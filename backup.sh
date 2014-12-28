#!/bin/bash
LOGENABLED=1
function log_message {
if [ "$LOGENABLED" -ne 0 ]; then
      echo $1
fi
}
    SYSNAME=`hostname`
    USER=`cat /etc/mysql/debian.cnf | grep -m1 user | awk '{print $3}'`
    PASS=`cat /etc/mysql/debian.cnf | grep -m1 pass | awk '{print $3}'`
    TODAY=$(date +%d-%m-%Y)
    SQLNAME="${SYSNAME}_SQL_${TODAY}.zip"
    FILENAME="${SYSNAME}_files_$TODAY.zip"
    HOME="/home/user"
    WWW="/usr/share/nginx/www"
    BOTS="/opt/bin/"
    GRIVEROOT="/mnt/GoogleDrive"
    LOCAL="/mnt/Local"
    LOGS="$LOCAL/logs"
    GRIVEBACKUP="$GRIVEROOT/${SYSNAME}_backup"
    PASSWORD=PASSWORD
    EMAIL="EMAIL"
GRIVEENABLED=1

log_message "#####################################"
log_message "#REMOVING BACKUPS OLDER THEN 14 DAYS#"
log_message "#####################################"

find $GRIVEBACKUP/* -mtime +14 -exec rm {} \;

cd $LOCAL

log_message "############"
log_message "#SQL BACKUP#"
log_message "############"

DATABASES=`mysql -u $USER -p$PASS -Bse 'show databases'`
   for DB in $DATABASES; do

        if [ "$DB" == "information_schema" -o "$DB" == "performance_schema" -o "$DB" == "mysql" ]; then
            continue
        fi

        SQLFILE="$DB"_$TODAY.sql
log_message "Dumping and Compressing $DB"
    mysqldump -u $USER -p$PASS $DB > $SQLFILE
    zip -rP $PASSWORD $SQLNAME $SQLFILE >/dev/null
log_message "Compression finished; removing original $DB.sql"
    rm $SQLFILE
    done

log_message "#############"
log_message "#FILE BACKUP#"
log_message "#############"

log_message "Compressing $FILES to $FILENAME"
    zip -rP $PASSWORD $FILENAME $HOME $WWW
log_message "Moving $LOCAL/$FILENAME to $GRIVEBACKUP/$FILENAME"
    mv $LOCAL/$FILENAME $GRIVEBACKUP/$FILENAME
log_message "Moving $LOCAL/$SQLNAME to $GRIVEBACKUP/$SQLNAME"
    mv $LOCAL/$SQLNAME $GRIVEBACKUP/$SQLNAME


    if [ "$GRIVEENABLED" -ne 0 ]; then
     log_message "###############"
     log_message "#SYNC TO DRIVE#"
     log_message "###############"
            cd $GRIVEROOT
            grive -l $LOGS/${SYSNAME}_grive_$TODAY.txt
    fi

log_message "##############"
log_message "#MERGING LOGS#"
log_message "##############"
cat $LOGS/${SYSNAME}_bash_$TODAY.txt $LOGS/${SYSNAME}_grive_$TODAY.txt > $LOGS/${SYSNAME}_full_log_$TODAY.txt
rm $LOGS/${SYSNAME}_bash_$TODAY.txt
rm $LOGS/${SYSNAME}_grive_$TODAY.txt

log_message "################"
log_message "#SENDING E-MAIL#"
log_message "################"
mail -s "${SYSNAME} Google Drive Backup" $EMAIL < $LOGS/${SYSNAME}_full_log_$TODAY.txt
