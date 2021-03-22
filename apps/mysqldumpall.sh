#!/bin/bash
################################################################################
#
#   Dump all mysql-databases in the current MySQL installation to DUMPDIR
#
################################################################################

if [ $UID -ne 0 ]; then
	# Require root due to default DUMPDIR
	echo 'This script is expected to be run as root. Exiting...'
	exit 1
fi

## Parameters ------------------------------------------------------------------

# Main params
DUMPDIR='/var/backups'
DUMPPREFIX='db_dump_'
# DB's not dump. The _schema db's don't play well with lock-tables
DBBLACKLIST="performance_schema,information_schema"

## Helpers ---------------------------------------------------------------------
function in_blacklist(){
	echo $DBBLACKLIST | grep -q $1
	return $?
}

## (Optional,Placeholder) Deactivate services using DB on the server -----------

## Actual DB-dumping -----------------------------------------------------------
echo "$(date): Starting database dump"
for dbname in $(sudo mysql  -sNe 'show databases'); do
	if in_blacklist $dbname; then
		echo "Ignoring database: $dbname"
	else
		dbdump=$DUMPDIR/$DUMPPREFIX$dbname.sql
		echo "Dumping database: $dbname to location $dbdump"
		mysqldump --lock-tables $dbname > $dbdump
	fi
done
echo "Dump finished"

## (Optional,Placeholder) Reactivate services using DB server ------------------

## End -------------------------------------------------------------------------
exit 0 # 0 = success

