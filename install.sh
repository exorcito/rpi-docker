#!/bin/bash

##########################
# Add Sources List       #
##########################
echo "##########################"
echo "# Installation Process   #"
echo "##########################"
echo "`date +%m/%d' '%T` - Verification Sources List:"
if grep -Fxq "deb http://mirrordirector.raspbian.org/raspbian/ stretch main contrib non-free rpi" /etc/apt/sources.list
then
        echo "`date +%m/%d' '%T` - Sources List OK"
else
        echo "deb http://mirrordirector.raspbian.org/raspbian/ stretch main contrib non-free rpi" | sudo tee -a /etc/apt/sources.list
        echo "`date +%m/%d' '%T` - Sources List Added"
fi

###################
# Update System   #
###################
echo "`date +%m/%d' '%T` - Update System..."
echo "-------------------------------------"
sudo apt-get update
sudo apt-get install software-properties-common git python-apt python-apt libssl-dev libffi-dev python-dev python3-pip -y
echo "-------------------------------------"
###################
# Install ansible #
###################
if [ ! -f /usr/bin/ansible ]
then
        echo "`date +%m/%d' '%T` - Installing Ansible..."
        pip3 install ansible docker-py
	echo "";echo "`date +%m/%d' '%T` - Ansible installed"
else
        echo "";echo "`date +%m/%d' '%T` - Ansible already installed"
        
fi
######################
# Copy Files         #
######################
sudo cp files/common/hosts /etc/ansible/hosts
sudo cp files/common/cloud.cfg /etc/cloud/cloud.cfg
sudo cp files/common/etc_hosts /etc/hosts
sudo cp files/common/ansible.cfg /etc/ansible
sudo cp /home/pirate/.local/bin/* /usr/bin/

##########################
# Generate SSH Key Hosts #
#########################
ssh-keygen -b 2048 -t rsa -f /home/`whoami`/.ssh/id_rsa -q -N ""

##########################
# Copy SSH Key Hosts     #
#########################
cat /etc/hosts | awk '{print $2}' |grep -v 'localhost' |grep -v 'ip6'|grep -v '^$'| while read server
do
    ssh-copy-id -i ~/.ssh/id_rsa.pub -o StrictHostKeyChecking=no `whoami`@"${server}"
done

#####################################
# Display real installation process #
#####################################
echo ""
echo "`date +%m/%d' '%T` - Customize the playbook infra_instalL.yml to suit your needs, then run ansible with :"
echo "`date +%m/%d' '%T` - ansible-playbook infra_install.yml --ask-become-pass"
echo ""
