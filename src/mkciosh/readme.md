# Recreating the CIOS.H file

If you have the need to alter the CIOS.H file, here's how I build 
it.

Programs you'll need:

- ZEX
- IF (either resident or transient)
- ZMAC assembler
- Turbo Pascal
- MLOAD

This is done on a running ZCPR system. Use ZEX to run the script 
MKCIOSH.ZEX to build CIOS.H. Then, transfer the CIOS.H file to 
the directory where RunCPM.ino resides (making sure that the 
filename ends up in lower case as cios.h), and rebuild RunCPM.
