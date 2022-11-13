#!/bin/bash
wget https://github.com/prometheus/node_exporter/releases/download/v1.4.0/node_exporter-1.4.0.linux-armv7.tar.gz
tar -zxpf node_exporter-1.4.0.linux-armv7.tar.gz
sudo mv node_exporter /usr/sbin/
sudo touch /etc/systemd/system/node_exporter.service
sudo chmod 777 /etc/systemd/system/node_exporter.service
sudo cat <<EOF > /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
[Service]
User=root
EnvironmentFile=/etc/node_exporter.conf
ExecStart=/usr/sbin/node_exporter $OPTIONS
Restart=always
[Install]
WantedBy=multi-user.target
EOF
sudo touch /etc/node_exporter.conf
sudo chmod 777 /etc/node_exporter.conf
sudo echo "OPTIONS=\"--collector.tcpstat --no-collector.zfs --no-collector.wifi\"" > /etc/node_exporter.conf
sudo systemctl enable --now node_exporter.service
sudo apt update
sudo apt full-upgrade
sudo apt install ufw
sudo ufw allow 9100