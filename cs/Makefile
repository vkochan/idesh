CS := cscope

.PHONY: all install $(CS) $(foreach cs,$(CS),install-$(CS))

all: $(CS)
	@

$(CS):
	$(MAKE) -C $@

install: $(foreach cs,$(CS),install-$(cs))
	install -Dm 0755 main $(IDESH_PATH)/cs/main

install-cscope:
	$(MAKE) -C cscope install
