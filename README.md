# dirvish
## TODO here
* create Makefile

## TODO Kind
* put dirvish-status in /usr/bin/dirvish-status 
* make sure /etc/cron.d/dirvish has an entry for /usr/bin/dirvish-du 

### entry in `/etc/cron.d/dirvish`
```
# /etc/cron.d/dirvish: crontab fragment for dirvish

# run every night
4 22 * * *     root	/etc/dirvish/dirvish-cronjob
4 23 * * *     root	/usr/bin/dirvish-du
```
