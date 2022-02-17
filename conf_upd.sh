#!/bin/bash

# Update from GitHub
cd /root/prometheus/
git pull origin main

# Update nginx.conf, default.conf in /etc/nginx
cp -f /root/prometheus/prometheus.yml /etc/prometheus/

# Restart prometheus
systemctl restart prometheus
