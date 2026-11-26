# make         checks what play.sh needs (pv; xterm for -x), builds asciianm, the player of the text frames (asciianm/),
#              and says what to do about anything missing or any build that fails (also: make check)
# make clean   removes the asciianm program
# See INSTALL.md. Copyright (c) 2026 Kostas Maistrelis. MIT licence: see LICENSE-MIT.

all: check

check:
	@missing=0; \
	if command -v pv >/dev/null 2>&1; then \
	   echo "pv        ok"; \
	else \
	   missing=1; \
	   echo "pv        MISSING: play.sh needs it to play the .vt files at the speed of a serial line."; \
	   echo "          Install it: sudo apt install pv (Debian/Ubuntu), sudo dnf install pv (Fedora), brew install pv (macOS)."; \
	fi; \
	if ! command -v $${CC:-cc} >/dev/null 2>&1 && [ ! -x asciianm/asciianm ]; then \
	   echo "asciianm  not built: no C compiler (optional: the player of the text frames, .txt). Install one:"; \
	   echo "          sudo apt install build-essential libncurses-dev (Debian/Ubuntu), sudo dnf install gcc make ncurses-devel"; \
	   echo "          (Fedora), xcode-select --install (macOS); then: make. Without it, play.sh plays the .vt."; \
	elif out=$$($(MAKE) -s -C asciianm 2>&1); then \
	   if [ -n "$$out" ]; then s="built now"; else s="ok"; fi; \
	   if grep -q -a initscr asciianm/asciianm; then \
	      echo "asciianm  $$s (with ncurses)"; \
	   else \
	      echo "asciianm  $$s, but WITHOUT ncurses: it works, for ANSI terminals; with ncurses only what changes is redrawn."; \
	      echo "          For that: sudo apt install libncurses-dev (Debian/Ubuntu), sudo dnf install ncurses-devel (Fedora),"; \
	      echo "          then: make clean; make"; \
	   fi; \
	else \
	   echo "asciianm  BUILD FAILED (optional: the player of the text frames, .txt; without it play.sh plays the .vt):"; \
	   { echo "$$out" | grep -m 3 'error' || echo "$$out" | tail -n 3; } | sed 's/^ */          /'; \
	   echo "          Try: make -C asciianm ansi (without ncurses), or see INSTALL.md."; \
	fi; \
	if command -v xterm >/dev/null 2>&1; then \
	   echo "xterm     ok"; \
	else \
	   echo "xterm     not found (only for ./play.sh -x): sudo apt install xterm, or XQuartz on macOS"; \
	fi; \
	if [ $$missing = 0 ]; then echo "Ready: ./play.sh chase"; else echo "See INSTALL.md."; exit 1; fi

clean:
	@$(MAKE) -s -C asciianm clean

.PHONY: all check clean
