<h3>prometheus</h3>

<p>Enter with root:</p>
<pre>sudo -i</pre>

<p>Rename host:</p>
<pre>hostnamectl set-hostname prometheus</pre>

<p>Edit network setting (Warning: the network card make internal):</p>
<pre>vi /etc/sysconfig/network-scripts/ifcfg-enp0s3</pre>

<p>Comment line BOOTPROTO="dhcp":</p>
<pre>#BOOTPROTO="dhcp"</pre>

<p>Add next lines:</p>
<pre>BOOTPROTO="static"
IPADDR=10.0.1.21
NETMASK=255.255.255.0
GATEWAY=10.0.1.1
DNS1=10.0.1.1
DNS2=8.8.8.8</pre>

<p>Restart host:</p>
<pre>shutdown -r now</pre>

<p>Enter with root:</p>
<pre>sudo -i</pre>

<p>For monitoring host may install jnettop, htop, iotop, iftop, iptraf, nmon:</p>
<pre>yum install -y {jnet,h,io,if}top iptraf nmon</pre>

<p>Install git:</p>
<pre>yum -y install git</pre>

<p>Connect to GitHub repo for download to host:</p>
<pre>git clone https://github.com/SergSha/prometheus.git</pre>

<p>================== For to upload to GitHub ==================</p>
<p>Make pair keys:</p>
<pre>ssh-keygen
Enter
Enter
Enter</pre>

<p>Copy text of pub key and paste into GitHub:</p>
<pre>cat /root/.ssh/id_rsa.pub</pre>
<pre>https://github.com/settings/keys</pre>

<p>Connect to GitHub repo (prometheus):</p>
<pre>git clone git@github.com:SergSha/prometheus.git</pre>
<p>====================================================</p>

<p>Make the file inst_set.sh execute:</p>
<pre>chmod u+x /root/prometheus/inst_set.sh</pre>

<p>Start inst_set.sh:</p>
<pre>/root/prometheus/inst_set.sh</pre>

<p>========================== BROWSER ==========================</p>
<u>
<li>Open browser enter address <IP balancer>:3000</li>
<li>Login: admin</li>
<li>Password: admin</li>
<li>Skip</li>
<li>Configuration - Data sources</li>
<li>Add data source Prometheus</li>
<li>URL: http://localhost:9090</li>
<li>Save & test</li>
<li>В отдельной вкладке браузера зайдём на сайт Grafana по ссылке https://grafana.com/grafana/dashboards/</li>
<li>Выбираем Node Exporter Full - код 1860</li>
<li>Возвращаемся к своей вкладке и в меню Create кликаем Import</li>
<li>В поле вставляем 1860 и нажимаем Load</li>
<li>Внизу выбираем Prometheus</li>
<li>Import</li>
</ul>
