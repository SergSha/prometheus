# prometheus
# Enter with root
sudo -i

# Rename host
hostnamectl set-hostname prometheus

# Edit network setting (Warning: the network card make internal)
vi /etc/sysconfig/network-scripts/ifcfg-enp0s3

# comment line BOOTPROTO="dhcp"
#BOOTPROTO="dhcp"

# add next lines
BOOTPROTO="static"
IPADDR=10.0.1.21
NETMASK=255.255.255.0
GATEWAY=10.0.1.1
DNS1=10.0.1.1
DNS2=8.8.8.8

# Restart host
shutdown -r now

# Enter with root
sudo -i

# For monitoring host may install jnettop, htop, iotop, iftop, iptraf, nmon
#yum install -y {jnet,h,io,if}top iptraf nmon

# Install git
yum -y install git

# Connect to GitHub repo for download to host
git clone https://github.com/SergSha/prometheus.git

#------- For to upload to GitHub -------------
# Make pair keys
#ssh-keygen #Enter-Enter-Enter
# Copy text of pub key and paste into GitHub:
#cat /root/.ssh/id_rsa.pub
#https://github.com/settings/keys
# Connect to GitHub repo (prometheus)
#git clone git@github.com:SergSha/prometheus.git
------------------------------------------------

# Make the file inst_set.sh execute
chmod u+x /root/prometheus/inst_set.sh

# Start inst_set.sh
/root/prometheus/inst_set.sh

# Open browser enter address <IP balancer>:3000
# Login: admin
# Password: admin
# Skip
# Configuration - Data sources
# Add data source Prometheus
# URL: http://localhost:9090
# Save & test
# В отдельной вкладке браузера зайдём на сайт Grafana по ссылке https://grafana.com/grafana/dashboards/
# Выбираем Node Exporter Full - код 1860
# Возвращаемся к своей вкладке и в меню Create кликаем Import
# В поле вставляем 1860 и нажимаем Load
# Внизу выбираем Prometheus
# Import
