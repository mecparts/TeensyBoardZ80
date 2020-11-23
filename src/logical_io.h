#ifndef LOGICAL_IO_H
#define LOGICAL_IO_H

/* see main.c for definition */

uint8 _rdrist();
uint8 _getrdr();
uint8 _peekrdr();
void _putlst(uint8 c);

uint8 _conist(void) {
	switch (_RamRead(IOBYTE) & 0b00000011) {
		case 0:	// 00: TTY:
			return _ttyist();
		case 1:	// 01: CRT:
			return _crtist();
			break;
		case 2:	// 10: BAT:
			return _rdrist();
			break;
		case 3:	// 11: UC1:
			return _usr1ist();
			break;
		default:
			return (uint8)0;
			break;
	}
}

uint8 _getcon(void) {
	switch (_RamRead(IOBYTE) & 0b00000011) {
		case 0:	// 00: TTY:
			return _gettty();
		case 1:	// 01: CRT:
			return _getcrt();
		case 2:	// 10: BAT:
			return _getrdr();
		case 3:	// 11: UC1:
			return _getusr1();
		default:
			return (uint8)0x1A;
	}
}

void _putcon(uint8 ch)		// Puts a character
{
	if (!(getNovaDosFlags() & HiOutFlag)) {
		ch &= 0x7F;
	}
	switch (_RamRead(IOBYTE) & 0b00000011) {
		case 0:	// 00: TTY:
			_puttty(ch);
			break;
		case 1:	// 01: CRT:
			_putcrt(ch);
			break;
		case 2:	// 10: BAT:
			_putlst(ch);
			break;
		case 3:	// 11: UC1:
			_putusr1(ch);
			break;
		default:
			break;
	}
}

uint8 _peekcon() {
	switch (_RamRead(IOBYTE) & 0b00000011) {
		case 0b00000000:	// 00: TTY:
			return _peektty();
		case 1:	// 01: CRT:
			return _peekcrt();
		case 2:	// 10: BAT:
			return _peekrdr();
		case 3:	// 11: UC1:
			return _peekusr1();
		default:
			return (uint8)0x1A;
	}
}

void _puts(const char* str)	// Puts a \0 terminated string
{
	while (*str)
		_putcon(*(str++));
}

void _puthex8(uint8 c)		// Puts a HH hex string
{
	_putcon(tohex(c >> 4));
	_putcon(tohex(c & 0x0f));
}

void _puthex16(uint16 w)	// puts a HHHH hex string
{
	_puthex8(w >> 8);
	_puthex8(w & 0x00ff);
}

uint8 _lstst() {
	switch (_RamRead(IOBYTE) & 0b11000000) {
		case 0b00000000:	// 00 TTY:
			return _ttyost();
		case 0b01000000:	// 01 CRT:
			return _crtost();
		case 0b10000000:	// 10 LPT
			return _lptst();
		case 0b11000000:	// 11 UL1:
			return _usr1ost();
		default:
			return (uint8)0;
	}
}

void _putlst(uint8 c) {
	switch (_RamRead(IOBYTE) & 0b11000000) {
		case 0b00000000:	// 00 TTY:
			_puttty(c);
			break;
		case 0b01000000:	// 01 CRT:
			_putcrt(c);
			break;
		case 0b10000000:	// 10 LPT:
			_putlpt(c);
			break;
		case 0b11000000:	// 11 UC1:
			_putusr1(c);
			break;
		default:
			break;
	}
}

uint8 _getrdr() {
	switch (_RamRead(IOBYTE) & 0b00001100) {
		case 0b00000000:	// 00 TTY:
			return _gettty();
		case 0b00000100:	// 01 PTR:
			return (uint8)0x1A;
		case 0b00001000:	// 10 UR1:
			return _getusr1();
		case 0b00001100:	// 11 UR2:
			return (uint8)0x1a;
		default:
			return (uint8)0x1a;
	}
}

uint8 _rdrist() {
	switch (_RamRead(IOBYTE) & 0b00001100) {
		case 0b00000000:	// 00 TTY:
			return _ttyist();
		case 0b00000100:	// 01 PTR:
			return (uint8)0;
		case 0b00001000:	// 10 UR1:
			return _usr1ist();
		case 0b00001100:	// 11 UR2:
			return (uint8)0;
		default:
			return (uint8)0;
	}
}

uint8 _peekrdr() {
	switch (_RamRead(IOBYTE) & 0b00001100) {
		case 0b00000000:	// 00 TTY:
			return _peektty();
		case 0b00000100:	// 01 PTR:
			return (uint8)0;
		case 0b00001000:	// 10 UR1:
			return _peekusr1();
		case 0b00001100:	// 11 UR2:
			return (uint8)0;
		default:
			return (uint8)0;
	}
}

void _putpun(uint8 c) {
	switch (_RamRead(IOBYTE) & 0b00110000) {
		case 0b00000000:	// 00 TTY:
			_puttty(c);
			break;
		case 0b00010000:	// 01 PTP:
			break;
		case 0b00100000:	// 10 UP1:
			_putusr1(c);
			break;
		case 0b00110000:	// 11 UP2:
			break;
		default:
			break;
	}
}

uint8 _punost() {
	switch (_RamRead(IOBYTE) & 0b00110000) {
		case 0b00000000:	// 00 TTY:
			return _ttyost();
		case 0b00010000:	// 01 PTP:
			return (uint8)0xFF;
		case 0b00100000:	// 10 UP1:
			return _usr1ost();
		case 0b00110000:	// 11 UP2:
			return (uint8)0xFF;
		default:
			return (uint8)0xFF;
	}
}

#endif
