# Назначение публичного IP-адреса серверу {{ baremetal-name }} вручную

В [выделенной публичной подсети](../../baremetal/concepts/public-network.md#public-subnet) [серверов {{ baremetal-name }}](../../baremetal/concepts/servers.md) отсутствует [DHCP-сервер](../../baremetal/concepts/dhcp.md#dhcp-public-subnet). Поэтому на сетевом интерфейсе сервера, подключенного к такой подсети, необходимо вручную задать статический публичный IP-адрес из диапазона адресов подсети, а также прописать адрес шлюза по умолчанию и DNS-серверы.

{% include [public-subnet-address-info](../../_includes/baremetal/public-subnet-address-info.md) %}

{% note info %}

Описанные в этом руководстве шаги применимы также к [эфемерной публичной подсети](../../baremetal/concepts/public-network.md#ephemeral-public-subnet), если при аренде сервера в ней был выключен DHCP-сервер. Эфемерная публичная подсеть всегда имеет размер `/31` и состоит из двух адресов: первый — адрес шлюза по умолчанию, второй — публичный IP-адрес сервера. Подробнее в разделе [{#T}](../../baremetal/concepts/dhcp.md#dhcp-ephemeral-public-subnet).

Для серверов под управлением ОС Windows публичный IP-адрес необходимо назначать вручную в любой эфемерной публичной подсети /31, даже если DHCP-сервер в подсети включен. Это связано с тем, что DHCP-клиент Windows не поддерживает выдачу адресов в подсетях /31.

{% endnote %}

Подробнее об устройстве сетей в сервисе {{ baremetal-full-name }} — в разделе [{#T}](../../baremetal/concepts/network.md).

В данном руководстве вы научитесь вручную настраивать публичный IP-адрес на сетевом интерфейсе сервера {{ baremetal-name }}, подключенного к выделенной публичной подсети. В качестве примера используются серверы под управлением ОС Ubuntu 24.04 LTS, AlmaLinux 9 и Windows Server 2022. При использовании других операционных систем алгоритм действий будет аналогичным, но способ настройки сетевых интерфейсов может отличаться. Инструкции по настройке сетевых интерфейсов в других операционных системах ищите в документации к этим ОС.

Чтобы назначить серверу {{ baremetal-name }} публичный IP-адрес вручную:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Закажите выделенную публичную подсеть](#create-public-subnet).
1. [Арендуйте сервер {{ baremetal-name }}](#rent-server).
1. [Получите параметры публичной подсети](#get-subnet-params).
1. [Подключитесь к серверу по KVM-консоли](#connect-via-kvm).
1. [Определите публичный сетевой интерфейс](#identify-interface).
1. [Назначьте сетевому интерфейсу статический публичный IP-адрес](#assign-ip).
1. [Проверьте сетевую связность](#validate-connectivity).

Смотрите также [Как отказаться от аренды сервера](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость предлагаемого решения входит:

* плата за аренду сервера {{ baremetal-name }};
* Плата за аренду выделенной публичной подсети {{ baremetal-full-name }}.

Подробнее в разделе [тарифы {{ baremetal-full-name }}](../../baremetal/pricing.md).

{% note warning %}

Минимальный срок аренды выделенной публичной подсети — один месяц со дня заказа. Удалить такую подсеть в течение первого месяца после ее заказа нельзя.

{% endnote %}

## Закажите выделенную публичную подсеть {#create-public-subnet}

Закажите [выделенную публичную подсеть](../../baremetal/concepts/public-network.md#public-subnet) размера `/29` в пуле серверов `{{ region-id }}-m3`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы будете создавать инфраструктуру.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. На панели слева выберите ![globe](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.baremetal.label_public-subnets_v16CV }}**.
  1. Справа вверху нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-public-subnet-full }}**.
  1. В поле **{{ ui-key.yacloud.baremetal.field_zone-id }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет доступна подсеть.
  1. В поле **{{ ui-key.yacloud.baremetal.field_hardware-pool-id }}** выберите пул серверов `{{ region-id }}-m3`.
  1. В поле размера подсети выберите `/29`.
  1. В поле **{{ ui-key.yacloud.baremetal.field_name }}** задайте имя подсети: `my-public-subnet`.
  1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-public-subnet }}**.

{% endlist %}

Подробнее об аренде публичной подсети — в разделе [{#T}](../../baremetal/operations/reserve-public-subnet.md).

## Арендуйте сервер {{ baremetal-name }} {#rent-server}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. {% include [server-lease-step2](../../_includes/baremetal/instruction-steps/server-lease-step2.md) %}
  1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-server }}** и в открывшемся окне выберите вариант `{{ ui-key.yacloud_components.baremetal.StockConfigurations }}` и подходящую [конфигурацию](../../baremetal/concepts/server-configurations.md) сервера {{ baremetal-name }} в пуле серверов `{{ region-id }}-m3`.

      Для этого в фильтре в правой части окна в блоке **{{ ui-key.yacloud_components.baremetal.poolFilter }}** выберите пул серверов `{{ region-id }}-m3`.

      Чтобы выбрать подходящую вам конфигурацию сервера, нажмите на блок с именем этой конфигурации в центральной части экрана.

      {% include [server-lease-save-with-assembling-tip](../../_includes/baremetal/instruction-steps/server-lease-save-with-assembling-tip.md) %}

  1. В открывшемся окне с настройками конфигурации сервера:

      1. {% include [server-lease-step5](../../_includes/baremetal/instruction-steps/server-lease-step5.md) %}
      1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-product }}** выберите образ операционной системы, в которой вы будете настраивать сетевой интерфейс (`Ubuntu 24.04`, `AlmaLinux 9` или `Windows Server 2022`).
      1. {% include [server-lease-step8](../../_includes/baremetal/instruction-steps/server-lease-step8.md) %}
      1. В блоке **{{ ui-key.yacloud.baremetal.title_section-network-interfaces }}**:
          1. В поле **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** выберите `{{ ui-key.yacloud.baremetal.label_public-ip-from-dedicated-subnet }}`.
          1. В появившемся поле выбора публичной подсети укажите созданную ранее подсеть `my-public-subnet`.

      1. В блоке **{{ ui-key.yacloud.baremetal.title_server-access }}**:

          {% include [server-lease-access](../../_includes/baremetal/server-lease-access.md) %}

      1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-info }}** в поле **{{ ui-key.yacloud.baremetal.field_name }}** задайте имя сервера: `my-server`.
      1. {% include [server-lease-step13](../../_includes/baremetal/instruction-steps/server-lease-step13.md) %}

{% endlist %}

{% note info %}

Подготовка сервера и установка на него операционной системы может занять до 45 минут — в это время сервер будет находиться в статусе `Provisioning`. После завершения установки ОС сервер перейдет в статус `Ready`.

{% endnote %}

## Получите параметры публичной подсети {#get-subnet-params}

Перед настройкой сетевого интерфейса узнайте параметры выделенной публичной подсети, к которой подключен сервер: CIDR, адрес шлюза по умолчанию и диапазон доступных публичных IP-адресов.

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
1. На панели слева выберите ![globe](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.baremetal.label_public-subnets_v16CV }}** и откройте страницу с информацией о подсети `my-public-subnet`.
1. Запишите значения CIDR, адреса шлюза по умолчанию и диапазона доступных публичных IP-адресов.

   Для подсети размера `/29` (восемь IP-адресов в CIDR):

   * Первый IP-адрес в диапазоне — адрес подсети;
   * Второй IP-адрес в диапазоне — адрес шлюза по умолчанию;
   * С третьего по предпоследний адреса в диапазоне — адреса, доступные для назначения сетевым интерфейсам серверов;
   * последний IP-адрес в диапазоне — [широковещательный](https://ru.wikipedia.org/wiki/Широковещательный_адрес) (`broadcast`) адрес.

   Например, если CIDR подсети — `198.51.100.104/29`:

   * IP-адрес подсети — `198.51.100.104`.
   * IP-адрес шлюза по умолчанию — `198.51.100.105`.
   * Доступные адреса — `198.51.100.106` — `198.51.100.110`.
   * Широковещательный адрес — `198.51.100.111`.

   Эти значения будут использоваться в примерах команд далее в инструкции. Подставьте вместо них значения, полученные для вашей подсети.

## Подключитесь к серверу по KVM-консоли {#connect-via-kvm}

До настройки публичного IP-адреса сервер недоступен из интернета, поэтому подключиться к нему [по SSH](../../compute/operations/vm-connect/ssh.md) или [по RDP](../../compute/operations/vm-connect/rdp.md) не получится. Для подключения к серверу используйте KVM-консоль.

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
1. В строке с сервером `my-server` нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.baremetal.label_kvm-console_37Kma }}**.

    Откроется окно с терминалом KVM-консоли.

    Если терминал не отображается, попробуйте [перезапустить](../../baremetal/operations/servers/server-stop-and-start.md#restart) сервер.

1. Аутентифицируйтесь на сервере, используя сохраненный при аренде сервера пароль администратора (`root` для Linux, `Administrator` для Windows).

    {% include [kvm-paste-tip](../../_includes/baremetal/kvm-paste-tip.md) %}

    Если вы не сохранили пароль администратора, вы можете создать новый пароль по [инструкции](../../baremetal/operations/servers/reset-password.md) или [переустановить](../../baremetal/operations/servers/reinstall-os-from-marketplace.md) операционную систему на сервере.

Подробнее о подключении к серверу через KVM-консоль — в разделе [{#T}](../../baremetal/operations/servers/server-kvm.md).

## Определите публичный сетевой интерфейс {#identify-interface}

Чтобы понять, какой из сетевых интерфейсов сервера подключен к публичной сети, сопоставьте имя интерфейса с MAC-адресом, указанным в [консоли управления]({{ link-console-main }}) на странице с информацией о сервере в блоке **{{ ui-key.yacloud.baremetal.title_section-network-interfaces }}**.

Запишите MAC-адрес публичного сетевого интерфейса — он понадобится для настройки.

{% list tabs group=operating_system %}

- Ubuntu/Debian/AlmaLinux {#linux}

  В терминале KVM-консоли выполните команду:

  ```bash
  ip a
  ```

  Результат:

  ```text
  ...
  2: etx1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
      link/ether 00:25:90:c8:03:f8 brd ff:ff:ff:ff:ff:ff
      altname enp2s0f0
      inet6 fe80::225:90ff:fec8:3f8/64 scope link
          valid_lft forever preferred_lft forever
  3: etx2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
      link/ether 00:25:90:c8:03:f9 brd ff:ff:ff:ff:ff:ff
      altname enp2s0f1
      inet6 fe80::225:90ff:fec8:3f9/64 scope link
          valid_lft forever preferred_lft forever
  ...
  ```

  В этом примере публичный MAC-адрес из консоли управления — `00:25:90:c8:03:f9`, поэтому публичный сетевой интерфейс сервера — `eth2`.

- Windows Server {#windows}

  В PowerShell выполните команду:

  ```powershell
  Get-NetAdapter | Format-Table Name, InterfaceDescription, MacAddress, Status
  ```

  Результат:

  ```text
  Name       InterfaceDescription                          MacAddress         Status
  ----       --------------------                          ----------         ------
  Ethernet   Mellanox ConnectX-4 Lx Adapter #1             00-25-90-C8-03-F8  Up
  Ethernet 2 Mellanox ConnectX-4 Lx Adapter #2             00-25-90-C8-03-F9  Up
  ```

  В этом примере публичный MAC-адрес из консоли управления — `00:25:90:c8:03:f9`, поэтому публичный сетевой интерфейс сервера — `Ethernet 2`.

{% endlist %}

{% note warning %}

Если арендованный сервер поддерживает технологию [MC-LAG](../../baremetal/concepts/mc-lag.md) и установлен из [собственного образа](../../baremetal/concepts/images.md#user-images), физические сетевые интерфейсы автоматически не объединяются в группы агрегирования. В этом случае рекомендуется сначала [настроить группу агрегирования](../../baremetal/operations/servers/set-up-mc-lag.md) для пары публичных интерфейсов, а статический публичный IP-адрес назначать на bond-интерфейс. В настройках bond-интерфейса в качестве MAC-адреса нужно указывать MAC-адрес одного из физических интерфейсов группы агрегирования.

{% endnote %}

## Назначьте сетевому интерфейсу статический публичный IP-адрес {#assign-ip}

{% list tabs group=operating_system %}

- Ubuntu/Debian (Netplan) {#ubuntu}

  1. В терминале KVM-консоли узнайте имя файла конфигурации [Netplan](https://netplan.io/):

      ```bash
      ls /etc/netplan/
      ```

      Результат:

      ```text
      50-cloud-init.yaml
      ```
  1. Откройте файл конфигурации:

      ```bash
      nano /etc/netplan/50-cloud-init.yaml
      ```
  1. Внесите изменения в настройки публичного сетевого интерфейса:

      ```yaml
      network:
        version: 2
        ethernets:
          ... # В этом примере приведена только конфигурация публичного интерфейса
          etx2:
            match:
              macaddress: "00:25:90:c8:03:f9"
            dhcp4: false # Отключите DHCP на интерфейсе
            set-name: "etx2"
            addresses: # Задайте статический публичный IP-адрес и маску подсети
              - 198.51.100.106/29
            routes: # Задайте маршрут по умолчанию через шлюз публичной подсети
              - to: default
                via: 198.51.100.105
            nameservers: # Задайте DNS-серверы
              addresses: [77.88.8.8, 77.88.8.1]
      ```

      Где:

      * `match.macaddress` — MAC-адрес публичного сетевого интерфейса.
      * `dhcp4` — значение `false` отключает DHCP на интерфейсе.
      * `addresses` — публичный IP-адрес из диапазона доступных адресов подсети с указанием маски подсети в формате CIDR.
      * `routes.to: default` и `via` — маршрут по умолчанию через адрес шлюза публичной подсети.
      * `nameservers.addresses` — адреса DNS-серверов.

      Чтобы сохранить изменения и выйти из текстового редактора, на клавиатуре нажмите сочетание клавиш **Ctrl + X** и подтвердите сохранение изменений в файл `50-cloud-init.yaml`.
  1. Проверьте корректность конфигурации:

      ```bash
      netplan try
      ```

      Если в конфигурации нет ошибок, утилита временно применит ее и предложит подтвердить изменения. Подтвердите изменения, нажав **ENTER**.
  1. Примените новую конфигурацию:

      ```bash
      netplan apply
      ```

- AlmaLinux/RHEL/CentOS (NetworkManager) {#almalinux}

  Для настройки сетевого интерфейса используйте утилиту `nmcli`. Также можно использовать графическую утилиту `nmtui`, которая предоставляет интерактивный текстовый интерфейс к NetworkManager.

  1. В терминале KVM-консоли посмотрите список сетевых подключений:

      ```bash
      nmcli connection show
      ```

      Результат:

      ```text
      NAME         UUID                                  TYPE      DEVICE
      System etx1  5fb06bd0-0bb0-7ffb-45f1-d6edd65f3e03  ethernet  etx1
      System etx2  5fb06bd0-0bb0-7ffb-45f1-d6edd65f3e04  ethernet  etx2
      ```

      Найдите имя подключения для публичного сетевого интерфейса. В этом примере — `System etx2`.
  1. Задайте для подключения статический публичный IP-адрес, шлюз по умолчанию и DNS-серверы:

      ```bash
      nmcli connection modify "System etx2" \
        ipv4.method manual \
        ipv4.addresses 198.51.100.106/29 \
        ipv4.gateway 198.51.100.105 \
        ipv4.dns "77.88.8.8 77.88.8.1" \
        connection.autoconnect yes
      ```

      Где:

      * `ipv4.method manual` — отключает DHCP и переводит подключение в режим статической настройки.
      * `ipv4.addresses` — публичный IP-адрес из диапазона доступных адресов подсети с указанием маски подсети в формате CIDR.
      * `ipv4.gateway` — адрес шлюза публичной подсети.
      * `ipv4.dns` — адреса DNS-серверов через пробел.
      * `connection.autoconnect yes` — включает автоматическую активацию подключения при загрузке системы.
  1. Активируйте подключение:

      ```bash
      nmcli connection up "System etx2"
      ```

- Windows Server (GUI) {#windows-gui}

  1. В KVM-консоли откройте меню **Start** → **Control Panel** → **Network and Internet** → **Network and Sharing Center**.
  1. На панели слева выберите **Change adapter settings**.
  1. В открывшемся списке найдите сетевой адаптер, соответствующий публичному сетевому интерфейсу (например, `Ethernet 2`), нажмите на него правой кнопкой мыши и выберите **Properties**.
  1. В списке компонентов подключения выберите **Internet Protocol Version 4 (TCP/IPv4)** и нажмите **Properties**.
  1. Выберите **Use the following IP address** и заполните поля:

      * **IP address** — публичный IP-адрес из диапазона доступных адресов подсети, например, `198.51.100.106`.
      * **Subnet mask** — маска подсети, соответствующая CIDR. Для `/29` — `255.255.255.248`.
      * **Default gateway** — адрес шлюза публичной подсети, например, `198.51.100.105`.
  1. Выберите **Use the following DNS server addresses** и заполните поля:

      * **Preferred DNS server** — `77.88.8.8`.
      * **Alternate DNS server** — `77.88.8.1`.
  1. Нажмите **OK** в обоих окнах для сохранения настроек.

- Windows Server (PowerShell) {#windows-cli}

  В терминале PowerShell в KVM-консоли:

  1. Удалите имеющуюся конфигурацию IPv4 на публичном сетевом интерфейсе, если она была получена по DHCP:

      ```powershell
      Set-NetIPInterface -InterfaceAlias "Ethernet 2" -Dhcp Disabled
      Remove-NetIPAddress -InterfaceAlias "Ethernet 2" -AddressFamily IPv4 -Confirm:$false
      Remove-NetRoute -InterfaceAlias "Ethernet 2" -AddressFamily IPv4 -Confirm:$false
      ```
  1. Задайте статический публичный IP-адрес и шлюз по умолчанию:

      ```powershell
      New-NetIPAddress -InterfaceAlias "Ethernet 2" `
        -IPAddress 198.51.100.106 `
        -PrefixLength 29 `
        -DefaultGateway 198.51.100.105
      ```

      Где:

      * `-InterfaceAlias` — имя публичного сетевого интерфейса.
      * `-IPAddress` — публичный IP-адрес из диапазона доступных адресов подсети.
      * `-PrefixLength` — длина префикса маски подсети (для `/29` — `29`).
      * `-DefaultGateway` — адрес шлюза публичной подсети.
  1. Задайте DNS-серверы для интерфейса:

      ```powershell
      Set-DnsClientServerAddress -InterfaceAlias "Ethernet 2" `
        -ServerAddresses ("77.88.8.8","77.88.8.1")
      ```

{% endlist %}

## Проверьте сетевую связность {#validate-connectivity}

Убедитесь, что сетевому интерфейсу был назначен публичный IP-адрес и сервер имеет доступ в интернет.

{% list tabs group=operating_system %}

- Ubuntu/Debian/AlmaLinux {#linux}

  1. Проверьте, что сетевому интерфейсу присвоен заданный IP-адрес:

      ```bash
      ip a | grep etx2
      ```

      Результат:

      ```text
      3: etx2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
          inet 198.51.100.106/29 brd 198.51.100.111 scope global etx2
      ```
  1. Проверьте таблицу маршрутизации:

      ```bash
      ip r
      ```

      Результат:

      ```text
      default via 198.51.100.105 dev etx2 proto static
      198.51.100.104/29 dev etx2 proto kernel scope link src 198.51.100.106
      ```
  1. Проверьте настройки DNS:

      ```bash
      resolvectl status
      ```
  1. Проверьте сетевую связность с интернетом:

      ```bash
      ping ya.ru -c 5
      ```

      Результат:

      ```text
      PING ya.ru (77.88.55.88) 56(84) bytes of data.
      64 bytes from ya.ru (77.88.55.88): icmp_seq=1 ttl=55 time=3.45 ms
      64 bytes from ya.ru (77.88.55.88): icmp_seq=2 ttl=55 time=3.22 ms
      ...

      --- ya.ru ping statistics ---
      5 packets transmitted, 5 received, 0% packet loss, time 4006ms
      rtt min/avg/max/mdev = 3.215/3.337/3.452/0.085 ms
      ```

- Windows Server {#windows}

  1. В PowerShell проверьте, что сетевому интерфейсу присвоен заданный IP-адрес:

      ```powershell
      Get-NetIPAddress -InterfaceAlias "Ethernet 2" -AddressFamily IPv4
      ```
  1. Проверьте таблицу маршрутизации:

      ```powershell
      Get-NetRoute -InterfaceAlias "Ethernet 2" -AddressFamily IPv4
      ```
  1. Проверьте настройки DNS:

      ```powershell
      Get-DnsClientServerAddress -InterfaceAlias "Ethernet 2"
      ```
  1. Проверьте сетевую связность с интернетом:

      ```powershell
      Test-NetConnection ya.ru -InformationLevel Detailed
      ```

{% endlist %}

После того как публичный IP-адрес назначен, вы можете подключиться к серверу из интернета по этому IP-адресу [по SSH](../../compute/operations/vm-connect/ssh.md) (для Linux) или [по RDP](../../compute/operations/vm-connect/rdp.md) (для Windows).

## Как отказаться от аренды {#clear-out}

Удалить сервер {{ baremetal-name }} или выделенную публичную подсеть нельзя. Вместо этого можно отказаться от продления их аренды.

Чтобы перестать платить за созданные ресурсы:

1. [Откажитесь](../../baremetal/operations/servers/server-lease-cancel.md) от продления аренды созданного ранее сервера {{ baremetal-name }}.
1. По истечении минимального срока аренды (один месяц со дня заказа) удалите выделенную публичную подсеть.

#### Смотрите также {#see-also}

* [{#T}](../../baremetal/concepts/public-network.md)
* [{#T}](../../baremetal/concepts/dhcp.md)
* [{#T}](../../baremetal/operations/reserve-public-subnet.md)
* [{#T}](../../baremetal/operations/servers/set-up-mc-lag.md)
* [{#T}](../../baremetal/tutorials/bms-simple-subnet.md)
