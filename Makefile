# Makefile for nzfs

OSVER=FreeBSD-15.0

SRCDIR=/usr/src
OBJDIR=/usr/obj
MANDIR=/usr/share/man
BINDIR=/usr/local/sbin

SRCPATH=$(SRCDIR)/sys/contrib/openzfs/cmd/zfs/zfs_main.c
ZFSPATH=$(OBJDIR)/$(SRCDIR)/amd64.amd64/cddl/sbin/zfs/zfs


all:
	@echo "Usage: make [patch|build]"

patch:
	patch -d "$(SRCDIR)" -s <nzfs-$(OSVER).patch

build:	# patch
	(cd "$(SRCDIR)" && make -j20 buildworld) && cp "$(ZFSPATH)" nzfs


install: install-bin install-man

install-bin: build
	cp nzfs $(BINDIR)

install-man:
	cp nzfs-clean.8 nzfs-snapshot.8 $(MANDIR)/man8

distclean clean:
	@rm -f nzfs
	@find . \( -name '*~' -or -name '#*' \) -print0 | xargs -0 rm -vf

push: distclean
	git add -A && git commit -a && git push
