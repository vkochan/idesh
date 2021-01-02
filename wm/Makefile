WM = dvtm

.PHONY: all install $(WM) install-$(WM)

all: $(WM)
	@

$(WM):
	$(MAKE) -C $@

install: install-$(WM)
	install -Dm 0755 idesh-wm ${DESTDIR}${PREFIX}/bin/idesh-wm

install-$(WM):
	$(MAKE) -C $(WM) install
