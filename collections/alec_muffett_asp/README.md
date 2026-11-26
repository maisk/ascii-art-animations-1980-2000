# ASP demonstrations, by Alec Muffett (1991)

ASP, "Alec's Scrolling Program", is a small description language for `.plan` animations that Alec Muffett wrote in
September 1991 at the Computer Unit of the University College of Wales, Aberystwyth, "to finish a war over who could make
the longest, best, and prettiest ".plan" files, using only the printable ascii character set". Its output uses only printable
characters, carriage returns and a few line feeds: no escape sequences at all. A pause is a run of carriage returns
("approximately 2Kb … roughly 1 second at 9600 baud"), so the speed of the line is the clock.

The five files are the demonstrations that come with ASP, compiled and run in November 2026. Play them at 9600 baud
(`../play.sh`, or `pv -qL 960`).

| File | Bytes | At 9600 baud | What it is |
|---|---|---|---|
| `demo1.vt` | 50,876 | ~52 s | "Beware the M25 - heavy lorries !": a lorry drives across (also the example in ASP's manual) |
| `demo2.vt` | 191,642 | ~3 min 20 s | **"The Andalusian Video Snail"**, signed "Alec D.E. Muffett / Roadrunner>>>++>> (using asp 3.2)" |
| `demo3.vt` | 365,952 | ~6 min 20 s | "A Roadrunner>>>++>> production": the story of the `.plan` war, and a tour of what ASP can do |
| `demo4.vt` | 272,894 | ~4 min 45 s | "I'm sad … Is it because my Andalusian Video snail escaped ?" |
| `demo5.vt` | 300,722 | ~5 min 15 s | "Now it's my turn to show off": the effects added in ASP 3.1, with thanks to the two students of the war |

"Roadrunner>>>++>>" is Muffett himself: demo 3, signed with it, says "I sat down, and I wrote "ASP"".

## Where they come from

- **Source:** ASP v3.5, `asp,3.5.tar.gz` (files dated 11 December 1997), from the author's site,
  https://alecmuffett.com/alecm/software/asp/ . The manual inside keeps the notes of v3.2 (September 1991), v3.4 (March
  1995) and v3.5 (December 1997).
- **Made with:** `gcc -std=gnu89 -o asp anim.c asp.c copy.c display.c effects.c`, then `./asp < demoN.asp > demoN.vt` for
  each demo. The program must read the demo on its standard input: when that is not a terminal, it ignores the file name.
- **Every run is slightly different.** ASP seeds its random numbers with the time (`srand(time(0))`), and effects such as
  `.fade` and `.spatter` remove the characters in random order. These files are one run; another run differs only inside
  those effects.
- Each file ends with ASP's own signature line, with the version, the author's address of 1997 and the date ("11dec97"). It
  is part of the program's output and is left as it is.

## The same snail in 1991

`../collection-1998/snails.vt` (the 1998 collection; in circulation by February 1994, see `../PROVENANCE.md`) is **demo 2 of
ASP 3.2**: it ends with the signature line "asp3.2(c)aem@aber". Compared line by line with `demo2.vt`, the two differ only
inside the random effects (711 of about 150,600 lines) and in the signature line. So the snail of the newsgroup's early
archives is Muffett's own demonstration of ASP.

In August 2018 Muffett put the same demonstration on YouTube, played at about 9600 baud:
"Animated ".plan" file example", https://www.youtube.com/watch?v=xMFzspwuQZw .

ASP is "freely redistributable as long as this copyright notice remains intact" (`asp.h`, © ADE Muffett, September 1991).
