package = jupiter
version = 1.0
tarname = $(package)
distdir = $(tarname)-$(version)
prefix = /usr/local
exec_prefix = $(prefix)
bindir = $(exec_prefix)/bin

export prefix
export exec_prefix
export bindir

all clean check install uninstall jupiter:
	cd src && $(MAKE) $@

dist: $(distdir).tar.gz

$(distdir).tar.gz: $(distdir)
	tar chof - $(distdir) | gzip -9 -c > $@
	rm -rf $(distdir)

$(distdir): FORCE
	mkdir -p $(distdir)/src
	cp Makefile $(distdir)
	cp src/Makefile $(distdir)/src
	cp src/main.c $(distdir)/src

FORCE:
	-rm $(distdir).tar.gz > /dev/null 2>&1
	-rm -rf $(distdir) > /dev/null 2>&1

distcheck: $(distdir).tar.gz
	gzip -cd $(distdir).tar.gz | tar xvf -
	cd $(distdir) && $(MAKE) all
	cd $(distdir) && $(MAKE) check
	cd $(distdir) && $(MAKE) prefix=$${PWD}/_init install
	cd $(distdir) && $(MAKE) prefix=$${PWD}/_init uninstall
	@remaining="`find $${PWD}/$(distdir)/_inst -type f | wc -l`";	\
	if test "$${remaining}" -ne 0; then	\
		echo "*** $${remaining} file(s) remaining in stage directory!";	\
		exit 1;	\
	fi
	cd $(distdir) && $(MAKE) clean
	rm -rf $(distdir)
	@echo "*** Package $(distdir).tar.gz is ready for distribution."

.PHONY: FORCE all clean check dist distcheck install uninstall
