#!/usr/bin/env bash

DURATION_S=2592000 #1 month

ffmpeg -f lavfi -re -i smptebars=duration=$DURATION_S:size=1280x720:rate=30 \
-f lavfi -re -i sine=frequency=1000:duration=$DURATION_S:sample_rate=44100 \
-pix_fmt yuv420p -c:v libx264 -b:v 1000k -g 30 -keyint_min 120 -profile:v baseline -preset veryfast \
-c:a aac -b:a 96k \
-f flv rtmp://0.0.0.0:1935/live/stream

