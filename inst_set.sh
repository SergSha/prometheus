#!/bin/bash

# Run as root?
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root"
  exit 1
else

# Firewalld stop
systemctl disable firewalld
systemctl stop firewalld

# Create directory distrib
mkdir /root/distrib

# Go to directory distrib
cd /root/distrib/

# Download from GitHub prometheus
curl -LO https://github.com/prometheus/prometheus/releases/download/v2.33.0/prometheus-2.33.0.linux-amd64.tar.gz

# Unpack archive prometheus
tar -xf ./prometheus-2.33.0.linux-amd64.tar.gz

# Delete archive prometheus
rm /root/distrib/prometheus-2.33.0.linux-amd64.tar.gz

# Add service user prometheus
useradd --no-create-home --shell /usr/sbin/nologin prometheus

# Create directory prometheus in /etc/, /var/lib/
mkdir {/etc,/var/lib}/prometheus

# Copy from directory prometheus-2.33.0.linux-amd64 files prometheus and promtool to /usr/local/bin/
cp -f /root/distrib/prometheus-2.33.0.linux-amd64/prom{etheus,tool} /usr/local/bin/

# Copy from directory prometheus-2.33.0.linux-amd64 directories consoles, console_libraries and file prometheus.yml to /etc/prometheus/
cp -rf /root/distrib/prometheus-2.33.0.linux-amd64/{console{s,_libraries},prometheus.yml} /etc/prometheus/
cp -f /root/prometheus/prometheus.yml /etc/prometheus/
cp -f /root/prometheus/conf_upd.sh /etc/cron.daily/

# Change user:group files /usr/local/bin/prometheus, /usr/local/bin/promtool and directory /etc/prometheus
chown -Rv prometheus: /usr/local/bin/prom{etheus,tool} {/etc,/var/lib}/prometheus

# Copy file prometheus.service into directory /etc/systemd/system for make service prometheus
cp -f /root/prometheus/prometheus.service /etc/systemd/system/

# Update daemon configures
systemctl daemon-reload

# Start prometheus
systemctl start prometheus

# Add prometheus service to autostart
systemctl enable prometheus

# Get prometheus status
systemctl status prometheus

# Go to directory distrib
cd /root/distrib/

# Download grafana
curl -LO https://dl.grafana.com/oss/release/grafana-8.3.4-1.x86_64.rpm

# Install grafana
yum -y install /root/distrib/grafana-8.3.4-1.x86_64.rpm

# Update daemon configure, start grafana, add grafana to autostart, get grafana status
systemctl daemon-reload && systemctl start grafana-server && systemctl enable grafana-server && systemctl status grafana-server

# Delete directory distrib
rm -rf /root/distrib

fi
