ß
RCPMSCAN  v1.0

[type S to pause, C, K or X to abort, ? for help]

                                                                                    !  9"�	1�	>$2 
:] � �r�?�r�/�r 
� O� ��ʽ�����_ !
P~#��O� <ʽ!�{:� ��rGƀo& ~�N�2-�2~�$�22y-�r~� (�,6 x2� !� Fz##~�: �� � O� ѷ¤!� :q�ʙ�2q~��[�w�	���-ʁ�=G:t2 x2t:x���>��~�������G:u�ʵx���:x�xʿ�
��2q��,�E�^���� ��C� � �����_�S��7� ���� � �2p� �7�� �� ��C�����X
++ ABORTED ++$�ͅ  ��������ͅ[more]  �����	� ͅ
 � � *�	���!0�{�^~����#�{�~��#~���:y�º:p<2p����2p�Gͅ         >
��X
++ Cannot find RCPM*.LST ++

--> Type "RS ?" for help
$�!z"r! �*r���\�>
��b�|�bG~�a�,�{�,�_O#x�?����# ~��H��*r~#�|� ��Kx�������>��! ~#���
�k�� 
	� ��>��>
��~�ʝ�����#Ë�������X++ SOURCE FILE READ ERROR ++$>��O� �X----
[End of listing]$�^����_� ��
̒�����! 
w,"v2u���*vw,"v�]�.2u=2x6$��
RCPMSCAN v1.0  06/06/88

RCPMSCAN is a utility customized to scan for strings in the monthly
RCPMxxxx.LST.  A recent version (RCPM0788 or later) must be located on
the same drive/user as RS.COM.  Note: Search string is not case sensitive.

   Usage Examples:

A> RS (203)            All systems with area code 203
A> RS IRV              All systems with a sysop named Irv
A> RS BIBLE|RELIGION   Systems with either word in the description
A> RS FOG #??          FOG systems #10 - #99
A> RS $(               All systems that charge money

If no string is included, this help menu is displayed.
'?'  may be used as a wildcard to match any letter.  ('*' not allowed.)
'|'  allows numerous strings to be used at the same time.
'$N' at the end of the string eliminates [more] pauses
  RCPM????LST                     �   -           