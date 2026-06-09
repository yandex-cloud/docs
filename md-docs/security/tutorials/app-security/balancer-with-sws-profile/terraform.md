# Создание L7-балансировщика {{ alb-name }} с профилем безопасности {{ sws-name }} с помощью {{ TF }}

Чтобы создать [L7-балансировщик с профилем безопасности {{ sws-name }}](index.md) с помощью {{ TF }}:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Протестируйте работу профиля безопасности](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../../billing/quickstart/index.md) и [привяжите](../../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для L7-балансировщика с профилем безопасности {{ sws-name }} входят:
* плата за постоянно запущенные [ВМ](../../../../compute/concepts/vm.md) (см. [тарифы {{ compute-full-name }}](../../../../compute/pricing.md));
* плата за использование вычислительных ресурсов [L7-балансировщика](../../../../application-load-balancer/concepts/index.md) (см. [тарифы {{ alb-name }}](../../../../application-load-balancer/pricing.md));
* плата за запросы, обработанные правилами [профиля безопасности](../../../../smartwebsecurity/concepts/profiles.md) (см. [тарифы {{ sws-full-name }}](../../../../smartwebsecurity/pricing.md)).

## Создайте инфраструктуру {#deploy}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

Для создания инфраструктуры с помощью {{ TF }}:
1. [Установите {{ TF }}](../../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовая конфигурация {#ready}

     1. Клонируйте репозиторий с конфигурационными файлами.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-alb-with-sws-profile.git
        ```

     1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
        * `alb-smartwebsecurity-config.tf` — конфигурация создаваемой инфраструктуры.
        * `alb-smartwebsecurity.auto.tfvars` — файл с пользовательскими данными.

   - Вручную {#manual}

     1. Создайте папку для конфигурационных файлов.
     1. Создайте в папке:
        1. Конфигурационный файл `alb-smartwebsecurity-config.tf`:

           {% cut "alb-smartwebsecurity-config.tf" %}

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
           
           variable "allowed_ip" {
             type = string
           }
           
           # Добавление прочих переменных
           
           locals {
             zone               = "{{ region-id }}-a"
             network_name       = "web-network"
             subnet_name        = "subnet1"
             sg_vm_name         = "sg-web"
             vm_name            = "test-vm1"
             vm_image_family    = "lemp"
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
           
           # Создание подсети
           
           resource "yandex_vpc_subnet" "subnet-1" {
             name           = local.subnet_name
             v4_cidr_blocks = ["192.168.1.0/24"]
             zone           = local.zone
             network_id     = yandex_vpc_network.network-1.id
           }
           
           # Создание группы безопасности
           
           resource "yandex_vpc_security_group" "sg-1" {
             name        = local.sg_vm_name
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
           
           # Добавление готового образа ВМ
           
           resource "yandex_compute_image" "lamp-vm-image" {
             source_family = local.vm_image_family
           }
           
           resource "yandex_compute_disk" "boot-disk" {
             name     = "bootvmdisk"
             type     = "network-hdd"
             zone     = local.zone
             size     = "20"
             image_id = yandex_compute_image.lamp-vm-image.id
           }
           
           # Создание ВМ
           
           resource "yandex_compute_instance" "vm" {
             name        = local.vm_name
             platform_id = "standard-v3"
             zone        = local.zone
             resources {
               core_fraction = 20
               cores         = 2
               memory        = 1
             }
             boot_disk {
               disk_id = yandex_compute_disk.boot-disk.id
             }
             network_interface {
               subnet_id          = yandex_vpc_subnet.subnet-1.id
               nat                = true
               security_group_ids = [yandex_vpc_security_group.sg-1.id]
             }
             metadata = {
               user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("${var.ssh_key_path}")}"
             }
           }
           
           # Создание профиля безопасности
           
           resource "yandex_sws_security_profile" "demo-profile-simple" {
             name           = "test-profile"
             default_action = "DENY"
             
             # Правило Smart Protection с полной защитой
             security_rule {
               name     = "smart-protection"
               priority = 999900
           
               smart_protection {
                 mode = "FULL"
               }
             }
           
             # Базовое правило, пропускает трафик с указанного IP-адреса без проверки правилом Smart Protection
             security_rule {
               name     = "my-rule"
               priority = 999800
           
               rule_condition {
                 action = "ALLOW"
                 condition {
                   source_ip {
                     ip_ranges_match {
                       ip_ranges = [var.allowed_ip]
           
                     }
                   }
                 }
               }
             }
           }
           
           # Создание целевой группы
           
           resource "yandex_alb_target_group" "foo" {
             name           = "test-target-group"
           
             target {
               subnet_id    = yandex_vpc_subnet.subnet-1.id
               ip_address   = yandex_compute_instance.vm.network_interface.0.ip_address
             }
           }
           
           # Создание группы бэкендов
           
           resource "yandex_alb_backend_group" "alb-bg" {
             name                     = "test-backend-group"
           
             http_backend {
               name                   = "backend-1"
               port                   = 80
               target_group_ids       = [yandex_alb_target_group.foo.id]
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
           
           # Создание HTTP-роутера
           
           resource "yandex_alb_http_router" "alb-router" {
             name   = "test-http-router"
           }
           
           resource "yandex_alb_virtual_host" "alb-host" {
             name           = "test-virtual-host"
             http_router_id = yandex_alb_http_router.alb-router.id
             authority      = ["*"]
             route {
               name = "route-1"
               http_route {
                 http_route_action {
                   backend_group_id = yandex_alb_backend_group.alb-bg.id
                 }
               }
             }
             route_options {
               security_profile_id   = yandex_sws_security_profile.demo-profile-simple.id
             }
           }
           
           
           # Создание L7-балансировщика
           
           resource "yandex_alb_load_balancer" "sws-balancer" {
             name               = "test-load-balancer"
             network_id         = yandex_vpc_network.network-1.id
             security_group_ids = [yandex_vpc_security_group.sg-1.id]
           
             allocation_policy {
               location {
                 zone_id   = local.zone
                 subnet_id = yandex_vpc_subnet.subnet-1.id
               }
             }
           
             listener {
               name = "listener"
               endpoint {
                 address {
                   external_ipv4_address {
                   }
                 }
                 ports = [80]
               }
               http {
                 handler {
                   http_router_id = yandex_alb_http_router.alb-router.id
                 }
               }
             }
           }
           ```

           {% endcut %}

        1. Файл с пользовательскими данными `alb-smartwebsecurity.auto.tfvars`:

           {% cut "alb-smartwebsecurity.auto.tfvars" %}

           ```hcl
           folder_id    = "<идентификатор_каталога>"
           vm_user      = "<имя_пользователя_ВМ>"
           ssh_key_path = "<путь_к_публичному_SSH-ключу>"
           allowed_ip   = "<разрешенный_IP-адрес_устройства>"
           ```
           {% endcut %}

   {% endlist %}

   Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:
   * [Сеть](../../../../vpc/concepts/network.md#network) — [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
   * [Подсети](../../../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
   * [Группы безопасности](../../../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
   * [Образ ВМ](../../../../compute/concepts/image.md) — [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image).
   * [Группа бэкендов](../../../../application-load-balancer/concepts/backend-group.md) — [yandex_alb_backend_group]({{ tf-provider-resources-link }}/alb_backend_group).
   * [HTTP-роутер](../../../../application-load-balancer/concepts/http-router.md) — [yandex_alb_http_router]({{ tf-provider-resources-link }}/alb_http_router).
   * [Виртуальный хост](../../../../application-load-balancer/concepts/http-router.md#virtual-host) — [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).
   * [L7-балансировщик](../../../../application-load-balancer/concepts/application-load-balancer.md) — [yandex_alb_load_balancer]({{ tf-provider-resources-link }}/alb_load_balancer).
   * [Профиль безопасности](../../../../smartwebsecurity/concepts/profiles.md) — [yandex_sws_security_profile]({{ tf-provider-resources-link }}/sws_security_profile).

1. В файле `alb-smartwebsecurity.auto.tfvars` задайте пользовательские параметры:
   * `folder_id` — [идентификатор каталога](../../../../resource-manager/operations/folder/get-id.md).
   * `vm_user` — имя пользователя ВМ.
   * `ssh_key_path` — путь к файлу с публичным SSH-ключом. Подробнее см. [{#T}](../../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
   * `allowed_ip` — публичный IP-адрес устройства, с которого вы будете отправлять запросы L7-балансировщику.

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
   
      В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
   1. Примените изменения конфигурации:
   
      ```bash
      terraform apply
      ```
   
   1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

1. [Получите IP-адрес](../../../../application-load-balancer/operations/application-load-balancer-get.md) L7-балансировщика — он потребуется далее, чтобы [проверить работу профиля безопасности](#test).

После создания инфраструктуры проверьте работу профиля безопасности (#test).

## Протестируйте работу профиля безопасности {#test}

1. Откройте терминал устройства, IP-адрес которого вы указали в разрешающем правиле.
1. Отправьте запрос на бэкенд тестового приложения:

    ```bash
    curl --verbose <публичный_IP-адрес_L7-балансировщика>
    ```

    В результате должно быть выведено содержимое директории с тестовым веб-сервером.

1. Повторите запрос с другого IP-адреса. В результате должно быть выведено сообщение о невозможности установить соединение с сервером.

{% note info %}

Проверка правил Smart Protection не проводится. При такой проверке параметры подозрительных запросов, в том числе IP-адреса, заносятся в черный список.

{% endnote %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `alb-smartwebsecurity-config.tf` и удалите описание создаваемой инфраструктуры из файла.
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
    
       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
    1. Примените изменения конфигурации:
    
       ```bash
       terraform apply
       ```
    
    1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.


#### См. также {#see-also}

* [{#T}](console.md)