#!/bin/bash
# /home/u549896/get_lic/data/2021123123/plpicestapp57/license.dat
# /home/u549896/get_lic/data/2021123123/plpicestapp58/license.dat
# /home/u549896/get_lic/data/2021123123/plpicpacapp66/license.dat
# /home/u549896/get_lic/data/2021123123/plpicpacapp67/license.dat
dia=$(date +'%Y%m%d%H%M')
folder=$PWD
if [ -d ./bkp ]; then
{
echo "la carpeta bkp existe"
}
else
{
mkdir ./bkp
}
fi
if [ -d ./log ]; then
{
echo "la carpeta log existe"
}
else
{
mkdir ./log
}
fi
case "${1}" in
    f|F)    #Todo
	echo "trayendo todos los archivos de licencia" >> $folder/log/$dia.log
	export ListaPic=plpicpacapp66,plpicpacapp67,plpicestapp57,plpicestapp58
	get_lic
	;;
    p|P)
	echo "trayendo los archivos de licencia de Pacheco" >> $folder/log/$dia.log
	export ListaPic=plpicpacapp66,plpicpacapp67
	get_lic
	##Pacheco
	;;
    e|E)
	echo "trayendo los archivos de licencia de Estomba" >> $folder/log/$dia.log
	export ListaPic=plpicestapp57,plpicestapp58
	get_lic
        ##Estomba
	;;
    *)
	echo "Error de parametro, se espera 'F|f' para todolos archivos de licencias" >> $folder/log/$dia.log
	echo "                              'P|p' para pacheco" >> $folder/log/$dia.log
	echo "                              'E|e' para estomba." >> $folder/log/$dia.log
;;
esac
cd $FolderDataExec
echo -e $(date +'%Y-%m-%d--%H%M%S') "# comprimiendo resultado" >> $folder/log/$dia.log
tar  -zcvf ./license$dia.tgz ./
echo -e $(date +'%Y-%m-%d--%H%M%S') "# esperando 5 segundos" >> $folder/log/$dia.log
sleep 5
mv *.tgz $folder/bkp/
rm -R $FolderDataExec
unset ListaPic
echo fin




get_lic () 
{
Gstart=$(date +%s);
dia=$(date +'%Y%m%d%H%M')
folder=$PWD
FolderData=$folder/data
FolderDataExec=$FolderData/$dia
if [ -d "$FolderData" ]; then
     	if [ -d $FolderDataExec ]; then
       	echo -e $(date +'%Y-%m-%d--%H%M%S') "# Existe la Carpeta $FolderDataExec" >> $folder/log/$dia.log
		cd $FolderDataExec
     	echo -e $(date +'%Y-%m-%d--%H%M%S') "# ingresamos a la Carpeta $FolderDataExec" >> $folder/log/$dia.log
	    else
	    echo -e $(date +'%Y-%m-%d--%H%M%S') "# creamos la Carpeta $FolderDataExec" >> $folder/log/$dia.log
		mkdir $FolderDataExec
		# /home/u549896/get_lic/data/2021123123/
        echo -e $(date +'%Y-%m-%d--%H%M%S') "# ingresamos a la Carpeta $FolderDataExec" >> $folder/log/$dia.log
		cd $FolderDataExec
	fi
else
    echo -e $(date +'%Y-%m-%d--%H%M%S') "# creamos la Carpeta $FolderData" >> $folder/log/$dia.log
	mkdir $FolderData
	# /home/u549896/get_lic/data/
   	echo -e $(date +'%Y-%m-%d--%H%M%S') "# creamos la Carpeta $FolderDataExec" >> $folder/log/$dia.log
	mkdir $FolderDataExec
	# /home/u549896/get_lic/data/2021123123/
    echo -e $(date +'%Y-%m-%d--%H%M%S') "# ingresamos a la Carpeta $FolderDataExec" >> $folder/log/$dia.log
	cd $FolderDataExec
fi
	lic=/opt/genesys/flexlm/license.dat
    echo -e $(date +'%Y-%m-%d--%H%M%S') "# seteamos el archivo a traer $lic" >> $folder/log/$dia.log
	echo -e $(date +'%Y-%m-%d--%H%M%S') "# seteamos los equipos a usar: $listaPic" >> $folder/log/$dia.log
	Gstart=$(date +%s)
	echo -e $(date +'%Y-%m-%d--%H%M%S') "# seteamos el inicio del timer Global $Gstart" >> $folder/log/$dia.log
	for host in ${Lista//,/ }
        do
	    start=$(date +%s)
	    echo -e $(date +'%Y-%m-%d--%H%M%S') "# seteamos el inicio del timer $start" >> $folder/log/$dia.log
	    echo -e $(date +'%Y-%m-%d--%H%M%S') "# creamos la Carpeta $host" >> $folder/log/$dia.log
	    mkdir ./$host
	    echo -e $(date +'%Y-%m-%d--%H%M%S') "# ingresamos a la Carpeta $host" >> $folder/log/$dia.log
	    cd $host
	    echo -e $(date +'%Y-%m-%d--%H%M%S') "# Traemos el Archivo de licencia del $host" >> $folder/log/$dia.log
	    ##  echo "buscar $host" >> $folder/log/$dia.log
	    /usr/bin/sudo /usr/local/seguridad/bin/fttget $host $lic ./license_$host.dat
	    cd ..
	    end=$(date +%s) 
	    echo -e $(date +'%Y-%m-%d--%H%M%S') "# seteamos el fin del timer $end" >> $folder/log/$dia.log
	    Vtime=$((end-start))
	    echo -e $(date +'%Y-%m-%d--%H%M%S') "# Copiado del $host en duracion: $(($Vtime / 3600 )) horas $((($Vtime % 3600) / 60)) minutos $(($Vtime % 60)) segundos #" >> $folder/log/$dia.log
        done 
        Gend=$(date +%s)
        GVtime=$((Gend-Gstart)) 
        echo -e $(date +'%Y-%m-%d--%H%M%S') "# Copiado a todos los host, Duracion Total: $(($GVtime / 3600 )) horas $((($GVtime % 3600) / 60)) minutos $(($GVtime % 60)) segundos #"  >> $folder/log/$dia.log
}