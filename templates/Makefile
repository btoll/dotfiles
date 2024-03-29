CC      	= gcc
CFLAGS    	= -W -Wall
#CPPFLAGS # preprocessor flags
#LDFLAGS
PACKAGE		= simple-chat
prefix		= /usr/local
exec_prefix = ${prefix}
bindir		= $(exec_prefix)/bin

.PHONY: all build check clean dist distcheck distclean install install-strip installcheck uninstall

# The default target.
all: $(PACKAGE)

$(PACKAGE): $(PACKAGE).c
	$(CC) $(CFLAGS) -o $(PACKAGE) $(PACKAGE).c

build: $(PACKAGE)

check:
	echo "run the test suite, if any"

# Erase anything created by `make all`.
clean:
	rm -f $(PACKAGE) *.o

dist:
	echo "recreate package-version.tar.gz from all the source files"

#distcheck:
	# https://www.gnu.org/software/automake/manual/html_node/Preparing-Distributions.html
	# https://www.gnu.org/software/automake/manual/html_node/Checking-the-Distribution.html

# Erase anything created by `./configure`.
distclean: clean

# https://www.gnu.org/software/make/manual/html_node/DESTDIR.html
#
# This target can be thought of as a shorthand for
# `make install-exec install-data`.
# The former are architecture-dependent files and the latter are
# architecture-independent files.
# https://www.gnu.org/software/automake/manual/html_node/Two_002dPart-Install.html
install:
	install -D -m 0755 $(PACKAGE) $(DESTDIR)$(bindir)/$(PACKAGE)

install-strip:
	echo "same as \`make install\` then strip debugging symbols"

installcheck:
	echo "check the installed programs or libraries, if supported"

uninstall:
	-rm -f $(DESTDIR)$(bindir)/$(PACKAGE)

# ---
#
# Common settings can go in a `config.site` file.
# I.e., prefix/share/config.site will define variables in `config.site` for
# ./configure --prefix ~/usr
# https://www.gnu.org/software/automake/manual/html_node/config_002esite.html
#
# VPATH builds are a way to build packages from a read-only medium or directory.
# https://www.gnu.org/software/automake/manual/html_node/VPATH-Builds.html
#
