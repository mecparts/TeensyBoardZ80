PROGRAM MkCiosH;
CONST
  BlockEnd = 127;
  CiosHname = 'CIOS.H';
  EofMarker = $1A; { ^Z }
TYPE
  String2 = STRING[2];
  BlockType = ARRAY[0..BlockEnd] OF BYTE;
VAR
  ZeroCom, OneCom, PatchCios : FILE;
  OutFile : TEXT;
  ZeroBlock, OneBlock : BlockType;
  blockIndex, fileOffset : INTEGER;
  bitIndex, prlByte : BYTE;
  foundEOF : BOOLEAN;

FUNCTION HexIt(b : BYTE) : String2;
CONST
  hex : ARRAY[0..15] OF CHAR = '0123456789ABCDEF';
BEGIN
  HexIt := hex[b SHR 4] + hex[b AND 15];
END;

BEGIN
  IF ParamCount <> 2 THEN BEGIN
    WriteLN('Usage:');
    WriteLN('   MKCIOSH CIOS0.COM CIOS1.COM');
    HALT;
  END;
  Assign(ZeroCom, ParamStr(1));
  Assign(OneCom, ParamStr(2));
  Reset(ZeroCom);
  Reset(OneCom);
  Assign(OutFile, CiosHname);
  Rewrite(OutFile);

  WriteLN(OutFile,'#define USE_CIOS');
  WriteLN(OutFile,'static const uint8 cios[] = {');
  WHILE NOT EOF(ZeroCom) DO BEGIN
    BlockRead(ZeroCom, ZeroBlock, 1);
    FOR blockIndex := 0 TO BlockEnd DO BEGIN
      IF (blockIndex AND 7) = 0 THEN
        Write(OutFile,^I);
      Write(OutFile,'0x',HexIt(ZeroBlock[blockIndex]));
      IF (blockIndex AND 7) <> 7 THEN
        Write(OutFile,',')
      ELSE BEGIN
        IF NOT EOF(ZeroCom) OR (blockIndex < 127) THEN
          Write(OutFile,',');
        WriteLN(OutFile);
      END;
    END;
  END;
  WriteLN(OutFile,'};');
  WriteLN(OutFile);

  Seek(ZeroCom, 0);
  WriteLN(OutFile,'static const uint8 cios_prl[] = {');
  fileOffset := 0;
  bitIndex := 0;
  prlByte := 0;
  WHILE NOT EOF(ZeroCom) DO BEGIN
    BlockRead(ZeroCom, ZeroBlock, 1);
    BlockRead(OneCom, OneBlock, 1);
    FOR blockIndex := 0 TO BlockEnd DO BEGIN
      IF (blockIndex AND 63) = 0 THEN
        Write(OutFile,^I);
      IF ZeroBlock[blockIndex] <> OneBlock[blockIndex] THEN
        prlByte := prlByte OR (1 SHL bitIndex);
      bitIndex := Succ(bitIndex);
      IF bitIndex = 8 THEN BEGIN
        bitIndex := 0;
        Write(OutFile,'0x',HexIt(prlByte));
        prlByte := 0;
        IF (blockIndex AND 63) <> 63 THEN
          Write(OutFile,',')
        ELSE BEGIN
          IF NOT EOF(ZeroCom) OR (blockIndex < 127) THEN
            Write(OutFile,',');
          WriteLN(OutFile);
        END;
      END;
    END;
  END;
  WriteLN(OutFile,'};');
  { Finish the file with a C style comment so that the ^Z }
  { eof marker(s) will be ignored when RunCPM is compiled }
  Write(OutFile,'//');

  Close(OutFile);
  Close(OneCom);
  Close(ZeroCom);

  { Make sure last sector doesn't have any garbage after EOF marker }
  Assign(PatchCios, CiosHname);
  Reset(PatchCios);
  Seek(PatchCios, FileSize(PatchCios) - 1);
  BlockRead(PatchCios, ZeroBlock, 1);
  foundEOF := FALSE;
  FOR blockIndex := 0 TO BlockEnd DO BEGIN
    IF NOT foundEOF AND (ZeroBlock[blockIndex] = EofMarker) THEN
      foundEOF := TRUE
    ELSE IF foundEOF THEN
      ZeroBlock[blockIndex] := EofMarker;
  END;
  Seek(PatchCios, FileSize(PatchCios) - 1);
  BlockWrite(PatchCios, ZeroBlock, 1);
  Close(PatchCios);
END.
