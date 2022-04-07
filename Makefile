#!/bin/make -f

prefix = /usr/local/bin

install:
	mkdir -p $(DESTDIR)$(prefix)
	install -D scripts/dirvish-* $(DESTDIR)$(prefix)
	install -D cron/dirvish $(DESTDIR)/etc/cron.d

.PHONY: install
