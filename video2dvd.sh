#!/bin/bash
# AVI or any video 2 DVD iso Script
# DvdAuthor 7 and up needs this
export VIDEO_FORMAT=NTSC
#export VIDEO_FORMAT=PAL if use pal format
# Change to "ntsc" if you'd like to create NTSC disks
# Change to "pal" if you'd like to create PAL disks
# Requires: ffmpeg, dvdauthor, genisoimage (cdrkit package)
format="ntsc"
#format="pal" for pal format

# Check we have enough command line arguments
if [ $# -lt 1 ]
then
    echo "Usage: $0 <input file 1 ... input file n>"
    exit
fi

function emphasise() {
    echo ""
    echo "********** $1 **********"
    echo ""
}

# Check the files exists
for var in "$@"
do
    if [ ! -e "$var" ]
    then
        echo "File $var not found"
        exit
    fi
done

emphasise "Converting AVI to MPG"

for var in "$@"
do  
#normal dvd "sp mode"
#    ffmpeg -i "$var" -y -target ${format}-dvd -aspect 16:9 "$var.mpg"
#with compression "ep mode"
    ffmpeg -i "$var" -vf scale=720:480,fifo,pad=720:480:0:0:0x000000 -y -target ntsc-dvd -acodec ac3 -sn -g 12 -bf 2 -strict 1 -ac 2 -s 720x480 -trellis 1 -mbd 2 -b 5001000 -ab 224000 -aspect 16:9 "$var.mpg"
    if [ $? != 0 ]
    if [ $? != 0 ]
    then
        emphasise "Conversion failed"
        exit
    fi
done

emphasise "Creating XML file"

echo "<dvdauthor>
<vmgm />
<titleset>
<titles>
<pgc>" > dvd.xml

for var in "$@"
do
    echo "<vob file=\"$var.mpg\" />" >> dvd.xml
done

echo "</pgc>
</titles>
</titleset>
</dvdauthor>" >> dvd.xml

emphasise "Creating DVD contents"

dvdauthor -o dvd -x dvd.xml

if [ $? != 0 ]
then
    emphasise "DVD Creation failed"
    exit
fi

emphasise "Creating ISO image"

genisoimage -dvd-video -o dvd.iso dvd/

if [ $? != 0 ]
then
    emphasise "ISO Creation failed"
    exit
fi

# Everything passed. Cleanup
for var in "$@"
do
    rm -f "$var.mpg"
done
rm -rf dvd/
rm -f dvd.xml

emphasise "Success: dvd.iso image created"
