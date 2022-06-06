#!/bin/bash
#---------------------------------------------------------------------
# HOSPEDADO POR @GATESCCN 
#----------------------------------------------------------------------
clear
crz=$(echo -e "\033[1;31m           @GATESCCN\033[1;32m")
echo """              $crz             
 _____ _____ _____ _____ _         
|   __|   __|  |  |  _  | |_ _ ___ 
|__   |__   |     |   __| | | |_ -|
|_____|_____|__|__|__|  |_|___|___|
                      """
echo -e "\033[1;33mESTE SCRIPT RESTAURA LA BASE DE DATOS\n(BACKUP) DE PANEL !\033[0m" 
echo -e "\n\033[1;33mEL PANEL INSTALADO Y EL\nARCHIVO NECESARIO (\033[1;32msshplus.sql\033[1;33m)  DIRETORIO ROOT !\033[0m\n" 
echo -ne "\033[1;32mEnter para continuar...\033[0m"; read

[[ ! -e /var/www/html/pages/system/pass.php ]] && {
	echo -e "\n\033[1;31m PAINEL NO ESTA INSTALADO !\033[0m"; exit 0
}

[[ ! -e $HOME/sshplus.sql ]] && {
	echo -e "\n\033[1;31mARQUIVO (\033[1;32msshplus.sql\033[1;31m) NAO ENCONTRADO !\033[0m"; exit 0
}

passdb=$(cut -d"'" -f2 /var/www/html/pages/system/pass.php)
[[ $(mysql -h localhost -u root -p$passdb -e "show databases" | grep -wc sshplus) == '0' ]] && {
	echo -e "\n\033[1;31mSU PAINEL NO ÉS COMPATIBLE !\033[0m"; exit 0
}

mysql -h localhost -u root -p$passdb -e "drop database sshplus"
mysql -h localhost -u root -p$passdb -e 'CREATE DATABASE sshplus'
mysql -h localhost -u root -p$passdb --default_character_set utf8 sshplus < sshplus.sql
echo -e "\n\033[1;32mBACKUP RESTAURADO !\033[0m"
