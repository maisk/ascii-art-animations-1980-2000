# Installing what `play.sh` needs

The `.vt` files need no installation: they are plain terminal output. But `cat` shows them in a blink, because their
timing came from the speed of a serial line. `play.sh` slows them down to that speed, and for this it needs **pv**.

`make` (in this folder) checks what of the following is there, builds asciianm, and says what to do about anything missing.

## pv (Pipe Viewer)

`play.sh` sends each file to the terminal through `pv -q -L RATE`. This limits the output to RATE characters per second,
like a serial line (9600 baud = 960 characters per second).

pv is by Andrew Wood: <https://ivarch.com/programs/pv.shtml>. Most systems have it as a package:

| System | Command |
|---|---|
| Debian, Ubuntu, Mint | `sudo apt install pv` |
| Fedora, RHEL, Rocky, Alma | `sudo dnf install pv` (on RHEL-like systems from EPEL) |
| Arch, Manjaro | `sudo pacman -S pv` |
| openSUSE | `sudo zypper install pv` |
| Alpine | `sudo apk add pv` |
| macOS (Homebrew) | `brew install pv` |
| macOS (MacPorts) | `sudo port install pv` |
| FreeBSD | `pkg install pv` |
| Windows | use WSL (Windows Subsystem for Linux), then as for Ubuntu |

Otherwise, build it from source, as the page above describes.

Check that it works:

```sh
pv --version
./play.sh chase
```

Without pv, `play.sh` stops with an error that points to this file. `./play.sh -h`, `./play.sh -l` and `./play.sh info NAME`
work without pv, and so do the text frames (below).

## asciianm (for the text frames, optional)

Some animations are also here as text frames, `NAME.txt` next to `NAME.vt` (`[txt]` in `./play.sh -l FOLDER`). Their player is
a small C program in `asciianm/`, that keeps the time between the frames (keys: `q` ends it, space pauses, `+` and `-` change the speed):

```sh
make                     # or: make -C asciianm
./play.sh ll-band        # the text frames, because they exist and the player is built
./play.sh ll-band.vt     # the .vt, at the speed of a serial line
```

It needs a C compiler and make (Debian, Ubuntu: `sudo apt install build-essential libncurses-dev`; Fedora:
`sudo dnf install gcc make ncurses-devel`; macOS: `xcode-select --install`). Without ncurses it is built for ANSI terminals.
Without asciianm, `play.sh` plays the `.vt` of these animations.

## xterm (only for `play.sh -x`)

`./play.sh -x NAME` plays in a new xterm window of the right size: 80x24, or 80x25 for the files made for MS-DOS.
It also turns on 132 columns, which some files need. For this you need **xterm** (`sudo apt install xterm`,
`sudo dnf install xterm`, `brew install --cask xquartz` on macOS, which includes it). Without `-x` you do not need it.

## The rest

`play.sh` also needs `bash`, `find`, `awk`, `sed`, `sort`, `wc` and `stty`/`tput`. Every Linux and macOS system has them.

The terminal: **80x24** (a few files need 80x25, see `README.md`), a VT100-compatible emulator such as xterm. Most
modern emulators lack some VT100 features (double-size letters, smooth scroll); `README.md` lists which files use them.
