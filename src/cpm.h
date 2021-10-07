#ifndef CPM_H
#define CPM_H

/* see main.c for definition */

#define JP		0xc3
#define CALL	0xcd
#define RET		0xc9
#define INa		0xdb	// Triggers a BIOS call
#define OUTa	0xd3	// Triggers a BDOS call

#ifdef PROFILE
unsigned long time_start = 0;
unsigned long time_now = 0;
#endif

static uint8 firstTime = TRUE;

#include "cios.h"

void _PatchCPM(void) {
	uint16 i;

	//**********  Patch CP/M page zero into the memory  **********
	/* BIOS entry point */
	_RamWrite(0x0000, JP);		/* JP BIOS+3 (warm boot) */
	_RamWrite16(0x0001, BIOSjmppage + 3);

	if (Status != WBOOT) {
		/* IOBYTE - Points to Console */
		_RamWrite(IOBYTE, 0b10000001);	// CON:=CRT: RDR:=TTY: PUN:=TTY: LST:=LPT:
		/* Current drive/user - A:/0 */
		_RamWrite(0x0004, 0x00);
	}

	/* BDOS entry point (0x0005) */
	_RamWrite(0x0005, JP);
	_RamWrite16(0x0006, BDOSjmppage + 0x06);

	if (firstTime) {

		// Initial MSPEED value - 9600
		_RamWrite(0x003C, 8);

		//**********  Patch CP/M Version into the memory so the CCP can see it
#ifdef USE_CIOS
		// patch in page relocated CIOS
		for (uint16 i=0; i<sizeof cios; ++i) {
			if (cios_prl[i>>3] & (1 << (i % 8))) {
				_RamWrite(BDOSjmppage + i, (cios[i] + (BDOSjmppage >> 8)));
			} else {
				_RamWrite(BDOSjmppage + i, cios[i]);
			}
		}
		setNovaDosFlags(PublicFlag | PubROFlag);
		setZsdosFlags(ZSDOSpublic);
#else
		// Patches in the BDOS jump destination
		_RamWrite(BDOSjmppage + 6, JP);
		_RamWrite16(BDOSjmppage + 7, BDOSpage);

		// Patches in the BDOS page content
		_RamWrite(BDOSpage, INa);
		_RamWrite(BDOSpage + 1, 0x00);
		_RamWrite(BDOSpage + 2, RET);
#endif

		// Patches in the BIOS jump destinations
		for (i = 0; i < (numBIOScalls * 3); i = i + 3) {
			_RamWrite(BIOSjmppage + i, JP);
			_RamWrite16(BIOSjmppage + i + 1, BIOSpage + i);
		}

		// Patches in the BIOS page content
		for (i = 0; i < (numBIOScalls * 3); i = i + 3) {
			_RamWrite(BIOSpage + i, OUTa);
			_RamWrite(BIOSpage + i + 1, i & 0xff);
			_RamWrite(BIOSpage + i + 2, RET);
		}

		//**********  Patch CP/M (fake) Disk Parameter Table after the BDOS call entry  **********
		i = DPBaddr;
		_RamWrite(i++, 64);  		/* spt - Sectors Per Track */
		_RamWrite(i++, 0);
		_RamWrite(i++, 5);   		/* bsh - Data allocation "Block Shift Factor" */
		_RamWrite(i++, 0x1F);		/* blm - Data allocation Block Mask */
		_RamWrite(i++, 1);   		/* exm - Extent Mask */
		_RamWrite(i++, 0xFF);		/* dsm - Total storage capacity of the disk drive */
		_RamWrite(i++, 0x07);
		_RamWrite(i++, 255); 		/* drm - Number of the last directory entry */
		_RamWrite(i++, 3);
		_RamWrite(i++, 0xFF);		/* al0 */
		_RamWrite(i++, 0x00);		/* al1 */
		_RamWrite(i++, 0);   		/* cks - Check area Size */
		_RamWrite(i++, 0);
		_RamWrite(i++, 0x02);		/* off - Number of system reserved tracks at the beginning of the ( logical ) disk */
		_RamWrite(i++, 0x00);
		blockShift = _RamRead(DPBaddr + 2);
		blockMask = _RamRead(DPBaddr + 3);
		extentMask = _RamRead(DPBaddr + 4);
		numAllocBlocks = _RamRead16((DPBaddr + 5)) + 1;
		extentsPerDirEntry = extentMask + 1;

		// figure out the number of the first allocation block
		// after the directory for the phoney allocation block
		// list in _findnext()
		firstBlockAfterDir = 0;
		i = 0x80;
		while (_RamRead(DPBaddr + 9) & i) {
			firstBlockAfterDir++;
			i >>= 1;
		}
		if (_RamRead(DPBaddr + 9) == 0xFF) {
			i = 0x80;
			while (_RamRead(DPBaddr + 10) & i) {
				firstBlockAfterDir++;
				i >>= 1;
			}
		}
		physicalExtentBytes = logicalExtentBytes * (extentMask + 1);

		// Patch CP/M (fake) Disk Parameter Header 
		i = DPHaddr;
		_RamWrite16(i, 0);
		++i; ++i;
		_RamWrite16(i, 0);
		++i; ++i;
		_RamWrite16(i, 0);
		++i; ++i;
		_RamWrite16(i, 0);
		++i; ++i;
		_RamWrite16(i, DirBufAddr);
		++i; ++i;
		_RamWrite16(i, DPBaddr);
		++i; ++i;
		_RamWrite16(i, 0);
		++i; ++i;
		_RamWrite16(i, SCBaddr);

		uint16 c;

		_RamWrite16(Z3CL,Z3CL+4);  // Point to the 1st char in cmd line buf
		_RamWrite(Z3CL+2,Z3CL_B);  // Command line buffer size

		char autocmd[] = "STARTUP ";// 8 bytes max
		_RamWrite(Z3CL+3,sizeof(autocmd));
		c = 0;
		i = Z3CL+4;						// move the automatic command to the
		while( autocmd[c] ) {		// ZCPR3 command line
			_RamWrite(i++,autocmd[c]);
			++c;
		}
		_RamWrite(i,0);

		i = EXPATH;						// Initial path description
		_RamWrite(i++, '$');			// current drive
		_RamWrite(i++, '$');			// current user
		_RamWrite(i++, 1);			// Drive A:, user 15
		_RamWrite(i++, 15);
		_RamWrite(i++, 0);			// end of path

		_RamWrite(Z3WHL, 0xFF);		// turn the wheel byte on

		i = Z3ENV;							// move environment and TCAP
		_RamWrite(i++, JP);				// 0xFE00 - leading JP
		_RamWrite16(i, (BIOSjmppage + 6)); i+=2;

		_RamWrite(i++, 'Z');				// 0xFE03 - environment ID
		_RamWrite(i++, '3');
		_RamWrite(i++, 'E');
		_RamWrite(i++, 'N');
		_RamWrite(i++, 'V');

		_RamWrite(i++, 0x80);			// 0xFE08 - extended environment

		_RamWrite16(i, EXPATH); i+=2;	// 0xFE09 - external path (PATH)
		_RamWrite(i++, EXPATH_S);

		_RamWrite16(i, RCP); i+=2;		// 0xFE0C - resident command package (RCP)
		_RamWrite(i++, RCP_S);

		_RamWrite16(i, IOP); i+=2;		// 0xFE0F - input/output package (IOP)
		_RamWrite(i++, IOP_S);

		_RamWrite16(i, FCP); i+=2;		// 0xFE12 - flow command package (FCP)
		_RamWrite(i++, FCP_S);

		_RamWrite16(i, Z3NDIR); i+=2;	// 0xFE15 - named directories (NDR)
		_RamWrite(i++, Z3NDIR_S);

		_RamWrite16(i, Z3CL); i+=2;	// 0xFE18 - command line (CL)
		_RamWrite(i++, Z3CL_B);

		_RamWrite16(i, Z3ENV); i+=2;	// 0xFE1B - environment (ENV)
		_RamWrite(i++, Z3ENV_S);

		_RamWrite16(i, SHSTK); i+=2;	// 0xFE1E - shell stack (SH)
		_RamWrite(i++, SHSTK_N);
		_RamWrite(i++, SHSTK_L);

		_RamWrite16(i, Z3MSG); i+=2;	// 0xFE22 - message buffer (MSG)
		_RamWrite16(i, EXTFCB); i+=2;	// 0xFE24 - external FCB (FCB)
		_RamWrite16(i, EXTSTK); i+=2;	// 0xFE26 - external stack (STK)
		_RamWrite(i++, 0);				// 0xFE28 - Quiet flag (1=quiet, 0=not quiet)
		_RamWrite16(i, Z3WHL); i+=2;	// 0xFE29 - Wheel byte (WHL)
		_RamWrite(i++, 143);				// 0xFE2B - Processor speed (Mhz)
		_RamWrite(i++, MAXDSK-'@');	// 0xFE2C - Max disk letter
		_RamWrite(i++, MAXUSR);			// 0xFE2D - Max user number
		_RamWrite(i++, 1);				// 0xFE2E - 1=ok to accept DU:, 0=not ok
		_RamWrite(i++, 0);				// 0xFE2F - CRT selection
		_RamWrite(i++, 0);				// 0xFE30 - Printer selection
		_RamWrite(i++, TERM_COLS);		// 0xFE31 - CRT 0: Width
		_RamWrite(i++, TERM_ROWS);		// 0xFE32 - # of lines
		_RamWrite(i++, TERM_ROWS - 2);// 0xFE33 - # of text lines
		_RamWrite16(i, 0x003F);			// 0xFE34 - valid drive vector (A-F)
		i += 2;
		_RamWrite(i++, 0);				//	0xFE36 - spare
		_RamWrite(i++, 80);				// 0xFE37 - PRT 0: Width
		_RamWrite(i++, 66);				// 0xFE38 - # of lines
		_RamWrite(i++, 58);				//	0xFE39 - # of text lines
		_RamWrite(i++, 1);				//	0xFE3A - FF flag (1=can form feed)
		_RamWrite(i++, 0);				// 0xFE3B - spare
		_RamWrite(i++, 0);				//	0xFE3C - spare
		_RamWrite(i++, 0);				//	0xFE3D - spare
		_RamWrite(i++, 0);				// 0xFE3E - spare
		_RamWrite16(i, CCPaddr);		// 0xFE3F - CCP address
		i += 2;
		_RamWrite(i++, 16);				// 0xFE41 - CCP size in records
		_RamWrite16(i, BDOSjmppage);	//	0xFE42 - BDOS address
		i += 2;
		_RamWrite(i++, 28);				//	0xFE44 - BDOS size in records
		_RamWrite16(i, BIOSjmppage);	//	0xFE45 - BIOS address
		i += 2;
		//							  12345678123
		char shellvar[]	 = "SH      VAR";
		char genericfile[] = "           ";
		c=0;
		while( shellvar[c] ) {			// 0xFE47
			_RamWrite(i++,shellvar[c]);
			++c;
		}
		for( int j=0; j<4; ++j ) {
			c=0;
			while( genericfile[c] ) {	// 0xFE52, 0xFE5D, 0xFE68, 0xFE73
				_RamWrite(i++,genericfile[c]);
				++c;
			}
		}
		_RamWrite(i++,0);				// 0xFE7E - Public drive (ZRDOS +)
		_RamWrite(i++,0x0F);		// 0xFE7F - Public user (ZRDOS +)
		//						 1234567890123
		char terminal[] = "DEC-VT100    ";
		c = 0;
		while( terminal[c] ) {
			_RamWrite(i++,terminal[c]);
			++c;
		}
		_RamWrite(i++, 0x56);			// graphics offset
		_RamWrite(i++, 0x80);			// config byte B14
		_RamWrite(i++, 0x10);			// config byte B15
		_RamWrite(i++, 'E'-'@');		// Cursor UP (Wordstar Defaults)
		_RamWrite(i++, 'X'-'@');		// Cursor DOWN
		_RamWrite(i++, 'D'-'@');		// Cursor RIGHT
		_RamWrite(i++, 'S'-'@');		// Cursor LEFT
		_RamWrite(i++, 50);				// CL Delay
		_RamWrite(i++, 5);				// CM Delay
		_RamWrite(i++, 3);				// CE Delay

		_RamWrite(i++, 0x1b);			// CL String
		_RamWrite(i++, '[');
		_RamWrite(i++, 'H');
		_RamWrite(i++, 0x1b);
		_RamWrite(i++, '[');
		_RamWrite(i++, 'J');
		_RamWrite(i++, 0);

		_RamWrite(i++, 0x1b);			// CM string
		_RamWrite(i++, '[');
		_RamWrite(i++, '%');
		_RamWrite(i++, 'i');
		_RamWrite(i++, '%');
		_RamWrite(i++, 'd');
		_RamWrite(i++, ';');
		_RamWrite(i++, '%');
		_RamWrite(i++, 'd');
		_RamWrite(i++, 'H');
		_RamWrite(i++, 0);

		_RamWrite(i++, 0x1b);			// CE string (clear to end of line)
		_RamWrite(i++, '[');
		_RamWrite(i++, 'K');
		_RamWrite(i++, 0);

		_RamWrite(i++, 0x1b);			// SO string (standout on)
		_RamWrite(i++, '[');
		_RamWrite(i++, '1');
		_RamWrite(i++, 'm');
		_RamWrite(i++, 0);

		_RamWrite(i++, 0x1b);			// SE string (standout off)
		_RamWrite(i++, '[');
		_RamWrite(i++, 'm');
		_RamWrite(i++, 0);

		_RamWrite(i++, 0);				// TI string (terminal init)

		_RamWrite(i++, 0);				// TE string; (terminal deinit);
//
// Extensions to standard Z3TCAP
//
		_RamWrite(i++, 0x1b);			// DL line delete
		_RamWrite(i++, '[');
		_RamWrite(i++, 'M');
		_RamWrite(i++, 0);

		_RamWrite(i++, 0x1b);			// IL line insert
		_RamWrite(i++, '[');
		_RamWrite(i++, 'L');
		_RamWrite(i++, 0);

		_RamWrite(i++, 0x1b);			// CD clear to end of screen
		_RamWrite(i++, '[');
		_RamWrite(i++, 'J');
		_RamWrite(i++, 0);
//
// The attribute string contains the four command characters to set
// the following four attributes for this terminal in the following
// order:  	Normal, Blink, Reverse, Underscore
//
		_RamWrite(i++, 0x1b);
		_RamWrite(i++, '[');
		_RamWrite(i++, '%');
		_RamWrite(i++, '+');
		_RamWrite(i++, '0');
		_RamWrite(i++, 'm');
		_RamWrite(i++, 0);
//
// attribute string
//
		_RamWrite(i++, '0');
		_RamWrite(i++, '5');
		_RamWrite(i++, '7');
		_RamWrite(i++, '4');
		_RamWrite(i++, 0);

		_RamWrite(i++, 0x1b);			// Read current cursor position
		_RamWrite(i++, '[');
		_RamWrite(i++, '6');
		_RamWrite(i++, 'n');
		_RamWrite(i++, 0);

		_RamWrite(i++, 0);				// Read line until cursor
//
// Graphics TCAP area
//
		_RamWrite(i++, 0);				// GOELD graphics on/off delay

		_RamWrite(i++, '\x0e');			// GO graphics on
		_RamWrite(i++, 0);

		_RamWrite(i++, '\x0f');			// GE graphics off
		_RamWrite(i++, 0);

		_RamWrite(i++, 0x1b);			// CDO cursor off
		_RamWrite(i++, '[');
		_RamWrite(i++, '?');
		_RamWrite(i++, '2');
		_RamWrite(i++, '5');
		_RamWrite(i++, 'l');
		_RamWrite(i++, 0);

		_RamWrite(i++, 0x1b);			// CDE cursor on
		_RamWrite(i++, '[');
		_RamWrite(i++, '?');
		_RamWrite(i++, '2');
		_RamWrite(i++, '5');
		_RamWrite(i++, 'h');
		_RamWrite(i++, 0);
//
// Graphics characters
//
		_RamWrite(i++, 0xDA);			// GULC upper left corner
		_RamWrite(i++, 0xBF);			// GURC upper right corner
		_RamWrite(i++, 0xC0);			// GLLC lower left corner
		_RamWrite(i++, 0xD9);			// GLrC lower right corner
		_RamWrite(i++, 0xC4);			// GHL horizontal line
		_RamWrite(i++, 0xB3);			// GVL vertical line
		_RamWrite(i++, 0xDB);			// GFB full block
		_RamWrite(i++, 0xB1);			// GHB hashed block
		_RamWrite(i++, 0xC2);			// GUI upper intersection
		_RamWrite(i++, 0xC1);			// GLI lower intersection
		_RamWrite(i++, 0xC5);			// GIS intersection
		_RamWrite(i++, 0xB4);			// GRTI right intersection
		_RamWrite(i++, 0xC3);			// GLTI left intersection
		_RamWrite(i++, 0);

		firstTime = FALSE;
	} else {
		_RamWrite(BDOSjmppage + 0, 'Z');
		_RamWrite(BDOSjmppage + 1, 'S');
		_RamWrite(BDOSjmppage + 2, 'D');
		_RamWrite(BDOSjmppage + 3, 'O');
		_RamWrite(BDOSjmppage + 4, 'S');
		_RamWrite(BDOSjmppage + 5, ' ');
	}
}

#ifdef DEBUGLOG
uint8 LogBuffer[128];

void _logRegs(void) {
	uint8 J, I;
	uint8 Flags[9] = { 'S','Z','5','H','3','P','N','C' };
	uint8 c = HIGH_REGISTER(AF);
	if (c < 32 || c > 126)
		c = 46;
	for (J = 0, I = LOW_REGISTER(AF); J < 8; ++J, I <<= 1) Flags[J] = I & 0x80 ? Flags[J] : '.';
	sprintf((char*)LogBuffer, "  BC:%04x DE:%04x HL:%04x AF:%02x(%c)|%s| IX:%04x IY:%04x SP:%04x PC:%04x\n",
		WORD16(BC), WORD16(DE), WORD16(HL), HIGH_REGISTER(AF), c, Flags, WORD16(IX), WORD16(IY), WORD16(SP), WORD16(PC)); _sys_logbuffer(LogBuffer);
}

void _logMem(uint16 address, uint8 amount)	// Amount = number of 16 bytes lines, so 1 CP/M block = 8, not 128
{
	uint8 i, m, c, pos;
	uint8 head = 8;
	uint8 hexa[] = "0123456789ABCDEF";
	for (i = 0; i < amount; ++i) {
		pos = 0;
		for (m = 0; m < head; ++m)
			LogBuffer[pos++] = ' ';
		sprintf((char*)LogBuffer, "  %04x: ", address);
		for (m = 0; m < 16; ++m) {
			c = _RamRead(address++);
			LogBuffer[pos++] = hexa[c >> 4];
			LogBuffer[pos++] = hexa[c & 0x0f];
			LogBuffer[pos++] = ' ';
			LogBuffer[m + head + 48] = c > 31 && c < 127 ? c : '.';
		}
		pos += 16;
		LogBuffer[pos++] = 0x0a;
		LogBuffer[pos++] = 0x00;
		_sys_logbuffer(LogBuffer);
	}
}

void _logChar(char* txt, uint8 c) {
	uint8 asc[2];

	asc[0] = c > 31 && c < 127 ? c : '.';
	asc[1] = 0;
	sprintf((char*)LogBuffer, "        %s = %02xh:%3d (%s)\n", txt, c, c, asc);
	_sys_logbuffer(LogBuffer);
}

void _logBiosIn(uint8 ch) {
	static const char* BIOSCalls[18] =
	{
		"boot", "wboot", "const", "conin", "conout", "list", "punch/aux", "reader", "home", "seldsk", "settrk", "setsec", "setdma",
		"read", "write", "listst", "sectran", "altwboot"
	};
	int index = ch / 3;
	if (index < 18) {
		sprintf((char*)LogBuffer, "\nBios call: %3d/%02xh (%s) IN:\n", ch, ch, BIOSCalls[index]); _sys_logbuffer(LogBuffer);
	} else {
		sprintf((char*)LogBuffer, "\nBios call: %3d/%02xh IN:\n", ch, ch); _sys_logbuffer(LogBuffer);
	}

	_logRegs();
}

void _logBiosOut(uint8 ch) {
	sprintf((char*)LogBuffer, "               OUT:\n"); _sys_logbuffer(LogBuffer);
	_logRegs();
}

void _logBdosIn(uint8 ch) {
	uint16 address = 0;
	uint8 size = 0;

	static const char* CPMCalls[41] =
	{
		"System Reset", "Console Input", "Console Output", "Reader Input", "Punch Output", "List Output", "Direct I/O", "Get IOByte",
		"Set IOByte", "Print String", "Read Buffered", "Console Status", "Get Version", "Reset Disk", "Select Disk", "Open File",
		"Close File", "Search First", "Search Next", "Delete File", "Read Sequential", "Write Sequential", "Make File", "Rename File",
		"Get Login Vector", "Get Current Disk", "Set DMA Address", "Get Alloc", "Write Protect Disk", "Get R/O Vector", "Set File Attr", "Get Disk Params",
		"Get/Set User", "Read Random", "Write Random", "Get File Size", "Set Random Record", "Reset Drive", "N/A", "N/A", "Write Random 0 fill"
	};

	if (ch < 41) {
		sprintf((char*)LogBuffer, "\nBdos call: %3d/%02xh (%s) IN from 0x%04x:\n", ch, ch, CPMCalls[ch], _RamRead16(SP) - 3); _sys_logbuffer(LogBuffer);
	} else {
		sprintf((char*)LogBuffer, "\nBdos call: %3d/%02xh IN from 0x%04x:\n", ch, ch, _RamRead16(SP) - 3); _sys_logbuffer(LogBuffer);
	}
	_logRegs();
	switch (ch) {
	case 2:
	case 4:
	case 5:
	case 6:
		_logChar("E", LOW_REGISTER(DE)); break;
	case 9:
	case 10:
		address = DE; size = 8; break;
	case 15:
	case 16:
	case 17:
	case 18:
	case 19:
	case 22:
	case 23:
	case 30:
	case 35:
	case 36:
		address = DE; size = 3; break;
	case 20:
	case 21:
	case 33:
	case 34:
	case 40:
		address = DE; size = 3; _logMem(address, size);
		sprintf((char*)LogBuffer, "\n");  _sys_logbuffer(LogBuffer);
		address = dmaAddr; size = 8; break;
	default:
		break;
	}
	if (size)
		_logMem(address, size);
}

void _logBdosOut(uint8 ch) {
	uint16 address = 0;
	uint8 size = 0;

	sprintf((char*)LogBuffer, "              OUT:\n"); _sys_logbuffer(LogBuffer);
	_logRegs();
	switch (ch) {
	case 1:
	case 3:
	case 6:
		_logChar("A", HIGH_REGISTER(AF)); break;
	case 10:
		address = DE; size = 8; break;
	case 20:
	case 21:
	case 33:
	case 34:
	case 40:
		address = DE; size = 3; _logMem(address, size);
		sprintf((char*)LogBuffer, "\n");  _sys_logbuffer(LogBuffer);
		address = dmaAddr; size = 8; break;
	case 26:
		address = dmaAddr; size = 8; break;
	case 35:
	case 36:
		address = DE; size = 3; break;
	default:
		break;
	}
	if (size)
		_logMem(address, size);
}
#endif

void _Bios(void) {
	uint8 ch = LOW_REGISTER(PCX);
	uint8 c;

#ifdef DEBUGLOG
#ifdef LOGONLY
	if (ch == LOGONLY)
#endif
		_logBiosIn(ch);
#endif

	switch (ch) {
	case 0x00:
		Status = CBOOT;		// 0 - BOOT - Ends RunCPM
		break;
	case 0x03:
		Status = WBOOT;		// 1 - WBOOT - Back to CCP
		break;
	case 0x06:					// 2 - CONST - Console status
		SET_HIGH_REGISTER(AF, _conist());
		break;
	case 0x09:					// 3 - CONIN - Console input
		SET_HIGH_REGISTER(AF, _getcon());
#ifdef DEBUG
		if (HIGH_REGISTER(AF) == 4)
			Debug = 1;
#endif
		break;
	case 0x0C:					// 4 - CONOUT - Console output
		c = LOW_REGISTER(BC);
		if (!(getNovaDosFlags() & HiOutFlag)) {
			c &= 0x7F;
		}
		_putcon(c);
		break;
	case 0x0F:					// 5 - LIST - List output
		_putlst(LOW_REGISTER(BC));
		break;
	case 0x12:					// 6 - PUNCH/AUXOUT - Punch output
		_putpun(LOW_REGISTER(BC));
		break;
	case 0x15:					// 7 - READER - Reader input
		SET_HIGH_REGISTER(AF, _getrdr());
		break;
	case 0x18:					// 8 - HOME - Home disk head
		break;
	case 0x1B:					// 9 - SELDSK - Select disk drive
		if (LOW_REGISTER(BC) <= (MAXDSK-'A')) {
			HL = DPHaddr;
		} else {
			HL = 0x0000;
		}
		break;
	case 0x1E:					// 10 - SETTRK - Set track number
		TERMINALPORT.print("BIOS - SETTRK - "); TERMINALPORT.println(LOW_REGISTER(BC));
		break;
	case 0x21:					// 11 - SETSEC - Set sector number
		TERMINALPORT.print("BIOS - SETSEC - "); TERMINALPORT.println(LOW_REGISTER(BC));
		break;
	case 0x24:					// 12 - SETDMA - Set DMA address
		HL = BC;
		dmaAddr = BC;
		break;
	case 0x27:					// 13 - READ - Read selected sector
		TERMINALPORT.println("BIOS - READ");
		SET_HIGH_REGISTER(AF, 0x00);
		break;
	case 0x2A:					// 14 - WRITE - Write selected sector
		TERMINALPORT.println("BIOS - WRITE");
		SET_HIGH_REGISTER(AF, 0x00);
		break;
	case 0x2D:					// 15 - LISTST - Get list device status
		SET_HIGH_REGISTER(AF, _lstst());
		break;
	case 0x30:					// 16 - SECTRAN - Sector translate
		HL = BC;					// HL=BC=No translation (1:1)
		break;
	case 0x33:					// 17 - RETTOCCP - This allows programs ending in RET return to internal CCP
		Status = RETCCP;
		break;
	case 0x36:					// 18 - MODEMINIT - serial port configuration
		_modeminit(BC);
		break;
	case 0x39:					// 19 - RDRIST - RDR: input status
		HL = _rdrist();
		break;
	case 0x3C:					// 20 - PUNOST - PUN: output status:
		HL = _punost();
		break;
	case 0x3F:					// 21 - CONPEEK - console input peek
		SET_HIGH_REGISTER(AF, _peekcon());
		break;
	case 0x42:					// 22 - DELAY
		_delay(BC);
		break;
	default:
#ifdef DEBUG	// Show unimplemented BIOS calls only when debugging
		_puts("\r\nUnimplemented BIOS call.\r\n");
		_puts("C = 0x");
		_puthex8(ch);
		_puts("\r\n");
#endif
		break;
	}
#ifdef DEBUGLOG
#ifdef LOGONLY
	if (ch == LOGONLY)
#endif
		_logBiosOut(ch);
#endif

}

void _Bdos(void) {

	bdosFunc = LOW_REGISTER(BC);

#ifdef DEBUGLOG
#ifdef LOGONLY
	if (bdosFunc == LOGONLY)
#endif
		_logBdosIn(bdosFunc);
#endif

	HL = 0x0000;	// HL is reset by the BDOS
	SET_LOW_REGISTER(BC, LOW_REGISTER(DE)); // C ends up equal to E

	switch (bdosFunc) {

		case 0:
			//
			// C = 0 : System reset
			// Doesn't return. Reloads CP/M
			//
			TERMINALPORT.println("BDOS - WBOOT");
			Status = CBOOT;	// Same as call to "BOOT"
			break;

		case 1:
			//
			// C = 1 : Console input
			// Gets a char from the console
			// Returns: A=Char
			//
			TERMINALPORT.println("BDOS - CONIN");
			Status = CBOOT;	// Same as call to "BOOT"
			break;

		case 2:
			//
			// C = 2 : Console output
			// E = Char
			// Sends the char in E to the console
			//
			TERMINALPORT.println("BDOS - CONOUT");
			Status = CBOOT;	// Same as call to "BOOT"
			break;

		case 3:
			//
			// C = 3 : Auxiliary (Reader) input
			// Returns: A=Char
			//
			HL = _getrdr();
			break;

		case 4:
			//
			// C = 4 : Auxiliary (Punch) output
			//
			_putpun(LOW_REGISTER(DE));
			break;

		case 5:
			//
			// C = 5 : Printer output
			//
			_putlst(LOW_REGISTER(DE));
			break;

		case 6:
			//
			// C = 6 : Direct console IO
			// E = 0xFF : Checks for char available and returns it, or 0x00 if none (read)
			// E = 0xFE : Checks for char available and returns 0xFF if available, or 0x00 if none
			// E = char : Outputs char (write)
			// Returns: A=Char or 0x00 (on read)
			//
			TERMINALPORT.println("BDOS - DCONIO");
			Status = CBOOT;	// Same as call to "BOOT"
			break;

		case 7:
			//
			// C = 7 : Get IOBYTE
			// Gets the system IOBYTE
			// Returns: A = IOBYTE
			//
			HL = _RamRead(IOBYTE);
			break;

		case 8:
			//
			// C = 8 : Set IOBYTE
			// E = IOBYTE
			// Sets the system IOBYTE to E
			//
			_RamWrite(IOBYTE, LOW_REGISTER(DE));
			break;

		case 9:
			//
			// C = 9 : Output string
			// DE = Address of string
			// Sends the $ terminated string pointed by (DE) to the screen
			//
			TERMINALPORT.println("BDOS - STROUT");
			Status = CBOOT;	// Same as call to "BOOT"
			break;

		case 10:
			//
			// C = 10 (0Ah) : Buffered input
			// DE = Address of buffer
			// Reads (DE) bytes from the console
			// Returns: A = Number os chars read
			//          DE = First char
			//
			TERMINALPORT.println("BDOS - RDBUFF");
			Status = CBOOT;	// Same as call to "BOOT"
			break;

		case 11:
			//
			// C = 11 (0Bh) : Get console status
			// Returns: A=0x00 or 0xFF
			//
			TERMINALPORT.println("BDOS - CONST");
			Status = CBOOT;	// Same as call to "BOOT"
			break;

		case 12:
			//
			// C = 12 (0Ch) : Get version number
			// Returns: B=H=system type, A=L=version number
			//
			HL = 0x22;
			break;

		case 13:
			//
			// C = 13 (0Dh) : Reset disk system
			//
			roVector = 0;		// Make all drives R/W
			loginVector = 0;
			dmaAddr = 0x0080;
			cDrive = 0;			// userCode remains unchanged
			HL = _CheckSUB();	// Checks if there's a $$$.SUB on the boot disk
			break;

		case 14:
			//
			// C = 14 (0Eh) : Select Disk
			// Returns: A=0x00 or 0xFF
			//
			oDrive = cDrive;
			cDrive = LOW_REGISTER(DE);
			HL = _SelectDisk(LOW_REGISTER(DE) + 1, 0);	// +1 here is to allow SelectDisk to be used directly by disk.h as well
			if (!HL) {
				oDrive = cDrive;
			}
			break;

		case 15:
			//
			// C = 15 (0Fh) : Open file
			// Returns: A=0x00 or 0xFF
			//
			HL = _OpenFile(DE);
			break;

		case 16:
			//
			// C = 16 (10h) : Close file
			//
			HL = _CloseFile(DE);
			break;

		case 17:
			//
			// C = 17 (11h) : Search for first
			//
			HL = _SearchFirst(DE, TRUE);	// TRUE = Creates a fake dir entry when finding the file
			break;

		case 18:
			//
			// C = 18 (12h) : Search for next
			//
			HL = _SearchNext(DE, TRUE);		// TRUE = Creates a fake dir entry when finding the file
			break;

		case 19:
			//
			// C = 19 (13h) : Delete file
			//
			HL = _DeleteFile(DE);
			break;

		case 20:
			//
			// C = 20 (14h) : Read sequential
			//
			HL = _ReadSeq(DE);
			break;

		case 21:
			//
			// C = 21 (15h) : Write sequential
			//
			HL = _WriteSeq(DE);
			break;

		case 22:
			//
			// C = 22 (16h) : Make file
			//
			HL = _MakeFile(DE);
			break;

		case 23:
			//
			// C = 23 (17h) : Rename file
			//
			HL = _RenameFile(DE);
			break;

		case 24:
			//
			// C = 24 (18h) : Return log-in vector (active drive map)
			//
			HL = loginVector;	// (todo) improve this
			break;

		case 25:
			//
			//C = 25 (19h) : Return current disk
			//
			HL = cDrive;
			break;

		case 26:
			//
			// C = 26 (1Ah) : Set DMA address
			//
			dmaAddr = DE;
			break;

		case 27:
			//
			// C = 27 (1Bh) : Get ADDR(Alloc)
			//
			HL = SCBaddr;
			break;

		case 28:
			//
			// C = 28 (1Ch) : Write protect disks
			//
			roVector = DE;
			HL = 0;
			break;

		case 29:
			//
			// C = 29 (1Dh) : Get R/O vector
			//
			HL = roVector;
			break;

		case 30:
			//
			// C = 30 (1Eh) : Set file attributes
			//
			HL = _SetFileAttributes(DE);
			break;

		case 31:
			//
			// C = 31 (1Fh) : Get ADDR(Disk Parms)
			//
			HL = DPBaddr;
			break;

		case 32:
			//
			// C = 32 (20h) : Get/Set user code
			//
			if (LOW_REGISTER(DE) == 0xFF) {
				HL = userCode;
			} else {
				_SetUser(DE);
			}
			break;

		case 33:
			//
			// C = 33 (21h) : Read random
			//
			HL = _ReadRand(DE);
			break;

		case 34:
			//
			// C = 34 (22h) : Write random
			//
			HL = _WriteRand(DE);
			break;

		case 35:
			//
			// C = 35 (23h) : Compute file size
			//
			HL = _GetFileSize(DE);
			break;

		case 36:
			//
			// C = 36 (24h) : Set random record
			//
			HL = _SetRandom(DE);
			break;

		case 37:
			//
			// C = 37 (25h) : Reset drives
			// IN: DE = drive map vector
			//
			break;

		case 39:
			//
			// C = 39 (27h) : Return fixed media vector
			//
			HL = (1<<(MAXDSK-'@'))-1;
			break;

		case 40:
			//
			// C = 40 (28h) : Write random with zero fill (we have no disk blocks, so just write random)
			//
			HL = _WriteRand(DE);
			break;

		case 41:		// NovaDOS
			//
			// C = 41 (29h) : Get/Set/Reset NovaDOS flags
			//
			if (!LOW_REGISTER(DE)) {					// E=0 means return flags
				HL = getNovaDosFlags();
			} else if (LOW_REGISTER(DE) & 0x80) {	// set indicated flags
				uint8 flags = LOW_REGISTER(DE);
				for (uint8 i = 0x01; i < 0x80 ; i <<= 1 ) {
					if (flags & i) {
						setNovaDosFlags(getNovaDosFlags() | i);
					}
				}
				if (getNovaDosFlags() & PublicFlag) {
					setZsdosFlags(getZsdosFlags() | ZSDOSpublic);
				} else {
					setZsdosFlags(getZsdosFlags() & ~ZSDOSpublic);
				}
				if (getNovaDosFlags() & PubROFlag) {
					setZsdosFlags(getZsdosFlags() & ~ZSDOSpublicRW);
				} else {
					setZsdosFlags(getZsdosFlags() | ZSDOSpublicRW);
				}
			} else {											// reset indicated flags
				uint8 flags = LOW_REGISTER(DE);
				for (uint8 i = 0x01; i < 0x80 ; i <<= 1 ) {
					if (flags & i) {
						setNovaDosFlags(getNovaDosFlags() & ~i);
					}
				}
				if (getNovaDosFlags() & PublicFlag) {
					setZsdosFlags(getZsdosFlags() | ZSDOSpublic);
				} else {
					setZsdosFlags(getZsdosFlags() & ~ZSDOSpublic);
				}
				if (getNovaDosFlags() & PubROFlag) {
					setZsdosFlags(getZsdosFlags() & ~ZSDOSpublicRW);
				} else {
					setZsdosFlags(getZsdosFlags() | ZSDOSpublicRW);
				}
			}
			break;

		case 45:
			//
			// C = 45 (2Dh):  Set ZSDOS error mode
			//
			setZsdosErrorMode(LOW_REGISTER(DE));
			HL = 0;
			break;

		case 47:		// NovaDOS, ZRDOS, ZSDOS
			//
			// C = 47 (2Fh):  Return Current DMA Address
			//
			HL = dmaAddr;
			break;

		case 48:		// ZSDOS
			//
			// C = 48 (30h) : identify as ZSDOS
			//
			HL = 'S' << 8 | 0x11;
			break;

		case 54:		// NovaDOS, Z80DOS
			//
			// C = 54 : Get file timestamps
			// OUT: HL = address of timestamp from the last file used by 
			// functions 15 (open file), 17 (find first) or 18 (find next).
			//
			// The format of a NovaDOS timestamp is:
			//
			// DW  creation date
			// DB  creation time, hours,	BCD
			// DB  creation time, minutes, BCD
			// DW  modification date
			// DB  modification time, hours,	BCD
			// DB  modification time, minutes, BCD
			//
			HL = _getZrDosFileTimeStamp();
			break;

		case 98:
			//
			// C = 98: ZSDOS get system date/time
			// IN: DE = address to return system date/time
			//
			HL = _getZsDosTime(DE);
			break;

		case 99:
			//
			// C = 99: ZSDOS get system date/time
			// IN: DE = address of newsystem date/time
			//
			HL = _setZsDosTime(DE);
			break;

		case 100:
			//
			// C = 100: get ZSDOS flags
			// OUT HL=flags
			//
			HL = getZsdosFlags();
			break;

		case 101:
			//
			// C = 101: set ZSDOS flags
			// IN DE=flags
			//
			setZsdosFlags(LOW_REGISTER(DE));
			if( getZsdosFlags() & ZSDOSpublic ) {
				setNovaDosFlags( getNovaDosFlags() | PublicFlag );
			} else {
				setNovaDosFlags( getNovaDosFlags() & ~PublicFlag );
			}
			if( getZsdosFlags() & ZSDOSpublicRW ) {
				setNovaDosFlags( getNovaDosFlags() & ~PubROFlag );
			} else {
				setNovaDosFlags( getNovaDosFlags() | PubROFlag );
			}
			break;

		case 102:
			//
			// C = 102:  get file stamp
			// IN DE=FCB
			// OUT: A=time/date code
			//     DMA=file stamp
			//
			HL = _getZsDosFileTimeStamp(DE);
			break;

		case 103:
			//
			// C = 103:  set file stamp
			// IN: DE=FCB
			//    DMA=file stamp
			// OUT:
			//   A=time/date code
			//
			HL = _setZsDosFileTimeStamp(DE);
			break;

		case 105:	// Z80DOS
		case 200:	// NovaDOS
			//
			// C = 105, 200 (69h, C8h) : GetTime
			// IN: DE = address to receive time block (5 bytes)
			// OUT: A = seconds (emulating MP/M II)
			//
			_getZrDosTime(DE);
			HL = _RamRead(DE+4);
			break;

		case 104:	// Z80DOS
		case 201:	// NovaDOS
			//
			// C = 104, 201 (68h, C9h) : SetTime
			// IN: DE = address to time block to set time to (5 bytes)
			//
			_setZrDosTime(DE);
			HL = 0;
			break;

#ifdef USE_GSX
		case 115:	// GSX
			//
			// C = 115 (73h) : GSX
			// IN: DE = parameter block address
			//
			// DEFW	CONTRL	;Address of control array
			// DEFW	INTIN		;Address of integer input array
			// DEFW	PTSIN		;Address of pixel input array
			// DEFW	INTOUT	;Address of integer output array
			// DEFW	PTSOUT	;Address of pixel output array
			//
			HL = _gdos(DE);
			break;
#endif

			//
			// C = 141 : Delay
			// IN: DE = # of milliseconds to pause. Originally was # of
			//			system clock ticks but ms are of more use to me.
			//
		case 141:	// MP/M, Concurrent CP/M, CP/M-86 v4
			_delay(DE);
			break;

		case 165:
			//
			// C = 165 : get millis
			// OUT: HL = address of 4 byte millis counter
			//
			HL = _millis();
			break;

#if defined ARDUINO || defined CORE_TEENSY || defined ESP32
		case 220:
			//
			// C = 220 (DCh) : PinMode
			//
			pinMode(HIGH_REGISTER(DE), LOW_REGISTER(DE));
			break;

		case 221:
			//
			// C = 221 (DDh) : DigitalRead
			//
			HL = digitalRead(HIGH_REGISTER(DE));
			break;

		case 222:
			//
			// C = 222 (DEh) : DigitalWrite
			//
			digitalWrite(HIGH_REGISTER(DE), LOW_REGISTER(DE));
			break;

		case 223:
			//
			// C = 223 (DFh) : AnalogRead
			//
			HL = analogRead(HIGH_REGISTER(DE));
			break;

#ifndef ESP32
		case 224:
			//
			// C = 224 (E0h) : AnalogWrite
			//
			analogWrite(HIGH_REGISTER(DE), LOW_REGISTER(DE));
			break;
#endif

#endif
		case 230:
			//
			// C = 230 (E6h) : Set 8 bit masking
			//
			if (LOW_REGISTER(DE) == 0xFF) {
				// allow 8 bit output and lock it
				setNovaDosFlags(getNovaDosFlags() | HiOutFlag | LockFlag);
			} else {
				// allow 7 bit output and unlock it
				setNovaDosFlags(getNovaDosFlags() & ~HiOutFlag & ~LockFlag);
			}
			break;

		case 231:
			//
			// C = 231 (E7h) : Host specific BDOS call
			//
			HL = hostbdos(DE);
			break;

		case 249:
			//
			// C = 249 (F9h) : MakeDisk
			// Makes a disk directory if it doesn't already exist
			//
			HL = _MakeDisk(DE);
			break;

		case 250:
			//
			// C = 250 (FAh) : HostOS
			// Returns: A = 0x00 - Windows / 0x01 - Arduino / 0x02 - Posix / 0x03 - Dos / 0x04 - Teensy / 0x05 - ESP32 / 0x06 - STM32
			//
			HL = HostOS;
			break;

		case 251:
			//
			// C = 251 (FBh) : Version
			// Returns: A = 0xVv - Version in BCD representation: V.v
			//
			HL = VersionBCD;
			break;

		case 252:
			//
			// C = 252 (FCh) : CCP version
			// Returns: A = 0x00-0x05 = DRI|CCPZ|ZCPR2|ZCPR3|Z80CCP|ZCPR33 / 0xVv = Internal version in BCD: V.v
			//
			HL = VersionCCP;
			break;

		case 253:
			//
			// C = 253 (FDh) : CCP address
			//
			HL = CCPaddr;
			break;
			
		case 254:
			//
			// C = 254 (FEh): Reboot
			SCB_AIRCR = 0x05FA0004;
			break;

		default:
			//
			// Unimplemented calls get listed when debugging
			//
#ifdef DEBUG
			_puts("\r\nUnimplemented BDOS call.\r\n");
			_puts("C = 0x");
			_puthex8(bdosFunc);
			_puts("\r\n");
#endif
			break;
	}
	bdosFunc = 0;

	// CP/M BDOS does this before returning
	SET_HIGH_REGISTER(BC, HIGH_REGISTER(HL));
	SET_HIGH_REGISTER(AF, LOW_REGISTER(HL));

#ifdef DEBUGLOG
#ifdef LOGONLY
	if (ch == LOGONLY)
#endif
		_logBdosOut(ch);
#endif

}

#endif
