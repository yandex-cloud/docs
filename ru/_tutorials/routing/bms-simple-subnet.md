# Настройка сетевой связности в подсети {{ baremetal-full-name }}

Если для [приватной подсети](../../baremetal/concepts/network.md#private-subnet) настроена маршрутизация и назначен [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация), то сетевым интерфейсам [серверов {{ baremetal-name }}](../../baremetal/concepts/servers.md), подключенным к этой подсети, с помощью [DHCP](https://ru.wikipedia.org/wiki/DHCP) выдаются IP-адреса из заданного в настройках CIDR этой подсети диапазона.

При этом если маршрутизация для приватной подсети не настроена, то такая подсеть функционирует как сеть уровня L2 [сетевой модели OSI](https://ru.wikipedia.org/wiki/Сетевая_модель_OSI), DHCP в ней не работает, а для установления сетевой связности необходимо вручную назначать IP-адреса в настройках сетевых интерфейсов серверов. 

Это связано с тем, что DHCP-сервер появляется в составе приватной подсети только в тот момент, когда подсеть становится маршрутизируемой и подключается к [виртуальному сегменту сети](../../baremetal/concepts/network.md#vrf-segment) (VRF).

{% note info %}

Если на сервере установлена операционная система из образов [{{ marketplace-full-name }}]({{ link-cloud-marketplace }}), на всех физических интерфейсах сервера получение IP-адресов по DHCP включено по умолчанию.

{% endnote %}

Подробнее об устройстве сетей в сервисе {{ baremetal-full-name }} см. в разделе [{#T}](../../baremetal/concepts/network.md).

В данном руководстве вы научитесь вручную выключать DHCP на сетевом интерфейсе приватной подсети сервера {{ baremetal-name }} и назначать ему статический IP-адрес. Также вы научитесь повторно активировать DHCP на сетевом интерфейсе сервера, после того как в этой подсети будет включена маршрутизация.

В качестве примера вы будете использовать серверы {{ baremetal-name }} под управлением ОС Linux [Ubuntu 24.04](/marketplace/products/yc/ubuntu-2404-lts-oslogin). При использовании других операционных систем алгоритм действий будет аналогичным, но способ настройки сетевых интерфейсов может отличаться. Инструкции по настройке сетевых интерфейсов в других операционных системах смотрите в документации к этим ОС.

Чтобы настроить сетевую связность в подсети {{ baremetal-full-name }}:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте приватную подсеть](#create-subnet).
1. [Арендуйте серверы {{ baremetal-name }}](#rent-servers).
1. [Вручную настройте сетевые интерфейсы](#setup-interfaces).
1. [Создайте VRF и включите маршрутизацию в приватной подсети](#setup-vrf).
1. [Включите DHCP на сетевых интерфейсах](#re-enable-dhcp).

См. также [Как отказаться от аренды серверов](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость предлагаемого решения входит плата за аренду серверов {{ baremetal-name }} (см. [тарифы {{ baremetal-full-name }}](../../baremetal/pricing.md)).

## Создайте приватную подсеть {#create-subnet}

Создайте приватную подсеть в [пуле серверов](../../baremetal/concepts/servers.md#server-pools) `{{ region-id }}-m3`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы будете создавать инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. На панели слева выберите ![icon](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.baremetal.label_subnetworks }}** и нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.
  1. В поле **{{ ui-key.yacloud.baremetal.field_server-pool }}** выберите пул серверов `{{ region-id }}-m3`.
  1. В поле **{{ ui-key.yacloud.baremetal.field_name }}** задайте имя подсети: `subnet-m3`.
  1. Не включая опцию **{{ ui-key.yacloud.baremetal.title_routing-settings }}**, нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.

{% endlist %}


## Арендуйте серверы {{ baremetal-name }} {#rent-servers}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}** и нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-server }}**.
  1. В поле **{{ ui-key.yacloud.baremetal.field_server-pool }}** выберите выберите пул серверов `{{ region-id }}-m3`.
  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-config }}** выберите подходящую [конфигурацию сервера](../../baremetal/concepts/server-configurations.md).
  1. (Опционально) В блоке **{{ ui-key.yacloud.baremetal.title_section-disk }}** настройте разметку дисков:

        1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.action_disk-layout-settings }}**.
        1. Укажите параметры разделов. Чтобы создать новый раздел, нажмите кнопку ![icon](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.baremetal.actions_add-partition }}**.

           {% note info %}

           Чтобы самостоятельно собрать RAID-массивы и настроить разделы дисков, нажмите кнопку **{{ ui-key.yacloud.baremetal.action_destroy-raid }}**.

           {% endnote %}

        1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-product }}** выберите образ [Ubuntu 24.04](/marketplace/products/yc/ubuntu-2404-lts-oslogin).
  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-lease-conditions }}** выберите период, на который арендуете сервер. По окончании указанного периода аренда сервера будет автоматически продлена на такой же период.
  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-network-settings }}**:

     1. В поле **{{ ui-key.yacloud.baremetal.field_subnet-id }}** выберите созданную ранее подсеть `subnet-m3`.
     1. В поле **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** выберите `{{ ui-key.yacloud.baremetal.label_public-ip-no }}`.

  1. В блоке **{{ ui-key.yacloud.baremetal.title_server-access }}**:

      {% include [server-lease-access](../../_includes/baremetal/server-lease-access.md) %}

  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-info }}** в поле **{{ ui-key.yacloud.baremetal.field_name }}** задайте имя сервера: `server-m3-1`.
  1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-server }}**.
  1. Аналогичным способом арендуйте еще один сервер с именем `server-m3-2` в пуле серверов `{{ region-id }}-m3`.

{% endlist %}

{% note info %}

Подготовка серверов и установка на них операционных систем может занять до 45 минут — в это время серверы будут находиться в статусе `Provisioning`. После завершения установки ОС серверы перейдут в статус `Ready`.

{% endnote %}

## Вручную настройте сетевые интерфейсы {#setup-interfaces}

Поскольку DHCP-сервер в приватной подсети `subnet-m3` выключен, созданным серверам {{ baremetal-name }} не назначены внутренние IP-адреса и сетевая связность между этими серверами отсутствует.

На этом этапе вы подключитесь к созданным серверам и измените настройки их сетевых интерфейсов, привязанных к приватной подсети, отключив в них DHCP и назначив им статические IP-адреса.

Серверам не были назначены публичные IP-адреса, поэтому подключиться к ним [по SSH](../../compute/operations/vm-connect/ssh.md) не получится. Для подключения к серверам вы будете использовать KVM-консоль.

### Настройте сетевые интерфейсы на использование статических IP-адресов {#enable-static}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с сервером `server-m3-1` нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.baremetal.label_kvm-console }}**.
  
      Откроется окно с терминалом KVM-консоли, в котором вы увидите строку аутентификации:
      
      ```
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
          5: etx2: <BROADCAST, MULTICAST,UP,LOWER_UP> mtu 1500 qdisc ma state UP group default qlen 1000
              link/ether 00:02:09:35:fd:31 brd ff:ff:ff:ff:ff:ff
              altname enp6s0d1
              inet6 fe80::202:c9ff:fe35:fd31/64 scope link
                  valid_lft forever preferred_lft forever
          ...
          ```

          Поскольку публичный IP-адрес у сервера отсутствует, значит, единственный активный сетевой интерфейс (с состоянием `state UP`) сервера — это тот интерфейс, который подключен к приватной подсети. В примере выше — это интерфейс с идентификатором `etx2`. На следующем шаге вы назначите этому интерфейсу статический IP-адрес.
      1. Откройте файл конфигурации сетевых интерфейсов сервера:

          ```bash
          nano /etc/netplan/50-cloud-init.yaml
          ```
      1. В открывшемся файле внесите изменения в настройки сетевого интерфейса:

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
          5: etx2: <BROADCAST,MULTICAST, UP,LOWER_UP> mtu 1500 qdisc ma state UP group default qlen 1000
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
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с сервером `server-m3-1` нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.baremetal.label_kvm-console }}**.
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

Чтобы включить DHCP-сервер в приватной подсети, создайте виртуальный сетевой сегмент (VRF) и включите в подсети маршрутизацию, привязав подсеть к этому VRF.


### Создайте виртуальный сетевой сегмент (VRF) {#create-vrf}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. На панели слева выберите ![icon](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud.baremetal.label_networks }}** и нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-network }}**.
  1. В поле **{{ ui-key.yacloud.baremetal.field_name }}** задайте имя VRF: `my-vrf`.
  1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-network }}**.

{% endlist %}

### Подключите приватную подсеть к VRF {#connect-subnet-to-vrf} 

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. На панели слева выберите ![icon](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.baremetal.label_subnetworks }}**.
  1. В строке с приватной подсетью `subnet-m3` нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**. В открывшемся окне:
  
      1. Включите опцию **{{ ui-key.yacloud.baremetal.title_routing-settings }}**.
      1. В поле **{{ ui-key.yacloud.baremetal.field_network-id }}** выберите созданный ранее сегмент `my-vrf`.
      1. В поле **{{ ui-key.yacloud.baremetal.field_CIDR }}** укажите `192.168.1.0/24`.
      1. В поле **{{ ui-key.yacloud.baremetal.field_gateway }}** оставьте значение по умолчанию `192.168.1.1`.
      1. Включите опцию **{{ ui-key.yacloud.baremetal.field_dhcp-settings }}** и в появившемся поле **{{ ui-key.yacloud.baremetal.field_dhcp-ip-range }}** оставьте значения по умолчанию: `192.168.1.1` — `192.168.1.254`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save-changes }}**.

{% endlist %}

## Включите DHCP на сетевых интерфейсах {#re-enable-dhcp}

После того как вы включили маршрутизацию в приватной подсети и подключили подсеть к VRF, в этой подсети был запущен DHCP-сервер. Чтобы сетевые интерфейсы ваших серверов {{ baremetal-name }} могли автоматически получать IP-адреса по DHCP, необходимо включить DHCP в их настройках.

{% note info %}

DHCP-сервер, который обслуживает маршрутизируемые приватные подсети с VRF, может выдавать IP-адреса только физическим интерфейсам известных (доверенных) по отношению к нему серверов {{ baremetal-name }}. Поэтому выдавать в приватной подсети IP-адреса контейнерам или виртуальным машинам, запущенным на сервере, нельзя.

{% endnote %}

### Включите DHCP {#enable-dhcp}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с сервером `server-m3-1` нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.baremetal.label_kvm-console }}**.
  1. Через KVM-консоль аутентифицируйтесь на сервере от имени пользователя `root` с помощью сохраненного при аренде сервера пароля. Все дальнейшие действия, описанные на этом шаге руководства, выполняйте в терминале KVM-консоли:
  
      1. Откройте файл конфигурации сетевых интерфейсов сервера:

          ```bash
          nano /etc/netplan/50-cloud-init.yaml
          ```
      1. В открывшемся файле внесите изменения в настройки сетевого интерфейса, подключенного к приватной подсети:

          ```yaml
          network:
            version: 2
            ethernets:
              ... # В этом примере приведена только конфигурация интерфейса, который подключен к приватной подсети
              etx2:
                match:
                  macaddress: "00:02:09:35:fd:31"
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
          5: etx2: <BROADCAST,MULTICAST, UP,LOWER_UP> mtu 1500 qdisc ma state UP group default qlen 1000
              inet 192.168.1.2/24 metric 100 brd 192.168.1.255 scope global dynamic etx2
          ```

          Сетевому интерфейсу сервера `server-m3-1` присвоен IP-адрес `192.168.1.2` в приватной подсети `subnet-m3`.
  1. Аналогичным способом настройте сетевой интерфейс на сервере `server-m3-2` и сохраните присвоенный ему IP-адрес в приватной подсети. В примере это — `192.168.1.3`

{% endlist %}

### Проверьте сетевую связность между серверами {#revalidate-connectivity}

Убедитесь, что между серверами сохранилась сетевая связность после получения ими в приватной подсети IP-адресов по DHCP:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с сервером `server-m3-1` нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.baremetal.label_kvm-console }}**.
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