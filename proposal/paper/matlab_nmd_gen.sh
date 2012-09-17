#!/bin/sh 
#NUMSEEDS= '20'
i="1"
while [ $i -le 10 ]
do

sed -e "s/iseed =.*;/iseed = $i;/g" -e "s:str_main=strcat.*$:str_main=strcat('`pwd`/');:g" -e "s/for ikpt = 1:NUM_KPTS/for ikpt = 1:((NUM_KPTS)\/4)/g" NMD_LAMMPS_CONV_1.m > NMD_LAMMPS_1_$i.m

sed -e "s/iseed =.*;/iseed = $i;/g" -e "s:str_main=strcat.*$:str_main=strcat('`pwd`/');:g" -e "s/for ikpt = 1:NUM_KPTS/for ikpt = (((NUM_KPTS)\/4)+1):(NUM_KPTS\/2)/g" NMD_LAMMPS_CONV_1.m > NMD_LAMMPS_2_$i.m

sed -e "s/iseed =.*;/iseed = $i;/g" -e "s:str_main=strcat.*$:str_main=strcat('`pwd`/');:g" -e "s/for ikpt = 1:NUM_KPTS/for ikpt = (((NUM_KPTS)\/2)+1):(3*(NUM_KPTS)\/4)/g" NMD_LAMMPS_CONV_1.m > NMD_LAMMPS_3_$i.m

sed -e "s/iseed =.*;/iseed = $i;/g" -e "s:str_main=strcat.*$:str_main=strcat('`pwd`/');:g" -e "s/for ikpt = 1:NUM_KPTS/for ikpt = ((3*(NUM_KPTS)\/4)+1):NUM_KPTS/g" NMD_LAMMPS_CONV_1.m > NMD_LAMMPS_4_$i.m

sed -e "s/NMD_LAMMPS_CONV.*/NMD_LAMMPS_1_$i.m/g" -e "s:RUNPATH=.*$:RUNPATH=`pwd`/:g" -e "s/#PBS -N NMD.*/#PBS -N NMD_1_$i/g" matlab_nmd_sample.sh > matlab_nmd_1_$i.sh

sed -e "s/NMD_LAMMPS_CONV.*/NMD_LAMMPS_2_$i.m/g" -e "s:RUNPATH=.*$:RUNPATH=`pwd`/:g" -e "s/#PBS -N NMD.*/#PBS -N NMD_2_$i/g" matlab_nmd_sample.sh > matlab_nmd_2_$i.sh

sed -e "s/NMD_LAMMPS_CONV.*/NMD_LAMMPS_3_$i.m/g" -e "s:RUNPATH=.*$:RUNPATH=`pwd`/:g" -e "s/#PBS -N NMD.*/#PBS -N NMD_3_$i/g" matlab_nmd_sample.sh > matlab_nmd_3_$i.sh

sed -e "s/NMD_LAMMPS_CONV.*/NMD_LAMMPS_4_$i.m/g" -e "s:RUNPATH=.*$:RUNPATH=`pwd`/:g" -e "s/#PBS -N NMD.*/#PBS -N NMD_4_$i/g" matlab_nmd_sample.sh > matlab_nmd_4_$i.sh

chmod 755 matlab_nmd_1_$i.sh
chmod 755 matlab_nmd_2_$i.sh
chmod 755 matlab_nmd_3_$i.sh
chmod 755 matlab_nmd_4_$i.sh

qsub matlab_nmd_1_$i.sh
qsub matlab_nmd_2_$i.sh
qsub matlab_nmd_3_$i.sh
qsub matlab_nmd_4_$i.sh

i=$(( $i + 1 ))

done
