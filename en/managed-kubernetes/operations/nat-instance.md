# Configuring a VM as a NAT gateway

Yandex.Cloud allows you to configure internet connections for multiple VMs via a NAT gateway. In this case, only one public IP address will be used: the one that will be assigned to the gateway.

## Creating a NAT gateway {#create-nat-instance}

[Create](../../compute/quickstart/quick-create-linux.md) a VM to be used as an internet access gateway. The VM must have a public IP address to access the internet.

Once you've created the VM, configure routing:

{% list tabs %}

- Ubuntu 18
  
  1. Connect to the VM using its public IP address:
  
     ```
     $ ssh <VM's public IP>
     ```
  
  1. Enable routing in the **sysctl** configuration. You can edit the configuration file using the `nano` editor:
  
     ```
     $ sudo nano /etc/sysctl.conf
     ```
  
     Add the following parameters to the configuration:
  
     ```
     net.ipv4.ip_forward = 1
     net.ipv4.conf.all.accept_redirects = 1
     net.ipv4.conf.all.send_redirects = 1
     ```
  
  1. Apply the configuration changes and restart the network service:
  
     ```
     $ sudo sysctl -p /etc/sysctl.conf
     $ sudo systemctl restart systemd-networkd
     ```
  
  1. Set up address translation rules.
  
     1. Update the repositories and install the `iptables-persistent` and `netfilter-persistent` packages:
  
        ```
        $ sudo apt-get update
        $ sudo apt install iptables-persistent netfilter-persistent 
        ```
  
     1. Start the installed services:
  
        ```
        $ sudo systemctl start netfilter-persistent 
        $ sudo systemctl enable netfilter-persistent
        ```
  
     1. Enable the NAT:
  
        ```
        $ sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
        ```
  
     1. Save the `netfilter` configuration:
  
        ```
        $ sudo netfilter-persistent save
        ```
  
  1. When creating a Kubernetes cluster, specify the public IP address of the NAT gateway using the `--default-gateway-v4-address` flag.
  
- CentOS 7
  
  1. Connect to the VM using its public IP address:
  
     ```
     $ ssh <VM's public IP>
     ```
  
  1. Enable routing in the **sysctl** configuration. You can edit the configuration file using the `nano` editor:
  
     ```
     $ sudo nano /etc/sysctl.conf
     ```
  
     Add the following parameters to the configuration:
  
     ```
     net.ipv4.ip_forward = 1
     net.ipv4.conf.all.accept_redirects = 1
     net.ipv4.conf.all.send_redirects = 1
     ```
  
  1. Apply the configuration changes and restart the network service:
  
     ```
     $ sudo sysctl -p /etc/sysctl.conf
     $ sudo systemctl restart network.service
     ```
  
  1. Set up address translation rules.
  
     1. Install the `iptables-services` package:
  
        ```
        $ sudo yum install -y iptables-services 
        ```
  
     1. Enable the NAT:
  
        ```
        $ sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
        ```
  
     1. Enable `iptables`:
  
        ```
        $ sudo systemctl enable iptables
        ```
  
     1. Save the `iptables` configuration:
  
        ```
        $ sudo service iptables save
        ```
  
  1. When creating a Kubernetes cluster, specify the public IP address of the NAT gateway using the `--default-gateway-v4-address` flag.
  
{% endlist %}

