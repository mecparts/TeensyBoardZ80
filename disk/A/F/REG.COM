 Z3ENV � �!  ~�6��w;;������R�( �	� Not Z33+$*	���!� ~#�(�Q �2>���(K!� ���~�(^�/(Z�M�Q��-�Q��Pʄ��+ʄ��S���D #�2>�~�#ʽ��*�Ă�Eʅ��08$�:0 Å���
No Registers Available ���REG, Version 1.2  (Type 3 at  ! �ͣ���H)

Set/Display/Increment/Decrement Registers
Syntax:
 REG Dr or REG r  <-- Display Reg r
 REG Mr or REG -r <-- Minus (Decrement) Reg r
 REG Pr or REG +r <-- Plus (Increment) Reg r
 REG Sr val       <-- Set Reg r to val
where "r" may be 0-31 for one reg, E for error flag,
# for regs 0-9 or * for all regs.
Add Q at end of command for quiet mode. ��E���08�:0�ׄG� 0z����� Invld Reg ID �x��ʷ��΃��ۃ�I��t�O:>���x��(�� Reg �i��� =  y�i��� Error flag �>
2=�> 2=�:>��� �΃͋�x��W�(��     :=�� ��#�!m �ׄ� ,O~�#(�*(�I�y�}�Ë�>
> 2=� y�ۃ:=�� ����
Register value cannot exceed 255 z�#~�#(�*(�I��t�=�}�Ë�>
> 2=� �΃=�ۃ:=�� ��ɂ#~�#(�*(�I��t�<�}�Ë�>
> 2=� �΃<�ۃ:=�� ��ɂ���� �������� ������0 X��������0 X���" *?�~#fo���*?�|�(~���*?��w���"?��������� ~#�(3�	(Ϳ��(��
(�(	� �y�(��y�G>�G�O> Ϳ�������>Ϳ�>
Ϳ���� ���&d��&
��̈́�����͋�0�0Ϳ�|�.�,�0��g}� �@(> �� 7��|ͮ�}ͮ������0�Ϳ���4�Ϳ����.�ń���O: g҄��������  ~�08�0�
0�bk)))_ ��#�{���~#�(��(�+���~#�(��� ����O��	 !'����y���  	
�Ɛ'�@'�                                                                   