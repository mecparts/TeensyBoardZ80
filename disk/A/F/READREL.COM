!  "�9"&1&! "�!"�! "�>2��2�:] � �?���)���&!\ !���!�6R#6E#6L#6 �� ��E���2�:m � ��2�l !\ ��!e ~� 6O#6U#6T!e ��¬#���\ � \ � \ � ��[��! �"  Ͳ:���#*��*�{���6����� �!���� �!\ � ��s���+*&��>�t>
�t>2�>�2�� ��� ���:���&��z�`{͝��l��Ɛ'�@'���_� �:��ʉx�����͏�!�5�+�> �t�!�4¿�>(�t*�|�c}�c>)�t͏����~�$��t#����\ � ����&w#����*�}��+"�*��w#"���!"�! �� �!�� \ � � 3����!~#4�A�U6��+w�� �2xG�J���*�# }�|�ڧ!  "� }�|�Ҥ��� �� � ʚ�"��!�"�*�� �h!  "��~����2���F�`͏*�#"�ò�H���͝͑���F��F�ZW�[�+*�##"�ò:���+�2��H�O ! 	^#V!@	~#fo���/>M\kz���������`````}}}}��������H��k>��F�t�=�k�+ò͌����͌�`�H
��=�=��͌�����+ò͌�����+! �"ò��F��F�ZW�[
        READREL/ICUAP
Universidad Autonoma de Puebla
      November 20, 1983
$
READREL.COM will decompose the bitstream which
constitutes a .REL file into hexadecimal bytes
and addresses interspersed with commentaries
derived from the 'special LINK elements' and
other clarifying information. The command:

    READREL [D:]FILE[.REL] [[D:]LIST[.EXT]]

will analyze the requested file. If no extension
is given, .REL will be used. The analysis will
always appear at the console; but if a second file
is mentioned, it will also be used for output. Its
default extension will be .OUT
$entry symbol  $COMMON block  $program name  $req lib srch  $reserved      $COM  size $chain ext $def entry $reserved  $extnl + offset $size DATA area $ldng locn cntr $chain address  $def prgrm size $end of program $EOF$ABS: $PREL $DREL $CREL $Disk read error.$Disk write error.$Can't open .REL file.$Disk or Directory full.$Cannot close file.$Duplicate extensions.$-- Analysis interrupted --
$- Output file suppressed -$                                            