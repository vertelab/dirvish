# dirvish
## TODO here
* create Makefile

## Setup
* put file dirvish-status in /usr/bin/dirvish-status 
* put file dirvish-du in /usr/bin/dirvish-du
* put file dirvish in /etc/cron.d/dirvish
* put file dirvish-cronjob in /etc/dirvish/dirvish-cronjob

### entry in `/etc/cron.d/dirvish`
```
# /etc/cron.d/dirvish: crontab fragment for dirvish

# run every night
4 22 * * *     root	/etc/dirvish/dirvish-cronjob
4 23 * * *     root	/usr/bin/dirvish-du
```
