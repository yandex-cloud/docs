# Настройка VRRP для кластера серверов {{ baremetal-name }} с использованием Keepalived


[VRRP](https://ru.wikipedia.org/wiki/VRRP) (Virtual Router Redundancy Protocol) позволяет нескольким узлам в одной сети совместно использовать виртуальный IP-адрес. Узлы обмениваются объявлениями VRRP и выбирают активный узел. Если он становится недоступен, резервный узел назначает виртуальный IP-адрес своему интерфейсу.

В этом руководстве вы настроите на [серверах](../../baremetal/concepts/servers.md) {{ baremetal-name }} отказоустойчивый виртуальный IP-адрес с помощью сервиса [Keepalived](https://keepalived.org/). Keepalived управляет только виртуальным IP-адресом: установка и настройка прокси-сервера или другого приложения в руководство не входят.

## Схема решения {#solution-overview}

![bms-vrf-routing-scheme](../../_assets/baremetal/bms-vrf-routing-scheme.svg)

В зоне доступности `{{ region-id }}-m` вы настроите окружение из двух [приватных подсетей](../../baremetal/concepts/private-network.md#private-subnet) `subnet-m3` и `subnet-m4`, созданных соответственно в [пулах серверов](../../baremetal/concepts/servers.md#server-pools) `{{ region-id }}-m3` и `{{ region-id }}-m4`. Эти подсети вы объедините в [виртуальный фрагмент сети](../../baremetal/concepts/private-network.md#vrf-segment) (VRF) `vrrp-vrf`.

В подсети `subnet-m3` вы создадите два сервера {{ baremetal-name }} — `master-server-m3` и `backup-server-m3`, которые будут выполнять роли `MASTER` и `BACKUP` в VRRP-группе. На обоих серверах вы запустите Keepalived и настроите виртуальный IP-адрес для группы в пуле `{{ region-id }}-m3`.

В подсети `subnet-m4` в пуле серверов `{{ region-id }}-m4` вы создадите сервер {{ baremetal-name }} `client-server-m4`, который будет выступать в качестве клиента при использовании виртуального IP-адреса, созданного в пуле `{{ region-id }}-m3`.

Серверы `master-server-m3` и `backup-server-m3` обмениваются объявлениями VRRP в общей приватной подсети. Клиент из подсети `subnet-m4` обращается к виртуальному IP-адресу через маршрутизацию L3 в VRF. VRRP использует multicast, а не широковещательную рассылку.

{% note info %}

Участники группы VRRP должны находиться в одной приватной подсети одного пула серверов. VRF обеспечивает маршрутизацию L3 между подсетями разных пулов, но не переносит объявления VRRP между ними. В этом примере VRRP работает только между серверами в пуле `{{ region-id }}-m3`.

{% endnote %}

Чтобы настроить отказоустойчивый кластер серверов {{ baremetal-name }} с использованием VRRP:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте виртуальный сетевой сегмент](#create-vrf).
1. [Создайте приватные подсети](#create-subnetworks).
1. [Арендуйте серверы {{ baremetal-name }}](#rent-servers).
1. [Настройте Keepalived на серверах пула {{ region-id }}-m3](#setup-keepalived).
1. [Убедитесь в работоспособности решения](#test-solution).

Если сервер вам больше не нужен, [откажитесь от аренды](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость предлагаемого решения входит плата за аренду серверов {{ baremetal-name }} ([тарифы {{ baremetal-full-name }}](../../baremetal/pricing.md)).

## Создайте виртуальный сетевой сегмент {#create-vrf}

Чтобы связать несколько приватных подсетей на уровне L3 сетевой модели OSI, их необходимо объединить в виртуальный фрагмент сети (VRF).

Создайте новый VRF:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы будете создавать инфраструктуру.
  1. [Перейдите]({{ link-console-main }}/link/baremetal) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. На панели слева выберите ![icon](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud.baremetal.label_networks_kHgng }}** и нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-network }}**.
  1. В поле **{{ ui-key.yacloud.baremetal.field_name }}** задайте имя VRF: `vrrp-vrf`.
  1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-network }}**.

{% endlist %}

## Создайте приватные подсети {#create-subnetworks}

Создайте две приватные подсети в разных [пулах серверов](../../baremetal/concepts/servers.md#server-pools) и добавьте их в созданный ранее виртуальный фрагмент сети:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. [Перейдите]({{ link-console-main }}/link/baremetal) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. На панели слева выберите ![icon](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.baremetal.label_subnetworks_uU4LH }}** и нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.
  1. В поле **{{ ui-key.yacloud.baremetal.field_hardware-pool-id }}** выберите пул серверов `{{ region-id }}-m3`.
  1. В поле **{{ ui-key.yacloud.baremetal.field_name }}** задайте имя подсети: `subnet-m3`.
  1. Включите опцию **{{ ui-key.yacloud.baremetal.title_routing-settings }}**.
  1. В поле **{{ ui-key.yacloud.baremetal.field_network-id }}** выберите созданный ранее сегмент `vrrp-vrf`.
  1. В поле **{{ ui-key.yacloud.baremetal.field_CIDR_rwYMi }}** укажите `172.28.1.0/24`.
  1. В поле **{{ ui-key.yacloud.baremetal.field_gateway_t7LLk }}** оставьте шлюз по умолчанию `172.28.1.1`.
  1. Включите опцию **{{ ui-key.yacloud.baremetal.field_dhcp-settings }}** и задайте диапазон DHCP-адресов от `172.28.1.2` до `172.28.1.253`. Адрес `172.28.1.254` будет виртуальным IP-адресом, поэтому исключите его из диапазона DHCP.
  1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.
  1. Аналогичным образом создайте приватную подсеть `subnet-m4` в пуле серверов `{{ region-id }}-m4` с CIDR `172.28.2.0/24`, шлюзом `172.28.2.1` и диапазоном DHCP-адресов от `172.28.2.2` до `172.28.2.254`.

{% endlist %}

## Арендуйте серверы {{ baremetal-name }} {#rent-servers}

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
      1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-product }}** выберите образ `Ubuntu 24.04`.
      1. {% include [server-lease-step8](../../_includes/baremetal/instruction-steps/server-lease-step8.md) %}
      1. В блоке **{{ ui-key.yacloud.baremetal.title_section-network-interfaces }}**:
          1. В поле **{{ ui-key.yacloud.baremetal.field_subnet-id }}** выберите созданную ранее подсеть `subnet-m3`.
          1. В поле **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** выберите `{{ ui-key.yacloud.baremetal.label_public-ip-ephemeral }}`.

      1. В блоке **{{ ui-key.yacloud.baremetal.title_server-access }}**:
      
          {% include [server-lease-access](../../_includes/baremetal/server-lease-access.md) %}

      1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-info }}** в поле **{{ ui-key.yacloud.baremetal.field_name }}** задайте имя сервера: `master-server-m3`.
      1. {% include [server-lease-step13](../../_includes/baremetal/instruction-steps/server-lease-step13.md) %}
  1. Аналогичным способом арендуйте еще два сервера: `backup-server-m3` в пуле `{{ region-id }}-m3` с подсетью `subnet-m3` и `client-server-m4` в пуле `{{ region-id }}-m4` с подсетью `subnet-m4`. Для каждого сервера выберите эфемерный публичный IP-адрес, чтобы подключаться к нему по SSH.

{% endlist %}

На открывшейся странице со списком серверов {{ baremetal-name }} отобразится информация обо всех созданных серверах. В поле **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** таблицы скопируйте публичные IP-адреса серверов — они понадобятся для подключения к серверам по SSH.

{% note info %}

Подготовка серверов и установка на них операционных систем может занять до 45 минут — в это время серверы будут находиться в статусе `Provisioning`. После завершения установки ОС серверы перейдут в статус `Ready`.

{% endnote %}

## Настройте Keepalived на серверах пула {{ region-id }}-m3 {#setup-keepalived}

На этом этапе вы установите, настроите и запустите сервис [Keepalived](https://keepalived.org/) на серверах, созданных в пуле `{{ region-id }}-m3`.

Используйте приведенную ниже инструкцию, чтобы настроить оба сервера — `master-server-m3` и `backup-server-m3`.

1. [Подключитесь](../../baremetal/quickstart.md#server-connect) к серверу по SSH, используя его публичный IP-адрес.
1. Установите сервис Keepalived, выполнив команду:

    ```bash
    sudo apt update && sudo apt install keepalived -y
    ```
1. Посмотрите список сетевых интерфейсов сервера:

    ```bash
    ip a
    ```

    Результат:

    ```text
    ...
    5: etx2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
        link/ether 00:02:c9:35:fd:31 brd ff:ff:ff:ff:ff:ff
        altname enp6s0d1
        inet 172.28.1.2/24 metric 100 brd 172.28.1.255 scope global dynamic etx2
           valid_lft 3512sec preferred_lft 3512sec
        inet6 fe80::202:c9ff:fe35:fd31/64 scope link
           valid_lft forever preferred_lft forever
    ```

    В выводе команды найдите интерфейс с IP-адресом, относящимся к диапазону `172.28.1.0/24`, назначенному приватной подсети `subnet-m3`. В примере выше это интерфейс с идентификатором `etx2`. Идентификатор интерфейса понадобится далее, при настройке Keepalived.

    Имя интерфейса может различаться на серверах. Укажите в конфигурации каждого сервера имя его собственного интерфейса.
1. Создайте файл конфигурации Keepalived:

    ```bash
    sudo nano /etc/keepalived/keepalived.conf
    ```
1. Добавьте в созданный файл конфигурацию для роли сервера:

    {% list tabs %}

    - Master

      ```text
      vrrp_instance M3_1 {
          state MASTER
          interface etx2
          virtual_router_id 51
          priority 100
          advert_int 1

          virtual_ipaddress {
              172.28.1.254
          }
      }
      ```

    - Backup

      ```text
      vrrp_instance M3_2 {
          state BACKUP
          interface etx2
          virtual_router_id 51
          priority 90
          advert_int 1

          virtual_ipaddress {
              172.28.1.254
          }
      }
      ```

    {% endlist %}

    Где:

    * `vrrp_instance` — имя экземпляра VRRP. Оно может различаться на серверах:
    
        * для сервера с ролью `MASTER` — `M3_1`
        * для сервера с ролью `BACKUP` — `M3_2`
    * `state` — начальное состояние экземпляра: `MASTER` или `BACKUP`. После запуска Keepalived узел с наибольшим приоритетом становится активным.
    * `interface` — идентификатор сетевого интерфейса, на котором будет работать виртуальный IP-адрес. В примере выше — `etx2`.
    * `virtual_router_id` — идентификатор группы VRRP. Он должен совпадать на всех серверах группы и не использоваться другими группами в этой подсети.
    * `priority` — приоритет узла. Активным становится узел с наибольшим значением; в примере используются значения `100` и `90`.
    * `advert_int` — интервал объявления состояния в секундах.
    * `virtual_ipaddress` — виртуальный IP-адрес, который будет управляться этим узлом. Виртуальный IP-адрес:

        * должен входить в CIDR приватной подсети группы VRRP;
        * должен быть не занят;
        * должен быть исключен из диапазона DHCP и совпадать в конфигурациях всех серверов группы.

    Keepalived по умолчанию допускает возврат активной роли к узлу с более высоким приоритетом после его восстановления.

    В примере не задана аутентификация VRRP. Параметр `auth_pass` в режиме `PASS` ограничен восемью символами и не обеспечивает надежную защиту. Ограничьте доступ к приватной сети средствами сетевой безопасности.
1. Включите автозапуск и запустите Keepalived:

    ```bash
    sudo systemctl enable --now keepalived.service
    ```
1. Проверьте журнал Keepalived:

    ```bash
    sudo journalctl -u keepalived.service -b --no-pager
    ```

    Результат:

    {% list tabs %}

    - Master

      ```text
      systemd[1]: Starting keepalived.service - Keepalive Daemon (LVS and VRRP)...
      Keepalived[4045]: Starting Keepalived v2.2.8 (04/04,2023), git commit v2.2.7-154-g292b299e+
      Keepalived[4045]: Running on Linux 6.8.0-53-generic #55-Ubuntu SMP PREEMPT_DYNAMIC Fri Jan 17 15:37:52 UTC 2025 (built for Linux 6.8.0)
      Keepalived[4045]: Command line: '/usr/sbin/keepalived' '--dont-fork'
      Keepalived[4045]: Configuration file /etc/keepalived/keepalived.conf
      Keepalived[4045]: NOTICE: setting config option max_auto_priority should result in better keepalived performance
      Keepalived[4045]: Starting VRRP child process, pid=4046
      Keepalived[4045]: Startup complete
      systemd[1]: Started keepalived.service - Keepalive Daemon (LVS and VRRP).
      Keepalived_vrrp[4046]: (M3_1) Entering BACKUP STATE (init)
      Keepalived_vrrp[4046]: (M3_1) Entering MASTER STATE
      ```

    - Backup

      ```text
      systemd[1]: Starting keepalived.service - Keepalive Daemon (LVS and VRRP)...
      Keepalived[2751]: Starting Keepalived v2.2.8 (04/04,2023), git commit v2.2.7-154-g292b299e+
      Keepalived[2751]: Running on Linux 6.8.0-53-generic #55-Ubuntu SMP PREEMPT_DYNAMIC Fri Jan 17 15:37:52 UTC 2025 (built for Linux 6.8.0)
      Keepalived[2751]: Command line: '/usr/sbin/keepalived' '--dont-fork'
      Keepalived[2751]: Configuration file /etc/keepalived/keepalived.conf
      Keepalived[2751]: NOTICE: setting config option max_auto_priority should result in better keepalived performance
      Keepalived[2751]: Starting VRRP child process, pid=2752
      Keepalived[2751]: Startup complete
      Keepalived_vrrp[2752]: (M3_2) Entering BACKUP STATE (init)
      ```

    {% endlist %}

## Убедитесь в работоспособности решения {#test-solution}

1. Убедитесь, что виртуальный IP-адрес был добавлен к сетевому интерфейсу сервера с ролью `Master`:
    1. [Подключитесь](../../baremetal/quickstart.md#server-connect) по SSH к серверу `master-server-m3`.
    1. Посмотрите конфигурацию сетевого интерфейса, назначенного приватной подсети `subnet-m3`.

        ```bash
        ip a
        ```

        Результат:

        ```text
        ...
        5: etx2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
            link/ether 00:02:c9:35:fd:31 brd ff:ff:ff:ff:ff:ff
            altname enp6s0d1
            inet 172.28.1.2/24 metric 100 brd 172.28.1.255 scope global dynamic etx2
            valid_lft 3575sec preferred_lft 3575sec
            inet 172.28.1.254/32 scope global etx2
            valid_lft forever preferred_lft forever
            inet6 fe80::202:c9ff:fe35:fd31/64 scope link
            valid_lft forever preferred_lft forever
        ```

        Сетевой интерфейс получил дополнительный виртуальный IP-адрес `172.28.1.254/32`, заданный в конфигурации Keepalived.

1. С помощью [ICMP](https://ru.wikipedia.org/wiki/ICMP)-запросов из приватной подсети `subnet-m4` убедитесь в доступности виртуального IP-адреса, расположенного в приватной подсети `subnet-m3`:

    1. [Подключитесь](../../baremetal/quickstart.md#server-connect) по SSH к серверу `client-server-m4`.
    1. Выполните команду:

        ```bash
        ping 172.28.1.254 -s 1024 -c 5
        ```

        Результат:

        ```text
        PING 172.28.1.254 (172.28.1.254) 1024(1052) bytes of data.
        1032 bytes from 172.28.1.254: icmp_seq=1 ttl=62 time=0.211 ms
        1032 bytes from 172.28.1.254: icmp_seq=2 ttl=62 time=0.242 ms
        1032 bytes from 172.28.1.254: icmp_seq=3 ttl=62 time=0.264 ms
        1032 bytes from 172.28.1.254: icmp_seq=4 ttl=62 time=0.312 ms
        1032 bytes from 172.28.1.254: icmp_seq=5 ttl=62 time=0.273 ms

        --- 172.28.1.254 ping statistics ---
        5 packets transmitted, 5 received, 0% packet loss, time 4117ms
        rtt min/avg/max/mdev = 0.211/0.260/0.312/0.033 ms
        ```

        Полученные ответы подтверждают, что клиент из подсети `subnet-m4` достигает виртуального IP-адреса через VRF.

1. Проверьте переключение виртуального IP-адреса при отказе активного узла:

    1. [Подключитесь](../../baremetal/quickstart.md#server-connect) по SSH к серверу `client-server-m4`.
    1. В отдельном окне терминала [подключитесь](../../baremetal/quickstart.md#server-connect) по SSH к серверу `master-server-m3`.

        Расположите окна терминала так, чтобы одновременно видеть содержимое обоих окон.
    1. В окне терминала с сессией подключения к серверу `client-server-m4` повторно запустите утилиту `ping` без ограничения на количество повторений:

        ```bash
        ping 172.28.1.254 -s 1024
        ```

        Пока выполняется `ping`, в окне терминала сервера `master-server-m3` остановите Keepalived:
        
        ```bash
        sudo systemctl stop keepalived.service
        ```
        
        Убедитесь, что после остановки сервиса виртуальный IP-адрес переходит к резервному серверу. Команда `ping` продолжит выполняться, хотя при переключении возможна кратковременная потеря пакетов из-за ожидания объявлений VRRP и выбора нового активного узла.

        Результат:

        ```text
        PING 172.28.1.254 (172.28.1.254) 1024(1052) bytes of data.
        1032 bytes from 172.28.1.254: icmp_seq=1 ttl=62 time=0.249 ms
        ...
        1032 bytes from 172.28.1.254: icmp_seq=56 ttl=62 time=0.224 ms
        1032 bytes from 172.28.1.254: icmp_seq=57 ttl=62 time=0.314 ms
        1032 bytes from 172.28.1.254: icmp_seq=58 ttl=62 time=0.278 ms
        ^C
        --- 172.28.1.254 ping statistics ---
        58 packets transmitted, 55 received, 5.17241% packet loss, time 58368ms
        rtt min/avg/max/mdev = 0.185/0.271/0.326/0.035 ms
        ```
    1. В окне терминала сервера `master-server-m3` запустите Keepalived:

        ```bash
        sudo systemctl start keepalived.service
        ```
1. Проверьте журнал логов сервиса Keepalived на сервере с ролью `BACKUP`:

    1. [Подключитесь](../../baremetal/quickstart.md#server-connect) по SSH к серверу `backup-server-m3`.
    1. Посмотрите журнал логов сервиса Keepalived:

        ```bash
        sudo journalctl -u keepalived.service -b --no-pager
        ```

        Результат:

        ```text
        ...
        # регистрация события о переключении на MASTER в момент остановки сервиса на исходном основном узле
        Feb 19 07:08:07 backup-server-m3 Keepalived_vrrp[2752]: (M3_2) Entering MASTER STATE

        # регистрация события о переключении на BACKUP при восстановлении работы сервиса на исходном основном узле
        Feb 19 07:08:31 backup-server-m3 Keepalived_vrrp[2752]: (M3_2) Master received advert from 172.28.1.2 with higher priority 100, ours 90
        Feb 19 07:08:31 backup-server-m3 Keepalived_vrrp[2752]: (M3_2) Entering BACKUP STATE
        ...
        ```

        После остановки Keepalived на `master-server-m3` резервный узел `backup-server-m3` стал активным. После повторного запуска Keepalived приоритет вернул активную роль серверу `master-server-m3`.

## Как отказаться от аренды серверов {#clear-out}

Удалить серверы {{ baremetal-name }} нельзя. Вместо этого можно отказаться от продления их аренды.

Чтобы перестать платить за созданные ресурсы, [откажитесь](../../baremetal/operations/servers/server-lease-cancel.md) от продления аренды созданных ранее серверов {{ baremetal-name }}.
