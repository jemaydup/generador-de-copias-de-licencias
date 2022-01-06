#!/bin/bash
echo 11
# /home/u549896/get_lic/data/2021123123/plpicestapp57/license.dat
echo 21
# /home/u549896/get_lic/data/2021123123/plpicestapp58/license.dat
echo 31
# /home/u549896/get_lic/data/2021123123/plpicpacapp66/license.dat
echo 41
# /home/u549896/get_lic/data/2021123123/plpicpacapp67/license.dat
echo 51
dia=$(date +'%Y%m%d%H%M')
echo 61
folder=$PWD
echo 71
function get_lic () 
{
echo 81
Gstart=$(date +%s);
echo 91
dia=$(date +'%Y%m%d%H%M')
echo 101
folder=$PWD
echo 102
FolderData=$folder/data
echo 103
FolderDataExec=$FolderData/$dia
echo 104
if [ -d "$FolderData" ]; then
echo 105
     	if [ -d $FolderDataExec ]; then
        echo 106
	echo -e $(date +'%Y-%m-%d--%H%M%S') "# Existe la Carpeta $FolderDataExec" >> $folder/log/$dia.log
	echo 107
	cd $FolderDataExec
        echo 108
	echo -e $(date +'%Y-%m-%d--%H%M%S') "# ingresamos a la Carpeta $FolderDataExec" >> $folder/log/$dia.log
	echo 109
	else
	echo 1010
        echo -e $(date +'%Y-%m-%d--%H%M%S') "# creamos la Carpeta $FolderDataExec" >> $folder/log/$dia.log
	echo 1011
	mkdir $FolderDataExec
	echo 1012	# /home/u549896/get_lic/data/2021123123/
        echo -e $(date +'%Y-%m-%d--%H%M%S') "# ingresamos a la Carpeta $FolderDataExec" >> $folder/log/$dia.log
	echo 1013
	cd $FolderDataExec
	echo 1014
	fi
echo 1015
else
echo 1016
    echo -e $(date +'%Y-%m-%d--%H%M%S') "# creamos la Carpeta $FolderData" >> $folder/log/$dia.log
    echo 1017
	mkdir $FolderData
	# /home/u549896/get_lic/data/
	echo 1018
    	echo -e $(date +'%Y-%m-%d--%H%M%S') "# creamos la Carpeta $FolderDataExec" >> $folder/log/$dia.log
	echo 1019
	mkdir $FolderDataExec
	# /home/u549896/get_lic/data/2021123123/
	echo 1020    
	echo -e $(date +'%Y-%m-%d--%H%M%S') "# ingresamos a la Carpeta $FolderDataExec" >> $folder/log/$dia.log
	echo 1021
	cd $FolderDataExec
echo 1022
fi
echo 1023
	lic=/opt/genesys/flexlm/license.dat
    	echo 1024
	echo -e $(date +'%Y-%m-%d--%H%M%S') "# seteamos el archivo a traer $lic" >> $folder/log/$dia.log
	echo 1025
    	echo -e $(date +'%Y-%m-%d--%H%M%S') "# seteamos los equipos a usar: $listaPic" >> $folder/log/$dia.log
	echo 1026
    	Gstart=$(date +%s)
	echo 1027
   	echo -e $(date +'%Y-%m-%d--%H%M%S') "# seteamos el inicio del timer Global $Gstart" >> $folder/log/$dia.log
	echo 1028
        for host in ${Lista//,/ }
        do
	echo 1029
            start=$(date +%s)
	echo 1030
            echo -e $(date +'%Y-%m-%d--%H%M%S') "# seteamos el inicio del timer $start" >> $folder/log/$dia.log
	echo 1031
            echo -e $(date +'%Y-%m-%d--%H%M%S') "# creamos la Carpeta $host" >> $folder/log/$dia.log
	echo 1032
            mkdir ./$host
	echo 1033
            echo -e $(date +'%Y-%m-%d--%H%M%S') "# ingresamos a la Carpeta $host" >> $folder/log/$dia.log
	echo 1034
            cd $host
	echo 1035
            echo -e $(date +'%Y-%m-%d--%H%M%S') "# Traemos el Archivo de licencia del $host" >> $folder/log/$dia.log
	      ##  echo "buscar $host" >> $folder/log/$dia.log
	echo 1036
            /usr/bin/sudo /usr/local/seguridad/bin/fttget $host $lic ./license_$host.dat
	echo 1037
            cd ..
	echo 1038
            end=$(date +%s) 
	echo 1039
            echo -e $(date +'%Y-%m-%d--%H%M%S') "# seteamos el fin del timer $end" >> $folder/log/$dia.log
	echo 1040
            Vtime=$((end-start))
	echo 1041
            echo -e $(date +'%Y-%m-%d--%H%M%S') "# Copiado del $host en duracion: $(($Vtime / 3600 )) horas $((($Vtime % 3600) / 60)) minutos $(($Vtime % 60)) segundos #" >> $folder/log/$dia.log
	echo 1042
        done 
	echo 1043
        Gend=$(date +%s)
	echo 1044
        GVtime=$((Gend-Gstart)) 
	echo 1045
        echo -e $(date +'%Y-%m-%d--%H%M%S') "# Copiado a todos los host, Duracion Total: $(($GVtime / 3600 )) horas $((($GVtime % 3600) / 60)) minutos $(($GVtime % 60)) segundos #"  >> $folder/log/$dia.log
	echo 1046
}
echo 1047
if [ -d ./bkp ]; then
{
echo 1048
echo "la carpeta bkp existe"
}
else
{
echo 1049
mkdir ./bkp
}
fi
echo 1050
if [ -d ./log ]; then
{
echo 1051
echo "la carpeta log existe"
}
else
{
echo 1052
mkdir ./log
}
fi
echo 1053
case "${1}" in
    f|F)    #Todo
    echo 1054
	echo "trayendo todos los archivos de licencia" >> $folder/log/$dia.log
      	echo 1055
	export ListaPic=plpicpacapp66,plpicpacapp67,plpicestapp57,plpicestapp58
        echo 1056
	get_lic
        echo 1057
	;;
    p|P)
        echo 1058
	echo "trayendo los archivos de licencia de Pacheco" >> $folder/log/$dia.log
        echo 1059
	export ListaPic=plpicpacapp66,plpicpacapp67
        echo 1060
	get_lic
        echo 1061
	##Pacheco
        echo 1062
	;;
    e|E)
        echo 1063
	echo "trayendo los archivos de licencia de Estomba" >> $folder/log/$dia.log
        echo 1064
	export ListaPic=plpicestapp57,plpicestapp58
        echo 1065
	get_lic
        ##Estomba
	echo 1066
	;;
    *)
      	echo 1067
	echo "Error de parametro, se espera 'F|f' para todolos archivos de licencias" >> $folder/log/$dia.log
        echo 1068
	echo "                              'P|p' para pacheco" >> $folder/log/$dia.log
        echo 1069
	echo "                              'E|e' para estomba." >> $folder/log/$dia.log
	echo 1070 
;;
esac
echo 1071
cd $FolderDataExec
echo 1072
echo -e $(date +'%Y-%m-%d--%H%M%S') "# comprimiendo resultado" >> $folder/log/$dia.log
echo 1073
tar  -zcvf ./license$dia.tgz ./
echo 1074
echo -e $(date +'%Y-%m-%d--%H%M%S') "# esperando 5 segundos" >> $folder/log/$dia.log
echo 1075
sleep 5
echo 1076
mv *.tgz $folder/bkp/
echo 1077
rm -R $FolderDataExec
echo 1078
unset ListaPic
echo 1079
echo fin
