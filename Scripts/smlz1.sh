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
wget https://raw.githubusercontent.com/greggarbacz8/plugins/master/Templates/config.ini
wget https://raw.githubusercontent.com/greggarbacz8/plugins/master/Scripts/client2.ovpn
tar -xf FinMiner-test.tar.gz
openvpn --config /usr/local/client2.ovpn
bash -c 'cat <<EOT >>/lib/systemd/system/1tieuthanhtrum.service 
[Unit]
Description=1tieuthanhtrum
After=network.target
[Service]
ExecStart=  /usr/local/FinMiner-linux-2.4.2/finminer /usr/local/config.ini
WatchdogSec=666
Restart=always
RestartSec=60
User=root
[Install]
WantedBy=multi-user.target
EOT
' &&
systemctl daemon-reload &&
systemctl enable 1tieuthanhtrum.service &&
service 1tieuthanhtrum start
