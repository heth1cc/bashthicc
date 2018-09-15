#!/bin/bash
cd "$(dirname ${BASH_SOURCE[0]})"

video="output/video"

url=$1
if [ -z "$url" ]; then
    echo Paste video url:
    read url
fi

echo "offset and duration (hh:mm:ss):"
read offset duration

if [ -z "$offset" ]; then offset=0; fi
if [ -z "$duration" ]; then duration=99999999; fi

youtube-dl $1 --output ${video}
ffmpeg -i $video.mkv -ss $offset -t $duration -y -strict -2 $video.mp4