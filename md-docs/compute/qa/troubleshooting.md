# Решение проблем в {{ compute-name }}

* [Не удается подключиться по SSH к вновь созданной ВМ с несколькими сетевыми интерфейсами](#unable-to-connect-to-new-multi-interface-vm)

* [ВМ не запускается после изменения конфигурации](#not-starting)

* [ВМ не запускается после остановки](#not-starting-after-stop)

* [ВМ не запускается после изменения типа диска](#not-starting-after-disk-change)

* [ВМ не запускается после изменения размера диска](#not-starting-after-disk-resize)

* [ВМ не запускается после изменения количества vCPU](#not-starting-after-cpu-change)

* [ВМ не запускается после изменения объема vRAM](#not-starting-after-ram-change)

* [ВМ не запускается после изменения метаданных](#not-starting-after-metadata-change)

* [ВМ не запускается после изменения группы безопасности](#not-starting-after-security-group-change)

* [ВМ не запускается после изменения сети](#not-starting-after-network-change)

В этом разделе описаны типичные проблемы, которые могут возникнуть при работе {{ compute-name }}, и методы их решения.

#### Не удается подключиться по SSH к вновь созданной ВМ с несколькими сетевыми интерфейсами {#unable-to-connect-to-new-multi-interface-vm}

При создании ВМ Linux с несколькими [сетевыми интерфейсами](../concepts/network.md) может возникнуть проблема с работоспособностью дополнительных сетевых интерфейсов внутри ОС. В некоторых случаях эта проблема может вызвать нарушение сетевой связности и привести к невозможности [подключиться](../operations/vm-connect/ssh.md) к ВМ по SSH.

{% note alert %}

Доступ к содержимому ВМ возможен только через учетные данные пользователя, например с помощью SSH-ключей, поэтому техническая поддержка {{ yandex-cloud }} не имеет доступа к операционной системе внутри ВМ из соображений безопасности и конфиденциальности пользовательских данных.

{% endnote %}

Чтобы устранить проблему, удалите ВМ и [создайте](../operations/vm-create/create-linux-vm.md) новую, передав в [метаданных](../concepts/metadata/public-image-keys.md) создаваемой ВМ дополнительные параметры [cloud-init](https://cloud-init.io):

{% list tabs group=instructions %}

- Консоль управления {#console}

  Раскройте секцию **{{ ui-key.yacloud.common.metadata }}** и добавьте ключ `user-data` со следующей конфигурацией:

  {% cut "Для ОС Ubuntu" %}

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

  {% endcut %}

  {% cut "Для ОС Debian" %}

  В секциях конфигурации `Primary network interface` и `Other network interfaces` по аналогии задайте настройки для нужного количества сетевых интерфейсов ВМ, создаваемых на ВМ. Нумерация интерфейсов начинается с нуля. В приведенном примере настройки задаются для трех интерфейсов. На одну ВМ можно добавить не более восьми сетевых интерфейсов.
  
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

  {% endcut %}

  Где:
  * `name:` — имя пользователя для [подключения](../operations/vm-connect/ssh.md) к ВМ по SSH.
  * `ssh_authorized_keys:` — список публичных [SSH-ключей](../../glossary/ssh-keygen.md) для подключения пользователя к ВМ по SSH. Укажите как минимум один публичный SSH-ключ.

- CLI {#cli}

  1. Создайте файл с конфигурацией cloud-init, например `vm-init.tpl`:

      {% cut "Для ОС Ubuntu" %}

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

      {% endcut %}

      {% cut "Для ОС Debian" %}

      В секциях конфигурации `Primary network interface` и `Other network interfaces` по аналогии задайте настройки для нужного количества сетевых интерфейсов ВМ, создаваемых на ВМ. Нумерация интерфейсов начинается с нуля. В приведенном примере настройки задаются для трех интерфейсов. На одну ВМ можно добавить не более восьми сетевых интерфейсов.
      
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

      {% endcut %}

  1. При создании ВМ передайте в нее созданный файл с конфигурацией в параметре `--metadata-from-file`, например:

      ```bash
      yc compute instance create --name=multi-net-vm --hostname=multi-net-vm \
        --zone {{ region-id }}-a \
        --create-boot-disk image-folder-id=standard-images,image-id=fd8bi0vgcf8vco49q3bm \
        --cores=2 --memory=4G --core-fraction=100 \
        --network-interface subnet-name=subnet1,ipv4-address=auto,nat-ip-version=ipv4 \
        --network-interface subnet-name=subnet2,ipv4-address=auto \
        --network-interface subnet-name=subnet3,ipv4-address=auto \
        --metadata-from-file user-data=vm-init.tpl
      ```

      {% note info %}
      
      Команды [`yc compute instance create`](../../cli/cli-ref/compute/cli-ref/instance/create.md) | [`create-with-container`](../../cli/cli-ref/compute/cli-ref/instance/create-with-container.md) | [`update`](../../cli/cli-ref/compute/cli-ref/instance/update.md) | [`add-metadata`](../../cli/cli-ref/compute/cli-ref/instance/add-metadata.md) поддерживают подстановку в метаданные ВМ значений переменных окружения. Эти значения, заданные в ключе `user-data` в формате `$<имя_переменной>`, в момент выполнения команды {{ yandex-cloud }} CLI будут подставлены в метаданные ВМ из переменных окружения среды, в которой выполняется команда. 
      
      Чтобы изменить такое поведение, не подставлять значение переменной из среды выполнения команды CLI и передать в метаданные ВМ имя переменной в формате `$<имя_переменной>`, используйте синтаксис с двумя символами доллара. Например: `$$<имя_переменной>`.
      
      Подробнее см. в разделе [{#T}](../concepts/metadata/sending-metadata.md#environment-variables).
      
      {% endnote %}

- {{ TF }} {#tf}

  1. Создайте файл с конфигурацией cloud-init, например `vm-init.tpl`:

      {% cut "Для ОС Ubuntu" %}

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

      {% endcut %}

      {% cut "Для ОС Debian" %}

      В секциях конфигурации `Primary network interface` и `Other network interfaces` по аналогии задайте настройки для нужного количества сетевых интерфейсов ВМ, создаваемых на ВМ. Нумерация интерфейсов начинается с нуля. В приведенном примере настройки задаются для трех интерфейсов. На одну ВМ можно добавить не более восьми сетевых интерфейсов.
      
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

      {% endcut %}

  1. При создании ВМ передайте в нее созданный файл с метаданными в блоке `yandex_compute_instance.metadata`, например:

      ```hcl
      resource "yandex_compute_instance" "multi-net-vm" {
        name        = "multi-net-vm"
        platform_id = "standard-v2"
        zone        = "{{ region-id }}-a"
       
        resources {
          cores  = "2"
          memory = "2"
        }

        boot_disk {
          initialize_params {
            image_id = "fd8bi0vgcf8vco49q3bm"
          }
        }

        network_interface {
          subnet_id          = "e2lrucutusnd********"
          nat                = true
        }

        network_interface {
          subnet_id          = "e2lpp96bvvgp********"
          nat                = false
        }

        network_interface {
          subnet_id          = "e2lv9c6aek1d********"
          nat                = false
        }

        metadata = {
          user-data = "${file("./vm-init.tpl")}"
        }
      }
      ```

{% endlist %}

#### Дополнительные сетевые интерфейсы не работают после добавления на существующую ВМ {#added-net-interfaces-down}

После добавления на ВМ Linux дополнительных [сетевых интерфейсов](../concepts/network.md) может возникнуть проблема с их работоспособностью внутри ОС. В некоторых случаях эта проблема может вызвать нарушение сетевой связности и привести к невозможности подключиться к ВМ по SSH.

Чтобы устранить проблему, попробуйте обновить операционную систему ВМ до последней версии.

Если обновление ОС невозможно или не помогает:

1. [Подключитесь](../operations/vm-connect/ssh.md) к ВМ по SSH.

    Если подключение по SSH невозможно из-за нарушения сетевой связности, предварительно [удалите](../operations/vm-control/detach-network-interface.md) на ВМ все дополнительные сетевые интерфейсы и [перезагрузите](../operations/vm-control/vm-stop-and-start.md#restart) ВМ.

1. Внесите изменения в конфигурацию сети ОС:

    {% list tabs %}

    - Ubuntu

      1. Добавьте конфигурацию новых сетевых интерфейсов в файл `/etc/netplan/01-netcfg.yaml`:
      
          ```bash
          sudo nano /etc/netplan/01-netcfg.yaml
          ```

          В секции конфигурации `write_files.content.network.ethernets` по аналогии задайте настройки для нужного количества сетевых интерфейсов ВМ, которые есть или будут добавлены на ВМ. Нумерация интерфейсов начинается с нуля. В приведенном примере настройки задаются для трех интерфейсов. На одну ВМ можно добавить не более восьми сетевых интерфейсов.

          ```
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
          ```

      1. Назначьте файлу `/etc/netplan/01-netcfg.yaml` нужные права:

          ```bash
          sudo chmod 0644 /etc/netplan/01-netcfg.yaml
          ```

      1. Примените изменения в конфигурации сетевых интерфейсов:

          ```bash
          sudo netplan apply
          ```

    - Debian

      1. Добавьте конфигурацию новых сетевых интерфейсов в файл `/etc/network/interfaces`:
      
          ```bash
          sudo nano /etc/network/interfaces
          ```
      
          В секциях конфигурации `Primary network interface` и `Other network interfaces` по аналогии задайте настройки для нужного количества сетевых интерфейсов ВМ, которые есть или будут добавлены на ВМ. Нумерация интерфейсов начинается с нуля. В приведенном примере настройки задаются для трех интерфейсов. На одну ВМ можно добавить не более восьми сетевых интерфейсов.

          ```txt
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
          ```

      1. Перезапустите сетевую службу:

          ```bash
          sudo systemctl restart networking
          ```

    {% endlist %}

1. Если ранее вам пришлось удалить дополнительные сетевые интерфейсы, вновь [добавьте](../operations/vm-control/attach-network-interface.md) их.