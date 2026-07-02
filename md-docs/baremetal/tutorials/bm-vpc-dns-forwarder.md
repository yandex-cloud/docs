[Документация Yandex Cloud](../../index.md) > [Yandex BareMetal](../index.md) > [Практические руководства](index.md) > Настройка DNS-связности между сегментами Yandex BareMetal и Yandex Virtual Private Cloud для доступа к Managed Service for PostgreSQL по FQDN

# Настройка DNS-связности между сегментами Yandex BareMetal и Yandex Virtual Private Cloud для доступа к Managed Service for PostgreSQL по FQDN

Использование полных доменных имен (FQDN) для подключения к облачным сервисам, таким как Yandex Managed Service for PostgreSQL, является рекомендуемой практикой: это обеспечивает абстракцию от инфраструктуры и автоматизацию процессов. FQDN остается стабильным, в то время как IP-адреса могут изменяться при масштабировании, восстановлении или миграции сервисов.

Однако если сервер в сегменте BareMetal подключен к облаку через Yandex Cloud Interconnect, возникает проблема с разрешением FQDN облачных сервисов: прямые DNS-запросы из внешней подсети блокируются.

Для решения этой задачи предлагается развернуть промежуточную виртуальную машину в той же подсети, что и кластер Managed Service for PostgreSQL, в роли DNS-форвардера на базе Bind9. Этот сервер будет принимать DNS-запросы от сервера BareMetal, перенаправлять их в Yandex Cloud DNS и возвращать ответы клиенту, обеспечивая корректное разрешение FQDN облачных сервисов.

Чтобы настроить DNS-связность:

1. [Подготовьте инфраструктуру](#prepare-infra).
1. [Настройте DNS-форвардер на виртуальной машине](#configure-forwarder).
1. [Настройте DNS-клиент на сервере BareMetal](#configure-baremetal).
1. [Проверьте доступ к кластеру Managed Service for PostgreSQL по FQDN](#check-postgresql).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте инфраструктуру {#prepare-infra}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки решения входят:

* плата за использование виртуальной машины и диска ([тарифы Yandex Compute Cloud](../../compute/pricing.md));
* плата за использование кластера Managed Service for PostgreSQL ([тарифы Yandex Managed Service for PostgreSQL](../../managed-postgresql/pricing.md));
* плата за аренду серверов BareMetal ([тарифы Yandex BareMetal](../pricing.md));
* плата за использование ресурсов Yandex Cloud Interconnect ([тарифы Yandex Cloud Interconnect](../../interconnect/pricing.md)).

### Создайте кластер Managed Service for PostgreSQL {#create-postgresql-cluster}

1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать кластер.
1. В списке сервисов выберите **Managed Service for&nbsp;PostgreSQL**.
1. Нажмите кнопку **Создать кластер**.
1. Задайте параметры кластера:
   * **Имя кластера** — укажите имя кластера.
   * **База данных** — задайте имя базы данных, имя пользователя и пароль.
   * **Сетевые настройки** — выберите зоны доступности и подсети.
1. Нажмите кнопку **Создать кластер**.

   {% note info %}

   При создании кластера Managed Service for PostgreSQL автоматически создается приватная DNS-зона `mdb.yandexcloud.net`, в которой появляются DNS-записи для хостов кластера. FQDN хостов имеют формат `c-<идентификатор_кластера>-<номер_хоста>.mdb.yandexcloud.net`. Внутри зоны автоматически создаются DNS-записи для базы данных — например, мастер: `10.129.0.29` и реплика: `10.130.0.15`.

   {% endnote %}

Подробнее о создании кластера читайте в [инструкции](../../managed-postgresql/operations/cluster-create.md).

### Создайте виртуальную машину для DNS-форвардера {#create-dns-forwarder-vm}

1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать виртуальную машину.
1. В списке сервисов выберите **Compute Cloud**.
1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **Виртуальные машины**.
1. Нажмите кнопку **Создать виртуальную машину**.
1. В блоке **Общая информация** задайте имя виртуальной машины.
1. В блоке **Образ загрузочного диска** выберите образ **Ubuntu 22.04 LTS**.
1. В блоке **Сетевые настройки**:
   * В поле **Подсеть** выберите подсеть, в которой размещены хосты кластера Managed Service for PostgreSQL (например, `10.129.0.0/24`).
   * Укажите внутренний IP-адрес виртуальной машины (например, `10.129.0.10`).
   * Убедитесь, что зона доступности совпадает с зоной размещения кластера Managed Service for PostgreSQL (например, `ru-central1-b`).
1. Нажмите кнопку **Создать ВМ**.

Подробнее о создании виртуальной машины читайте в [инструкции](../../compute/operations/vm-create/create-linux-vm.md).

### Арендуйте сервер BareMetal {#lease-baremetal-server}

1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите арендовать сервер.
1. В списке сервисов выберите **BareMetal**.
1. Нажмите кнопку **Заказать сервер**.
1. Выберите параметры сервера:
   * Выберите подходящую [конфигурацию](../concepts/server-configurations.md) сервера.
   * Присвойте или получите по DHCP приватный IP-адрес (например, `172.16.2.2`).
1. Нажмите кнопку **Заказать сервер**.

Подробнее об аренде сервера читайте в [инструкции](../operations/servers/server-lease.md).

### Настройте сетевую связность {#configure-network-connectivity}

Настройте связность между подсетями BareMetal и Virtual Private Cloud через Yandex Cloud Interconnect:

1. Создайте сеть Virtual Private Cloud с подсетями в нужных зонах доступности.
1. Создайте приватную подсеть BareMetal.
1. Настройте подключение через Yandex Cloud Interconnect между подсетью BareMetal и подсетью Virtual Private Cloud, в которой размещен кластер Managed Service for PostgreSQL.

Подробнее о настройке сетевой связности читайте в [инструкции](bm-vrf-and-vpc-interconnect.md).

В примерах ниже используются:

* подсеть BareMetal: `172.16.2.0/24`;
* IP-адрес сервера BareMetal: `172.16.2.2`;
* подсеть Virtual Private Cloud с хостами Managed Service for PostgreSQL: `10.129.0.0/24`;
* IP виртуальной машины с Bind9: `10.129.0.10`;
* DNS-резолверы Virtual Private Cloud: `10.129.0.2` и `10.130.0.2`.

   {% note info %}

   DNS-резолверы Virtual Private Cloud имеют адреса вида `10.X.0.2`, где `X` — номер подсети. Для каждой подсети в Virtual Private Cloud доступен свой DNS-резолвер.

   {% endnote %}

### Создайте группу безопасности для DNS-форвардера {#configure-sg}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **Virtual Private Cloud**.
  1. На панели слева выберите ![image](../../_assets/console-icons/shield.svg) **Группы безопасности** и нажмите кнопку **Создать группу безопасности**.
  1. В поле **Имя** задайте имя `dns-forwarder-sg`.
  1. В поле **Сеть** выберите сеть, в которой размещена виртуальная машина с Bind9.
  1. В блоке **Правила** [создайте](../../vpc/operations/security-group-add-rule.md) следующие правила для управления трафиком:

      | Направление<br/>трафика | Описание | Диапазон портов | Протокол | Источник /<br/>Назначение | CIDR блоки /<br/>Группа безопасности |
      | --- | --- | --- | --- | --- | --- |
      | Входящий | `dns-udp` | `53` | `UDP` | `CIDR` | `172.16.2.0/24` |
      | Входящий | `dns-tcp` | `53` | `TCP` | `CIDR` | `172.16.2.0/24` |
      | Исходящий | `dns-udp-forward` | `53` | `UDP` | `CIDR` | `10.129.0.0/24` |
      | Исходящий | `dns-tcp-forward` | `53` | `TCP` | `CIDR` | `10.129.0.0/24` |
      | Исходящий | `dns-udp-forward` | `53` | `UDP` | `CIDR` | `10.130.0.0/24` |
      | Исходящий | `dns-tcp-forward` | `53` | `TCP` | `CIDR` | `10.130.0.0/24` |

      {% note info %}

      В примере используются подсети `10.129.0.0/24` и `10.130.0.0/24`, в которых находятся DNS-резолверы `10.129.0.2` и `10.130.0.2`. Замените их на подсети, в которых находятся DNS-резолверы ваших подсетей Virtual Private Cloud. DNS-резолверы Virtual Private Cloud имеют адреса вида `10.X.0.2`, где `X` — номер подсети.

      {% endnote %}

  1. При необходимости добавьте правило для SSH-доступа к виртуальной машине:

      | Направление<br/>трафика | Описание | Диапазон портов | Протокол | Источник /<br/>Назначение | CIDR блоки /<br/>Группа безопасности |
      | --- | --- | --- | --- | --- | --- |
      | Входящий | `ssh` | `22` | `TCP` | `CIDR` | `<CIDR_административной_подсети>` |

  1. Нажмите **Создать**.

{% endlist %}

## Настройте DNS-форвардер на виртуальной машине {#configure-forwarder}

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к виртуальной машине по SSH.

1. Установите Bind9:

   ```bash
   sudo apt update
   sudo apt install -y bind9 bind9-utils dnsutils
   ```

1. Откройте файл `/etc/bind/named.conf.options` и укажите параметры форвардинга:

   ```bash
   sudo nano /etc/bind/named.conf.options
   ```

   Пример конфигурации:

   ```text
   options {
     directory "/var/cache/bind";

     recursion yes;
     allow-recursion {
       172.16.2.0/24;
       localhost;
     };
     allow-query {
       172.16.2.0/24;
       localhost;
     };

     forwarders {
       10.129.0.2;
       10.130.0.2;
     };

     dnssec-validation auto;
     listen-on { any; };
     listen-on-v6 { any; };
   };
   ```

1. Проверьте конфигурацию и перезапустите сервис:

   ```bash
   sudo named-checkconf
   sudo systemctl restart bind9
   sudo systemctl enable bind9
   ```

1. Убедитесь, что сервис запущен:

   ```bash
   sudo systemctl status bind9 --no-pager
   ```

1. Если на виртуальной машине запущен локальный резолвер `systemd-resolved`, который перезаписывает `/etc/resolv.conf`, настройте его для работы с Bind9:

   ```bash
   sudo systemctl stop systemd-resolved
   sudo systemctl disable systemd-resolved
   sudo mv /etc/resolv.conf /etc/resolv.conf.backup
   ```

   Создайте статический файл `/etc/resolv.conf`:

   ```bash
   sudo nano /etc/resolv.conf
   ```

   Добавьте запись:

   ```text
   nameserver 127.0.0.1
   ```

1. Настройте nameserver в Ubuntu. Отредактируйте файл `/run/systemd/resolve/stub-resolv.conf`:

   ```bash
   sudo nano /run/systemd/resolve/stub-resolv.conf
   ```

   Измените значение параметра `nameserver` на `127.0.0.1`.

1. Проверьте работу форвардера локально:

   ```bash
   dig @127.0.0.1 NS mdb.yandexcloud.net +short
   ```

   В ответе должны появиться адреса DNS-серверов зоны.

   Альтернативная проверка:

   ```bash
   dig @127.0.0.1 yandex.ru +short
   ```

   Команда должна вернуть IP-адрес домена, что подтверждает работу форвардинга.

## Настройте DNS-клиент на сервере BareMetal {#configure-baremetal}

1. [Подключитесь по SSH](../../compute/operations/vm-connect/ssh.md) к серверу BareMetal.

1. Назначьте DNS-сервером IP виртуальной машины с Bind9:

   ```bash
   sudo nano /etc/resolv.conf
   ```

   Пример:

   ```text
   nameserver 10.129.0.10
   ```

1. Если `/etc/resolv.conf` управляется системным сервисом, задайте DNS постоянным способом.

   **Вариант 1:** Используйте команду `systemd-resolve` для конкретного интерфейса:

   ```bash
   sudo systemd-resolve --interface ethXX --set-dns 10.129.0.10
   ```

   где `ethXX` — интерфейс приватной сети.

   **Вариант 2:** Отредактируйте файл `/etc/systemd/resolved.conf`:

   ```bash
   sudo nano /etc/systemd/resolved.conf
   ```

   Укажите:

   ```text
   [Resolve]
   DNS=10.129.0.10
   Domains=~.
   ```

   Примените настройки:

   ```bash
   sudo systemctl restart systemd-resolved
   ```

1. Проверьте DNS-разрешение:

   ```bash
   dig mdb.yandexcloud.net +short
   ```

   Проверьте разрешение FQDN хоста кластера Managed Service for PostgreSQL:

   ```bash
   dig c-<идентификатор_кластера>-<номер_хоста>.mdb.yandexcloud.net +short
   ```

   Команды должны вернуть IP-адреса хостов кластера из подсети Virtual Private Cloud (например, `10.129.0.29` — для мастера, `10.130.0.15` — для реплики).

## Проверьте доступ к кластеру Managed Service for PostgreSQL по FQDN {#check-postgresql}

1. Установите сертификат центра сертификации:

   ```bash
   mkdir -p ~/.postgresql && \
   wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" \
     --output-document ~/.postgresql/root.crt && \
   chmod 0600 ~/.postgresql/root.crt
   ```

1. Установите клиент PostgreSQL:

   ```bash
   sudo apt update && sudo apt install -y postgresql-client
   ```

1. Подключитесь к базе по FQDN:

   ```bash
   psql "host=<FQDN_мастера>,<FQDN_реплики> port=6432 sslmode=verify-full dbname=<имя_БД> user=<имя_пользователя> target_session_attrs=read-write"
   ```

   Параметры подключения для вашего кластера можно взять в консоли управления на странице кластера Managed Service for PostgreSQL.

## Проверьте результат {#check-result}

После настройки:

1. Сервер в сегменте BareMetal успешно разрешает доменные имена зоны `mdb.yandexcloud.net`.
1. FQDN хостов кластера Managed Service for PostgreSQL разрешаются в приватные IP-адреса Virtual Private Cloud.
1. Подключение к PostgreSQL выполняется по FQDN без указания IP-адресов вручную.

{% note warning %}

* Используйте статические IP-адреса для виртуальной машины с DNS-форвардером и сервера BareMetal, чтобы избежать проблем с DNS-разрешением при перезапуске.
* Регулярно проверяйте логи Bind9 для выявления проблем с DNS-запросами:

  ```bash
  sudo journalctl -u bind9 -f
  ```

* При изменении подсети, в которой размещен кластер Managed Service for PostgreSQL, обновите адреса DNS-резолверов в параметре `forwarders` конфигурации Bind9.

{% endnote %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить использование ресурсов и избежать лишних затрат:

1. [Удалите](../../compute/operations/vm-control/vm-delete.md) виртуальную машину с DNS-форвардером.
1. [Удалите](../../vpc/operations/security-group-delete.md) группу безопасности, созданную для DNS-форвардера.
1. Если тестовый кластер больше не нужен, [удалите](../../managed-postgresql/operations/cluster-delete.md) кластер Managed Service for PostgreSQL.
1. Если связность через Yandex Cloud Interconnect была создана только для теста, удалите соответствующие сетевые настройки и ресурсы Cloud Interconnect.