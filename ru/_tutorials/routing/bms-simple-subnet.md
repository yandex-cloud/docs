# Организация сетевой связности в приватной подсети {{ baremetal-full-name }}


Чтобы [серверы {{ baremetal-name }}](../../baremetal/concepts/servers.md), подключенные к [приватной подсети](../../baremetal/concepts/private-network.md#private-subnet), получали IP-адреса по [DHCP](https://ru.wikipedia.org/wiki/DHCP), подключите подсеть к [VRF](../../baremetal/concepts/private-network.md#vrf-segment), укажите CIDR и включите DHCP-сервис в настройках подсети.

Если маршрутизация не настроена, подсеть работает на уровне L2 [сетевой модели OSI](https://ru.wikipedia.org/wiki/Сетевая_модель_OSI). DHCP-сервер для такой подсети недоступен, поэтому для сетевого взаимодействия назначьте IP-адреса интерфейсам серверов вручную.

В {{ baremetal-name }} DHCP-сервис в подсети по умолчанию выключен. В этом руководстве сначала будет настроена статическая адресация, затем — маршрутизация и подключение к [виртуальному сегменту сети](../../baremetal/concepts/private-network.md#vrf-segment) (VRF).

{% note info %}

При установке операционной системы из образов [{{ marketplace-full-name }}]({{ link-cloud-marketplace }}) настройки DHCP на физических интерфейсах задаются в соответствии с настройками подсетей. Подробнее — в разделе [{#T}](../../baremetal/concepts/dhcp.md#dhcp-private).

{% endnote %}

Подробнее об устройстве сетей в сервисе {{ baremetal-full-name }} смотрите в разделе [{#T}](../../baremetal/concepts/network.md).

В этом руководстве вы назначите статические IP-адреса интерфейсам серверов, включите маршрутизацию в подсети и настроите интерфейсы на получение IP-адресов по DHCP.

В примере используются серверы {{ baremetal-name }} под управлением Ubuntu 24.04 LTS. В других операционных системах порядок действий будет аналогичным, но способы настройки сетевых интерфейсов могут отличаться. Инструкции по настройке сетевых интерфейсов в других операционных системах смотрите в документации к этим ОС.

Чтобы настроить сетевую связность в подсети {{ baremetal-full-name }}:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте приватную подсеть](#create-subnet).
1. [Арендуйте серверы {{ baremetal-name }}](#rent-servers).
1. [Вручную настройте сетевые интерфейсы](#setup-interfaces).
1. [Создайте VRF и включите маршрутизацию в приватной подсети](#setup-vrf).
1. [Включите DHCP на сетевых интерфейсах](#re-enable-dhcp).

Если сервер вам больше не нужен, [откажитесь от аренды](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость предлагаемого решения входит плата за аренду серверов {{ baremetal-name }} ([тарифы {{ baremetal-full-name }}](../../baremetal/pricing.md)).

## Создайте приватную подсеть {#create-subnet}

Создайте приватную подсеть в [пуле серверов](../../baremetal/concepts/servers.md#server-pools) `{{ region-id }}-m3`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы будете создавать инфраструктуру.
  1. [Перейдите]({{ link-console-main }}/link/baremetal) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. На панели слева выберите ![icon](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.baremetal.label_subnetworks_uU4LH }}** и нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.
  1. В поле **{{ ui-key.yacloud.baremetal.field_hardware-pool-id }}** выберите пул серверов `{{ region-id }}-m3`.
  1. В поле **{{ ui-key.yacloud.baremetal.field_name }}** задайте имя подсети: `subnet-m3`.
  1. Не включая опцию **{{ ui-key.yacloud.baremetal.title_routing-settings }}**, нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.

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
          1. В поле **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** выберите `{{ ui-key.yacloud.baremetal.label_public-ip-no }}`.

      1. В блоке **{{ ui-key.yacloud.baremetal.title_server-access }}**:

          {% include [server-lease-access](../../_includes/baremetal/server-lease-access.md) %}

      1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-info }}** в поле **{{ ui-key.yacloud.baremetal.field_name }}** задайте имя сервера: `server-m3-1`.
      1. {% include [server-lease-step13](../../_includes/baremetal/instruction-steps/server-lease-step13.md) %}
  1. Аналогичным способом арендуйте еще один сервер с именем `server-m3-2` в пуле серверов `{{ region-id }}-m3`.

{% endlist %}

{% note info %}

Подготовка серверов и установка на них операционных систем может занять до 45 минут — в это время серверы будут находиться в статусе `Provisioning`. После завершения установки ОС серверы перейдут в статус `Ready`.

{% endnote %}

## Вручную настройте сетевые интерфейсы {#setup-interfaces}

Поскольку DHCP-сервер в приватной подсети `subnet-m3` выключен, созданным серверам {{ baremetal-name }} не назначены внутренние IP-адреса и сетевая связность между этими серверами отсутствует.

На этом этапе вы подключитесь к созданным серверам и настроите интерфейсы приватной подсети на статическую адресацию, назначив каждому уникальный IP-адрес.

Серверам не назначены публичные IP-адреса, поэтому подключиться к ним по SSH нельзя. Для настройки используйте [KVM-консоль](../../baremetal/operations/servers/server-kvm.md).

### Настройте сетевые интерфейсы на использование статических IP-адресов {#enable-static}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. [Перейдите]({{ link-console-main }}/link/baremetal) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с сервером `server-m3-1` нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.baremetal.label_kvm-console_37Kma }}**.
  
      Откроется окно с терминалом KVM-консоли, в котором вы увидите строку аутентификации:
      
      ```text
      server-m3-1 login:
      ```

      Если вы не видите этой строки, попробуйте [перезапустить](../../baremetal/operations/servers/server-stop-and-start.md#restart) сервер.

      Все дальнейшие действия, описанные на этом шаге руководства, выполняйте в терминале KVM-консоли:

      1. Введите имя пользователя `root` и нажмите **ENTER**.
      1. В строке для ввода пароля вставьте полученный при аренде сервера пароль и нажмите **ENTER**. Обратите внимание, что при наборе или вставке пароля в ОС Linux введенные символы не отображаются на экране.

          {% include [kvm-paste-tip](../../_includes/baremetal/kvm-paste-tip.md) %}

          Результат:

          ```text
          Welcome to Ubuntu 24.04.2 LTS (GNU/Linux 6.8.0-53-generic x86_64)
          ...
          root@server-m3-1:~# _
          ```

          Если вы не сохранили пароль администратора к серверу, вы можете создать новый пароль по [инструкции](../../baremetal/operations/servers/reset-password.md) или [переустановить](../../baremetal/operations/servers/reinstall-os-from-marketplace.md) на сервере операционную систему.
      1. Посмотрите список сетевых интерфейсов сервера и определите интерфейс, подключенный к приватной подсети:

          ```bash
          ip a
          ```

          Результат:

          ```text
          ...
          5: etx2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
              link/ether 00:02:09:35:fd:31 brd ff:ff:ff:ff:ff:ff
              altname enp6s0d1
              inet6 fe80::202:c9ff:fe35:fd31/64 scope link
                  valid_lft forever preferred_lft forever
          ...
          ```

          Сопоставьте MAC-адреса интерфейсов с данными в консоли управления и найдите интерфейс, подключенный к приватной подсети. В примере это интерфейс `etx2`. На следующем шаге назначьте ему статический IP-адрес.

          {% note tip %}

          Убедиться в том, что выбран верный сетевой интерфейс, можно с помощью MAC-адреса. MAC-адрес нужного сетевого интерфейса сервера {{ baremetal-name }} вы можете [посмотреть](../../baremetal/operations/servers/get-info.md) на странице с информацией о сервере в блоке **{{ ui-key.yacloud.baremetal.title_section-network-interfaces }}**.

          {% endnote %}

      1. Откройте файл конфигурации сетевых интерфейсов сервера:

          ```bash
          nano /etc/netplan/50-cloud-init.yaml
          ```
      1. В открывшемся файле измените настройки интерфейса `etx2`. Не удаляйте конфигурацию остальных сетевых интерфейсов:

          ```yaml
          network:
            version: 2
            ethernets:
              ... # В этом примере приведена только конфигурация интерфейса, который необходимо настроить
              etx2:
                match:
                  macaddress: "00:02:09:35:fd:31"
                dhcp4: false # Здесь необходимо отказаться от использования DHCP
                addresses: # В этой секции задается статический IP-адрес интерфейса
                  - 192.168.1.101/24
                set-name: "etx2"
          ```

          Для интерфейса `etx2` выполните следующие настройки:

          * Значение поля `dhcp4` измените на `false`, чтобы отказаться от использования DHCP и задавать IP-адрес интерфейса статически.
          * Добавьте секцию `addresses`, содержащую присвоенный серверу внутренний статический IP-адрес. Адрес каждого сервера должен быть уникальным в данной подсети.

              {% note info %}

              {% include [internal-addressing-rules](../../_includes/baremetal/internal-addressing-rules.md) %}

              {% endnote %}

          Чтобы сохранить изменения и выйти из текстового редактора, на клавиатуре нажмите сочетание клавиш **Ctrl + X** и подтвердите сохранение изменений в файл `50-cloud-init.yaml`.          
      1. Примените внесенные изменения:

          ```bash
          netplan apply
          ```
      1. Убедитесь, что нужному сетевому интерфейсу был присвоен IP-адрес. Для этого выполните команду, отфильтровав вывод по идентификатору нужного интерфейса:

          ```bash
          ip a | grep etx2
          ```

          Результат:

          ```text
          5: etx2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
              inet 192.168.1.101/24 brd 192.168.1.255 scope global etx2
          ```

          Сетевой интерфейс настроен на использование статического IP-адреса `192.168.1.101` в приватной подсети `subnet-m3`.
  1. Аналогичным способом настройте сетевой интерфейс на сервере `server-m3-2`, в настройках netplan присвоив ему статический IP-адрес `192.168.1.102/24`.

{% endlist %}

### Проверьте сетевую связность между серверами {#validate-connectivity}

Перенастроив сетевые интерфейсы серверов в приватной подсети, вы установили между ними сетевую связность. Убедитесь в этом:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. [Перейдите]({{ link-console-main }}/link/baremetal) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с сервером `server-m3-1` нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.baremetal.label_kvm-console_37Kma }}**.
  1. Через KVM-консоль аутентифицируйтесь на сервере от имени пользователя `root` с помощью сохраненного при аренде сервера пароля.
  1. В терминале KVM-консоли выполните команду `ping`, чтобы убедиться в доступности сервера `server-m3-2` по его IP-адресу `192.168.1.102`:

      ```bash
      ping 192.168.1.102 -c 5
      ```

      Результат:

      ```text
      PING 192.168.1.102 (192.168.1.102) 56(84) bytes of data.
      64 bytes from 192.168.1.102: icmp_seq=1 ttl=64 time=3.90 ms
      64 bytes from 192.168.1.102: icmp_seq=2 ttl=64 time=0.235 ms
      64 bytes from 192.168.1.102: icmp_seq=3 ttl=64 time=0.222 ms
      64 bytes from 192.168.1.102: icmp_seq=4 ttl=64 time=0.231 ms
      64 bytes from 192.168.1.102: icmp_seq=5 ttl=64 time=0.235 ms

      --- 192.168.1.102 ping statistics ---
      5 packets transmitted, 5 received, 0% packet loss, time 4086ms
      rtt min/avg/max/mdev = 0.222/0.964/3.899/1.467 ms
      ```

      Сетевая связность между серверами установлена, пакеты проходят без потерь.

{% endlist %}

## Создайте VRF и включите маршрутизацию в приватной подсети {#setup-vrf}

Чтобы перейти от статической адресации к DHCP, создайте виртуальный сетевой сегмент (VRF), подключите к нему подсеть и включите в ее настройках маршрутизацию и DHCP-сервис.


### Создайте виртуальный сетевой сегмент (VRF) {#create-vrf}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. [Перейдите]({{ link-console-main }}/link/baremetal) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. На панели слева выберите ![icon](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud.baremetal.label_networks_kHgng }}** и нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-network }}**.
  1. В поле **{{ ui-key.yacloud.baremetal.field_name }}** задайте имя VRF: `my-vrf`.
  1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-network }}**.

{% endlist %}

### Подключите приватную подсеть к VRF {#connect-subnet-to-vrf} 

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. [Перейдите]({{ link-console-main }}/link/baremetal) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. На панели слева выберите ![icon](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.baremetal.label_subnetworks_uU4LH }}**.
  1. В строке с приватной подсетью `subnet-m3` нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**. В открывшемся окне:
  
      1. Включите опцию **{{ ui-key.yacloud.baremetal.title_routing-settings }}**.
      1. В поле **{{ ui-key.yacloud.baremetal.field_network-id }}** выберите созданный ранее сегмент `my-vrf`.
      1. В поле **{{ ui-key.yacloud.baremetal.field_CIDR_rwYMi }}** укажите `192.168.1.0/24`.
      1. В поле **{{ ui-key.yacloud.baremetal.field_gateway_t7LLk }}** оставьте значение по умолчанию `192.168.1.1`.
      1. Включите опцию **{{ ui-key.yacloud.baremetal.field_dhcp-settings }}** и в появившемся поле **{{ ui-key.yacloud.baremetal.field_dhcp-ip-range }}** оставьте значения по умолчанию: `192.168.1.1` — `192.168.1.254`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save-changes }}**.

{% endlist %}

## Включите DHCP на сетевых интерфейсах {#re-enable-dhcp}

После того как вы подключили подсеть к VRF, включили маршрутизацию и DHCP-сервис в ее настройках, серверы могут получать IP-адреса по DHCP. Для этого включите DHCP на сетевых интерфейсах серверов.

{% note info %}

DHCP-сервер, который обслуживает маршрутизируемые приватные подсети с VRF, может выдавать IP-адреса только физическим интерфейсам известных (доверенных) по отношению к нему серверов {{ baremetal-name }}. Поэтому выдавать в приватной подсети IP-адреса контейнерам или виртуальным машинам, запущенным на сервере, нельзя.

{% endnote %}

### Включите DHCP {#enable-dhcp}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. [Перейдите]({{ link-console-main }}/link/baremetal) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с сервером `server-m3-1` нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.baremetal.label_kvm-console_37Kma }}**.
  1. Через KVM-консоль аутентифицируйтесь на сервере от имени пользователя `root` с помощью сохраненного при аренде сервера пароля. Все дальнейшие действия, описанные на этом шаге руководства, выполняйте в терминале KVM-консоли:
  
      1. Откройте файл конфигурации сетевых интерфейсов сервера:

          ```bash
          nano /etc/netplan/50-cloud-init.yaml
          ```
      1. В открывшемся файле измените настройки интерфейса `etx2`, подключенного к приватной подсети. Не удаляйте конфигурацию остальных сетевых интерфейсов:

          ```yaml
          network:
            version: 2
            ethernets:
              ... # В этом примере приведена только конфигурация интерфейса, который подключен к приватной подсети
              etx2:
                match:
                  macaddress: "00:02:09:**:**:**"
                dhcp4: true # Здесь необходимо включить DHCP
                # Закомментируйте или удалите секцию addresses
                # addresses:
                #   - 192.168.1.101/24
                set-name: "etx2"
          ```

          Для нужного интерфейса выполните следующие настройки:

          * Значение поля `dhcp4` измените на `true`, чтобы включить на этом интерфейсе получение IP-адресов по DHCP.
          * Закомментируйте или удалите секцию `addresses`, содержащую присвоенный серверу внутренний статический IP-адрес.

          Чтобы сохранить изменения и выйти из текстового редактора, на клавиатуре нажмите сочетание клавиш **Ctrl + X** и подтвердите сохранение изменений в файл `50-cloud-init.yaml`.          
      1. Примените внесенные изменения:

          ```bash
          netplan apply
          ```
      1. Убедитесь, что нужному сетевому интерфейсу был присвоен IP-адрес. Для этого выполните команду, отфильтровав вывод по идентификатору нужного интерфейса:

          ```bash
          ip a | grep etx2
          ```

          Результат:

          ```text
          5: etx2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
              inet 192.168.1.2/24 metric 100 brd 192.168.1.255 scope global dynamic etx2
          ```

          Сетевому интерфейсу сервера `server-m3-1` присвоен IP-адрес `192.168.1.2` в приватной подсети `subnet-m3`.
  1. Аналогичным способом настройте сетевой интерфейс на сервере `server-m3-2` и сохраните присвоенный ему IP-адрес в приватной подсети. В примере это `192.168.1.3`.

{% endlist %}

### Проверьте сетевую связность между серверами {#revalidate-connectivity}

Убедитесь, что между серверами сохранилась сетевая связность после получения ими в приватной подсети IP-адресов по DHCP:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. [Перейдите]({{ link-console-main }}/link/baremetal) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с сервером `server-m3-1` нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.baremetal.label_kvm-console_37Kma }}**.
  1. Через KVM-консоль аутентифицируйтесь на сервере от имени пользователя `root` с помощью сохраненного при аренде сервера пароля.
  1. В терминале KVM-консоли выполните команду `ping`, чтобы убедиться в доступности сервера `server-m3-2` по IP-адресу, сохраненному на предыдущем шаге, например, `192.168.1.3`:

      ```bash
      ping 192.168.1.3 -c 5
      ```

      Результат:

      ```text
      PING 192.168.1.3 (192.168.1.3) 56(84) bytes of data.
      64 bytes from 192.168.1.3: icmp_seq=1 ttl=64 time=0.271 ms
      64 bytes from 192.168.1.3: icmp_seq=2 ttl=64 time=0.215 ms
      64 bytes from 192.168.1.3: icmp_seq=3 ttl=64 time=0.262 ms
      64 bytes from 192.168.1.3: icmp_seq=4 ttl=64 time=0.223 ms
      64 bytes from 192.168.1.3: icmp_seq=5 ttl=64 time=0.208 ms

      --- 192.168.1.3 ping statistics ---
      5 packets transmitted, 5 received, 0% packet loss, time 4106ms
      rtt min/avg/max/mdev = 0.208/0.235/0.271/0.025 ms
      ```

      Сетевая связность между серверами установлена, пакеты проходят без потерь.

{% endlist %}

## Как отказаться от аренды серверов {#clear-out}

Удалить серверы {{ baremetal-name }} нельзя. Вместо этого можно отказаться от продления их аренды.

Чтобы перестать платить за созданные ресурсы, [откажитесь](../../baremetal/operations/servers/server-lease-cancel.md) от продления аренды созданных ранее серверов {{ baremetal-name }}.
