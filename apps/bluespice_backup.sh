#!/bin/bash
################################################################################
#
#   Make a backup of the Bluespice Wiki.
#
#   Does the following steps:
#     1. Disables Apache2
#     2. Makes DB-dump
#     3. Compress web root and DB dump to backup location
#     4. Removes the uncompressed DB dumb
#     5. Enables Apache2
#
################################################################################


if [ $UID -ne 0 ];then
	echo "This script is not run as root. Exiting..."
	exit 1
fi

## Parameters
# DB-information
DBNAME='bluespice'
#DBUSER='bluespice' # Not required if running as root
#DBPWD='REDACTED' # Not required if run as root.

BACKUPPATH=/var/backups
BACKUPFILE=$BACKUPPATH/bluespice_wiki_backup.tar.gz
WEBPATH=/var/www/bluespice
DBDUMPPATH=$WEBPATH/db_dump_$(date --iso-8601).sql

## Prep
echo "Preparing backup"
echo 'Temporarily disabling the wiki'
service apache2 stop # Main wiki - Ignoring other subservices like Jetty and pm2 for now

## Backup itself
echo 'Performing backup'
echo 'Making DB-dump'
mysqldump --lock-tables $DBNAME > $DBDUMPPATH
echo 'Building backup archive'
tar -zcf $BACKUPFILE $WEBPATH
echo 'Removing excess DB dump'
rm $DBDUMPPATH


## Cleanup
echo "Reenabling wiki"
service apache2 start

## End
exit 0 # 0 = success

#echo 'Removing old backups'
#BACKUPFILE=$BACKUPPATH/bluespice_wiki_backup_$(date --iso-8601).tar.gz
#DBDUMPPATH=$WEBPATH/db_dump_$(date --iso-8601).sql
#find $BACKUPPATH -mmin +7200 -name 'bluespice_wiki_backup_*.tar.gz' | xargs rm
# ^ Might throw some error if there are no backups to remove. Won't have
# any effect on the script.
