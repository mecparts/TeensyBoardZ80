EESchema Schematic File Version 2
LIBS:TeensyBoardZ80-rescue
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:teensy
LIBS:TeensyBoardZ80
LIBS:diy_rcl
LIBS:altered
LIBS:TeensyBoardZ80-cache
EELAYER 25 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 1 1
Title "TeensyBoard/Z80 computer"
Date "2020-05-03"
Rev "1.0"
Comp ""
Comment1 "RS-232 serial port and Centronics parallel printer port"
Comment2 "SDIO connected microSD card for storage"
Comment3 "Raspbery Pi B used as terminal"
Comment4 "Teensy 4.0 board for RunCPM based computer"
$EndDescr
$Comp
L Teensy4.0-RESCUE-TeensyBoardZ80 U4
U 1 1 5DFE8B18
P 6500 4250
F 0 "U4" H 6500 5800 50  0000 C CNN
F 1 "Teensy4.0" H 6500 4400 50  0000 C CNN
F 2 "Teensy:Teensy40" H 6100 4450 50  0001 C CNN
F 3 "https://www.pjrc.com/store/teensy40.html" H 6100 4450 50  0001 C CNN
F 4 "1568-DEV-15583-ND" H 6500 4250 60  0001 C CNN "DigiKey PN"
F 5 "33.37" H 6500 4250 60  0001 C CNN "Price"
	1    6500 4250
	1    0    0    -1  
$EndComp
$Comp
L Battery_Cell BT1
U 1 1 5DFE8BE0
P 4800 4500
F 0 "BT1" H 4850 4350 50  0000 L CNN
F 1 "CR2032" H 4850 4450 50  0000 L CNN
F 2 "Connectors:CR2032V" H 4800 4560 50  0001 C CNN
F 3 "http://www.memoryprotectiondevices.com/datasheets/BS-5-datasheet.pdf" H 4800 4560 50  0001 C CNN
F 4 "BS-5-ND" H 4800 4500 60  0001 C CNN "DigiKey PN"
F 5 "1.39" H 4800 4500 60  0001 C CNN "Price"
	1    4800 4500
	1    0    0    -1  
$EndComp
$Comp
L MCP23017 U3
U 1 1 5DFE8C42
P 3600 3000
F 0 "U3" H 3500 4025 50  0000 R CNN
F 1 "MCP23017" H 3850 3000 50  0000 R CNN
F 2 "Housings_DIP:DIP-28_W7.62mm_LongPads" H 3650 2050 50  0001 L CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/20001952C.pdf" H 3850 4000 50  0001 C CNN
	1    3600 3000
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X05 P3
U 1 1 5DFE8D8A
P 4850 3000
F 0 "P3" H 4850 3300 50  0000 C CNN
F 1 "RPI_CONN" V 4950 3000 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x05" H 4850 3000 50  0001 C CNN
F 3 "" H 4850 3000 50  0001 C CNN
	1    4850 3000
	-1   0    0    -1  
$EndComp
$Comp
L CONN_01X08 P4
U 1 1 5DFEB8CB
P 7100 1450
F 0 "P4" H 7100 1900 50  0000 C CNN
F 1 "SDIO connector" V 7200 1450 50  0000 C CNN
F 2 "Connectors_FFC:HLW8R-2C7LF" H 7100 1450 50  0001 C CNN
F 3 "https://cdn.amphenol-icc.com/media/wysiwyg/files/drawing/hlw01lf.pdf" H 7100 1450 50  0001 C CNN
F 4 "HLW8R-2C7LF" H 7100 1450 60  0001 C CNN "DigiKey PN"
F 5 "0.34" H 7100 1450 60  0001 C CNN "Price"
	1    7100 1450
	-1   0    0    -1  
$EndComp
$Comp
L GND #PWR01
U 1 1 5DFEBBC9
P 6200 2500
F 0 "#PWR01" H 6200 2250 50  0001 C CNN
F 1 "GND" H 6200 2350 50  0000 C CNN
F 2 "" H 6200 2500 50  0000 C CNN
F 3 "" H 6200 2500 50  0000 C CNN
	1    6200 2500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 5DFEC7E8
P 8350 5450
F 0 "#PWR02" H 8350 5200 50  0001 C CNN
F 1 "GND" H 8350 5300 50  0000 C CNN
F 2 "" H 8350 5450 50  0000 C CNN
F 3 "" H 8350 5450 50  0000 C CNN
	1    8350 5450
	1    0    0    -1  
$EndComp
$Comp
L LED D1
U 1 1 5DFED9B2
P 4950 3550
F 0 "D1" H 4950 3650 50  0000 C CNN
F 1 "LED" H 4950 3450 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x02" H 4950 3550 50  0001 C CNN
F 3 "" H 4950 3550 50  0001 C CNN
	1    4950 3550
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR03
U 1 1 5DFEDCAD
P 4950 3750
F 0 "#PWR03" H 4950 3500 50  0001 C CNN
F 1 "GND" H 4950 3600 50  0000 C CNN
F 2 "" H 4950 3750 50  0000 C CNN
F 3 "" H 4950 3750 50  0000 C CNN
	1    4950 3750
	1    0    0    -1  
$EndComp
$Comp
L MAX232 U2
U 1 1 5DFEE5B3
P 3450 6100
F 0 "U2" H 2900 7150 50  0000 C CNN
F 1 "MAX3232" H 3450 6350 50  0000 C CNN
F 2 "Housings_DIP:DIP-16_W7.62mm" H 3450 6200 50  0001 C CNN
F 3 "https://datasheets.maximintegrated.com/en/ds/MAX3222-MAX3241.pdf" H 3450 6200 50  0001 C CNN
F 4 "ICL3232CPZ-ND" H 3450 6100 60  0001 C CNN "DigiKey PN"
F 5 "2.65" H 3450 6100 60  0001 C CNN "Price"
	1    3450 6100
	-1   0    0    -1  
$EndComp
$Comp
L +3V3 #PWR04
U 1 1 5DFEEAD1
P 7800 5400
F 0 "#PWR04" H 7800 5250 50  0001 C CNN
F 1 "+3V3" V 7800 5600 50  0000 C CNN
F 2 "" H 7800 5400 50  0000 C CNN
F 3 "" H 7800 5400 50  0000 C CNN
	1    7800 5400
	0    1    1    0   
$EndComp
$Comp
L +3V3 #PWR05
U 1 1 5DFEEC77
P 3450 4300
F 0 "#PWR05" H 3450 4150 50  0001 C CNN
F 1 "+3V3" H 3300 4350 50  0000 C CNN
F 2 "" H 3450 4300 50  0000 C CNN
F 3 "" H 3450 4300 50  0000 C CNN
	1    3450 4300
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR06
U 1 1 5DFEEDE0
P 3450 7400
F 0 "#PWR06" H 3450 7150 50  0001 C CNN
F 1 "GND" H 3450 7250 50  0000 C CNN
F 2 "" H 3450 7400 50  0000 C CNN
F 3 "" H 3450 7400 50  0000 C CNN
	1    3450 7400
	1    0    0    -1  
$EndComp
$Comp
L Buzzer BZ1
U 1 1 5DFEF4D9
P 5950 6200
F 0 "BZ1" H 6100 6250 50  0000 L CNN
F 1 "Buzzer" H 6100 6150 50  0000 L CNN
F 2 "Murata_Buzzers:PKM22EPP" H 5925 6300 50  0001 C CNN
F 3 "https://www.murata.com/~/media/webrenewal/support/library/catalog/products/sound/p37e.ashx?la=en-us" H 5925 6300 50  0001 C CNN
F 4 "490-7031-ND" H 5950 6200 60  0001 C CNN "DigiKey PN"
F 5 "0.93" H 5950 6200 60  0001 C CNN "Price"
	1    5950 6200
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR07
U 1 1 5DFF0112
P 5800 6350
F 0 "#PWR07" H 5800 6100 50  0001 C CNN
F 1 "GND" H 5800 6200 50  0000 C CNN
F 2 "" H 5800 6350 50  0000 C CNN
F 3 "" H 5800 6350 50  0000 C CNN
	1    5800 6350
	1    0    0    -1  
$EndComp
$Comp
L C_Small C5
U 1 1 5DFFE7C4
P 4350 5350
F 0 "C5" H 4360 5420 50  0000 L CNN
F 1 "100nF" H 4360 5270 50  0000 L CNN
F 2 "Capacitors_THT:C_Axial_D2.5_L4.3_P7.5" H 4350 5350 50  0001 C CNN
F 3 "https://content.kemet.com/datasheets/KEM_C1042_AXIMAX_Z5U.pdf" H 4350 5350 50  0001 C CNN
F 4 "399-9843-ND" H 4350 5350 60  0001 C CNN "DigiKey PN"
F 5 "0.34" H 4350 5350 60  0001 C CNN "Price"
	1    4350 5350
	1    0    0    -1  
$EndComp
$Comp
L C_Small C3
U 1 1 5DFFE995
P 2500 5350
F 0 "C3" H 2510 5420 50  0000 L CNN
F 1 "100nF" H 2510 5270 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D3_P2.5" H 2500 5350 50  0001 C CNN
F 3 "https://content.kemet.com/datasheets/KEM_C1042_AXIMAX_Z5U.pdf" H 2500 5350 50  0001 C CNN
F 4 "399-9843-ND" H 2500 5350 60  0001 C CNN "DigiKey PN"
F 5 "0.37" H 2500 5350 60  0001 C CNN "Price"
	1    2500 5350
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR08
U 1 1 5DFFEFD2
P 2250 6100
F 0 "#PWR08" H 2250 5850 50  0001 C CNN
F 1 "GND" H 2250 5950 50  0000 C CNN
F 2 "" H 2250 6100 50  0000 C CNN
F 3 "" H 2250 6100 50  0000 C CNN
	1    2250 6100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR09
U 1 1 5DFFF1C3
P 3600 4800
F 0 "#PWR09" H 3600 4550 50  0001 C CNN
F 1 "GND" H 3600 4650 50  0000 C CNN
F 2 "" H 3600 4800 50  0000 C CNN
F 3 "" H 3600 4800 50  0000 C CNN
	1    3600 4800
	1    0    0    -1  
$EndComp
$Comp
L CONN_02X13 P1
U 1 1 5E005536
P 1350 3600
F 0 "P1" H 1350 4300 50  0000 C CNN
F 1 "Parallel Port" V 1350 3600 50  0000 C CNN
F 2 "Connectors:IDC_Header_Straight_26pins" H 1350 2450 50  0001 C CNN
F 3 "http://www.on-shore.com/wp-content/uploads/2018/04/302-SXX1.pdf" H 1350 2450 50  0001 C CNN
F 4 "377-2269-ND" H 1350 3600 60  0001 C CNN "DigiKey PN"
F 5 "0.86" H 1350 3600 60  0001 C CNN "Price"
	1    1350 3600
	-1   0    0    -1  
$EndComp
$Comp
L GND #PWR010
U 1 1 5E005623
P 1000 4300
F 0 "#PWR010" H 1000 4050 50  0001 C CNN
F 1 "GND" H 1000 4150 50  0000 C CNN
F 2 "" H 1000 4300 50  0000 C CNN
F 3 "" H 1000 4300 50  0000 C CNN
	1    1000 4300
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR011
U 1 1 5E006448
P 3600 1300
F 0 "#PWR011" H 3600 1150 50  0001 C CNN
F 1 "+3.3V" H 3600 1440 50  0000 C CNN
F 2 "" H 3600 1300 50  0000 C CNN
F 3 "" H 3600 1300 50  0000 C CNN
	1    3600 1300
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR012
U 1 1 5E00653D
P 3600 4100
F 0 "#PWR012" H 3600 3850 50  0001 C CNN
F 1 "GND" H 3750 4050 50  0000 C CNN
F 2 "" H 3600 4100 50  0000 C CNN
F 3 "" H 3600 4100 50  0000 C CNN
	1    3600 4100
	1    0    0    -1  
$EndComp
NoConn ~ 4100 2600
NoConn ~ 4100 2700
$Comp
L GND #PWR013
U 1 1 5E006D75
P 1900 4150
F 0 "#PWR013" H 1900 3900 50  0001 C CNN
F 1 "GND" H 1900 4000 50  0000 C CNN
F 2 "" H 1900 4150 50  0000 C CNN
F 3 "" H 1900 4150 50  0000 C CNN
	1    1900 4150
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR014
U 1 1 5E007431
P 5200 2600
F 0 "#PWR014" H 5200 2450 50  0001 C CNN
F 1 "+5V" H 5200 2740 50  0000 C CNN
F 2 "" H 5200 2600 50  0000 C CNN
F 3 "" H 5200 2600 50  0000 C CNN
	1    5200 2600
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR015
U 1 1 5E007555
P 8350 5050
F 0 "#PWR015" H 8350 4900 50  0001 C CNN
F 1 "+5V" H 8350 5190 50  0000 C CNN
F 2 "" H 8350 5050 50  0000 C CNN
F 3 "" H 8350 5050 50  0000 C CNN
	1    8350 5050
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG016
U 1 1 5E0082E3
P 8550 5000
F 0 "#FLG016" H 8550 5095 50  0001 C CNN
F 1 "PWR_FLAG" H 8550 5180 50  0000 C CNN
F 2 "" H 8550 5000 50  0000 C CNN
F 3 "" H 8550 5000 50  0000 C CNN
	1    8550 5000
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG017
U 1 1 5E0083D0
P 8550 5600
F 0 "#FLG017" H 8550 5695 50  0001 C CNN
F 1 "PWR_FLAG" H 8550 5780 50  0000 C CNN
F 2 "" H 8550 5600 50  0000 C CNN
F 3 "" H 8550 5600 50  0000 C CNN
	1    8550 5600
	-1   0    0    1   
$EndComp
NoConn ~ 5400 4800
NoConn ~ 5400 5600
NoConn ~ 5400 4200
NoConn ~ 5400 4100
NoConn ~ 5400 4000
NoConn ~ 5400 3900
NoConn ~ 5400 3800
NoConn ~ 5400 3700
NoConn ~ 5400 3600
NoConn ~ 5400 3500
NoConn ~ 5400 3400
NoConn ~ 7600 5600
NoConn ~ 7600 5500
$Comp
L GND #PWR018
U 1 1 5E009C8B
P 5600 2600
F 0 "#PWR018" H 5600 2350 50  0001 C CNN
F 1 "GND" H 5600 2450 50  0000 C CNN
F 2 "" H 5600 2600 50  0000 C CNN
F 3 "" H 5600 2600 50  0000 C CNN
	1    5600 2600
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR019
U 1 1 5E00B303
P 8200 5050
F 0 "#PWR019" H 8200 4900 50  0001 C CNN
F 1 "VCC" H 8200 5200 50  0000 C CNN
F 2 "" H 8200 5050 50  0000 C CNN
F 3 "" H 8200 5050 50  0000 C CNN
	1    8200 5050
	1    0    0    -1  
$EndComp
$Comp
L C_Small C9
U 1 1 5E813948
P 7100 2200
F 0 "C9" H 6900 2200 50  0000 L CNN
F 1 "4.7uF" H 6850 2100 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D3_P2.5" H 7100 2200 50  0001 C CNN
F 3 "https://api.kemet.com/component-edge/download/datasheet/T350A475K006AT.pdf" H 7100 2200 50  0001 C CNN
F 4 "399-3543-ND" H 7100 2200 60  0001 C CNN "DigiKey PN"
F 5 "1.59" H 7100 2200 60  0001 C CNN "Price"
	1    7100 2200
	1    0    0    -1  
$EndComp
$Comp
L C_Small C6
U 1 1 5E813D65
P 6800 2200
F 0 "C6" H 6600 2200 50  0000 L CNN
F 1 "22uF" H 6550 2100 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D3_P2.5" H 6800 2200 50  0001 C CNN
F 3 "https://api.kemet.com/component-edge/download/datasheet/T350F226K016AT.pdf" H 6800 2200 50  0001 C CNN
F 4 "399-3574-ND" H 6800 2200 60  0001 C CNN "DigiKey PN"
F 5 "2.59" H 6800 2200 60  0001 C CNN "Price"
	1    6800 2200
	1    0    0    -1  
$EndComp
$Comp
L R_US R9
U 1 1 5E826F27
P 5200 3300
F 0 "R9" V 5280 3300 50  0000 C CNN
F 1 "470R" V 5350 3300 50  0000 C CNN
F 2 "Discret:R3" H 5200 3300 60  0001 C CNN
F 3 "https://www.seielect.com/catalog/sei-cf_cfm.pdf" H 5200 3300 60  0001 C CNN
F 4 "CF18JT470R" V 5200 3300 60  0001 C CNN "DigiKey PN"
F 5 "0.16" V 5200 3300 60  0001 C CNN "Field5"
	1    5200 3300
	0    1    1    0   
$EndComp
$Comp
L R_US R10
U 1 1 5E826FFE
P 5500 6100
F 0 "R10" V 5580 6100 50  0000 C CNN
F 1 "1K" V 5420 6100 50  0000 C CNN
F 2 "Discret:R3" H 5500 6100 60  0001 C CNN
F 3 "https://www.seielect.com/catalog/sei-cf_cfm.pdf" H 5500 6100 60  0001 C CNN
F 4 "CF18JT1K00CT-ND" V 5500 6100 60  0001 C CNN "DigiKey PN"
F 5 "0.16" V 5500 6100 60  0001 C CNN "Price"
	1    5500 6100
	0    1    1    0   
$EndComp
$Comp
L 74LS245A U5
U 1 1 5E826860
P 2550 3600
F 0 "U5" H 2650 4175 50  0000 L BNN
F 1 "74LS245" H 2600 3025 50  0000 L TNN
F 2 "Housings_DIP:DIP-20_W7.62mm_LongPads" H 2550 3600 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74ls245" H 2550 3600 50  0001 C CNN
	1    2550 3600
	1    0    0    -1  
$EndComp
$Comp
L R_US R7
U 1 1 5E827B2B
P 4300 3100
F 0 "R7" H 4450 3050 50  0000 C CNN
F 1 "4.7K" H 4450 3150 50  0000 C CNN
F 2 "Discret:R3" H 4300 3100 60  0001 C CNN
F 3 "https://www.seielect.com/catalog/sei-cf_cfm.pdf" H 4300 3100 60  0001 C CNN
F 4 "CF18JT4K70CT-ND" H 4300 3100 60  0001 C CNN "DigiKey PN"
F 5 "0.16" H 4300 3100 60  0001 C CNN "Price"
	1    4300 3100
	-1   0    0    1   
$EndComp
$Comp
L R_US R8
U 1 1 5E827D14
P 4400 3100
F 0 "R8" H 4300 3050 50  0000 C CNN
F 1 "4.7K" H 4250 3150 50  0000 C CNN
F 2 "Discret:R3" H 4400 3100 60  0001 C CNN
F 3 "https://www.seielect.com/catalog/sei-cf_cfm.pdf" H 4400 3100 60  0001 C CNN
F 4 "CF18JT4K70CT-ND" H 4400 3100 60  0001 C CNN "DigiKey PN"
F 5 "0.16" H 4400 3100 60  0001 C CNN "Price"
	1    4400 3100
	-1   0    0    1   
$EndComp
$Comp
L +3V3 #PWR020
U 1 1 5E827FEB
P 4400 2800
F 0 "#PWR020" H 4400 2650 50  0001 C CNN
F 1 "+3V3" H 4400 2940 50  0000 C CNN
F 2 "" H 4400 2800 50  0000 C CNN
F 3 "" H 4400 2800 50  0000 C CNN
	1    4400 2800
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR021
U 1 1 5E828324
P 4150 3850
F 0 "#PWR021" H 4150 3600 50  0001 C CNN
F 1 "GND" H 4150 3700 50  0000 C CNN
F 2 "" H 4150 3850 50  0000 C CNN
F 3 "" H 4150 3850 50  0000 C CNN
	1    4150 3850
	1    0    0    -1  
$EndComp
$Comp
L R_US R6
U 1 1 5E828704
P 4150 2050
F 0 "R6" H 4050 2000 50  0000 C CNN
F 1 "4.7K" H 4000 2100 50  0000 C CNN
F 2 "Discret:R3" H 4150 2050 60  0001 C CNN
F 3 "https://www.seielect.com/catalog/sei-cf_cfm.pdf" H 4150 2050 60  0001 C CNN
F 4 "CF18JT4K70CT-ND" H 4150 2050 60  0001 C CNN "DigiKey PN"
F 5 "0.16" H 4150 2050 60  0001 C CNN "Price"
	1    4150 2050
	-1   0    0    1   
$EndComp
$Comp
L +3V3 #PWR022
U 1 1 5E828776
P 4150 1900
F 0 "#PWR022" H 4150 1750 50  0001 C CNN
F 1 "+3V3" H 4150 2040 50  0000 C CNN
F 2 "" H 4150 1900 50  0000 C CNN
F 3 "" H 4150 1900 50  0000 C CNN
	1    4150 1900
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR023
U 1 1 5E828A46
P 2550 2900
F 0 "#PWR023" H 2550 2750 50  0001 C CNN
F 1 "+5V" H 2450 3000 50  0000 C CNN
F 2 "" H 2550 2900 50  0000 C CNN
F 3 "" H 2550 2900 50  0000 C CNN
	1    2550 2900
	-1   0    0    -1  
$EndComp
$Comp
L GND #PWR024
U 1 1 5E828B7F
P 2550 4300
F 0 "#PWR024" H 2550 4050 50  0001 C CNN
F 1 "GND" H 2550 4150 50  0000 C CNN
F 2 "" H 2550 4300 50  0000 C CNN
F 3 "" H 2550 4300 50  0000 C CNN
	1    2550 4300
	1    0    0    -1  
$EndComp
$Comp
L R_US R5
U 1 1 5E82C34D
P 3000 1900
F 0 "R5" H 2900 1850 50  0000 C CNN
F 1 "4.7K" H 2850 1950 50  0000 C CNN
F 2 "Discret:R3" H 3000 1900 60  0001 C CNN
F 3 "https://www.seielect.com/catalog/sei-cf_cfm.pdf" H 3000 1900 60  0001 C CNN
F 4 "CF18JT4K70CT-ND" H 3000 1900 60  0001 C CNN "DigiKey PN"
F 5 "0.16" H 3000 1900 60  0001 C CNN "Price"
	1    3000 1900
	-1   0    0    1   
$EndComp
$Comp
L +3V3 #PWR025
U 1 1 5E82C353
P 3000 1750
F 0 "#PWR025" H 3000 1600 50  0001 C CNN
F 1 "+3V3" H 3000 1890 50  0000 C CNN
F 2 "" H 3000 1750 50  0000 C CNN
F 3 "" H 3000 1750 50  0000 C CNN
	1    3000 1750
	1    0    0    -1  
$EndComp
$Comp
L R_US R3
U 1 1 5E82C795
P 1900 2100
F 0 "R3" H 1800 2050 50  0000 C CNN
F 1 "10K" H 1750 2150 50  0000 C CNN
F 2 "Discret:R3" H 1900 2100 60  0001 C CNN
F 3 "https://www.seielect.com/catalog/sei-cf_cfm.pdf" H 1900 2100 60  0001 C CNN
F 4 "CF18JT10K0CT-ND" H 1900 2100 60  0001 C CNN "DigiKey PN"
F 5 "0.16" H 1900 2100 60  0001 C CNN "Price"
	1    1900 2100
	-1   0    0    1   
$EndComp
$Comp
L +5V #PWR026
U 1 1 5E82C911
P 1900 1900
F 0 "#PWR026" H 1900 1750 50  0001 C CNN
F 1 "+5V" H 1800 2000 50  0000 C CNN
F 2 "" H 1900 1900 50  0000 C CNN
F 3 "" H 1900 1900 50  0000 C CNN
	1    1900 1900
	-1   0    0    -1  
$EndComp
$Comp
L R_US R2
U 1 1 5E82CC1E
P 800 2100
F 0 "R2" H 700 2050 50  0000 C CNN
F 1 "10K" H 650 2150 50  0000 C CNN
F 2 "Discret:R3" H 800 2100 60  0001 C CNN
F 3 "https://www.seielect.com/catalog/sei-cf_cfm.pdf" H 800 2100 60  0001 C CNN
F 4 "CF18JT10K0CT-ND" H 800 2100 60  0001 C CNN "DigiKey PN"
F 5 "0.16" H 800 2100 60  0001 C CNN "Price"
	1    800  2100
	-1   0    0    1   
$EndComp
$Comp
L +5V #PWR027
U 1 1 5E82CC24
P 800 1900
F 0 "#PWR027" H 800 1750 50  0001 C CNN
F 1 "+5V" H 700 2000 50  0000 C CNN
F 2 "" H 800 1900 50  0000 C CNN
F 3 "" H 800 1900 50  0000 C CNN
	1    800  1900
	-1   0    0    -1  
$EndComp
$Comp
L R_US R1
U 1 1 5E82EFF3
P 600 1200
F 0 "R1" H 500 1150 50  0000 C CNN
F 1 "10K" H 450 1250 50  0000 C CNN
F 2 "Discret:R3" H 600 1200 60  0001 C CNN
F 3 "https://www.seielect.com/catalog/sei-cf_cfm.pdf" H 600 1200 60  0001 C CNN
F 4 "CF18JT10K0CT-ND" H 600 1200 60  0001 C CNN "DigiKey PN"
F 5 "0.16" H 600 1200 60  0001 C CNN "Price"
	1    600  1200
	-1   0    0    1   
$EndComp
$Comp
L +5V #PWR028
U 1 1 5E82EFF9
P 600 1000
F 0 "#PWR028" H 600 850 50  0001 C CNN
F 1 "+5V" H 500 1100 50  0000 C CNN
F 2 "" H 600 1000 50  0000 C CNN
F 3 "" H 600 1000 50  0000 C CNN
	1    600  1000
	-1   0    0    -1  
$EndComp
$Comp
L R_US R4
U 1 1 5E82F193
P 2700 1200
F 0 "R4" H 2600 1150 50  0000 C CNN
F 1 "4.7K" H 2550 1250 50  0000 C CNN
F 2 "Discret:R3" H 2700 1200 60  0001 C CNN
F 3 "https://www.seielect.com/catalog/sei-cf_cfm.pdf" H 2700 1200 60  0001 C CNN
F 4 "CF18JT4K70CT-ND" H 2700 1200 60  0001 C CNN "DigiKey PN"
F 5 "0.16" H 2700 1200 60  0001 C CNN "Price"
	1    2700 1200
	-1   0    0    1   
$EndComp
$Comp
L +3V3 #PWR029
U 1 1 5E82F199
P 2700 1050
F 0 "#PWR029" H 2700 900 50  0001 C CNN
F 1 "+3V3" H 2700 1190 50  0000 C CNN
F 2 "" H 2700 1050 50  0000 C CNN
F 3 "" H 2700 1050 50  0000 C CNN
	1    2700 1050
	1    0    0    -1  
$EndComp
NoConn ~ 3100 2900
NoConn ~ 3100 2800
NoConn ~ 3100 2700
NoConn ~ 3100 2600
NoConn ~ 3100 2500
NoConn ~ 3100 2400
Text Notes 850  1400 0    60   ~ 0
BUSY
Text Notes 1950 1400 0    60   ~ 0
/BUSY
Text Notes 4300 6200 0    60   ~ 0
TxD
Text Notes 4300 6400 0    60   ~ 0
RTS
Text Notes 4300 6600 0    60   ~ 0
RxD
Text Notes 4300 6800 0    60   ~ 0
CTS
NoConn ~ 7300 1400
$Comp
L LM2931AZ-3.3/5.0 U6
U 1 1 5EA694B3
P 6200 2050
F 0 "U6" H 6200 2300 50  0000 C CNN
F 1 "L4931CZ33-AP" H 6200 2250 50  0000 C CNN
F 2 "TO_SOT_Packages_THT:TO-92_Inline_Wide" H 6200 2150 50  0001 C CIN
F 3 "http://www.st.com/content/ccc/resource/technical/document/datasheet/ff/95/2f/6a/75/70/42/49/CD00000971.pdf/files/CD00000971.pdf/jcr:content/translations/en.CD00000971.pdf" H 6200 2050 50  0001 C CNN
F 4 "497-7246-1-ND" H 6200 2050 60  0001 C CNN "DigiKey PN"
F 5 "1.06" H 6200 2050 60  0001 C CNN "Price"
	1    6200 2050
	1    0    0    -1  
$EndComp
$Comp
L CONN_02X05 P2
U 1 1 5EA69640
P 1850 6700
F 0 "P2" H 1850 6400 50  0000 C CNN
F 1 "Serial Port" V 1850 6700 50  0000 C CNN
F 2 "Connectors:IDC_Header_Straight_10pins" H 1850 5500 50  0001 C CNN
F 3 "http://www.on-shore.com/wp-content/uploads/2018/04/302-SXX1.pdf" H 1850 5500 50  0001 C CNN
F 4 "296-1589-5-ND" H 1850 6700 60  0001 C CNN "DigiKey PN"
F 5 "0.63" H 1850 6700 60  0001 C CNN "Price"
	1    1850 6700
	-1   0    0    1   
$EndComp
NoConn ~ 2100 6900
NoConn ~ 2100 6600
NoConn ~ 1600 6500
NoConn ~ 1600 6600
NoConn ~ 1600 6900
Text Notes 1400 6700 0    60   ~ 0
CTS
Text Notes 1400 6800 0    60   ~ 0
RTS
Text Notes 2200 6700 0    60   ~ 0
TxD
Text Notes 2200 6800 0    60   ~ 0
RxD
$Comp
L C_Small C4
U 1 1 5EA7DA56
P 3600 4600
F 0 "C4" H 3610 4670 50  0000 L CNN
F 1 "100nF" H 3610 4520 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D3_P2.5" H 3600 4600 50  0001 C CNN
F 3 "https://content.kemet.com/datasheets/KEM_C1042_AXIMAX_Z5U.pdf" H 3600 4600 50  0001 C CNN
F 4 "399-9843-ND" H 3600 4600 60  0001 C CNN "DigiKey PN"
F 5 "0.37" H 3600 4600 60  0001 C CNN "Price"
	1    3600 4600
	1    0    0    -1  
$EndComp
$Comp
L C_Small C1
U 1 1 5EA7DAF5
P 2450 5700
F 0 "C1" V 2300 5650 50  0000 L CNN
F 1 "100nF" V 2500 5750 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D3_P2.5" H 2450 5700 50  0001 C CNN
F 3 "https://content.kemet.com/datasheets/KEM_C1042_AXIMAX_Z5U.pdf" H 2450 5700 50  0001 C CNN
F 4 "399-9843-ND" H 2450 5700 60  0001 C CNN "DigiKey PN"
F 5 "0.37" H 2450 5700 60  0001 C CNN "Price"
	1    2450 5700
	0    1    1    0   
$EndComp
$Comp
L C_Small C2
U 1 1 5EA7DB7B
P 2450 6000
F 0 "C2" V 2550 6000 50  0000 L CNN
F 1 "100nF" V 2400 5700 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D3_P2.5" H 2450 6000 50  0001 C CNN
F 3 "https://content.kemet.com/datasheets/KEM_C1042_AXIMAX_Z5U.pdf" H 2450 6000 50  0001 C CNN
F 4 "399-9843-ND" H 2450 6000 60  0001 C CNN "DigiKey PN"
F 5 "0.37" H 2450 6000 60  0001 C CNN "Price"
	1    2450 6000
	0    -1   -1   0   
$EndComp
$Comp
L C_Small C8
U 1 1 5EA7E3ED
P 7400 2200
F 0 "C8" H 7200 2200 50  0000 L CNN
F 1 "100nF" H 7150 2100 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D3_P2.5" H 7400 2200 50  0001 C CNN
F 3 "https://content.kemet.com/datasheets/KEM_C1042_AXIMAX_Z5U.pdf" H 7400 2200 50  0001 C CNN
F 4 "399-9843-ND" H 7400 2200 60  0001 C CNN "DigiKey PN"
F 5 "0.37" H 7400 2200 60  0001 C CNN "Price"
	1    7400 2200
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR030
U 1 1 5EA7EB67
P 5700 1900
F 0 "#PWR030" H 5700 1750 50  0001 C CNN
F 1 "+5V" H 5700 2040 50  0000 C CNN
F 2 "" H 5700 1900 50  0000 C CNN
F 3 "" H 5700 1900 50  0000 C CNN
	1    5700 1900
	1    0    0    -1  
$EndComp
$Comp
L CP1_Small C7
U 1 1 5EA7ECF6
P 8350 5250
F 0 "C7" H 8360 5320 50  0000 L CNN
F 1 "100nF" H 8360 5170 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D3_P2.5" H 8350 5250 50  0001 C CNN
F 3 "https://content.kemet.com/datasheets/KEM_C1042_AXIMAX_Z5U.pdf" H 8350 5250 50  0001 C CNN
F 4 "399-9843-ND" H 8350 5250 60  0001 C CNN "DigiKey PN"
F 5 "0.37" H 8350 5250 60  0001 C CNN "Price"
	1    8350 5250
	1    0    0    -1  
$EndComp
Text Notes 1000 2700 0    60   ~ 0
/STROBE
NoConn ~ 1600 4200
NoConn ~ 1600 4100
NoConn ~ 1600 3900
NoConn ~ 1100 3300
NoConn ~ 1100 3200
NoConn ~ 1100 3100
NoConn ~ 1100 3000
Text Notes 1750 3800 0    60   ~ 0
DB7
Text Notes 1750 3700 0    60   ~ 0
DB6
Text Notes 1750 3600 0    60   ~ 0
DB5
Text Notes 1750 3500 0    60   ~ 0
DB4
Text Notes 1750 3400 0    60   ~ 0
DB3
Text Notes 1750 3300 0    60   ~ 0
DB2
Text Notes 1750 3200 0    60   ~ 0
DB1
Text Notes 1750 3100 0    60   ~ 0
DB0
$Comp
L +5V #PWR031
U 1 1 5E006E88
P 1900 3950
F 0 "#PWR031" H 1900 3800 50  0001 C CNN
F 1 "+5V" H 1800 4050 50  0000 C CNN
F 2 "" H 1900 3950 50  0000 C CNN
F 3 "" H 1900 3950 50  0000 C CNN
	1    1900 3950
	-1   0    0    -1  
$EndComp
$Comp
L GND #PWR032
U 1 1 5EA8828D
P 4800 4700
F 0 "#PWR032" H 4800 4450 50  0001 C CNN
F 1 "GND" H 4800 4550 50  0000 C CNN
F 2 "" H 4800 4700 50  0000 C CNN
F 3 "" H 4800 4700 50  0000 C CNN
	1    4800 4700
	1    0    0    -1  
$EndComp
$Comp
L VMEM #PWR033
U 1 1 5EA882E0
P 4800 4200
F 0 "#PWR033" H 4800 4050 50  0001 C CNN
F 1 "VMEM" H 4800 4350 50  0000 C CNN
F 2 "" H 4800 4200 50  0000 C CNN
F 3 "" H 4800 4200 50  0000 C CNN
	1    4800 4200
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG034
U 1 1 5EA883EF
P 5100 4200
F 0 "#FLG034" H 5100 4295 50  0001 C CNN
F 1 "PWR_FLAG" H 5100 4380 50  0000 C CNN
F 2 "" H 5100 4200 50  0000 C CNN
F 3 "" H 5100 4200 50  0000 C CNN
	1    5100 4200
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR035
U 1 1 5EA88C96
P 4500 4250
F 0 "#PWR035" H 4500 4000 50  0001 C CNN
F 1 "GND" H 4500 4100 50  0000 C CNN
F 2 "" H 4500 4250 50  0000 C CNN
F 3 "" H 4500 4250 50  0000 C CNN
	1    4500 4250
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X02 P5
U 1 1 5EA88AD0
P 4550 4000
F 0 "P5" V 4750 4000 50  0000 C CNN
F 1 "Vbat" V 4650 4000 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x02" H 4550 4000 50  0001 C CNN
F 3 "" H 4550 4000 50  0001 C CNN
	1    4550 4000
	0    -1   -1   0   
$EndComp
$Comp
L CN0023 P6
U 1 1 5EAA0B3D
P 8200 1550
F 0 "P6" H 8300 1600 50  0000 C CNN
F 1 "CN0023" H 8300 1500 50  0000 C CNN
F 2 "microSD_Adapters:CN0023" H 8100 1650 60  0001 C CNN
F 3 "http://www.chipquik.com/datasheets/CN0023.pdf" H 8100 1650 60  0001 C CNN
F 4 "CN0023-ND" H 8200 1550 60  0001 C CNN "DigiKey PN"
F 5 "16.00" H 8200 1550 60  0001 C CNN "Price"
	1    8200 1550
	1    0    0    -1  
$EndComp
$Comp
L C_Small C12
U 1 1 5EAA38F6
P 3750 1600
F 0 "C12" H 3760 1670 50  0000 L CNN
F 1 "100nF" H 3760 1520 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D3_P2.5" H 3750 1600 50  0001 C CNN
F 3 "https://content.kemet.com/datasheets/KEM_C1042_AXIMAX_Z5U.pdf" H 3750 1600 50  0001 C CNN
F 4 "399-9843-ND" H 3750 1600 60  0001 C CNN "DigiKey PN"
F 5 "0.37" H 3750 1600 60  0001 C CNN "Price"
	1    3750 1600
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR036
U 1 1 5EAA39B9
P 3750 1800
F 0 "#PWR036" H 3750 1550 50  0001 C CNN
F 1 "GND" H 3750 1650 50  0000 C CNN
F 2 "" H 3750 1800 50  0000 C CNN
F 3 "" H 3750 1800 50  0000 C CNN
	1    3750 1800
	1    0    0    -1  
$EndComp
$Comp
L C_Small C11
U 1 1 5EAA41B2
P 2300 4450
F 0 "C11" H 2310 4520 50  0000 L CNN
F 1 "100nF" H 2310 4370 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D3_P2.5" H 2300 4450 50  0001 C CNN
F 3 "https://content.kemet.com/datasheets/KEM_C1042_AXIMAX_Z5U.pdf" H 2300 4450 50  0001 C CNN
F 4 "399-9843-ND" H 2300 4450 60  0001 C CNN "DigiKey PN"
F 5 "0.37" H 2300 4450 60  0001 C CNN "Price"
	1    2300 4450
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR037
U 1 1 5EAA41B8
P 2300 4600
F 0 "#PWR037" H 2300 4350 50  0001 C CNN
F 1 "GND" H 2300 4450 50  0000 C CNN
F 2 "" H 2300 4600 50  0000 C CNN
F 3 "" H 2300 4600 50  0000 C CNN
	1    2300 4600
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR038
U 1 1 5EAA42C2
P 2300 4300
F 0 "#PWR038" H 2300 4150 50  0001 C CNN
F 1 "+5V" H 2200 4400 50  0000 C CNN
F 2 "" H 2300 4300 50  0000 C CNN
F 3 "" H 2300 4300 50  0000 C CNN
	1    2300 4300
	-1   0    0    -1  
$EndComp
$Comp
L C_Small C10
U 1 1 5EAA45F1
P 2300 850
F 0 "C10" H 2310 920 50  0000 L CNN
F 1 "100nF" H 2310 770 50  0000 L CNN
F 2 "Capacitors_THT:C_Disc_D3_P2.5" H 2300 850 50  0001 C CNN
F 3 "https://content.kemet.com/datasheets/KEM_C1042_AXIMAX_Z5U.pdf" H 2300 850 50  0001 C CNN
F 4 "399-9843-ND" H 2300 850 60  0001 C CNN "DigiKey PN"
F 5 "0.37" H 2300 850 60  0001 C CNN "Price"
	1    2300 850 
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR039
U 1 1 5EAA45F7
P 2300 1000
F 0 "#PWR039" H 2300 750 50  0001 C CNN
F 1 "GND" H 2300 850 50  0000 C CNN
F 2 "" H 2300 1000 50  0000 C CNN
F 3 "" H 2300 1000 50  0000 C CNN
	1    2300 1000
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR040
U 1 1 5EAA45FE
P 2300 700
F 0 "#PWR040" H 2300 550 50  0001 C CNN
F 1 "+5V" H 2200 800 50  0000 C CNN
F 2 "" H 2300 700 50  0000 C CNN
F 3 "" H 2300 700 50  0000 C CNN
	1    2300 700 
	-1   0    0    -1  
$EndComp
NoConn ~ 7800 1900
$Comp
L 74LS05 U1
U 3 1 5E82303E
P 1450 1400
F 0 "U1" H 1645 1515 50  0000 C CNN
F 1 "74LS05" H 1640 1275 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_LongPads" H 1450 1400 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74ls05" H 1450 1400 50  0001 C CNN
F 4 "296-1631-5-ND" H 1450 1400 60  0001 C CNN "DigiKey PN"
F 5 "1.45" H 1450 1400 60  0001 C CNN "Price"
	3    1450 1400
	1    0    0    -1  
$EndComp
$Comp
L 74LS05 U1
U 2 1 5E82311C
P 1350 2300
F 0 "U1" H 1545 2415 50  0000 C CNN
F 1 "74LS05" H 1540 2175 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_LongPads" H 1350 2300 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74ls05" H 1350 2300 50  0001 C CNN
F 4 "296-1631-5-ND" H 1350 2300 60  0001 C CNN "DigiKey PN"
F 5 "1.45" H 1350 2300 60  0001 C CNN "Price"
	2    1350 2300
	-1   0    0    -1  
$EndComp
Wire Wire Line
	7400 1400 7400 2100
Wire Wire Line
	2300 700  2300 750 
Wire Wire Line
	2300 1000 2300 950 
Wire Wire Line
	2300 4300 2300 4350
Wire Wire Line
	2300 4600 2300 4550
Connection ~ 3600 1400
Wire Wire Line
	3750 1400 3600 1400
Wire Wire Line
	3750 1500 3750 1400
Wire Wire Line
	3750 1800 3750 1700
Connection ~ 7500 2400
Wire Wire Line
	7750 2000 7750 2400
Wire Wire Line
	7800 2000 7750 2000
Wire Wire Line
	4600 4200 4600 4250
Wire Wire Line
	4500 4250 4500 4200
Connection ~ 4800 4250
Wire Wire Line
	5100 4250 5100 4200
Wire Wire Line
	4600 4250 5100 4250
Wire Wire Line
	4800 4200 4800 4300
Wire Wire Line
	4800 4600 4800 4700
Wire Wire Line
	1600 3100 2050 3100
Wire Wire Line
	1600 3200 2050 3200
Wire Wire Line
	1600 3300 2050 3300
Wire Wire Line
	1600 3400 2050 3400
Wire Wire Line
	1600 3500 2050 3500
Wire Wire Line
	1600 3600 2050 3600
Wire Wire Line
	1600 3700 2050 3700
Wire Wire Line
	1600 3800 2050 3800
Wire Wire Line
	1000 3400 1000 4300
Wire Wire Line
	1000 3400 1100 3400
Wire Wire Line
	1100 3500 1000 3500
Connection ~ 1000 3500
Wire Wire Line
	1000 3600 1100 3600
Connection ~ 1000 3600
Wire Wire Line
	1000 3700 1100 3700
Connection ~ 1000 3700
Wire Wire Line
	1000 3800 1100 3800
Connection ~ 1000 3800
Wire Wire Line
	1000 3900 1100 3900
Connection ~ 1000 3900
Wire Wire Line
	1000 4000 1100 4000
Connection ~ 1000 4000
Wire Wire Line
	1000 4100 1100 4100
Connection ~ 1000 4100
Wire Wire Line
	1000 4200 1100 4200
Connection ~ 1000 4200
Wire Wire Line
	1700 4600 1700 4000
Wire Wire Line
	1700 4000 1600 4000
Wire Wire Line
	1600 3000 1700 3000
Wire Wire Line
	1700 2700 800  2700
Wire Wire Line
	1700 3000 1700 2700
Wire Wire Line
	5700 2000 5800 2000
Wire Wire Line
	5700 1900 5700 2000
Connection ~ 6200 2400
Wire Wire Line
	7400 2300 7400 2400
Connection ~ 6800 2400
Wire Wire Line
	6200 2300 6200 2500
Connection ~ 6800 2000
Wire Wire Line
	2600 6800 2650 6800
Wire Wire Line
	2600 7200 2600 6800
Wire Wire Line
	1300 7200 2600 7200
Wire Wire Line
	1300 6700 1300 7200
Wire Wire Line
	1600 6700 1300 6700
Wire Wire Line
	1400 6800 1600 6800
Wire Wire Line
	1400 7100 1400 6800
Wire Wire Line
	2500 7100 1400 7100
Wire Wire Line
	2500 6400 2500 7100
Wire Wire Line
	2650 6400 2500 6400
Wire Wire Line
	2450 6800 2100 6800
Wire Wire Line
	2450 6600 2450 6800
Wire Wire Line
	2650 6600 2450 6600
Wire Wire Line
	2400 6200 2650 6200
Wire Wire Line
	2400 6700 2400 6200
Wire Wire Line
	2100 6700 2400 6700
Wire Wire Line
	2150 6500 2150 6000
Wire Wire Line
	2100 6500 2150 6500
Wire Wire Line
	7400 1400 7800 1400
Wire Wire Line
	5200 2800 5050 2800
Wire Wire Line
	5200 2600 5200 2800
Wire Wire Line
	5050 2900 5400 2900
Wire Wire Line
	5400 3000 5050 3000
Wire Wire Line
	5050 3100 5400 3100
Wire Wire Line
	5400 3200 5050 3200
Wire Wire Line
	4950 3300 4950 3400
Wire Wire Line
	4950 3700 4950 3750
Connection ~ 2700 1400
Wire Wire Line
	2700 1050 2700 1100
Connection ~ 600  1400
Wire Wire Line
	600  1000 600  1100
Wire Wire Line
	2700 1400 1900 1400
Wire Wire Line
	2700 1300 2700 2200
Wire Wire Line
	2700 2200 3100 2200
Wire Wire Line
	600  4600 1700 4600
Wire Wire Line
	600  1300 600  4600
Wire Wire Line
	1000 1400 600  1400
Connection ~ 800  2300
Wire Wire Line
	800  1900 800  2000
Wire Wire Line
	800  2300 900  2300
Wire Wire Line
	800  2700 800  2200
Wire Wire Line
	1900 1900 1900 2000
Connection ~ 1900 2300
Wire Wire Line
	1900 2200 1900 2300
Wire Wire Line
	1800 2300 2000 2300
Connection ~ 3000 2300
Wire Wire Line
	3000 2000 3000 2300
Wire Wire Line
	2900 2300 3100 2300
Wire Wire Line
	3000 1750 3000 1800
Wire Wire Line
	3050 3800 3100 3800
Wire Wire Line
	3050 3700 3100 3700
Wire Wire Line
	3050 3600 3100 3600
Wire Wire Line
	3050 3500 3100 3500
Wire Wire Line
	3050 3400 3100 3400
Wire Wire Line
	3050 3300 3100 3300
Wire Wire Line
	3050 3200 3100 3200
Wire Wire Line
	3050 3100 3100 3100
Wire Wire Line
	2550 4300 2550 4250
Wire Wire Line
	2550 2900 2550 2950
Wire Wire Line
	4150 2200 4100 2200
Wire Wire Line
	4150 2150 4150 2200
Wire Wire Line
	4150 1900 4150 1950
Connection ~ 4150 3800
Wire Wire Line
	4100 3800 4150 3800
Connection ~ 4150 3700
Wire Wire Line
	4100 3700 4150 3700
Wire Wire Line
	4150 3600 4100 3600
Wire Wire Line
	4150 3600 4150 3850
Connection ~ 4400 2900
Wire Wire Line
	4300 2900 4400 2900
Wire Wire Line
	4300 3000 4300 2900
Wire Wire Line
	4400 2800 4400 3000
Connection ~ 4400 3400
Connection ~ 4300 3300
Wire Wire Line
	1900 4000 2050 4000
Wire Wire Line
	1900 3950 1900 4000
Wire Wire Line
	1900 4100 1950 4100
Wire Wire Line
	1900 4150 1900 4100
Wire Wire Line
	7300 1100 7800 1100
Wire Wire Line
	7300 1200 7800 1200
Wire Wire Line
	7300 1300 7800 1300
Wire Wire Line
	7300 1500 7800 1500
Wire Wire Line
	7300 1600 7800 1600
Wire Wire Line
	7300 1700 7800 1700
Wire Wire Line
	7300 1800 7800 1800
Wire Wire Line
	7500 2400 7500 1600
Wire Wire Line
	7750 2400 6200 2400
Connection ~ 7400 2400
Connection ~ 7500 1600
Wire Wire Line
	8350 5050 8350 5150
Wire Wire Line
	8350 5350 8350 5450
Wire Wire Line
	7600 5300 8200 5300
Wire Wire Line
	8200 5300 8200 5400
Wire Wire Line
	8200 5400 8800 5400
Connection ~ 8350 5400
Wire Wire Line
	8200 5200 7600 5200
Wire Wire Line
	8200 5050 8200 5200
Wire Wire Line
	8200 5100 8700 5100
Connection ~ 8350 5100
Wire Wire Line
	4950 3300 5100 3300
Wire Wire Line
	5300 3300 5400 3300
Wire Wire Line
	7800 5400 7600 5400
Wire Wire Line
	3450 7400 3450 7300
Wire Wire Line
	5400 4900 4600 4900
Wire Wire Line
	4600 4900 4600 6200
Wire Wire Line
	4600 6200 4250 6200
Wire Wire Line
	5400 5000 4750 5000
Wire Wire Line
	4750 5000 4750 6600
Wire Wire Line
	4750 6600 4250 6600
Wire Wire Line
	5400 5300 4900 5300
Wire Wire Line
	4900 5300 4900 6400
Wire Wire Line
	4900 6400 4250 6400
Wire Wire Line
	5400 5400 5050 5400
Wire Wire Line
	5050 5400 5050 6800
Wire Wire Line
	5050 6800 4250 6800
Wire Wire Line
	5800 6350 5800 6300
Wire Wire Line
	5800 6300 5850 6300
Wire Wire Line
	5600 6100 5850 6100
Wire Wire Line
	5400 6100 5200 6100
Wire Wire Line
	5200 6100 5200 5500
Wire Wire Line
	5200 5500 5400 5500
Wire Wire Line
	3450 4300 3450 4900
Wire Wire Line
	4250 5200 4350 5200
Wire Wire Line
	4350 5200 4350 5250
Wire Wire Line
	4350 5450 4350 5500
Wire Wire Line
	4350 5500 4250 5500
Wire Wire Line
	2500 5250 2500 5200
Wire Wire Line
	2500 5200 2650 5200
Wire Wire Line
	2500 5450 2500 5500
Wire Wire Line
	2500 5500 2650 5500
Wire Wire Line
	2550 6000 2650 6000
Wire Wire Line
	2250 5700 2250 6100
Wire Wire Line
	2250 5700 2350 5700
Wire Wire Line
	2150 6000 2350 6000
Connection ~ 2250 6000
Wire Wire Line
	3600 4800 3600 4700
Wire Wire Line
	3600 4400 3600 4500
Connection ~ 3450 4400
Wire Wire Line
	3600 1300 3600 2000
Wire Wire Line
	3600 4000 3600 4100
Wire Wire Line
	4300 5100 5400 5100
Wire Wire Line
	4300 3200 4300 5100
Wire Wire Line
	4300 3300 4100 3300
Wire Wire Line
	4400 5200 5400 5200
Wire Wire Line
	4400 3200 4400 5200
Wire Wire Line
	4400 3400 4100 3400
Wire Wire Line
	8550 5100 8550 5000
Wire Wire Line
	8550 5400 8550 5600
Wire Wire Line
	2550 5700 2650 5700
Wire Wire Line
	5600 2600 5600 2550
Wire Wire Line
	5600 2550 5350 2550
Wire Wire Line
	5350 2550 5350 2900
Connection ~ 5350 2900
Wire Wire Line
	3600 4400 3450 4400
Connection ~ 8200 5100
Wire Wire Line
	7400 2000 6600 2000
Wire Wire Line
	6800 2000 6800 2100
Connection ~ 7400 2000
Wire Wire Line
	7100 2100 7100 2000
Connection ~ 7100 2000
Wire Wire Line
	6800 2300 6800 2400
Wire Wire Line
	7100 2400 7100 2300
Connection ~ 7100 2400
$Comp
L 74LS05 U1
U 1 1 5E8232DF
P 2450 2300
F 0 "U1" H 2645 2415 50  0000 C CNN
F 1 "74LS05" H 2640 2175 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_LongPads" H 2450 2300 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74ls05" H 2450 2300 50  0001 C CNN
F 4 "296-1631-5-ND" H 2450 2300 60  0001 C CNN "DigiKey PN"
F 5 "1.45" H 2450 2300 60  0001 C CNN "Price"
	1    2450 2300
	-1   0    0    -1  
$EndComp
$Comp
L 74LS05 U1
U 4 1 5EAA1B89
P 5250 700
F 0 "U1" H 5445 815 50  0000 C CNN
F 1 "74LS05" H 5440 575 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_LongPads" H 5250 700 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74ls05" H 5250 700 50  0001 C CNN
F 4 "296-1631-5-ND" H 5250 700 60  0001 C CNN "DigiKey PN"
F 5 "1.45" H 5250 700 60  0001 C CNN "Price"
	4    5250 700 
	1    0    0    -1  
$EndComp
$Comp
L 74LS05 U1
U 5 1 5EAA1CD3
P 5250 1100
F 0 "U1" H 5445 1215 50  0000 C CNN
F 1 "74LS05" H 5440 975 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_LongPads" H 5250 1100 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74ls05" H 5250 1100 50  0001 C CNN
F 4 "296-1631-5-ND" H 5250 1100 60  0001 C CNN "DigiKey PN"
F 5 "1.45" H 5250 1100 60  0001 C CNN "Price"
	5    5250 1100
	1    0    0    -1  
$EndComp
$Comp
L 74LS05 U1
U 6 1 5EAA1FD9
P 5250 1500
F 0 "U1" H 5445 1615 50  0000 C CNN
F 1 "74LS05" H 5440 1375 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_LongPads" H 5250 1500 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74ls05" H 5250 1500 50  0001 C CNN
F 4 "296-1631-5-ND" H 5250 1500 60  0001 C CNN "DigiKey PN"
F 5 "1.45" H 5250 1500 60  0001 C CNN "Price"
	6    5250 1500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR041
U 1 1 5EAA2135
P 4700 1600
F 0 "#PWR041" H 4700 1350 50  0001 C CNN
F 1 "GND" H 4700 1450 50  0000 C CNN
F 2 "" H 4700 1600 50  0000 C CNN
F 3 "" H 4700 1600 50  0000 C CNN
	1    4700 1600
	1    0    0    -1  
$EndComp
Wire Wire Line
	4700 1600 4700 700 
Wire Wire Line
	4700 700  4800 700 
Wire Wire Line
	4800 1100 4700 1100
Connection ~ 4700 1100
Wire Wire Line
	4800 1500 4700 1500
Connection ~ 4700 1500
NoConn ~ 5700 1500
NoConn ~ 5700 1100
NoConn ~ 5700 700 
$Comp
L BARREL_JACK CON1
U 1 1 5EABBA20
P 9100 5300
F 0 "CON1" H 9100 5550 50  0000 C CNN
F 1 "Power" H 9100 5100 50  0000 C CNN
F 2 "Connectors:BARREL_JACK" H 9100 5300 50  0001 C CNN
F 3 "http://www.tensility.com/pdffiles/54-00166.pdf" H 9100 5300 50  0001 C CNN
F 4 "839-54-00166-ND" H 9100 5300 60  0001 C CNN "DigiKey PN"
F 5 "0.72" H 9100 5300 60  0001 C CNN "Price"
	1    9100 5300
	-1   0    0    -1  
$EndComp
Connection ~ 8550 5400
Wire Wire Line
	8800 5200 8700 5200
Wire Wire Line
	8700 5200 8700 5100
Connection ~ 8550 5100
NoConn ~ 8800 5300
$EndSCHEMATC