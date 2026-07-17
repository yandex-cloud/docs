[Документация Yandex Cloud](../../index.md) > [Yandex Cloud DNS](../index.md) > [Практические руководства](index.md) > Разрешение облачных DNS-имен в корпоративной сети

# Разрешение облачных DNS-имен в корпоративной сети

Если у вас есть собственные корпоративные сети, связанные с [облачными сетями](../../vpc/concepts/network.md#network) Yandex Cloud (например, с помощью сервиса [Yandex Cloud Interconnect](../../interconnect/index.md)), то вы можете интегрировать корпоративный DNS с внутренними DNS-зонами в Yandex Cloud и реализовать разрешение DNS-имен облачных ресурсов в ваших корпоративных сетях. Это позволит по имени обращаться к облачным ресурсам и сервисам Yandex Cloud из корпоративных сетей.

Чтобы настроить разрешение внутренних облачных DNS-имен клиентами в вашей корпоративной сети, вы создадите на стороне Yandex Cloud [входящее DNS-подключение](../concepts/dns-connection.md#dns-inbound), которое будет перенаправлять DNS-запросы из корпоративной сети на [DNS-резолверы](../concepts/dns-resolver.md) в подсетях Virtual Private Cloud. На стороне корпоративной сети вы настроите DNS-сервер так, чтобы все DNS-запросы к облачным ресурсам направлялись на IP-адрес созданного входящего DNS-подключения.

В данном сценарии пользователь, подключенный к корпоративной сети в `subnet1`, разрешает DNS-имя хоста в [кластере](../../managed-postgresql/concepts/index.md) Yandex Managed Service for PostgreSQL, отправляя DNS-запросы через локальный [DNS-форвардер](*dns_forwarder).

Схема решения:

![DNS integration example](../../_assets/dns/dns-integration-26.svg "DNS integration example")

1. Корпоративная сеть:

    * Состоит из подсети `subnet1` с диапазоном адресов `172.16.1.0/24`.
    * В подсети `subnet1` размещен DNS-сервер (DNS-форвардер) с IP-адресом `172.16.1.200`.

        Этот сервер обслуживает DNS-зону в подсети `subnet1` и перенаправляет DNS-запросы компьютера пользователя с IP-адресом `172.16.1.10` в облачную сеть на IP-адрес [входящего DNS-подключения](../concepts/dns-connection.md#dns-inbound), созданного на стороне Yandex Cloud.
1. Облачная сеть Yandex Cloud:

    * Состоит из [подсети](../../vpc/concepts/network.md#subnet) `subnet2` с диапазоном адресов `192.168.1.0/24`.
    * В подсети `subnet2` расположен кластер Yandex Managed Service for PostgreSQL.
    
        В этом руководстве вы настроите интеграцию таким образом, чтобы DNS-имя ([FQDN](../../glossary/fqdn.md)) хоста этого кластера успешно разрешалось изнутри корпоративной сети.
    * В облачной сети создано [входящее DNS-подключение](../concepts/dns-connection.md#dns-inbound), позволяющее клиентам из корпоративной сети разрешать DNS-имена во [внутренних DNS-зонах](../concepts/dns-zone.md#private-zones) Yandex Cloud.

        Входящему DNS-подключению присвоен IP-адрес `192.168.1.200`, относящийся к подсети `subnet2` и зарезервированный в сервисе Yandex Virtual Private Cloud.
1. С помощью сервиса Yandex Cloud Interconnect корпоративная и облачная сети связаны между собой так, что все IP-адреса подсети в одной сети доступны из подсети в другой сети и наоборот.

Чтобы настроить разрешение DNS-имен облачных ресурсов и сервисов Yandex Cloud в корпоративных сетях:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Настройте облачную инфраструктуру](#setup-cloud-dns).
1. [Настройте корпоративную сеть](#setup-on-prem-dns).
1. [Проверьте работу интеграции](#check-dns-service).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки создаваемой инфраструктуры входят:

* Плата за ресурсы кластера Managed Service for PostgreSQL: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы Managed Service for PostgreSQL](../../managed-postgresql/pricing.md)).
* Плата за использование сервиса Yandex Cloud Interconnect ([тарифы Cloud Interconnect](../../interconnect/pricing.md)).

## Настройте облачную инфраструктуру {#setup-cloud-dns}

На стороне Yandex Cloud вы создадите облачную сеть с одной подсетью, кластер Managed Service for PostgreSQL с одним хостом и входящее DNS-подключение.

### Создайте облачную сеть {#create-network}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете создавать облачную инфраструктуру.
  1. Перейдите в сервис **Virtual Private Cloud** и нажмите кнопку **Создать сеть**.
  1. В поле **Имя** задайте [имя](*name) облачной сети `my-vpc-network`.
  1. Отключите опцию **Создать подсети**.
  1. Нажмите **Создать сеть**.

{% endlist %}

### Создайте подсеть {#create-subnet}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **Virtual Private Cloud**.
  1. На панели слева выберите ![subnets](../../_assets/console-icons/nodes-right.svg) **Подсети** и нажмите кнопку **Создать подсеть**.
  1. В поле **Имя** задайте [имя](*name) подсети `subnet2`.
  1. В поле **Зона доступности** выберите [зону доступности](../../overview/concepts/geo-scope.md) `ru-central1-b`.
  1. В поле **Сеть** выберите облачную сеть `my-vpc-network`, созданную ранее.
  1. В поле **CIDR** задайте CIDR подсети `192.168.1.0/24`.
  1. Нажмите **Создать подсеть**.

{% endlist %}

### Создайте кластер Yandex Managed Service for PostgreSQL {#create-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL** и нажмите кнопку **Создать кластер**.
  1. В поле **Имя кластера** задайте [имя](*name) кластера `my-postgresql-cluster`.
  1. В блоке **База данных** в поле **Пароль** выберите `Сгенерировать`.
  1. В блоке **Сетевые настройки** выберите созданную ранее облачную сеть `my-vpc-network`.
  1. В блоке **Хосты** оставьте один хост в зоне доступности `ru-central1-b`.

      Чтобы удалить лишние хосты, в строке с соответствующим хостом нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../_assets/console-icons/trash-bin.svg) **Удалить**.
  
      {% note tip %}

      Одного хоста достаточно, чтобы проверить работу рассматриваемого решения.
      
      В рабочих сценариях не рекомендуется создавать кластер из одного хоста. Такой кластер обходится дешевле, но не обеспечивает [высокую доступность](../../managed-postgresql/concepts/high-availability.md#host-configuration).

      {% endnote %}

  1. Значения остальных параметров оставьте без изменений и нажмите кнопку **Создать кластер**.

{% endlist %}

### Создайте входящее DNS-подключение {#create-inbound-endpoint}

Создайте [входящее DNS-подключение](../concepts/dns-connection.md#dns-inbound), через которое клиенты из корпоративной сети смогут разрешать DNS-имена во внутренних DNS-зонах Yandex Cloud:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу каталога, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **Cloud DNS**.
  1. На панели слева выберите ![nodes-down](../../_assets/console-icons/nodes-down.svg) **Входящие подключения** и нажмите кнопку **Создать подключение**. В открывшемся окне:

      1. В поле **Имя** задайте [имя](*name) `corp-example-net-inbound`.
      1. В блоке **Сетевые настройки** в поле **Сеть** выберите облачную сеть `my-vpc-network`.
      1. В поле **IP-адрес** нажмите кнопку **Зарезервировать**, чтобы зарезервировать статический внутренний IP-адрес для создаваемого DNS-подключения. В открывшемся окне:

          1. В поле **Имя** задайте [имя](*name) резервируемого адреса `corp-example-net-inbound-address`.
          1. В поле **Подсеть** выберите подсеть `subnet2`, в которой будет зарезервирован IP-адрес.

              {% note info %}

              IP-адрес входящего DNS-подключения может относиться к любой из подсетей в выбранной облачной сети. При этом указывать IP-адреса, уже используемые ресурсами Yandex Cloud, нельзя.

              {% endnote %}

          1. В поле **Внутренний IPv4 адрес** задайте IP-адрес `192.168.1.200` (относится к диапазону адресов подсети `subnet2`).
          1. Нажмите кнопку **Создать**, чтобы зарезервировать адрес.
    1. Нажмите кнопку **Создать**, чтобы создать входящее DNS-подключение.

{% endlist %}

## Настройте корпоративную сеть {#setup-on-prem-dns}

Настройте корпоративную сеть так, чтобы DNS-запросы к [внутренним зонам Yandex Cloud](../concepts/dns-zone.md#private-zones) направлялись на зарезервированный внутренний IP-адрес `192.168.1.200`, который [был назначен](#create-inbound-endpoint) входящему DNS-подключению.

Например, в корпоративной подсети вы можете создать [DNS-форвардер](*dns_forwarder) и задать его IP-адрес в качестве адреса основного DNS-сервера на сетевых интерфейсах клиентов в корпоративной подсети `subnet1`. Для создания DNS-форвардеров рекомендуем использовать утилиты [CoreDNS](https://coredns.io/) или [Unbound](https://www.nlnetlabs.nl/projects/unbound/).

{% cut "Пример настройки DNS-форвардера" %}

{% list tabs accordion %}

- Настройка DNS-переадресации с помощью CoreDNS

  1. Подключитесь к хосту, на котором будет настроен DNS-форвардер.
  1. Скачайте актуальную версию `CoreDNS` со [страницы производителя](https://github.com/coredns/coredns/releases/latest) и установите ее:

      ```bash
      cd /var/tmp && wget <URL_пакета> -O - | tar -xz
      sudo mv coredns /usr/local/sbin
      ```
  1. Создайте файл конфигурации `CoreDNS`: 

      ```bash
      sudo mkdir /etc/coredns
      sudo tee >> /etc/coredns/Corefile <<EOF
      mdb.yandexcloud.net {
        forward . 192.168.1.200
      }
      . {
        forward . <IP-адрес_основного_DNS-сервера_в_корпоративной_подсети>
      }
      EOF
      ```
  1. Настройте автоматический запуск `CoreDNS`:

      ```bash
      sudo tee >> /etc/systemd/system/coredns.service <<EOF
      [Unit]
      Description=CoreDNS
      After=network.target

      [Service]
      User=root
      ExecStart=/usr/local/sbin/coredns -conf /etc/coredns/Corefile
      StandardOutput=append:/var/log/coredns.log
      StandardError=append:/var/log/coredns.log
      RestartSec=5
      Restart=always

      [Install]
      WantedBy=multi-user.target
      EOF
      sudo systemctl enable --now coredns
      ```
  1. Отключите системную службу распознавания имен DNS, чтобы ее функции выполнял локальный DNS-форвардер. Например, в ОС Linux Ubuntu 20.04 это можно сделать с помощью команд:

      ```bash
      sudo systemctl disable --now systemd-resolved
      rm /etc/resolv.conf
      echo "nameserver 127.0.0.1" | sudo tee /etc/resolv.conf
      ```

- Настройка DNS-переадресации с помощью Unbound

  1. Подключитесь к хосту, на котором будет настроен DNS-форвардер.
  1. Установите пакет `unbound` (приведен пример для ОС Linux Ubuntu):

      ```bash
      sudo apt update && sudo apt install --yes unbound
      ```
  1. Создайте файл конфигурации `unbound`:
   
      ```bash
      sudo tee -a /etc/unbound/unbound.conf <<EOF
      server:
        module-config: "iterator"
        interface: 0.0.0.0
        access-control: 127.0.0.0/8   allow
        access-control: 192.168.0.0/21 allow

      forward-zone:
        name: "mdb.yandexcloud.net"
        forward-addr: 192.168.1.200

      forward-zone:
        name: "."
        forward-addr: <IP-адрес_основного_DNS-сервера_в_корпоративной_подсети>
      EOF
      ``` 
  1. Перезапустите Unbound:

      ```bash
      sudo systemctl restart unbound
      ```

  1. Отключите системную службу распознавания имен DNS, чтобы ее функции выполнял локальный DNS-форвардер. Например, в ОС Linux Ubuntu 20.04 это можно сделать с помощью команд:

      ```bash
      sudo systemctl disable --now systemd-resolved
      rm /etc/resolv.conf
      echo "nameserver 127.0.0.1" | sudo tee /etc/resolv.conf
      ```

{% endlist %}

{% endcut %}


## Проверьте работу интеграции {#check-dns-service}

1. Получите FQDN хоста созданного ранее кластера `my-postgresql-cluster`.

    О том, как узнать FQDN хоста, читайте в разделе [FQDN хостов PostgreSQL](../../managed-postgresql/operations/connect/fqdn.md).
1. Убедитесь, что с компьютера в корпоративной сети выполняется разрешение имен во внутренней DNS-зоне Yandex Cloud `mdb.yandexcloud.net`. Для этого выполните команду, указав в ней FQDN хоста кластера.

    Например:

    ```bash
    host rc1d-oсfgp28n0k358fj1.mdb.yandexcloud.net
    ```

    Результат:

    ```text
    rc1d-oсfgp28n0k358fj1.mdb.yandexcloud.net has address 192.168.1.20
    ```
1. Убедитесь, что на компьютере в корпоративной сети выполняется разрешение имен в публичных зонах, например:

    ```bash
    host cisco.com
    ```

    Результат:

    ```text
    cisco.com has address 72.163.4.185
    ...
    ```

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за ресурсы:

* [удалите кластер Managed Service for PostgreSQL](../../managed-postgresql/operations/cluster-delete.md);
* [удалите входящее DNS-подключение](../operations/connection-inbound-delete.md);
* [удалите зарезервированный внутренний IP-адрес](../../vpc/operations/private-ip-delete.md);
* [удалите подсеть](../../vpc/operations/subnet-delete.md);
* [удалите облачную сеть](../../vpc/operations/network-delete.md).

[*name]: Требования к имени:
         
         * длина — от 3 до 63 символов;
         * может содержать строчные буквы латинского алфавита, цифры и дефисы;
         * первый символ — буква, последний — не дефис.

[*dns_forwarder]: DNS-форвардер — это специальный DNS-сервер, который по-разному перенаправляет DNS-запросы в зависимости от доменного имени, указанного в запросе.