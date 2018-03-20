#!/bin/bash -e

###
# Is brew installed? It is?! Update!
###
which -s brew
if [[ $? != 0 ]] ; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update    
fi

## Install the necessary stuff
brew install emacs
brew services start emacs # quickly please!

brew install python
brew cask
brew cask install Caskroom/versions/java7
brew cask install java

###
# Install brew packages if they aren't installed
###
PACKAGES="
ack
apache-spark
cgal
colordiff
coreutils
findutils
freetype
gdal
gdbm
ghc
gnupg
gnu-sed
gnu-tar
hadoop
haskell-stack
htop
httpie
imagemagick
jpeg
jq
kafka
leiningen
libtool
maven
mit-scheme
mono
mosh
mysql
netcat
node
openssl
p7zip
parallel
pass
phantomjs
postgis
postgresql
proj
pv
readline
redis
s3cmd
sbt
scala
sfcgal
sqlite
valgrind
tree
watchman
xvid
xz
"

for arg in `echo $PACKAGES`
do
    which -s $arg || brew install $arg
done

###
# Casks
###
brew cask install ngrok
brew cask install virtualbox
brew cask install vagrant
brew cask install docker

###
# Caveats and stuff
###
brew services start mysql
brew services restart postgresql
brew services start redis
brew services start kafka

# get ghc
stack setup

# symlink for emacs
ln -s ~/.bash_profile ~/.bashrc

###
# Done
###
brew list

exit 0
