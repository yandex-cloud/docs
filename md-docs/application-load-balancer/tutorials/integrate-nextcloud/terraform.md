# Развертывание Nextcloud на виртуальной машине или в группе виртуальных машин Yandex Compute Cloud в интеграции с Yandex Object Storage с помощью Terraform

В этом руководстве вы подключите [бакет](../../../storage/concepts/bucket.md) Object Storage к решению Nextcloud, развернутому на [виртуальной машине](../../../compute/concepts/vm.md) Compute Cloud с базой данных в [кластере](../../../managed-mysql/concepts/index.md) Yandex Managed Service for MySQL®. Для обеспечения отказоустойчивости и избыточности создаваемой под Nextcloud инфраструктуры вы масштабируете Nextcloud на [группу виртуальных машин](../../../compute/concepts/instance-groups/index.md) с распределением нагрузки при помощи [L7-балансировщика](../../concepts/application-load-balancer.md) Yandex Application Load Balancer. В отказоустойчивой конфигурации Nextcloud будет доступен по доменному имени, для которого в Yandex Certificate Manager будет выпущен [TLS-сертификат](../../../certificate-manager/concepts/managed-certificate.md).

{% note info %}

Для реализации отказоустойчивой конфигурации Nextcloud вам понадобится домен, который будет использоваться L7-балансировщиком.

{% endnote %}

Схема отказоустойчивого решения:

![integrate-nextcloud](../../../_assets/tutorials/integrate-nextcloud/integrate-nextcloud.svg)

Где:
* `example.com` — ваш домен, для которого в Yandex Certificate Manager выпущен [сертификат](../../../certificate-manager/concepts/managed-certificate.md) и который подключен к [L7-балансировщику](../../concepts/application-load-balancer.md) нагрузки.
* `nextcloud-alb` — L7-балансировщик, который равномерно распределяет входящий трафик от пользователей между хостами группы виртуальных машин.
* `nextcloud-instance-group` — [группа виртуальных машин](../../../compute/concepts/instance-groups/index.md), в которую входят хосты с развернутым решением Nextcloud.
* `nextcloud-db-cluster` — [кластер](../../../managed-mysql/concepts/index.md) Yandex Managed Service for MySQL®, в котором расположена служебная база данных Nextcloud.
* `my-nextcloud-bucket` — [бакет](../../../storage/concepts/bucket.md) Yandex Object Storage, подключенный к решению Nextcloud.

Чтобы развернуть Nextcloud в Yandex Cloud с интеграцией бакета Object Storage:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Разверните Nextcloud в базовой конфигурации](#the-basic-variant):
    1. [Создайте инфраструктуру для базовой конфигурации](#create-basic-infrastructure).
    1. [Установите и настройте Nextcloud на виртуальной машине](#setup-nextcloud).
    1. [Протестируйте работу решения в базовой конфигурации](#test-simple).
1. [Разверните Nextcloud в отказоустойчивой конфигурации](#the-redundant-variant):
    1. [Донастройте Nextcloud](#tune-nextcloud).
    1. [Расширьте инфраструктуру для отказоустойчивой конфигурации](#create-failsafe-infrastructure).
    1. [Протестируйте работу решения в отказоустойчивой конфигурации](#test-redundant).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость предлагаемого решения входят: 
* плата за [диски](../../../compute/concepts/disk.md), [снимки дисков](../../../compute/concepts/snapshot.md) и постоянно запущенные [ВМ](../../../compute/concepts/vm.md) ([тарифы Yandex Compute Cloud](../../../compute/pricing.md));
* плата за использование [публичных IP-адресов](../../../vpc/concepts/address.md#public-addresses) и [NAT-шлюзов](../../../vpc/concepts/gateways.md#nat-gateway) ([тарифы Yandex Virtual Private Cloud](../../../vpc/pricing.md));
* плата за [хранение данных](../../../storage/concepts/bucket.md) в Object Storage и [операции](../../../storage/operations/index.md) с ними ([тарифы Yandex Object Storage](../../../storage/pricing.md));
* плата за использование управляемой БД MySQL® ([тарифы Managed Service for MySQL®](../../../managed-mysql/pricing.md));
* при использовании Yandex Cloud DNS плата за [DNS-зоны](../../../dns/concepts/dns-zone.md#public-zones) и публичные DNS-запросы ([тарифы Cloud DNS](../../../dns/pricing.md));
* при использовании балансировщика нагрузки плата за количество ресурсных единиц [L7-балансировщика](../../concepts/application-load-balancer.md) ([тарифы Yandex Application Load Balancer](../../pricing.md));
* при использовании [лог-группы](../../../logging/concepts/log-group.md) для записи логов балансировщика плата за запись и хранение данных ([тарифы Yandex Cloud Logging](../../../logging/pricing.md)).

## Разверните Nextcloud в базовой конфигурации {#the-basic-variant}

Базовая конфигурация Nextcloud будет развернута на одной виртуальной машине, при этом служебная база данных Nextcloud будет создана в кластере Managed Service for MySQL® с одним хостом.

### Создайте инфраструктуру для базовой конфигурации {#create-basic-infrastructure}

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

Для создания инфраструктуры с помощью Terraform:
1. [Установите Terraform](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера Yandex Cloud (раздел [Настройте провайдер](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовая конфигурация {#ready}

      1. Клонируйте репозиторий с конфигурационными файлами.

         ```bash
         git clone https://github.com/yandex-cloud-examples/yc-nextcloud-s3.git
         ```

      1. Перейдите в папку с репозиторием. В ней должны появиться файлы и папки:
          * `nextcloud-integrate-storage-basic-config.tf` — файл конфигурации создаваемой инфраструктуры в базовом варианте.
          * `nextcloud-integrate-storage.auto.tfvars` — файл со значениями пользовательских переменных.
          * `failsafe` — папка, содержащая конфигурацию в отказоустойчивом варианте:
              * `nextcloud-integrate-storage-failsafe-config.tf` — файл конфигурации создаваемой инфраструктуры в отказоустойчивом варианте.

    - Вручную {#manual}

      1. Создайте папку для конфигурационных файлов.
      1. Создайте в папке:

          1. Конфигурационный файл `nextcloud-integrate-storage-basic-config.tf`:

              {% cut "nextcloud-integrate-storage-basic-config.tf" %}

              ```hcl
              # Объявление переменных
              
              variable "folder_id" {
                type = string
              }
              
              variable "bucket_name" {
                type = string
              }
              
              variable "ssh_key_path" {
                type = string
              }
              
              variable "db_password" {
                type = string
                sensitive  = true
              }
              
              variable "domain_name" {
                type = string
              }
              
              locals {
                sa_name             = "nextcloud-sa"
                network_name        = "nextcloud-network"
                subnet_a_name       = "nextcloud-subnet-ru-central1-a"
                subnet-a-cidr       = "192.168.11.0/24"
                sg_name             = "nextcloud-sg"
                gw_name             = "nextcloud-gateway"
                vm_name             = "nextcloud-vm"
                vm_image_id         = "fd8vsghfu10ev5gdatkh"
                ig_name             = "nexcloud-ig"
                cluster_name        = "nextcloud-db-cluster"
                db_name             = "nextcloud"
                db_username         = "user"
              }
              
              # Настройка провайдера
              
              terraform {
                required_providers {
                  yandex = {
                    source = "yandex-cloud/yandex"
                  }
                }
                required_version = ">= 0.13"
              }
              
              provider "yandex" {
                folder_id = var.folder_id
              }
              
              # Создание сети
              
              resource "yandex_vpc_network" "nextcloud-network" {
                name = local.network_name
              }
              
              # Создание NAT-шлюза
              
              resource "yandex_vpc_gateway" "nextcloud-gw" {
                name = local.gw_name
                shared_egress_gateway {}
              }
              
              # Создание таблицы маршрутизации
              
              resource "yandex_vpc_route_table" "nextcloud-rt-table" {
                network_id  = yandex_vpc_network.nextcloud-network.id
              
                static_route {
                  destination_prefix = "0.0.0.0/0"
                  gateway_id         = yandex_vpc_gateway.nextcloud-gw.id
                }
              }
              
              # Создание подсети
              
              resource "yandex_vpc_subnet" "nextcloud-subnet-a" {
                name           = local.subnet_a_name
                zone           = "ru-central1-a"
                network_id     = yandex_vpc_network.nextcloud-network.id
                v4_cidr_blocks = [local.subnet-a-cidr]
                route_table_id = yandex_vpc_route_table.nextcloud-rt-table.id
              }
              
              # Создание группы безопасности
              
              resource "yandex_vpc_security_group" "nextcloud-sg" {
                name        = local.sg_name
                network_id  = yandex_vpc_network.nextcloud-network.id
              
                ingress {
                  protocol       = "TCP"
                  description    = "http"
                  v4_cidr_blocks = ["0.0.0.0/0"]
                  port           = 80
                }
              
                ingress {
                  protocol       = "TCP"
                  description    = "https"
                  v4_cidr_blocks = ["0.0.0.0/0"]
                  port           = 443
                }
              
                ingress {
                  protocol       = "TCP"
                  description    = "ssh"
                  v4_cidr_blocks = ["0.0.0.0/0"]
                  port           = 22
                }
              
                ingress {
                  protocol       = "ANY"
                  description    = "self"
                  predefined_target = "self_security_group"
                  from_port      = 0
                  to_port        = 65535
                }
              
                ingress {
                  protocol       = "ANY"
                  description    = "healthchecks"
                  predefined_target = "loadbalancer_healthchecks"
                  from_port      = 0
                  to_port        = 65535
                }
              
                egress {
                  protocol       = "ANY"
                  description    = "any"
                  v4_cidr_blocks = ["0.0.0.0/0"]
                  from_port      = 0
                  to_port        = 65535
                }
              }
              
              # Создание сервисного аккаунта
              
              resource "yandex_iam_service_account" "nextcloud-sa" {
                name = local.sa_name
              }
              
              # Назначение роли сервисному аккаунту
              
              resource "yandex_resourcemanager_folder_iam_member" "editor" {
                folder_id = var.folder_id
                role      = "editor"
                member    = "serviceAccount:${yandex_iam_service_account.nextcloud-sa.id}"
              }
              
              # Создание статического ключа доступа для СА
              
              resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
                service_account_id = yandex_iam_service_account.nextcloud-sa.id
              }
              
              # Создание бакета
              
              resource "yandex_storage_bucket" "nextcloud-bucket" {
                access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
                secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
                bucket     = var.bucket_name
              }
              
              # Создание загрузочного диска для ВМ
              
              resource "yandex_compute_disk" "boot-disk" {
                type     = "network-ssd"
                zone     = "ru-central1-a"
                size     = "24"
                image_id = local.vm_image_id
              }
              
              # Создание ВМ
              
              resource "yandex_compute_instance" "nextcloud-vm" {
                name        = local.vm_name
                platform_id = "standard-v2"
                zone        = "ru-central1-a"
              
                resources {
                  cores  = "2"
                  memory = "4"
                }
              
                boot_disk {
                  disk_id = yandex_compute_disk.boot-disk.id
                }
              
                network_interface {
                  subnet_id          = yandex_vpc_subnet.nextcloud-subnet-a.id
                  nat                = true
                  security_group_ids = [yandex_vpc_security_group.nextcloud-sg.id]
                }
              
                metadata = {
                  user-data = "#cloud-config\nusers:\n  - name: yc-user\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ${file(var.ssh_key_path)}"
                }
              }
              
              # Создание кластера MySQL
              
              resource "yandex_mdb_mysql_cluster" "nextcloud-cluster" {
                name        = local.cluster_name
                environment = "PRODUCTION"
                network_id  = yandex_vpc_network.nextcloud-network.id
                version     = "8.0"
                security_group_ids = [yandex_vpc_security_group.nextcloud-sg.id]
              
                resources {
                  resource_preset_id = "s2.micro"
                  disk_type_id       = "network-ssd"
                  disk_size          = 10
                }
              
                host {
                  zone      = "ru-central1-a"
                  subnet_id = yandex_vpc_subnet.nextcloud-subnet-a.id
                }
              
                mysql_config = {
                  sql_mode             = "ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"
                  character_set_server = "utf8mb4"
                  collation_server     = "utf8mb4_general_ci"
                }
              }
              
              # Создание базы данных в кластере MySQL
              
              resource "yandex_mdb_mysql_database" "nextcloud-db" {
                cluster_id = yandex_mdb_mysql_cluster.nextcloud-cluster.id
                name       = local.db_name
              }
              
              # Создание пользователя БД в кластере MySQL
              
              resource "yandex_mdb_mysql_user" "my_user" {
                cluster_id = yandex_mdb_mysql_cluster.nextcloud-cluster.id
                name       = local.db_username
                password   = var.db_password
              
                permission {
                  database_name = yandex_mdb_mysql_database.nextcloud-db.name
                  roles         = ["ALL"]
                }
              }
              
              # Вывод данных статического ключа доступа на экран
              
              output "Access_key" {
                value = yandex_iam_service_account_static_access_key.sa-static-key.access_key
              }
              
              output "Secret_key" {
                value = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
                sensitive = true
              }
              ```

              {% endcut %}

          1. Файл с пользовательскими данными `nextcloud-integrate-storage.auto.tfvars`:

              {% cut "nextcloud-integrate-storage.auto.tfvars" %}

              ```hcl
              folder_id     = "<идентификатор_каталога>"
              ssh_key_path  = "<путь_к_публичному_SSH-ключу>"
              bucket_name   = "<имя_бакета>"
              db_password   = "<пароль_пользователя_базы_данных>"
              domain_name   = "<имя_домена>"
              ```

              {% endcut %}

    {% endlist %}

    Подробнее о параметрах используемых ресурсов в Terraform смотрите в документации провайдера:
    * [Сеть](../../../vpc/concepts/network.md#network) — [yandex_vpc_network](../../../terraform/resources/vpc_network.md).
    * [NAT-шлюз](../../../vpc/concepts/gateways.md#nat-gateway) — [yandex_vpc_gateway](../../../terraform/resources/vpc_gateway.md).
    * [Таблица маршрутизации](../../../vpc/concepts/routing.md#rt-vpc) — [yandex_vpc_route_table](../../../terraform/resources/vpc_route_table.md).
    * [Подсеть](../../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet](../../../terraform/resources/vpc_subnet.md).
    * [Группа безопасности](../../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group](../../../terraform/resources/vpc_security_group.md).
    * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account](../../../terraform/resources/iam_service_account.md).
    * [Роль](../../../iam/concepts/access-control/roles.md) — [yandex_resourcemanager_folder_iam_member](../../../terraform/resources/resourcemanager_folder_iam_member.md).
    * [Статический ключ доступа](../../../iam/concepts/authorization/access-key.md) — [yandex_iam_service_account_static_access_key](../../../terraform/resources/iam_service_account_static_access_key.md).
    * [Бакет](../../../storage/concepts/bucket.md) — [yandex_storage_bucket](../../../terraform/resources/storage_bucket.md).
    * [Диск](../../../compute/concepts/disk.md) виртуальной машины — [yandex_compute_disk](../../../terraform/resources/compute_disk.md).
    * [Виртуальная машина](../../../compute/concepts/vm.md) — [yandex_compute_instance](../../../terraform/resources/compute_instance.md).
    * [Кластер Managed Service for MySQL®](../../../managed-mysql/concepts/index.md) — [yandex_mdb_mysql_cluster](../../../terraform/resources/mdb_mysql_cluster.md).
    * База данных MySQL® — [yandex_mdb_mysql_database](../../../terraform/resources/mdb_mysql_database.md).
    * Пользователь базы данных MySQL® — [yandex_mdb_mysql_user](../../../terraform/resources/mdb_mysql_user.md).

1. В файле `nextcloud-integrate-storage.auto.tfvars` задайте значения пользовательских переменных:
    * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
    * `ssh_key_path` — путь к файлу с публичным SSH-ключом. Подробнее в разделе [Создание пары ключей SSH](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
    * `bucket_name` — имя бакета в соответствии с [правилами именования](../../../storage/concepts/bucket.md#naming).
    * `db_password` — пароль пользователя базы данных MySQL®.
    * `domain_name` — имя домена, на котором будет размещен экземпляр Nextcloud.

        Чтобы получить доступ к именам из публичной зоны, вам нужно делегировать домен. Укажите адреса серверов `ns1.yandexcloud.net` и `ns2.yandexcloud.net` в личном кабинете вашего регистратора.

        {% note info %}

        Если вы планируете ограничиться созданием экземпляра Nextcloud в базовой конфигурации и не планируете развертывать отказоустойчивый вариант решения, можете не изменять значение переменной `domain_name`.

        {% endnote %}

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

В результате в выбранном каталоге будет создана вся инфраструктура, необходимая для развертывания Nextcloud в базовой конфигурации.

Terraform выведет на экран идентификатор созданного [статического ключа доступа](../../../iam/concepts/authorization/access-key.md). Это значение понадобится позднее при настройке интеграции Nextcloud с Object Storage. При настройке вам также понадобится секретный ключ. Чтобы получить его, в терминале выполните команду:

```bash
terraform output Secret_key
```

Получив значение секретного ключа, переходите к настройке Nextcloud на виртуальной машине.

### Установите и настройте Nextcloud на виртуальной машине {#setup-nextcloud}

1. Установите Nextcloud на виртуальную машину `nextcloud-vm`:

    1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md#vm-connect) к виртуальной машине `nextcloud-vm` по SSH.

        Для этого в терминале ВМ выполните команду, указав публичный IP-адрес виртуальной машины:

        ```bash
        ssh yc-user@<IP-адрес_ВМ>
        ```

        Узнать публичный IP-адрес виртуальной машины вы можете в [консоли управления](https://console.yandex.cloud) на странице с информацией о ВМ в блоке **Сеть** в поле **Публичный IPv4-адрес**.
    1. Обновите версии пакетов, установленные на ВМ:
       
       ```bash
       sudo apt update && sudo apt upgrade
       ```
    1. Установите необходимые пакеты программного обеспечения и зависимости:
       
       ```bash
       sudo apt install \
         apache2 mariadb-server libapache2-mod-php php-gd php-mysql php-curl php-mbstring \
         php-intl php-gmp php-bcmath php-xml php-imagick php-zip php-fpm unzip
       ```
    1. Скачайте архив с последней версией Nextcloud:
       
       ```bash
       wget https://download.nextcloud.com/server/releases/latest.zip
       ```
    1. Распакуйте скачанный архив в директорию `/var/www`:
       
       ```bash
       sudo unzip latest.zip -d /var/www
       ```
    1. Измените права доступа к директории с Nextcloud:
       
       ```bash
       sudo chown -R www-data:www-data /var/www/nextcloud
       sudo chmod -R 755 /var/www/nextcloud/
       ```
    1. Настройте виртуальный хост по умолчанию:
       
       1. Откройте файл конфигурации виртуального хоста по умолчанию:
       
           ```bash
           sudo nano /etc/apache2/sites-available/000-default.conf
           ```
       1. Замените содержимое открытого файла конфигурации `000-default.conf` на следующее:
       
           ```text
           <VirtualHost *:80>
           DocumentRoot /var/www/nextcloud/
       
           <Directory /var/www/nextcloud/>
           Require all granted
           AllowOverride All
           Options FollowSymLinks MultiViews
       
           <IfModule mod_dav.c>
           Dav off
           </IfModule>
           </Directory>
           </VirtualHost>
           ```
    1. Включите необходимые модули [веб-сервера Apache](https://ru.wikipedia.org/wiki/Apache_HTTP_Server):
       
       ```bash
       sudo a2enmod rewrite
       sudo a2enmod headers
       a2enmod env
       a2enmod dir
       a2enmod mime
       ```
    1. Увеличьте до `512 МБ` объем оперативной памяти, доступной интерпретатору PHP при обработке запросов к Nextcloud:
       
       1. Откройте файл `.htaccess` в директории установки Nextcloud:
       
           ```bash
           sudo nano /var/www/nextcloud/.htaccess
           ```
       1. В конце открытого файла добавьте строку:
       
           ```bash
           php_value memory_limit 512M
           ```
       
           Не забудьте сохранить внесенные изменения.
    1. Перезапустите веб-сервер:
       
       ```bash
       sudo systemctl restart apache2
       ```
1. Настройте Nextcloud в графическом пользовательском интерфейсе:

    1. На вашем локальном компьютере откройте браузер и в адресной строке введите:
       
       ```text
       http://<публичный_IP-адрес_ВМ>
       ```
       
       Узнать публичный IP-адрес виртуальной машины вы можете в [консоли управления](https://console.yandex.cloud) на странице с информацией о ВМ в блоке **Сеть** в поле **Публичный IPv4-адрес**.
    1. В открывшейся форме **Create an admin account**:

        1. В полях **New admin account name** и **New admin password** задайте учетные данные администратора Nextcloud, которые вы будете использовать для входа в систему.
        1. В поле **Database account** введите `user` — имя пользователя БД, созданного в кластере MySQL®.
        1. В поле **Database password** введите пароль пользователя БД, который вы задали в файле `nextcloud-integrate-storage.auto.tfvars`.
        1. В поле **Database name** введите `nextcloud` — имя БД, созданной в кластере MySQL®.
        1. В поле **Database host** укажите [FQDN](../../../glossary/fqdn.md) [текущего хост-мастера](../../../managed-mysql/operations/connect/fqdn.md#fqdn-master) кластера MySQL® и порт в формате:

            ```text
            c-<идентификатор_кластера>.rw.mdb.yandexcloud.net:3306
            ```

            Узнать идентификатор кластера вы можете в [консоли управления](https://console.yandex.cloud) на странице с информацией о кластере в поле **Идентификатор**.
        1. Нажмите кнопку **Install**.

            Начнется развертывание базы данных Nextcloud в кластере MySQL®. Дождитесь завершения этого процесса.
    1. После завершения установки в открывшемся окне с рекомендованными приложениями нажмите кнопку **Skip**. Вы сможете вернуться к установке необходимых приложений позднее.
    1. Закройте открывшееся окно с информацией об обновлениях в текущей версии Nextcloud.
    1. Откройте меню управления приложениями. Для этого в правом верхнем углу экрана нажмите на значок пользователя и в открывшемся контекстном меню выберите ![plus](../../../_assets/console-icons/plus.svg) **Apps**.
    1. В открывшемся окне на панели слева выберите ![person](../../../_assets/console-icons/person.svg) **Your apps**.
    1. В открывшемся списке найдите приложение `External storage support` и в строке с этим приложением нажмите кнопку **Enable**.
       
       При необходимости для подтверждения действия во всплывающем окне введите ваш пароль администратора Nextcloud.
    1. Откройте основное меню настроек. Для этого в правом верхнем углу экрана нажмите на значок пользователя и в открывшемся контекстном меню выберите ![admin-icon](../../../_assets/tutorials/integrate-nextcloud/admin-icon.svg) **Administration settings**.
    1. В открывшемся окне на панели слева в блоке **Administration** выберите ![app-dark-icon](../../../_assets/tutorials/integrate-nextcloud/app-dark-icon.svg) **External storage** и в открывшемся окне в блоке **External storage** задайте настройки интеграции с Object Storage:
       
       1. В секции **External storage** выберите `Amazon S3`.
       1. В секции **Authentication** выберите `Access key`.
       1. В секции **Configuration**:
       
           * В поле **Bucket** укажите имя созданного ранее бакета. Например: `my-nextcloud-bucket`.
           * В поле **Hostname** укажите `storage.yandexcloud.net`.
           * В поле **Port** укажите `443`.
           * В поле **Access key** вставьте полученный ранее идентификатор статического ключа доступа.
           * В поле **Secret key** вставьте полученный ранее секретный ключ статического ключа доступа.
       1. В секции **Available for** включите опцию **All people**.
       1. В правой части редактируемого блока нажмите значок ![check](../../../_assets/console-icons/check.svg), чтобы сохранить изменения.
       
           Для подтверждения действия во всплывающем окне введите ваш пароль администратора Nextcloud.

### Протестируйте работу решения в базовой конфигурации {#test-simple}

Чтобы проверить работу интеграции Yandex Object Storage с Nextcloud на одном хосте:

1. На вашем локальном компьютере откройте браузер и в адресной строке введите публичный IPv4-адрес виртуальной машины, на которой развернут Nextcloud:

    ```text
    http://<публичный_IP-адрес_ВМ>
    ```
1. Аутентифицируйтесь в Nextcloud с помощью логина и пароля, созданных при настройке решения на предыдущем этапе.
1. В левой части верхнего меню выберите ![folder-fill](../../../_assets/console-icons/folder-fill.svg) **Files**.
1. В меню слева выберите **External storage** и выберите **AmazonS3**.
1. Нажмите ![plus](../../../_assets/console-icons/plus.svg) **New** и выберите ![arrow-shape-up-from-line](../../../_assets/console-icons/arrow-shape-up-from-line.svg) **Upload files**, чтобы загрузить в хранилище файл с локального компьютера.
1. Выберите файл на локальном компьютере и загрузите его в хранилище.

    Загруженный файл отобразится в хранилище `AmazonS3` Nextcloud.
1. В сервисе Yandex Object Storage [убедитесь](../../../storage/operations/objects/list.md), что файл был загружен в бакет.

На этом завершено развертывание базовой конфигурации Nextcloud. Теперь вы можете перейти к развертыванию отказоустойчивой конфигурации.

## Разверните Nextcloud в отказоустойчивой конфигурации {#the-redundant-variant}

Отказоустойчивая конфигурация Nextcloud будет развернута в группе из трех виртуальных машин, при этом нагрузка на хосты Nextcloud будет распределяться с помощью L7-балансировщика Yandex Application Load Balancer. Служебная база данных будет расположена в кластере MySQL®, состоящем из трех хостов. Хосты группы ВМ, балансировщика и кластера MySQL® будут равномерно распределены по трем [зонам доступности](../../../overview/concepts/geo-scope.md). Nextcloud будет доступен по доменному имени, для которого в Certificate Manager будет выпущен TLS-сертификат.

### Донастройте Nextcloud {#tune-nextcloud}

Прежде чем приступать к развертыванию отказоустойчивой конфигурации, добавьте ваш домен в список доверенных адресов и доменов Nextcloud:

1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md#vm-connect) к виртуальной машине `nextcloud-vm` по SSH.
1. Добавьте ваш домен в массив доверенных адресов и доменов Nextcloud:
   
   1. В терминале ВМ откройте файл конфигурации Nextcloud:
   
       ```bash
       sudo nano /var/www/nextcloud/config/config.php
       ```
   1. В массиве `trusted_domains` замените IP-адрес хоста на имя вашего домена.
   
       Например:
   
       ```php
       'trusted_domains' =>
       array (
         0 => 'example.com',
       ),
       ```
   
       Массив значений `trusted_domains` позволяет задать ограничение на IP-адреса и/или домены, по которым вы можете обращаться к Nextcloud, и обеспечивает дополнительную защиту от несанкционированного доступа. Вы можете указать несколько адресов и/или доменов, а также ослабить или снять это ограничение с помощью символов подстановки:
   
       {% list tabs %}
   
       - Пример 1
   
         ```php
         'trusted_domains' =>
         array (
           0 => '*.example.com',
           1 => '198.168.*.*',
         ),
         ```
   
         В этом примере доступ разрешается с любых поддоменов домена `example.com`, а также с IP-адресов в диапазоне `192.168.0.0` — `192.168.255.255`.
   
       - Пример 2
   
         ```php
         'trusted_domains' =>
         array (
           0 => '*',
         ),
         ```
   
         В этом примере доступ разрешается с любых доменов и IP-адресов.
   
       {% endlist %}
   1. Удалите строку `'overwrite.cli.url' => 'http://<IP-адрес_ВМ>',`.
   1. Сохраните изменения и закройте редактор `nano`.
1. [Остановите](../../../compute/operations/vm-control/vm-stop-and-start.md#stop) виртуальную машину `nextcloud-vm`.

### Расширьте инфраструктуру для отказоустойчивой конфигурации {#create-failsafe-infrastructure}

1. Подготовьте файлы с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовая конфигурация {#ready}

      1. В папке со скачанным репозиторием удалите файл `nextcloud-integrate-storage-basic-config.tf`.
      1. Из папки `failsafe` переместите файл `nextcloud-integrate-storage-failsafe-config.tf` в корневую папку репозитория — в ту папку, из которой вы только что удалили файл.

    - Вручную {#manual}

      1. В созданной ранее папке для конфигурационных файлов удалите файл `nextcloud-integrate-storage-basic-config.tf`.
      1. Создайте в этой папке новый конфигурационный файл `nextcloud-integrate-storage-failsafe-config.tf`:

          {% cut "nextcloud-integrate-storage-failsafe-config.tf" %}

          ```hcl
          # Объявление переменных
          
          variable "folder_id" {
            type = string
          }
          
          variable "bucket_name" {
            type = string
          }
          
          variable "ssh_key_path" {
            type = string
          }
          
          variable "db_password" {
            type = string
            sensitive  = true
          }
          
          variable "domain_name" {
            type = string
          }
          
          locals {
            sa_name             = "nextcloud-sa"
            network_name        = "nextcloud-network"
            subnet_a_name       = "nextcloud-subnet-ru-central1-a"
            subnet_b_name       = "nextcloud-subnet-ru-central1-b"
            subnet_d_name       = "nextcloud-subnet-ru-central1-d"
            subnet-a-cidr       = "192.168.11.0/24"
            subnet-b-cidr       = "192.168.12.0/24"
            subnet-d-cidr       = "192.168.13.0/24"
            sg_name             = "nextcloud-sg"
            gw_name             = "nextcloud-gateway"
            vm_name             = "nextcloud-vm"
            vm_image_id         = "fd8vsghfu10ev5gdatkh"
            ig_name             = "nextcloud-instance-group"
            cluster_name        = "nextcloud-db-cluster"
            db_name             = "nextcloud"
            db_username         = "user"
            domain_zone_name    = "nexcloud-domain-zone"
            certificate_name    = "mymanagedcert"
            snapshot_name       = "nextcloud-vm-snapshot"
            tg_name             = "nextcloud-target-group"
            backend_name        = "nextcloud-backend"
            bg_name             = "nextcloud-bg"
            http_router_name    = "nextcloud-router"
            vh_name             = "nextcloud-vh"
            route_name          = "nextcloud-route"
            alb_name            = "nextcloud-alb"
            listener_name       = "nextcloud-listener"
          }
          
          # Настройка провайдера
          
          terraform {
            required_providers {
              yandex = {
                source = "yandex-cloud/yandex"
              }
            }
            required_version = ">= 0.13"
          }
          
          provider "yandex" {
            folder_id = var.folder_id
          }
          
          # Создание сети
          
          resource "yandex_vpc_network" "nextcloud-network" {
            name = local.network_name
          }
          
          # Создание NAT-шлюза
          
          resource "yandex_vpc_gateway" "nextcloud-gw" {
            name = local.gw_name
            shared_egress_gateway {}
          }
          
          # Создание таблицы маршрутизации
          
          resource "yandex_vpc_route_table" "nextcloud-rt-table" {
            network_id  = yandex_vpc_network.nextcloud-network.id
          
            static_route {
              destination_prefix = "0.0.0.0/0"
              gateway_id         = yandex_vpc_gateway.nextcloud-gw.id
            }
          }
          
          # Создание подсетей
          
          resource "yandex_vpc_subnet" "nextcloud-subnet-a" {
            name           = local.subnet_a_name
            zone           = "ru-central1-a"
            network_id     = yandex_vpc_network.nextcloud-network.id
            v4_cidr_blocks = [local.subnet-a-cidr]
            route_table_id = yandex_vpc_route_table.nextcloud-rt-table.id
          }
          
          resource "yandex_vpc_subnet" "nextcloud-subnet-b" {
            name           = local.subnet_b_name
            zone           = "ru-central1-b"
            network_id     = yandex_vpc_network.nextcloud-network.id
            v4_cidr_blocks = [local.subnet-b-cidr]
            route_table_id = yandex_vpc_route_table.nextcloud-rt-table.id
          }
          
          resource "yandex_vpc_subnet" "nextcloud-subnet-d" {
            name           = local.subnet_d_name
            zone           = "ru-central1-d"
            network_id     = yandex_vpc_network.nextcloud-network.id
            v4_cidr_blocks = [local.subnet-d-cidr]
            route_table_id = yandex_vpc_route_table.nextcloud-rt-table.id
          }
          
          # Создание группы безопасности
          
          resource "yandex_vpc_security_group" "nextcloud-sg" {
            name        = local.sg_name
            network_id  = yandex_vpc_network.nextcloud-network.id
          
            ingress {
              protocol       = "TCP"
              description    = "http"
              v4_cidr_blocks = ["0.0.0.0/0"]
              port           = 80
            }
          
            ingress {
              protocol       = "TCP"
              description    = "https"
              v4_cidr_blocks = ["0.0.0.0/0"]
              port           = 443
            }
          
            ingress {
              protocol       = "TCP"
              description    = "ssh"
              v4_cidr_blocks = ["0.0.0.0/0"]
              port           = 22
            }
          
            ingress {
              protocol       = "ANY"
              description    = "self"
              predefined_target = "self_security_group"
              from_port      = 0
              to_port        = 65535
            }
          
            ingress {
              protocol       = "ANY"
              description    = "healthchecks"
              predefined_target = "loadbalancer_healthchecks"
              from_port      = 0
              to_port        = 65535
            }
          
            egress {
              protocol       = "ANY"
              description    = "any"
              v4_cidr_blocks = ["0.0.0.0/0"]
              from_port      = 0
              to_port        = 65535
            }
          }
          
          # Создание сервисного аккаунта
          
          resource "yandex_iam_service_account" "nextcloud-sa" {
            name = local.sa_name
          }
          
          # Назначение роли сервисному аккаунту
          
          resource "yandex_resourcemanager_folder_iam_member" "editor" {
            folder_id = var.folder_id
            role      = "editor"
            member    = "serviceAccount:${yandex_iam_service_account.nextcloud-sa.id}"
          }
          
          # Создание статического ключа доступа для СА
          
          resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
            service_account_id = yandex_iam_service_account.nextcloud-sa.id
          }
          
          # Создание бакета
          
          resource "yandex_storage_bucket" "nextcloud-bucket" {
            access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
            secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
            bucket     = var.bucket_name
          }
          
          # Создание загрузочного диска для ВМ
          
          resource "yandex_compute_disk" "boot-disk" {
            type     = "network-ssd"
            zone     = "ru-central1-a"
            size     = "24"
            image_id = local.vm_image_id
          }
          
          # Создание ВМ
          
          resource "yandex_compute_instance" "nextcloud-vm" {
            name        = local.vm_name
            platform_id = "standard-v2"
            zone        = "ru-central1-a"
          
            resources {
              cores  = "2"
              memory = "4"
            }
          
            boot_disk {
              disk_id = yandex_compute_disk.boot-disk.id
            }
          
            network_interface {
              subnet_id          = yandex_vpc_subnet.nextcloud-subnet-a.id
              nat                = true
              security_group_ids = [yandex_vpc_security_group.nextcloud-sg.id]
            }
          
            metadata = {
              user-data = "#cloud-config\nusers:\n  - name: yc-user\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ${file(var.ssh_key_path)}"
            }
          }
          
          # Создание кластера MySQL
          
          resource "yandex_mdb_mysql_cluster" "nextcloud-cluster" {
            name        = local.cluster_name
            environment = "PRODUCTION"
            network_id  = yandex_vpc_network.nextcloud-network.id
            version     = "8.0"
            security_group_ids = [yandex_vpc_security_group.nextcloud-sg.id]
          
            resources {
              resource_preset_id = "s2.micro"
              disk_type_id       = "network-ssd"
              disk_size          = 10
            }
          
            host {
              zone      = "ru-central1-a"
              subnet_id = yandex_vpc_subnet.nextcloud-subnet-a.id
            }
          
            host {
              zone      = "ru-central1-b"
              subnet_id = yandex_vpc_subnet.nextcloud-subnet-b.id
            }
          
            host {
              zone      = "ru-central1-d"
              subnet_id = yandex_vpc_subnet.nextcloud-subnet-d.id
            }
          
            mysql_config = {
              sql_mode             = "ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"
              character_set_server = "utf8mb4"
              collation_server     = "utf8mb4_general_ci"
            }
          }
          
          # Создание базы данных в кластере MySQL
          
          resource "yandex_mdb_mysql_database" "nextcloud-db" {
            cluster_id = yandex_mdb_mysql_cluster.nextcloud-cluster.id
            name       = local.db_name
          }
          
          # Создание пользователя БД в кластере MySQL
          
          resource "yandex_mdb_mysql_user" "my_user" {
            cluster_id = yandex_mdb_mysql_cluster.nextcloud-cluster.id
            name       = local.db_username
            password   = var.db_password
          
            permission {
              database_name = yandex_mdb_mysql_database.nextcloud-db.name
              roles         = ["ALL"]
            }
          }
          
          # Создание снимка диска
          
          resource "yandex_compute_snapshot" "nextcloud-snapshot" {
            name           = local.snapshot_name
            source_disk_id = yandex_compute_disk.boot-disk.id
          }
          
          # Создание публичной DNS-зоны
          
          resource "yandex_dns_zone" "nextcloud-domain-zone" {
            name    = local.domain_zone_name
            zone    = "${var.domain_name}."
            public  = true
          }
          
          # Добавление сертификата Let's Encrypt
          
          resource "yandex_cm_certificate" "nextcloud-certificate" {
            name    = local.certificate_name
            domains = [var.domain_name]
          
            managed {
            challenge_type = "DNS_CNAME"
            challenge_count = 1
            }
          }
          
          # Создание CNAME-записей для валидации доменов при выпуске сертификата
          
          resource "yandex_dns_recordset" "validation-record" {
            count   = yandex_cm_certificate.nextcloud-certificate.managed[0].challenge_count
            zone_id = yandex_dns_zone.nextcloud-domain-zone.id
            name    = yandex_cm_certificate.nextcloud-certificate.challenges[count.index].dns_name
            type    = yandex_cm_certificate.nextcloud-certificate.challenges[count.index].dns_type
            ttl     = 600
            data    = [yandex_cm_certificate.nextcloud-certificate.challenges[count.index].dns_value]
          }
          
          # Ожидание валидации домена и выпуска сертификата Let's Encrypt
          
          data "yandex_cm_certificate" "wait-nextcloud-certificate" {
            depends_on      = [yandex_dns_recordset.validation-record]
            certificate_id  = yandex_cm_certificate.nextcloud-certificate.id
            wait_validation = true
          }
          
          # Создание группы виртуальных машин
          
          resource "yandex_compute_instance_group" "nextcloud-ig" {
            name                = local.ig_name
            service_account_id  = yandex_iam_service_account.nextcloud-sa.id
            instance_template {
              platform_id = "standard-v2"
              resources {
                memory = 4
                cores  = 2
              }
              boot_disk {
                mode = "READ_WRITE"
                initialize_params {
                  snapshot_id = yandex_compute_snapshot.nextcloud-snapshot.id
                  size     = 24
                }
              }
          
              network_interface {
                subnet_ids         = [yandex_vpc_subnet.nextcloud-subnet-a.id,yandex_vpc_subnet.nextcloud-subnet-b.id,yandex_vpc_subnet.nextcloud-subnet-d.id]
                security_group_ids = [yandex_vpc_security_group.nextcloud-sg.id]
              }
          
              metadata = {
                ssh-keys = "yc-user:${file(var.ssh_key_path)}"
              }
            }
          
            scale_policy {
              fixed_scale {
                size = 3
              }
            }
          
            allocation_policy {
              zones = ["ru-central1-a","ru-central1-b","ru-central1-d"]
            }
          
            deploy_policy {
              max_unavailable = 2
              max_expansion   = 1
            }
          
            application_load_balancer {
              target_group_name = local.tg_name
            }
          
            depends_on = [
              yandex_resourcemanager_folder_iam_member.editor
            ]
          }
          
          # Создаем группу бэкендов
          
          resource "yandex_alb_backend_group" "nextcloud-backend-group" {
            name = local.bg_name
          
            session_affinity {
              connection {
                source_ip = true
              }
            }
          
            http_backend {
              name             = local.backend_name
              weight           = 1
              port             = 80
              target_group_ids = [yandex_compute_instance_group.nextcloud-ig.application_load_balancer[0].target_group_id]
              load_balancing_config {
                mode = "MAGLEV_HASH"
              }
            }
          }
          
          # Создаем HTTP-роутер
          
          resource "yandex_alb_http_router" "nextcloud-router" {
            name = local.http_router_name
          }
          
          # Создаем виртуальный хост
          
          resource "yandex_alb_virtual_host" "nextcloud-vhost" {
            name           = local.vh_name
            http_router_id = yandex_alb_http_router.nextcloud-router.id
            route {
              name = local.route_name
              http_route {
                http_route_action {
                  backend_group_id = yandex_alb_backend_group.nextcloud-backend-group.id
                  timeout          = "60s"
                }
              }
            }
          }
          
          # Создаем L7-балансировщик
          
          resource "yandex_alb_load_balancer" "nextcloud-alb" {
            name = local.alb_name
          
            network_id = yandex_vpc_network.nextcloud-network.id
          
            allocation_policy {
              location {
                zone_id   = "ru-central1-a"
                subnet_id = yandex_vpc_subnet.nextcloud-subnet-a.id
              }
              location {
                zone_id   = "ru-central1-b"
                subnet_id = yandex_vpc_subnet.nextcloud-subnet-b.id
              }
              location {
                zone_id   = "ru-central1-d"
                subnet_id = yandex_vpc_subnet.nextcloud-subnet-d.id
              }
            }
          
            security_group_ids = [yandex_vpc_security_group.nextcloud-sg.id]
          
            listener {
              name = local.listener_name
              endpoint {
                address {
                  external_ipv4_address {
                  }
                }
                ports = [443]
              }
          
              tls {
                default_handler {
                  certificate_ids = [data.yandex_cm_certificate.wait-nextcloud-certificate.id]
                  http_handler {
                    http_router_id = yandex_alb_http_router.nextcloud-router.id
                  }
                }
              }
            }
          }
          
          # Создание ресурсной A-записи для L7-балансировщика
          
          resource "yandex_dns_recordset" "nextcloud-a-record" {
            zone_id = yandex_dns_zone.nextcloud-domain-zone.id
            name    = yandex_dns_zone.nextcloud-domain-zone.zone
            type    = "A"
            ttl     = 600
            data    = [yandex_alb_load_balancer.nextcloud-alb.listener[0].endpoint[0].address[0].external_ipv4_address[0].address]
          }
          ```

          {% endcut %}

    {% endlist %}

    Подробнее о параметрах добавляемых ресурсов в Terraform смотрите в документации провайдера:
    * [Снимок диска](../../../compute/concepts/snapshot.md) — [yandex_compute_snapshot](../../../terraform/resources/compute_snapshot.md).
    * [DNS-зона](../../../dns/concepts/dns-zone.md) — [yandex_dns_zone](../../../terraform/resources/dns_zone.md).
    * [TLS-сертификат](../../../certificate-manager/concepts/managed-certificate.md) — [yandex_cm_certificate](../../../terraform/resources/cm_certificate.md).
    * [Ресурсная запись DNS](../../../dns/concepts/resource-record.md) — [yandex_dns_recordset](../../../terraform/resources/dns_recordset.md).
    * [Группа виртуальных машин](../../../compute/concepts/instance-groups/index.md) — [yandex_compute_instance_group](../../../terraform/resources/compute_instance_group.md).
    * [Группа бэкендов](../../concepts/backend-group.md) — [yandex_alb_backend_group](../../../terraform/resources/alb_backend_group.md).
    * [HTTP-роутер](../../concepts/http-router.md) — [yandex_alb_http_router](../../../terraform/resources/alb_http_router.md).
    * [Виртуальный хост](../../concepts/http-router.md#virtual-host) — [yandex_alb_virtual_host](../../../terraform/resources/alb_virtual_host.md).
    * [L7-балансировщик](../../concepts/application-load-balancer.md) — [yandex_alb_load_balancer](../../../terraform/resources/alb_load_balancer.md).

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

В результате в выбранном каталоге будет развернуто решение Nextcloud в отказоустойчивой конфигурации.

### Протестируйте работу решения в отказоустойчивой конфигурации {#test-redundant}

Чтобы проверить работу интеграции Yandex Object Storage с Nextcloud в отказоустойчивой конфигурации:

1. На вашем локальном компьютере откройте браузер и в адресной строке введите имя вашего домена, например:

    ```text
    https://example.com
    ```
1. Аутентифицируйтесь в Nextcloud с помощью логина и пароля, созданных при настройке решения.
1. В левой части верхнего меню выберите ![folder-fill](../../../_assets/console-icons/folder-fill.svg) **Files**.
1. В меню слева выберите **External storage** и выберите **AmazonS3**.
1. Убедитесь, что вы видите загруженный на предыдущем этапе проверки файл.
1. Скачайте загруженный ранее файл. Для этого в строке с именем файла нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![arrow-down](../../../_assets/console-icons/arrow-down.svg) **Download**.
1. Удалите файл. Для этого в строке с именем файла нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **Delete file**.
1. В сервисе Yandex Object Storage [убедитесь](../../../storage/operations/objects/list.md), что файл был удален из бакета.

## Как удалить созданные ресурсы {#clear-out}

{% note warning %}

Прежде чем удалять инфраструктуру, [удалите](../../../storage/operations/objects/delete.md) все объекты в созданном бакете.

{% endnote %}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `nextcloud-integrate-storage-failsafe-config.tf` и удалите описание создаваемой инфраструктуры из файла.
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

* [Развертывание Nextcloud на виртуальной машине Yandex Compute Cloud из образа Container Optimized Image в интеграции с Yandex Object Storage](coi-based.md)
* [Развертывание Nextcloud вручную на виртуальной машине или в группе виртуальных машин Yandex Compute Cloud в интеграции с Yandex Object Storage](fault-tolerant.md)