# Makefile for DLX simulator
#
#

MACHINE = -DSOLARIS
#DEBUGFLAGS = -DDEBUG
CFLAGS = $(MACHINE) -O3 -g $(DEBUGFLAGS)
CXXFLAGS = $(MACHINE) -O3 -g $(DEBUGFLAGS)

INCS = $(wildcard *.h)
SRCS = $(wildcard *.cc)
OBJS = $(addsuffix .o, $(basename $(wildcard *.cc)))
TARGET = dlxsim

$(TARGET): $(OBJS) Makefile.depend
	g++ -O3 -g $(OBJS) -o dlxsim

Makefile.depend: depend

depend: $(SRCS) $(INCS)
	g++ -MM $(SRCS) > Makefile.depend

clean:
	/bin/rm -f $(OBJS) *~

spotless: clean
	/bin/rm -f Makefile.depend $(TARGET)

tarball: spotless
	cd ..; tar cfX - dlxsim/notar dlxsim | gzip - > dlxsim.tar.gz

include Makefile.depend
