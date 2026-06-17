# Создание сайта на CMS Joomla с базой данных PostgreSQL с помощью Terraform

Чтобы создать инфраструктуру для [сайта на CMS Joomla с базой данных PostgreSQL](index.md) c помощью Terraform:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Настройте окружение на виртуальной машине](#env-install).
1. [Настройте Joomla](#configure-joomla).
1. [Проверьте работу сайта](#test-site).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

* Виртуальная машина: использование вычислительных ресурсов, хранилища, публичного IP-адреса и операционной системы ([тарифы Compute Cloud](../../../compute/pricing.md)).
* Кластер Managed Service for PostgreSQL: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы Managed Service for PostgreSQL](../../../managed-postgresql/pricing.md)).
* Плата за исходящий трафик ([тарифы Yandex Compute Cloud](../../../compute/pricing.md)).
* Публичные [DNS-запросы](../../../glossary/dns.md) и [зоны DNS](../../../dns/concepts/dns-zone.md) ([тарифы Cloud DNS](../../../dns/pricing.md)).


## Создайте инфраструктуру {#deploy}

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

Для создания инфраструктуры c помощью Terraform:
1. [Установите](../../infrastructure-management/terraform-quickstart.md#install-terraform) Terraform и укажите источник для установки провайдера Yandex Cloud (раздел [Настройте провайдер](../../infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файл с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовая конфигурация {#ready}

     1. Клонируйте репозиторий с конфигурационными файлами.

         ```bash
         git clone https://github.com/yandex-cloud-examples/yc-joomla-postgresql
         ```

     1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:

         * `joomla-postgresql-terraform.tf` — конфигурация создаваемой инфраструктуры.
         * `joomla-postgresql-terraform.auto.tfvars` — файл c пользовательскими данными.

   - Вручную {#manual}

     1. Создайте папку для файла с описанием инфраструктуры.
     1. Создайте в папке конфигурационный файл `joomla-postgresql-terraform.tf`:

         {% cut "joomla-postgresql-terraform.tf" %}

         ```hcl
         # Объявление переменных для пользовательских параметров
         
         variable "folder_id" {
           type = string
         }
         
         variable "ssh_key_path" {
           type = string
         }
         
         variable "db_password" {
           type      = string
           sensitive = true
         }
         
         variable "domain_name" {
           type = string
         }
         
         # Добавление прочих переменных
         
         locals {
           network_name       = "joomla-network"
           subnet_name1       = "joomla-subnet-a"
           subnet_name2       = "joomla-subnet-b"
           subnet_name3       = "joomla-subnet-d"
           subnet_cidr1       = "192.168.2.0/24"
           subnet_cidr2       = "192.168.1.0/24"
           subnet_cidr3       = "192.168.3.0/24" 
           sg_vm_name         = "joomla-sg"
           sg_pgsql_name      = "postgresql-sg"
           vm_name            = "joomla-web-server"
           cluster_name       = "joomla-pg-cluster"
           db_name            = "joomla_db"
           dns_zone_name      = "joomla-zone"
           vm_user            = "yc-user"
           db_user            = "joomla"
           cert_name          = "joomla-cert"
         }
         
         # Настройка провайдера
         
         terraform {
           required_providers {
             yandex    = {
               source  = "yandex-cloud/yandex"
               version = ">= 0.47.0"
             }
           }
         }
         
         provider "yandex" {
           folder_id = var.folder_id
         }
         
         
         # Создание облачной сети
         
         resource "yandex_vpc_network" "joomla-pg-network" {
           name = local.network_name
         }
         
         # Создание подсети в зоне доступности ru-central1-a
         
         resource "yandex_vpc_subnet" "joomla-pg-network-subnet-a" {
           name           = local.subnet_name1
           zone           = "ru-central1-a"
           v4_cidr_blocks = [local.subnet_cidr1]
           network_id     = yandex_vpc_network.joomla-pg-network.id
         }
         
         # Создание подсети в зоне доступности ru-central1-b
         
         resource "yandex_vpc_subnet" "joomla-pg-network-subnet-b" {
           name           = local.subnet_name2
           zone           = "ru-central1-b"
           v4_cidr_blocks = [local.subnet_cidr2]
           network_id     = yandex_vpc_network.joomla-pg-network.id
         }
         
         # Создание подсети в зоне доступности ru-central1-d
         
         resource "yandex_vpc_subnet" "joomla-pg-network-subnet-d" {
           name           = local.subnet_name3
           zone           = "ru-central1-d"
           v4_cidr_blocks = [local.subnet_cidr3]
           network_id     = yandex_vpc_network.joomla-pg-network.id
         }
         
         # Создание группы безопасности для кластера БД PostgreSQL
         
         resource "yandex_vpc_security_group" "pgsql-sg" {
           name       = local.sg_pgsql_name
           network_id = yandex_vpc_network.joomla-pg-network.id
         
           ingress {
             description    = "port-6432"
             port           = 6432
             protocol       = "TCP"
             v4_cidr_blocks = [local.subnet_cidr2]
           }
         
           ingress {
             description       = "self"
             protocol          = "ANY"
             from_port         = 0
             to_port           = 65535
             predefined_target = "self_security_group"
           }
         
           egress {
             description    = "any"
             protocol       = "ANY"
             v4_cidr_blocks = ["0.0.0.0/0"]
             from_port      = 0
             to_port        = 65535
           }
         
         }
         
         # Создание группы безопасности для ВМ
         
         resource "yandex_vpc_security_group" "vm-sg" {
           name       = local.sg_vm_name
           network_id = yandex_vpc_network.joomla-pg-network.id
         
           egress {
             description    = "any"
             protocol       = "ANY"
             v4_cidr_blocks = ["0.0.0.0/0"]
             from_port      = 0
             to_port        = 65535
           }
         
           ingress {
             description    = "http"
             protocol       = "TCP"
             v4_cidr_blocks = ["0.0.0.0/0"]
             port           = 80
           }
         
           ingress {
             description    = "https"
             protocol       = "TCP"
             v4_cidr_blocks = ["0.0.0.0/0"]
             port           = 443
           }
         
           ingress {
             description    = "ssh"
             protocol       = "ANY"
             v4_cidr_blocks = ["0.0.0.0/0"]
             port           = 22
           }
         
           ingress {
             description       = "self"
             protocol          = "ANY"
             from_port         = 0
             to_port           = 65535
             predefined_target = "self_security_group"
           }
         }
         
         # Резервирование публичного IP-адреса
         
         resource "yandex_vpc_address" "addr" {
           name = "joomla-address"
         
           external_ipv4_address {
             zone_id = "ru-central1-b"
           }
         }
         
         
         # Добавление готового образа ВМ
         
         resource "yandex_compute_image" "joomla-pg-vm-image" {
           source_family = "ubuntu-2404-lts-oslogin"
         }
         
         resource "yandex_compute_disk" "boot-disk" {
           name     = "bootvmdisk"
           type     = "network-hdd"
           zone     = "ru-central1-b"
           size     = "10"
           image_id = yandex_compute_image.joomla-pg-vm-image.id
         }
         
         # Создание ВМ
         
         resource "yandex_compute_instance" "joomla-pg-vm" {
           name               = local.vm_name
           platform_id        = "standard-v3"
           zone               = "ru-central1-b"
         
           resources {
             cores         = 2
             memory        = 4
           }
         
           boot_disk {
             disk_id = yandex_compute_disk.boot-disk.id
           }
         
           network_interface {
             subnet_id          = yandex_vpc_subnet.joomla-pg-network-subnet-b.id
             nat                = true
             nat_ip_address     = yandex_vpc_address.addr.external_ipv4_address[0].address
             security_group_ids = [ yandex_vpc_security_group.vm-sg.id ]
           }
         
           metadata = {
             user-data = "#cloud-config\nusers:\n  - name: ${local.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("${var.ssh_key_path}")}"
           }
         }
         
         # Создание кластера БД PostgreSQL
         
         resource "yandex_mdb_postgresql_cluster" "joomla-pg-cluster" {
           name                = local.cluster_name
           environment         = "PRODUCTION"
           network_id          = yandex_vpc_network.joomla-pg-network.id
           security_group_ids  = [ yandex_vpc_security_group.pgsql-sg.id ]
         
           config {
             version = "17"
             resources {
               resource_preset_id = "b2.medium"
               disk_type_id       = "network-ssd"
               disk_size          = 10
             }
           }
         
           host {
             zone      = "ru-central1-a"
             subnet_id = yandex_vpc_subnet.joomla-pg-network-subnet-a.id
           }
         
           host {
             zone      = "ru-central1-b"
             subnet_id = yandex_vpc_subnet.joomla-pg-network-subnet-b.id
           }
         
           host {
             zone      = "ru-central1-d"
             subnet_id = yandex_vpc_subnet.joomla-pg-network-subnet-d.id
           }
         }
         
         # Создание БД
         
         resource "yandex_mdb_postgresql_database" "joomla-pg-tutorial-db" {
           cluster_id = yandex_mdb_postgresql_cluster.joomla-pg-cluster.id
           name       = local.db_name
           owner      = local.db_user
         }
         
         # Создание пользователя БД
         
         resource "yandex_mdb_postgresql_user" "joomla-user" {
           cluster_id = yandex_mdb_postgresql_cluster.joomla-pg-cluster.id
           name       = local.db_user
           password   = var.db_password
         }
         
         # Создание зоны DNS
         
         resource "yandex_dns_zone" "joomla-pg" {
           name    = local.dns_zone_name
           zone    = "${var.domain_name}."
           public  = true
         }
         
         # Добавление сертификата Let's Encrypt
         
         resource "yandex_cm_certificate" "le-certificate" {
           name    = local.cert_name
           domains = [var.domain_name]
         
           managed {
           challenge_type = "DNS_CNAME"
           challenge_count = 1
           }
         }
         
         # Создание CNAME-записей для валидации доменов при выпуске сертификата
         
         resource "yandex_dns_recordset" "validation-record" {
           count   = yandex_cm_certificate.le-certificate.managed[0].challenge_count
           zone_id = yandex_dns_zone.joomla-pg.id
           name    = yandex_cm_certificate.le-certificate.challenges[count.index].dns_name
           type    = yandex_cm_certificate.le-certificate.challenges[count.index].dns_type
           ttl     = 600
           data    = [yandex_cm_certificate.le-certificate.challenges[count.index].dns_value]
         }
         
         # Создание ресурсной записи типа А
         
         resource "yandex_dns_recordset" "joomla-pg-a" {
           zone_id = yandex_dns_zone.joomla-pg.id
           name    = "${yandex_dns_zone.joomla-pg.zone}"
           type    = "A"
           ttl     = 600
           data    = [ yandex_compute_instance.joomla-pg-vm.network_interface.0.nat_ip_address ]
         }
         ```

         {% endcut %}

     1. Создайте в папке файл с пользовательскими данными `joomla-postgresql-terraform.auto.tfvars`:

         {% cut "joomla-postgresql-terraform.auto.tfvars" %}

         ```hcl
         folder_id          = "<идентификатор_каталога>"
         ssh_key_path       = "<путь_к_публичному_SSH-ключу>"
         db_password        = "<пароль_для_доступа_к_БД>"
         domain_name        = "<доменное_имя>"
         ```

         {% endcut %}

   {% endlist %}

   Более подробную информацию о параметрах используемых ресурсов в Terraform см. в документации провайдера:

   * [Сеть](../../../vpc/concepts/network.md#network) — [yandex_vpc_network](../../../terraform/resources/vpc_network.md).
   * [Подсети](../../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet](../../../terraform/resources/vpc_subnet.md).
   * [Группы безопасности](../../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group](../../../terraform/resources/vpc_security_group.md).
   * [Образ ВМ](../../../compute/concepts/image.md) — [yandex_compute_image](../../../terraform/resources/compute_image.md).
   * [Диск](../../../compute/concepts/disk.md) — [yandex_compute_disk](../../../terraform/resources/compute_disk.md).
   * [Виртуальная машина](../../../compute/concepts/vm.md) — [yandex_compute_instance](../../../terraform/resources/compute_instance.md).
   * [Кластер PostgreSQL](../../../managed-postgresql/concepts/index.md) — [yandex_mdb_postgresql_cluster](../../../terraform/resources/mdb_postgresql_cluster.md).
   * [БД PostgreSQL](../../../managed-postgresql/index.md) — [yandex_mdb_postgresql_database](../../../terraform/resources/mdb_postgresql_database.md).
   * [Пользователь БД](../../../managed-postgresql/operations/cluster-users.md) — [yandex_mdb_postgresql_user](../../../terraform/resources/mdb_postgresql_user.md).
   * [Зона DNS](../../../dns/concepts/dns-zone.md) — [yandex_dns_zone](../../../terraform/resources/dns_zone.md).
   * [Ресурсная запись DNS](../../../dns/concepts/resource-record.md) — [yandex_dns_recordset](../../../terraform/resources/dns_recordset.md).
   * [TLS-Сертификат](../../../certificate-manager/concepts/managed-certificate.md) — [yandex_cm_certificate](../../../terraform/resources/cm_certificate.md).

1. В файле `joomla-postgresql-terraform.auto.tfvars` задайте пользовательские параметры:
   * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
   * `ssh_key_path` — путь к файлу с открытым SSH-ключом для аутентификации пользователя на ВМ. Подробнее см. [Создание пары ключей SSH](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
   * `db_password` — пароль для доступа к БД. Длина пароля должна составлять от 8 до 128 символов.
   * `domain_name` — имя домена. Укажите ваше зарегистрированное доменное имя, делегированное Yandex Cloud DNS. Например: `example.com`.

       Чтобы получить доступ к именам из публичной зоны, вам нужно делегировать домен. Укажите адреса серверов `ns1.yandexcloud.net` и `ns2.yandexcloud.net` в личном кабинете вашего регистратора доменных имен.
1. Создайте ресурсы:

   1. В терминале перейдите в директорию с конфигурационным файлом.
   1. Проверьте корректность конфигурации с помощью команды:
   
      ```bash
      terraform validate
      ```
   
      Если конфигурация является корректной, появится сообщение:
   
      ```bash
      Success! The configuration is valid.
      ```
   
   1. Выполните команду:
   
      ```bash
      terraform plan
      ```
   
      В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
   1. Примените изменения конфигурации:
   
      ```bash
      terraform apply
      ```
   
   1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

После создания инфраструктуры, [установите Joomla](#env-install).

## Настройте окружение на виртуальной машине {#env-install}

На этом этапе вы подготовите окружение на виртуальной машине для запуска и настройки Joomla.

1. Экспортируйте TLS-сертификат `joomla-cert` на локальный компьютер:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
        1. Перейдите в сервис **Certificate Manager** и выберите сертификат `joomla-cert`.
        1. На панели сверху нажмите ![ArrowUpFromLine](../../../_assets/console-icons/arrow-up-from-line.svg) **Экспортировать сертификат**, выберите вариант `Сертификат без приватного ключа` и нажмите **Скачать сертификат**. На ваш компьютер будет скачан файл с сертификатом `certificate.pem`.
        1. Повторите предыдущее действие и скачайте закрытый ключ, выбрав вариант `Только приватный ключ`. Переименуйте скачанный файл с закрытым ключом в `private_key.pem`.
        1. Сохраните скачанные файлы `certificate.pem` и `private_key.pem` — они понадобятся при настройке веб-сервера.

    {% endlist %}

1. Скопируйте на ВМ полученные сертификат и закрытый ключ:

    ```bash
    scp ./certificate.pem yc-user@<IP-адрес_ВМ>:certificate.pem \
      && scp ./private_key.pem yc-user@<IP-адрес_ВМ>:private_key.pem
    ```

    Где `<IP-адрес_ВМ>` — публичный IP-адрес созданной ранее ВМ `joomla-web-server`.

    Узнать IP-адрес ВМ можно в [консоли управления](https://console.yandex.cloud) на странице ВМ в блоке **Сеть**.

    При первом подключении к ВМ появится предупреждение о неизвестном хосте:

    ```text
    The authenticity of host '51.250.**.*** (51.250.**.***)' can't be established.
    ED25519 key fingerprint is SHA256:PpcKdcT09gjU045pkEIwIU8lAXXLpwJ6bKC********.
    This key is not known by any other names
    Are you sure you want to continue connecting (yes/no/[fingerprint])?
    ```

    Введите в терминале слово `yes` и нажмите **Enter**.

1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md) к ВМ по SSH:

    ```bash
    ssh yc-user@<IP-адрес_ВМ>
    ```
1. Создайте директорию для сертификата и перенесите в нее скопированные файлы:

    ```bash
    sudo mkdir /etc/ssl-certificates
    sudo mv certificate.pem /etc/ssl-certificates/
    sudo mv private_key.pem /etc/ssl-certificates/
    ```
1. Обновите версии пакетов, установленные на ВМ:

    ```bash
    sudo apt update && sudo apt upgrade -y
    ```
1. Установите и запустите [Apache HTTP-сервер](https://ru.wikipedia.org/wiki/Apache_HTTP_Server):

    ```bash
    sudo apt install apache2
    sudo systemctl start apache2 && sudo systemctl enable apache2
    ```
1. Установите [PHP](https://ru.wikipedia.org/wiki/PHP) c необходимыми библиотеками:

    ```bash
    sudo apt install php libapache2-mod-php php-common php-pgsql php-xml php-mbstring php-curl php-zip php-intl php-json unzip
    ```
1. Скачайте и распакуйте пакет Joomla:

    {% note info %}

    В примере приведена ссылка на скачивание версии Joomla `5.2.4`, актуальной на момент написания данного руководства. Уточнить наличие более новой версии и получить ссылку на скачивание вы можете на [сайте](https://downloads.joomla.org/) проекта.

    {% endnote %}

    ```bash
    wget https://downloads.joomla.org/cms/joomla5/5-2-4/Joomla_5-2-4-Stable-Full_Package.zip -O Joomla.zip
    sudo rm /var/www/html/index.html
    sudo unzip Joomla.zip -d /var/www/html
    rm Joomla.zip
    ```
1. Настройте разрешения на доступ к директории с сайтом:

    ```
    sudo chown -R www-data:www-data /var/www/html
    sudo chmod -R 755 /var/www/html
    ```
1. Измените номер порта по умолчанию, использующийся Joomla для доступа к базам данных PostgreSQL: в Yandex Managed Service for PostgreSQL используется порт `6432`.

    1. Откройте файл настроек драйверов доступа к базам данных Joomla:

        ```bash
        sudo nano /var/www/html/libraries/vendor/joomla/database/src/Pdo/PdoDriver.php
        ```
    1. Найдите в файле раздел с настройками баз данных PostgreSQL и замените номер порта c `5432` на `6432`:

        ```php
        ...
        case 'pgsql':
        $this->options['port'] = $this->options['port'] ?? 6432;
        ...
        ```

        Не забудьте сохранить внесенные изменения.
1. Настройте виртуальный хост для вашего сайта:

    1. Создайте файл конфигурации виртуального хоста:

        ```bash
        sudo nano /etc/apache2/sites-available/joomla.conf
        ```

    1. Поместите в созданный файл следующую конфигурацию:

        ```text
        <VirtualHost *:80>
            ServerAdmin admin@localhost
            DocumentRoot /var/www/html
            ServerName <имя_домена>

            <Directory /var/www/html>
                Options FollowSymLinks
                AllowOverride All
                Require all granted
            </Directory>

            ErrorLog ${APACHE_LOG_DIR}/joomla_http_error.log
            CustomLog ${APACHE_LOG_DIR}/joomla_http_access.log combined
        </VirtualHost>

        <VirtualHost *:443>
            ServerAdmin admin@localhost
            DocumentRoot /var/www/html
            ServerName <имя_домена>

            ErrorLog ${APACHE_LOG_DIR}/joomla_ssl_error.log
            CustomLog ${APACHE_LOG_DIR}/joomla_ssl_access.log combined

            SSLEngine on
            SSLCertificateFile /etc/ssl-certificates/certificate.pem
            SSLCertificateChainFile /etc/ssl-certificates/certificate.pem
            SSLCertificateKeyFile /etc/ssl-certificates/private_key.pem
        </VirtualHost>
        ```

        Где `<имя_домена>` — доменное имя вашего сайта. Например: `example.com`.
1. Активируйте созданный виртуальный хост и перезапустите веб-сервер:

    ```bash
    sudo a2ensite joomla.conf
    sudo a2enmod rewrite
    sudo a2enmod ssl
    sudo systemctl restart apache2
    ```

## Настройте Joomla {#configure-joomla}

1. Получите имена хостов кластера Managed Service for PostgreSQL, они потребуются в процессе установки Joomla:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
      1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
      1. Выберите кластер `joomla-pg-cluster` и перейдите на вкладку **Хосты**.
      1. Наведите указатель мыши на поле **FQDN хоста** в строке с  каждым из хостов и нажмите значок ![Copy](../../../_assets/console-icons/copy.svg), чтобы скопировать FQDN хоста. Сохраните скопированные значения — они понадобятся позднее.

    {% endlist %}

1. Установите и настройте Joomla:

    1. Откройте в браузере мастер установки и настройки Joomla. На этом этапе он должен быть доступен по любому из адресов:

        * `http://<публичный_IP-адрес_ВМ>`
        * `http://<имя_вашего_домена>`
        * `https://<имя_вашего_домена>`
    1. При настройке параметров базы данных заполните поля:

        * **Тип базы данных** — `PostgreSQL (PDO)`.
        * **Имя хоста**:

            ```text
            <имя_хоста_1>,<имя_хоста_2>,<имя_хоста_3>
            ```

            Где `<имя_хоста_1>`, `<имя_хоста_2>`, `<имя_хоста_3>` — FQDN-имена хостов кластера Managed Service for PostgreSQL, скопированные на предыдущем шаге.
        * **Имя пользователя базы данных** — `joomla`.
        * **Пароль пользователя базы данных** — пароль пользователя БД, заданный при создании кластера PostgreSQL.
        * **Имя базы данных** — `joomla_db`.
        * **Шифрование соединения** — оставьте значение по умолчанию.
    1. В качестве проверки безопасности Joomla может попросить вас создать или удалить определенный тестовый файл в директории установки продукта на ВМ. Перейдите в директорию `/var/www/html/installation/` и создайте или удалите там указанный файл:

        ```text
        Вы пытаетесь использовать хост базы данных, который недоступен на локальном 
        сервере. Вам необходимо подтвердить право собственности на учетную запись 
        на хостинге. Пожалуйста, ознакомьтесь с информацией на странице Защищенная 
        процедура установки Joomla.

        Для подтверждения права собственности на сайт, пожалуйста, удалите файл 
        _JoomlazUZKusLnD2jXi********.txt в каталоге installation и нажмите 
        "Установить Joomla" для продолжения.
        ```
1. После завершения установки удалите директорию `installation` на ВМ. Это требование безопасности Joomla:

    ```bash
    sudo rm -rf /var/www/html/installation
    ```

Если в процессе установки Joomla у вас возникли трудности, воспользуйтесь [инструкцией](https://docs.joomla.org/J4.x:Installing_Joomla) на сайте проекта.

## Проверьте работу сайта {#test-site}

После завершения установки Joomla введите в браузере IP-адрес или доменное имя вашего сайта, чтобы проверить его работу:

* `http://<публичный_IP-адрес_ВМ>`
* `http://example.com`
* `https://example.com`

Теперь вы можете приступить к дальнейшей настройке вашего сайта и наполнению его контентом с помощью административного интерфейса и инструментов Joomla.

## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу сайта и перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `joomla-postgresql-terraform.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    1. В терминале перейдите в директорию с конфигурационным файлом.
    1. Проверьте корректность конфигурации с помощью команды:
    
       ```bash
       terraform validate
       ```
    
       Если конфигурация является корректной, появится сообщение:
    
       ```bash
       Success! The configuration is valid.
       ```
    
    1. Выполните команду:
    
       ```bash
       terraform plan
       ```
    
       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
    1. Примените изменения конфигурации:
    
       ```bash
       terraform apply
       ```
    
    1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

#### Полезные ссылки {#see-also}

* [Создание сайта на CMS Joomla с базой данных PostgreSQL с помощью консоли управления](console.md).