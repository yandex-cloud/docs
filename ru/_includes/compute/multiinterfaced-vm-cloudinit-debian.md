В секциях конфигурации `Primary network interface` и `Other network interfaces` по аналогии задайте настройки для нужного количества сетевых интерфейсов ВМ, создаваемых на ВМ. Нумерация интерфейсов начинается с нуля. В приведенном примере настройки задаются для трех интерфейсов. На одну ВМ можно добавить не более восьми сетевых интерфейсов.

```
#cloud-config

datasource:
  Ec2:
    strict_id: false
ssh_pwauth: yes
users:
  - name: <имя_пользователя>
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh-authorized-keys:
      - <публичный_SSH-ключ>
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