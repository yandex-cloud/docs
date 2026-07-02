[Документация Yandex Cloud](../../../index.md) > [Практические руководства](../../index.md) > Базовая инфраструктура > Отказоустойчивость и масштабирование > [Отказоустойчивый сайт с балансировкой нагрузки через Application Load Balancer](index.md) > Terraform

# Отказоустойчивый сайт с балансировкой нагрузки через Yandex Application Load Balancer с помощью Terraform


Чтобы создать инфраструктуру для [сайта с балансировкой нагрузки](index.md) в трех [зонах доступности](../../../overview/concepts/geo-scope.md) с использованием балансировщика [Application Load Balancer](../../../application-load-balancer/concepts/index.md) c помощью Terraform:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Загрузите файлы веб-сайта](#upload-files).
1. [Протестируйте отказоустойчивость](#test-ha).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:
* плата за постоянно запущенные [ВМ](../../../compute/concepts/vm.md) ([тарифы Yandex Compute Cloud](../../../compute/pricing.md));
* плата за использование динамического [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses) ([тарифы Yandex Virtual Private Cloud](../../../vpc/pricing.md));
* плата за балансировку трафика ([тарифы Application Load Balancer](../../../application-load-balancer/pricing.md));
* плата за публичные [DNS-запросы](../../../glossary/dns.md) и [зоны DNS](../../../dns/concepts/dns-zone.md), если вы используете [Yandex Cloud DNS](../../../dns/index.md) ([тарифы Cloud DNS](../../../dns/pricing.md)).

## Создайте инфраструктуру {#deploy}

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

Чтобы разместить в группе ВМ отказоустойчивый сайт с балансировкой нагрузки через Application Load Balancer с помощью Terraform:
1. [Установите Terraform](../../infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера Yandex Cloud (раздел [Настройте провайдер](../../infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовая конфигурация {#ready}

     1. Склонируйте репозиторий с конфигурационными файлами.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-website-high-availability-with-alb.git
        ```

     1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
        * `application-load-balancer-website.tf` — конфигурация создаваемой инфраструктуры.
        * `application-load-balancer-website.auto.tfvars` — файл с пользовательскими данными.

   - Вручную {#manual}

     1. Создайте папку для конфигурационных файлов.
     1. Создайте в папке:
        1. Конфигурационный файл `application-load-balancer-website.tf`:

           {% cut "application-load-balancer-website.tf" %}

           ```hcl
           # Объявление переменных для конфиденциальных параметров
           
           variable "folder_id" {
             type = string
           }
           
           variable "vm_user" {
             type = string
           }
           
           variable "ssh_key_path" {
             type      = string
             sensitive = true
           }
           
           variable "domain" {
             type      = string
           }
           
           # Добавление прочих переменных
           
           locals {
             sa_name      = "ig-sa"
             network_name = "network1"
             subnet_name1 = "subnet-1"
             subnet_name2 = "subnet-2"
             subnet_name3 = "subnet-3"
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
             zone = "ru-central1-a"
           }
           
           # Создание сервисного аккаунта и назначение прав
           
           resource "yandex_iam_service_account" "ig-sa" {
             name = local.sa_name
           }
           
           resource "yandex_resourcemanager_folder_iam_member" "editor" {
             folder_id = var.folder_id
             role      = "editor"
             member    = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
           }
           
           # Создание облачной сети и подсетей
           
           resource "yandex_vpc_network" "network-1" {
             name = local.network_name
           }
           
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
           
           resource "yandex_vpc_subnet" "subnet-3" {
             name           = local.subnet_name3
             zone           = "ru-central1-d"
             network_id     = yandex_vpc_network.network-1.id
             v4_cidr_blocks = ["192.168.3.0/24"]
           }
           
           # Создание групп безопасности
           
           resource "yandex_vpc_security_group" "alb-sg" {
             name        = "alb-sg"
             network_id  = yandex_vpc_network.network-1.id
           
             egress {
               protocol       = "ANY"
               description    = "any"
               v4_cidr_blocks = ["0.0.0.0/0"]
               from_port      = 1
               to_port        = 65535
             }
           
             ingress {
               protocol       = "TCP"
               description    = "ext-http"
               v4_cidr_blocks = ["0.0.0.0/0"]
               port           = 80
             }
           
             ingress {
               protocol       = "TCP"
               description    = "ext-https"
               v4_cidr_blocks = ["0.0.0.0/0"]
               port           = 443
             }
           
             ingress {
               protocol          = "TCP"
               description       = "healthchecks"
               predefined_target = "loadbalancer_healthchecks"
               port              = 30080
             }
           }
           
           resource "yandex_vpc_security_group" "alb-vm-sg" {
             name        = "alb-vm-sg"
             network_id  = yandex_vpc_network.network-1.id
           
             ingress {
               protocol          = "TCP"
               description       = "balancer"
               security_group_id = yandex_vpc_security_group.alb-sg.id
               port              = 80
             }
           
             ingress {
               protocol       = "TCP"
               description    = "ssh"
               v4_cidr_blocks = ["0.0.0.0/0"]
               port           = 22
             }
           }
           
           # Создание группы ВМ для сайта
           
           resource "yandex_compute_image" "lemp" {
             source_family = "lemp"
           }
           
           resource "yandex_compute_instance_group" "alb-vm-group" {
             name               = "alb-vm-group"
             folder_id          = var.folder_id
             service_account_id = yandex_iam_service_account.ig-sa.id
             instance_template {
               platform_id        = "standard-v2"
               service_account_id = yandex_iam_service_account.ig-sa.id
               resources {
                 core_fraction = 5
                 memory        = 1
                 cores         = 2
               }
           
               boot_disk {
                 mode = "READ_WRITE"
                 initialize_params {
                   image_id = yandex_compute_image.lemp.id
                   type     = "network-hdd"
                   size     = 3
                 }
               }
           
               network_interface {
                 network_id         = yandex_vpc_network.network-1.id
                 subnet_ids         = [yandex_vpc_subnet.subnet-1.id,yandex_vpc_subnet.subnet-2.id,yandex_vpc_subnet.subnet-3.id]
                 nat                = true
                 security_group_ids = [yandex_vpc_security_group.alb-vm-sg.id]
               }
           
               metadata = {
                 user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh_authorized_keys:\n      - ${file("${var.ssh_key_path}")}"
               }
             }
           
             scale_policy {
               fixed_scale {
                 size = 3
               }
             }
           
             allocation_policy {
               zones = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]
             }
           
             deploy_policy {
               max_unavailable = 1
               max_expansion   = 0
             }
           
             application_load_balancer {
               target_group_name = "alb-tg"
             }
           }
           
           # Создание группы бэкендов
           
           resource "yandex_alb_backend_group" "alb-bg" {
             name                     = "alb-bg"
             http_backend {
               name                   = "backend-1"
               port                   = 80
               target_group_ids       = [yandex_compute_instance_group.alb-vm-group.application_load_balancer.0.target_group_id]
               healthcheck {
                 timeout              = "10s"
                 interval             = "2s"
                 healthcheck_port     = 80
                 http_healthcheck {
                   path               = "/"
                 }
               }
             }
           }
           
           # Создание HTTP-роутера и виртуального хоста
           
           resource "yandex_alb_http_router" "alb-router" {
             name   = "alb-router"
           }
           
           resource "yandex_alb_virtual_host" "alb-host" {
             name           = "alb-host"
             http_router_id = yandex_alb_http_router.alb-router.id
             authority      = [var.domain, "www.${var.domain}"]
             route {
               name = "route-1"
               http_route {
                 http_route_action {
                   backend_group_id = yandex_alb_backend_group.alb-bg.id
                 }
               }
             }
           }
           
           # Создание L7-балансировщика
           
           resource "yandex_alb_load_balancer" "alb-1" {
             name               = "alb-1"
             network_id         = yandex_vpc_network.network-1.id
             security_group_ids = [yandex_vpc_security_group.alb-sg.id]
           
             allocation_policy {
               location {
                 zone_id   = "ru-central1-a"
                 subnet_id = yandex_vpc_subnet.subnet-1.id
               }
           
               location {
                 zone_id   = "ru-central1-b"
                 subnet_id = yandex_vpc_subnet.subnet-2.id
               }
           
               location {
                 zone_id   = "ru-central1-d"
                 subnet_id = yandex_vpc_subnet.subnet-3.id
               }
             }
           
             listener {
               name = "alb-listener"
               endpoint {
                 address {
                   external_ipv4_address {
                   }
                 }
                 ports = [ 80 ]
               }
               http {
                 handler {
                   http_router_id = yandex_alb_http_router.alb-router.id
                 }
               }
             }
           }
           
           # Создание DNS-зоны
           
           resource "yandex_dns_zone" "alb-zone" {
             name        = "alb-zone"
             description = "Public zone"
             zone        = "${var.domain}."
             public      = true
           }
           
           # Создание ресурсных записей в DNS-зоне
           
           resource "yandex_dns_recordset" "rs-1" {
             zone_id = yandex_dns_zone.alb-zone.id
             name    = "${var.domain}."
             ttl     = 600
             type    = "A"
             data    = [yandex_alb_load_balancer.alb-1.listener[0].endpoint[0].address[0].external_ipv4_address[0].address]
           }
           
           resource "yandex_dns_recordset" "rs-2" {
             zone_id = yandex_dns_zone.alb-zone.id
             name    = "www"
             ttl     = 600
             type    = "CNAME"
             data    = [ var.domain ]
           }
           ```

           {% endcut %}

        1. Файл с пользовательскими данными `application-load-balancer-website.auto.tfvars`:

           {% cut "application-load-balancer-website.auto.tfvars" %}

           ```hcl
           folder_id    = "<идентификатор_каталога>"
           vm_user      = "<имя_пользователя_ВМ>"
           ssh_key_path = "<путь_к_публичному_SSH-ключу>"
           domain       = "<домен>"
           ```

           {% endcut %}

   {% endlist %}

   Подробнее о параметрах используемых ресурсов в Terraform смотрите в документации провайдера:
   * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account](../../../terraform/resources/iam_service_account.md).
   * [Роль](../../../iam/concepts/access-control/roles.md) — [yandex_resourcemanager_folder_iam_member](../../../terraform/resources/resourcemanager_folder_iam_member.md).
   * [Сеть](../../../vpc/concepts/network.md#network) — [yandex_vpc_network](../../../terraform/resources/vpc_network.md).
   * [Подсети](../../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet](../../../terraform/resources/vpc_subnet.md).
   * [Группы безопасности](../../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group](../../../terraform/resources/vpc_security_group.md).
   * [Образ ВМ](../../../compute/concepts/image.md) — [yandex_compute_image](../../../terraform/resources/compute_image.md).
   * [Группа ВМ](../../../compute/concepts/instance-groups/index.md) — [yandex_compute_instance_group](../../../terraform/resources/compute_instance_group.md).
   * [Группа бэкендов](../../../application-load-balancer/concepts/backend-group.md) — [yandex_alb_backend_group](../../../terraform/resources/alb_backend_group.md).
   * [HTTP-роутер](../../../application-load-balancer/concepts/http-router.md) — [yandex_alb_http_router](../../../terraform/resources/alb_http_router.md).
   * [Виртуальный хост](../../../application-load-balancer/concepts/http-router.md#virtual-host) — [yandex_alb_virtual_host](../../../terraform/resources/alb_virtual_host.md).
   * [L7-балансировщик](../../../application-load-balancer/concepts/application-load-balancer.md) — [yandex_alb_load_balancer](../../../terraform/resources/alb_load_balancer.md).
   * [DNS-зона](../../../dns/concepts/dns-zone.md) — [yandex_dns_zone](../../../terraform/resources/dns_zone.md).
   * [Ресурсная запись DNS](../../../dns/concepts/resource-record.md) — [yandex_dns_recordset](../../../terraform/resources/dns_recordset.md).

1. В файле `application-load-balancer-website.auto.tfvars` задайте пользовательские параметры:
    * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
    * `vm_user` — имя пользователя ВМ.
    * `ssh_key_path` — путь к файлу с открытым SSH-ключом для аутентификации пользователя на ВМ. Подробнее в разделе [Создание пары ключей SSH](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
    * `domain` — название домена, например `alb-example.com`.

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

После создания инфраструктуры, [загрузите файлы веб-сайта](#upload-files).

## Загрузите файлы веб-сайта {#upload-files}

Чтобы проверить работу веб-сервера, необходимо загрузить файлы сайта на каждую ВМ. Для примера вы можете использовать файл `index.html` из [архива](https://storage.yandexcloud.net/doc-files/index.html.zip).

Для каждой ВМ в [созданной группе](#create-vms) выполните следующее:
1. На вкладке **Виртуальные машины** нажмите на имя нужной ВМ в списке.
1. Скопируйте **Публичный IPv4-адрес** из блока **Сеть**.
1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ по протоколу SSH.
1. Выдайте права на запись для вашего пользователя на директорию `/var/www/html`:

   ```bash
   sudo chown -R "$USER":www-data /var/www/html
   ```

1. Загрузите на ВМ файлы сайта с помощью [протокола SCP](https://ru.wikipedia.org/wiki/SCP).

   {% list tabs group=operating_system %}

   - Linux/macOS {#linux-macos}

     Используйте утилиту командной строки `scp`:

     ```bash
     scp -r <путь_до_директории_с-файлами> <имя_пользователя_ВМ>@<IP-адрес_ВМ>:/var/www/html
     ```

   - Windows {#windows}

     С помощью программы [WinSCP](https://winscp.net/eng/download.php) скопируйте локальную директорию с файлами в директорию `/var/www/html` на ВМ.

   {% endlist %}

## Протестируйте отказоустойчивость {#test-ha}

1. Откройте [консоль управления](https://console.yandex.cloud).
1. Перейдите в сервис **Compute Cloud**.
1. Перейдите на страницу ВМ из созданной ранее группы.
1. Скопируйте **Публичный IPv4-адрес** из блока **Сеть**.
1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ по протоколу SSH.
1. Остановите веб-сервис, чтобы сымитировать сбой в работе веб-сервера:

   ```bash
   sudo service nginx stop
   ```

1. Откройте ваш сайт в браузере. Несмотря на сбой в работе одного из веб-серверов, сайт должен успешно открыться.
1. После завершения проверки запустите веб-сервис:

   ```bash
   sudo service nginx start
   ```

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `application-load-balancer-website.tf` и удалите описание создаваемой инфраструктуры из файла.
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

* [Отказоустойчивый сайт с балансировкой нагрузки через Yandex Application Load Balancer с помощью консоли управления](console.md)