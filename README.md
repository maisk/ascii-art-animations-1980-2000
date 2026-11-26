# ASCII art animations, 1980–2000: a collection, with provenance

A collection of **109 VT100/ANSI terminal animations** from the early-to-mid 1990s ASCII art scene, as they
circulated on Usenet, FTP and the web, together with an index of where each one came from
and, where it could be found, who made it.

**Watch them in your browser:** the whole collection is published at
<https://maistrelis.com/ascii-art/vt100-animations/>, with a page for every file. The animations play in the browser
at the speed of the serial line they were made for, with the provenance, maker and notes of each file from this
repository. They can be browsed by folder or by person. For some of the files that need a real VT100 to be seen
right (double-height lines, smooth scroll), there is also a video from a simulator running the terminal's original
firmware.

- **36 of the 109 could not be found anywhere else online** (checked November 2026 against textfiles.com, ibiblio,
  grox.net and three other collections): `online_2026` = `not found` in `index.tsv`.
- 56 files of `collection-1998/` match, by exact byte size, 55 of the 57 files of the animation directory of Bob Allison's
  ("Scarecrow") FTP archive `ftp.wwa.com/pub/Scarecrow/Animations` as listed on 13 Oct 1994 (`fish.vt` = `fishy-fishy.vt`
  and `ship.vt` = `sship.vt` are identical pairs; "Fishy2" and "Shamus" are one file, `shamus.vt`). That FTP site no longer
  exists. Its oldest files date from December 1993.
- The uuencoded attachments of alt.ascii-art.animation from the mid-1990s have been **stripped** from the Google Groups
  Usenet archive (and from archives derived from it). Copies saved at the time, like these, are often the only ones left.
- Looking closely paid off: `gabi.vt` turned out to be a German re-texting of a French animation posted in 1994, and
  `chase.vt` hides its author's signature in the grass of its last frame. These findings are in [FINDINGS.md](FINDINGS.md).

Next to them are **282 more files** from other sources (web pages of 1997–2000, later Usenet posts, DECUS tapes, old FTP archives, textfiles.com, …), sorted
into one folder per source, and the 5 demonstrations of Alec Muffett's ASP (1991), compiled and run by the collector in 2026. The full
story, and the source of every file, is in [PROVENANCE.md](PROVENANCE.md). `./play.sh -l` lists them all, folder by folder.

## What is here

The folders of animations are in `collections/` (for example `collections/collection-1998/`); everything else is at the top.
Almost all the files are from 1980–2000; `modern/` has 10 works from after 2000.

| Path | Contents |
|---|---|
| `collection-1998/` | 101 files exactly as in `vt-anims.tar.gz` (only `ani.vt` and `vortex.vt` are renamed: they had no extension, `ani` and `vortex`), put together from alt.ascii-art.animation posts and the Scarecrow archive, and packed on 13 Jan 1999. 74 of them are dated 31 Dec 1998, one on 8 Jan 1999 and 26 on 13 Jan 1999. `README-1999.txt` is the original Greek (Greeklish) readme of that package. |
| `usenet-1996/` | 8 files. 7 animations from posts that are not in `collection-1998/`: 6 decoded from posts saved in 1998 (reposts by Kai Voelcker in 1996, plus files posted by Colin Douthwaite, whose MS-DOS names are here in lower case: `BARNEY1.VT` is `barney1.vt`), and `vicki.vt` (Lyle Murphy's VICKI.ANS, posted as plain text on 1 Feb 1995; the copies found online elsewhere are damaged, see [FINDINGS.md](FINDINGS.md)). Plus `wartie.vt`, from the collector's alt.ascii-art mailbox: what Gareth Walwyn's DOS program WARTIE.EXE (posted on 24 May 1996) printed, read from its code by the collector in 2026. |
| `usenet-1994-1999/` | 41 other animations of alt.ascii-art.animation, recovered from the asciiart.eu Usenet archive (`date_subject_mXXXX.vt`), from the collector's mailbox, or through vt100-slowcat, which converted the HTML/JavaScript animations of 1997–99 to VT files. |
| `vk-junkyard/` | 19 HTML/JavaScript animations from Veronica Karlsson's "junkyard" pages (late 1990s), converted by vt100-slowcat. |
| `web-js-1997-1999/` | 21 JavaScript animations from the web pages of Andreas Freise (`freise-*`, 1997–98), Joan Stark (`jgs-*`, 1997–99) and Krogg (`krogg-*`, 1998–99, violent), converted by the collector frame by frame in November 2026. No pauses between frames: they are meant to be played fast, and `play.sh` plays them at 38400 baud (column `baud`), or, with `asciianm` built, the text frames, at the page's own delay. |
| `kangaroo/` | 5 JavaScript animations from KANGAROO's "Great Ascii Art Library" (GeoCities, Wayback Machine), converted by the collector frame by frame. The other 32 of the 37 pages that were saved are the same as files of other folders, or parts of them: see [FINDINGS.md](FINDINGS.md). |
| `llizard/` | 55 files: the JavaScript animations from llizard's web site (crosswinds.net/~llizard, Wayback copies of 2000–01), most of them her own (signed ejm97–ejm99: the lizard that eats, laughs, juggles and fishes, the pianist, the horses, tango, valentine 98), and a few by others that she kept there under their names (Matthew Thomas, Andrew Hood, Robert Haschart, bbunny, PeterPunk, Valery Silivanov, Joan Stark). Converted by the collector frame by frame in November 2026. No pauses: `play.sh` plays each at the speed that matches the page's delay (column `baud`), or, with `asciianm` built, the text frames, at the page's own delay. Where a page played several animations at once, they are one file, each at its own delay (`ll-hulahoop5`, `ll-elphnt2jvscptanim`, `ll-MThomasanim`); on the page they all played over and over. |
| `cjrandall/` | From CJRandall's site (shieldwolf.demon.co.uk, Wayback Machine). His JavaScript animations of 1998–2000, converted by the collector in 2026 frame by frame: his first four (`cjr-piston`, `cjr-transp`, `cjr-skuz`, `cjr-flaaz`, Aug 1998), `cjr-copter` and `cjr-pop` (May 1999), `cjr-bat-1/2` (Nov 2000); and four of his colour "Method 5" pages (1999–2000), as examples, with ANSI colours: `cjr-doggy05` (miK's dog, cut at 80 columns), `cjr-flower05`, `cjr-boomer05` (drawing by Matthew Thomas), `cjr-pop53`. No pauses: `play.sh` plays each at the speed that matches the page's delay (column `baud`), or, with `asciianm` built, the text frames, at the page's own delay. The `transp` frames are 30 lines tall (column `rows`). `cjr-unix1*.vt`: "Shieldwolf Unix Script #1" (5 Feb 1999), a Bourne shell script that clears the screen with `tput` and echoes two frames of llizard's bird nine times. Recorded by the collector in 2026 from the script, unchanged, with `/bin/sh` and with bash: their `echo` differs by one backslash. About 1 second each at 9600. |
| `decus-1981-1993/` | 26 "films" for the VT100 from the tapes of DECUS, the user society of Digital Equipment Corporation: `gonzo.vt` (3M, December 1981, "Run at 9600 baud, please"), the oldest dated animation file here; six films of FILM, a VMS program of 1979, as they were on an RSX tape of 1983 (`bambi`, `blob`, `duel`, `mrbill`, `oscar`, `porsche`); "pictures" of the Space Telescope Science Institute (1987–88), among them the complete *Twilight Zone*, with its signature; and films of 1987–1993. Byte for byte, except `go.vt` and `hein.vt`, converted by the collector in 2026 from FILM's own format. |
| `bsd-1980/` | `rain`, the "animated raindrops display", and `worms`, two animations of BSD Unix (Eric P. Scott, 1980), recorded by the collector in 2026 from the 4.2BSD sources: 2 minutes each at 9600 baud. Play them at 9600 (`play.sh` does): they have no delay of their own. |
| `alec_muffett_asp/` | 5 demonstrations of ASP, "Alec's Scrolling Program", the `.plan` animation language that Alec Muffett wrote in 1991, among them "The Andalusian Video Snail" (`demo2.vt`; `collection-1998/snails.vt` is the same demo, run with ASP 3.2 in the early 1990s). Compiled from ASP 3.5 and run by the collector in November 2026: see the folder's README. Their pauses are runs of carriage returns: play them at 9600 (`play.sh` does). |
| `sl-1992/` | `sl`, the Steam Locomotive of Toyoda Masashi (version 1.00: 11 Dec 1992), the joke for those who type `sl` instead of `ls`: one pass of the train in each of 4 variants, recorded by the collector in 2026 from its current source. Play them at 9600. |
| `vtgraph-1992/` | 18 files from `vtgraph.zip` and `xmasvt.zip`, dated 1989–1992. Several are in no online collection. |
| `nice-1994/` | 6 files from the NeXT archive NiCE (`ftp.nice.ch`, `vt100.anims/`, April 1994). |
| `kermit/` | 3 VT100 demos from the Kermit archive of Columbia University. |
| `textfiles/` | 46 files from artscene.textfiles.com/vt100 (own mirror of October 2002), titled with the textfiles.com descriptions. |
| `grox/` | 5 files from grox.net. |
| `maistrelis/` | 5 animations by the collector, Kostas Maistrelis (1994–1998), and `bear2`, a story by an unknown maker that he made into frames (1998). His own are drawn by hand in a text editor and played with his own players ASCIIANI (DOS) and asciianm (Linux). Converted to VT files with asciianm's own `-ansi` output. They have no pauses between frames: `play.sh` plays them fast, at 115200 baud (`bear2` at 28800; column `baud`). And `maistrelis-sig.vt`: what the three lines of C at the bottom of his Usenet signature of February 1998 printed when compiled and run; its pauses are BEL characters, so it beeps. |
| `modern/` | 10 works and captures from after 2000, among them Asciiquarium and WeatherSpect (Kirk Baucom), the telnet Star Wars of towel.blinkenlights.nl, and Eli the Bearded's fade-out banner. |
| `thumbs/` | 383 small pictures, one screen of each file (`thumbs/FOLDER/FILE.png`), except the 13 files with a note in the column `content`. Generated. They do not show colours, double-height or double-width lines. |
| `provenance.tsv` | **The hand-written data**: one row per file of the repository (every folder): title, creator (as the sources describe it), people (who made it, one name per person, for `CREDITS.md`), posters (who posted, reposted or collected it without making it), date, folder, origin, references, certainty, videos, the screen of the thumbnail (`thumb_at`: the screen after so many bytes; empty: chosen automatically), encoding of the bytes above 127 (`cp437`, `dec-mcs`; empty: the 8th bit is ignored), notes. Corrections go here. |
| `index.tsv`, `index.json` | **The index**: one record per file of the repository, the same data in both (see [below](#the-index)). Title, creator, people, posters, date, certainty, videos and notes come from `provenance.tsv`; the rest is computed from the files. Generated: do not edit. |
| `CREDITS.md` | Who made what, as far as is known: one entry per person, across all folders; then, apart, who posted, reposted or collected files they did not make. |
| `FINDINGS.md` | Findings about single animations: signatures, a German re-texting of a French piece, damaged copies online, characters lost in the Usenet archives. |
| `PROVENANCE.md` | Where the files come from, and how this was checked. The second part lists the source of every file, folder by folder (generated from `provenance.tsv`). |
| `scarecrow-ftp-1994-10-13.txt` | Bob Allison's listing of `/pub/Scarecrow/Animations` (posted to alt.ascii-art.animation, 13 Oct 1994). |
| `play.sh` | Plays an animation **by name** (`./play.sh chase`) at the speed of a serial line (uses `pv`): 9600 baud, or the file's own speed (column `baud` of the index), or the one you give (`-2400`). If a name exists in several versions (`name.vt`, `name--xxxxxx.vt`), it lists them all and plays nothing: run it again with the full name, e.g. `./play.sh fireworks--77a1bd.vt`. `./play.sh --loop 10 NAME` plays it 10 times in a row (`--loop inf`: until Ctrl-C; without it, the file's own `loop` of the index, or once). `./play.sh -l` lists every animation, folder by folder; `./play.sh -l -t` by playing time. With `-x` it plays in a new xterm window of the size each file was made for (80x24, or 80x25 for MS-DOS). `./play.sh -h` lists all its options. |
| `Makefile` | `make` checks what `play.sh` needs (`pv`, and `xterm` for `-x`), builds `asciianm`, and says what to do about anything missing or a build that fails. |
| `asciianm/` | The C player of the text frames (`.txt`), with its `Makefile`: `make -C asciianm`. By Kostas Maistrelis (1998–2003), GNU GPL version 2, unlike the rest. With it built, `play.sh` plays the text frames of an animation that has them: `./play.sh ll-band`; `ll-band.vt` is the `.vt`, `ll-band.txt` the text frames. |
| `INSTALL.md` | What `play.sh` needs: `pv`, `asciianm` for the text frames (and `xterm` for `-x`), and how to install them. |
| `NOTICE.md` | Rights and licences (the animations belong to their creators; this repository's own texts and data are CC BY 4.0), and how to request a correction or removal. |
| `LICENSE-MIT` | The MIT licence of `play.sh` and `Makefile`. |

## How to watch

The `.vt` files are raw terminal output. They were meant to be sent to a DEC VT100 (or compatible) over a serial line, and
their timing comes from the line speed. On a modern computer `cat` shows them in a blink. Slow them down instead:

```sh
./play.sh -l                                 # every animation, folder by folder (also: ./play.sh alone)
./play.sh -l bsd-1980                        # one folder: playing time, speed, title and creator of each file
./play.sh -l -t                              # every animation by playing time, shortest first
./play.sh info chase                         # everything known about one file: index.tsv and provenance.tsv
./play.sh chase                              # finds collection-1998/chase.vt, plays it at 9600 baud
./play.sh fireworks                          # 3 versions: lists them, plays nothing
./play.sh fireworks--77a1bd.vt               # the full name plays exactly that one
./play.sh -2400 bunny                        # at 2400 baud
make; ./play.sh ll-band                      # the text frames (ll-band.txt); ll-band.vt would be the .vt
./play.sh -l xmas                            # every file with "xmas" in its name
./play.sh -x vicki chase                     # in a new xterm: 80x25 for vicki, then 80x24 for chase
cat some-file.vt | ./play.sh -               # from stdin
pv -qL 960 collections/collection-1998/chase.vt   # ~9600 baud
```

`play.sh` needs `pv` (Pipe Viewer): see [INSTALL.md](INSTALL.md). `make` says whether it is there.

Or, without installing anything, on the web: <https://maistrelis.com/ascii-art/vt100-animations/>.

Use an **80x24** terminal. Run `reset` afterwards if the terminal is left in an odd state.
Sixteen files need a taller screen (column `rows` of `index.tsv`; `play.sh` asks before playing them on another size,
and `./play.sh -x` opens an xterm of the right size). Ten need **80x25**: seven made for the screen of MS-DOS
(`usenet-1996/vicki.vt`, `collection-1998/ani.vt`, `collection-1998/t2.vt`, `collection-1998/vortex.vt`,
`collection-1998/barney.vt`, `usenet-1996/barney1.vt`, `collection-1998/prey_col.vt`) and three web pages
(`usenet-1994-1999/spider.vt`, `kangaroo/elvis.vt`, `web-js-1997-1999/jgs-mlamp.vt`). Six are taller still:
`maistrelis/polis.vt` (26 lines), `cjrandall/cjr-transp.vt` and `usenet-1994-1999/parachute.vt` (30),
`usenet-1994-1999/takeoff.vt` and `web-js-1997-1999/jgs-monster.vt` (31), `web-js-1997-1999/jgs-gogogadget.vt` (32).
Do not use 25 lines for everything: many VT100 files place the cursor and also scroll at line 24, and go wrong on a
taller screen. See [FINDINGS.md](FINDINGS.md).

The authors paced their animations for 2400–9600 baud lines or 4.77 MHz PCs, using padding (repeated `ESC[H`) or thousands
of backspaces. People soon asked how to slow them down, and tools were written for it: vtcat (Unix, 1994) and SlowANSI (DOS, 1995).
Others slowed down the whole PC with MOSLO (1990, made for old games). `play.sh` slows them down with `pv`.

Many of the files use features that most modern terminal emulators do not support (the index lists them in the
`vt100_features` column, explained [below](#the-vt100_features-column)): **double-height and double-width lines**, **smooth scroll**, **whole-screen reverse video**
flashes, the DEC special graphics character set, and scroll regions. xterm supports some of these. For the real thing,
use a real VT100/VT102/VT220.

### Text frames

142 of the animations (those made of whole frames, most of them from web pages) are also here as text frames, a `.txt`
next to the `.vt` of the same name, for `asciianm/`, the collector's C player: the same frames as the `.vt`, with the
speed that a `.vt` cannot hold (column `txt` of the index). Where the maker is not the collector, the title and credit
in the first line are from `provenance.tsv` or from the page. With `asciianm` built (`make`), `play.sh` plays
the text frames of an animation that has them.

**The technique.** Most of these animations are nothing more than a series of still pictures, all of the same size,
shown one after the other in the same place, like the pages of a flip book. A `.vt` holds them with the escape sequences
that put the cursor back at the top of the screen, and the time between two pictures is however long the terminal takes
to receive the next one: on a 2400 or 9600 baud line that was the clock, on a modern computer it is nothing. A text frame
file keeps only the pictures, and says how long each one stays on the screen. The JavaScript animations of the web pages
of 1997–2000 (`llizard/`, `web-js-1997-1999/`, `cjrandall/`, KANGAROO's pages, Veronica Karlsson's "junkyard") worked the
same way: the page held the frames as strings of text and changed them on a timer (`setTimeout`), every so many
milliseconds. The `.txt` keeps that delay; the `.vt` made from the same page can only be played at the speed that comes
closest to it (column `baud`).

The format is plain text, so it can be drawn and corrected in any text editor. The first line holds the settings:

```
ARGUMENTS:4:80:70:0:band - llizard (ejm):#
```

that is: 4 lines and 80 columns per frame, 70 ms per frame, played for ever (`0`; otherwise so many times), and the title.
Then come the frames, one after another, 4 lines each, with nothing between them. A frame can use only the characters
of the text: no colours, no cursor movements, no double-height lines. That is why animations that move the cursor or
use the features of the VT100 have no `.txt`. And there is one speed for the whole file: where a page waited longer on
one frame, that pause is lost.

**The player.** `asciianm` is a small C program for the Unix terminal: the collector's Linux player of
1998–2003, after ASCIIANI, his MS-DOS player of 1996–98. With ncurses it draws only the characters that change from one
frame to the next; without it (`-ansi`) it draws each frame whole with ANSI sequences, and its output can be saved as a
`.vt` (that is how the `.vt` of `maistrelis/` were made). While it plays, `q` ends it, space pauses, `+` and `-` change
the speed. See [asciianm/README.md](asciianm/README.md). It is under the GNU GPL, version 2, unlike the rest of the
repository.

## The index

`index.tsv` and `index.json` have one record for each of the 396 files of the repository, in the same order: folder by
folder (`collection-1998/` and `usenet-1996/` first), and by name within a folder. File names are unique across the
repository: where a name occurs more than once, the later copy is renamed `name--xxxxxx.vt`, `xxxxxx` being the first 6
hex digits of its md5. In `index.json`, `bytes` and `rows` are numbers, the rest strings.

| Column | Meaning |
|---|---|
| `folder`, `file`, `bytes`, `md5` | where the file is, and its identity |
| `title` | description, mostly from textfiles.com or vt100-slowcat (empty where none is known) |
| `creator`, `people` | who made it: `creator` as the sources describe it (`unknown` if nobody is known); `people` one name per person, separated by `;` (the names of `CREDITS.md`) |
| `posters` | who posted, reposted, collected or circulated it without having made it, as far as the sources say: one person per entry with the role in brackets, e.g. `Jorge Donato (posted)`, separated by `;` (listed apart in `CREDITS.md`). `collected`: a person of the scene (1980–2000) had it in a collection or on a site, wherever the copy here comes from (that is in `found_at` and in the provenance) |
| `date` | when it was made, or the earliest date known ("by …") |
| `certainty` | how sure the attribution is: `verified` = signature in the file or original post found; `secondary` = from another archive's description; `inferred` = a deduction, not documented; `unknown` = nothing known |
| `notes` | anything else; the full story of each file is in [PROVENANCE.md](PROVENANCE.md) |
| `kind` | how the file draws, from its escape sequences: **`vt100`** moves the cursor and redraws only what changes, and/or uses VT100-only features: made for the terminal. **`frames`** whole-screen frames separated only by "home" or "clear screen": plays on any terminal, like a text file of frames. **`dehtmlizer`** converted in 2021 by Eli the Bearded from an HTML/JavaScript page of the late 1990s (starts with `ESC[H ESC[2J ESC[3J ESC[?25l`; `ESC[3J` is an xterm extension): not a 1990s terminal animation. **`pc-ansi`** written for MS-DOS ANSI.SYS / BBS (ANSI colours, CP437 characters). **`text`** no escape sequences |
| `vt100_features` | terminal features the file uses (VT100, VT220 soft fonts, and ANSI colour), comma-separated: see [below](#the-vt100_features-column) |
| `rows` | screen height the file needs: `24` (VT100), `25` (MS-DOS screen), up to `32` for a few files of taller frames (web pages, `polis.vt`) |
| `baud` | the speed to play it at, where it needs its own (empty: the player's default, 9600). Fast for files with no pauses of their own (`maistrelis/` 115200, `web-js-1997-1999/` 38400, `maistrelis-sig.vt` 1800000), exactly 9600 for programs whose clock was the line (`bsd-1980/`, `sl-1992/`, `alec_muffett_asp/`). `play.sh` uses it unless given a speed; in `index.json` a number or `null` |
| `loop` | how many times in a row `play.sh` plays it (empty: once). Set for the converted web animations (`llizard/`, `cjrandall/`, `web-js-1997-1999/`) whose page played them over and over and whose one pass is shorter than 5 seconds: repeated to about 10 seconds. Not for those that their page played once (`ll-hood_anim-1`, `ll-spot`), nor `cjr-unix1*` (the script ends). From the second pass on, `play.sh` leaves out the clear screen at the start of the file, so the screen does not flash. `play.sh` uses it unless given `--loop`; in `index.json` a number or `null` |
| `seconds` | about how long it plays at that speed (`baud`, or 9600): bytes × 10 / baud, as `play.sh` and `pv` play it, times `loop`. `PROVENANCE.md` shows it as "Plays" (m:ss) |
| `videos` | addresses of videos of the file playing, separated by `;` (empty: none) |
| `txt` | the same animation for asciianm, in the same folder (empty: none): text frames, first line `ARGUMENTS:lines:columns:milliseconds per frame:times (0 = for ever):title:#`. It has no record of its own |
| `content` | `adult` / `mature` notes. Most files have not been individually reviewed |
| `contains_email` | `yes` if the file shows an e-mail address (in its bytes, or drawn on the screen a letter at a time) |
| `found_at` | where the copy was found: online archives and collections, the collector's own disks and mailbox (`collector's archive`, `collector's mailbox`, `… (collector's copy)` for his copies of sites now gone), or `made by the collector` / `recorded by the collector` for files made in 2026 |
| `scarecrow_ftp_1994` | `collection-1998/` only: name and date on the Scarecrow FTP listing of 13 Oct 1994 (matched by exact byte size) |
| `kai_voelcker_repost` | `collection-1998/`, `usenet-1996/`: date Kai Voelcker reposted it to alt.ascii-art.animation (1996) |
| `online_2026` | `collection-1998/`, `usenet-1996/`: `identical`, `variant xx%` (share of identical visible lines) or `not found` online (November 2026); `empty file`: only NUL bytes, nothing to look for (`tigercat.vt`) |
| `online_where` | where: `tf:` textfiles.com, `ib:` ibiblio, `eli:` Eli-the-Bearded/vt100-slowcat, `ta:` orhun/theattyr |
| `web_url` | the file's page at <https://maistrelis.com/ascii-art/vt100-animations/>, where it plays in the browser |

### The `vt100_features` column

A value is listed when its escape sequence occurs anywhere in the file (`ESC` = byte 27). "Files" counts the files of the
index that use it (of 396).

| Value | Escape sequence | What it does | Files |
|---|---|---|---|
| `double-height` | `ESC#3`, `ESC#4` | turns the current line into the top (`#3`) or bottom (`#4`) half of a line of double-height, double-width letters; the same text is sent on two lines | 68 |
| `double-width` | `ESC#6` | turns the current line into double-width letters (40 columns) | 30 |
| `smooth-scroll` | `ESC[?4h` | the screen scrolls smoothly, a few pixels at a time (on the VT100 at most six lines a second), instead of jumping a whole line | 27 |
| `reverse-screen` | `ESC[?5h` | the whole screen in reverse video (dark letters on a light background) until `ESC[?5l`; used for flashes | 31 |
| `dec-graphics` | `ESC(0`, or `ESC)0` together with SO (byte 14); `ESC)0` alone is often just a start-up string and is not counted | the DEC special graphics character set: line-drawing pieces, corners, blocks and a few symbols in place of lower-case letters and some punctuation | 86 |
| `scroll-region` | `ESC[top;bottomr` | only the lines from `top` to `bottom` scroll; the rest of the screen stays still | 42 |
| `soft-font` | `ESC P` … `{` … `ESC \` (DECDLD), or the same with the 8-bit bytes 0x90 and 0x9C | loads letters of its own design into the terminal (a downloadable character set, or soft font) and draws with them. Not a VT100 feature: it needs a VT220 or later | 2 |
| `ansi-color` | `ESC[30m` … `ESC[37m` | foreground colour. Not a VT100 feature (the VT100 had no colour): it comes from MS-DOS ANSI.SYS and BBS art | 18 |

## Corrections

If you made one of these, or know who made an "unknown" one, please open an issue. To have a file removed, see
[NOTICE.md](NOTICE.md).

## Thanks

To everyone who drew, posted and reposted these, and to Bob Allison ("Scarecrow"), Kai Voelcker and Colin Douthwaite
in particular.

Many of the files come from the Internet Archive's [Wayback Machine](https://web.archive.org/) (the old pages of
[Veronica Karlsson](https://web.archive.org/web/19991009043931/http://www.ludd.luth.se:80/%7Evk/pics/ascii/junkyard/creative/animations/),
[Joan Stark](https://web.archive.org/web/19991012180054/http://geocities.com:80/SoHo/Gallery/6446/indexjs.htm),
[KANGAROO](https://web.archive.org/web/19991013163448/http://www.geocities.com:80/SouthBeach/Marina/4942/anim.htm),
[llizard](https://web.archive.org/web/20001017124654/http://www.crosswinds.net/~llizard/ascii-art/animation/animations.htm),
[CJRandall](https://web.archive.org/web/20000130180128/http://www.shieldwolf.demon.co.uk/anim.htm) and
[Krogg](https://web.archive.org/web/19981203042441/http://www.inspace.net:80/%7Ecarcher/krogg/aani.htm)) and from the DECUS archives of
[digiater.nl](https://www.digiater.nl/openvms/decus/) and
[mrynet.com](https://mrynet.com/FTP/os/PDP-11/rsx11-rechner/). Jason Scott's
[textfiles.com](http://artscene.textfiles.com/vt100/), Eli the Bearded's
[vt100-slowcat](https://github.com/Eli-the-Bearded/vt100-slowcat), orhun's [theattyr](https://github.com/orhun/theattyr),
[ibiblio](https://www.ibiblio.org/pub/multimedia/animation/vt100-animation/) and the
[asciiart.eu Usenet archive](https://www.asciiart.eu/archives/usenet) made the cross-checking possible.

Collected in 1998 and documented in 2026 by Kostas Maistrelis (Κώστας Μαϊστρέλης, [https://maistrelis.com/](https://maistrelis.com/en/)).
