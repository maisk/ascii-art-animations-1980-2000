# asciianm

The C program with which `../play.sh` plays the `.txt` files of this repository: text frames, with the time between them.
By Kostas Maistrelis (1998–2003), version 2, in four C files. **GNU GPL, version 2** ([COPYING](COPYING)), unlike the rest of
the repository.

```sh
make            # in this folder; gives ./asciianm, with ncurses if it is installed
cd .. && ./play.sh ll-band
```

It needs a C compiler and make; ncurses (Debian, Ubuntu: `libncurses-dev`; Fedora: `ncurses-devel`) is optional, and better: only what
changes is drawn. Without it (`make ansi`) every frame is drawn whole.

By itself: `./asciianm FILE.txt [ms [lines [columns [times]]]]`, with `-ansi` at the end for ANSI sequences in place of
ncurses; times 0 = for ever. Keys: `q` ends it, space pauses, `+` and `-` change the speed. `./asciianm --info FILE.txt` shows the settings. The first line of a file holds them:
`ARGUMENTS:lines:columns:ms per frame:times:title:#`. Then come the frames, one after another, with that number of lines each.

The source is that of January 2003, except for the places marked 2026, which are listed in [ChangeLog](ChangeLog).
[README.2003](README.2003) is the original, in Greek with Latin letters, like the comments of the source.
