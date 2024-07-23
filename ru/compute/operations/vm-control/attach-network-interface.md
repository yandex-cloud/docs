# Добавить дополнительный сетевой интерфейс на виртуальную машину


У виртуальной машины может быть один или несколько [сетевых интерфейсов](../../concepts/network.md). Подробнее о максимальном количестве сетевых интерфейсов на ВМ см. в [{#T}](../../concepts/limits.md). 

Добавить сетевые интерфейсы можно как на [запущенные](#add-to-running), так и на [остановленные](#add-to-stopped) ВМ. Для сохранения [сетевой связности](../../../vpc/concepts/static-routes.md#rt-vm) рекомендуется добавлять сетевые интерфейсы на остановленные ВМ.

## Добавление сетевого интерфейса на остановленную ВМ {#add-to-stopped}

Чтобы добавить дополнительный интерфейс на виртуальную машину:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для добавления сетевого интерфейса на виртуальную машину:

      ```bash
      yc compute instance attach-network-interface --help
      ```

  1. Получите список ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

      Сохраните идентификатор ВМ, на которую вы хотите добавить дополнительный сетевой интерфейс.

  1. Остановите выбранную ВМ, указав ее идентификатор:

      ```bash
      yc compute instance stop <идентификатор_ВМ>
      ```

  1. Получите список всех [подсетей](../../../vpc/concepts/network.md#subnet) в каталоге по умолчанию:

      {% include [add-network-interface-cli-list-subnets](../../../_includes/compute/add-network-interface-cli-list-subnets.md) %}

      Сохраните идентификатор подсети, которую вы хотите привязать к добавляемому сетевому интерфейсу ВМ. Подсеть должна находиться в той же [зоне доступности](../../../overview/concepts/geo-scope.md), что и виртуальная машина.

  1. Получите список всех [групп безопасности](../../../vpc/concepts/security-groups.md) в каталоге по умолчанию:

      {% include [add-network-interface-cli-list-sgs](../../../_includes/compute/add-network-interface-cli-list-sgs.md) %}

      Сохраните идентификаторы групп безопасности, которые вы хотите привязать к добавляемому сетевому интерфейсу ВМ. Группы безопасности должны находиться в той же [облачной сети](../../../vpc/concepts/network.md#network), что и привязываемая подсеть.

  1. Получите список занятых номеров сетевых интерфейсов выбранной ВМ, указав ее идентификатор:

      ```bash
      yc compute instance get <идентификатор_ВМ>
      ```

      Результат:

      ```yml
      ...
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:b8:**:**:**
          subnet_id: e2lpp96bvvgp********
          primary_v4_address:
            address: 192.168.2.7
            one_to_one_nat:
              ip_version: IPV4
          security_group_ids:
            - enpuatgvejtn********
        - index: "1"
          mac_address: d0:ad:b8:**:**:**
          subnet_id: e2lrucutusnd********
          primary_v4_address: {}
          security_group_ids:
            - enpuatgvejtn********
            - enpg8d2hqh1o********
      ...
      ```

      В приведенном примере сетевые интерфейсы с номерами `0` и `1` (значения полей `index`) заняты.

  1. Добавьте на выбранную ВМ новый сетевой интерфейс:

      {% include [add-network-interface-the-cli-command](../../../_includes/compute/add-network-interface-the-cli-command.md) %}

      Результат:

      ```yml
      ...
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:b8:**:**:**
          subnet_id: e2lpp96bvvgp********
          primary_v4_address:
            address: 192.168.2.7
            one_to_one_nat:
              ip_version: IPV4
          security_group_ids:
            - enpuatgvejtn********
        - index: "1"
          mac_address: d0:ad:b8:**:**:**
          subnet_id: e2lrucutusnd********
          primary_v4_address:
            address: 192.168.4.20
          security_group_ids:
            - enpuatgvejtn********
            - enpg8d2hqh1o********
        - index: "2"
          mac_address: d0:2d:b8:**:**:**
          subnet_id: e2lv9c6aek1d********
          primary_v4_address: {}
          security_group_ids:
            - enpuatgvejtn********
            - enpg8d2hqh1o********
      ...
      ```

  1. Для того чтобы новому интерфейсу были назначены IP-адреса, запустите ВМ, указав ее идентификатор:

      ```bash
      yc compute instance start <идентификатор_ВМ>
      ```

- API {#api}

  {% include [add-network-interface-api](../../../_includes/compute/add-network-interface-api.md) %}

{% endlist %}

У виртуальной машины появился новый сетевой интерфейс. [Убедитесь](#test), что он работает.


## Добавление сетевого интерфейса на работающую ВМ  {#add-to-running}

{% note info %}

{% include [add-network-interface-hotplug-preview-note](../../../_includes/compute/add-network-interface-hotplug-preview-note.md) %}

{% endnote %}

Чтобы добавить дополнительный интерфейс на виртуальную машину:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для добавления сетевого интерфейса на виртуальную машину:

      ```bash
      yc compute instance attach-network-interface --help
      ```

  1. Получите список ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

      Сохраните идентификатор ВМ, на которую вы хотите добавить дополнительный сетевой интерфейс.

  1. Получите список всех [подсетей](../../../vpc/concepts/network.md#subnet) в каталоге по умолчанию:

      {% include [add-network-interface-cli-list-subnets](../../../_includes/compute/add-network-interface-cli-list-subnets.md) %}

      Сохраните идентификатор подсети, которую вы хотите привязать к добавляемому сетевому интерфейсу ВМ. Подсеть должна находиться в той же [зоне доступности](../../../overview/concepts/geo-scope.md), что и виртуальная машина.

  1. Получите список всех [групп безопасности](../../../vpc/concepts/security-groups.md) в каталоге по умолчанию:

      {% include [add-network-interface-cli-list-sgs](../../../_includes/compute/add-network-interface-cli-list-sgs.md) %}

      Сохраните идентификаторы групп безопасности, которые вы хотите привязать к добавляемому сетевому интерфейсу ВМ. Группы безопасности должны находиться в той же [облачной сети](../../../vpc/concepts/network.md#network), что и привязываемая подсеть.

  1. Получите список занятых номеров сетевых интерфейсов выбранной ВМ, указав ее идентификатор:

      ```bash
      yc compute instance get <идентификатор_ВМ>
      ```

      Результат:

      ```yml
      ...
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:1a:**:**:**
          subnet_id: e2lrucutusnd********
          primary_v4_address:
            address: 192.168.1.20
            one_to_one_nat:
              address: 158.***.**.***
              ip_version: IPV4
          security_group_ids:
            - enpuatgvejtn********
        - index: "1"
          mac_address: d0:1d:1a:**:**:**
          subnet_id: e2lpp96bvvgp********
          primary_v4_address:
            address: 192.168.2.3
          security_group_ids:
            - enpuatgvejtn********
            - enpg8d2hqh1o********
      ...
      ```

      В приведенном примере сетевые интерфейсы с номерами `0` и `1` (значения полей `index`) заняты.

  1. Добавьте на выбранную ВМ новый сетевой интерфейс:

      {% include [add-network-interface-the-cli-command](../../../_includes/compute/add-network-interface-the-cli-command.md) %}

      Результат:

      ```yml
      ...
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:1a:**:**:**
          subnet_id: e2lrucutusnd********
          primary_v4_address:
            address: 192.168.1.20
            one_to_one_nat:
              address: 158.***.**.***
              ip_version: IPV4
          security_group_ids:
            - enpuatgvejtn********
        - index: "1"
          mac_address: d0:1d:1a:**:**:**
          subnet_id: e2lpp96bvvgp********
          primary_v4_address:
            address: 192.168.2.3
          security_group_ids:
            - enpuatgvejtn********
            - enpg8d2hqh1o********
        - index: "2"
          mac_address: d0:2d:1a:**:**:**
          subnet_id: e2lv9c6aek1d********
          primary_v4_address:
            address: 192.168.4.17
          security_group_ids:
            - enpuatgvejtn********
            - enpg8d2hqh1o********
      ...
      ```

- API {#api}

  {% include [add-network-interface-api](../../../_includes/compute/add-network-interface-api.md) %}

{% endlist %}

У виртуальной машины появился новый сетевой интерфейс. При этом подключенный интерфейс находится в неактивном состоянии, потому что он был добавлен на работающую ВМ. Чтобы убедиться в этом:

{% list tabs group=operating_system %}

- Linux {#linux}

  1. [Подключитесь](../vm-connect/ssh.md#vm-connect) к ВМ по SSH.
  1. Выполните команду, чтобы получить информацию о состоянии сетевых интерфейсов ВМ:

      ```bash
      ip a
      ```

      Результат:

      ```txt
      1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
          link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
          inet 127.0.0.1/8 scope host lo
             valid_lft forever preferred_lft forever
          inet6 ::1/128 scope host
             valid_lft forever preferred_lft forever
      ...
      4: eth2: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
          link/ether d0:2d:1a:f4:20:ef brd ff:ff:ff:ff:ff:ff
          altname enp140s0
          altname ens10
      ```

      Состояние `state DOWN` для интерфейса с именем `eth2` означает, что сетевой интерфейс неактивен.

- Windows {#windows}

  1. [Подключитесь](../vm-connect/rdp.md) к ВМ по RDP.
  1. Запустите **Диспетчер устройств**, выполнив команду в PowerShell:

      ```powershell
      devmgmt.msc
      ```

  1. В открывшемся окне **Диспетчера устройств** раскройте секцию **Сетевые адаптеры** (**Network adapters**). Добавленный сетевой интерфейс помечен восклицательным знаком и неактивен.

{% endlist %}

Для того чтобы активировать добавленный сетевой интерфейс, [перезапустите](./vm-stop-and-start.md#restart) ВМ. Для ОС Windows перезапуск ВМ — это единственный способ активировать интерфейс.

Если ваша ВМ под управлением ОС Linux, и у вас нет возможности перезапустить ее, вы можете активировать сетевой интерфейс без перезапуска ВМ. При этом, чтобы избежать потери сетевой связности, выполнять настройки необходимо из [серийной консоли](../serial-console/index.md):

{% list tabs group=operating_system %}

- Linux {#linux}

  1. [Включите](../serial-console/index.md#turn-on-for-current-instance) на ВМ доступ к серийной консоли. 

      При создании пользователя для аутентификации на ВМ через серийную консоль добавьте этого пользователя в группу `sudo` с помощью команды `sudo usermod -a -G sudo <имя_пользователя>`.

  1. Подключитесь к серийной консоли ВМ [с помощью CLI](../serial-console/connect-cli.md#connect-to-serial-console) или [по SSH](../serial-console/connect-ssh.md#connect-to-serial-console).

  1. Активируйте добавленный сетевой интерфейс:

      ```bash
      sudo ip link set <имя_интерфейса> up
      ```

      Где `<имя_интерфейса>` — имя неактивного интерфейса в ОС Linux. Например: `eth2`. Посмотреть имена сетевых интерфейсов можно в терминале Linux с помощью команды `ip a`.

  1. Получите настройки DHCP для нового интерфейса:

      ```bash
      sudo dhclient <имя_интерфейса>
      ```

  1. Удалите из [таблицы маршрутизации ВМ](../../../vpc/concepts/static-routes.md#rt-vm) маршрут по умолчанию для нового сетевого интерфейса:

      ```bash
      sudo ip route del default dev <имя_интерфейса>
      ```

  1. [Отключите](../serial-console/disable.md) доступ к серийной консоли ВМ, если он вам больше не нужен.

{% endlist %}

Теперь подключенный сетевой интерфейс активен.


## Убедитесь в работоспособности нового сетевого интерфейса {#test}

Чтобы убедиться в работоспособности добавленного сетевого интерфейса:

{% list tabs group=operating_system %}

- Linux {#linux}

  1. [Подключитесь](../vm-connect/ssh.md#vm-connect) к ВМ по SSH.
  1. Выполните команду, чтобы получить информацию о состоянии сетевых интерфейсов ВМ:

      ```bash
      ip a
      ```

      Результат:

      ```txt
      1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
          link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
          inet 127.0.0.1/8 scope host lo
             valid_lft forever preferred_lft forever
          inet6 ::1/128 scope host
             valid_lft forever preferred_lft forever
      2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
          link/ether d0:0d:b8:99:4f:fa brd ff:ff:ff:ff:ff:ff
          altname enp138s0
          altname ens8
          inet 192.168.2.7/24 metric 100 brd 192.168.2.255 scope global eth0
             valid_lft forever preferred_lft forever
          inet6 fe80::d20d:b8ff:fe99:4ffa/64 scope link
             valid_lft forever preferred_lft forever
      3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
          link/ether d0:2d:b8:99:4f:fa brd ff:ff:ff:ff:ff:ff
          altname enp139s0
          altname ens9
          inet 192.168.4.20/24 metric 200 brd 192.168.4.255 scope global eth1
             valid_lft forever preferred_lft forever
          inet6 fe80::d22d:b8ff:fe99:4ffa/64 scope link
             valid_lft forever preferred_lft forever
      4: eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
          link/ether d0:ad:b8:99:4f:fa brd ff:ff:ff:ff:ff:ff
          altname enp140s0
          altname ens10
          inet 192.168.1.28/24 metric 300 brd 192.168.1.255 scope global eth2
             valid_lft forever preferred_lft forever
          inet6 fe80::d2ad:b8ff:fe99:4ffa/64 scope link
             valid_lft forever preferred_lft forever
      ```

      Состояние `state UP` для интерфейсов `eth0`, `eth1` и `eth2` означает, что сетевые интерфейсы запущены и активны.

  1. Выполните команду, чтобы посмотреть [таблицу маршрутизации ВМ](../../../vpc/concepts/static-routes.md#rt-vm):

      ```bash
      ip r
      ```

      Результат:

      ```txt
      default via 192.168.2.1 dev eth0 proto dhcp src 192.168.2.7 metric 100
      default via 192.168.4.1 dev eth1 proto dhcp src 192.168.4.20 metric 200
      default via 192.168.1.1 dev eth2 proto dhcp src 192.168.1.28 metric 300
      192.168.1.0/24 dev eth2 proto kernel scope link src 192.168.1.28 metric 300
      192.168.1.1 dev eth2 proto dhcp scope link src 192.168.1.28 metric 300
      192.168.1.2 dev eth2 proto dhcp scope link src 192.168.1.28 metric 300
      192.168.2.0/24 dev eth0 proto kernel scope link src 192.168.2.7 metric 100
      192.168.2.1 dev eth0 proto dhcp scope link src 192.168.2.7 metric 100
      192.168.2.2 dev eth0 proto dhcp scope link src 192.168.2.7 metric 100
      192.168.4.0/24 dev eth1 proto kernel scope link src 192.168.4.20 metric 200
      192.168.4.1 dev eth1 proto dhcp scope link src 192.168.4.20 metric 200
      192.168.4.2 dev eth1 proto dhcp scope link src 192.168.4.20 metric 200
      ```

      Маршруты для всех сетевых интерфейсов настроены.

      {% note info %}

      Если добавленные сетевые интерфейсы неактивны или у вас пропала возможность [подключаться](../vm-connect/ssh.md) к ВМ, см. раздел [Решение проблем](../../qa/troubleshooting.md).

      {% endnote %}


- Windows {#windows}

  1. [Подключитесь](../vm-connect/rdp.md) к ВМ по RDP.
  1. В PowerShell выполните команду, чтобы получить информацию о состоянии сетевых интерфейсов ВМ:

      ```powershell
      ipconfig /all
      ```

      Результат:

      ```txt
      Windows IP Configuration

         Host Name . . . . . . . . . . . . : windows-vm
         Primary Dns Suffix  . . . . . . . :
         Node Type . . . . . . . . . . . . : Hybrid
         IP Routing Enabled. . . . . . . . : No
         WINS Proxy Enabled. . . . . . . . : No
         DNS Suffix Search List. . . . . . : {{ region-id }}.internal
                                             auto.internal

      Ethernet adapter Ethernet:

         Connection-specific DNS Suffix  . : {{ region-id }}.internal
         Description . . . . . . . . . . . : Red Hat VirtIO Ethernet Adapter
         Physical Address. . . . . . . . . : D0-2D-7E-E7-46-C5
         DHCP Enabled. . . . . . . . . . . : Yes
         Autoconfiguration Enabled . . . . : Yes
         Link-local IPv6 Address . . . . . : fe80::788f:1f20:e4e4:2f17%10(Preferred)
         IPv4 Address. . . . . . . . . . . : 192.168.4.23(Preferred)
         Subnet Mask . . . . . . . . . . . : 255.255.255.0
         Lease Obtained. . . . . . . . . . : Sunday, May 5, 2024 8:33:25 AM
         Lease Expires . . . . . . . . . . : Wednesday, June 11, 2160 3:05:02 PM
         Default Gateway . . . . . . . . . : 192.168.4.1
         DHCP Server . . . . . . . . . . . : 192.168.4.2
         DHCPv6 IAID . . . . . . . . . . . : 181415294
         DHCPv6 Client DUID. . . . . . . . : 00-01-00-01-2D-C8-FA-25-D0-0D-7E-E7-46-C5
         DNS Servers . . . . . . . . . . . : 192.168.4.2
         NetBIOS over Tcpip. . . . . . . . : Enabled
         Connection-specific DNS Suffix Search List :
                                             {{ region-id }}.internal
                                             auto.internal

      Ethernet adapter eth0:

         Connection-specific DNS Suffix  . : {{ region-id }}.internal
         Description . . . . . . . . . . . : Red Hat VirtIO Ethernet Adapter #2
         Physical Address. . . . . . . . . : D0-0D-7E-E7-46-C5
         DHCP Enabled. . . . . . . . . . . : Yes
         Autoconfiguration Enabled . . . . : Yes
         Link-local IPv6 Address . . . . . : fe80::5e90:6d59:693:3d74%5(Preferred)
         IPv4 Address. . . . . . . . . . . : 192.168.1.27(Preferred)
         Subnet Mask . . . . . . . . . . . : 255.255.255.0
         Lease Obtained. . . . . . . . . . : Sunday, May 5, 2024 8:33:23 AM
         Lease Expires . . . . . . . . . . : Wednesday, June 11, 2160 3:05:02 PM
         Default Gateway . . . . . . . . . : 192.168.1.1
         DHCP Server . . . . . . . . . . . : 192.168.1.2
         DHCPv6 IAID . . . . . . . . . . . : 131075350
         DHCPv6 Client DUID. . . . . . . . : 00-01-00-01-2D-C8-FA-25-D0-0D-7E-E7-46-C5
         DNS Servers . . . . . . . . . . . : 192.168.1.2
         NetBIOS over Tcpip. . . . . . . . : Enabled
         Connection-specific DNS Suffix Search List :
                                             {{ region-id }}.internal
                                             auto.internal

      Ethernet adapter Ethernet 2:

         Connection-specific DNS Suffix  . : {{ region-id }}.internal
         Description . . . . . . . . . . . : Red Hat VirtIO Ethernet Adapter #3
         Physical Address. . . . . . . . . : D0-1D-7E-E7-46-C5
         DHCP Enabled. . . . . . . . . . . : Yes
         Autoconfiguration Enabled . . . . : Yes
         Link-local IPv6 Address . . . . . : fe80::851a:86ae:28fd:90ce%11(Preferred)
         IPv4 Address. . . . . . . . . . . : 192.168.2.15(Preferred)
         Subnet Mask . . . . . . . . . . . : 255.255.255.0
         Lease Obtained. . . . . . . . . . : Sunday, May 5, 2024 8:33:25 AM
         Lease Expires . . . . . . . . . . : Wednesday, June 11, 2160 3:05:02 PM
         Default Gateway . . . . . . . . . : 192.168.2.1
         DHCP Server . . . . . . . . . . . : 192.168.2.2
         DHCPv6 IAID . . . . . . . . . . . : 198188414
         DHCPv6 Client DUID. . . . . . . . : 00-01-00-01-2D-C8-FA-25-D0-0D-7E-E7-46-C5
         DNS Servers . . . . . . . . . . . : 192.168.2.2
         NetBIOS over Tcpip. . . . . . . . : Enabled
         Connection-specific DNS Suffix Search List :
                                             {{ region-id }}.internal
                                             auto.internal
      ```

      Все сетевые интерфейсы запущены и активны.

{% endlist %}