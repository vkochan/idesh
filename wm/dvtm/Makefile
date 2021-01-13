DVTM_SCRIPTS = main create setmax main open setcwd events title tagname shell

.PHONY: all

all:
	@

install:
	$(INSTALL) -Dm 0755 dvtm-copy $(DESTDIR)/$(PREFIX)/bin/dvtm-copy
	$(INSTALL) -D vim/yank.vim $(IDESH_PATH)/wm/dvtm/vim/yank.vim
	$(foreach s,$(DVTM_SCRIPTS), \
		$(INSTALL) -Dm 0755 $(s) $(IDESH_PATH)/wm/dvtm/$(s);)
