# Создание сайта на базе «1С-Битрикс» с помощью Terraform

Чтобы создать инфраструктуру для [сайта на базе «1С-Битрикс»](index.md) c помощью Terraform:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Настройте сервер для работы с «1C-Битрикс»](#configure-server).
1. [Настройте «1С-Битрикс»](#configure-bitrix).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

* Виртуальная машина: использование вычислительных ресурсов, хранилища, публичного IP-адреса и операционной системы ([тарифы Compute Cloud](../../../compute/pricing.md)).

* Кластер Managed Service for MySQL®: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы Managed Service for MySQL®](../../pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Virtual Private Cloud](../../../vpc/pricing.md)).

Для данного руководства используется пробная версия «1С-Битрикс» с ознакомительным периодом в 30 дней. Стоимость электронных версий продукта вы можете уточнить на официальном ресурсе [«1С-Битрикс»](https://www.1c-bitrix.ru).

## Создайте инфраструктуру {#deploy}

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

Для создания инфраструктуры c помощью Terraform:

1. [Установите Terraform](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера Yandex Cloud (раздел [Настройте провайдер](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовая конфигурация {#ready}
 
     1. Склонируйте репозиторий с конфигурационными файлами.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-bitrix-website.git
        ```

     1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
        * `bitrix-website.tf` — конфигурация создаваемой инфраструктуры.
        * `bitrix-website.auto.tfvars` — файл с пользовательскими данными.

   - Вручную {#manual}

     1. Создайте папку для конфигурационных файлов.
     1. Создайте в папке:
        1. Конфигурационный файл `bitrix-website.tf`:

           {% cut "bitrix-website.tf" %}

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
           
           variable "mysql_user" {
             type = string
           }
           
           variable "mysql_password" {
             type = string
             sensitive = true
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
             zone = var.folder_id
           }
           
           # Создание облачной сети и подсетей
           
           resource "yandex_vpc_network" "network-1" {
             name = "network1"
           }
           
           resource "yandex_vpc_subnet" "subnet-1" {
             name           = "subnet1"
             zone           = "ru-central1-a"
             network_id     = yandex_vpc_network.network-1.id
             v4_cidr_blocks = ["192.168.1.0/24"]
           }
           
           resource "yandex_vpc_subnet" "subnet-2" {
             name           = "subnet2"
             zone           = "ru-central1-b"
             network_id     = yandex_vpc_network.network-1.id
             v4_cidr_blocks = ["192.168.2.0/24"]
           }
           
           resource "yandex_vpc_subnet" "subnet-3" {
             name           = "subnet3"
             zone           = "ru-central1-d"
             network_id     = yandex_vpc_network.network-1.id
             v4_cidr_blocks = ["192.168.3.0/24"]
           }
           
           # Создание групп безопасности
           
           resource "yandex_vpc_security_group" "sg-vm" {
             name        = "bitrix-sg-vm"
             description = "Description for security group"
             network_id  = yandex_vpc_network.network-1.id
           
             egress {
               protocol       = "ANY"
               description    = "ANY"
               v4_cidr_blocks = ["0.0.0.0/0"]
               from_port      = 0
               to_port        = 65535
             }
           
             ingress {
               protocol       = "TCP"
               description    = "EXT-HTTP"
               v4_cidr_blocks = ["0.0.0.0/0"]
               port           = 80
             }
           
             ingress {
               protocol       = "TCP"
               description    = "EXT-SSH"
               v4_cidr_blocks = ["0.0.0.0/0"]
               port           = 22
             }
           
             ingress {
               protocol       = "TCP"
               description    = "EXT-HTTPS"
               v4_cidr_blocks = ["0.0.0.0/0"]
               port           = 443
             }
           }
           
           resource "yandex_vpc_security_group" "sg-mysql" {
             name        = "bitrix-sg"
             description = "Security group for mysql"
             network_id  = yandex_vpc_network.network-1.id
           
             egress {
               protocol       = "ANY"
               description    = "any"
               v4_cidr_blocks = ["0.0.0.0/0"]
               from_port      = 0
               to_port        = 65535
             }
           
             ingress {
               protocol       = "TCP"
               description    = "ext-msql"
               v4_cidr_blocks = ["0.0.0.0/0"]
               port           = 3306
             }
           }
           
           # Добавление готового образа ВМ
           
           data "yandex_compute_image" "ubuntu-image" {
             family = "ubuntu-2204-lts"
           }
           
           # Создание загрузочного диска
           
           resource "yandex_compute_disk" "boot-disk" {
             name     = "bootdisk"
             type     = "network-ssd"
             zone     = "ru-central1-a"
             size     = "24"
             image_id = data.yandex_compute_image.ubuntu-image.id
           }
           
           # Создание ВМ
           
           resource "yandex_compute_instance" "vm-bitrix" {
             name        = "bitrixwebsite"
             platform_id = "standard-v3"
             zone        = "ru-central1-a"
           
             resources {
               core_fraction = 20
               cores         = 2
               memory        = 4
             }
           
             boot_disk {
               disk_id = yandex_compute_disk.boot-disk.id
             }
           
             network_interface {
               subnet_id          = yandex_vpc_subnet.subnet-1.id
               security_group_ids = ["${yandex_vpc_security_group.sg-vm.id}"]
               nat                = true
             }
           
             metadata = {
                user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("${var.ssh_key_path}")}"
             }
           }
           
           # Создание кластера Managed Service for MySQL
           
           resource "yandex_mdb_mysql_cluster" "bitrix-cluster" {
             name               = "BitrixMySQL"
             environment        = "PRESTABLE"
             network_id         = yandex_vpc_network.network-1.id
             version            = "8.0"
             security_group_ids = ["${yandex_vpc_security_group.sg-mysql.id}"]
           
             resources {
               resource_preset_id = "s2.micro"
               disk_type_id       = "network-hdd"
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
           
           # Создание БД MySQL
           
           resource "yandex_mdb_mysql_database" "bitrix-db" {
             cluster_id = yandex_mdb_mysql_cluster.bitrix-cluster.id
             name       = "db1"
           }
           
           # Создание пользователя БД
           
           resource "yandex_mdb_mysql_user" "bitrix-user" {
             cluster_id = yandex_mdb_mysql_cluster.bitrix-cluster.id
             name       = var.mysql_user
             password   = var.mysql_password
             permission {
               database_name = yandex_mdb_mysql_database.bitrix-db.name
               roles         = ["ALL"]
             }
           }
           ```

           {% endcut %}

        1. Файл с пользовательскими данными `bitrix-website.auto.tfvars`:

           {% cut "bitrix-website.auto.tfvars" %}

           ```hcl
           folder_id      = "<идентификатор_каталога>"
           vm_user        = "<имя_пользователя_ВМ>"
           ssh_key_path   = "<путь_к_файлу_с_открытым_SSH-ключом>"
           mysql_user     = "<имя_пользователя_БД>"
           mysql_password = "<пароль_пользователя_БД>"
           ```

           {% endcut %}

   {% endlist %}

   Подробнее о параметрах используемых ресурсов в Terraform смотрите в документации провайдера:

   * [Сеть](../../../vpc/concepts/network.md#network) — [yandex_vpc_network](../../../terraform/resources/vpc_network.md).
   * [Подсети](../../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet](../../../terraform/resources/vpc_subnet.md).
   * [Группы безопасности](../../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group](../../../terraform/resources/vpc_security_group.md).
   * [Образ](../../../compute/concepts/image.md) — [yandex_compute_image](../../../terraform/resources/compute_image.md).
   * [Диск](../../../compute/concepts/disk.md) — [yandex_compute_disk](../../../terraform/resources/compute_disk.md).
   * [Виртуальная машина](../../../compute/concepts/vm.md) — [yandex_compute_instance](../../../terraform/resources/compute_instance.md).
   * [Кластер MySQL](../../concepts/index.md) — [yandex_mdb_mysql_cluster](../../../terraform/resources/mdb_mysql_cluster.md).
   * База данных — [yandex_mdb_mysql_database](../../../terraform/resources/mdb_mysql_database.md).
   * Пользователь БД — [yandex_mdb_mysql_user](../../../terraform/resources/mdb_mysql_user.md).

1. В файле `bitrix-website.auto.tfvars` задайте пользовательские параметры:
   * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
   * `vm_user` — имя пользователя ВМ.
   * `ssh_key_path` — путь к файлу с открытым SSH-ключом для аутентификации пользователя на ВМ. Подробнее в разделе [Создание пары ключей SSH](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
   * `mysql_user` — имя пользователя для подключения к БД MySQL®. В этом руководстве укажите `user1`.
   * `mysql_password` — пароль пользователя для доступа к БД MySQL®. В этом руководстве укажите значение `p@s$woRd!`.
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

## Настройте сервер для работы с «1C-Битрикс» {#configure-server}

Для настройки сервера для работы с «1С-Битрикс» выполните следующие шаги:
1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md) к ВМ по SSH от имени пользователя, заданного при [создании ВМ](#create-vm) (например, `ubuntu`):

   ```bash
   ssh ubuntu@<публичный_IP-адрес_ВМ>
   ```

   Публичный IP-адрес ВМ можно узнать в [консоли управления](https://console.yandex.cloud) в поле **Публичный IPv4-адрес** блока **Сеть** на странице ВМ.

1. Установите необходимое программное обеспечение:

   {% note info %}

   Следующие команды установки предназначены для Ubuntu. Для других дистрибутивов используйте команды вашего менеджера пакетов.

   {% endnote %}

   ```bash
   sudo apt-get update
   sudo apt-get install -y apache2 libapache2-mod-php php-gd php-mbstring php-mysql
   ```

1. Перейдите в рабочий каталог проекта и скачайте дистрибутив «1С-Битрикс: Управление сайтом»:

   ```bash
   cd /var/www/html/
   sudo wget https://www.1c-bitrix.ru/download/business_encode.tar.gz
   ```

1. Распакуйте полученный архив и после этого удалите ненужные файлы:

   ```bash
   sudo tar -zxf business_encode.tar.gz
   sudo rm -f index.html business_encode.tar.gz
   ```

1. Назначьте пользователя `www-data` владельцем рабочего каталога проекта:

   ```bash
   sudo chown -R www-data:www-data /var/www/html
   ```

   Проверьте права и владельцев рабочего каталога:

   ```bash
   ls -l
   ```

   Результат:

   ```text
   total 40
   drwxrwxr-x 7 www-data www-data  4096 Jun  8  2023 bitrix
   -rwxrwxr-x 1 www-data www-data  1150 Nov 30  2020 favicon.ico
   -rwxrwxr-x 1 www-data www-data  1353 Jun  8  2023 index.php
   -rwxrwxr-x 1 www-data www-data   268 Apr 17  2023 install.config
   -rwxrwxr-x 1 www-data www-data 12821 Mar 18  2022 readme.html
   -rwxrwxr-x 1 www-data www-data   112 Mar 27  2013 readme.php
   drwxrwxr-x 2 www-data www-data  4096 Jun  8  2023 upload
   ```

1. Для корректной работы 1С настройте параметры PHP. Для этого воспользуйтесь встроенным редактором `nano` и отредактируйте следующие переменные в файле конфигурации `php.ini`:

   ```bash
   sudo nano /etc/php/8.1/apache2/php.ini
   ```

   Было | Стало
   :--- | :---
   `short_open_tag = Off` | `short_open_tag = On`
   `memory_limit = 128M` | `memory_limit = 256M`
   `;date.timezone =` | `date.timezone = Europe/Moscow`
   `;opcache.revalidate_freq =2` | `opcache.revalidate_freq =0`
   `;session.save_path = "/var/lib/php/sessions"` | `session.save_path = "/var/lib/php/sessions"`

   Путь к файлу `php.ini` зависит от установленной версии PHP. В примере приведен путь для версии `8.1`. Для версии `8.0` введите `/etc/php/8.0/apache2/php.ini`, для версии `8.2` — `/etc/php/8.2/apache2/php.ini` и т. д.

   {% note tip %}

   Чтобы найти нужный параметр в редакторе `nano` нажмите сочетание клавиш **Ctrl** + **W**. Найдите требуемый параметр из таблицы выше, далее сохраните изменения при помощи сочетания клавиш **Ctrl** + **O**. Выход из редактора **Ctrl** + **X**.

   {% endnote %}

1. Настройте веб-сервер Apache. Для этого отредактируйте файл конфигурации `/etc/apache2/sites-enabled/000-default.conf`.
   1. Откройте файл в текстовом редакторе:

      ```bash
      sudo nano /etc/apache2/sites-enabled/000-default.conf
      ```

   1. После строки `DocumentRoot /var/www/html` добавьте следующий блок и сохраните изменения:

      ```html
      <Directory /var/www/html>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
      </Directory>
      ```

   1. Перезапустите веб-сервер, чтобы все измененные настройки применились:

      ```bash
      sudo systemctl restart apache2
      ```

После выполнения этих команд серверная часть будет сконфигурирована для корректной работы 1С-Битрикс.

## Настройте «1С-Битрикс» {#configure-bitrix}

Установите и настройте «1С-Битрикс»:
1. Откройте веб-интерфейс «1С-Битрикс: Управление сайтом». Для этого в браузере перейдите по адресу `http://<публичный_IP-адрес_ВМ>/`. Должна открыться страница с приглашением установить «1С-Битрикс».
1. Нажмите кнопку **Далее**.

   ![Шаг 1](../../../_assets/tutorials/bitrix-website/bitrix-website1.png)

1. Ознакомьтесь с лицензионным соглашением и выберите **Я принимаю лицензионное соглашение**. Затем нажмите кнопку **Далее**.

   ![Шаг 2](../../../_assets/tutorials/bitrix-website/bitrix-website2.png)

1. Регистрация необязательна, поэтому уберите соответствующую галочку, но оставьте **Установить в кодировке UTF-8** и нажмите кнопку **Далее**.

   ![Шаг 3](../../../_assets/tutorials/bitrix-website/bitrix-website3.png)

1. Система проверит, верно ли сконфигурирован сервер. Просмотрите все параметры на данной странице и нажмите кнопку **Далее**.

   ![Шаг 4](../../../_assets/tutorials/bitrix-website/bitrix-website6.png)

1. Настройте БД:
   1. В поле **Сервер** укажите полное доменное имя созданной вами БД. Чтобы его узнать:
      1. В [консоли управления](https://console.yandex.cloud) перейдите в новой вкладке браузера на страницу каталога.
      1. Перейдите в сервис **Managed Service for&nbsp;MySQL**.
      1. В открывшемся окне выберите созданный ранее кластер `BitrixMySQL`.
      1. В меню слева выберите вкладку **Хосты**.
      1. В поле **FQDN хоста** подведите курсор к имени хоста (вида `rc1c-cfazv1db********`) и скопируйте полное доменное имя базы данных, нажав появившийся значок ![copy](../../../_assets/copy.svg). К имени хоста добавится полное доменное имя, в результате в поле **Сервер** должно быть указано имя вида `rc1c-cfazv1db********.mdb.yandexcloud.net`.
   1. В полях **Имя пользователя** и **Пароль** укажите данные, с которыми вы создавали БД в разделе [Создайте кластер БД MySQL®](#create-mysql).
   1. В поле **Имя базы данных** укажите имя созданной БД (`db1`).
   1. Нажмите кнопку **Далее**.

   ![Шаг 5](../../../_assets/tutorials/bitrix-website/bitrix-website7.png)

1. Дождитесь инициализации БД MySQL®.

   ![Шаг 6](../../../_assets/tutorials/bitrix-website/bitrix-website8.png)

1. Создайте аккаунт администратора, который сможет вносить изменения в вашу систему. Заполните все поля и нажмите кнопку **Далее**.

   ![Шаг 7](../../../_assets/tutorials/bitrix-website/bitrix-website9.png)

1. Выберите шаблон **Информационный портал** и нажмите кнопку **Далее**.

   ![Шаг 8](../../../_assets/tutorials/bitrix-website/bitrix-website10.png)

1. Подтвердите выбор единственного шаблона оформления, нажав кнопку **Далее**.

   ![Шаг 9](../../../_assets/tutorials/bitrix-website/bitrix-website11.png)

1. Выберите цветовое оформление и нажмите кнопку **Далее**.

   ![Шаг 10](../../../_assets/tutorials/bitrix-website/bitrix-website12.png)

1. Заполните все поля в соответствии с требованиями к сайту и нажмите кнопку **Установить**. Начнется установка и настройка всех компонентов системы. Дождитесь ее окончания.

   ![Шаг 11](../../../_assets/tutorials/bitrix-website/bitrix-website13.png)

1. Через некоторое время появится страница, уведомляющая о том, что система установлена и настроена. Для начала работы с сайтом нажмите кнопку **Перейти на сайт**.

   ![Шаг 12](../../../_assets/tutorials/bitrix-website/bitrix-website15.png)

1. Вы открыли веб-интерфейс полностью готовой для дальнейшей эксплуатации системы в режиме редактирования содержимого.

   ![Шаг 13](../../../_assets/tutorials/bitrix-website/bitrix-website16.png)

1. Чтобы увидеть главную страницу сайта глазами пользователя, выйдите из режима администрирования вашим сайтом. Для этого в правом верхнем углу страницы нажмите **Выйти**, затем перейдите по адресу `http://<публичный_IP-адрес_ВМ>/`.
   Чтобы вернуться в режим редактирования, авторизуйтесь на сайте с учетными данными администратора, которые вы указали при настройке «1С-Битрикс».

   ![Шаг 14](../../../_assets/tutorials/bitrix-website/bitrix-website17.png)

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `bitrix-website.tf` и удалите описание создаваемой инфраструктуры из файла.
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

* [Создание сайта на базе «1С-Битрикс» с помощью консоли управления](console.md).