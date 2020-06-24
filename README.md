# Teensy Board/Z80 - A Teensy4.0 based ZCPR3.3/ZSDOS Z80 computer

The Teensy Board/Z80 is a
[Teensy 4.0](https://www.pjrc.com/store/teensy40.html) computer running a
ZCPR3.3/ZSDOS variant of [RunCPM](https://github.com/MockbaTheBorg/RunCPM).

![Teensy Board/Z80](images/01%20-%20TeensyBoardZ80.jpg "The Teensy Board/Z80")

Features:
* 100-140MHz equivalent Z80 (RunCPM doesn't emulate cycle times - it just goes *fast*).
* SDIO connected uSD card (about 2.5x faster than SPI) with a standard FAT file system.
* ANSI colour terminal emulator with [GSX](https://github.com/mecparts/pigfx)
graphics support. Runs on a first generation Raspberry Pi, so HDMI video
and USB keyboards are natively supported.
* Battery backed up real time clock.
* Centronics compatible parallel port (DB-25F).
* RS-232 serial port (DE-9M) with RTS/CTS hardware flow control.

## Hardware

![VESA mount](images/02%20-%20on%20the%20VESA%20mount.jpg "The Teensy Board/Z80 and the Raspberry Pi on the VESA mount")

The PCB for the Teensy Board/Z80 fits on a VESA mount along with an
original Raspberry Pi 1 B (rev 2). The Pi is the ANSI console used by
the Teensy Board/Z80.

Along with the internal connection to the ANSI terminal, the Teensy Board/Z80
has two vintage I/O ports: an RS-232 port with a DE-9 connector, with
RTS/CTS handshaking, and a Centronics parallel port. The RS-232 port is
the TTY: device in the Teensy Board/Z80's BIOS. The parallel port is,
quite naturally, the LPT: device.

In my setup, the RS-232 port is hooked up to a
[Retro WiFi modem](https://github.com/mecparts/RetroWiFiModem), complete
with Hayes Smartmodem style LED indicators.

The Teensy 4's real time clock is used in ZSDOS to support file timestamps
via the normal ZSDOS calls. A CR2032 coin cell provides the battery back up.

## Case

The Ampro Little Board/Z80 mounted on the bottom of a 5.25" floppy drive.
The Teensy Board/Z80 mounts on a VESA mount on the back on an LCD monitor.

![Case bits and pieces](images/03%20-%20sides%20and%20top.jpg "The case bits and pieces")

The case was designed in OpenSCAD. Although it's 3D printed, it's designed
like a laser cut case, with separate sides, top and bottom. This allowed
a quicker "getting it to fit" cycle than if the bottom and sides had been
printed as one piece; this way, individual sides could by reprinted.

![Sides on](images/04%20-%20sides%20on.jpg "Sides on")

The base is printed with integrated standoffs. The hole are sized to accept
a #4/40 tap so that no nuts are required. It took a bit of care to get the
holes tapped without snapping the standoffs. Both the Teensy Board PCB and
the Raspberry Pi will take 1/2" 4/40 screws in lieu of the M2.5s normally
specified for the Pi.

![Completed case](images/05%20-%20cased.jpg "The completed case")

The sides bolt together with 3/8" #4-40 screws. The filament was plain old
PLA.

## Software

![Booted](images/06%20-%20booted.jpg "Booted")

When I bought my first Teensy 4.0 last autumn, I'd thought about looking
around for a Z80 emulator written in C and implementing a BIOS in Z80
assembler that would talk to the Teensy hardware... somehow. Luckily, I
came across [RunCPM](https://github.com/MockbaTheBorg/RunCPM) first. It
had already solved the problem of communicating with the Teensy
hardware, and had done it with a FAT file system. I stopped looking! I
had the first system up and running within an hour of getting home with
the Teensy.

Over the winter I helped to get RunCPM's BDOS emulation much closer to
how CP/M operated. I'd done my fair share of BIOS development back in
the day, and had even done some work with a BDOS replacement called
*NovaDOS*, but all that was long ago and far away. But like riding a
bicycle, it all started coming back.


While all that was happening, I was also working on getting ZCPR3.3
working with RunCPM. Then, after adding proper serial and parallel port
support to RunCPM's BDOS and BIOS, I, well, started to get a little
carried away.

![Printer and a modem](images/07%20-%20printer%20and%20a%20modem.jpg "The printer and the modem")

![Yes, it really prints](images/08%20-%20printout.jpg "Yes, it really prints")

![The Teensy Board online](images/09%20-%20online.jpg "The Teensy Board/Z80 online")

A couple of decades of having all those extra cursor and function keys
on my keyboard meant that I kept reaching for them. So I added the
equivalent a ZCPR3 IOP to RunCPM's console input handling. It handled
translating the ANSI style arrow, cursor and function keys to their
WordStar(tm) equivalents. Suddenly, *everything* that used the ZCPR TCAP
knew about all those extra keys. That was incredibly handy. Also, it took
no space at in the Z80's 64K.

![And colour graphics too](images/10%20-%20graphics.jpg "And colour graphics too")

The Teensy Board/Z80 also implements the GSX (Graphics System Extension)
BDOS call, but without the overhead of having GSX.SYS and a device
driver loaded in the TPA. No more GSX.SYS or GENGRAF.COM! Instead,
everything is handled in the Teensy Board/Z80's BDOS code. Most of the heavy
lifting actually occurs in my modified PiGFX code running on the
Raspberry Pi. Fast as a 115.2K serial connection is, it's way faster
sending the start and end point of a line and letting PiGFX draw it than
it would be to send a "set this pixel" command for each pixel in the
line.

Then, no longer satisfied with what NovaDOS did, I added ZSDOS
capabilities to RunCPM's BDOS. One of the most useful things to get
working was file datestamps. My favourite editor (ZDE16) was already
ZSDOS-aware and capable of maintaining the actual creation date of a
file; and its backup.

## Forked libraries used by Teensy Board/Z80

* [PiGFX](https://github.com/mecparts/pigfx): a fork of 
https://github.com/dhansel/pigfx (which is a fork of 
https://github.com/fbergama/pigfx) with all kinds of additions, including
native GSX support.
* [SdFat-beta](https://github.com/mecparts/SdFat-beta): a fork of
https://github.com/greiman/SdFat-beta with support for file attributes.

## Status

Though the hardware and software for the Teensy Board/Z80 are in good
shape, this repository will be a work in progress for a while. I still 
have to figure out a good base set of ZCPR3.3/ZSDOS utilities to populate
the disk image with.
