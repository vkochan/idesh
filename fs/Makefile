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
	install -Dm 0755 main $(IDESH_PATH)/fs/main

install-$(FS):
	$(MAKE) -C $(FS) install
