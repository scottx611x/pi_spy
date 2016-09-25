#!/bin/bash

# Most Rpi's don't have bash, but have "dash"
# sudo dpkg-reconfigure dash -> select NO if necessary

sudo sh scripts/make_cron.sh

python -m utils.day_or_night

sudo kill $(ps aux | grep '[p]ython flask_server.py' | awk '{print $2}')
sudo kill $(ps aux | grep '[p]ython py_sPi.py' | awk '{print $2}')

# Remove old nohup log
sudo rm -rf nohup.out

# Make our dirs for pics and vids if need be
mkdir -p vids
mkdir -p pics

# Install requirements
pip install -r requirements.txt

# Run our flask server & py_sPi script
sudo nohup python flask_server.py &
sleep 5
nohup python py_sPi.py &

# Peep the output
sudo tail -f nohup.out

