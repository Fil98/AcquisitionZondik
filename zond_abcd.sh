#!/bin/bash
mypath=/usr/meteo/konst
cmb="cmb -v"

cd /usr/meteo/konst 

$cmb USRS13RUMS >> zond_A 
$cmb UKRS13RUMS >> zond_B

cat zond_B >> zond_A

$cmb USRA15RUAA >> zond_C 
$cmb UKRA15RUAA >> zond_D 

cat zond_D >> zond_C
cat zond_C >> zond_A

$cmb USRA16RUNW >> zond_E   
$cmb UKRA16RUNW >> zond_F 

cat zond_F >> zond_E
cat zond_E >> zond_A

$cmb ULRS13RUMS >> zond_G
$cmb UERS13RUMS >> zond_H    

cat zond_H >> zond_G  

$cmb ULRA15RUAA >> zond_I  
$cmb UERA15RUAA >> zond_K  

cat zond_K >> zond_I
cat zond_I >> zond_G

$cmb ULRA16RUNW >> zond_L
$cmb UERA16RUNW >> zond_M 

cat zond_M >> zond_L
cat zond_L >> zond_G
cat zond_G >> zond_A

tr -d "[\001\003\015]" < zond_A > zond_N
grep -v '[*U]' zond_N > zond_O
grep '[A-Z0-9^0-9]' zond_O > zond_P
grep -v '^...$' zond_P > zond_R
#mail -s `date +%d%m` sbor@arh.mecom.ru < zond_R
#mail -s `date +%d%m` aero@arh.mecom.ru < zond_R
#cp zond_R /usr/meteo/aero/`date +%d`
rm $mypath/zond_A
rm $mypath/zond_B
rm $mypath/zond_C
rm $mypath/zond_D
rm $mypath/zond_E
rm $mypath/zond_F
rm $mypath/zond_G
rm $mypath/zond_H
rm $mypath/zond_I
rm $mypath/zond_K
rm $mypath/zond_L:
rm $mypath/zond_M
rm $mypath/zond_N
rm $mypath/zond_O
rm $mypath/zond_P
rm $mypath/zond_R
