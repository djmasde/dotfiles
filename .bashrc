# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='[\u]\w \$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
upl-imgur() { 
	curl -# -F image=@"$1" -F "key=1913b4ac473c692372d108209958fd15" \
	http://api.imgur.com/2/upload.xml | grep -Eo "<original>(.)*</original>" \
	| grep -Eo "http://i.imgur.com/[^<]*"
}

# some more ls aliases
alias p8='ping 8.8.8.8'
alias detoxx='detox -s iso8859_1 -r'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ping8='ping -c4 8.8.8.8'
alias iwlink='sudo /usr/sbin/iw wlan1 link'
alias iwlink2='sudo /usr/sbin/iw wlan0 link'
alias iwscan='sudo /usr/sbin/iw wlan0 scan |less'
alias iwscan2='sudo /usr/sbin/iw wlan1 scan |less'
alias ippu='curl ip.appspot.com'
alias whoi='lsof -P -i -n'
#alias vps='ssh -p 1337 ircd@96.8.118.126'
alias vps='ssh -p 443 djdexter@188.40.44.117'
alias vpsx='ssh -p 1337 znc@23.94.249.163'
alias vpsxtunel='ssh -N -D 127.0.0.1:9090 znc@23.94.249.163 -p 1337'
alias ippublica='curl ifconfig.me'
#alias x11grab="ffmpeg -f x11grab -s 1366x768 -r 24 -i :0.0 -qscale 0 -vcodec huffyuv ~/grab.mkv ; ffmpeg -threads 8 -i ~/grab.mkv -crf 10 -b:v 3M ~/grab.webm"
alias weather2='telnet rainmaker.wunderground.com 3000'
function extract () {

    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjvf $1     ;;
        *.tar.gz)    tar xzvf $1     ;;
        *.tar.xz)    tar xJvf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar x $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xfv $1      ;;
        *.tbz2)      tar xjvf $1     ;;
        *.tgz)       tar xzvf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}
function dumpwav ()
#dumpear webm a wav raw
{
mplayer -novideo -ao pcm:fast $1
}
function lamemp3 ()
#pasar dump wav a mp3
{
lame -h -b 192 audiodump.wav $1
}
function nemesis ()
#destroy a zombie process
{
kill -HUP $(ps -A -ostat,ppid | grep -e '[zZ]'| awk '{ print $2 }')
}
function txtunixtowin ()
#convert unix format to "windoze format" (CRLF)
#parameters ej: txtunixtowin text1.txt text2.txt (output)
{
sed 's/$'"/`echo \\\r`/" $1 > $2
}
function txtwintounix ()
#convert CRLF "windoze format", to unix format
#parameters ej: txtwintounix text1.txt text2.txt (output)
{
tr -d '\r' < $1 > $2
}
#get 4chan images :problem moot? since /src/ is removed in i.4cdn.org, this version gets ok :3
#parameters: 4chandl dir to images + 4chan url thread ex: weadedir + thread of 4chan url
#2017/01/02 4chan changes i.4cdn.org to is.4chan.org target to two is* and get images :problem moot? :3
#2019/05/12 again is and is2.4chan.org.. And now download images and media normally :problem moot? :3 
function 4chandl ()
{
wget --no-check-certificate -nc -nd -H -r -A jpg,jpeg,gif,png,webm -D is.4chan.org -e robots=off -P $1 $2;
wget --no-check-certificate -nc -nd -H -r -A jpg,jpeg,gif,png,webm -D is2.4chan.org -e robots=off -P $1 $2;
#get --no-check-certificate -nc -nd -H -r -A jpg,jpeg,gif,png,webm -D i.4cdn.org -e robots=off -P $1 $2;
#delete thumbnails "chapuza"
cd $1
#rm $1*s*
rm *s*
cd $HOME
}
#dead

function hispachandl ()
{
#not 100% functional, gets thumbnails, and another image outside the thread :/
wget --no-check-certificate -nc -nd -r -H -A jpg,jpeg,gif,png -D hispachan.org -e robots=off -P $1 $2;
}
function nichandl ()
{
#not 100% functional, gets thumbnails, and another image outside the thread :/
wget --no-check-certificate -nc -nd -r -H -A jpg,jpeg,gif,png -D nido.org -e robots=off -P $1 $2;
}

function nullchandl ()
{
wget --no-check-certificate -nc -nd -H -r -A jpg,jpeg,gif,png,webm -D nullchan.org -e robots=off -P $1 $2;
}
function 2chandl () 
{ 
#wget -e robots=off -nvcdp -t 0 -Hkrl 0 -I \*/\*/src/ -P . $1 $2;
wget -e robots=off -nvcdp -t 0 -Hkrl 0 -I \*/\*/src/ -P $1 $2;
rm $1*.htm
}
function ponychandl () 
{ 
#downloads images from ponychan, problem with this?
wget -e robots=off -nvcdp -t 0 -Hkrl 0 -I \*/\*/src/ -P $1 $2;
rm $1*.html
}
function uguuup ()
{
curl -i -F name=$1 -F file=@$1 http://uguu.se/api.php?d=upload
}
#function cspeed() 
#{ 
#echo "scale=2; `curl --progress-bar -w "%{speed_download}" http://speedtest.wdc01.softlayer.com/downloads/test10.zip -o test.zip` / 131072" | bc | xargs -I {} echo {}Mb\/s 
#}
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
#export GOPATH="$HOME/src/go"
#sh $HOME/.fehbg &

#Initializes GNUstep
#source /opt/gnustep/System/Library/Makefiles/GNUstep.sh
source /etc/profile.d/openjdk.sh