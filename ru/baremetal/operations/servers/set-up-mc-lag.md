---
title: Настройка резервирования сетевого подключения в {{ baremetal-full-name }}
description: Следуя данной инструкции, вы сможете настроить группу агрегирования на сервере {{ baremetal-full-name }} с возможностью резервирования сетевого подключения с использованием технологии MC-LAG.
---

# Настроить группу агрегирования MC-LAG

Серверы с поддержкой [MC-LAG](../../concepts/mc-lag.md) подключены к каждой из сетей ([публичной](../../concepts/network.md#public-network) и [приватной](../../concepts/network.md#private-network)) одновременно с помощью двух сетевых карт. При этом для обеспечения отказоустойчивости каждая пара сетевых интерфейсов, подключенных к сети, на стороне сервера должна быть объединена в _группу агрегирования_. Подробнее см. в разделе [{#T}](../../concepts/mc-lag.md#additional-setup).

{% note info %}

При настройке групп агрегирования не подключайтесь к серверу по сетевому интерфейсу, который будет включен в группу, так как при создании группы соединение будет разорвано. Для настройки групп MC-LAG надежнее всего использовать [KVM-консоль](./server-kvm.md).

{% endnote %}

В настоящий момент настроить группы агрегирования каналов MC-LAG можно в операционных системах Linux Ubuntu 20.04, 22.04, 24.04 и Debian 11. В качестве примера в инструкции используется сервер с двумя парами сетевых карт со скоростью соединения 25 Гбит/с.

Чтобы настроить группу агрегирования каналов:

{% list tabs group=operating_system %}

- Ubuntu/Debian (Netplan) {#ubuntu}

  1. Установите утилиту `ethtool`:

      ```bash
      apt install ethtool
      ```
  1. Убедитесь, что в системе установлены и активны необходимые сетевые интерфейсы:

      ```bash
      ip link
      ```

      Результат:

      ```text
      ...
      2: etx3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
          link/ether b8:ce:f6:40:12:d6 brd ff:ff:ff:ff:ff:ff
      3: etx4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
          link/ether b8:ce:f6:40:12:d7 brd ff:ff:ff:ff:ff:ff
      4: etx1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
          link/ether 58:a2:e1:ad:38:2a brd ff:ff:ff:ff:ff:ff
      5: etx2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
          link/ether 58:a2:e1:ad:38:2b brd ff:ff:ff:ff:ff:ff
      ```

      Как видно из результата, на сервере активны четыре сетевых интерфейса:

      * `etx3` — с MAC-адресом `b8:ce:f6:40:12:d6`;
      * `etx4` — с MAC-адресом `b8:ce:f6:40:12:d7`;
      * `etx1` — с MAC-адресом `58:a2:e1:ad:38:2a`;
      * `etx2` — с MAC-адресом `58:a2:e1:ad:38:2b`.
  1. Узнайте, какие из интерфейсов относятся к публичной сети, а какие — к приватной:

        1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), которому принадлежит сервер.
        1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}** и в открывшемся списке серверов выберите нужный сервер.

            На открывшейся странице в разделах **{{ ui-key.yacloud.baremetal.title_section-server-public-network }}** и **{{ ui-key.yacloud.baremetal.title_section-server-private-network }}** в поле `{{ ui-key.yacloud.baremetal.field_mac-address }}` указаны MAC-адреса интерфейсов, подключенных соответственно к публичной и приватной сетям.

        1. Соотнесите информацию, полученную на двух предыдущих шагах, и определите пары интерфейсов сервера, которые подключены к публичной и приватной сетям. В примере выше это следующие пары:

            **Публичная сеть**:
            * `etx3` — с MAC-адресом `b8:ce:f6:40:12:d6`;
            * `etx1` — с MAC-адресом `58:a2:e1:ad:38:2a`.

            **Приватная сеть**:
            * `etx4` — с MAC-адресом `b8:ce:f6:40:12:d7`;
            * `etx2` — с MAC-адресом `58:a2:e1:ad:38:2b`.
  1. Узнайте имя файла, в котором хранится конфигурация [Netplan](https://netplan.io/):

      ```bash
      ls /etc/netplan/
      ```

      Результат:

      ```text
      50-cloud-init.yaml
      ```
  1. Откройте файл конфигурации Netplan удобным вам текстовым редактором. В этой инструкции используется редактор [nano](https://ru.wikipedia.org/wiki/Nano):

      ```bash
      nano /etc/netplan/50-cloud-init.yaml
      ```
  1. Настройте конфигурацию Netplan, добавив в нее группы агрегирования (раздел `bonds`):

      ```yaml
      network:
          bonds:
              bond1:
                  dhcp4: true
                  interfaces:
                  - <имя_публичного_интерфейса_1>
                  - <имя_публичного_интерфейса_2>
                  macaddress: <MAC-адрес_публичного_интерфейса_1_или_2>
                  parameters:
                      lacp-rate: fast
                      mode: 802.3ad
                      transmit-hash-policy: layer3+4
              bond2:
                  dhcp4: true
                  interfaces:
                  - <имя_приватного_интерфейса_1>
                  - <имя_приватного_интерфейса_2>
                  macaddress: <MAC-адрес_приватного_интерфейса_1_или_2>
                  parameters:
                      lacp-rate: fast
                      mode: 802.3ad
                      transmit-hash-policy: layer3+4
          ethernets:
              etx1:
                  dhcp4: false
                  match:
                      macaddress: 58:a2:e1:ad:38:2a
                  set-name: etx1
              etx2:
                  dhcp4: false
                  match:
                      macaddress: 58:a2:e1:ad:38:2b
                  set-name: etx2
              etx3:
                  dhcp4: false
                  match:
                      macaddress: b8:ce:f6:40:12:d6
                  set-name: etx3
              etx4:
                  dhcp4: false
                  match:
                      macaddress: b8:ce:f6:40:12:d7
                  set-name: etx4
          version: 2
      ```

      Где:
      * `<имя_публичного_интерфейса_1>`, `<имя_публичного_интерфейса_2>` — имена интерфейсов, определенных ранее как относящиеся к публичной сети.
      * `<MAC-адрес_приватного_интерфейса_1_или_2>` — MAC-адрес любого из интерфейсов, определенных ранее как относящиеся к публичной сети.
      * `<имя_приватного_интерфейса_1>`, `<имя_приватного_интерфейса_2>` — имена интерфейсов, определенных ранее как относящиеся к приватной сети.
      * `<MAC-адрес_приватного_интерфейса_1_или_2>` — MAC-адрес любого из интерфейсов, определенных ранее как относящиеся к приватной сети.

      {% note warning %}

      Обратите внимание, что [DHCP](../../concepts/dhcp.md) должен быть:
      * включен (значение `dhcp4: true`) для групп агрегирования (раздел `bonds`);
      * выключен (значение `dhcp4: false`) для индивидуальных интерфейсов (раздел `ethernets`).

      {% endnote %}

      {% cut "Пример конфигурации Netplan" %}

      ```yaml
      network:
          bonds:
              bond1:
                  dhcp4: true
                  interfaces:
                  - etx3
                  - etx1
                  macaddress: b8:ce:f6:40:12:d6
                  parameters:
                      lacp-rate: fast
                      mode: 802.3ad
                      transmit-hash-policy: layer3+4
              bond2:
                  dhcp4: true
                  interfaces:
                  - etx4
                  - etx2
                  macaddress: b8:ce:f6:40:12:d7
                  parameters:
                      lacp-rate: fast
                      mode: 802.3ad
                      transmit-hash-policy: layer3+4
          ethernets:
              etx1:
                  dhcp4: false
                  match:
                      macaddress: 58:a2:e1:ad:38:2a
                  set-name: etx1
              etx2:
                  dhcp4: false
                  match:
                      macaddress: 58:a2:e1:ad:38:2b
                  set-name: etx2
              etx3:
                  dhcp4: false
                  match:
                      macaddress: b8:ce:f6:40:12:d6
                  set-name: etx3
              etx4:
                  dhcp4: false
                  match:
                      macaddress: b8:ce:f6:40:12:d7
                  set-name: etx4
          version: 2
      ```

      {% endcut %}

  1. Примените новую конфигурацию Netplan:

      ```bash
      netplan apply
      ```
  1. Убедитесь, что в списке сетевых интерфейсов появились группы агрегирования:

      ```bash
      ip link
      ```

      Результат:

      ```text
      ...
      2: etx3: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc mq master bond1 state UP mode DEFAULT group default qlen 1000
          link/ether b8:ce:f6:40:12:d6 brd ff:ff:ff:ff:ff:ff
      3: etx4: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc mq master bond2 state UP mode DEFAULT group default qlen 1000
          link/ether b8:ce:f6:40:12:d7 brd ff:ff:ff:ff:ff:ff
      4: etx1: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc mq master bond1 state UP mode DEFAULT group default qlen 1000
          link/ether b8:ce:f6:40:12:d6 brd ff:ff:ff:ff:ff:ff
      5: etx2: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc mq master bond2 state UP mode DEFAULT group default qlen 1000
          link/ether b8:ce:f6:40:12:d7 brd ff:ff:ff:ff:ff:ff
      6: bond1: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
          link/ether b8:ce:f6:40:12:d6 brd ff:ff:ff:ff:ff:ff
      7: bond2: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
          link/ether b8:ce:f6:40:12:d7 brd ff:ff:ff:ff:ff:ff
      ```

      Как видно из результата, на сервере появились две группы агрегирования MC-LAG: `bond1` и `bond2`.

      {% note info %}

      Если группы агрегирования неактивны (состояние `DOWN`), включите их:

      ```bash
      ifconfig bond1 up
      ifconfig bond2 up
      ```

      {% endnote %}

  1. Посмотрите информацию о созданных группах. В качестве примера возьмем группу агрегирования, подключенную к публичной сети:

      ```bash
      ethtool bond1
      ```

      Результат:

      ```
      Settings for bond1:
        Supported ports: [ ]
        Supported link modes:   Not reported
        Supported pause frame use: No
        Supports auto-negotiation: No
        Supported FEC modes: Not reported
        Advertised link modes:  Not reported
        Advertised pause frame use: No
        Advertised auto-negotiation: No
        Advertised FEC modes: Not reported
        Speed: 50000Mb/s
        Duplex: Full
        Port: Other
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: off
        Link detected: yes
      ```

      Как видно из результата, скорость соединения для группы `bond1` составляет 50 Гбит/с.
  1. Смоделируйте нештатную ситуацию с разрывом связи на одном из каналов, входящих в группу агрегирования публичной сети `bond1`. Для этого отключите один из сетевых интерфейсов этой группы:

      ```bash
      ifconfig etx3 down
      ```
  1. Повторно посмотрите информацию о группе:

      ```bash
      ethtool bond1
      ```

      Результат:

      ```
      Settings for bond1:
        Supported ports: [ ]
        Supported link modes:   Not reported
        Supported pause frame use: No
        Supports auto-negotiation: No
        Supported FEC modes: Not reported
        Advertised link modes:  Not reported
        Advertised pause frame use: No
        Advertised auto-negotiation: No
        Advertised FEC modes: Not reported
        Speed: 25000Mb/s
        Duplex: Full
        Port: Other
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: off
        Link detected: yes
      ```

      Как видно из результата, скорость соединения для группы `bond1` снизилась до 25 Гбит/с, но сетевая связность сохранилась. Чтобы убедиться в этом, [подключитесь](../../../compute/operations/vm-connect/ssh.md) к серверу по SSH.
  1. Включите отключенный ранее интерфейс и убедитесь, что группа агрегирования вновь работает на максимальной скорости:

      ```bash
      ifconfig etx3 up
      ethtool bond1
      ```

      Результат:

      ```text
      Settings for bond1:
        Supported ports: [ ]
        Supported link modes:   Not reported
        Supported pause frame use: No
        Supports auto-negotiation: No
        Supported FEC modes: Not reported
        Advertised link modes:  Not reported
        Advertised pause frame use: No
        Advertised auto-negotiation: No
        Advertised FEC modes: Not reported
        Speed: 50000Mb/s
        Duplex: Full
        Port: Other
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: off
        Link detected: yes
      ```

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/mc-lag.md)
* [{#T}](../../concepts/network.md)
* [{#T}](../../concepts/network-restrictions.md)