## Cluster Raspberry Pi 3 deployed by Ansible with Docker

**Highlights**

* Based in Hypriot for Raspberry Pi ( Official Docker Support for Raspberry Pi3 )
* Its included several elements for use with Docker ( Portainer, Cadvisor, Prometheus, Stack ELK, Traefik and Consul )
* Ansible allows to deploy and manage your infrastructure ( packages system, docker containers, etc.. )
* Ease of use with *one-click* install

## Installation

1. Download your image from hypriot
     
     Link: https://blog.hypriot.com/downloads/

2. Write your image in the SD using Win32 Disk Imager

3. Define the hostname of each cluster machine
     
     login with: pirate / hypriot
     sudo vi /boot/user-data
     
     Search 'hostname' and replace by your desired hostname
     
4. Define your network for each cluster machine

     sudo vi /etc/network/interfaces.d/eth0
     
     Ex:
     
     allow-hotplug eth0
     iface eth0 inet static
     address 192.168.0.50
     netmask 255.255.255.0
     broadcast 192.168.0.255
     gateway 192.168.0.1
     dns-nameservers 8.8.8.8
     dns-nameservers 8.8.4.4

5. Clone this repo in your central machine or node 1

6. Define your hosts in files/common/etc_hosts

7. Define your ansible hosts in files/common/hosts

8.  Define your installation in infra_install.yml

9.  Launch install.sh

### Enjoy It!
