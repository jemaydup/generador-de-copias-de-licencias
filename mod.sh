#!/bin/bash
init_folder () 
{
validar_folder bkp
validar_folder log
validar_folder data
}

validar_folder () {
if [ -d ./$1 ]; then
{
echo "la carpeta $1 existe" >> $PWD/INIT-$dia.log
}
else
{
mkdir ./$1
}
fi
}



set_site(){
case "${1}" in
    'full' | 'FULL' | 'Full')
        #Todo
        echo "trayendo todos los archivos de licencia" >> $PWD/log/$dia.log
      	export ListaPic=plpicpacapp66,plpicpacapp67,plpicestapp57,plpicestapp58
        ;;
    'pacheco' | 'PACECHO'|'Pacheco')
        echo "trayendo los archivos de licencia de Pacheco" >> $PWD/log/$dia.log
        export ListaPic=plpicpacapp66,plpicpacapp67
        ##Pacheco
        ;;
    'Estomba' | 'estomba' | 'ESTOMBA')
        echo "trayendo los archivos de licencia de Estomba" >> $PWD/log/$dia.log
        export ListaPic=plpicestapp57,plpicestapp58
        ##Estomba
        ;;
    *)
      	echo "Error de parametro, se espera 'full' | 'FULL' | 'Full' para todolos archivos de licencias" >> $PWD/log/$dia.log
        echo "                              'pacheco' | 'PACECHO'|'Pacheco' para pacheco" >> $PWD/log/$dia.log
        echo "                              'Estomba | estomba | ESTOMBA' para estomba." >> $PWD/log/$dia.log
        echo "Error de parametro, se espera 'full' | 'FULL' | 'Full' para todolos archivos de licencias" 
        echo "                              'pacheco' | 'PACECHO'|'Pacheco' para pacheco" 
        echo "                              'Estomba | estomba | ESTOMBA' para estomba."
        ;;
esac
}



get_lic () 
{
Gstart=$(date +%s);
dia=$(date +'%Y%m%d%H%M')
Data=$PWD/data
DataExec=$Data/$dia
if [ -d "$Data" ]; then
{	
     	if [ -d $DataExec ]; then
	        {
            echo -e $(date +'%Y-%m-%d--%H%M%S') "# Existe la Carpeta $DataExec" >> $PWD/log/$dia.log
            cd $DataExec
	        echo -e $(date +'%Y-%m-%d--%H%M%S') "# ingresamos a la Carpeta $DataExec" >> $PWD/log/$dia.log
            }
	    else
	        {
            echo -e $(date +'%Y-%m-%d--%H%M%S') "# creamos la Carpeta $DataExec" >> $PWD/log/$dia.log
	        mkdir $DataExec
    	    # /home/u549896/get_lic/data/2021123123/
            echo -e $(date +'%Y-%m-%d--%H%M%S') "# ingresamos a la Carpeta $DataExec" >> $PWD/log/$dia.log
        	cd $DataExec
            }
        fi
}
else
{
    echo -e $(date +'%Y-%m-%d--%H%M%S') "# creamos la Carpeta $Data" >> $PWD/log/$dia.log
	mkdir $Data
	# /home/u549896/get_lic/data/
    echo -e $(date +'%Y-%m-%d--%H%M%S') "# creamos la Carpeta $DataExec" >> $PWD/log/$dia.log
	mkdir $DataExec
	# /home/u549896/get_lic/data/2021123123/ 
	echo -e $(date +'%Y-%m-%d--%H%M%S') "# ingresamos a la Carpeta $DataExec" >> $PWD/log/$dia.log
	cd $DataExec
}
fi
lic=/opt/genesys/flexlm/license.dat
echo -e $(date +'%Y-%m-%d--%H%M%S') "# seteamos el archivo a traer $lic" >> $PWD/log/$dia.log
echo -e $(date +'%Y-%m-%d--%H%M%S') "# seteamos los equipos a usar: $listaPic" >> $PWD/log/$dia.log
Gstart=$(date +%s)
echo -e $(date +'%Y-%m-%d--%H%M%S') "# seteamos el inicio del timer Global $Gstart" >> $PWD/log/$dia.log
for host in ${Lista//,/ }
    do
        start=$(date +%s)
        echo -e $(date +'%Y-%m-%d--%H%M%S') "# seteamos el inicio del timer $start" >> $PWD/log/$dia.log
        echo -e $(date +'%Y-%m-%d--%H%M%S') "# creamos la Carpeta $host" >> $PWD/log/$dia.log
        mkdir ./$host
        echo -e $(date +'%Y-%m-%d--%H%M%S') "# ingresamos a la Carpeta $host" >> $PWD/log/$dia.log
        cd $host
        echo -e $(date +'%Y-%m-%d--%H%M%S') "# Traemos el Archivo de licencia del $host" >> $PWD/log/$dia.log
	    ##  echo "buscar $host" >> $PWD/log/$dia.log
        /usr/bin/sudo /usr/local/seguridad/bin/fttget $host $lic ./license_$host.dat
        cd ..
        end=$(date +%s) 
        echo -e $(date +'%Y-%m-%d--%H%M%S') "# seteamos el fin del timer $end" >> $PWD/log/$dia.log
        Vtime=$((end-start))
        echo -e $(date +'%Y-%m-%d--%H%M%S') "# Copiado del $host en duracion: $(($Vtime / 3600 )) horas $((($Vtime % 3600) / 60)) minutos $(($Vtime % 60)) segundos #" >> $PWD/log/$dia.log
    done 
Gend=$(date +%s)
GVtime=$((Gend-Gstart)) 
echo -e $(date +'%Y-%m-%d--%H%M%S') "# Copiado a todos los host, Duracion Total: $(($GVtime / 3600 )) horas $((($GVtime % 3600) / 60)) minutos $(($GVtime % 60)) segundos #"  >> $PWD/log/$dia.log
}