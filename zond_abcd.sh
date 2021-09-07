#!/bin/bash

#Формирование зондов
#Description: Формирование зондов
#Ilya Filimonov (c) 2021
#admin.cks@sevmeteo.ru
#filimonov@arh.mecom.ru


#$date=`date "+%d%m%y"`
path1=/home/meteo/data/printed/"$(date "+%d%m%y")"
path=/home/meteo/zond
zond=/home/meteo/zond/zond_R
cd $path1
grep --null -l -i "USRS13 RUMS" * | xargs -0 cat > $path/zond_A
grep --null -l -i "UKRS13 RUMS" * | xargs -0 cat > $path/zond_B
cat $path/zond_B >> $path/zond_A
grep --null -l -i "USRA15 RUAA" * | xargs -0 cat > $path/zond_C
grep --null -l -i "UKRA15 RUAA" * | xargs -0 cat > $path/zond_D
cat $path/zond_D >> $path/zond_C
cat $path/zond_C >> $path/zond_A
grep --null -l -i "USRA16 RUNW" * | xargs -0 cat > $path/zond_E
grep --null -l -i "UKRA16 RUNW" * | xargs -0 cat > $path/zond_F
cat $path/zond_F >> $path/zond_E
cat $path/zond_E >> $path/zond_A
grep --null -l -i "ULRS13 RUMS" * | xargs -0 cat > $path/zond_G
grep --null -l -i "UERS13 RUMS" * | xargs -0 cat > $path/zond_H
cat $path/zond_H >> $path/zond_G
grep --null -l -i "ULRA15 RUAA" * | xargs -0 cat > $path/zond_I
grep --null -l -i "UERA15 RUAA" * | xargs -0 cat > $path/zond_K
cat $path/zond_K >> $path/zond_I
cat $path/zond_I >> $path/zond_G
grep --null -l -i "ULRA16 RUNW" * | xargs -0 cat > $path/zond_L
grep --null -l -i "UERA16 RUNW" * | xargs -0 cat > $path/zond_M
cat $path/zond_M >> $path/zond_L
cat $path/zond_L >> $path/zond_G
cat $path/zond_G >> $path/zond_A
cd $path
tr -d "[\001\003\015]" < zond_A > zond_N
grep -v '[*U]' zond_N > zond_O
grep '[A-Z0-9^0-9]' zond_O > zond_P
grep -v '^...$' zond_P > zond_R
#sed -i '/NNNN/ d' $zond
#sed -i '/USRS13/ d' $zond
#sed -i '/UKRS13/ d' $zond
#sed -i '/USRA15/ d' $zond
#sed -i '/UKRA15/ d' $zond
#sed -i '/USRA16/ d' $zond
#sed -i '/ULRS13/ d' $zond
#sed -i '/UERS13/ d' $zond
#sed -i '/USRA15/ d' $zond
#sed -i '/ULRA15/ d' $zond
#sed -i '/UERA15/ d' $zond
#sed -i '/ULRA16/ d' $zond
#sed -i '/UERA16/ d' $zond
sed -i '/NNNNZCZC/ d' $zond
sed -i '/ZCZC/ d' $zond
sed -i '/NNNN/ d' $zond
#mail -s `date +%d%m` aero@arh.mecom.ru < zond_R
#mail -s `date +%d%m` sbor@arh.mecom.ru < zond_R
cp zond_R /usr/meteo/aero/`date +%d`
#sed -i '/^$/d' $zond
rm -rf $path/zond_*
