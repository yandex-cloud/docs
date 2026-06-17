# Создание интернет-магазина на платформе OpenCart с помощью Terraform

Чтобы создать инфраструктуру для [интернет-магазина на платформе OpenCart](index.md) с помощью Terraform:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Настройте OpenCart](#configure-opencart).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

* Виртуальная машина: использование вычислительных ресурсов, хранилища, публичного IP-адреса и операционной системы ([тарифы Compute Cloud](../../pricing.md)).
* Кластер Managed Service for MySQL®, если он создан для поддержки и обслуживания СУБД: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы Managed Service for MySQL®](../../../managed-mysql/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Virtual Private Cloud](../../../vpc/pricing.md)).

## Создайте инфраструктуру{#deploy}

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

Чтобы разместить интернет-магазин на OpenCart с помощью Terraform:

1. [Установите Terraform](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера Yandex Cloud (раздел [Настройте провайдер](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).

1. Подготовьте файлы с описанием инфраструктуры:

    {% list tabs %}

    - Готовая конфигурация

      1. Клонируйте репозиторий с конфигурационными файлами:

          ```bash
          git clone https://github.com/yandex-cloud-examples/yc-opencart-store.git
          ```

      1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
          * `opencart.tf` — конфигурация создаваемой инфраструктуры;
          * `opencart.auto.tfvars` — файл с пользовательскими данными.

    - Создание вручную

       1. Создайте папку для конфигурационных файлов.

       1. Создайте в папке:

           1. Конфигурационный файл `opencart.tf`:

               {% cut "opencart.tf" %}

               ```hcl
               # Объявление переменных для конфиденциальных параметров
               
               variable "folder_id" {
                 type = string
               }
               
               variable "vm_user" {
                 type = string
               }
               
               variable "ssh_key_path" {
                 type = string
               }
               
               variable "db_user" {
                 type = string
               }
               
               variable "db_password" {
                 type      = string
                 sensitive = true
               }
               
               # Добавление прочих переменных
               
               locals {
                 network_name = "network-1"
                 subnet_name1 = "subnet-1"
                 subnet_name2 = "subnet-2"
                 sg_db_name   = "opencart-sg"
                 sg_vm_name   = "opencart-sg-vm"
                 vm_name      = "opencart"
                 cluster_name = "opencart"
                 db_name      = "db1"
               }
               
               # Настройка провайдера
               
               terraform {
                 required_providers {
                   yandex = {
                     source  = "yandex-cloud/yandex"
                     version = ">= 0.47.0"
                   }
                 }
               }
               
               provider "yandex" {
                 folder_id = var.folder_id
               }
               
               # Создание облачной сети
               
               resource "yandex_vpc_network" "network-1" {
                 name = local.network_name
               }
               
               # Создание подсетей
               
               resource "yandex_vpc_subnet" "subnet-1" {
                 name           = local.subnet_name1
                 zone           = "ru-central1-a"
                 network_id     = yandex_vpc_network.network-1.id
                 v4_cidr_blocks = ["192.168.1.0/24"]
               }
               
               resource "yandex_vpc_subnet" "subnet-2" {
                 name           = local.subnet_name2
                 zone           = "ru-central1-b"
                 network_id     = yandex_vpc_network.network-1.id
                 v4_cidr_blocks = ["192.168.2.0/24"]
               }
               
               # Создание групп безопасности
               
               resource "yandex_vpc_security_group" "opencart-sg" {
                 name       = local.sg_db_name
                 network_id = yandex_vpc_network.network-1.id
               
                 egress {
                   protocol       = "ANY"
                   description    = "any"
                   v4_cidr_blocks = ["0.0.0.0/0"]
                 }
               
                 ingress {
                   protocol       = "TCP"
                   description    = "ext-https"
                   v4_cidr_blocks = ["0.0.0.0/0"]
                   port           = 3306
                 }
               }
               
               resource "yandex_vpc_security_group" "opencart-sg-vm" {
                 name       = local.sg_vm_name
                 network_id = yandex_vpc_network.network-1.id
               
                 egress {
                   protocol       = "ANY"
                   description    = "any"
                   v4_cidr_blocks = ["0.0.0.0/0"]
                   from_port      = 0
                   to_port        = 65535
                 }
               
                 ingress {
                   description    = "HTTP"
                   protocol       = "TCP"
                   v4_cidr_blocks = ["0.0.0.0/0"]
                   port           = 80
                 }
               
                 ingress {
                   protocol       = "TCP"
                   description    = "ssh"
                   v4_cidr_blocks = ["0.0.0.0/0"]
                   port           = 22
                 }
               
                 ingress {
                   protocol       = "TCP"
                   description    = "ext-https"
                   v4_cidr_blocks = ["0.0.0.0/0"]
                   port           = 443
                 }
               }
               
               # Указание готового образа ВМ
               
               resource "yandex_compute_image" "opencart-image" {
                 source_family = "opencart"
               }
               
               # Создание ВМ
               
               resource "yandex_compute_instance" "opencart" {
                 name        = "opencart"
                 platform_id = "standard-v3"
                 zone        = "ru-central1-a"
               
                 resources {
                   core_fraction = 20
                   cores         = 2
                   memory        = 4
                 }
               
                 boot_disk {
                   initialize_params {
                     image_id = yandex_compute_image.opencart-image.id
                     type     = "network-ssd"
                     size     = "13"
                   }
                 }
               
                 network_interface {
                   subnet_id          = yandex_vpc_subnet.subnet-1.id
                   security_group_ids = [yandex_vpc_security_group.opencart-sg-vm.id]
                   nat                = true
                 }
               
                 metadata = {
                   user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh_authorized_keys:\n      - ${file("${var.ssh_key_path}")}"
                 }
               }
               
               # Создание кластера MySQL®
               # Если необходимости в кластере нет, удалите блок кода с созданием кластера, БД и пользователя  MySQL®
               
               resource "yandex_mdb_mysql_cluster" "opencart-mysql" {
                 name               = local.cluster_name
                 environment        = "PRODUCTION"
                 network_id         = yandex_vpc_network.network-1.id
                 version            = "8.0"
                 security_group_ids = [yandex_vpc_security_group.opencart-sg.id]
               
                 resources {
                   resource_preset_id = "s2.micro"
                   disk_type_id       = "network-ssd"
                   disk_size          = "10"
                 }
               
                 host {
                   zone             = "ru-central1-a"
                   subnet_id        = yandex_vpc_subnet.subnet-1.id
                   assign_public_ip = false
                 }
               
                 host {
                   zone             = "ru-central1-b"
                   subnet_id        = yandex_vpc_subnet.subnet-2.id
                   assign_public_ip = false
                 }
               }
               
               # Создание базы данных для MySQL®
               
               
               resource "yandex_mdb_mysql_database" "db1" {
                 cluster_id = yandex_mdb_mysql_cluster.opencart-mysql.id
                 name       = local.db_name
               }
               
               # Создание пользователя для MySQL®
               
               resource "yandex_mdb_mysql_user" "user1" {
                 cluster_id = yandex_mdb_mysql_cluster.opencart-mysql.id
                 name       = var.db_user
                 password   = var.db_password
                 permission {
                   database_name = yandex_mdb_mysql_database.db1.name
                   roles         = ["ALL"]
                 }
               }
               ```

               {% endcut %}

           1. Файл с пользовательскими данными `opencart.auto.tfvars`:

               {% cut "opencart.auto.tfvars" %}

               ```hcl
               folder_id    = "<идентификатор_каталога>"
               vm_user      = "<имя_пользователя_ВМ>"
               ssh_key_path = "<путь_к_публичному_SSH-ключу>"
               db_user      = "<имя_пользователя_БД>"
               db_password  = "<пароль_для_доступа_к_БД>"
               ```

               {% endcut %}

    {% endlist %}

    Более подробную информацию о параметрах используемых ресурсов в Terraform см. в документации провайдера:

    * [Сеть](../../../vpc/concepts/network.md#network) — [yandex_vpc_network](../../../terraform/resources/vpc_network.md)
    * [Подсети](../../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet](../../../terraform/resources/vpc_subnet.md)
    * [Группы безопасности](../../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group](../../../terraform/resources/vpc_security_group.md)
    * [Образ ВМ](../../concepts/image.md) — [yandex_compute_image](../../../terraform/resources/compute_image.md)
    * [Виртуальная машина](../../concepts/vm.md) — [yandex_compute_instance](../../../terraform/resources/compute_instance.md)
    * [Кластер MySQL®](../../../managed-mysql/concepts/index.md) — [yandex_mdb_mysql_cluster](../../../terraform/resources/mdb_mysql_cluster.md)
    * База данных MySQL® — [yandex_mdb_mysql_database](../../../terraform/resources/mdb_mysql_database.md)
    * Пользователь MySQL® — [yandex_mdb_mysql_user](../../../terraform/resources/mdb_mysql_user.md)

1. В файле `opencart.auto.tfvars` задайте пользовательские параметры:

    * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
    * `vm_user` — имя пользователя ВМ.
    * `ssh_key_path` — путь к файлу с открытым SSH-ключом для аутентификации пользователя на ВМ. Подробнее см. [Создание пары ключей SSH](../../operations/vm-connect/ssh.md#creating-ssh-keys).
    * `db_user` — имя пользователя БД, например `user1`.
    * `db_password` — пароль для доступа к БД. Длина пароля должна составлять от 8 до 128 символов.

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

1. [Получите публичный IP-адрес ВМ](../../operations/instance-groups/get-info.md) — он потребуется далее, чтобы [настроить OpenCart](#configure-opencart).

После создания инфраструктуры, [настройте OpenCart](#configure-opencart).

## Настройте OpenCart {#configure-opencart}

1. Откройте веб-интерфейс интернет-магазина OpenCart. Для этого откройте в браузере адрес `http://<публичный_IP-адрес_ВМ>/`. Откроется страница настройки OpenCart.
1. Ознакомьтесь с лицензией и нажмите **Continue**.

   ![Шаг 1](../../../_assets/tutorials/opencart/opencart1.png)

1. Убедитесь, что все строки с требованиями к системе отмечены зелеными галочками, и нажмите кнопку **Continue**.

   ![Шаг 2](../../../_assets/tutorials/opencart/opencart2.png)

1. Настройте доступ к БД:

   {% list tabs %}

   - Локальный сервер MySQL®

     Атрибуты подключения к БД генерируются в специальном файле при создании ВМ:
     1. Зайдите по SSH на созданную ВМ.
     1. Перейдите в режим администратора `sudo -i`.
     1. Откройте файл `default_passwords.txt` в домашней директории администратора:

        ```bash
        root@opencart:~# cat default_passwords.txt
        MYSQL_USER=opencart
        MYSQL_PASS=qDbvN1R6tA6ET
        MYSQL_ROOT_PASS=5DiVb80l1kXVz
        MYSQL_DB=opencart
        ```

     1. На странице настройки OpenCart в секции БД, введите соответствующие данные:
        * **Username** — значение переменной `MYSQL_USER`.
        * **Database** — значение переменной `MYSQL_DB`.
        * **Password** — значение переменной `MYSQL_PASS`.

        Остальные поля оставьте без изменения.

   - Кластер Managed Service for MySQL®

     Если вы используете кластер Managed Service for MySQL®, введите нужные атрибуты кластера:
     * **Hostname** — укажите [полное доменное имя (FQDN)](../../concepts/network.md#hostname) созданной БД. Чтобы его узнать:
       1. Перейдите в новой вкладке браузера на страницу каталога в [консоли управления](https://console.yandex.cloud).
       1. Выберите раздел **Managed Service for MySQL®**.
       1. В таблице выберите созданный вами кластер.
       1. В меню слева выберите вкладку **Хосты**.
       1. Подведите курсор к полю **Имя хоста** (например, `rc1c-vok617m35g3dj23i`) и скопируйте полное доменное имя БД, нажав на значок ![copy](../../../_assets/console-icons/copy.svg).
     * **Username** — имя пользователя (в примере `user1`).
     * **Database** — имя БД (в примере `db1`).
     * **Password** — указанный вами пароль пользователя.

     Остальные поля оставьте без изменения.

   {% endlist %}

1. Задайте имя администратора, его пароль и актуальный электронный адрес. После этого нажмите кнопку **Continue**.

   ![Шаг 3](../../../_assets/tutorials/opencart/opencart3.png)

1. Откроется страница с уведомлением о том, что система настроена. Чтобы настроить интернет-магазин, нажмите кнопку **Login to your administration** и введите логин и пароль администратора.

   ![Шаг 4](../../../_assets/tutorials/opencart/opencart4.png)

1. После завершения установки зайдите на ВМ по SSH и удалите ненужные установочные файлы:

   ```bash
   user@opencart:~$ sudo -i
   root@opencart:~# rm -rf /var/www/opencart/install/
   ```

1. Чтобы проверить главную страницу сайта, перейдите по адресу `http://<публичный_IP-адрес_ВМ>/`. Вы увидите главную страницу сайта глазами пользователя, посетившего ваш интернет-магазин.

   ![Шаг 5](../../../_assets/tutorials/opencart/opencart5.png)

## Удалите созданные ресурсы {#clear-out}

Как удалить созданные ресурсы:

1. Откройте конфигурационный файл `opencart.tf` и удалите описание создаваемой инфраструктуры из файла.
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

* [Создание интернет-магазина на платформе OpenCart с помощью консоли управления](console.md).