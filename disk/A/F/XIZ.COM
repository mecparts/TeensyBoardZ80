æ   XIZ v2 07 May 86 - an 8080 to Z80 translator.  Work done by Irv Hoff, heavily based on a previous program by Frank Zerilli in 1984 which was based on XLATE2.   !  9"A1AF�:] � ���?��:^ � �����Q	�� ��Q������h��� <2�n�)�f:��!�����b�>��_�22@!OWP�*�W�z���u{���u���W�� ��E�� �=�_>w� �z���F{���F���W��"�W�w�':/2~�w:�¦~�;ʣ�¦�2@:���:@���~�a���{���_w~����	�������� �0x�P��~�*��6;2@#�0+�0#6
#6 �*f#"f*�W����!�:@�>!�:�>!�>�͐v�B�T�i��K*f ��t��  �T���=���Z��!OW����!) �!
��!R �!
�s!� �!
�7
!�
 �!
�! �!
��!8 �!
�7
!
 �!
��
!b
 �!
�!� �!
ʻ!�
 �!
��
!_	
 �!
�:!�	��!�	
 �!
��
*C�*J ~� �Z�	�Z����;�u��B�'�;�;�#�͓
#~�;�}~� �T6	���k�͓
������B�;~�u����;͓
):<�ҟ=���	�ʟڗ> Ù>	��:� ʱ�	ʱ> �~�;���#~� ��> �~�a���{���_��~#��F���������~� �%�	�%�����;� ~�:�5�	�h��h�;�h� �h���#� ͓
��j
�:���à#~�:�C��Y+���V���V��Y�z>:#�~�ʥÍ���z���z�y�ڠ> �å>:�y�ڠʥ>�>
�>	�͓
~���;º�}1A��"CE�t
͓
"J�<�����#͓
~�E��#~�Q��#~�U�����#͓
~�M��#~�A��#~�C��#~�R��#~�O���#͓
~�S��#~�E��#~�T��CC   CNC  CZ   CNZ  CP   CM   CPE  CPO   REQ  RNE  RLT  RGE  CEQ  CNE  CLT  CGE  JEQ  JNE  JLT  JGE   ELSE ELSE PENDIFENDIFPENDM ENDM PIF   IF   XIFC  IF   8ICL  *INCL@LST  LIST HMACROMACROX ACI  ADC  ADI  ADD  SBI  SBC   JC   JNC  JZ   JNZ  JP   JM   JPE  JPO   ADC  ADC  �ADD  ADD  �DAD  ADD  �IN   IN   LDA  LD   LDAX LD   LHLD LD   6MOV  LD   JOUT  OUT  �RST  RST  �SBB  SBC  �SHLD LD   �SPHL LD   �STA  LD   �STAX LD   �XCHG EX   �XTHL EX   �PCHL JP    ANI  AND  CALL CALL CPI  CP   JMP  JP   ORG  ORG  ORI  OR   SUI  SUB  XRI  XOR   ANA  AND  CMP  CP   DCR  DEC  INR  INC  MVI  LD   ORA  OR   SUB  SUB  XRA  XOR   RC   RNC  RZ   RNZ  RP   RM   RPE  RPO   RET  RET  CMA  CPL  CMC  CCF  HLT  HALT RAL  RLA  RAR  RRA  RLC  RLCA RRC  RRCA STC  SCF  DAA  DAA  NOP  NOP  DI   DI   EI   EI    DCX  DEC  INX  INC  LXI  LD   POP  POP  PUSH PUSH  DB   DEFB DS   DEFS DW   DEFW EQU  EQU  SET  DEFL  DB   DB   DS   DS   DW   DW   EQU  EQU  SET  DEFL  ENT  ENTRYNAM  NAME RAM  DATA ROG  REL   ~��5
�E��
��	�!
<��
 	N#F����J
>	� 	A~� ��	�~�#�O
�~���#�`
�ͥ
��#�j
H �����
����ͥ
��~#x�ʥ
À
~� ʡ
�	ʡ
�:�#Ó
~�	�� ��,��;����:��+��-��/��*��)�������a��
�_���
#��
����> bk~#x���
��B
��J
��B
*J~�M��m�#�!������B
*J�2���`
��~�_�B�J�D�O�H�T�P�Y��#��#��#�#~�_�S�q#~�_�W�p�#�++�:F!,�Eʱ!.�Nʱ!0�Lʱ!2�Gʱ!4�eʱ!6�nʱ!8�lʱ!:~2F#~2G�!����!���!���>,���B
:F�:G� ���B
!�����B
!����!�B
!����B
!��<�B
*J~�_�B�*�D�0�!���!����B
!���� >)���B
*J~�M�[�m�l�!����#~�#���c�B
� �!�û�B
!����B
!����B
>(�� �!�û�B
!����B
>(�� �!������B
*J~�_�B���D���!���!�`
*J#��B
!����B
!����*J~�;�����#�+~� ��	�#�*Jz��0{��~�#�(>	2B�c>	2T�c>	2i�c> ���
> ��B
��B
>2v�!\ E	 ��
~� ʋ�?ʋ ��
!\ �	 ��
:l �ʡ2�:m � ʵ �!m ��
:���>M2�>A2�>C2�:u � �� �!u ��
�!E��/�!���=��~��:�@� >:� #�>.� ~#� � ��E� ���?>�!��"�W���N         ASM                     �� ��»�� ��ʔ�� >�2N!O"L���N         Z80                     ���/���� �s>�*A��~���#��~� ���	�> �#��>�>
�����2*L��>!w��/�
�/�	�4:<=���	�8>�8:<<2<#:N=�E>�2N|�W�y}�O�yO�� ���́� �z�W�W{�O�W!O"L������� ����N>�:N��O*L|�µ}�µ�� �� ���́� �:M�µ:L�µí'�����d ��
 ��}�0� /����x�0�
��0� ��� �}�o|�g�����_� ������ ��K��_�Y�� ��� �=��K�Q��a��{��_�:h=2h�>.� >d2h:A=2A> � >
2A:�=2���K>22��

XIZ translates Intel 8080 assembly language source
code into Zilog Z80 assembly language source code.
It is invoked by a command of the form:

    XIZ B:8080FILE.TYP B:Z80FILE.TYP

All parameters are optional - if omitted, the
following values are assumed:

    8080 source filetype    - ASM
    Z80  output filetype    - Z80
    Z80  output file name   - same as source file-name
    Drive                   - current drive


    Byte 0103H  - 00 defaults to .Z80 extent, FF to .MAC
    Byte 0104h  - 00 does not print .Z80 and ASEG for MAC
    Byte 0105H  - 00 normal Zilog DEFB, etc., FF to DB, etc. [more] 

Examples:

XIZ PRGM1                 (translates PRGM1.ASM to PRGM1.Z80)
XIZ PRGM1 PRGM2           (translates PRGM1.ASM to PRGM2.Z80)
XIZ PRGM1.TXT PRGM2.MAC   (translates PRGM1.TXT to PRGM2.MAC)

XIZ also has the following feature:

  A dot '.' is displayed for each 100 lines processed. 
++ Aborting to CP/M ++
 
*** Job cancelled ***
  lines processed
 

	.Z80
	ASEG

 No directory space
 No source file found
 Output file exists, delete it and continue? (Y/N)  Output file write error
 
8080 source file:       Z80 output file:   
XIZ v2 - translates 8080 to Z80 source code
  
The following operands have been used in your source and have not
been fully translated.  You must complete the translation using an editor.
	original:		must be translated to:
 Z NZC NCz nzc nc
  
 #ENDIF			ENDIF
  ICL			*INCLUDE
   d LST  <operands>		LIST  <valid ASMB operands>
 2CALL  JP    RET   A,( ),A ),HL DE,HL (SP),HL HL,( A,(BC) A,(DE) 8* A, AF BC ,A DE HL HL, (HL) SP,HL (BC),A (DE),A                                                                                                                     