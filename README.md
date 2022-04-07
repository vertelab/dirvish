# README
## Summary

This is a set of utility scripts used to manage and monitor Dirvish backups
as applicable at Vertel.

## Prerequisites

The script suite is intended to run on a Linux system with Dirvish.

Testing has only been done on Ubuntu systems but since the scripts only use
basic functionalities such as bash, find etc it likely will run on most Unix systems with minor tweaks.

## Installation and Setup

### Setup

The scripts don't need any compilation before install. Executable scripts are expected to be in $PATH.

A cron file (default `/etc/cron.d/dirvish`) determine when dirvish is run.

### Install

Using make run:
```
    make install
```

For testing purposes this might be better:
```
    make install DESTDIR=mybuilddir
```

## Sample usage

Print last backup status:
```
    dirvsh-status
```

Test if the vaults in a bank currently are available from the dirvsh installation:
```
    dirvsh-bank-conntest /srv/backups
```
where `/srv/backups` is a Dirvish bank.
