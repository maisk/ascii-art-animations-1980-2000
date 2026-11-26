#!/bin/bash
# Copyright (c) 2026 Kostas Maistrelis. MIT licence: see LICENSE-MIT.
# play.sh - play VT100 animations from this repository by name, at the speed of a serial terminal (uses pv); those that
# also exist as text frames (.txt), with asciianm, the C player in asciianm/, if it has been built there (make).
#
#   ./play.sh chase                  plays chase.vt, if it is the only version with that name
#   ./play.sh fireworks              more than one version: lists them all and plays nothing;
#                                    run again with the full name: ./play.sh fireworks--77a1bd.vt
#   ./play.sh fireworks.vt           the full name (with .vt) plays exactly that file
#   ./play.sh ll-band                has text frames (ll-band.txt): plays them with asciianm, if it is there, else ll-band.vt
#   ./play.sh ll-band.txt            the text frames, with asciianm
#   ./play.sh ll-band.vt             the .vt, as a serial terminal
#   ./play.sh -2400 bunny            at 2400 baud (any number: -1200, -19200 ...); also -b 2400 or --baud 2400
#                                    (without it: the file's own speed, column `baud` of index.tsv, if it has one)
#   ./play.sh --loop 10 ll-hulahoop5 play it 10 times in a row (also -r 10); --loop inf: until Ctrl-C;
#                                    --loop 1: once (without it: column `loop` of index.tsv, if the file has one)
#   ./play.sh chase hanoi rose       several, one after the other (Enter = next, q = quit)
#   ./play.sh -l                     list every animation, folder by folder (also ./play.sh with no names)
#   ./play.sh -l bsd-1980            list one folder: playing time, speed, title and creator of each file
#   ./play.sh -l xmas                list every file whose name contains "xmas", the same way
#   ./play.sh -l -t                  every animation by playing time, shortest first (also -l -t FOLDER/NAME)
#   ./play.sh info chase             everything the index and provenance.tsv say about a file (also -i NAME)
#   ./play.sh -x chase vicki         play in a new xterm window: 80x24, or 80x25 for the MS-DOS files
#                                    (the window is resized for each file); also --xterm
#   ./play.sh -x --rows 25 FILE      xterm with 25 lines whatever the index says (-xdos = -x --rows 25)
#   ./play.sh -L 500 chase           pv's own rate limit, in characters/sec (also 1k, 2k ...)
#   ./play.sh -p chase               show pv's progress bar (it is drawn on the same screen)
#   cat file.vt | ./play.sh -        "-" reads the animation from stdin
#
# Names are looked up in every folder of the repository (case does not matter); file names are unique
# across the repository. When the same name exists in several versions, the extra versions are named
# name--xxxxxx.vt (xxxxxx = first 6 hex digits of the file's md5). A path to a file also works.
#
# Speed: -b/-2400 if given, else the file's `baud` in index.tsv (some files need a fast or an exact speed), else
# PLAY_BAUD, else 9600 baud = 960 characters per second (10 bits per character).
# Loop: --loop/-r if given, else the file's `loop` in index.tsv (a short animation that its page played over and over),
# else once.
# Text frames (.txt): the speed and the times are in the file itself. One that plays for ever is played for about 10
# seconds (at least once); --loop inf: until Ctrl-C. Keys: q ends it, space pauses, + and - change the speed. -b, -2400, -L and -p are about the serial line: with them a name
# without .txt plays the .vt.
# PLAY_XTERM=1 always plays in an xterm, as with -x. FS=20 FONT='Liberation Mono': its font size (16) and font.
# Use an 80x24 terminal. A few files were made for the 25-line screen of MS-DOS (column `rows` of index.tsv);
# for those play.sh asks first if the terminal is not 80x25 (with -x it resizes the xterm instead).
# Run "reset" if the terminal is left odd. Needs pv (not for text frames); -x also needs xterm (see INSTALL.md).

R=$(cd "$(dirname "$0")" && pwd)
# The folders of animations: at the top of the repository, or (in the public repository) under collections/.
DIRS=()
for d in "$R"/*/ "$R"/collections/*/; do
    [ -d "$d" ] || continue
    case "$d" in "$R/asciianm/"|"$R/collections/"|"$R/thumbs/") continue ;; esac
    DIRS+=("${d%/}")
done
# folder/file of a full path, as in index.tsv (without collections/)
relpath() { local p=${1#"$R"/}; printf '%s' "${p#collections/}"; }
PLAYER=$R/asciianm/asciianm     # the player of text frames, built with make

baud=""                        # -b / -2400: one speed for every file
defbaud=${PLAY_BAUD:-9600}      # for files without a `baud` of their own
list=0
xterm=0
case "${PLAY_XTERM:-0}" in 0|no|off) ;; *) xterm=1 ;; esac
rows=""       # --rows: lines every file needs (otherwise the `rows` column of the index, or 24)
lrate=""      # -L: rate in characters/sec, given as such
progress=0
loop=""       # --loop / -r: times every file is played in a row (inf: until Ctrl-C); else the `loop` column, or once
bytime=0      # -t: -l sorted by playing time
info=0        # info / -i: show what is known about the files instead of playing them
names=()
[ "$1" = info ] && { info=1; shift; }
while [ $# -gt 0 ]; do
    case "$1" in
        -h|--help)  sed -n '2,/^$/s/^# \{0,1\}//p' "$0"; exit 0 ;;
        -b|--baud)  baud=$2; shift ;;
        --baud=*)   baud=${1#--baud=} ;;
        -[0-9]*)    baud=${1#-} ;;
        -l|--list)  list=1 ;;
        -t|--time)  list=1; bytime=1 ;;
        -i|--info)  info=1 ;;
        -x|--xterm) xterm=1 ;;
        -xdos|--xdos) xterm=1; rows=25 ;;
        --rows)     rows=$2; shift ;;
        --rows=*)   rows=${1#--rows=} ;;
        -L|--rate-limit) lrate=$2; shift ;;
        -L*)        lrate=${1#-L} ;;
        --rate-limit=*) lrate=${1#--rate-limit=} ;;
        -p|--progress) progress=1 ;;
        -r|--loop)  loop=$2; shift ;;
        --loop=*)   loop=${1#--loop=} ;;
        --)         shift; names+=("$@"); break ;;
        -)          names+=("-") ;;
        -*)         echo "play.sh: unknown option $1 (see -h)" >&2; exit 1 ;;
        *)          names+=("$1") ;;
    esac
    shift
done
for b in "${baud:-1}" "$defbaud"; do
    case "$b" in ''|*[!0-9]*|0) echo "play.sh: bad baud rate: $b" >&2; exit 1 ;; esac
done
case "$rows" in ''|[1-9]|[1-9][0-9]) ;; *) echo "play.sh: bad number of rows: $rows" >&2; exit 1 ;; esac
case "$lrate" in ''|[1-9]*) ;; *) echo "play.sh: bad rate limit: $lrate" >&2; exit 1 ;; esac
case "$loop" in ''|inf|[1-9]|[1-9][0-9]|[1-9][0-9][0-9]) ;; *) echo "play.sh: bad loop count: $loop (1-999 or inf)" >&2; exit 1 ;; esac
pvopts=(-q); [ $progress = 1 ] && pvopts=(-p)

MD5='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
# glob-escape user text for find -iname
esc() { printf '%s' "$1" | sed 's/[][*?\\]/\\&/g'; }
# base name: without folder, .vt or .txt, and an md5 suffix
base() { local b=${1##*/}; b=${b%.[vV][tT]}; b=${b%.[tT][xX][tT]}; printf '%s' "${b%--$MD5}"; }
# the animations of the given folders (one per line; not READMEs, .tsv, or the .txt FAQs of faqs/)
animations() { find "$@" -maxdepth 1 -type f ! -name 'README*' ! -name '*.tsv' ! -name '*.txt' 2>/dev/null; }
# the text frames of an animation (name.txt next to name.vt; prints nothing if there are none), and the reverse
txt_of() { local t="${1%.*}.txt"; [ "$t" != "$1" ] && [ -f "$t" ] && [ "${1##*.}" = vt ] && printf '%s' "$t"; }
is_txt() { case "$1" in *.[tT][xX][tT]) [ -f "${1%.*}.vt" ] || head -c 10 "$1" 2>/dev/null | grep -q '^ARGUMENTS:' ;; *) return 1 ;; esac; }
# the settings of a .txt, from its first line: lines, columns, ms per frame, times (0 = for ever)
settings() { local l; IFS= read -r l < "$1"; IFS=: read -r _ t_lines t_cols t_ms t_times _ <<<"$l"
             case "$t_lines$t_cols$t_ms$t_times" in ''|*[!0-9]*) return 1 ;; esac; }
# matching files (one per line, sorted) for a find -iname pattern
lookup() { animations "${DIRS[@]}" -iname "$1" | sort -f; }
# every version of a base name: name.vt and name--xxxxxx.vt
versions() { local e; e=$(esc "$(base "$1")"); { lookup "$e.vt"; lookup "$e--$MD5.vt"; } | sort -f -u; }
# a column of index.tsv (one row per file of the repository) for folder/file $1, by the column's name $2
col_of() {
    local rel; rel=$(relpath "$1")
    awk -F'\t' -v d="${rel%/*}" -v n="${rel##*/}" -v k="$2" \
        'NR==1{for(i=1;i<=NF;i++) if($i==k) c=i; next} c && $1==d && $2==n {print $c; exit}' "$R/index.tsv" 2>/dev/null
}
# Full paths on stdin -> one line per file: the name to type, folder, playing time at the speed it would be played
# at (-b/-2400, else its `baud` in index.tsv, else PLAY_BAUD or 9600: 10 bits per character, as pv), and title - creator
# (else where it was found). With -t sorted by playing time. A last line gives the total when there are several.
describe() {
    local lr=""; case "$lrate" in [1-9]*) [ -z "${lrate//[0-9]/}" ] && lr=$lrate ;; esac   # -L with a plain number
    awk -F'\t' -v R="$R/" -v cli="$baud" -v def="$defbaud" -v lr="$lr" -v bytime="$bytime" -v cloop="$loop" '
        function dur(t,  h, m, s) { if (t < 1) return "<0:01"; t = int(t + 0.5); h = int(t / 3600); m = int(t / 60) % 60
                                    s = t % 60; return h ? sprintf("%d:%02d:%02d", h, m, s) : sprintf("%d:%02d", m, s) }
        FNR == NR { if (FNR == 1) { for (i = 1; i <= NF; i++) c[$i] = i; next }
                    k = $1 "/" $2; t = $c["title"]; w = $c["creator"]
                    if (t == "") t = $c["found_at"]; if (w != "" && w != "unknown") t = t " - " w
                    info[k] = t; tx[k] = $c["txt"]; by[k] = $c["bytes"]; bd[k] = $c["baud"]; lp[k] = $c["loop"]; next }
        { rel = substr($0, length(R) + 1); sub(/^collections\//, "", rel); n = rel; sub(/.*\//, "", n); d = rel; sub(/\/[^\/]*$/, "", d)
          b = cli != "" ? cli : (bd[rel] != "" ? bd[rel] : def)
          t = cloop == "inf" ? 1 : cloop != "" ? cloop : (lp[rel] > 1 ? lp[rel] : 1)          # times in a row
          sz = (rel in by) ? by[rel] : 0; sec = (lr != "" ? sz / lr : sz * 10 / b) * t; tot += sec; cnt++
          sp = (lr != "" ? lr " ch/s" : "at " b) (cloop == "inf" ? " x inf" : t > 1 ? " x" t : "")
          printf "%s\t  %-26s %-18s %8s %-13s %s\n", (bytime ? sec : NR), n, d "/", dur(sec), sp, (tx[rel] != "" ? "[txt] " : "") substr(info[rel], 1, 60) }
        END { if (cnt > 1) printf "%s\t  %d files, %s in all\n", 1e18, cnt, dur(tot) }' "$R/index.tsv" - |
        sort -t "$(printf '\t')" -k1,1g -s | cut -f2-
}

# names (one per line) in columns, down then across, for a screen $1 characters wide
columns() {
    awk -v W="$1" '{ a[NR] = $0; if (length($0) > m) m = length($0) }
        END { if (!NR) exit; cw = m + 2; nc = int((W - 2) / cw); if (nc < 1) nc = 1; nr = int((NR + nc - 1) / nc)
              for (r = 1; r <= nr; r++) { s = " "
                  for (c = 0; c < nc; c++) { i = c * nr + r; if (i <= NR) s = s " " sprintf("%-" cw "s", a[i]) }
                  sub(/ +$/, "", s); print s } }'
}

# every animation, folder by folder, in columns
list_all() {
    local d n w total=0 folders=0
    w=${COLUMNS:-$( [ -t 1 ] && tput cols 2>/dev/null )}; w=${w:-80}
    for d in "${DIRS[@]}"; do
        n=$(animations "$d" | grep -c .)
        [ "$n" -gt 0 ] || continue
        total=$((total + n)) folders=$((folders + 1))
        printf '%s/  (%s)\n' "${d##*/}" "$n"
        animations "$d" | sed 's|.*/||' | sort -f | columns "$w"
        echo
    done
    echo "$total animations in $folders folders."
    echo "Play one: ./play.sh NAME (\".vt\" can be left out). NAME.txt: the text frames, where there are any."
    echo "Details: ./play.sh -l FOLDER or ./play.sh -l PART-OF-NAME; by playing time: ./play.sh -l -t"
    echo "Options: ./play.sh -h"
}

[ $info = 1 ] && [ ${#names[@]} -eq 0 ] && { echo "usage: $0 info NAME [NAME ...]" >&2; exit 1; }
# no names: list everything (also without -l), folder by folder; with -t as one list by playing time
[ ${#names[@]} -eq 0 ] && [ $bytime = 0 ] && { list_all; exit 0; }

if [ $list = 1 ]; then
    [ ${#names[@]} -eq 0 ] && { animations "${DIRS[@]}" | sort -f | describe; exit 0; }   # -l -t: everything by time
    for n in "${names[@]}"; do
        if [ -d "$R/collections/${n%/}" ] && [ "${n%/}" != "" ]; then                     # a folder: every file in it
            animations "$R/collections/${n%/}" | sort -f
        elif [ -d "$R/${n%/}" ] && [ "${n%/}" != "" ] && [ "${n%/}" != asciianm ]; then
            animations "$R/${n%/}" | sort -f
        else
            lookup "*$(esc "$(base "$n")")*"
        fi
    done | describe
    exit 0
fi

# the number of frames of a .txt, without empty ones at its end (settings must have been read)
frames_of() { tr -d '\000' < "$1" | awk -v h="$t_lines" 'NR > 1 && /[^ \t\r]/ { n = NR - 1 } END { print int((n + h - 1) / h) }'; }

# Everything known about a file: its row of index.tsv and of provenance.tsv, one field per line (empty fields left out),
# long values wrapped to the width of the terminal.
show_info() {
    local rel w t ti="" t_lines t_cols t_ms t_times
    rel=$(relpath "$1")
    t=$(txt_of "$1")
    [ -n "$t" ] && settings "$t" && ti="$(frames_of "$t") frames of $t_lines lines, $t_ms ms each, $( [ "$t_times" = 0 ] && echo 'for ever' || echo "times: $t_times")"
    w=${COLUMNS:-$( [ -t 1 ] && tput cols 2>/dev/null )}; w=${w:-80}
    awk -F'\t' -v d="${rel%/*}" -v n="${rel##*/}" -v W="$w" -v cli="$baud" -v def="$defbaud" -v cloop="$loop" -v tinfo="$ti" '
        function dur(t,  h, m, s) { if (t < 1) return "<0:01"; t = int(t + 0.5); h = int(t / 3600); m = int(t / 60) % 60
                                    s = t % 60; return h ? sprintf("%d:%02d:%02d", h, m, s) : sprintf("%d:%02d", m, s) }
        function out(k, v,   pre, line, i, nw, wd) {          # "  key   value", wrapped under the value
            if (v == "") return
            pre = sprintf("  %-20s ", k); line = pre; nw = split(v, wd, " ")
            for (i = 1; i <= nw; i++) {
                if (line != pre && length(line) + 1 + length(wd[i]) > W - 1) { print line; line = sprintf("%23s", "") }
                line = line (line ~ / $/ ? "" : " ") wd[i]
            }
            print line
        }
        FNR == 1 { split("", c); for (i = 1; i <= NF; i++) c[$i] = i; part++; next }
        part == 1 && $1 == d && $2 == n { for (k in c) ix[k] = $c[k]; found = 1 }
        part == 2 && $c["folder"] == d && $c["file"] == n { for (k in c) pr[k] = $c[k] }
        END {
            print d "/" n
            if (!found) { print "  (not in index.tsv)"; exit }
            b = cli != "" ? cli : (ix["baud"] != "" ? ix["baud"] : def)
            out("title", ix["title"]); out("creator", ix["creator"]); out("people", ix["people"]); out("posters", ix["posters"]); out("date", ix["date"])
            out("certainty", ix["certainty"])
            k = cloop == "inf" ? 1 : cloop != "" ? cloop : (ix["loop"] > 1 ? ix["loop"] : 1)
            out("plays", dur(ix["bytes"] * 10 / b * k) " at " b " baud" (cli != "" ? " (given)" : ix["baud"] != "" ? " (the file\x27s own speed)" : " (default)") \
                (cloop == "inf" ? ", over and over (given)" : k > 1 ? ", " k " times in a row" (cloop != "" ? " (given)" : " (the file\x27s own loop)") : ""))
            if (ix["txt"] != "") out("txt", ix["txt"] ": the same as text frames, for asciianm; " tinfo)
            out("videos", ix["videos"])
            out("web_url", ix["web_url"])                     # its page on the blog, where it plays in the browser
            out("bytes", ix["bytes"]); out("md5", ix["md5"]); out("kind", ix["kind"])
            out("vt100_features", ix["vt100_features"]); out("rows", ix["rows"]); out("content", ix["content"])
            out("contains_email", ix["contains_email"]); out("found_at", ix["found_at"])
            out("origin", pr["origin"]); out("refs", pr["refs"]); out("also_in", pr["also_in"])
            out("scarecrow_ftp_1994", ix["scarecrow_ftp_1994"]); out("kai_voelcker_repost", ix["kai_voelcker_repost"])
            out("online_2026", ix["online_2026"]); out("online_where", ix["online_where"])
            out("notes", ix["notes"])
        }' "$R/index.tsv" "$R/provenance.tsv"
}

# ESC[r (reset scroll region) also homes the cursor: save/restore the cursor around it (ESC 7 / ESC 8)
restore() { [ -t 1 ] && printf '\033[0m\033(B\033)B\033[?25h\0337\033[r\0338\033[?7h\033[?5l'; }
trap 'restore; echo; exit 130' INT TERM

# screen height the file was made for: the `rows` column of index.tsv (empty if not listed); for text frames their
# lines (without ncurses one more, where the cursor ends up)
rows_of() {
    local t_lines t_cols t_ms t_times
    is_txt "$1" || { col_of "$1" rows; return; }
    settings "$1" || return
    "$PLAYER" -v 2>/dev/null | grep -q Curses || t_lines=$((t_lines + 1))
    echo $(( t_lines > 24 ? t_lines : 24 ))
}

# lines of the terminal now
term_lines() { local s; s=$(stty size </dev/tty 2>/dev/null) && echo "${s% *}" || tput lines 2>/dev/null; }

# a file played again (loop): without the clear screen (ESC[2J) at its very start, if it has one (after ESC[H or
# ESC[...m only), so that the screen does not flash empty between two passes: the files that loop redraw every frame whole
again() {
    local p
    p=$(head -c 32 "$1" 2>/dev/null | LC_ALL=C tr '\033' '~')
    if [[ $p =~ ^((~\[[0-9\;]*[mH])*)~\[2J ]]; then
        printf '%s' "${BASH_REMATCH[1]}" | tr '~' '\033'
        tail -c +$(( ${#BASH_REMATCH[0]} + 1 )) "$1"
    else
        cat "$1"
    fi
}

# play the text frames $1 with asciianm; sets `speed` for the line after it
play_txt() {
    local f=$1 n one t_lines t_cols t_ms t_times ansi=()
    settings "$f" || { echo "play.sh: $f: no ARGUMENTS line" >&2; return 1; }
    one=$(( $(frames_of "$f") * t_ms ))            # one pass, in ms
    n=$t_times
    [ "$n" = 0 ] && { n=1; [ "$one" -gt 0 ] && [ "$one" -lt 10000 ] && n=$(( (10000 + one / 2) / one )); }
    case "$loop" in '') ;; inf) n=0 ;; *) n=$loop ;; esac
    speed="text frames, $t_ms ms each"
    case "$n" in 0) speed="$speed, over and over" ;; 1) ;; *) speed="$speed, $n times" ;; esac
    # a terminal with fewer lines: ncurses would refuse
    [ "$(term_lines)" -lt "$t_lines" ] 2>/dev/null && ansi=(-ansi)
    "$PLAYER" "$f" "$t_ms" "$t_lines" "$t_cols" "$n" "${ansi[@]}" 2> >(grep -v '^Warning: illegal' >&2)
}

# play one file, then show its name and baud; $2 = 1 if another file follows (then ask: Enter = next, q = quit)
play() {
    local f=$1 more=$2 o other ans need lines label i fb rate speed n k
    need=${rows:-$(rows_of "$f")}; need=${need:-24}
    fb=${baud:-$(col_of "$f" baud)}; fb=${fb:-$defbaud}     # the speed for this file
    rate=${lrate:-$((fb / 10))}
    speed="$fb baud"; [ -n "$lrate" ] && speed="$lrate chars/sec"
    n=${loop:-$(col_of "$f" loop)}; case "$n" in inf) ;; ''|*[!0-9]*|0) n=1 ;; esac    # times in a row
    [ "$f" = - ] && n=1                                                               # stdin: read once
    [ "$n" = 1 ] || speed="$speed, $( [ "$n" = inf ] && echo 'over and over' || echo "$n times")"
    if [ -t 1 ] && [ "${PLAY_IN_XTERM:-0}" = 1 ]; then
        # our own xterm (-x): resize it to the lines this file needs. Of xterm's window operations, -x allows
        # only this one (8: size in characters); the others (title/selection reports ...) stay off.
        lines=$(term_lines)
        if [ "$lines" != "$need" ]; then
            printf '\033[8;%s;80t' "$need"
            for i in 1 2 3 4 5 6 7 8 9 10; do sleep 0.1; lines=$(term_lines); [ "$lines" = "$need" ] && break; done
        fi
    fi
    if [ "$need" != 24 ] && [ -t 1 ]; then
        lines=$(term_lines)
        if is_txt "$f" && [ "${lines:-0}" -ge "$need" ]; then :       # frames: a taller terminal does no harm
        elif [ "$lines" != "$need" ]; then
            if [ "$need" = 25 ] && ! is_txt "$f"; then printf '%s was made for an 80x25 screen (MS-DOS)' "${f##*/}"
            else printf '%s needs %s lines' "${f##*/}"  "$need"; fi
            printf '; this terminal has %s lines.\n' "$lines"
            printf 'Enter = play anyway, q = skip (or: %s -x %s) ' "$0" "${f##*/}"
            { read -r ans </dev/tty; } 2>/dev/null || read -r ans
            [ "$ans" = q ] && return 0
        fi
    fi
    printf '\033[H\033[2J\033[?25l'
    if is_txt "$f"; then
        play_txt "$f"
    elif [ "$n" = 1 ]; then
        pv "${pvopts[@]}" -L "$rate" "$f"
    elif [ "$n" = inf ]; then
        { cat "$f"; while :; do again "$f" || break; done; } | pv "${pvopts[@]}" -L "$rate"
    else
        { cat "$f"; for ((k = 1; k < n; k++)); do again "$f"; done; } | pv "${pvopts[@]}" -s $(( $(wc -c < "$f") * n )) -L "$rate"
    fi
    restore
    if [ "$f" = - ] || [ "$f" = "${PLAY_TMP:-}" ]; then
        label=stdin other=""
    else
        label=$(relpath "$f")
        o=$f; is_txt "$f" && o=${f%.*}.vt
        other=$(versions "$f" | grep -v -x -F "$o" | sed 's|.*/||' | tr '\n' ' ')
    fi
    printf '\n\033[7m %s  (%s) \033[0m' "$label" "$speed"
    [ -n "$other" ] && printf '  other versions: %s' "$other"
    printf '\n'
    case "$hint" in *"|$f|"*) echo "Also as text frames, at the right speed; to build their player: make -C '$R/asciianm'" ;; esac
    [ "$more" = 1 ] || return 0
    printf 'Enter = next, q = quit '
    { read -r ans </dev/tty; } 2>/dev/null || read -r ans
    [ "$ans" = q ] && exit 0
}

# Decide what a name means. Prints the file to play, or explains and returns 1.
resolve() {
    local n=$1 e hits c
    [ "$n" = - ] && { echo -; return 0; }        # stdin
    [ -f "$n" ] && { printf '%s/%s\n' "$(cd "$(dirname "$n")" && pwd)" "${n##*/}"; return 0; }   # full path: index lookups
    e=$(esc "${n##*/}")
    case "$n" in
        *.[tT][xX][tT])                           # text frames: the .txt next to a .vt
            hits=$(lookup "$(esc "$(basename "${n%.*}")").vt" | while read -r c; do txt_of "$c" && echo; done)
            [ -n "$hits" ] && { printf '%s\n' "$hits" | head -1; return 0; }
            hits=$(versions "$n")
            [ -n "$hits" ] && { echo "\"$n\" does not exist: no text frames with that name. Versions ([txt] = has text frames):" >&2
                                printf '%s\n' "$hits" | describe >&2; return 1; } ;;
        *.[vV][tT])                               # full name: exactly that file
            hits=$(lookup "$e")
            [ -n "$hits" ] && { printf '%s\n' "$hits" | head -1; return 0; }
            hits=$(versions "$n")
            [ -n "$hits" ] && { echo "\"$n\" does not exist. Versions with that name:" >&2; printf '%s\n' "$hits" | describe >&2; return 1; } ;;
        *--$MD5)                                  # md5 suffix, no .vt: names one file already
            hits=$(lookup "$e.vt")
            [ -n "$hits" ] && { printf '%s\n' "$hits" | head -1; return 0; } ;;
        *)                                        # no .vt: fine if there is only one version
            hits=$(versions "$n")
            [ -z "$hits" ] && hits=$(lookup "$e.vt")   # e.g. "dum--sleepycat"
            c=$(printf '%s' "$hits" | grep -c .)
            [ "$c" = 1 ] && { printf '%s\n' "$hits"; return 0; }
            first=${hits%%$'\n'*}
            [ "$c" -gt 1 ] && { echo "\"$n\" exists in $c versions. Run again with the full name, e.g. ./play.sh ${first##*/}" >&2
                                printf '%s\n' "$hits" | describe >&2; return 1; } ;;
    esac
    hits=$(lookup "*$(esc "$(base "$n")")*" | head -20)
    if [ -n "$hits" ]; then echo "\"$n\" not found. Similar names:" >&2; printf '%s\n' "$hits" | describe >&2
    else echo "\"$n\": nothing found (try ./play.sh -l part-of-name)" >&2; fi
    return 1
}

# resolve every name first, so that "N versions" messages are not wiped by the first animation
# a name without .vt or .txt: the text frames, if there are any and asciianm has been built (-b, -L, -p: the .vt)
st=0 files=()
hint="|"                        # the .vt files played because asciianm is not built
serial="$baud$lrate"; [ $progress = 1 ] && serial=1
for n in "${names[@]}"; do
    f=$(resolve "$n") || { st=2; continue; }
    if [ $info = 1 ]; then is_txt "$f" && f=${f%.*}.vt
    elif is_txt "$f"; then
        [ -x "$PLAYER" ] || { b=${f##*/}
                              echo "play.sh: $b needs asciianm, the player of text frames, which is not built yet:" >&2
                              echo "play.sh: make -C '$R/asciianm'   (see INSTALL.md). Or play the .vt: $0 ${b%.*}.vt" >&2
                              st=2; continue; }
    else
        case "$n" in
            *.[vV][tT]|-) ;;
            *)  t=$(txt_of "$f")
                if [ -n "$t" ] && [ -z "$serial" ]; then
                    if [ -x "$PLAYER" ]; then f=$t
                    else hint="$hint$f|"; fi
                fi ;;
        esac
    fi
    files+=("$f")
done
if [ $info = 1 ]; then                       # info: show, do not play
    for i in "${!files[@]}"; do [ "$i" -gt 0 ] && echo; show_info "${files[$i]}"; done
    exit $st
fi
if [ $st = 2 ] && [ ${#files[@]} -gt 0 ] && [ -t 1 ]; then
    printf 'Enter = play the rest anyway, q = quit '
    { read -r ans </dev/tty; } 2>/dev/null || read -r ans
    [ "$ans" = q ] && exit $st
fi
[ ${#files[@]} -eq 0 ] && exit $st

# playing needs pv (Pipe Viewer), except text frames; -h, -l and info work without it
needpv=0
for f in "${files[@]}"; do is_txt "$f" || needpv=1; done
if [ $needpv = 1 ] && ! command -v pv >/dev/null 2>&1; then
    echo "play.sh: error: pv (Pipe Viewer) is not installed, and play.sh needs it to play the animations." >&2
    echo "play.sh: see $R/INSTALL.md (e.g. sudo apt install pv; https://ivarch.com/programs/pv.shtml)" >&2
    exit 1
fi

# -x: run play.sh itself, with the files found, inside a new xterm, and return at once
if [ $xterm = 1 ]; then
    command -v xterm >/dev/null 2>&1 || { echo "play.sh: error: -x needs xterm (e.g. sudo apt install xterm; see $R/INSTALL.md)" >&2; exit 1; }
    tmp=""
    for i in "${!files[@]}"; do
        [ "${files[$i]}" = - ] || continue
        # data from a pipe: keep it in a temp file for the xterm (removed when the xterm closes)
        [ -t 0 ] && { echo "play.sh: \"-\" needs a pipe: cat file.vt | $0 -x -" >&2; exit 1; }
        [ -z "$tmp" ] && { tmp=$(mktemp --tmpdir play.XXXXXX.vt) && cat > "$tmp" || exit 1; }
        files[$i]=$tmp
    done
    fwd=(); [ -n "$baud" ] && fwd+=(-b "$baud")     # else each file at its own speed (PLAY_BAUD goes with the environment)
    [ -n "$lrate" ] && fwd+=(-L "$lrate")
    [ -n "$rows" ] && fwd+=(--rows "$rows")
    [ $progress = 1 ] && fwd+=(-p)
    [ -n "$loop" ] && fwd+=(--loop "$loop")
    first=${rows:-$(rows_of "${files[0]}")}
    PLAY_XTERM=0 PLAY_IN_XTERM=1 PLAY_TMP=$tmp \
    xterm -title "play.sh ${names[*]}" \
          -fa "${FONT:-DejaVu Sans Mono}" -fs "${FS:-16}" -geometry "80x${first:-24}" \
          -bg black -fg gray90 -cr gray90 \
          -xrm 'XTerm*c132: true' \
          -xrm 'XTerm*disallowedWindowOps: 1,2,3,4,5,6,7,9,11,13,14,18,19,20,21,GetSelection,SetSelection,SetWinLines,SetXprop' \
          -e bash -c '"$0" "$@"; echo; read -rp "-- end, Enter to close --"; [ -n "$PLAY_TMP" ] && rm -f "$PLAY_TMP"' \
             "$R/play.sh" "${fwd[@]}" -- "${files[@]}" &
    exit $st
fi

# the screen is left as it is after the last one (no clear)
for i in "${!files[@]}"; do
    play "${files[$i]}" $(( i + 1 < ${#files[@]} ))
done
exit $st
