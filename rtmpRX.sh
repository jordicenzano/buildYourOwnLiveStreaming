#!/usr/bin/env bash

# Acts as RMTP server for application named live (expects stream)
# transmux the media data into TS and send them to local port 2000

echo "Starting RMTP server"
ffmpeg -hide_banner \
-listen 1 -re -i "rtmp://0.0.0.0:1935/live/stream" \
-codec copy \
-f mpegts \
udp://localhost:2000

