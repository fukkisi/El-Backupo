El-Backupo
==============
What is this and does this do ?
--------------
This is a bash script i wrote to backup my entire MySQL database and some files, zip them with a password, sync it to my google drive and e-mail me the logs once its done.


Install Grive
--------------
wget http://www.lbreda.com/grive/_media/packages/grive_0.1.1_20120619git27g55c0f4e-1_amd64.deb


dpkg --install grive_0.1.1_20120619git27g55c0f4e-1_amd64.deb


Make the folders
--------------
mkdir /mnt/GoogleDrive


mkdir /mnt/Local


mkdir /mnt/Local/logs

Setup Grive
--------------
cd /mnt/GoogleDrive

grive -a


Setup backup.sh to your liking.
-------------
Set $FOLDER1 for file backups.

Set PASSWORD=PASSWORD for the zip password

If you have mail setup set EMAIL="EMAIL" to the reciepent adress.

Setup daily backups
--------------
Drop the files in your home folder and chmod +x them.

Add run_backup.sh to your crontab

0 7 * * * /home/user/run_backup.sh
