#! bin/bash

sudo apt update
sudo apt install apache2 -y
sudo ufw enable
sudo ufw allow 'Apache Full'
sudo systemctl start apache2