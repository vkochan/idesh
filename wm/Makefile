WM = dvtm

.PHONY: all install $(WM) install-$(WM)

all: $(WM)
	@

$(WM):
	$(MAKE) -C $@

install: install-$(WM)
	install -Dm 0755 run $(IDESH_PATH)/wm/run
	install -Dm 0755 main $(IDESH_PATH)/wm/main

install-$(WM):
	$(MAKE) -C $(WM) install
