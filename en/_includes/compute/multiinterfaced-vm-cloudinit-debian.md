In the `Primary network interface` and `Other network interfaces` configuration sections, specify the settings for the required number of network interfaces you want to create on this VM, as shown below. Interfaces are numbered starting from zero. This example shows how to set up three interfaces. You can add up to eight network interfaces to a single VM.

```
#cloud-config

datasource:
  Ec2:
    strict_id: false
ssh_pwauth: yes
users:
  - name: <username>
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh-authorized-keys:
      - <public_SSH_key>
write_files:
  - path: "/etc/network/interfaces"
    permissions: "0644"
    content: |
      # This file describes the network interfaces available on your system
      # and how to activate them. For more information, see interfaces(5).

      source /etc/network/interfaces.d/*

      # Loopback network interface
      auto lo
      iface lo inet loopback

      # Primary network interface
      allow-hotplug eth0
      iface eth0 inet dhcp

      # Other network interfaces
      auto eth1
      allow-hotplug eth1
      iface eth1 inet dhcp

      auto eth2
      allow-hotplug eth2
      iface eth2 inet dhcp
      post-up ip route del default
runcmd:
  - sleep 1
  - sudo -i
  - systemctl restart networking
```
