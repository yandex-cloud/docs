[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Сборник рецептов администратора Stackland](../index.md) > Проектирование и развертывание инсталляции Stackland > Подготовка к инсталляции

# Подготовка к инсталляции

С помощью этого рецепта вы сможете подготовить инфраструктурные компоненты и конфигурационные файлы для развертывания кластера Stackland из трех combined-узлов.

{% note info %}

Рецепт основан на версии 26.2.1, требования к ресурсам приведены для нее. В других релизах требования могут отличаться.

{% endnote %}

## Подготовка к работе {#before-you-begin}

Для развертывания Stackland вам понадобятся:

* **Среда виртуализации**

    Подойдет любая среда, в которой вы можете самостоятельно управлять виртуальными машинами и загружать их с ISO-образа: VMware vSphere, KVM/QEMU, Proxmox, Hyper-V и другие.

* **Узлы Stackland**

    Требования к ресурсам:

    * **Три виртуальные машины** с 32 vCPU, 64 ГБ RAM, связанные L2-сетью.

    * Минимум два диска на каждом узле:

        * **Системный диск** — для установки ОС, его объем — минимум 150 ГБ.

        * **Диск для данных** — для приложений, томов и объектного хранилища, его объем — минимум 400 ГБ.

    {% note tip %}

    Мы рекомендуем выделять не менее 400 ГБ для данных потому, что в релизе 26.2.1 по умолчанию включен компонент Object Storage. Он требует 154 ГБ свободного места на каждом узле. Компонент Object Storage потребуется в других рецептах.

    {% endnote %}

* **Джамп-хост**

    Компьютер или виртуальная машина с Ubuntu версии не ниже 22.04. С него производится установка и дальнейший доступ к кластеру. Джамп-хост должен иметь сетевой доступ ко всем ВМ кластера и доступ в интернет для скачивания `sladm` и установочного образа. Также джамп-хост будет служить местом для размещения необходимых инфраструктурных компонентов, таких как DHCP, DNS и NTP.

    Требования к ресурсам:

    * Одна виртуальная машина с 2 vCPU и 4 ГБ RAM.

    * Один диск для ОС и данных, объем — не менее 50 ГБ.

* **Сеть**

    Все три ВМ должны находиться в одной виртуальной сети (L2-домене). IP-адреса могут назначаться статически или по DHCP, но должны быть стабильными — не меняться в ходе установки и эксплуатации.

    Подробные требования к сетевой конфигурации — в [Руководстве по установке](../../quickstart.md#underlay).

* **NTP-сервер**

    Необязателен. Необходим, только если кластер Stackland не имеет доступа в интернет.

* **DNS**

    При развертывании Stackland в периметре компании можно использовать существующую инфраструктуру DNS. Если такой возможности нет, то можно развернуть свою.

    Подробнее о настройке DNS — в [Руководстве по установке](../../quickstart.md#dns).

{% note info %}

Почему выбраны combined-узлы? Потому что роль `combined` совмещает функции `control-plane` (управление кластером, etcd) и `worker` (пользовательская нагрузка). Для кластера из трех узлов это оптимальный выбор: вы получаете отказоустойчивый `control-plane` и можете запускать приложения на тех же серверах без дополнительных `worker`-узлов.

{% endnote %}

## Шаг 1. Установка и настройка DHCP {#configure-dhcp}

### Запуск виртуальной машины джамп-хоста {#create-jump-host}

1. Скачайте [ISO-образ Ubuntu Server 22.04](https://releases.ubuntu.com/jammy/ubuntu-22.04.5-live-server-amd64.iso) и загрузите его в хранилище образов вашей системы виртуализации.

1. Создайте виртуальную машину с необходимыми ресурсами. Выберите сетевой интерфейс, подключенный к той же сети, где будут располагаться будущие узлы кластера, и выберите загрузку из ISO-образа.

1. Инсталлируйте систему, руководствуясь официальной документацией.

{% note tip %}

Устанавливайте **DHCP-сервер**, только если в сети нет альтернативных DHCP.

{% endnote %}

### Назначение серверу статического IP-адреса {#configure-static-ip}

Прежде чем устанавливать DHCP-сервер, убедитесь, что **сам сервер имеет статический IP-адрес** на сетевом интерфейсе, подключенном к вашей сети, то есть там, где будут располагаться узлы будущего кластера. Если он будет получать адрес автоматически, это может вызвать конфликты.

Чтобы назначить серверу статический IP-адрес:

1. Найдите конфигурационный файл Netplan:

    ```bash
    sudo vim /etc/netplan/00-installer-config.yaml
    ```

1. Отредактируйте его в соответствии с примером ниже. Замените `ens18`, `172.19.11.151/24` и `172.19.11.254` на ваши данные:

    ```yaml
    network:
      version: 2
      renderer: networkd
      ethernets:
        ens18:                                # Имя вашего сетевого интерфейса
          dhcp4: no                           # Отключить DHCP для сервера
          addresses:
            - 172.19.11.151/24                # Статический IP сервера
          routes:
            - to: default
              via: 172.19.11.254              # Адрес вашего основного шлюза (роутера)
          nameservers:
            addresses: [77.88.8.8, 77.88.8.1] # DNS-серверы
    ```

1. Примените новую конфигурацию:

    ```bash
    sudo netplan apply
    ```

### Установка ISC DHCP Server и его настройка {#install-dhcp}

Теперь можно установить сам сервер.

1. Обновите список пакетов и установите сервер:

    ```bash
    sudo apt update
    sudo apt install isc-dhcp-server -y
    ```

    Конфигурация состоит из двух основных файлов: `/etc/default/isc-dhcp-server` и `/etc/dhcp/dhcpd.conf`.

1. Дальше нужно сообщить серверу, на каком сетевом интерфейсе «слушать» запросы клиентов. Откройте файл конфигурации, найдите переменную `INTERFACESv4` и укажите в ней имя вашего сетевого интерфейса — то же самое, что вы использовали в файле Netplan.

    ```bash
    sudo vim /etc/default/isc-dhcp-server
    ```

    ```bash
    INTERFACESv4="ens18"
    ```

1. Отредактируйте основной файл настроек `/etc/dhcp/dhcpd.conf`, чтобы определить, какие параметры будет получать клиент. Пример настроек — ниже, не забудьте заменить параметры под вашу сеть:

    ```plaintext
    # Общие настройки, действующие для всех подсетей
    default-lease-time 600;
    max-lease-time 7200;

    ddns-update-style none;

    # Настройка подсети
    subnet 172.19.11.0 netmask 255.255.255.0 {
        range 172.19.11.129 172.19.11.135;           # Пул адресов для выдачи клиентам
        option routers 172.19.11.254;                # Шлюз по умолчанию (ваш роутер)
        option domain-name-servers 172.19.11.151;    # DNS-серверы (можно указать свои)
        option broadcast-address 172.19.11.255;      # Широковещательный адрес
        option ntp-servers 172.19.11.151;            # NTP-сервер
    }
    ```

1. Запустите службу и настройте автозапуск:

    ```bash
    sudo systemctl restart isc-dhcp-server
    sudo systemctl enable isc-dhcp-server
    ```

1. Проверьте статус работы:

    ```bash
    sudo systemctl status isc-dhcp-server
    ```

    Если ошибок нет, вы увидите статус `active (running)`.

## Шаг 2. Подготовка узлов кластера {#prepare-nodes}

В примерах ниже используется система виртуализации Proxmox.

1. Скачайте [ISO-образ Stackland](https://storage.yandexcloud.net/stackland-public/stackland/26.2.1/images/stackland-amd64-26.2.1.iso) и загрузите его в хранилище образов вашей системы виртуализации.

1. Создайте три виртуальные машины с необходимыми ресурсами.

    ![Созданные ВМ в интерфейсе Proxmox](../../_assets/cookbooks/installation/02-01-proxmox-created-vms.png)

1. Выберите загрузку из ISO-образа Stackland для каждой созданной ВМ.

    ![Меню порядка загрузки устройств в интерфейсе Proxmox](../../_assets/cookbooks/installation/02-02-proxmox-boot-order-menu.png)

1. Теперь вы можете получить MAC-адреса интерфейсов узлов кластера и прописать статические IP-адреса в параметрах DHCP-сервера.

    {% note warning %}

    IP-адреса узлов кластера должны быть статическими и не меняться после первоначальной конфигурации.

    {% endnote %}

    Внесите изменения в конфигурационный файл `/etc/dhcp/dhcpd.conf`: добавьте блоки `host` с информацией об узлах кластера.

    {% note info %}

    Статические IP-адреса необходимо указывать вне диапазона для динамического распределения. В примере ниже они не пересекаются с диапазоном `172.19.11.129 — 172.19.11.135`.

    {% endnote %}

    Пример настроек:

    ```plaintext
    # Общие настройки, действующие для всех подсетей
    default-lease-time 600;
    max-lease-time 7200;

    ddns-update-style none;

    # Настройка подсети
    subnet 172.19.11.0 netmask 255.255.255.0 {
        range 172.19.11.129 172.19.11.135;           # Пул адресов для выдачи клиентам
        option routers 172.19.11.254;                # Шлюз по умолчанию (ваш роутер)
        option domain-name-servers 172.19.11.151;    # DNS-серверы (можно указать свои)
        option broadcast-address 172.19.11.255;      # Широковещательный адрес

      # Резервирование статического IP-адреса для конкретного устройства
      host node1 {
          hardware ethernet bc:24:11:6f:e0:08;
          fixed-address 172.19.11.136;                 # Выдаваемый статический IP-адрес
          option host-name "node1.proxmox.internal";
      }

      host node2 {
          hardware ethernet bc:24:11:16:fb:ce;
          fixed-address 172.19.11.137;
          option host-name "node2.proxmox.internal";
      }

      host node3 {
          hardware ethernet bc:24:11:2f:0b:d7;
          fixed-address 172.19.11.138;
          option host-name "node3.proxmox.internal";
      }
    }
    ```

1. Перезапустите службу:

    ```bash
    sudo systemctl restart isc-dhcp-server
    ```

1. Запустите все три виртуальные машины. Загрузка сервера занимает несколько минут. После загрузки в консоли появится интерфейс Talos и хосты получат IP-адреса, которые вы указали в настройках DHCP.

    ![Интерфейс Talos в консоли ВМ](../../_assets/cookbooks/installation/02-03-talos-vm-console.png)

    Если вы видите дашборд, на котором указан этап `Maintenance`, значит загрузка установочного образа прошла успешно.

## Шаг 3. Установка и настройка DNS- и NTP-серверов {#configure-dns-ntp}

При развертывании Stackland в периметре компании можно использовать существующую инфраструктуру DNS. Настройте свой DNS-сервер, если существующую инфраструктуру использовать невозможно или вы хотите лучше разобраться в работе DNS.

{% note warning %}

Для корректной работы кластера Stackland ему нужно делегировать управление собственной DNS-зоной.

{% endnote %}

В нашем примере имя зоны для развертывания — `stackland.internal`.

В качестве DNS-сервера рекомендуем [BIND](https://www.isc.org/bind/), а в качестве NTP-сервера предлагаем использовать [Chrony](https://chrony-project.org/).

1. Установите BIND и Chrony из репозиториев Ubuntu стандартным способом:

    ```bash
    sudo apt install bind9 bind9utils dnsutils unzip -y
    ```

1. Настройте Chrony так, чтобы он начал принимать NTP-запросы. Отредактируйте файл `/etc/chrony/chrony.conf` и добавьте следующую строку:

    ```plaintext
    allow 0.0.0.0/0      # разрешить подключение с любых адресов
    # allow 172.19.11.0/24 # разрешить подключения с конкретной сети
    ```

1. Перезапустите сервис Chrony:

    ```bash
    sudo systemctl restart chrony
    ```

1. Настройте BIND в качестве системного кеширующего DNS-резолвера. Для этого отредактируйте файл `/etc/bind/named.conf.options` и добавьте в секцию `forwarders {}` IP-адреса публичных DNS-серверов, которые будут выполнять фактическое разрешение. Рекомендуем использовать серверы Yandex DNS: `77.88.8.8` и `77.88.8.1`.

    ```plaintext
    options {
        ...
        forwarders {
            77.88.8.8;
            77.88.8.1;
        };
        ...
    };
    ```

1. Создайте файл родительской зоны `internal` (`/etc/bind/db.internal`). Вместо `172.19.11.151` подставьте IP-адрес вашего джамп-хоста:

    ```plaintext
    ; /etc/bind/db.internal

    $TTL 1H
    @       IN      SOA     ns1.internal. admin.internal. (
                            2026052808     ; Serial
                            3H             ; Refresh
                            30M            ; Retry
                            1W             ; Expire
                            5M)            ; Negative Cache TTL

    @       IN      NS      ns1.internal.
    ns1.internal.           IN      A       172.19.11.151

    ; Делегирование stackland.internal на три узла
    stackland.internal.     IN      NS      node1.proxmox.internal.
    stackland.internal.     IN      NS      node2.proxmox.internal.
    stackland.internal.     IN      NS      node3.proxmox.internal.

    ```

1. Также создайте файл зоны для узлов кластера. В нашем примере это зона `proxmox.internal` — она будет использоваться при определении IP-адресов узлов будущего кластера.

    Вместо `node1`, `node2` и `node3` укажите имена, которые вы планируете назначить узлам, и IP-адреса узлов, которые они получили от DHCP.

    ```plaintext
    ; /etc/bind/db.proxmox.internal

    $TTL 1H
    @       IN      SOA     node1.proxmox.internal. admin.proxmox.internal. (
                            2026052809     ; Serial
                            3H             ; Refresh
                            30M            ; Retry
                            1W             ; Expire
                            5M)            ; Negative Cache TTL

    @   IN  NS   ns1.internal.

    node1  IN  A  172.19.11.136
    node2  IN  A  172.19.11.137
    node3  IN  A  172.19.11.138
    ```

1. Отредактируйте `/etc/bind/named.conf.local` и добавьте только что созданные зоны:

    ```plaintext
    ; /etc/bind/named.conf.local

    zone "internal" {
        type master;
        file "/etc/bind/db.internal";
        forwarders {};
    };

    zone "proxmox.internal" {
        type master;
        file "/etc/bind/db.proxmox.internal";
    };
    ```

1. Перезагрузите сервис BIND командой:

    ```bash
    sudo systemctl restart named
    ```

1. Для корректного разрешения имен созданных зон укажите приватный IP-адрес джамп-хоста как вышестоящий DNS-резолвер (параметр `DNS=`) в конфигурационном файле `/etc/systemd/resolved.conf` и перезагрузите настройки сервисов.

    ```bash
    sudo rndc reconfig
    sudo systemctl restart systemd-resolved
    ```

1. Проверьте, что разрешение доменных имен работает ожидаемо:

    ```bash
    nslookup ns1.internal.
    Server:		127.0.0.1
    Address:	127.0.0.1#53

    Name:	ns1.internal
    Address: 172.19.11.151
    ```

    ```bash
    nslookup node1.proxmox.internal
    Server:		127.0.0.53
    Address:	127.0.0.53#53

    Non-authoritative answer:
    Name:	node1.proxmox.internal
    Address: 172.19.11.136
    ```

{% note tip %}

Подробную информацию по делегированию зоны можно найти в [Руководстве по установке](../../quickstart.md#dns).

{% endnote %}

## Шаг 4. Подготовка конфигурационного файла {#prepare-config}

Далее вы подготовите конфигурационные файлы для инсталляции кластера.

{% note tip %}

Для более подробной информации обратитесь к [Руководству по установке](../../quickstart.md#configuration).

{% endnote %}

Конфигурация состоит из трех частей:

1. **Конфигурация кластера** (`StacklandClusterConfig`) — общие настройки кластера, включая платформу, подсети и балансировщик нагрузки.

1. **Конфигурация хостов** (`StacklandHostsList`) — настройки отдельных серверов, включая роли и сетевые интерфейсы.

1. **Секреты** (`StacklandSecretsConfig`) — секреты, например лицензионный ключ или сертификат внутреннего удостоверяющего центра (CA).

Для инсталляции вы подготовите три отдельных файла с конфигурацией.

{% note alert %}

Параметры `hostsNetwork`, `clusterNetwork`, `servicesNetwork` в дальнейшем нельзя будет изменить без переустановки кластера.

{% endnote %}

{% note warning %}

`defaultStorageClass` — класс хранилища по умолчанию. Допустимые значения: `stackland-nvme`, `stackland-ssd`, `stackland-hdd`, `stackland-other`.

Значение выбирают в зависимости от типа использующихся дисков. В нашем примере, при использовании виртуализации, подходит класс `stackland-other`, так как используются диски VirtIO (`/dev/vdX`).

{% endnote %}

* Файл конфигурации кластера

    ```yaml
    apiVersion: stackland.yandex.cloud/v1alpha1
    kind: StacklandClusterConfig
    metadata:
      name: main
    spec:
      platform:
        type: "baremetal"                           # Платформа развертывания. В данный момент параметр не влияет ни на что
        loadBalancer:
          type: "cilium-l2"                         # Тип балансировщика нагрузки
          ipPools:
            - ranges:                               # Диапазон адресов для балансировщиков
              - start: 172.19.11.72
                end: 172.19.11.75
      cluster:
        baseDomain: "stackland.internal"            # Домен кластера. Эту зону делегировали на DNS
        networking:
          hostsNetwork:
            - cidr: 172.19.11.128/25                 # Подсеть, в которой находятся IP-адреса хостов кластера
          clusterNetwork:
            - cidr: 10.244.0.0/16                    # Подсеть, из которой выделяются IP-адреса подов кластера
          servicesNetwork:
            - cidr: 10.96.0.0/12                     # Подсеть, из которой выделяются IP-адреса сервисов кластера
        storage:
          defaultStorageClass: "stackland-other"     # Класс хранения по умолчанию

      genericHostConfig:                            # Общие настройки для всех хостов кластера
        disksConfig:
          - installDisk:
              name: "/dev/sda"                      # Диск для установки системы
        networkConfig:
          routes:                                   # Настройки статических маршрутов
            - to: 0.0.0.0/0
              via: "172.19.11.254"
              iface: "ens18"
          resolvers:
            - 172.19.11.151                         # IP-адрес DNS. В данном случае IP-адрес джамп-хоста
          timeservers:
            - 172.19.11.151                         # IP-адрес NTP. В данном случае IP-адрес джамп-хоста
          addresses:
            - interface: "ens18"
              dhcp: true                            # Использовать DHCP для получения IP-адреса
    ```

* Файл конфигурации хостов кластера

    ```yaml
    apiVersion: stackland.yandex.cloud/v1alpha1
    kind: StacklandHostsList
    metadata:
      name: main
    spec:
      hosts:
        - hostname: "node1.proxmox.internal"        # FQDN хоста
          role: "combined"                          # Роль хоста
          networkConfig:
            interfaces:
              - macaddress: "bc:24:11:6f:e0:08"     # MAC-адрес
                name: "ens18"                       # Имя интерфейса

        - hostname: "node2.proxmox.internal"
          role: "combined"
          networkConfig:
            interfaces:
              - macaddress: "bc:24:11:16:fb:ce"
                name: "ens18"

        - hostname: "node3.proxmox.internal"
          role: "combined"
          networkConfig:
            interfaces:
              - macaddress: "bc:24:11:2f:0b:d7"
                name: "ens18"
    ```

Конфигурационный файл с секретами генерируется с помощью утилиты `sladm`. Для этого **необходим лицензионный ключ**.

Команда создаст самоподписанный сертификат и ключ промежуточного CA, которым подписываются сертификаты сервисов Stackland. Если требуется аутентификация межсервисного взаимодействия удостоверяющим центром компании, обратитесь к [инструкции](../../quickstart.md#prepare-secrets) по добавлению и обновлению секретов.

{% note alert %}

После установки кластера изменить сертификат и ключ, загруженные на этом этапе, невозможно. Для этого потребуется полностью переустановить кластер Stackland.

{% endnote %}

1. Загрузите инструмент `sladm` и распакуйте его:

    ```bash
    wget https://storage.yandexcloud.net/stackland-public/stackland/26.2.1/sladm-26.2.1-linux-amd64.zip
    unzip sladm-26.2.1-linux-amd64.zip
    chmod +x sladm
    ```

1. Подготовьте лицензионный ключ (файл `key.json`) и запустите генерацию секретов:

    ```bash
    sladm secrets add --out config/secrets.yml --license-key key.json
    ```

Итоговая структура конфигурационных файлов:

```bash
tree
.
├── config
│   ├── secrets.yml
│   ├── StacklandClusterConfig.yml
│   └── StacklandHostsList.yml
├── key.json
└── sladm
```

## Итоги {#summary}

Вы подготовили инфраструктуру для развертывания Stackland:

* настроили джамп-хост с DHCP-сервером для автоматической выдачи IP-адресов узлам кластера, DNS-сервером BIND с делегированием зоны `stackland.internal` и NTP-сервером Chrony для синхронизации времени;

* настроили три виртуальные машины для узлов кластера Stackland из ISO-образа;

* подготовили конфигурационные файлы: `StacklandClusterConfig.yml` с общими настройками кластера и сети, `StacklandHostsList.yml` с описанием узлов кластера и `secrets.yml` с секретами — лицензионным ключом или сертификатом внутреннего CA, сгенерированными утилитой `sladm`.

Теперь все готово к инсталляции.