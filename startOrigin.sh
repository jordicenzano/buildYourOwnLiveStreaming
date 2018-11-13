#!/usr/bin/env bash

# Start a webserver on port 80
# Allow CORS *
# Set mag-age 3s

sudo static -a 0.0.0.0 -p 80 -c 3 \
-H '{"Access-Control-Allow-Origin": "*","Access-Control-Allow-Methods": "GET","Access-Control-Allow-Headers": "Content-Type"}' \
./origin

