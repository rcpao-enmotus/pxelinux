#!/bin/bash

sudo apt install nfs-kernel-server
# cp etc/exports /etc/exports
sudo systemctl start nfs-kernel-server.service
