#ifndef ABSTRACT_H
#define ABSTRACT_H

#include <TimeLib.h>

#ifdef PROFILE
#define printf(a, b) TERMINALPORT.println(b)
#endif

#define HostOS 0x04

/* Memory abstraction functions */
/*===============================================================================*/
bool _RamLoad(char* filename, uint16 address) {
	File f;
	bool result = false;

	if (f = SD.open(filename, FILE_READ)) {
		while (f.available())
			_RamWrite(address++, f.read());
		f.close();
		result = true;
	}
	return(result);
}

/* Filesystem (disk) abstraction fuctions */
/*===============================================================================*/
File rootdir, userdir;
#define FOLDERCHAR '/'

typedef struct {
	uint8 dr;
	uint8 fn[8];
	uint8 tp[3];
	uint8 ex, s1, s2, rc;
	uint8 al[16];
	uint8 cr, r0, r1, r2;
} CPM_FCB;

typedef struct {
	uint8 dr;
	uint8 fn[8];
	uint8 tp[3];
	uint8 ex, s1, s2, rc;
	uint8 al[16];
} CPM_DIRENTRY;

static DirFat_t	fileDirEntry;

File _sys_fopen_w(uint8* filename) {
	return(SD.open((char*)filename, O_CREAT | O_WRITE));
}

int _sys_fputc(uint8 ch, File& f) {
	return(f.write(ch));
}

void _sys_fflush(File& f) {
	f.flush();
}

void _sys_fclose(File& f) {
	f.close();
}

int _sys_select(uint8* disk) {
	uint8 result = FALSE;
	File f;

	digitalWrite(LED, HIGH ^ LEDinv);
	if (f = SD.open((char*)disk, O_READ)) {
		if (f.isDirectory())
			result = TRUE;
		f.close();
	}
	digitalWrite(LED, LOW ^ LEDinv);
	return(result);
}

uint16 _sys_setfileattributes(uint8* filename, uint16 fcbaddr) {
	CPM_FCB *F = (CPM_FCB*)_RamSysAddr(fcbaddr);
	uint16 result = 0xFF;
	File f;

	digitalWrite(LED, HIGH ^ LEDinv);
	if ((f = SD.open((char*)filename, O_RDONLY))) {
		f.makeHidden(F->fn[1] & 0x80);
		f.makeReadOnly(F->tp[0] & 0x80);
		f.makeSystem(F->tp[1] & 0x80);
		f.makeArchive(F->tp[2] & 0x80);
		f.close();
		result = 0x00;
	}
	digitalWrite(LED, LOW ^ LEDinv);
	return result;

}

uint8 bin2bcd(uint8 bin) {
	return (bin / 10) * 16 + (bin % 10);
}

uint8 bcd2bin(uint8 bcd) {
	return (bcd / 16) * 10 + (bcd % 16);
}

uint16 bytes2uint16(uint8* bytes) {
	return bytes[0] | (bytes[1] << 8);
}
uint16 _sys_getfiletimestamp(uint8* filename) {
	uint16 result = 0xFF;
	File f;
	uint16 dt;
	
	digitalWrite(LED, HIGH ^ LEDinv);
	f = SD.open((char*)filename, O_READ);
	if (f) {
		f.dirEntry(&fileDirEntry);
		f.close();

		dt = bytes2uint16(fileDirEntry.createDate);
		_RamWrite(dmaAddr +  0, bin2bcd(FS_YEAR(dt) % 100));
		_RamWrite(dmaAddr +  1, bin2bcd(FS_MONTH(dt)));
		_RamWrite(dmaAddr +  2, bin2bcd(FS_DAY(dt)));
		dt = bytes2uint16(fileDirEntry.createTime);
		_RamWrite(dmaAddr +  3, bin2bcd(FS_HOUR(dt)));
		_RamWrite(dmaAddr +  4, bin2bcd(FS_MINUTE(dt)));

		dt = bytes2uint16(fileDirEntry.accessDate);
		_RamWrite(dmaAddr +  5, bin2bcd(FS_YEAR(dt) % 100));
		_RamWrite(dmaAddr +  6, bin2bcd(FS_MONTH(dt)));
		_RamWrite(dmaAddr +  7, bin2bcd(FS_DAY(dt)));
		_RamWrite(dmaAddr +  8, 0);	// no last access time, only date
		_RamWrite(dmaAddr +  9, 0);

		dt = bytes2uint16(fileDirEntry.modifyDate);
		_RamWrite(dmaAddr + 10, bin2bcd(FS_YEAR(dt) % 100));
		_RamWrite(dmaAddr + 11, bin2bcd(FS_MONTH(dt)));
		_RamWrite(dmaAddr + 12, bin2bcd(FS_DAY(dt)));
		dt = bytes2uint16(fileDirEntry.modifyTime);
		_RamWrite(dmaAddr + 13, bin2bcd(FS_HOUR(dt)));
		_RamWrite(dmaAddr + 14, bin2bcd(FS_MINUTE(dt)));

		result = 1;
	}
	digitalWrite(LED, LOW ^ LEDinv);
	return result;
}

uint16 _sys_setfiletimetamp(uint8* filename) {
	uint16 result = 0xFF;
	File f;

	digitalWrite(LED, HIGH ^ LEDinv);
	if ((f = SD.open((char*)filename, O_RDONLY))) {
		uint16 year;
		uint8 month, day, hour, minute;
		year = bcd2bin(_RamRead(dmaAddr + 0));
		if (year>77) {
			year += 1900;
		} else {
			year += 2000;
		}
		month = bcd2bin(_RamRead(dmaAddr + 1));
		day = bcd2bin(_RamRead(dmaAddr + 2));
		hour = bcd2bin(_RamRead(dmaAddr + 3));
		minute = bcd2bin(_RamRead(dmaAddr + 4));
		f.timestamp(T_CREATE, year, month, day, hour, minute, 0);

		year = bcd2bin(_RamRead(dmaAddr + 5));
		if (year>77) {
			year += 1900;
		} else {
			year += 2000;
		}
		month = bcd2bin(_RamRead(dmaAddr + 6));
		day = bcd2bin(_RamRead(dmaAddr + 7));
		f.timestamp(T_ACCESS, year, month, day, 0, 0, 0);

		year = bcd2bin(_RamRead(dmaAddr + 10));
		if (year>77) {
			year += 1900;
		} else {
			year += 2000;
		}
		month = bcd2bin(_RamRead(dmaAddr + 11));
		day = bcd2bin(_RamRead(dmaAddr + 12));
		hour = bcd2bin(_RamRead(dmaAddr + 13));
		minute = bcd2bin(_RamRead(dmaAddr + 14));
		f.timestamp(T_WRITE, year, month, day, hour, minute, 0);
		f.close();
		result = 0x01;
	}
	digitalWrite(LED, LOW ^ LEDinv);
	return result;
}

long _sys_filesize(uint8* filename) {
	long l = -1;
	File f;

	digitalWrite(LED, HIGH ^ LEDinv);
	if (f = SD.open((char*)filename, O_RDONLY)) {
		l = f.size();
		f.close();
	}
	digitalWrite(LED, LOW ^ LEDinv);
	return(l);
}

int _sys_openfile(uint8* filename, CPM_FCB* F) {
	File f;
	int result = 0;

	digitalWrite(LED, HIGH ^ LEDinv);
	f = SD.open((char*)filename, O_READ);
	if (f) {
		f.dirEntry(&fileDirEntry);
		f.close();
		F->s1 = fromhex(filename[2]) | 0x80;
		result = 1;
	}
	digitalWrite(LED, LOW ^ LEDinv);
	return(result);
}

int _sys_openpublicfile(uint8* filename, CPM_FCB* F) {
	File f;
	int result = 0;
	uint8 origUserCode = filename[2];
	
	digitalWrite(LED, HIGH ^ LEDinv);
	for( uint8 i = 0; i < 16; ++i) {
		filename[2] = tohex(i);
		f = SD.open((char*)filename, O_READ);
		if (f) {
			f.dirEntry(&fileDirEntry);
			f.close();
			if (fileDirEntry.attributes & FAT_ATTRIB_HIDDEN) {
				F->s1 = fromhex(filename[2]) | 0x80;
				F->fn[6] |= 0x80;	// indicates public file opened to caller
				result = 1;
				break;
			}
		}
	}
	filename[2] = origUserCode;
	digitalWrite(LED, LOW ^ LEDinv);
	return(result);
}

int _sys_closefile(uint8* filename, CPM_FCB* F) {
	File f;
	int result = 0;

	if (!(F->s2 & 0x80)) {	// file is modified
		f = SD.open((char*)filename, O_READ);
		if (f) {
			time_t rightNow = Teensy3Clock.get();
			uint16 yr = year(rightNow);
			uint8 mon = month(rightNow);
			uint8 dy = day(rightNow);
			uint8 hr = hour(rightNow);
			uint8 min = minute(rightNow);
			f.timestamp(T_WRITE, yr, mon, dy, hr, min, 0);
			f.makeArchive(false);
			f.close();
			result = 1;
		}
	} else {
		result = 1;	// close is a formality for unmodified files
	}
	digitalWrite(LED, LOW ^ LEDinv);
	return result;
}
int _sys_makefile(uint8* filename) {
	File f;
	int result = 0;

	digitalWrite(LED, HIGH ^ LEDinv);
	f = SD.open((char*)filename, O_CREAT | O_WRITE);
	if (f) {
		time_t rightNow = Teensy3Clock.get();
		uint16 yr = year(rightNow);
		uint8 mon = month(rightNow);
		uint8 dy = day(rightNow);
		uint8 hr = hour(rightNow);
		uint8 min = minute(rightNow);
		f.timestamp(T_CREATE, yr, mon, dy, hr, min, 0);
		f.close();
		result = 1;
	}
	digitalWrite(LED, LOW ^ LEDinv);
	return(result);
}

int _sys_deletefile(uint8* filename) {
	int result;
	digitalWrite(LED, HIGH ^ LEDinv);
	result = SD.remove((char*)filename);
	digitalWrite(LED, LOW ^ LEDinv);
	return(result);
}

int _sys_renamefile(uint8* filename, uint8* newname) {
	File f;
	int result = 0;

	digitalWrite(LED, HIGH ^ LEDinv);
	f = SD.open((char*)filename, O_WRITE | O_APPEND);
	if (f) {
		if (f.rename((char*)newname)) {
			f.makeHidden(false);			// renaming a public file makes it private
			f.close();
			result = 1;
		}
	}
	digitalWrite(LED, LOW ^ LEDinv);
	return(result);
}

#ifdef DEBUGLOG
void _sys_logbuffer(uint8* buffer) {
#ifdef CONSOLELOG
	puts((char*)buffer);
#else
	File f;
	uint8 s = 0;
	while (*(buffer + s))	// Computes buffer size
		++s;
	if (f = SD.open(LogName, O_CREAT | O_APPEND | O_WRITE)) {
		f.write(buffer, s);
		f.flush();
		f.close();
	}
#endif
}
#endif

bool _sys_extendfile(char* fn, unsigned long fpos)
{
	uint8 result = true;
	File f;
	unsigned long i;

	digitalWrite(LED, HIGH ^ LEDinv);
	if (f = SD.open(fn, O_WRITE | O_APPEND)) {
		if (fpos > f.size()) {
			for (i = 0; i < f.size() - fpos; ++i) {
				if (f.write((uint8)0) != 1) {
					result = false;
					break;
				}
			}
		}
		f.close();
	} else {
		result = false;
	}
	digitalWrite(LED, LOW ^ LEDinv);
	return(result);
}

uint8 _sys_readseq(uint8* filename, long fpos) {
	uint8 result = 0xff;
	File f;
	uint8 bytesread;
	uint8 dmabuf[BlkSZ];
	uint8 i;

	digitalWrite(LED, HIGH ^ LEDinv);
	f = SD.open((char*)filename, O_READ);
	if (f) {
		if (f.seek(fpos)) {
			for (i = 0; i < BlkSZ; ++i)
				dmabuf[i] = 0x1a;
			bytesread = f.read(&dmabuf[0], BlkSZ);
			if (bytesread) {
				for (i = 0; i < BlkSZ; ++i)
					_RamWrite(dmaAddr + i, dmabuf[i]);
			}
			result = bytesread ? 0x00 : 0x01;
		} else {
			result = 0x01;
		}
		f.close();
	} else {
		result = 0x10;
	}
	digitalWrite(LED, LOW ^ LEDinv);
	return(result);
}

uint8 _sys_writeseq(uint8* filename, long fpos) {
	uint8 result = 0xff;
	File f;

	digitalWrite(LED, HIGH ^ LEDinv);
	if (_sys_extendfile((char*)filename, fpos))
		f = SD.open((char*)filename, O_RDWR);
	if (f) {
		if (f.seek(fpos)) {
			if (f.write(_RamSysAddr(dmaAddr), BlkSZ))
				result = 0x00;
		} else {
			result = 0x01;
		}
		f.close();
	} else {
		result = 0x10;
	}
	digitalWrite(LED, LOW ^ LEDinv);
	return(result);
}

uint8 _sys_readrand(uint8* filename, long fpos) {
	uint8 result = 0xff;
	File f;
	uint8 bytesread;
	uint8 dmabuf[BlkSZ];
	uint8 i;
	long extSize;

	digitalWrite(LED, HIGH ^ LEDinv);
	f = SD.open((char*)filename, O_READ);
	if (f) {
		if (f.seek(fpos)) {
			for (i = 0; i < BlkSZ; ++i)
				dmabuf[i] = 0x1a;
			bytesread = f.read(&dmabuf[0], BlkSZ);
			if (bytesread) {
				for (i = 0; i < BlkSZ; ++i)
					_RamWrite(dmaAddr + i, dmabuf[i]);
			}
			result = bytesread ? 0x00 : 0x01;
		} else {
			if (fpos >= 65536L * BlkSZ) {
				result = 0x06;	// seek past 8MB (largest file size in CP/M)
			} else {
				extSize = f.size();
				// round file size up to next full logical extent
				extSize = ExtSZ * ((extSize / ExtSZ) + ((extSize % ExtSZ) ? 1 : 0));
				if (fpos < extSize)
					result = 0x01;	// reading unwritten data
				else
					result = 0x04; // seek to unwritten extent
			}
		}
		f.close();
	} else {
		result = 0x10;
	}
	digitalWrite(LED, LOW ^ LEDinv);
	return(result);
}

uint8 _sys_writerand(uint8* filename, long fpos) {
	uint8 result = 0xff;
	File f;

	digitalWrite(LED, HIGH ^ LEDinv);
	if (_sys_extendfile((char*)filename, fpos)) {
		f = SD.open((char*)filename, O_RDWR);
	}
	if (f) {
		if (f.seek(fpos)) {
			if (f.write(_RamSysAddr(dmaAddr), BlkSZ))
				result = 0x00;
		} else {
			result = 0x06;
		}
		f.close();
	} else {
		result = 0x10;
	}
	digitalWrite(LED, LOW ^ LEDinv);
	return(result);
}

static uint8 findNextDirName[13];
static uint16 fileRecords = 0;
static uint16 fileExtents = 0;
static uint16 fileExtentsUsed = 0;
static uint16 firstFreeAllocBlock;

uint8 _findnext(uint8 isdir) {
	File f;
	uint8 result = 0xff;
	bool isfile;
	uint32 bytes;
	bool isPublicFile;

	digitalWrite(LED, HIGH ^ LEDinv);
	if (allExtents && fileRecords) {
		_mockupDirEntry();
		result = 0;
	} else {
		while (f = userdir.openNextFile()) {
			f.getName((char*)&findNextDirName[0], 13);
			isfile = !f.isDirectory();
			bytes = f.size();
			f.dirEntry(&fileDirEntry);
			isPublicFile = fileDirEntry.attributes & FAT_ATTRIB_HIDDEN;
			f.close();
			if (!isfile)
				continue;
			_HostnameToFCBname(findNextDirName, fcbname);
			if (match(fcbname, pattern) && (!publicOnly || isPublicFile)) {
				if (isdir) {
					// account for host files that aren't multiples of the block size
					// by rounding their bytes up to the next multiple of blocks
					if (bytes & (BlkSZ - 1)) {
						bytes = (bytes & ~(BlkSZ - 1)) + BlkSZ;
					}
					fileRecords = bytes / BlkSZ;
					fileExtents = fileRecords / BlkEX + ((fileRecords & (BlkEX - 1)) ? 1 : 0);
					fileExtentsUsed = 0;
					firstFreeAllocBlock = firstBlockAfterDir;
					_mockupDirEntry();
				} else {
					fileRecords = 0;
					fileExtents = 0;
					fileExtentsUsed = 0;
					firstFreeAllocBlock = firstBlockAfterDir;
				}
				_RamWrite(tmpFCB, filename[0] - '@');
				_HostnameToFCB(tmpFCB, findNextDirName);
				result = 0x00;
				break;
			}
		}
	}
	digitalWrite(LED, LOW ^ LEDinv);
	return(result);
}

uint8 _findfirst(uint8 isdir) {
	uint8 path[4] = { '?', FOLDERCHAR, '?', 0 };
	path[0] = filename[0];
	path[2] = filename[2];
	if (userdir)
		userdir.close();
	userdir = SD.open((char*)path); // Set directory search to start from the first position
	_HostnameToFCBname(filename, pattern);
	fileRecords = 0;
	fileExtents = 0;
	fileExtentsUsed = 0;
	return(_findnext(isdir));
}

uint8 _findnextallusers(uint8 isdir) {
	uint8 result = 0xFF;
	char dirname[13];
	bool done = false;

	while (!done) {
		while (!userdir) {
			userdir = rootdir.openNextFile();
			if (!userdir) {
				done = true;
				break;
			}
			userdir.getName(dirname, sizeof dirname);
			if (userdir.isDirectory() && strlen(dirname) == 1 && isxdigit(dirname[0])) {
				currFindUser = dirname[0] <= '9' ? dirname[0] - '0' : toupper(dirname[0]) - 'A' + 10;
				break;
			}
			userdir.close();
		}
		if (userdir) {
			result = _findnext(isdir);
			if (result) {
				userdir.close();
			} else {
				done = true;
			}
		} else {
			result = 0xFF;
			done = true;
		}
	}
	return result;
}

uint8 _findfirstallusers(uint8 isdir) {
	uint8 path[2] = { '?', 0 };

	path[0] = filename[0];
	if (rootdir)
		rootdir.close();
	if (userdir)
		userdir.close();
	rootdir = SD.open((char*)path); // Set directory search to start from the first position
	if (!rootdir)
		return 0xFF;
	fileRecords = 0;
	fileExtents = 0;
	fileExtentsUsed = 0;
	return(_findnextallusers(isdir));
}

uint8 _Truncate(char* filename, uint8 rc) {
	File f;
	int result = 0;

	digitalWrite(LED, HIGH ^ LEDinv);
	f = SD.open((char*)filename, O_WRITE | O_APPEND);
	if (f) {
		if (f.truncate(rc * BlkSZ)) {
			f.close();
			result = 1;
		}
	}
	digitalWrite(LED, LOW ^ LEDinv);
	return(result);
}

void _MakeUserDir() {
	uint8 dFolder = cDrive + 'A';
	uint8 uFolder = tohex(userCode);

	uint8 path[4] = { dFolder, FOLDERCHAR, uFolder, 0 };

	digitalWrite(LED, HIGH ^ LEDinv);
	SD.mkdir((char*)path);
	digitalWrite(LED, LOW ^ LEDinv);
}

uint8 _sys_makedisk(uint8 drive) {
	uint8 result = 0;
	if (drive < 1 || drive>16) {
		result = 0xff;
	} else {
		uint8 dFolder = drive + '@';
		uint8 disk[2] = { dFolder, 0 };
		digitalWrite(LED, HIGH ^ LEDinv);
		if (!SD.mkdir((char*)disk)) {
			result = 0xfe;
		} else {
			uint8 path[4] = { dFolder, FOLDERCHAR, '0', 0 };
			SD.mkdir((char*)path);
		}
		digitalWrite(LED, LOW ^ LEDinv);
	}

	return(result);
}

/* Console abstraction functions */
/*===============================================================================*/
uint8 _crtost(void) {
	return TERMINALPORT.availableForWrite() ? 0xFF : 0x00;
}

void _putcrt(uint8 ch) {
   while( digitalRead(TERMINALRTS) ) {
      yield();
   }
	TERMINALPORT.write(ch);
#if defined BEEPER
	if (ch == '\a') {
		tone(BEEPER, 800, 200);
	} else 
#endif
	if (ch == '\x0e') { // SO - 8 bit output
		setNovaDosFlags(getNovaDosFlags() | HiOutFlag);
	} else if (ch == '\x0f') { // SI - 7 bit output
		setNovaDosFlags(getNovaDosFlags() & ~HiOutFlag);
	}
}

#define KEY_TIMEOUT 5
#define FIFO_LNG 32
static uint8 keyFifo[FIFO_LNG];
static uint8 escNumber;
static int fifoCount = 0,fifoHead = 0, fifoTail = 0;
enum EscStateType { NOT_IN_SEQ, SAW_ESC, SAW_BRACE, SAW_2ND_BRACE, SAW_O, SAW_NUMBER, SAW_8_OR_9, SAW_SEMICOLON, SAW_5 } escState = NOT_IN_SEQ;

// Implement a Finite State Machine to translate VT100/ANSI cursor
// key sequences to WordStar equivalents. This has the major advantage
// of EVERYTHING that understand WS sequences just working with the
// cursor keypad. ZCPR3.3 utilities of all kinds, DazzleStar, Turbo
// Pascal, ZDE, you name it.
//
// This routine works fine on Arduino style platforms, but porting it
// to Linux wasn't straightforward. There seemed to be problems timing
// the interval between characters. As I was primarily interested in
// using this on my Teensy 4, I left the Linux side for another day.
// As I also did not any attempt at optimization, the code is ugly, but
// it does what I want.
int _kbhit(void) {
	char c;
	uint32_t timeout = 0;

	if (getNovaDosFlags() & HiInFlag) {
		// turn off cursor key escape processing
		// when inputting 8 bit characters
		// (needed for file transfers through the
		// console AND handy when a terminal program
		// is talking on a hardware serial port to a
		// system that expects an ANSI terminal)
		//
		// (unless of course that terminal program is
		// ZMP and swallows the ESC character sent by
		// the cursor key - curses, foiled again)
		if (TERMINALPORT.available()) {
			c = TERMINALPORT.read();
			keyFifo[fifoTail] = c;
			fifoTail = (fifoTail + 1) % FIFO_LNG;
			++fifoCount;
			if (c == '\x1b') {
				timeout = millis() + KEY_TIMEOUT;
				do {
					if (TERMINALPORT.available()) {
						keyFifo[fifoTail] = '\x1b';
						fifoTail = (fifoTail + 1) % FIFO_LNG;
						++fifoCount;
						break;
					}
				} while (millis() < timeout);
			}
		}
	} else {
		do {
			if (TERMINALPORT.available()) {
				c = TERMINALPORT.read();
				timeout = millis() + KEY_TIMEOUT;
				keyFifo[fifoTail] = c;
				fifoTail = (fifoTail + 1) % FIFO_LNG;
				++fifoCount;
				switch (escState) {
					case NOT_IN_SEQ:
						if (c == 0x1b) {
							escState = SAW_ESC;
						}
						break;
					case SAW_ESC:
						if (c == '[') {
							escState = SAW_BRACE;
						} else if (c == 'O') {
							escState = SAW_O;
						} else {
							escState = NOT_IN_SEQ;
						}
						break;
					case SAW_BRACE:
						switch (c) {
							case 'A':		// up arrow key
							case 'B':		// down arrow key
							case 'C':		// right arrow key
							case 'D':		// left arrow key
								fifoCount -= 3;
								fifoTail = (fifoTail - 3 + FIFO_LNG) % FIFO_LNG;
								switch (c) {
									case 'A':	// line up
										keyFifo[fifoTail] = 'E' - '@';
										break;
									case 'B':	// line down
										keyFifo[fifoTail] = 'X' - '@';
										break;
									case 'C':	// char right
										keyFifo[fifoTail] = 'D' - '@';
										break;
									case 'D':	// char left
										keyFifo[fifoTail] = 'S' - '@';
										break;
								}
								fifoTail = (fifoTail + 1) % FIFO_LNG;
								++fifoCount;
								escState = NOT_IN_SEQ;
								break;

							case '1':		// HOME key
							case '2':		// INSERT key
							case '3':		// DELETE key
							case '4':		// END key
							case '5':		// PAGE UP key
							case '6':		// PAGE DOWN key
								escNumber = c;
								escState = SAW_NUMBER;
								break;
							case '[':
								escState = SAW_2ND_BRACE;
								break;
							default:
								escState = NOT_IN_SEQ;
								break;
						}
						break;
					case SAW_2ND_BRACE:
						switch( c ) {
							case 'A':
								fifoCount -= 4;
								fifoTail = (fifoTail - 4 + FIFO_LNG) % FIFO_LNG;
								{
									time_t now = Teensy3Clock.get();
									uint16 yr = year(now);
									uint8 mon = month(now) - 1;
									uint8 dy = day(now);
									char dateStr[10];
									static const char *monthNames[] = {
										"Jan","Feb","Mar","Apr","May","Jun",
										"Jul","Aug","Sep","Oct","Nov","Dec"
									};
									snprintf(
										dateStr, 
										sizeof dateStr, 
										"%s %u/%02u", 
										monthNames[mon], 
										dy, yr % 100);
									uint8_t i = 0;
									while( dateStr[i] ) {
										keyFifo[fifoTail] = dateStr[i++];
										fifoTail = (fifoTail + 1) % FIFO_LNG;
										++fifoCount;
									}
								}
								break;
							case 'B':
								fifoCount -= 4;
								fifoTail = (fifoTail - 4 + FIFO_LNG) % FIFO_LNG;
								{
									time_t now = Teensy3Clock.get();
									uint16 hh = hour(now);
									uint8 mm = minute(now);
									char ampm = 'a';
									char timeStr[9];
									if( hh >= 12 ) {
										hh -= 12;
										ampm = 'p';
									}
									if( hh == 0 ) {
										hh = 12;
									}
									snprintf(
										timeStr, sizeof timeStr, 
										"%u:%02u %cm", hh, mm, ampm);
									uint8_t i = 0;
									while( timeStr[i] ) {
										keyFifo[fifoTail] = timeStr[i++];
										fifoTail = (fifoTail + 1) % FIFO_LNG;
										++fifoCount;
									}
								}
								break;
							default:
								break;
						}
						escState = NOT_IN_SEQ;
						break;
					case SAW_O:
						if (c == 'F') {	// <esc> O F - END key
							fifoCount -= 3;
							fifoTail = (fifoTail - 3 + FIFO_LNG) % FIFO_LNG;
							keyFifo[fifoTail] = 'Q' - '@';	
							fifoTail = (fifoTail + 1) % FIFO_LNG;
							++fifoCount;
							keyFifo[fifoTail] = 'D';	// ^QD end of line
							fifoTail = (fifoTail + 1) % FIFO_LNG;
							keyFifo[(fifoTail + 1) % FIFO_LNG] = 'D';
							++fifoCount;
						}
						escState = NOT_IN_SEQ;
						break;
					case SAW_NUMBER:
						if (c == '~') {			// <esc> [ N ~
							switch (escNumber) {
								case '1':	// HOME key
									fifoCount -= 4;
									fifoTail = (fifoTail - 4 + FIFO_LNG) % FIFO_LNG;
									keyFifo[fifoTail] = 'Q' - '@';
									fifoTail = (fifoTail + 1) % FIFO_LNG;
									++fifoCount;
									keyFifo[fifoTail] = 'S';	// ^QS start of line
									fifoTail = (fifoTail + 1) % FIFO_LNG;
									++fifoCount;
									break;
								case '2':	// INSERT key
									fifoCount -= 4;
									fifoTail = (fifoTail - 4 + FIFO_LNG) % FIFO_LNG;
									keyFifo[fifoTail] = 'V' - '@';	// insert on/of
									fifoTail = (fifoTail + 1) % FIFO_LNG;
									++fifoCount;
									break;
								case '3':	// DELETE key
									fifoCount -= 4;
									fifoTail = (fifoTail - 4 + FIFO_LNG) % FIFO_LNG;
									keyFifo[fifoTail] = 'G' - '@';	// del char under cursor
									fifoTail = (fifoTail + 1) % FIFO_LNG;
									++fifoCount;
									break;
								case '4':	// END key
									fifoCount -= 4;
									fifoTail = (fifoTail - 4 + FIFO_LNG) % FIFO_LNG;
									keyFifo[fifoTail] = 'Q' - '@';
									fifoTail = (fifoTail + 1) % FIFO_LNG;
									++fifoCount;
									keyFifo[fifoTail] = 'D';	// ^QD end of line
									fifoTail = (fifoTail + 1) % FIFO_LNG;
									++fifoCount;
									break;
								case '5':	// PAGE UP key
									fifoCount -= 4;
									fifoTail = (fifoTail - 4 + FIFO_LNG) % FIFO_LNG;
									keyFifo[fifoTail] = 'R' - '@';	// page up
									fifoTail = (fifoTail + 1) % FIFO_LNG;
									++fifoCount;
									break;
								case '6':	// PAGE DOWN key
									fifoCount -= 4;
									fifoTail = (fifoTail - 4 + FIFO_LNG) % FIFO_LNG;
									keyFifo[fifoTail] = 'C' - '@';	// page down
									fifoTail = (fifoTail + 1) % FIFO_LNG;
									++fifoCount;
									break;
							}
							escState = NOT_IN_SEQ;
						} else if ((c == '8' || c == '9') && escNumber == '1') {
							escNumber = c;
							escState = SAW_8_OR_9;
						} else if (c == ';' && escNumber == '1') {
							escState = SAW_SEMICOLON;
						} else {
							escState = NOT_IN_SEQ;
						}
						break;
					case SAW_SEMICOLON:
						if (c == '5') {
							escState = SAW_5;
						} else {
							escState = NOT_IN_SEQ;
						}
						break;
					case SAW_8_OR_9:
						if (c == '~') {
							fifoCount -= 5;
							fifoTail = (fifoTail - 5 + FIFO_LNG) % FIFO_LNG;
							keyFifo[fifoTail] = 'K' - '@';
							fifoTail = (fifoTail + 1) % FIFO_LNG;
							++fifoCount;
							if (escNumber == '8') {
								keyFifo[fifoTail] = 'B';	// <F7> - block begin
							} else {
								keyFifo[fifoTail] = 'K';	// <F8> - block end
							}
							fifoTail = (fifoTail + 1) % FIFO_LNG;
							++fifoCount;
						}
						escState = NOT_IN_SEQ;
						break;
					case SAW_5:
						if (c >= 'A' && c <= 'D') {	// <esc> [ 1 ; 5 A, B, C or D
							fifoCount -= 6;
							fifoTail = (fifoTail - 6 + FIFO_LNG) % FIFO_LNG;
							switch (c) {
								case 'A':	// <ctrl>up arrow - scroll up
									keyFifo[fifoTail] = 'W' - '@';
									break;
								case 'B':	// <ctrl>down arrow - scroll down
									keyFifo[fifoTail] = 'Z' - '@';
									break;
								case 'C':	// <ctrl>right arrow - word right
									keyFifo[fifoTail] = 'F' - '@';
									break;
								case 'D':	// <ctrlleft arrow - word left
									keyFifo[fifoTail] = 'A' - '@';
									break;
							}
							fifoTail = (fifoTail + 1) % FIFO_LNG;
							++fifoCount;
						}
						escState = NOT_IN_SEQ;
						break;
				}
			} else if (millis() >= timeout) {
				escState = NOT_IN_SEQ;		// no keypress seen in last 5ms, we're done
			}
		} while (escState != NOT_IN_SEQ);
	}
	return fifoCount != 0;
}

uint8 _crtist(void) {		// Checks if there's a character ready for input
	return(_kbhit() ? 0xff : 0x00);
}

// wait for and return a key from the key FIFO
uint8 _getcrt(void) {
	uint8 c;

	while (!_kbhit()) {
		yield();
	}
	c = keyFifo[fifoHead];
	fifoHead = (fifoHead + 1) % FIFO_LNG;
	--fifoCount;
	return(c & ((getNovaDosFlags() & HiInFlag) ? 0xFF : 0x7F));
}

// non destructive peek at next available character
uint8 _peekcrt(void) {
	if (!_kbhit()) {
		return (uint8)0;
	} else {
		return keyFifo[fifoHead];
	}
}

// wait for an echo a keypress
uint8 _getcrte(void) {
	uint8 ch = _getcrt();
	_putcrt(ch);
	return(ch);
}

void _clrscr(void) {
	_puts("\e[H\e[J");
}

// modem support
#if defined MODEMPORT
// return 1 if a character is ready from the modem input, 0 otherwise
uint8 _ttyist() {
	return (uint8)(MODEMPORT.available() ? 1 : 0);
}

// wait for and return a character from the modem
uint8 _gettty(void) {
	while (!MODEMPORT.available() );
	return MODEMPORT.read();
}

uint8 _peektty(void) {
	int c = MODEMPORT.peek();
	if (c == -1) {
		return (char)0;
	} else {
		return (char)c;
	}
}

// return 1 if a character can be sent to the modem output, 0 otherwise
uint8 _ttyost(void) {
	return (uint8)(digitalRead(MODEMCTS) == LOW ? 1 : 0);
}

// send a character to the modem
void _puttty(uint8 c) {
	MODEMPORT.write(c);
}

// Set up the modem serial port for a new baud rate and possibly data format.
// Largely untested, but does what I want for the moment.
void _modeminit(uint16 iotab) {
	uint32 newBaud = 0;
	uint16 dataFmt = 0xFFFF;
	
	switch (_RamRead(iotab)) {		// baud rate
		case 0:		// 110 baud
			newBaud = 110;
			break;
		case 1:		// 300 baud  
			newBaud = 300;
			break;
		case 2:		// 450 baud
			newBaud = 450;
			break;
		case 3:		// 600 baud
			newBaud = 600;
			break;
		case 4:		// 710 baud
			newBaud = 710;
			break;
		case 5:		// 1200 baud
			newBaud = 1200;
			break;
		case 6:		// 2400 baud
			newBaud = 2400;
			break;
		case 7:		// 4800 baud
			newBaud = 4800;
			break;
		case 8:		// 9600 baud
			newBaud = 9600;
			break;
		case 9:		// 19.2Kbaud
			newBaud = 19200;
			break;
		case 10:		// 38.4Kbaud
			newBaud = 38400;
			break;
		case 11:		// 57.6Kbaud
			newBaud = 57600;
			break;
		case 12:		// 76.8Kbaud
			newBaud = 76800;
			break;
		default:
			break;
	}
	switch (_RamRead(iotab+1)) {					// data bits
		case 7:
			switch (_RamRead(iotab+3)) {			// stop bits
				case 1:
					switch (_RamRead(iotab+2)) {	// parity
						case 'E':
							dataFmt = SERIAL_7E1;
							break;
						case 'O':
							dataFmt = SERIAL_7O1;
							break;
						default:
							break;
					}
					break;
				default:
					break;
			}
			break;
		case 8:
			switch (_RamRead(iotab+3)) {			// stop bits
				case 1:
					switch (_RamRead(iotab+2)) {	// parity
						case 'N':
							dataFmt = SERIAL_8N1;
							break;
						case 'E':
							dataFmt = SERIAL_8E1;
							break;
						case 'O':
							dataFmt = SERIAL_8O1;
							break;
						default:
							break;
					}
					break;
				case 2:
					switch (_RamRead(iotab+2)) {	// parity
						case 'N':
							dataFmt = SERIAL_8N2;
							break;
						case 'E':
							dataFmt = SERIAL_8E2;
							break;
						case 'O':
							dataFmt = SERIAL_8O2;
							break;
						default:
							break;
					}
					break;
				default:
					break;
			}
			break;
		default:
			break;
	}
	if (newBaud && newBaud != modemSpeed) {
		modemSpeed = newBaud;
		
		// update the Teensy's serial port
		if (dataFmt != 0xFFFF) {
			MODEMPORT.begin(newBaud, dataFmt);
		} else {
			MODEMPORT.begin(newBaud);
		}
	}
	MODEMPORT.clear();
}
#else
// return 1 if a character is ready from the modem input, 0 otherwise
uint8 _ttyist() {
	return 0;				// no char available
}

// wait for and return a character from the modem
uint8 _gettty() {
	return (uint8)0x1A;	// EOF
}

// return 1 if a character can be sent to the modem output, 0 otherwise
uint8 _ttyost() {
	return (uint8)1;		// go ahead and send (will be discarded)
}

// send a character to the modem (discard)
void _puttty(uint8 c) {
}

// Set up the modem serial port for a new baud rate and possibly data format.
void _modeminit(uint16 iotab) {
}
#endif

#if defined LPT_PORT
// Reads a given I2C register
uint8 _readI2Cregister(uint8 addr) {
  LPT_PORT.beginTransmission(LPT_ADDR);
  LPT_PORT.write(addr);
  LPT_PORT.endTransmission();
  LPT_PORT.requestFrom(LPT_ADDR, 1);
  return LPT_PORT.read();
}

// Writes a given I2C register
void _writeI2Cregister(uint8 regAddr, uint8 regValue) {
  LPT_PORT.beginTransmission(LPT_ADDR);
  LPT_PORT.write(regAddr);
  LPT_PORT.write(regValue);
  LPT_PORT.endTransmission();
}

uint8 _lptst(void) {
	return (_readI2Cregister(LPT_GPIOB) & LPT_BUSY) ? 0xFF : 0x00;
}

// send a character to the LPT device
//
// assumption: we don't enter this routine before the printer 
// has had a chance to assert the busy signal from the last 
// time we sent a character
void _putlpt(uint8 c) {
	while( _lptst() == 0x00);
	_writeI2Cregister(LPT_GPIOA, c);
	delayMicroseconds(1);
	uint8 lpt_ctrl = _readI2Cregister(LPT_GPIOB);
	_writeI2Cregister(LPT_GPIOB, lpt_ctrl & ~LPT_STROBE);
	delayMicroseconds(1);
	_writeI2Cregister(LPT_GPIOB, lpt_ctrl | LPT_STROBE);
	delayMicroseconds(1);
}

#else
void _putlpt(uint8 c) {
}

uint8 _lptst(void) {
	return 0xFF;
}
#endif

// delay # of ms
void _delay(uint16 ms) {
	delay(ms);
}

// return pointer to internal BIOS millisecond timer block
// with current milliseconds since power up value.
// NB: the value does not increment automagically. You have
// to call _millis() to get the current value.
uint16 _millis() {
	uint32 ms = millis();
	_RamWrite(millisTS,		 ms & 0xFF);
	_RamWrite(millisTS + 1, (ms >> 8) & 0xFF);
	_RamWrite(millisTS + 2, (ms >> 16) & 0xFF);
	_RamWrite(millisTS + 3, (ms >> 24) & 0xFF);
	return millisTS;
}
//
// TimeLib day 0 is Jan 1, 1970 00:00:00
// FAT file system day 0 is Jan 1, 1980 00:00:00
// Z80DOS day 0 is Dec 31, 1977 (or, day 1 is Jan 1,1978)
//
// The upshot is when we retrieve a TimeLib time, we have to subtract
// the number of seconds between Jan 1, 1970 and Dec 31, 1977 - a peroid
// of 2921 days - before we can use it in a Z80DOS time block.
//
// Conversely, when we're converting from a Z80DOS time block to TimeLib
// we add 2921 days worth of seconds.
// 
#define DAYS_OFFSET_CPM_TO_UNIX 2921

uint16 _getZrDosFileTimeStamp() {
	tmElements_t te;
	time_t tt;
	uint16 dt;
	
	dt = bytes2uint16(fileDirEntry.createDate);
	te.Year = CalendarYrToTm(FS_YEAR(dt));
	te.Month = FS_MONTH(dt);
	te.Day = FS_DAY(dt);
	dt = bytes2uint16(fileDirEntry.createTime);
	te.Hour = FS_HOUR(dt);
	te.Minute = FS_MINUTE(dt);
	te.Second = 0;
	tt = makeTime(te);

	uint16 days = tt / SECS_PER_DAY - DAYS_OFFSET_CPM_TO_UNIX;
	_RamWrite16(fileTS+0, days);
	uint8 i;
	i = bin2bcd(hour(tt));
	_RamWrite(fileTS+2, i);
	i = bin2bcd(minute(tt));
	_RamWrite(fileTS+3, i);

	dt = bytes2uint16(fileDirEntry.modifyDate);
	te.Year = CalendarYrToTm(FS_YEAR(dt));
	te.Month = FS_MONTH(dt);
	te.Day = FS_DAY(dt);
	dt = bytes2uint16(fileDirEntry.modifyTime);
	te.Hour = FS_HOUR(dt);
	te.Minute = FS_MINUTE(dt);
	te.Second = 0;
	tt = makeTime(te);
	
	days = tt / SECS_PER_DAY - DAYS_OFFSET_CPM_TO_UNIX;
	_RamWrite16(fileTS+4, days);
	i = bin2bcd(hour(tt));
	_RamWrite(fileTS+6, i);
	i = bin2bcd(minute(tt));
	_RamWrite(fileTS+7, i);

	return fileTS;
}

// ZSDOS compatible get time routine
uint8 _getZsDosTime(uint16 timeBlk) {
	time_t rightNow = Teensy3Clock.get();
	uint8 i;
	i = bin2bcd(year(rightNow) % 100);
	_RamWrite(timeBlk++, i);
	i = bin2bcd(month(rightNow));
	_RamWrite(timeBlk++, i);
	i = bin2bcd(day(rightNow));
	_RamWrite(timeBlk++, i);
	i = bin2bcd(hour(rightNow));
	_RamWrite(timeBlk++, i);
	i = bin2bcd(minute(rightNow));
	_RamWrite(timeBlk++, i);
	i = bin2bcd(second(rightNow));
	_RamWrite(timeBlk++, i);
	return 1;
}

// ZSDOS compatible set time routine
uint8 _setZsDosTime(uint16 timeBlk) {
	uint8 yr = _RamRead(timeBlk++);
	uint8 mon = _RamRead(timeBlk++);
	uint8 day = _RamRead(timeBlk++);
	uint8 hr = _RamRead(timeBlk++);
	uint8 mn = _RamRead(timeBlk++);
	uint8 sec = _RamRead(timeBlk);
	tmElements_t tm;

	yr = bcd2bin(yr);
	// Unix year is # years past 1970
	if (yr < 78) {
		yr += 30;			// 0..77 is 2000..2077
	} else {
		yr -= 70;			// 78..99 is 1978..1999
	}
	tm.Year = yr;
	tm.Month = bcd2bin(mon);
	tm.Day = bcd2bin(day);
	tm.Hour = bcd2bin(hr);
	tm.Minute = bcd2bin(mn);
	tm.Second = bcd2bin(sec);
	Teensy3Clock.set(makeTime(tm)); // set the RTC
	return 1;
}

// ZRDOS compatible get time routine
void _getZrDosTime(uint16 timeBlk) {
	time_t rightNow = Teensy3Clock.get();
	uint16 days = rightNow / SECS_PER_DAY - DAYS_OFFSET_CPM_TO_UNIX;
	_RamWrite16(timeBlk, days);
	timeBlk += 2;
	uint8 i;
	i = bin2bcd(hour(rightNow));
	_RamWrite(timeBlk++, i);
	i = bin2bcd(minute(rightNow));
	_RamWrite(timeBlk++, i);
	i = bin2bcd(second(rightNow));
	_RamWrite(timeBlk++, i);
}

void _setZrDosTime(uint16 timeBlk) {
	time_t newTime = (_RamRead16(timeBlk) + DAYS_OFFSET_CPM_TO_UNIX) * SECS_PER_DAY;
	uint8 i;
	i = _RamRead(timeBlk + 2);
	newTime += 3600UL * bcd2bin(i);
	i = _RamRead(timeBlk + 3);
	newTime += 60UL * bcd2bin(i);
	i = _RamRead(timeBlk + 4);
	newTime += bcd2bin(i);
	Teensy3Clock.set(newTime); // set the RTC
}

#endif
