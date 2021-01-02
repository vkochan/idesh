DVTM_SCRIPTS = main fzy-open main open setcwd

.PHONY: all

all:
	@

install:
	$(foreach s,$(DVTM_SCRIPTS), \
		$(INSTALL) -Dm 0755 $(s) $(IDESH_PATH)/wm/dvtm/$(s);)
