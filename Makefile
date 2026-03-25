# Makefile for nzfs

SRCDIR=/usr/src
OBJDIR=/usr/obj

ZFSPATH=$(OBJDIR)/$(SRCDIR)/amd64.amd64/cddl/sbin/zfs/zfs



all:
	@echo "Usage: make [patch|build]"

patch:
	patch -d "$(SRCDIR)" -s <nzfs-freebsd-15.0.patch

build:
	(cd "$(SRCDIR)" && make -j20 buildworld) && cp "$(ZFSPATH)" nzfs

distclean clean:
	@rm -f nzfs
	@find . \( -name '*~' -or -name '#*' \) -print0 | xargs -0 rm -vf

push: distclean
	git add -A && git commit -a && git push
