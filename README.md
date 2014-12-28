El-Backupo
==============

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

Setup daily backups
--------------
Drop the files in your home folder and chmod +x them.

Add run_backup.sh to your crontab

0 7 * * * /home/user/run_backup.sh
