# Findings

Findings about single animations, too long for `index.tsv` or `provenance.tsv`: who made them, where the copies came
from, how they differ, and which copy is in this repository. Where each file comes from is in
[PROVENANCE.md](PROVENANCE.md), and who made what in [CREDITS.md](CREDITS.md).

## Gabi and the Vestale (`collection-1998/gabi.vt`, `usenet-1996/vestale.vt`)

*`gabi.vt` is a German re-texting of a French piece.*

The frames are identical to "Vestale sous Contraintes (Exercice ludique en courier 10) – Copyright (c) YT", posted to
alt.ascii-art.animation in November 1994 in two parts by "here.and.there" through the anon.penet.fi remailer and signed
"Yves". Only the words change ("Gabi wartet am Strand", "Ich heisse Gabi, wann treffen wir uns …" against "Beaucoup trop
moderne ce truc …"). Both files start with the exact bytes printed by the Perl "small movie" player the same poster
published on 27 Oct 1994 (`ESC[H ESC[J \n ESC[1 \n`).

It is not a translation: every caption of the two files, side by side, shows new words with a meaning of their own. The
name, the setting and the last line changed, and Yves's copyright line was dropped.

| `vestale.vt` (French, 1994) | `gabi.vt` (German) |
|---|---|
| "Vestale sous Contraintes" / "(Exercice ludique en courier 10)" | "Gabi wartet am Strand" ("Gabi waits on the beach") |
| "Copyright (c) YT" / "All rights reserved" | (nothing: the signature was removed) |
| "Beaucoup trop moderne ce truc ..." ("Much too modern, this thing ...") | "Ich heisse Gabi, wann treffen wir uns ..." ("My name is Gabi, when shall we meet ...") |
| "a i :\_jooo", "i a :\_jooo", "u e :\_jooo" | the same (sounds, not words) |

Kai Voelcker had both. His copies are dated 13 Nov 1994, `vestale.vt` at 16:34 and `gabi.vt` at 17:27 GMT (gzip headers of
his attachments). He reposted the French original first, on 4 Feb 1996, adding "This is my personal favourite. Does anybody
remember the address of the author, somewhere in France?", and again on 4 May, 26 Aug, 14 Sep, 2 Oct and 22 Oct 1996.
`gabi.vt` followed on 4 May 1996, the same day, and again on 14 Aug, 3 Sep, 22 Sep and 10 Oct 1996. His repost of
14 Sep 1996, saved in the collector's mailbox, is `usenet-1996/vestale.vt`.

## The signature in the grass (`collection-1998/chase.vt`)

*`chase.vt` is signed "Catalyst".*

The signature is drawn into the grass of the last frame (`;;;;Catalyst;;`), so it only shows when the animation is
rendered. A copy in a zip dated 4 May 1995 survives on Veronica Karlsson's old pages.

## Chris Groom (`collection-1998/hanoi.vt`)

`hanoi.vt` ("Animated by: Chris Groom") was circulated by Bob Allison in October 1994. The 1994 `vtcat` slow-cat utility
was written by a C. Groom at Newcastle, probably the same person.

## Creators known from textfiles.com

`castle.vt`, `mark_twa.vt`, `monorail.vt`, `skyway.vt` and `tomorrw.vt` (all in `collection-1998/`) are Don Bertino's
Disneyland series, according to textfiles.com. `snails.vt` ("The Andalusian Video Snail") is by Alec D. E. Muffett.

## VICKI.ANS (`usenet-1996/vicki.vt`)

*An animated girl dancing, in colour, for MS-DOS. By Lyle Murphy, posted on 1 February 1995.*

Murphy posted it as plain text, not uuencoded, three times on the same day:

| Group | Time | Subject |
|---|---|---|
| alt.ascii-art | 02:25:30 GMT | "ANIMATION : VICKI.ANS" |
| alt.ascii-art.animation | 20:51 (as shown by asciiart.eu) | "ANIMATION :ANSI file VICKI>ANS" |
| alt.ascii-art.animation | 20:55 (as shown by asciiart.eu) | "ANIMATION : ANSI FILE VICKI.ANS" |

Above a "CUT HERE" line he explained how to play it (save it as `VICKI.ANS` and run `type VICKI.ANS` from a batch file; on
MS-DOS this needs the ANSI.SYS driver) and how he made it: "I found this girl on the board. She was cold and naked in cyberspace. I fixed her hair, clothed her, and taught her
to dance. It took me about 1.5 hours to make this."

### Three versions

| # | Where | Bytes | md5 | State |
|---|---|---|---|---|
| 1 | The original posts, 1 Feb 1995: alt.ascii-art.animation in the asciiart.eu Usenet archive ([20:51](https://www.asciiart.eu/archives/usenet/message/m5bb1c111da), [20:55](https://www.asciiart.eu/archives/usenet/message/m876e2fd3f0)), and alt.ascii-art (02:25 GMT) in the "preservation" archive of asciiart.website | 20,854 (the part below "CUT HERE") | `3231d4686ee9d98b4a3a7e0a2fc574c5` | **Good.** This is the copy in `usenet-1996/vicki.vt`. |
| 2 | [vt100-slowcat](https://github.com/Eli-the-Bearded/vt100-slowcat), `videos/grox/vicki.vt` | 23,493 | `75a6ba860d8d05d35b9b6929e89b557e` | Damaged (see below). |
| 3 | mewbies.com, `vt_files.zip` (2013), `vt_files/vicki.vt` | 23,493 | `ea8ba3cd2c92dbd5f2fb1569fea73dd9` | Damaged as no. 2, and its colours changed. |

**1. The original posts.** The two posts to alt.ascii-art.animation, four minutes apart (the first has a typo in the
subject), are byte-for-byte identical. The earlier post to alt.ascii-art, in the asciiart.website archive, has the same
animation, also byte-for-byte. Three posts in two independent archives agree, and all keep the 2,647 escape characters. The
animation is 2,647 lines with one escape sequence each, followed by ten `^Z` characters, the end-of-file padding of MS-DOS,
a sign that it was pasted straight from a DOS file.

**2. vt100-slowcat.** Apart from the following three changes it is the same file, line for line:
- line endings converted to CR LF;
- the ten `^Z` at the end removed;
- **one escape sequence broken in two.** At line 1130 the original has `ESC[6;36H` followed by a space (cursor to row 6,
  column 36). In this copy a line break falls inside the sequence: `ESC[6;` ends one line and `36H ` begins the next. The
  terminal reads a broken sequence, the cursor does not move where it should, and the characters `36H` are printed on the
  screen.

**3. mewbies `vt_files.zip`.** The same three changes as no. 2, at the same places, and in addition **every colour code of
two kinds has been replaced**:
- all 200 `ESC[30m` (black) became `ESC[37m` (white);
- all 184 `ESC[34m` (blue) became `ESC[35m` (magenta).

Nothing else differs. Why the colours were changed is not known. The change alters what the animation looks like, so this
copy cannot be used as a reference.

Copies 2 and 3 probably share an ancestor. mewbies says that eight of its files came from grox.net, and vt100-slowcat keeps
this file in its `grox/` folder. The broken escape at line 1130 is the same in both. This is an inference from the paths and
the shared damage; the grox.net copy itself has not been seen.

### What is in the repository

- `usenet-1996/vicki.vt`: version 1, the part of the post below the "CUT HERE" line, unchanged (LF line endings as posted,
  the `^Z` padding kept), taken from the asciiart.eu copy of the 20:51 post. File date: 1 Feb 1995, 02:25:30 GMT, the time
  of the first post.
- Versions 2 and 3, and the full post with Murphy's header, are **not** in the repository.
- Version 1 was extracted by the collector from the first post (the part below its "CUT HERE" line).

### Playing it

It is an ANSI file for MS-DOS: colours (`ESC[30m`, `ESC[34m`, `ESC[37m`), cursor positioning, and `ESC[2J` to clear the
screen. It needs a terminal with ANSI colours and a black background, at 80×25. With `./play.sh vicki` it plays at 9600 baud,
about 22 seconds. On DOS, `type` stopped reading at the first `^Z`; a terminal that does not treat `^Z` as the end of the file
may show it as a symbol at the end.

The 25 lines matter. Every escape sequence is followed by a line feed, so each step places the cursor, draws one character
and moves down a line. The cursor reaches line 25. On a 24-line screen that line feed scrolls the screen, 19 times in all,
and each time the picture slides up a line and comes apart. On the DOS screen it never scrolls.

## Files made for the 25-line screen of MS-DOS

A VT100 has 24 lines, the PC screen of MS-DOS 25. A file made for 25 lines plays wrongly on 24: a line feed on the last line
scrolls the screen where the author's screen did not. The opposite holds too: many VT100 files place the cursor and also
scroll with line feeds at line 24, and on 25 lines they scroll one line later and come apart. So the screen height is a
property of each file, in the column `rows` of `index.tsv`.

**How they were found (17 Nov 2026).** The cursor of every file was simulated at 24 and at 25 lines (positioning, line feeds,
scroll regions). Files that scroll in mid-file at 24 lines but never at 25 are candidates; a single line feed at the very end
of a file does not count. The candidates were then played side by side at 24 and 25 lines and compared by eye.

| File | Scrolls at 24 lines | At 25 lines |
|---|---|---|
| `usenet-1996/vicki.vt` | 19 | correct (see VICKI.ANS above) |
| `collection-1998/ani.vt` | 4 | correct, apart from 3 scrolls at the very end (nine empty lines); converted from a DOS batch file, see below. Found on 24 Nov 2026 by simulation only |
| `collection-1998/t2.vt` | 150 | correct: whole frames of 25 lines; at 24 the top of every frame is a line off |
| `collection-1998/vortex.vt` | 2 | PC ANSI; small difference, 25 is the screen it was made on |
| `usenet-1994-1999/spider.vt` | 28 | correct: the web stays inside its frame (converted by vt100-slowcat from an HTML page, probably of 25 lines) |
| `collection-1998/barney.vt`, `usenet-1996/barney1.vt` | 11, 18 | correct: at 24 the line feed after line 24 of each frame slides the picture up and leaves a second "I love you..." and other remains. At 25 they scroll only before the first frame (line feeds that clear the screen) and, `barney1.vt`, at the very end. Found on 25 Nov 2026 |
| `collection-1998/prey_col.vt` | 16 | correct, apart from 10 scrolls of the last screen; at 24 six frames slide up a line. CR LF and ANSI colours. Found on 25 Nov 2026 |

Thirteen more files scroll just once in mid-file at 24 lines and not at 25: in `gabi.vt`, `vestale.vt` and `reading.vt` it is a
title page of 25 lines followed by "home", which the next frame covers. They were not checked one by one and are left at 24.

## Files of frames taller than 25 lines

The search above cannot find a file that scrolls at 25 lines too. On 25 Nov 2026 the cursor of every file was simulated again at
24 to 60 lines, and every whole frame was compared with the same frame on a screen of 60 lines. Beside the files already known
(`jgs-monster.vt`, `jgs-gogogadget.vt`, `cjr-transp.vt`), three scroll in every frame at 24 **and** at 25 lines:

| File | Lines of a frame | Scrolls per frame at 24 / 25 lines | Height |
|---|---|---|---|
| `maistrelis/polis.vt` | 25 | 2 / 1 | 26 |
| `usenet-1994-1999/parachute.vt` | 29 (the page had `TEXTAREA ROWS=29`) | 6 / 5 | 30 |
| `usenet-1994-1999/takeoff.vt` | 30 (`TEXTAREA ROWS=30`) | 7 / 6 | 31 |

The height is one more than the lines of the frame, because the last line too ends with a line feed. At the very end
`parachute.vt` sends one more, which scrolls the last picture up a line at 30, as `spider.vt` does at 25.

## ani.vt was a batch file (`collection-1998/ani.vt`)

The animation was first an **MS-DOS batch file**: `ani.vt.z`, reposted by Kai Voelcker on 15 Sep 1996 (his copy is dated
12 Feb 1995), is not a stream of bytes for a terminal. It has `echo off`, then 1,645 lines `echo ESC[row;colH<char>`, 8 labels
(`:start`, `:i am`, `:bell`, `:wave`, `:wave1`, `:rpging`, `:startrek`, `:final`) and four `pause` commands, CRLF line endings
and a `^Z` at the end. Run under DOS with ANSI.SYS, each `echo` printed its escape sequence, one character, and a new line: the
same one-step-per-line form as VICKI.ANS. Played as a `.vt`, the words `echo`, the labels and `pause` appear on screen with the
picture.

**It is by Lyle Murphy, the author of VICKI.ANS** (signature in the file). The section `:i am` writes, letter by letter:
"Hello and welcome to a Bell, Book, and Candle production ... I am Lyle Murphy ... DBA 'Alien Software' !!!". Two more
things agree: the e-mail address in the last section is on the same Texas Instruments host as Murphy's signature in the
VICKI.ANS post of 1 Feb 1995 (another mailbox name), and "Bell", the "book Genie" ("she sorta looks like my wife"), is the
same drawing as the girl of VICKI.ANS (head `,-,__,-,` / `{ /__\ }` / `{_}/\- /\{_}`, shoulders `/'!  `' !`\`). It is a
"presentation" of a Star Trek role-playing game of alt.games.xtrek.

**`collection-1998/ani.vt` is a conversion of that batch file, made by the collector on 8 Jan 1999**, the date of the file in
`vt-anims.tar.gz`, where it is named `ani`; only the name is changed here. The source was probably the copy in the collector's mailbox. Compared
line by line with the batch file:

- `echo off` and the final `^Z` are gone, and so is the word `echo` of every line; the space after it stays.
- The 8 labels and the 4 `pause` are empty lines, so the animation no longer waits for a key.
- At the end there are one more space and nine empty lines.
- Every other line is the same.

It needs **25 lines**: in four places a `pause` and the label after it became two empty lines below line 22, which scroll a
screen of 24 lines, and from there on the texts run into each other ("What Igreally want tosdo is invite"). On 25 lines it scrolls only at the very end, from the
empty lines, and the picture before that is the one the batch file draws (simulated, 24 Nov 2026).

The batch file itself is not in this repository.

## The warthog was a DOS program (`usenet-1996/wartie.vt`)

Gareth Walwyn of Rhodes University posted `WARTIE.EXE`, uuencoded, to alt.ascii-art on 24 May 1996 ("Here is a warthog I animated
for Rhodes. Any comments ?"). On the same day he also posted a `wartie.exe` to alt.ascii-art.animation ("Here is a compiled animation I
did for Rhodes"); in the [asciiart.eu copy](https://www.asciiart.eu/archives/usenet/thread/t954b906841) the program has been removed
("uuencoded_portion_removed"). The copy used here is the one in the collector's alt.ascii-art mailbox; the program itself is not in this repository.

**Where the warthog comes from.** Two days earlier, on 22 May, he had asked the group for drawings of a warthog, giraffe, sunbird,
lark, hippo, kudu, thoth and hyaena, to show "the sysops and postmanagers on our systems at Rhodes, because the present ones leave plenty
to be desired", with "a rather feeble warthog I drew". That drawing is the first and last frame of the animation: 6 of its 11
lines are the same, and in the other 5 the apostrophes became backquotes (and one leg changed). His own address was on the host
`warthog.ru.ac.za`, so the "W a r t h o g" of the screen is most likely the name of a machine, and the animals are the names of others. This is an
inference (a host `kudu.ru.ac.za` also appears in a post from Rhodes).

**What the program does** (read from its code, 18 and 25 Nov 2026; it was not run). It is in Turbo Pascal, with the Crt unit: 18 procedures,
each of which draws one frame from line 4 of the screen with `Write` and `WriteLn`. The main part calls them one after the other, then
the first again, so there are 19 frames, and leaves the cursor on line 16. Between two frames it waits and clears the screen.
The wait is the number given on the command line times 12 ms; with no number, or with something that is not one, it is 10,
which makes 120 ms. It plays once.

A ball rolls along the line of the text and uncovers "You are logged into the Rhodes Novell server / W a r t h o g" (frames 11 to 15). The text
is whole in frames 16, 17 and 18, and gone in the last. After frame 16 the program waits another 500 ms, so that frame stays for 620 ms, and the
whole text for 860 ms.

**The two copies here and the time.** The frames are the same in both; what they can keep of the time is not.

| | Time per frame | Frame 16 | The whole animation |
|---|---|---|---|
| `WARTIE.EXE`, no number given | 120 ms | 620 ms | 2.7 s, and then the last frame stays |
| `wartie.vt` at 9600 baud | about 0.7 s, the time the bytes take | like the others | 14.1 s |
| `wartie.txt` | 120 ms | 120 ms | 2.3 s |

A `.vt` has no pauses, so every wait became only "clear screen". A text-frame file has one speed for all its frames, so the
500 ms are not there either. They could be kept only by repeating frame 16, and then the `.txt` would no longer have the frames of the `.vt`
(it was made on 25 Nov 2026 from the `.vt`).

## Orb (`collection-1998/orb.vt`)

On the Scarecrow FTP listing as "Orb" (1 Jun 1994); Kai Voelcker reposted it on 4 Feb 1996. The screen shows, a letter at a
time, the line "=-=-=-=-=-=- Hacked by Anthony Bowyer-Lowe (…@mdx.ac.uk) -=-=-=-=-=-=-=-" (Middlesex University). Since the
text is not in the bytes as one string, it was found only on 17 Nov 2026, by simulating the screen and looking for e-mail
addresses on it. "Hacked by" means that he changed the animation; who made it first is not known.

## TIGERCAT is empty (`collection-1998/tigercat.vt`)

The file has 7,572 bytes and all of them are NUL (0): it draws nothing, and at 9600 baud it is eight seconds of an empty
screen. It is the same in `vt-anims.tar.gz` (file date 31 Dec 1998) and in the collector's other copy of the package's files,
so it was already empty when the collection was packed on 13 Jan 1999. No other file of the package, or of this repository, is like
this. What is left is the name and the size, which a copy from elsewhere could be checked against; the size may be rounded up or
cut by whatever damaged it.

Nothing else is known of it: the name is not in Bob Allison's FTP listing of 13 Oct 1994, nor in the collector's mailbox of
1996-98. It is kept here as it is in the package. Found on 25 Nov 2026; until then it was counted among the
files that were not found online (37, now 36).

## Vortex, the colour animation of the FAQ (`collection-1998/vortex.vt`)

Bob Allison's ASCII art FAQ gave this file as its example of colour and animation together. Version 3.9 of 15 Sep 1994,
posted to alt.ascii-art.animation ([thread on asciiart.eu](https://www.asciiart.eu/archives/usenet/thread/t0e13345d45)):

> o  Color Animation - For an example of color and animation together, take a
>    look at the file called "Vortex" in the Scarecrow's FTP site.

His last version, 4.9.2 of 9 Apr 1996 ([faqs/1996-04-09_allison-v4.9.2.txt](faqs/1996-04-09_allison-v4.9.2.txt)), still
says so. "Vortex" is not in the listing of `/pub/Scarecrow/Animations` that he posted on 13 Oct 1994
([scarecrow-ftp-1994-10-13.txt](scarecrow-ftp-1994-10-13.txt)), so it was in another directory of the site. The copy here
is the one of `vt-anims.tar.gz`, where it was called `vortex`; the collector also had it as `VORTEX.TXT`, dated 1 Apr 1995.
Its maker is not known, and it was found in no other collection online (November 2026).

**How it plays.** It was made for the ANSI driver of an MS-DOS PC, not for the VT100: a screen of 25 lines, the block and
line characters of the PC (code page 437), blue and magenta. It moves the cursor only by relative steps (`ESC[nA`, `B`,
`C`, `D`) and has no pauses: on a PC its pace was that of the machine. `play.sh` plays it at 57600 baud, about 10 seconds.
A simulation of the screen shows four parts:

1. Bytes 0-15190: it clears the screen and fills it with a mottled picture of blue and magenta blocks, crossed by a
   funnel of black lines drawn with the line characters: the vortex.
2. Bytes 15191-36391: it goes back to the top of the screen (`ESC[24A`) and redraws the picture, and the black lines
   shrink towards the middle of the screen until they are gone (around byte 33000).
3. Bytes 36392-42400: after one more pass, the word WELCOME is drawn in the middle, stroke by stroke, in large letters
   of double lines, bright blue and blinking.
4. Bytes 42400-57605: a black window opens around WELCOME and grows to the edges of the screen, and the last columns
   are cleared one by one. WELCOME is left alone on the black screen, blinking. The file ends with `^Z`, the
   end-of-file mark of MS-DOS.

Much of the picture is also drawn with the blink attribute (`ESC[5m`). On a PC screen a blinking block shows its two
colours in turn, so the picture flickers between blue and magenta. At the full speed of a PC (or of DOSBox) only the end
can be seen: the blinking WELCOME.

## LOVE STORY (`collection-1998/newbeer.vt`)

The title on the screen is "LOVE STORY", under the letters "d i g i t a l" in boxes, and it closes with "THE END". "Working
on a VT100" is only the description of textfiles.com. A man works at a VT100 until it smokes, goes to a pub ("GOLDEN LION"),
drinks until "Wot! No more Beer??" and leaves with a woman; "She Thinks" shows a heart with an arrow, "He thinks" a bed.
There is no signature. The spelling ("Wot!", the graffiti "I Woz ere") and the pub suggest that it is British; this is an
inference.

- **The oldest dated copy** is `nice-1994/declove.vt` (8 Apr 1994), the same animation under another name. It differs only in
  empty lines, a "1" at the start, and a last "show cursor". Nobody is named there either. It is not on the Scarecrow FTP
  listing of 13 Oct 1994.
- **The heart and the arrow** are the ones of "Happy Valentine's Day" (`vtgraph-1992/valentin--9c5f23.vt`, 29 May 1992): 73 of
  its 80 lines of 12 bytes or more are in `newbeer.vt`. In the Valentine the heart holds the names "BETH AND DAVE"; here it is empty.
- **The pub** is also in `textfiles/new_year.vt`, drawn again with another sign ("Toners") and other words ("What! No more
  Beer??"), and without the graffiti. Only 3% of the lines of `new_year.vt` are identical. The oldest date of `new_year.vt` is 2002.

Which of them borrowed from which is not known. `beer.vt` ("Time for a Beer Break, Folks!") is another work: no line of 12
bytes or more is the same.

## Stuck in Rabbit's Hole (`maistrelis/bear2.vt`)

A parody of "Winnie the Pooh" in 32 pictures with words: Pooh is stuck, Rabbit takes the honey away, and it ends badly ("THE END",
"unknown"). It was made to be read a screen at a time: "Center the screen and press the spacebar once for each screen".
The collector had it in February 1998 in `story.asc`, one of a set of files of ASCII art sorted by theme ("See
'winnie_the_pooh' for more !"), and on 8 Feb 1998 made it into an animation for his player ASCIIANI: every
picture as many times as it takes to read it (1 to 15), 157 frames of 600 ms. Every line is of the story, except the numbers 1 to 3 on
the first three frames.

The maker is not known. The story was not found anywhere else: not in the collector's two newsgroup mailboxes of 1996-99, nor in the asciiart.eu
archive of alt.ascii-art.animation, the collections compared here, or a web search (25 Nov 2026). The
set that `story.asc` belongs to is probably Andreas Freise's collection; this is an inference from the way
its files refer to one another.

## KANGAROO's JavaScript pages: who made what

*Applies to the files named in the table below. The pages themselves are not in this repository: the five animations
that were in no other folder are in `kangaroo/`.*

KANGAROO's "Great Ascii Art Library" (geocities.com/SouthBeach/Marina/4942) held ASCII animations that play in the
browser: the frames are strings in JavaScript, shown one after another in a text box. The FAQ of alt.ascii-art sent its
readers there for animations of this kind. The Wayback Machine kept 37 of its animation pages (captures of 2000 to
2008). Their titles, all but one, are already in the collector's copy of the index of the site, saved on 6 Oct 1997.
Below each animation there is a credit. On 25 Nov 2026 the frames of the 37 pages were compared with the files of this
repository.

**29 of the 37 were here already.** The frames are the same, in the same order, in 21 of them; in two more except for
blanks; in the other six with small differences. The site was a library: most of these animations are by other people,
and the page says so.

- **Sixteen are works of others, with their names:** Joan Stark (`crying`, `faerie`, `golf`, `hello`, `mlamp`,
  `sea_mons`, `swimlaps`, `tropics`), llizard (`band`, `chair`, `phoenix`, `tango`), Andreas Freise (`stage`,
  `station`), Shimrod (`fighting`), Clinton M. James (`spceship`). In twelve of them a signature in the picture (`jgs`,
  `ejm97`, `a:f`) confirms it; `band`, `tango`, `fighting` and `spceship` have none in these frames.
- **Nine are the same as a file here that was made from a post of KANGAROO's of 1997** (`bball`, `crash`, `dive3`,
  `f117`, `firework`, `kangaroo`, `monkey`, `parachut`, `parade`). For these the pages are later copies of one source,
  not a second one. `eye` is the same, and an older version exists: see below.
- **Three** are `earth` and `finger` (below), and `flamer`, whose maker the page does not know either.

Three more turned out to be here as well, by their frames: `prey2`, `macaren1` and `onlyone`. `prey` and `witch` are
other versions. `condom`, `elvis` and `swimmer` were not found. These five are now in
`kangaroo/`.

### Where the credit does not settle it

- **"Art by Unknown, Animated by KANGAROO"** stands under animations that are older. `earth` has the 30 frames of
  `globe.vt`, which was on the Scarecrow FTP on 23 Jan 1994; `prey2` those of `prey--7b414c.vt`, and 11 of the 12 of
  `prey.vt`, on the same FTP on 10 Mar 1994; `finger` those of `monkey.vt`, which carries a mail header of 1 May 1994
  (Gleb Shadeck, who sent it; not necessarily the maker). No post of KANGAROO's before 21 Apr 1997 was found. "Animated
  by" probably means "converted to my format"; this is an inference. Their makers remain unknown.
- **`eye`** credits an "Original frame by Brett Seargent, Animated by KANGAROO", as did the post of 22 Jul 1997.
  `collection-1998/eye.vt` was on the collector's disk on 23 Aug 1996, with no name in it. It moves the cursor, so it
  can be compared with the page only by lines. Whether KANGAROO made that one too is not known.
- **`parachut` was corrected.** The post of 22 Jul 1997 said "Art and Animation by llizard". The next day Veronica
  Karlsson answered: "Art by llizard, Idea/Joke by Erik, Animation by Veronica"
  ([post](https://www.asciiart.eu/archives/usenet/message/m0afbd6c805)). The page captured in 2007 has "Art by llizard,
  Erik K. Veland and Veronica Karlsson, Animation by Veronica Karlsson". The signature in the picture had named all
  three from the start (`ejm/Erik/VK`).
- **`spceship`** lacks the title screen of `sship.vt`, "Bye Bye Planet by Clinton M. James". The page has "Clint J".
- **`condom`** is credited to "Nana", while the picture is signed "Ts97". What the two have to do with each other is not
  known.
- **`macaren1`** has "Unknown". All its 9 frames are in `llizard/ll-macarena2.vt` ("Mr. Asciihead adds the obligatory
  Jump to the Macarena"), from llizard's site, where it is attributed to her only by inference. It has no frame in
  common with Leow Yee Ling's `usenet-1994-1999/macarena.vt`.
- **`onlyone`** has "Unknown" too, and so has `vk-junkyard/bikes.vt`: no name is known from either side.
- **`dive3`**: "Unknown" on the page; Veronica Karlsson's copy (`vk-junkyard/diver.vt`) is dated 19 Jul 1997 on her
  server, three days before the post.

### What these pages cannot tell

The captures are of 2000 to 2008, so they do not show who took a file from whom. What can be said rests on three things:
the signature in the picture, the credit line, and the oldest dated copy. A credit line has room for one or two names
where three people worked; it can lose a name that the file had; and it does not say what "Animated by" means.

Two of the pages, `chair` and `flamer`, do not run: their scripts have stray bytes 0xFF (1 and 6), in another capture of
each as well, and stop with an error. The bytes were left out to read the frames.

### The table

"Same" means: the same frames in the same order, trailing blanks and empty lines around the picture left aside.

| Page | In this repository | Credit on the page | Frames |
|---|---|---|---|
| [`band.htm`](https://web.archive.org/web/20000301151244/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/band.htm) | `llizard/ll-band.vt` | Art and Animation by llizard | same |
| [`bball.htm`](https://web.archive.org/web/20040806074145/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/bball.htm) | `usenet-1994-1999/baseball.vt` | Art and Animation by Joan Stark | same |
| [`chair.htm`](https://web.archive.org/web/20071123031857/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/chair.htm) | `llizard/ll-chair.vt` | Art and Animation by llizard | 37 of 44 frames the same; in the 7 others the page lacks the first line of the picture |
| [`condom.htm`](https://web.archive.org/web/20000301171947/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/condom.htm) | `kangaroo/condom.vt` | Art and Animation by Nana | new here; not found elsewhere |
| [`crash.htm`](https://web.archive.org/web/20071110004731/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/crash.htm) | `usenet-1994-1999/crash--3e0c23.vt` | Original frame by Shimrod Animated by KANGAROO | same |
| [`crying.htm`](https://web.archive.org/web/20000301194657/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/crying.htm) | `web-js-1997-1999/jgs-cry.vt` | Art and Animation by Joan Stark | same |
| [`dive3.htm`](https://web.archive.org/web/20050220190312/http://www.geocities.com/SouthBeach/Marina/4942/animation/dive3.htm) | `usenet-1994-1999/diving.vt`, `vk-junkyard/diver.vt` | Art and Animation by Unknown | same |
| [`earth.htm`](https://web.archive.org/web/20010422070725/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/earth.htm) | `collection-1998/globe.vt` | Art by Unknown Animated by KANGAROO | same 30 frames, except for blanks |
| [`elvis.htm`](https://web.archive.org/web/20000408225553/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/elvis.htm) | `kangaroo/elvis.vt` | Art and Animation by David Riley | new here; not found elsewhere |
| [`eye.htm`](https://web.archive.org/web/20000301214733/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/eye.htm) | `usenet-1994-1999/eye--1da09d.vt`, `collection-1998/eye.vt` | Original frame by Brett Seargent Animated by KANGAROO | same as the first; the second moves the cursor and can only be compared by lines |
| [`f117.htm`](https://web.archive.org/web/20071231121640/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/f117.htm) | `usenet-1994-1999/f117.vt` | Original frame by Unknown Animated by KANGAROO | same |
| [`faerie.htm`](https://web.archive.org/web/20010501045138/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/faerie.htm) | `vk-junkyard/joans-animated-pixie.vt` | Art and Animation by Joan Stark | same |
| [`fighting.htm`](https://web.archive.org/web/20010501045018/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/fighting.htm) | `vk-junkyard/fighting.vt` | Art and Animation by Shimrod | same |
| [`finger.htm`](https://web.archive.org/web/20050127052005/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/finger.htm) | `collection-1998/monkey.vt`, `textfiles/monkey--305b28.vt` | Art by Unknown Animated by KANGAROO | same 120 steps; some frames are repeated more often, and the page plays to the end and then backwards |
| [`firework.htm`](https://web.archive.org/web/20000409004038/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/firework.htm) | `usenet-1994-1999/fireworks--a137ba.vt` | Art and Animation by Joan Stark | same; the `.vt` has one more frame at the end, which the post of 1997 does not have either |
| [`flamer.htm`](https://web.archive.org/web/20000301235811/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/flamer.htm) | `vk-junkyard/flamer.vt` | Art and Animation by Unknown | same |
| [`golf.htm`](https://web.archive.org/web/20000302011811/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/golf.htm) | `web-js-1997-1999/jgs-golfanim.vt` | Art and Animation by Joan Stark | same |
| [`hello.htm`](https://web.archive.org/web/20000302035215/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/hello.htm) | `web-js-1997-1999/jgs-indexjs.vt` | Art and Animation by Joan Stark | same |
| [`kangaroo.htm`](https://web.archive.org/web/20080812032511/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/kangaroo.htm) | `usenet-1994-1999/kangaroo.vt` | Art and Animation by KANGAROO | same |
| [`macaren1.htm`](https://web.archive.org/web/20000613023511/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/macaren1.htm) | `llizard/ll-macarena2.vt` | Art and Animation by Unknown | its 9 frames are there in the same order; the `.vt` has one more |
| [`mlamp.htm`](https://web.archive.org/web/20010505195616/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/mlamp.htm) | `web-js-1997-1999/jgs-mlamp.vt` | Art and Animation by Joan Stark | same |
| [`monkey.htm`](https://web.archive.org/web/20000302054241/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/monkey.htm) | `usenet-1994-1999/monkey--905d66.vt` | Art and Animation by llizard | same |
| [`onlyone.htm`](https://web.archive.org/web/20050224015142/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/onlyone.htm) | `vk-junkyard/bikes.vt` | Art and Animation by Unknown | its 51 frames are among the 63 of the `.vt`, except for blanks |
| [`parachut.htm`](https://web.archive.org/web/20071123031902/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/parachut.htm) | `usenet-1994-1999/parachute.vt` | Art by llizard, Erik K. Veland and Veronica Karlsson Animation by Veronica Karlsson | same |
| [`parade.htm`](https://web.archive.org/web/20010505195606/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/parade.htm) | `usenet-1994-1999/parade.vt` | Art and Animation by Joan Stark | same; the `.vt` has one more frame at the end, which the post of 1997 does not have either |
| [`phoenix.htm`](https://web.archive.org/web/20010505195537/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/phoenix.htm) | `llizard/ll-phoenix_born.vt` | Art and Animation by llizard | 24 frames each; in every one the page has one more line at the bottom |
| [`prey.htm`](https://web.archive.org/web/20050127055958/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/prey.htm) | `kangaroo/prey--977a49.vt`; compare `collection-1998/prey_col.vt`, `textfiles/prey--7b414c.vt` | Art by Unknown Animated by KANGAROO | 30 frames, except for blanks 25 of them in `prey_col.vt`, 12 in `prey--7b414c.vt`: a longer version |
| [`prey2.htm`](https://web.archive.org/web/20050127060213/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/prey2.htm) | `textfiles/prey--7b414c.vt`, `collection-1998/prey.vt` | Art by Unknown Animated by KANGAROO | the 12 frames of the first, except for blanks; 11 of 12 in the second |
| [`sea_mons.htm`](https://web.archive.org/web/20000613100223/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/sea_mons.htm) | `web-js-1997-1999/jgs-monster.vt` | Art and Animation by Joan Stark | same |
| [`spceship.htm`](https://web.archive.org/web/20010507171827/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/spceship.htm) | `collection-1998/sship.vt` | Art and Animation by Clint J | same 232 frames; the title screen of the `.vt` is missing |
| [`stage.htm`](https://web.archive.org/web/20010507171755/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/stage.htm) | `web-js-1997-1999/freise-kiss.vt` | Art and Animation by Andreas Freise | same 46 frames, except for blanks |
| [`station.htm`](https://web.archive.org/web/20000302102330/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/station.htm) | `web-js-1997-1999/freise-station.vt` | Art and Animation by Andreas Freise | same |
| [`swimlaps.htm`](https://web.archive.org/web/20010513084546/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/swimlaps.htm) | `web-js-1997-1999/jgs-swimlap2.vt` | Art and Animation by Joan Stark | same |
| [`swimmer.htm`](https://web.archive.org/web/20000302111837/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/swimmer.htm) | `kangaroo/swimmer.vt` | Art and Animation by Joan Stark | new here; not found elsewhere |
| [`tango.htm`](https://web.archive.org/web/20010513084434/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/tango.htm) | `llizard/ll-TANGO.vt` | Art and Animation by llizard | same |
| [`tropics.htm`](https://web.archive.org/web/20050127064508/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/tropics.htm) | `web-js-1997-1999/jgs-amntrop.vt` | Art and Animation by Joan Stark | same |
| [`witch.htm`](https://web.archive.org/web/20000407103545/http://www.geocities.com:80/SouthBeach/Marina/4942/animation/witch.htm) | `kangaroo/witch.vt`; compare `web-js-1997-1999/freise-fly.vt` | Art and Animation by Andreas Freise | 50 frames each, none the same: the same scene, another drawing |

## Non-ASCII bytes lost in the online Usenet archives (U+FFFD)

*Applies to every file taken from the asciiart.eu Usenet archive (`usenet-1994-1999/`, names `date_subject_mXXXX.vt`),
and to some vt100-slowcat copies of Usenet posts.*

Usenet posts of the 1990s were 8-bit text with no declared character set: Latin-1 in Europe, the PC code page 437 in
ANSI art, Big5 on Taiwanese BBSes. The asciiart.eu archive serves every post as UTF-8. Each byte, or run of bytes, that
was not valid UTF-8 has been replaced by U+FFFD, the "replacement character" `�`. Where two Big5 bytes happen to
form a valid UTF-8 sequence, they survive as some other character. The loss cannot be undone from the archive copy.

The damage is in the pages as asciiart.eu sends them: the raw pages, saved unchanged, already contain
U+FFFD. Saving them did not cause it.

**Examples.**
- SAURON's "Some animation" (10 Apr 1997) is signed `El Señor de las Tinieblas ... compañero`. The copy in
  `collection-1998/sex.vt`, saved from a news server in 1998, has the Latin-1 byte `0xF1` (`ñ`). The asciiart.eu copy
  and the vt100-slowcat copy (`usenet-1994-1999/mike.vt`) both have `Se�or` and `compa�ero`. Two independent copies with the same
  damage suggest that it happened upstream of both, most likely in the Google Groups archive that both depend on. This
  is an inference.
- 15 posts from Taiwanese BBSes (Nov–Dec 1996), PC ANSI pictures in colour, lost all their Chinese text and the Big5
  block characters of their pictures, 100 to 675 bytes per post. Three of them are also in the collector's mailbox of
  December 1998, with the Big5 bytes intact. Once readable, they turned out to be still pictures and signatures, not
  animations; one of them is Joan Stark's Snoopy ("JOE COOL!", signed jgs), forwarded from the BBS 快樂小站 on 16 Dec
  1996. The 15 posts are therefore **not** in this repository.

**What is not affected.** VT100 animations are almost always pure 7-bit ASCII plus escape sequences, so their pictures
come through intact. Only PC ANSI art (code page 437), non-English text and signatures lose characters. To check a file:
`grep -c $'\xef\xbf\xbd' file.vt`.
