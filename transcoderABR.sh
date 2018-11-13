#!/usr/bin/env bash

# Clean and create origin
echo "Restarting ./origin directory"
rm -rf ./origin/*
mkdir -p ./origin

# Create master playlist
echo "Creating master playlist manifest (playlist.m3u8)"
echo "#EXTM3U" > ./origin/playlist.m3u8
echo "#EXT-X-VERSION:3" >> ./origin/playlist.m3u8
echo "#EXT-X-STREAM-INF:BANDWIDTH=996000,RESOLUTION=854x480" >> ./origin/playlist.m3u8
echo "480p.m3u8" >> ./origin/playlist.m3u8
echo "#EXT-X-STREAM-INF:BANDWIDTH=548000,RESOLUTION=640x360" >> ./origin/playlist.m3u8
echo "360p.m3u8" >> ./origin/playlist.m3u8

# Create default index file
echo "Creating default index file"
echo "Hello this is my test about create your own live streaming platform.\nTry HOST/playlist.m3u8" > ./origin/index.html

#Select font path based in OS
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    FONT_PATH='/usr/share/fonts/dejavu/DejaVuSans-Bold.ttf'
elif [[ "$OSTYPE" == "darwin"* ]]; then
    FONT_PATH='/Library/Fonts/Arial.ttf'
fi

# Create 2 renditions from a TS input stream
# 854x480@30fps 1000Kbps 1 Kf / 2s (+ Overlay)
# 640x360@30fps 500Kbps 1kf / 2s (+ Overlay)

echo "Starting transcoder"
ffmpeg -hide_banner -y \
-re -i "udp://localhost:2000" \
-vf scale=854x480 \
-vf "drawtext=fontfile=$FONT_PATH: text=\'RENDITION 1 - Local time %{localtime\: %Y\/%m\/%d %H.%M.%S} (%{n})\': x=0: y=0: fontsize=36: fontcolor=pink: box=1: boxcolor=0x00000099" \
-c:v libx264 -b:v 900k -g 60 -profile:v baseline -preset veryfast \
-c:a aac -b:a 48k \
-hls_flags delete_segments -hls_time 6 -hls_segment_filename ./origin/480p_%05d.ts ./origin/480p.m3u8  \
-vf scale=640x360 \
-vf "drawtext=fontfile=$FONT_PATH: text=\'RENDITION 2 - Local time %{localtime\: %Y\/%m\/%d %H.%M.%S} (%{n})\': x=0: y=0: fontsize=36: fontcolor=pink: box=1: boxcolor=0x00000099" \
-c:v libx264 -b:v 500k -g 60 -profile:v baseline -preset veryfast \
-c:a aac -b:a 48k \
-hls_flags delete_segments -hls_time 6 -hls_segment_filename ./origin/360p_%05d.ts ./origin/360p.m3u8  \
