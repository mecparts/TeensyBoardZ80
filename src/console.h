#ifndef CONSOLE_H
#define CONSOLE_H

/* see main.c for definition */

uint8 _getcon(void) {
	switch (_RamRead(IOBYTE) & 0b00000011) {
		case 0:	// 00: TTY:
			return _gettty();
			break;
		default:	// 01: CRT:
			return _getcrt();
			break;
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
		default:	// 01: CRT:
			_putcrt(ch);
			break;
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

#endif
