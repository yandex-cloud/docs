---
title: Настройка дополнительной приватной подсети на сервере {{ baremetal-full-name }}
description: Следуя данной инструкции, вы сможете добавить на сервер {{ baremetal-full-name }} и настроить дополнительную приватную подсеть с тегированным VLAN.
---

# Настроить на сервере дополнительную приватную подсеть с тегированным VLAN

К [сетевому интерфейсу](../../concepts/servers.md#network-interfaces) (или группе агрегирования [MC-LAG](../../concepts/mc-lag.md)) сервера, которые подключены к [приватной сети](../../concepts/private-network.md), помимо [основной](../../concepts/private-network.md#native-vlan-subnet) приватной подсети можно привязать несколько [дополнительных](../../concepts/private-network.md#tagged-vlan-subnet) приватных подсетей.

О том, как привязать дополнительную приватную подсеть к серверу или отвязать ее, читайте в разделе [{#T}](./server-update.md).

После того как вы изменили количество или состав дополнительных приватных подсетей, привязанных к серверу, необходимо настроить сетевой интерфейс в его операционной системе. В качестве примера приведена настройка сетевого интерфейса в ОС Linux Ubuntu 24.04 с [Netplan](https://netplan.io/):

1. Подключитесь к серверу по SSH:

    ```bash
    ssh root@<публичный_IP-адрес_сервера>
    ```

    Вы также можете подключиться к серверу через [KVM-консоль](./server-kvm.md) с помощью логина и пароля.
1. Узнайте имя файла, в котором хранится конфигурация Netplan:

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
1. Чтобы настроить на сервере дополнительные приватные подсети с тегированным VLAN, добавьте в конфигурацию Netplan секцию `vlans`, содержащую сведения о дополнительных приватных подсетях, привязанных к серверу. Параметры настроек для серверов без резервирования сетевых подключений и серверов с MC-LAG различаются. Например:

    {% list tabs %}

    - Сервер без резервирования сети

      ```yaml
      network:
          version: 2
          ethernets:
              etx1:
                  dhcp4: true
                  match:
                      macaddress: b4:2e:99:58:5b:cc
                  set-name: etx1
              etx2:
                  dhcp4: true
                  match:
                      macaddress: b4:2e:99:58:5b:ce
                  set-name: etx2
          vlans:
              myvlan:
                  id: <идентификатор_VLAN>
                  link: <имя_сетевого_интерфейса>
                  addresses:
                      - <IP-адрес_сервера_в_дополнительной_подсети>
                  routes:
                      - to: <CIDR_дополнительной_подсети>
                        via: <шлюз_по_умолчанию_дополнительной_подсети>
      ```

      Где:

      * {% include [set-up-tagged-vlan-legend-1](../../../_includes/baremetal/set-up-tagged-vlan-legend-1.md) %}
      * {% include [set-up-tagged-vlan-legend-2](../../../_includes/baremetal/set-up-tagged-vlan-legend-2.md) %}
      * `<имя_сетевого_интерфейса>` — имя, назначенное в конфигурации Netplan (в секции `ethernets`) сетевому интерфейсу, подключенному к приватной сети. Например: `etx1`.

          Определить, какой из сетевых интерфейсов сервера подключен к приватной сети, вы можете по [MAC-адресу](https://ru.wikipedia.org/wiki/MAC-адрес): MAC-адрес [отображается](./get-info.md) в [консоли управления]({{ link-console-main }}) на странице с информацией о сервере в блоке **{{ ui-key.yacloud.baremetal.title_section-server-private-network_xrEye }}**.
      * {% include [set-up-tagged-vlan-legend-3](../../../_includes/baremetal/set-up-tagged-vlan-legend-3.md) %}
      * {% include [set-up-tagged-vlan-legend-4](../../../_includes/baremetal/set-up-tagged-vlan-legend-4.md) %}
      * {% include [set-up-tagged-vlan-legend-5](../../../_includes/baremetal/set-up-tagged-vlan-legend-5.md) %}

    - Сервер с MC-LAG

      ```yaml
      network:
          version: 2
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
          vlans:
              myvlan:
                  id: <идентификатор_VLAN>
                  link: <имя_сетевого_интерфейса>
                  addresses:
                      - <IP-адрес_сервера_в_дополнительной_подсети>
                  routes:
                      - to: <CIDR_дополнительной_подсети>
                        via: <шлюз_по_умолчанию_дополнительной_подсети>
      ```

      Где:

      * {% include [set-up-tagged-vlan-legend-1](../../../_includes/baremetal/set-up-tagged-vlan-legend-1.md) %}
      * {% include [set-up-tagged-vlan-legend-2](../../../_includes/baremetal/set-up-tagged-vlan-legend-2.md) %}
      * `<имя_сетевого_интерфейса>` — имя, назначенное в конфигурации Netplan (в секции `bonds`) группе агрегирования, подключенной к приватной сети. Например: `bond1`.

          О том, как определить, какая из групп агрегирования подключена к приватной сети, читайте в разделе [{#T}](./set-up-mc-lag.md).
      * {% include [set-up-tagged-vlan-legend-3](../../../_includes/baremetal/set-up-tagged-vlan-legend-3.md) %}
      * {% include [set-up-tagged-vlan-legend-4](../../../_includes/baremetal/set-up-tagged-vlan-legend-4.md) %}
      * {% include [set-up-tagged-vlan-legend-5](../../../_includes/baremetal/set-up-tagged-vlan-legend-5.md) %}

    {% endlist %}

    Если вы отвязали все дополнительные приватные подсети от сервера, удалите секцию `vlans` из файла настроек.
1. Примените обновленные настройки Netplan:

    ```bash
    netplan apply
    ```

{% note tip %}

Если вы ошиблись и создали VLAN для неверного сетевого интерфейса (группы агрегирования):

1. Скорректируйте настройки в файле конфигурации Netplan.
1. Удалите некорректно настроенный интерфейс VLAN. Для этого выполните команду, указав его идентификатор:

    ```bash
    ip link del myvlan
    ```
1. Примените обновленные настройки Netplan:

    ```bash
    netplan apply
    ```

{% endnote %}

#### См. также {#see-also}

* [{#T}](../../concepts/mc-lag.md)
* [{#T}](../../concepts/network.md)