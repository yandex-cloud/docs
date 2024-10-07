В секции конфигурации `write_files.content.network.ethernets` по аналогии задайте настройки для нужного количества сетевых интерфейсов ВМ, создаваемых на ВМ. Нумерация интерфейсов начинается с нуля. В приведенном примере настройки задаются для трех интерфейсов. На одну ВМ можно добавить не более восьми сетевых интерфейсов.

```yaml
#cloud-config

datasource:
  Ec2:
    strict_id: false
ssh_pwauth: yes
users:
  - name: <имя_пользователя>
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - <публичный_SSH-ключ>
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