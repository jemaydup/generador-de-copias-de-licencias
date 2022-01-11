#!/bin/bash
#source ./mod.sh
# /home/u549896/get_lic/data/2021123123/plpicestapp57/license.dat
# /home/u549896/get_lic/data/2021123123/plpicestapp58/license.dat
# /home/u549896/get_lic/data/2021123123/plpicpacapp66/license.dat
# /home/u549896/get_lic/data/2021123123/plpicpacapp67/license.dat
# Funcion get_lic permite obtener la licencia de una aplicacion
init_folder
set_site $1
get_lic
cd $DataExec

echo -e $(date +'%Y-%m-%d--%H%M%S') "# comprimiendo resultado" >> $PWD/log/$dia.log
#tar  -zcvf ./license$dia.tgz ./
echo -e $(date +'%Y-%m-%d--%H%M%S') "# esperando 5 segundos" >> $PWD/log/$dia.log
sleep 5
mv *.tgz $PWD/bkp/
#rm -R $DataExec
#unset ListaPic
echo fim
