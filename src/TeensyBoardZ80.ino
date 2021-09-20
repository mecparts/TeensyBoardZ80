#include "globals.h"

#include <SPI.h>
#include <SdFat-beta.h>  // One SD library to rule them all - Greinman SdFat from Library Manager
#include <Wire.h>

SdFat SD;
#define USE_SDIO
#if defined USE_SDIO
#define SDINIT SdioConfig(FIFO_SDIO)
#define SD_IFC "SDIO"
#else
#define SDINIT 10
#define SD_IFC "SPI"
#endif
#define LED 3
#define LEDinv 0
#if defined ARDUINO_TEENSY41
#define BOARD "Teensy 4.1"
#elif defined ARDUINO_TEENSY40
#define BOARD "Teensy 4.0"
#else
#define BOARD "Unknown board"
#endif

#define MODEMPORT Serial3
#define MODEMSPD 9600
#define MODEMRTS 18
#define MODEMCTS 19
#define MODEMCTSREAD 21
#define MODEMDATABITS 8
#define MODEMSTOPBITS 1

uint32 modemSpeed = MODEMSPD;

#define LPT_PORT		Wire1
#define LPT_ADDR		0x20		// MCP23017 I2C address

// MCP23017 registers
#define LPT_IODIRA	0x00
#define LPT_IODIRB	0x01
#define LPT_IOCON		0x0A
#define LPT_GPPUB		0x0D		// pull ups for control port
#define LPT_GPIOA		0x12		// LPT data port
#define LPT_GPIOB		0x13		// LPT status/control port

#define LPT_CONFIG	0x20		// SEQOP
#define LPT_BUSY		0x01		// /BUSY on GPIOB.1
#define LPT_STROBE	0x02		// /STROBE out on GPIOB.2

#define BEEPER 20

#define USE_GSX
#define PiGFX
//#define TFT
//#define ST7735
//#define ILI9341

// Delays for LED blinking
#define sDELAY 100
#define DELAY 200

// Serial (terminal) port speed
#define TERMINALPORT Serial1
#define SERIALSPD 115200
#define STARTUP_DELAY   3000
#define TERMINALRTS 2

#define USR1PORT Serial

#include "abstraction_arduino.h"

#include "ram.h"
#include "logical_io.h"
#include "cpu.h"
#include "disk.h"
#include "host.h"
#ifdef USE_GSX
#include "gsx.h"
#endif
#include "cpm.h"

void setup(void) {
   int32 startup_delay = STARTUP_DELAY;
   
	pinMode(LED, OUTPUT);
	digitalWrite(LED, LOW);

	TERMINALPORT.begin(SERIALSPD);
   pinMode(TERMINALRTS, INPUT_PULLDOWN);
	while (!TERMINALPORT) {	// Wait until serial is connected
		digitalWrite(LED, HIGH^LEDinv);
		delay(sDELAY);
		digitalWrite(LED, LOW^LEDinv);
		delay(sDELAY);
	}
#if defined MODEMPORT
	MODEMPORT.begin(MODEMSPD);
	if (!MODEMPORT.attachRts(MODEMRTS)) {
		TERMINALPORT.println("Could not attach RTS.");
		return;
	}
	if (!MODEMPORT.attachCts(MODEMCTS)) {
		TERMINALPORT.println("Could not attach CTS.");
		return;
	}
	pinMode(MODEMCTSREAD, INPUT);
#endif

#ifdef LPT_PORT
	LPT_PORT.begin();
	_writeI2Cregister(LPT_IOCON, LPT_CONFIG);	// IOCON.SEQOP
	_writeI2Cregister(LPT_GPPUB, LPT_BUSY);	// enable /BUSY pull up resistor
	_writeI2Cregister(LPT_IODIRA, 0x00);		// data port all outputs
	_writeI2Cregister(LPT_GPIOB, LPT_STROBE);	// make sure /STROBE starts inactive
	_writeI2Cregister(LPT_IODIRB, LPT_BUSY);	// /BUSY is an input; all others out
#endif
		
   while (startup_delay > 0) {
		digitalWrite(LED, HIGH^LEDinv);
		delay(sDELAY);
      startup_delay -= sDELAY;
		digitalWrite(LED, LOW^LEDinv);
		delay(sDELAY);
      startup_delay -= sDELAY;
	}
   
#ifdef DEBUGLOG
	_sys_deletefile((uint8 *)LogName);
#endif

	for( unsigned a=0; a<MEMSIZE; ++a ) {
		_RamWrite(a, 0);
	}
	_RamWrite(IOBYTE, 0b10000001);	// CON:=CRT, RDR:=TTY:, PUN:=TTY, LST:=LPT:
	_clrscr();
	_putcon('\a');
	_puts("TeensyBoard/Z80 (");
	_puts(BOARD);
	_putcon(' ');
	_puts(SD_IFC);
	_puts(")\r\n");
	_puts(STR(CPMSIZE));
	_puts("K ZCPR ");
	_putcon(Z3REV / 10 + '0');
	_putcon('.');
	_putcon(Z3REV % 10 + '0');
	_puts(", ZSDOS 1.1\r\n");
	_puts("Based on RunCPM by Marcelo Dantas\r\n");
	_puts("Arduino read/write support by Krzysztof Klis\r\n");
   _puts("\x1b[#1w");   // Set PiGFX keyboard into Wordstar mode

	if (SD.begin(SDINIT)) {
#if defined USE_GSX
		gsx.begin();
#endif

		if (VersionCCP >= 0x10 || SD.exists(CCPname)) {
			while (true) {
				_PatchCPM();
				Status = RUNNING;
				if (!_RamLoad((char *)CCPname, CCPaddr)) {
					_puts("Unable to load the CCP.\r\nCPU halted.\r\n");
					break;
				}
				Z80reset();
				SET_LOW_REGISTER(BC, _RamRead(0x0004));
				PC = CCPaddr;
				Z80run();
				if (Status == CBOOT) {
					break;
				}
			}
		} else {
			_puts("Unable to load the CCP.\r\nCPU halted.\r\n");
		}
	} else {
		_puts("Unable to initialize SD card.\r\nCPU halted.\r\n");
	}
}

void loop(void) {
	digitalWrite(LED, HIGH^LEDinv);
	delay(DELAY);
	digitalWrite(LED, LOW^LEDinv);
	delay(DELAY);
	digitalWrite(LED, HIGH^LEDinv);
	delay(DELAY);
	digitalWrite(LED, LOW^LEDinv);
	delay(DELAY * 4);
}

