# buildYourOwnLiveStreaming

## Introduction
- You need to lunch a linux machine in any cloud you like (GCP, AWS, Azure, etc), debian recommended. Make sure you have enought compute power to process all the renditions you want (I used a GCP 2 vCPUs, 10 GB memory to create 2 renditions)
- You need to install the necessary dependencies, see below:
```
# Upgrade & update machine
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install git -y

# Install FFMPEG
sudo apt-get install ffmpeg -y

# Install node
Sudo curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
sudo apt-get install nodejs -y

# Install web server (origin)
sudo npm install -g node-static
```
- Be sure you follow the instructions of the specific cloud you are deploying to open the for ingress TCP trafics the ports 1935 and 80 (for GCP [FW rules](https://cloud.google.com/vpc/docs/using-firewalls))
- You can SSH that machine (follow the instructions of the specific cloud on how to do that, for GCP [Connecting to VM](https://cloud.google.com/compute/docs/instances/connecting-to-instance))
- Using a tool to create a persistent session (like [tmux](https://github.com/tmux/tmux)) you have to execute the following scripts, with the following order:
`startOrigin.sh`
`transcoderABR.sh`
`rtmpRX.sh`
- Finally you can start streaming configuring your encoder with this URL: `rtmp://YOUR-MACHINE-PUBLIC-IP/live/stream`
- You can see your streaming from your origin with this URL: `http://YOUR-MACHINE-PUBLIC-IP/playlist.m3u8`
- If you configure a CDN on top of your origin then you should use: `http://YOUR-DOMAIN/playlist.m3u8`

## Slides
Here you can find the slides I used for the presentation: [buildyourownlivestreaming](https://slides.com/jordicenzano/buildyourownlivestreaming)
