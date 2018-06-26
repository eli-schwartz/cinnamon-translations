DIRS := $(patsubst po-export/%/,%,$(wildcard po-export/*/))
POFILES := $(wildcard po-export/*/*.po)

all: $(POFILES:po=mo)

install: all
	for dir in $(DIRS); do \
	    for file in po-export/$$dir/$$dir-*.mo; do \
	        lang=$${file##*/$$dir-}; \
	        lang=$${lang%.mo}; \
	        install -Dm644 $$file "$(DESTDIR)/usr/share/locale/$$lang/LC_MESSAGES/$$dir.mo"; \
	    done; \
	done

%.mo: %.po
	msgfmt -o $@ $<

clean:
	rm -rf po-export/*/*.mo
