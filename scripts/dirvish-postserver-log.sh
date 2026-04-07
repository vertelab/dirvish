#!/bin/bash
set -u

VAULT="$1"
DEFAULT_CONF="/srv/backup/$VAULT/dirvish/default.conf"

# Hämta bank från master.conf
BANK=$(grep '^bank:' /etc/dirvish/master.conf | head -1 | sed 's/^bank:[ \t]*//')

# Hämta client från default.conf
CLIENT=$(sed -n 's/^client:[ \t]*//p' "$DEFAULT_CONF" | head -1)

# Hämta aktuell image (senaste eller current)
IMAGE=$(ls -t /srv/backup/$VAULT | head -1)

ts=$(date '+%F %T')

# Hämta data från summary
start=$(sed -n 's/Backup-begin: //p' /srv/backup/$VAULT/$IMAGE/summary)
end=$(sed -n 's/Backup-complete: //p' /srv/backup/$VAULT/$IMAGE/summary)
status=$(sed -n 's/Status: *\(.*\) */\1/p' /srv/backup/$VAULT/$IMAGE/summary | sed 's/ *$//')


# Beräkna minuter
duration_sec=$(( $(date -d "$end" +%s) - $(date -d "$start" +%s) ))
duration_min=$(( duration_sec / 60 ))

# Resultat: 0=OK, övrigt=FAIL
[ "$status" = "success" ] && result=OK || result=FAIL

ssh $CLIENT "echo \"$ts image=$IMAGE start=$start duration=$duration_min minute(s) status=$status result=$result\" >> /var/log/dirvish.log"
scp /srv/backup/$VAULT/dirvish/du $CLIENT:/var/log/dirvish.du
