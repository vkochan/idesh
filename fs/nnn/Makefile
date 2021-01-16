NNN_SCRIPTS = main gocwd fzy-cd

.PHONY: all install

all:
	@

install:
	$(foreach s,$(NNN_SCRIPTS), \
		$(INSTALL) -Dm 0755 $(s) $(IDESH_PATH)/fs/nnn/$(s);)
