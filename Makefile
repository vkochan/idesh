export IDESH_PATH = $(DESTDIR)/usr/share/idesh
export INSTALL = install

MODULES := wm fs gr
PREFIX ?= /usr

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

install: install-modules
	$(INSTALL) -Dm 0755 idesh $(DESTDIR)$(PREFIX)/bin/idesh
