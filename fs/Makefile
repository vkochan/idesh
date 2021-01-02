all:
	@

install:
	@
FS = fff

.PHONY: all install $(FS) install-$(FS)

all: $(FS)
	@

$(FS):
	$(MAKE) -C $@

install: install-$(FS)
	install -Dm 0755 idesh-fs ${DESTDIR}${PREFIX}/bin/idesh-fs

install-$(FS):
	$(MAKE) -C $(FS) install
