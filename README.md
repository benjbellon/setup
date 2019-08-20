# Setup

Run setup.sh for a bare minimal setup.

## Local Enviornment
`.bash_profile` loads `.bash_profile.local` to keep a private local environment
`.bashrc` loads `.bashrc.local` to keep a private local environment

## Things to do

### $PROJ_DIR/scripts

General scripts should be installed/symlinked into `/usr/local/bin`

i3blocks scripts should be installed/symlinked into `/usr/local/i3blocks/`

```
for i in $(ls ~/.setup/configs/i3/i3blocks/scripts); do sudo ln -s ~/.setup/configs/i3/i3blocks/scripts/$i $i; done
```

### Udev Rules
https://wiki.archlinux.org/index.php/Udev

When using i3wm, it's nice to have external displays automatically detected. Since /sys isn't a real filesystem, inotifywait has no guarantees. Thus, we write a udev rule which points to our `$PROJ_DIR/i3/format_displays.sh` script.

_TODO_

#### Suggested Applications

These application packages are based on the packages from [archlinux.org](https://www.archlinux.org/packages/). Each distro will vary.

> Note for ArchLinux users: Not all these packages are available from the standard repos. `cower` is recommended as a great lookup, discovery, and download tool, so you don't need to remember the entire snapshot URL ;)

**From the package manager**:
autoconf
automake
binutils
bash
clojure
cmake
docker
docker-compose
dropbox
emacs-git
firefox
gcc
gcc-libs
gdb
ghc
gimp
git
glibc
go
grep
gzip
htop
jdk8-openjdk
jq
keychain
less
libreoffice-fresh
libtool
nasm
npm
openssh
pass
patchelf
python
python-pip
rsync
sbcl
sbt
scala
screen
texlive-core
vim
xsel

**Self managed /usr/local**:
arcanist
libphutil

**ArchLinux specific**:
alsa-utils
bluez-utils
broadcom-wl
chromium
chromium-widevine
cower
intel-ucode (for macbookpro)
mbpfan-git
networkmanager
pepper-flash
tzupdate
wpa_supplicant

**Gnome Specific**
boabab

#### Monospaced fonts I like
[Adobe Source Code Pro](https://github.com/adobe-fonts/source-code-pro)
