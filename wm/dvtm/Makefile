DVTM_SCRIPTS = main \
	       copy \
	       create \
	       setmax \
	       main \
	       open \
	       setcwd \
	       getcwd \
	       events \
	       title \
	       tagname \
	       shell

.PHONY: all

all:
	@

install:
	$(INSTALL) -Dm 0755 dvtm-copy $(DESTDIR)/$(PREFIX)/bin/dvtm-copy
	$(foreach s,$(DVTM_SCRIPTS), \
		$(INSTALL) -Dm 0755 $(s) $(IDESH_PATH)/wm/dvtm/$(s);)
