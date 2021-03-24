#!/bin/bash
################################################################################
#
#   Make a backup of the Bluespice Wiki data/code directory.
#   Simplified from the bluespice_backup.sh script.
#
#   Does the following steps:
#     1. Disables Apache2
#     2. Compress web root and DB dump to backup location
#     3. Enables Apache2
#
################################################################################


if [ $UID -ne 0 ];then
	echo "This script is not run as root. Exiting..."
	exit 1
fi

## Parameters

BACKUPPATH=/var/backups
BACKUPFILE=$BACKUPPATH/bluespice_wiki_backup.tar.gz
WEBPATH=/var/www/bluespice

## Prep
echo "Preparing backup"
echo 'Temporarily disabling the wiki'
service apache2 stop # Main wiki - Ignoring other subservices like Jetty and pm2 for now

## Backup itself
echo 'Performing backup'
echo 'Building backup archive'
tar -zcf $BACKUPFILE $WEBPATH


## Cleanup
echo "Reenabling wiki"
service apache2 start

## End
echo "Script finished"
exit 0 # 0 = success

#echo 'Removing old backups'
#find $BACKUPPATH -mmin +7200 -name 'bluespice_wiki_backup_*.tar.gz' | xargs rm
# ^ Might throw some error if there are no backups to remove. Won't have
# any effect on the script.
