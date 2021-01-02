FFF_SCRIPTS = main fff dvtm/fzy-cd

.PHONY: all install

all:
	@

install:
	$(foreach s,$(FFF_SCRIPTS), \
		$(INSTALL) -Dm 0755 $(s) $(IDESH_PATH)/fs/fff/$(s);)
