FS := fff nnn

.PHONY: all install $(FS) $(foreach fs,$(FS),install-$(FS))

all: $(FS)
	@

$(FS):
	$(MAKE) -C $@

install: $(foreach fs,$(FS),install-$(fs))
	install -Dm 0755 main $(IDESH_PATH)/fs/main

install-fff:
	$(MAKE) -C fff install

install-nnn:
	$(MAKE) -C nnn install
