CXX = g++
# change CXXTESTGEN and CXXTESTINCLUDEDIR to appropriate directories.
CXXTESTGEN = cxxtest/cxxtestgen.pl
CXXTESTGENFLAGS = --abort-on-fail --have-eh
CXXTESTINCLUDEDIR = cxxtest

CXXFLAGS = -Wall -I. # -ggdb3 -DDEBUG

LIBRARY = munkres
PROGRAM = demo

SOURCES_DEMO = main.cpp
OBJECTS_DEMO := $(patsubst %.cpp,%.o,$(SOURCES_DEMO))

SOURCES = munkres.cpp
OBJECTS := $(patsubst %.cpp,%.o,$(SOURCES))
HEADERS := munkres.h matrix.h
UNITTESTS = unittests/singlesolution.h unittests/validsolution.h

# implementation

.SUFFIXES:      .o .cpp

.cpp.o : $(HEADERS)
	$(CXX) $(CXXFLAGS) -c  -o $@ $<

all:	$(PROGRAM) $(LIBRARY)

$(LIBRARY): $(OBJECTS) $(HEADERS)
	$(CXX) -shared -o libmunkres.so $(OBJECTS)
	ar rv libmunkres.a $(OBJECTS)

$(PROGRAM): $(OBJECTS_DEMO) $(LIBRARY)
	$(CXX) -o $(PROGRAM) $(OBJECTS_DEMO) -lmunkres -L.

test:	testsuite
	@echo "Running test suite."
	@./testsuite

testsuite: testsuite.cpp $(LIBRARY)
	$(CXX) -I$(CXXTESTINCLUDEDIR) $(CXXFLAGS) -o $@ $^ -lmunkres

testsuite.cpp:	$(UNITTESTS)
	$(CXXTESTGEN) $(CXXTESTGENFLAGS) -o $@ --error-printer $^

clean:
	rm -f $(PROGRAM)
	rm -f $(OBJECTS)
	rm -f $(OBJECTS_DEMO)
	rm -f libmunkres.so
	rm -f libmunkres.a
	rm -f testsuite
	rm -f testsuite.cpp

install: $(LIBRARY)
	install -d $(DESTDIR)/usr/lib $(DESTDIR)/usr/include $(DESTDIR)/usr/lib/pkgconfig $(DESTDIR)/usr/share/pkgconfig
	install libmunkres.so $(DESTDIR)/usr/lib
	install libmunkres.a $(DESTDIR)/usr/lib
	install matrix.cpp $(DESTDIR)/usr/include
	install matrix.h $(DESTDIR)/usr/include
	install munkres.h $(DESTDIR)/usr/include
	install munkres.pc $(DESTDIR)/usr/lib/pkgconfig
	install munkres.pc $(DESTDIR)/usr/share/pkgconfig
	install libmunkres.la $(DESTDIR)/usr/lib
