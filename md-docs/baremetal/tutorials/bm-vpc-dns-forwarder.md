[Документация Yandex Cloud](../../index.md) > [Yandex BareMetal](../index.md) > [Практические руководства](index.md) > Настройка разрешения DNS-имен из приватной сети Yandex BareMetal

# Настройка разрешения DNS-имен из приватной сети Yandex BareMetal

Сервер BareMetal, подключенный к облачной сети Virtual Private Cloud с помощью Yandex Cloud Interconnect, находится за пределами Virtual Private Cloud и не может обращаться к [DNS-резолверу](../../dns/concepts/dns-resolver.md) облачной сети напрямую.

Чтобы разрешать на сервере BareMetal доменные имена из [внутренних DNS-зон](../../dns/concepts/dns-zone.md#private-zones) Yandex Cloud, создайте в облачной сети [входящее DNS-подключение](../../dns/concepts/dns-connection.md#dns-inbound) и укажите его IP-адрес в качестве DNS-сервера на сервере BareMetal. Разворачивать для этого отдельную виртуальную машину с DNS-форвардером не требуется.

В качестве примера вы настроите разрешение [FQDN](../../glossary/fqdn.md) хоста кластера Yandex Managed Service for PostgreSQL из приватной сети BareMetal.

Чтобы настроить разрешение DNS-имен:

1. [Подготовьте инфраструктуру](#prepare-infrastructure).
1. [Создайте входящее DNS-подключение](#create-inbound-endpoint).
1. [Настройте DNS на сервере BareMetal](#configure-baremetal).
1. [Проверьте разрешение DNS-имен](#check-dns).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте инфраструктуру {#prepare-infrastructure}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за аренду сервера BareMetal ([тарифы Yandex BareMetal](../pricing.md));
* плата за ресурсы кластера Managed Service for PostgreSQL ([тарифы Yandex Managed Service for PostgreSQL](../../managed-postgresql/pricing.md)), если вы используете кластер для проверки разрешения DNS-имен.

### Настройте сетевую связность {#configure-connectivity}

Если между приватной подсетью BareMetal и облачной сетью Virtual Private Cloud еще нет сетевой связности, [настройте ее](bm-vrf-and-vpc-interconnect.md) с помощью Cloud Interconnect.

Убедитесь, что в виртуальном маршрутизаторе анонсирован префикс подсети Virtual Private Cloud, в которой будет находиться IP-адрес входящего DNS-подключения. Сервер BareMetal должен иметь маршрут до этого префикса.

В примерах ниже используются:

* CIDR приватной подсети BareMetal — `172.16.2.0/24`;
* IP-адрес сервера BareMetal — `172.16.2.2`;
* CIDR подсети Virtual Private Cloud — `192.168.1.0/24`;
* IP-адрес входящего DNS-подключения — `192.168.1.200`.

### Создайте кластер Managed Service for PostgreSQL {#create-postgresql-cluster}

Если у вас еще нет облачного ресурса с FQDN во внутренней DNS-зоне, для проверки создайте [кластер Managed Service for PostgreSQL](../../managed-postgresql/operations/cluster-create.md) в облачной сети, связанной с приватной подсетью BareMetal.

Сохраните FQDN одного из хостов кластера. Он понадобится для проверки разрешения DNS-имен.

## Создайте входящее DNS-подключение {#create-inbound-endpoint}

[Создайте входящее DNS-подключение](../../dns/operations/connection-inbound-create.md) в облачной сети, связанной с приватной подсетью BareMetal.

При создании подключения:

1. Выберите облачную сеть, подключенную к виртуальному маршрутизатору.
1. Зарезервируйте для подключения внутренний IP-адрес в подсети, префикс которой анонсирован виртуальным маршрутизатором. Например, `192.168.1.200`.
1. Дождитесь, когда входящее DNS-подключение перейдет в статус `AVAILABLE`.
1. Сохраните IP-адрес подключения. Он понадобится для настройки сервера BareMetal.

{% note info %}

В одной облачной сети можно создать только одно входящее DNS-подключение. Если в выбранной сети уже есть такое подключение, используйте его IP-адрес.

{% endnote %}

## Настройте DNS на сервере BareMetal {#configure-baremetal}

В примере используется сервер с Ubuntu 24.04 и конфигурацией сети через [Netplan](https://netplan.io/).

1. [Подключитесь](../operations/servers/server-kvm.md) к KVM-консоли сервера BareMetal или подключитесь к серверу по SSH.
1. Узнайте имя файла с конфигурацией Netplan:

    ```bash
    ls /etc/netplan/
    ```

    Результат:

    ```text
    50-cloud-init.yaml
    ```

1. Откройте файл конфигурации:

    ```bash
    sudo nano /etc/netplan/50-cloud-init.yaml
    ```

1. В настройках приватного сетевого интерфейса отключите использование DNS-серверов, получаемых по DHCP, и добавьте IP-адрес входящего DNS-подключения:

    ```yaml
    network:
      version: 2
      ethernets:
        etx1:
          match:
            macaddress: "90:e2:ba:a2:30:de"
          dhcp4: true
          dhcp4-overrides:
            use-dns: false
          set-name: "etx1"
          nameservers:
            addresses:
              - 192.168.1.200
            search:
              - "~."
    ```

    Сохраните остальные настройки сетевых интерфейсов без изменений. В конфигурации укажите:

    * вместо `etx1` — имя приватного сетевого интерфейса сервера;
    * вместо `90:e2:ba:a2:30:de` — MAC-адрес приватного сетевого интерфейса;
    * вместо `192.168.1.200` — IP-адрес входящего DNS-подключения.

    Значение `~.` в параметре `nameservers.search` направляет все DNS-запросы через входящее DNS-подключение.

1. Проверьте корректность конфигурации:

    ```bash
    sudo netplan try
    ```

    Если в конфигурации нет ошибок, подтвердите изменения.

1. Примените конфигурацию:

    ```bash
    sudo netplan apply
    ```

1. Убедитесь, что для приватного интерфейса используется IP-адрес входящего DNS-подключения:

    ```bash
    resolvectl status etx1
    ```

    Результат должен содержать IP-адрес подключения:

    ```text
    Link 2 (etx1)
        Current DNS Server: 192.168.1.200
               DNS Servers: 192.168.1.200
                DNS Domain: ~.
    ```

{% note warning %}

Не изменяйте файл `/etc/resolv.conf` вручную: сервис `systemd-resolved` может перезаписать внесенные изменения.

{% endnote %}

## Проверьте разрешение DNS-имен {#check-dns}

1. Проверьте доступность входящего DNS-подключения, отправив на его IP-адрес запрос к FQDN облачного ресурса:

    ```bash
    dig @192.168.1.200 <FQDN_облачного_ресурса>
    ```

    В секции `ANSWER` должен появиться внутренний IP-адрес облачного ресурса.

1. Проверьте разрешение того же FQDN с помощью системных настроек DNS:

    ```bash
    resolvectl query <FQDN_облачного_ресурса>
    ```

1. Если для проверки вы создали кластер Managed Service for PostgreSQL, [подключитесь к нему](../../managed-postgresql/operations/connect/clients.md) по FQDN с сервера BareMetal.

## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить использование ресурсов:

1. Удалите IP-адрес входящего DNS-подключения из конфигурации Netplan на сервере BareMetal и примените изменения.
1. [Удалите входящее DNS-подключение](../../dns/operations/connection-inbound-delete.md).
1. [Удалите зарезервированный внутренний IP-адрес](../../vpc/operations/private-ip-delete.md).
1. Если для проверки вы создали кластер Managed Service for PostgreSQL, [удалите его](../../managed-postgresql/operations/cluster-delete.md).