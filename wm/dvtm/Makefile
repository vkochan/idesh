DVTM_SCRIPTS = main create fzy-open main open setcwd events title tagname shell

.PHONY: all

all:
	@

install:
	$(foreach s,$(DVTM_SCRIPTS), \
		$(INSTALL) -Dm 0755 $(s) $(IDESH_PATH)/wm/dvtm/$(s);)
