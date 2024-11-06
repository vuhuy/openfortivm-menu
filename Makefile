VERSION		:= 1.0.0

PREFIX		?=

BIN_FILES	:= vpn-menu

SCRIPTS		:= $(BIN_FILES)

FULL_VERSION	:= $(VERSION)


DESC="Openfortivm configuration scripts"
WWW="https://github.com/vuhuy/openfortivm-conf"


SED		:= sed

SED_REPLACE	:= -e 's:@VERSION@:$(FULL_VERSION):g' \
			-e 's:@PREFIX@:$(PREFIX):g' \

.SUFFIXES:	.sh.in .in
%.sh: %.sh.in
	${SED} ${SED_REPLACE} ${SED_EXTRA} $< > $@

%: %.in
	${SED} ${SED_REPLACE} ${SED_EXTRA} $< > $@ && chmod +x $@

.PHONY:	all apk clean install uninstall
all:	$(SCRIPTS)

apk:	$(APKF)

install: $(BIN_FILES)
	install -m 755 -d $(DESTDIR)/$(PREFIX)/bin
	install -m 755 $(BIN_FILES) $(DESTDIR)$(PREFIX)/bin

uninstall:
	for i in $(BIN_FILES); do \
		rm -f "$(DESTDIR)/$(PREFIX)/bin/$$i";\
	done

clean:
	rm -rf $(SCRIPTS)
