#
# Makefile for the dlx MD.
#

PREFIX=/afs/umbc.edu/users/e/t/etmiller/pub/dlx
GCCVER=2.7.2.3
GCCDLXVER=1.4
#
# Use an ansi C compiler, gcc is not specifically required.
CC=gcc
SHELL=/bin/sh
OPT=-O3
CFLAGS=$(OPT) -DPREFIX=\"$(PREFIX)\"

DIST=dlx/README dlx/COPYING dlx/dlx.h dlx/dlx.md dlx/dlx.c \
     dlx/dlx-ld.c dlx/sym.c dlx/sym.h dlx/globals.h dlx/lexer.l \
     dlx/parser.y dlx/dlx-as.c \
     dlx/crt0.s dlx/libtraps dlx/dlx_include \
     dlx/config.sub.diff dlx/configure.diff dlx/Makefile dlx/t-dlx \
     dlx/xm-dlx.h

BIN=$(PREFIX)/bin
LIB=$(PREFIX)/lib/gcc-lib/dlx/$(GCCVER)
LDOBJS=y.tab.o sym.o dlx-ld.o
TOOLS=dlx-as dlx-ld ranlib crt0.o libtraps.a
LIBTRAPS=bcopy.o trap_close.o trap_open.o trap_read.o bzero.o \
         trap_exit.o trap_printf.o trap_srandom.o \
         trap_random.o trap_write.o trap_lseek.o

all:	compiler tools

tools:	$(TOOLS)

dlx-as:	dlx-as.c
	$(CC) $(CFLAGS) -o dlx-as dlx-as.c

dlx-ld: $(LDOBJS)
	$(CC) $(CFLAGS) -o $@ $(LDOBJS) -lfl

ranlib:	dlx-ld
	-rm -f ranlib
	ln -s dlx-ld ranlib

y.tab.c: parser.y
	yacc parser.y

lex.yy.c: lexer.l
	lex lexer.l

crt0.o:	crt0.s
	cp crt0.s crt0.o

libtraps.a: dlx-ld ranlib
	cd libtraps; ar cq ../libtraps.a $(LIBTRAPS)
	./ranlib libtraps.a

clean:
	/bin/rm -f *.o y.tab.c lex.yy.c *~

distclean: clean
	/bin/rm -f $(TOOLS)
	cd ../..; make distclean

dist:
	cd ..; tar cf dlx_gcc_md$(GCCDLXVER).tar $(DIST)

compiler:	../../xgcc ../../cc1 ../../cpp

../../xgcc:	../../config.status dlx.h
	cd ../..; make CC=$(CC) CFLAGS=$(OPT) xgcc

../../cc1:	../../config.status dlx.c dlx.h dlx.md
	cd ../..; make CC=$(CC) CFLAGS=$(OPT) cc1

../../cpp:	../../config.status dlx.h
	cd ../..; make CC=$(CC) CFLAGS=$(OPT) cpp

#
# Make prefix and local prefix be the same because we don't 
# want anything out of /usr/local.
#
../../config.status:	../../config.sub ../../configure
	cd ../.. ; \
	./configure --target=dlx --prefix=$(PREFIX) ; \
	sed -e 's,tooldir = \$$(exec_prefix)/\$$(target),tooldir = \$$(exec_prefix),' < Makefile > Makefile.out ; \
	mv Makefile.out Makefile


../../config.sub:	config.sub.diff
	-grep dlx ../../config.sub > /dev/null ; 		\
	if [ $$? = 1 ]; 					\
	then cd ../..; patch config.sub < config/dlx/config.sub.diff ;	\
	else touch ../../config.sub ; fi

../../configure:	configure.diff
	-grep dlx ../../configure > /dev/null ; 			\
	if [ $$? = 1 ]; 					\
	then cd ../..; patch configure < config/dlx/configure.diff ;	\
	else touch ../../configure ; fi

install:	all
	@x=$(LIB) ; y= ;					\
	while [ ".$$x" != "." ]; 				\
	do next=`echo $$x | sed -e 's@\(/[^/]*\)/.*@\1@'` ; 	\
	   y=$$y$$next ; 					\
	   x=`echo $$x | sed -e 's@^/[^/]*$$@@'` ; 		\
	   x=`echo $$x | sed -e 's@^/[^/]*/@/@'` ; 		\
	   if [ ! -d $$y ] ; 					\
	   then echo mkdir $$y ;				\
		mkdir $$y ; 					\
	        if [ $$? != 0 ]; then exit 1; fi; 		\
	        chmod 755 $$y ;					\
	   fi ; 						\
	done ; 							\
	if [ ! -d $(BIN) ]; then echo mkdir $(BIN) ; mkdir $(BIN) ; fi
	if [ ! -d $(LIB)/include ]; then echo mkdir $(LIB)/include ; \
				         mkdir $(LIB)/include ; fi
	cp crt0.o $(LIB)
	cp dlx_include/* $(LIB)/include
	cp dlx-ld $(LIB)/ld
	cp dlx-as $(LIB)/as
	cp libtraps.a ../../cc1 ../../cpp $(LIB)
	cp ../../xgcc $(BIN)/gcc-dlx
	cp dlx-ld $(BIN)/ranlib
	chmod 755 $(BIN)/gcc-dlx $(LIB)/cc1 $(LIB)/cpp $(LIB)/as $(LIB)/ld
	chmod 644 $(LIB)/crt0.o $(LIB)/include/math-dlx.h

# DO NOT DELETE THIS LINE -- make depend depends on it.

dlx-ld.o: globals.h sym.h
globals.o: sym.h
sym.o: globals.h sym.h
y.tab.o: globals.h sym.h
y.tab.o: lex.yy.c
