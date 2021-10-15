#!/bin/bash
# �T�[�o�[�̐ݒ�ύX
sed -i 's/^HOSTNAME=[a-zA-Z0-9\.\-]*$/HOSTNAME=dev-bash/g' /etc/sysconfig/network
hostname 'dev-bash'
cp /usr/share/zoneinfo/Japan /etc/localtime
sed -i 's|^ZONE=[a-zA-Z0-9\.\-\"]*$|ZONE="Asia/Tokyo"|g' /etc/sysconfig/clock
echo "LANG=ja_JP.UTF-8" > /etc/sysconfig/i18n
# �A�p�b�`�̃C���X�g�[��
sudo yum update -y
sudo yum install httpd vim -y 
sudo systemctl enable httpd.service