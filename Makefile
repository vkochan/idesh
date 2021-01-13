export PREFIX ?= /usr/local

export IDESH_PATH = $(DESTDIR)$(PREFIX)/share/idesh
export INSTALL = install

MODULES := wm fs gr mk

.PHONY: all install $(MODULES) install-modules $(foreach m,$(MODULES),install-$(m))

all: $(MODULES)

$(MODULES):
	$(MAKE) -C $@

install-modules: $(foreach m,$(MODULES),install-$(m))
	@

install-fs:
	$(MAKE) -C fs install

install-wm:
	$(MAKE) -C wm install

install-gr:
	$(MAKE) -C gr install

install-mk:
	$(MAKE) -C mk install

install: install-modules
	$(INSTALL) -Dm 0755 idesh $(DESTDIR)$(PREFIX)/bin/idesh
	$(INSTALL) -Dm 0755 idesh-mk $(DESTDIR)$(PREFIX)/bin/idesh-mk
