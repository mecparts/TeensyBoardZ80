å   XZI v1 07 May 86 - a Z80 to 8080 translator.  Work done by Irv Hoff, heavily based on a previous program by Frank Zerilli in 1984 which was based on XLATE2.   !  9"l1l���:] � ���?��:^ � ����������� ��������������� <20�2ϛ���{͕�̀����[�2�2!n[P�*Ǜ�z�[�m{�n�m��n�� ��9�� �=�W>w� �z�[�>{�n�>��n��"Ǜ�w�':�/2�~�w:��~�;ʛ��2:��º:�º~�aں�{Һ�_w~����	�������� �(x�P��~�*��6;2#�(+�(#6
#6 �*1#"1*Ǜ����!�:�>!�:��>!�>�*5��#�d�w#wͧ�{�j�����*1 �t���  �P��������Z������!ϛ"5e��
*5^#V#"5�|�ʠ> ���0���x��
�x>
����!ϛ~��"5!"�b
*5^#V#"5�|���> ���0�J�¸��>;��
ø>
�����>;��>��>
���!n[�1	�b!� ́
�!
 ́
�5! ́
ʅ!9
 ́
��!D
 ́
�!Y ́
�$!x ́
�=!v
 ́
��!c
 ́
�
!�
 ́
��!�
 ́
��!� ́
�v
*˛à*͛ ~� ���	����b�;�����'������#âͩ#~�;�	~� ��6	����ͩ��q�����;~��â��ͩ):��+=���	��+�#> �%>	���:!� �=�	�=> ��~�;�b��#~� �b> ��~�a�b�{�b�_�c~#��������b���bCPL  CMA  CCF  CMC  SCF  STC  HALT HLT  RLA  RAL  RRA  RAR  RLCA RLC  RRCA RRC  DAA  DAA  NOP  NOP  DI   DI   EI   EI    EXX  EXX  LDIR LDIR LDI  LDI  LDDR LDDR LDD  LDD  CPI  CPI  CPIR CPIR CPD  CPD  CPDR CPDR INI  INI  INIR INIR IND  IND  INDR INDR OUTI OUTI OTIR OTIR OUTD OUTD OTDR OTDR NEG  NEG  RLD  RLD  RRD  RRD  RETI RETI RETN RETN IM0  IM0  IM1  IM1  IM2  IM2   DJNZ DJNZ BIT  BIT  SET  SET  RES  RES  RLC  RCL  RL   RL   RRC  RRC  RR   RR   SLA  SLA  SRA  SRA  SRL  SRL  IM   IM    DB   DB   DW   DW   DS   DS   DEFB DB   DEFW DW   DEFS DS   EQU  EQU  DEFL SET  ORG  ORG   OR   ORI  ORA  AND  ANI  ANA  XOR  XRI  XRA  CP   CPI  CMP  SUB  SUI  SUB   ADD  ADI  ADD   ADC  ACI  ADC  SBC  SBI  SBB   EX   XCHG  PUSH PUSH POP  POP   INC  INX  INR  DEC  DCX  DCR   LD   MVI  MOV   IF   IF   ELSE ELSE �ENDIFENDIF�MEND ENDM �ENDM ENDM �IN   IN   �OUT  OUT  'RST  RST  �JP   JMP  ~JR   JMP  ~CALL CALL �ORG  ORG  �RET  RET  �MACROMACRO ~� �j	�	�j	�����;� ~� ʮ	�:�z	�;ʮ	�	ʮ	������#�G	ͩ��Z�:��E	��	#~�:	��ß	+�
ʛ	�1
ʛ	�W
	#��	>:#��~���	��	�
��	�1
��	�W
��	y���	> ����	>:��y���	��	>��>
��>	��ͩ~���;� 
�	1l��"˛͊ͩ"͛�<�����#ͩ~�E�/
#~�Q�/
#~�U�����#ͩ~�M�/
#~�A�/
#~�C�/
#~�R�/
#~�O���#ͩ~�D�/
#~�E�/
#~�F�/
#~�L���
 	N#F���~�ʕ
�ͫ
��	Á
<��G~�ʨ
ͫ
x��	×
<������aڶ
�_���
#®
������
>	�� 	A~� ��	�~��#��
�~��~��#��
~��~��#��
x��~��#��
����=F6 ��bp���~� � �	�> ��#�~��;�,�6#�'+~�)ɷ�~�;�L��L#�=+~� �L�	�L#���d��#�Z~�:��+��-��/��*��)��!�~�,�� ��	��;���H ���ͽ�����d��~#x��dÖ~� ʲ�	�#é}�o|�g�> bk~#x�������!6�b*˛à>2"2e*1�*5��s#r#"5�> ����
Ý> ����
Ý�*͛�"͛ͯ�-�/�����
Ý�! �'�*͛�"͛ͯ�-�/���d�_�F�&�,�&���,��#͏���P���!U��
��
����
��à�*͛�"͛ͯ�-�/���d���F�&�,�&��~�_�A���B���C���D���E���H���L��~�(���#�d�+��!�ͫ
���####�d��###>Mw"͛�#~�~�_�A�#~�,#�++�~�_�A�#�d�+�~�_�I���R���~�(�#�F�<+��+��)�+++�~�_�I�#~�_�X�\�Y�\+�#�d�++�~�_�H�#~�_�L�\+�~�(�#�d�)#�d�++++��!�> ͗
��##�d�++��!> ͗
��####�d�++++��*͛�!>
 ͗
#! ��!)> ͗
0��! ��d������
��à�*͛͏���S��"͛���
���
Ý�*͛ͯ�-͏���P����*͛ͯ�@͏��~�(���/���F���!��ͨʣ#��'����Ͷ�##�dʛ�����!p��
��
���
��à��!tÌ�,��#���"͛!���
��
���
�Ý�,#���P���S~��~�(�����(��!g��
��
���
>,�����à�F���d��"͛!y��
�Ý�H��#��=�)���+�!b��
��
�6 ��b��à�,��#~�(�[ͯ�-�!���&�/��ͨʩ#�d�)��++++F+~###w"͛#p#>Mw�-�*͛~��_�A����=�)���+�!Y�-�*͛~��_�A���!]��
��
����
��à��
*͛�>/��>8��à�*͛���~�(��#����
���=�)�+6 ��à~�(�#~�_�C�%#~�)�$#�d�+++��*͛�
��~�(�8#�~�,�M�;�z��z#�9+~�)�[#"3�_"3##��z"͛����
*36 ��bÝ����*͛�u���/�������<��͊�����
��
Ý�*͛Î�*͛����c��ͥ�����
Ý�!k��
��à#�*˛~����b�_�R��
��à~�_�Z��C��P��M��~S#~�,�+�~�_�Z�0�C�0�P�0�M�0�~S#�z�+�~�_�N�~R#~�_�Z�W�C�W+�~2S#~�,�++�~�_�N�~R#~�_�Z�~�C�~+�~2S#�z�++�~�_�P�~R#~�_�E�W�O�W+�~�_�P�~R#~�_�E�~�O�~+�!\ 9	 ��~� ���?�� ��!\ ~	 ��:l ���2~:m � � !m ��:��>M2B>A2C>C2D:u � �1 �!u �����!9�P���!~�P���~��X:0�@��>:��#�o>.��~#� ���o�9� ��ʏ!n["Ǜ���J~� ����~� ����~� >�2�[!�["ɛ���J������~� â���*l������2!*ɛw���
��	�:=���	�>�:<2#:�[=�&>�2�[|���Z}���Z�[�� ��~�l� �z���8{���8!�["ɛ�����~����#�b�� ��7�J>��:�[���{�[*ɛ|� }� ~� �� ��~�l� �:ʛ� :ɛ� Ø����������_� ������ �������Y�� ��� ����������* %�Ͷ���'�2��2d �2
 �2}�0��/�Ͷ�4x�0�E��0��'�h��hd �h
 �h}�0��/�Ͷ�jx�0�{��0��:7=27�>.��>d27:8=28¦> ��>
28:9=29���>229�

XZI translates Zilog Z80 assembly language source
code into Intel 8080 assembly language source code.
It is invoked by a command of the form:

    XZI B:Z80FILE.TYP B:8080FILE.TYP

All parameters are optional - if omitted, the 
following values are assumed:

    Z80 source filetype     - .Z80   (or .MAC)
    8080 output filetype    - .ASM
    8080 output filename    - same as source filename
    Drive                   - current drive



    Byte 0103H - 00 Defaults to .Z80 extent, FF to .MAC [more]  

Examples:

XZI PRGM1                (translates PRGM1.Z80 to PRGM1.ASM)
XZI PRGM1 PRGM2          (translates PRGM1.Z80 to PRGM2.ASM)
XZI PRGM1.MAC PRGM2.TXT  (translates PRGM1.MAC to PRGM2.TXT)

XZI also has the following feature:

  A dot '.' is displayed for each 100 lines processed. 
++ Aborting to CP/M ++
 (BC)B (DE)D   
 DE,HLXCHG  (SP),HLXTHL  #           Z80                     
*** Job cancelled ***
  lines processed
 
Ran out of memory for table of line numbers of intrinsic Z80 opcodes
 (HL)No directory space
 No source file found
 Output file exists, delete it and continue? (Y/N)  Output file write error
    DAD LDA LDAX LHLD LXI PCHL STA SHLD SPHL          ASM                     
Z80 source file:       8080 output file:   STAX  BCB   DED   HLH   SPSP  AFPSW  
XZI v3 - translates Z80 to 8080 source code
   ;
;
;
;
; Line numbers containing untranslated opcodes:
;
;  

Line numbers containing untranslated opcodes:

  
The following operands have been used in your source and have not
been fully translated.  You must complete the translation using an editor.

      ϛd
2                                                                      