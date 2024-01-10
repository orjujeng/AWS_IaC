#!/bin/bash
sudo -i
yum install -y docker
systemctl start docker
usermod -aG docker ec2-user
CODEDEPLOY_BIN="/opt/codedeploy-agent/bin/codedeploy-agent"
$CODEDEPLOY_BIN stop
yum erase codedeploy-agent -y
yum install ruby -y 
cd /home/ec2-user 
wget https://aws-codedeploy-ap-northeast-1.s3.ap-northeast-1.amazonaws.com/latest/install
chmod +x ./install
./install auto