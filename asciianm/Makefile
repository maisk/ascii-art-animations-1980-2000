# asciianm, the text frame player of play.sh. "make" builds it with ncurses if that is installed, else with ANSI
# escape sequences only. "make ansi": without ncurses anyway. Needs only a C compiler and make.
CC = cc
CFLAGS = -O2 -Wall -Wno-format-security
SRC = asciianm.c timer.c ansicontrol.c
HDR = timer.h ansicontrol.h

all: asciianm

asciianm: $(SRC) $(HDR) Makefile
	@if $(CC) $(CFLAGS) -DNCURSES=1 -o $@ $(SRC) -lncurses 2>/dev/null \
	 || $(CC) $(CFLAGS) -DNCURSES=1 -o $@ $(SRC) -lncurses -ltinfo 2>/dev/null; \
	then echo "asciianm: built with ncurses"; \
	else echo "asciianm: no ncurses (package libncurses-dev or ncurses-devel), building for ANSI terminals"; \
	     $(CC) $(CFLAGS) -o $@ $(SRC); fi

ansi:
	$(CC) $(CFLAGS) -o asciianm $(SRC)

clean:
	rm -f asciianm

.PHONY: all ansi clean
