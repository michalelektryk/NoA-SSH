EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 6 11
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text HLabel 8050 3850 2    50   Output ~ 0
out
$Comp
L Connector:AudioJack2_SwitchT J?
U 1 1 616D474E
P 5600 3700
AR Path="/6161DB85/616D474E" Ref="J?"  Part="1" 
AR Path="/616D368E/616D474E" Ref="J8"  Part="1" 
F 0 "J8" H 5421 3633 50  0000 R CNN
F 1 "AudioJack2_SwitchT" H 5421 3724 50  0000 R CNN
F 2 "jacks:thonkiconn" H 5600 3700 50  0001 C CNN
F 3 "~" H 5600 3700 50  0001 C CNN
	1    5600 3700
	1    0    0    1   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 616D4754
P 5900 3900
AR Path="/6161DB85/616D4754" Ref="#PWR?"  Part="1" 
AR Path="/616D368E/616D4754" Ref="#PWR0166"  Part="1" 
F 0 "#PWR0166" H 5900 3650 50  0001 C CNN
F 1 "GND" H 5905 3727 50  0000 C CNN
F 2 "" H 5900 3900 50  0001 C CNN
F 3 "" H 5900 3900 50  0001 C CNN
	1    5900 3900
	1    0    0    -1  
$EndComp
Wire Wire Line
	5800 3800 5900 3800
Wire Wire Line
	5900 3800 5900 3900
$Comp
L Amplifier_Operational:TL072 U12
U 1 1 616D503B
P 7000 3600
F 0 "U12" H 7000 3967 50  0000 C CNN
F 1 "TL072" H 7000 3876 50  0000 C CNN
F 2 "Package_SO:SOIC-8_3.9x4.9mm_P1.27mm" H 7000 3600 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/tl071.pdf" H 7000 3600 50  0001 C CNN
	1    7000 3600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0167
U 1 1 616D8DB7
P 6600 3500
F 0 "#PWR0167" H 6600 3250 50  0001 C CNN
F 1 "GND" V 6605 3372 50  0000 R CNN
F 2 "" H 6600 3500 50  0001 C CNN
F 3 "" H 6600 3500 50  0001 C CNN
	1    6600 3500
	0    1    1    0   
$EndComp
Wire Wire Line
	6600 3500 6700 3500
$Comp
L Device:R R60
U 1 1 616DA4CF
P 6150 3700
F 0 "R60" V 5943 3700 50  0000 C CNN
F 1 "100k" V 6034 3700 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 6080 3700 50  0001 C CNN
F 3 "~" H 6150 3700 50  0001 C CNN
	1    6150 3700
	0    1    1    0   
$EndComp
$Comp
L Device:R R61
U 1 1 616DAAEF
P 7150 4000
F 0 "R61" V 6943 4000 50  0000 C CNN
F 1 "100k" V 7034 4000 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 7080 4000 50  0001 C CNN
F 3 "~" H 7150 4000 50  0001 C CNN
	1    7150 4000
	0    1    1    0   
$EndComp
Wire Wire Line
	7300 3600 7400 3600
Wire Wire Line
	7400 3600 7400 4000
Wire Wire Line
	7400 4000 7300 4000
Wire Wire Line
	7000 4000 6600 4000
Wire Wire Line
	6600 4000 6600 3700
Wire Wire Line
	6600 3700 6700 3700
Wire Wire Line
	6600 3700 6300 3700
Connection ~ 6600 3700
Wire Wire Line
	6000 3700 5800 3700
$Comp
L Device:R_POT RV8
U 1 1 616DBFA4
P 7800 3850
F 0 "RV8" H 7730 3896 50  0000 R CNN
F 1 "gain" H 7730 3805 50  0000 R CNN
F 2 "learning:Potentiometer_Alps_RK09K_Single_Vertical" H 7800 3850 50  0001 C CNN
F 3 "~" H 7800 3850 50  0001 C CNN
	1    7800 3850
	1    0    0    -1  
$EndComp
Wire Wire Line
	7400 3600 7800 3600
Wire Wire Line
	7800 3600 7800 3700
Connection ~ 7400 3600
Wire Wire Line
	8050 3850 7950 3850
$Comp
L power:GND #PWR0168
U 1 1 616DD330
P 7800 4100
F 0 "#PWR0168" H 7800 3850 50  0001 C CNN
F 1 "GND" H 7805 3927 50  0000 C CNN
F 2 "" H 7800 4100 50  0001 C CNN
F 3 "" H 7800 4100 50  0001 C CNN
	1    7800 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	7800 4100 7800 4000
Text HLabel 8050 3600 2    50   Output ~ 0
norm_out
Wire Wire Line
	8050 3600 7800 3600
Connection ~ 7800 3600
$EndSCHEMATC
