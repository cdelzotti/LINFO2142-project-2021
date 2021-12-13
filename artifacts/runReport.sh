#!/bin/bash
currentDate=$(date +'%Y-%m-%d')
# Stop service
systemctl stop tstat
# Save files in archive
mkdir -p archives
cp -r RRD graphs
tar -czf archives/$currentDate.tar.gz graphs
# Clean files to save memory
rm graphs/* -rf
rm /stdin/* -rf
# Restart Services
systemctl restart tstat
# Send report
python3 sendMail.py $currentDate.tar.gz
