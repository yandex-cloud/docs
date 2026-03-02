---
title: Настройка DNS-связности между сегментами {{ baremetal-full-name }} и {{ vpc-full-name }} для доступа к {{ mpg-name }} по FQDN
description: Следуя данной инструкции, вы настроите DNS-форвардер на базе Bind9 для разрешения FQDN {{ mpg-name }} из приватного сегмента {{ baremetal-name }}.
canonical: '{{ link-docs }}/tutorials/routing/bm-vpc-dns-forwarder'
---

# Настройка DNS-связности между сегментами {{ baremetal-full-name }} и {{ vpc-full-name }} для доступа к {{ mpg-name }} по FQDN

Использование полных доменных имен (FQDN) для подключения к облачным сервисам, таким как {{ mpg-full-name }}, является рекомендуемой практикой: это обеспечивает абстракцию от инфраструктуры и автоматизацию процессов. FQDN остается стабильным, в то время как IP-адреса могут изменяться при масштабировании, восстановлении или миграции сервисов.

Однако если сервер в сегменте {{ baremetal-name }} подключен к облаку через {{ interconnect-full-name }}, возникает проблема с разрешением FQDN облачных сервисов: прямые DNS-запросы из внешней подсети блокируются.

Для решения этой задачи предлагается развернуть промежуточную виртуальную машину в той же подсети, что и кластер {{ mpg-name }}, в роли DNS-форвардера на базе Bind9. Этот сервер будет принимать DNS-запросы от сервера {{ baremetal-name }}, перенаправлять их в {{ dns-full-name }} и возвращать ответы клиенту, обеспечивая корректное разрешение FQDN облачных сервисов.

Чтобы настроить DNS-связность:

1. [Подготовьте инфраструктуру](#prepare-infra).
1. [Настройте DNS-форвардер на виртуальной машине](#configure-forwarder).
1. [Настройте DNS-клиент на сервере {{ baremetal-name }}](#configure-baremetal).
1. [Проверьте доступ к кластеру {{ mpg-name }} по FQDN](#check-postgresql).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте инфраструктуру {#prepare-infra}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки решения входят:

* плата за использование виртуальной машины и диска (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование кластера {{ mpg-name }} (см. [тарифы {{ mpg-full-name }}](../../managed-postgresql/pricing.md));
* плата за аренду серверов {{ baremetal-name }} (см. [тарифы {{ baremetal-full-name }}](../../baremetal/pricing.md));
* плата за использование ресурсов {{ interconnect-full-name }} (см. [тарифы {{ interconnect-full-name }}](../../interconnect/pricing.md)).

### Создайте кластер {{ mpg-name }} {#create-postgresql-cluster}

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать кластер.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
1. Задайте параметры кластера:
   * **{{ ui-key.yacloud.mdb.forms.base_field_name }}** — укажите имя кластера.
   * **{{ ui-key.yacloud.mdb.forms.section_database }}** — задайте имя базы данных, имя пользователя и пароль.
   * **{{ ui-key.yacloud.mdb.forms.section_network }}** — выберите зоны доступности и подсети.
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.

   {% note info %}

   При создании кластера {{ mpg-name }} автоматически создается приватная DNS-зона `{{ dns-zone }}`, в которой появляются DNS-записи для хостов кластера. FQDN хостов имеют формат `c-<идентификатор_кластера>-<номер_хоста>.mdb.yandexcloud.net`. Внутри зоны автоматически создаются DNS-записи для базы данных — например, мастер: `10.129.0.29` и реплика: `10.130.0.15`.

   {% endnote %}

Подробнее о создании кластера читайте в [инструкции](../../managed-postgresql/operations/cluster-create.md).

### Создайте виртуальную машину для DNS-форвардера {#create-dns-forwarder-vm}

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать виртуальную машину.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя виртуальной машины.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите образ **Ubuntu 22.04 LTS**.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
   * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите подсеть, в которой размещены хосты кластера {{ mpg-name }} (например, `10.129.0.0/24`).
   * Укажите внутренний IP-адрес виртуальной машины (например, `10.129.0.10`).
   * Убедитесь, что зона доступности совпадает с зоной размещения кластера {{ mpg-name }} (например, `ru-central1-b`).
1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

Подробнее о создании виртуальной машины читайте в [инструкции](../../compute/operations/vm-create/create-linux-vm.md).

### Арендуйте сервер {{ baremetal-name }} {#lease-baremetal-server}

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите арендовать сервер.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-server }}**.
1. Выберите параметры сервера:
   * Выберите подходящую [конфигурацию](../../baremetal/concepts/server-configurations.md) сервера.
   * Присвойте или получите по DHCP приватный IP-адрес (например, `172.16.2.2`).
1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-server }}**.

Подробнее об аренде сервера читайте в [инструкции](../../baremetal/operations/servers/server-lease.md).

### Настройте сетевую связность {#configure-network-connectivity}

Настройте связность между подсетями {{ baremetal-name }} и {{ vpc-name }} через {{ interconnect-full-name }}:

1. Создайте сеть {{ vpc-name }} с подсетями в нужных зонах доступности.
1. Создайте приватную подсеть {{ baremetal-name }}.
1. Настройте подключение через {{ interconnect-full-name }} между подсетью {{ baremetal-name }} и подсетью {{ vpc-name }}, в которой размещен кластер {{ mpg-name }}.

Подробнее о настройке сетевой связности читайте в [инструкции](../../baremetal/tutorials/bm-vrf-and-vpc-interconnect.md).

В примерах ниже используются:

* подсеть {{ baremetal-name }}: `172.16.2.0/24`;
* IP-адрес сервера {{ baremetal-name }}: `172.16.2.2`;
* подсеть {{ vpc-name }} с хостами {{ mpg-name }}: `10.129.0.0/24`;
* IP виртуальной машины с Bind9: `10.129.0.10`;
* DNS-резолверы {{ vpc-name }}: `10.129.0.2` и `10.130.0.2`.

   {% note info %}

   DNS-резолверы {{ vpc-name }} имеют адреса вида `10.X.0.2`, где `X` — номер подсети. Для каждой подсети в {{ vpc-name }} доступен свой DNS-резолвер.

   {% endnote %}

### Создайте группу безопасности для DNS-форвардера {#configure-sg}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}** и нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
  1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** задайте имя `dns-forwarder-sg`.
  1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** выберите сеть, в которой размещена виртуальная машина с Bind9.
  1. В блоке **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}** [создайте](../../vpc/operations/security-group-add-rule.md) следующие правила для управления трафиком:

      | Направление<br/>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }} |
      | --- | --- | --- | --- | --- | --- |
      | Входящий | `dns-udp` | `53` | `UDP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `172.16.2.0/24` |
      | Входящий | `dns-tcp` | `53` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `172.16.2.0/24` |
      | Исходящий | `dns-udp-forward` | `53` | `UDP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `10.129.0.0/24` |
      | Исходящий | `dns-tcp-forward` | `53` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `10.129.0.0/24` |
      | Исходящий | `dns-udp-forward` | `53` | `UDP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `10.130.0.0/24` |
      | Исходящий | `dns-tcp-forward` | `53` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `10.130.0.0/24` |

      {% note info %}

      В примере используются подсети `10.129.0.0/24` и `10.130.0.0/24`, в которых находятся DNS-резолверы `10.129.0.2` и `10.130.0.2`. Замените их на подсети, в которых находятся DNS-резолверы ваших подсетей {{ vpc-name }}. DNS-резолверы {{ vpc-name }} имеют адреса вида `10.X.0.2`, где `X` — номер подсети.

      {% endnote %}

  1. При необходимости добавьте правило для SSH-доступа к виртуальной машине:

      | Направление<br/>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }} |
      | --- | --- | --- | --- | --- | --- |
      | Входящий | `ssh` | `22` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<CIDR_административной_подсети>` |

  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

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
   dig @127.0.0.1 NS {{ dns-zone }} +short
   ```

   В ответе должны появиться адреса DNS-серверов зоны.

   Альтернативная проверка:

   ```bash
   dig @127.0.0.1 yandex.ru +short
   ```

   Команда должна вернуть IP-адрес домена, что подтверждает работу форвардинга.

## Настройте DNS-клиент на сервере {{ baremetal-name }} {#configure-baremetal}

1. [Подключитесь по SSH](../../compute/operations/vm-connect/ssh.md) к серверу {{ baremetal-name }}.

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
   dig {{ dns-zone }} +short
   ```

   Проверьте разрешение FQDN хоста кластера {{ mpg-name }}:

   ```bash
   dig c-<идентификатор_кластера>-<номер_хоста>.mdb.yandexcloud.net +short
   ```

   Команды должны вернуть IP-адреса хостов кластера из подсети {{ vpc-name }} (например, `10.129.0.29` — для мастера, `10.130.0.15` — для реплики).

## Проверьте доступ к кластеру {{ mpg-name }} по FQDN {#check-postgresql}

1. Установите сертификат центра сертификации:

   ```bash
   mkdir -p ~/.postgresql && \
   wget "{{ crt-web-path }}" \
     --output-document ~/.postgresql/root.crt && \
   chmod 0600 ~/.postgresql/root.crt
   ```

1. Установите клиент PostgreSQL:

   ```bash
   sudo apt update && sudo apt install -y postgresql-client
   ```

1. Подключитесь к базе по FQDN:

   ```bash
   psql "host=<FQDN_мастера>,<FQDN_реплики> port={{ port-mpg }} sslmode=verify-full dbname=<имя_БД> user=<имя_пользователя> target_session_attrs=read-write"
   ```

   Параметры подключения для вашего кластера можно взять в консоли управления на странице кластера {{ mpg-name }}.

## Проверьте результат {#check-result}

После настройки:

1. Сервер в сегменте {{ baremetal-name }} успешно разрешает доменные имена зоны `{{ dns-zone }}`.
1. FQDN хостов кластера {{ mpg-name }} разрешаются в приватные IP-адреса {{ vpc-name }}.
1. Подключение к PostgreSQL выполняется по FQDN без указания IP-адресов вручную.

{% note warning %}

* Используйте статические IP-адреса для виртуальной машины с DNS-форвардером и сервера {{ baremetal-name }}, чтобы избежать проблем с DNS-разрешением при перезапуске.
* Регулярно проверяйте логи Bind9 для выявления проблем с DNS-запросами:

  ```bash
  sudo journalctl -u bind9 -f
  ```

* При изменении подсети, в которой размещен кластер {{ mpg-name }}, обновите адреса DNS-резолверов в параметре `forwarders` конфигурации Bind9.

{% endnote %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить использование ресурсов и избежать лишних затрат:

1. [Удалите](../../compute/operations/vm-control/vm-delete.md) виртуальную машину с DNS-форвардером.
1. [Удалите](../../vpc/operations/security-group-delete.md) группу безопасности, созданную для DNS-форвардера.
1. Если тестовый кластер больше не нужен, [удалите](../../managed-postgresql/operations/cluster-delete.md) кластер {{ mpg-name }}.
1. Если связность через {{ interconnect-full-name }} была создана только для теста, удалите соответствующие сетевые настройки и ресурсы {{ interconnect-name }}.
