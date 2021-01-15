NNN_SCRIPTS = main gocwd fzy-cd apply

.PHONY: all install

all:
	@

install:
	$(foreach s,$(NNN_SCRIPTS), \
		$(INSTALL) -Dm 0755 $(s) $(IDESH_PATH)/fs/nnn/$(s);)
