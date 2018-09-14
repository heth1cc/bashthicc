#!/bin/bash
cd "$(dirname ${BASH_SOURCE[0]})"

video="output"
url=$1
if [ -z "$url" ]; then
    echo Paste video url:
    read url
fi

youtube-dl $1 --output ${video}
echo please specify offset and duration in s example: 2 4
read offset duration

ffmpeg $video.mp4 -i $video.mkv
#ffmpeg $video.mp4 -i $video.mkv -ss $offset -t $duration
