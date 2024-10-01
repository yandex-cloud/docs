In the `write_files.content.network.ethernets` configuration section, specify the settings for the required number of network interfaces you want to create on this VM, as shown below. Interfaces are numbered starting from zero. This example shows how to set up three interfaces. You can add up to eight network interfaces to a single VM.

```yaml
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
  - path: "/etc/netplan/01-netcfg.yaml"
    permissions: "0644"
    content: |
      # This file describes the network interfaces available on your system
      # For more information, see netplan(5).
      network:
        version: 2
        renderer: networkd
        ethernets:
          eth0:
            dhcp4: yes
          eth1:
            dhcp4: yes
            dhcp4-overrides:
              use-dns: false
              use-routes: false
            dhcp6: no
          eth2:
            dhcp4: yes
            dhcp4-overrides:
              use-dns: false
              use-routes: false
            dhcp6: no
runcmd:
  - sleep 1
  - sudo -i
  - netplan apply
```