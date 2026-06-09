# Терминирование TLS-соединений с помощью {{ TF }}

Чтобы создать инфраструктуру для [терминирования TLS-соединений](index.md) c помощью {{ TF }}:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Проверьте работу хостинга](#test).

В качестве примера используется доменное имя `my-site.com`.

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для терминирования TLS-соединений входят:
* плата за постоянно запущенные [ВМ](../../../compute/concepts/vm.md) (см. [тарифы {{ compute-full-name }}](../../../compute/pricing.md));
* плата за использование [публичного статического IP-адреса](../../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-full-name }}](../../../vpc/pricing.md));
* плата за использование вычислительных ресурсов [L7-балансировщика](../../concepts/index.md) (см. [тарифы {{ alb-name }}](../../pricing.md));
* плата за публичные [DNS-запросы](../../../glossary/dns.md) и [зоны DNS](../../../dns/concepts/dns-zone.md), если вы используете [{{ dns-full-name }}](../../../dns/index.md) (см. [тарифы {{ dns-name }}](../../../dns/pricing.md)).

## Создайте инфраструктуру {#deploy}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

Для создания инфраструктуры c помощью {{ TF }}:
1. [Установите {{ TF }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовая конфигурация {#ready}

     1. Клонируйте репозиторий с конфигурационными файлами.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-alb-tls-termination.git
        ```

     1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
        * `tls-termination-config.tf` — конфигурация создаваемой инфраструктуры.
        * `tls-terminationg.auto.tfvars` — файл с пользовательскими данными.

   - Вручную {#manual}

     1. Создайте папку для конфигурационных файлов.
     1. Создайте в папке:
        1. Конфигурационный файл `tls-termination-config.tf`:

           {% cut "tls-termination-config.tf" %}

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
           
           variable "domain" {
             type = string
           }
           
           variable "certificate" {
             type = string
           }
           
           variable "private_key" {
             type = string
           }
           
           # Добавление прочих переменных
           
           locals {
             sa_name          = "ig-sa"
             network_name     = "network-1"
             subnet_name_a    = "subnet-a"
             subnet_name_b    = "subnet-b"
             sg_name_balancer = "sg-balancer"
             sg_name_vms      = "sg-vms"
             cert_name        = "imported-cert"
             site_ig_name     = "site-ig"
             alb_bg_name      = "alb-bg"
             alb_host_name    = "alb-host"
             alb_router_name  = "alb-router"
             alb_name         = "alb"
             alb_zone_name    = "alb-zone"
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
           
           # Создание сервисного аккаунта для группы ВМ
           
           resource "yandex_iam_service_account" "ig-sa" {
             name        = local.sa_name
             description = "service account to manage IG"
           }
           
           resource "yandex_resourcemanager_folder_iam_member" "editor" {
             folder_id = var.folder_id
             role      = "editor"
             member    = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
           }
           
           # Создание облачной сети
           
           resource "yandex_vpc_network" "network-1" {
             name = local.network_name
           }
           
           resource "yandex_vpc_subnet" "subnet-a" {
             name           = local.subnet_name_a
             zone           = "{{ region-id }}-a"
             v4_cidr_blocks = ["192.168.1.0/24"]
             network_id     = yandex_vpc_network.network-1.id
           }
           
           resource "yandex_vpc_subnet" "subnet-b" {
             name           = local.subnet_name_b
             zone           = "{{ region-id }}-b"
             v4_cidr_blocks = ["192.168.2.0/24"]
             network_id     = yandex_vpc_network.network-1.id
           }
           
           # Создание статического публичного IP-адреса
           
           resource "yandex_vpc_address" "stat_address" {
             name = "alb-static-address"
             external_ipv4_address {
               zone_id = "{{ region-id }}-a"
             }
           }
           
           # Создание групп безопасности
           
           resource "yandex_vpc_security_group" "sg-balancer" {
             name        = local.sg_name_balancer
             network_id  = yandex_vpc_network.network-1.id
           
             egress {
               protocol       = "ANY"
               description    = "any"
               v4_cidr_blocks = ["0.0.0.0/0"]
               from_port = 0
               to_port = 65535
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
           
           resource "yandex_vpc_security_group" "sg-vms" {
             name        = local.sg_name_vms
             network_id  = yandex_vpc_network.network-1.id
           
             ingress {
               protocol          = "TCP"
               description       = "balancer"
               security_group_id = yandex_vpc_security_group.sg-balancer.id
               port              = 80
               }
           
             ingress {
               protocol       = "TCP"
               description    = "ssh"
               v4_cidr_blocks = ["0.0.0.0/0"]
               port           = 22
             }
           }
           
           # Импорт TLS-сертификат сайта
           
           resource "yandex_cm_certificate" "imported-cert" {
             name    = local.cert_name
           
             self_managed {
               certificate = "${file("${var.certificate}")}"
               private_key = "${file("${var.private_key}")}"
             }
           }
           
           # Создание группу ВМ для сайта
           
           resource "yandex_compute_image" "lemp-image" {
             source_family = "lemp"
           }
           
           resource "yandex_compute_instance_group" "site-ig" {
             name                = local.site_ig_name
             folder_id           = var.folder_id
             service_account_id  = "${yandex_iam_service_account.ig-sa.id}"
             instance_template {
               platform_id = "standard-v2"
               resources {
                 memory        = 1
                 cores         = 2
                 core_fraction = 5
               }
           
               boot_disk {
                 mode = "READ_WRITE"
                 initialize_params {
                   image_id = yandex_compute_image.lemp-image.id
                 }
               }
           
               network_interface {
                 network_id         = yandex_vpc_network.network-1.id
                 subnet_ids         = [yandex_vpc_subnet.subnet-a.id,yandex_vpc_subnet.subnet-b.id]
                 security_group_ids = [yandex_vpc_security_group.sg-vms.id]
                 nat                = true
               }
           
               metadata = {
                 user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("${var.ssh_key_path}")}"
               }
             }
           
             scale_policy {
               fixed_scale {
                 size = 2
               }
             }
           
             allocation_policy {
               zones = ["{{ region-id }}-a","{{ region-id }}-b"]
             }
           
             deploy_policy {
               max_unavailable = 1
               max_expansion   = 0
             }
           
             application_load_balancer {
               target_group_name        = "alb-tg"
             }
           }
           
           # Создание группу бэкендов
           
           resource "yandex_alb_backend_group" "alb-bg" {
             name                     = local.alb_bg_name
           
             http_backend {
               name                   = "alb-backend"
               weight                 = 1
               port                   = 80
               target_group_ids       = [yandex_compute_instance_group.site-ig.application_load_balancer[0].target_group_id]
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
             name          = local.alb_router_name
           }
           
           resource "yandex_alb_virtual_host" "alb-host" {
             name                    = local.alb_host_name
             authority               = ["${var.domain}"]
             http_router_id          = yandex_alb_http_router.alb-router.id
             route {
               name                  = "alb-route"
               http_route {
                 http_route_action {
                   backend_group_id  = yandex_alb_backend_group.alb-bg.id
                   timeout           = "60s"
                 }
               }
             }
           }    
           
           # Создание L7-балансировщика
           
           resource "yandex_alb_load_balancer" "alb" {
             name        = local.alb_name
             network_id  = yandex_vpc_network.network-1.id
             security_group_ids = [yandex_vpc_security_group.sg-balancer.id]
           
             allocation_policy {
               location {
                 zone_id   = "{{ region-id }}-a"
                 subnet_id = yandex_vpc_subnet.subnet-a.id
               }
               location {
                 zone_id   = "{{ region-id }}-b"
                 subnet_id = yandex_vpc_subnet.subnet-b.id 
               }
             }
           
             listener {
               name = "list-http"
               endpoint {
                 address {
                   external_ipv4_address {
                     address = yandex_vpc_address.stat_address.external_ipv4_address[0].address
                   }
                 }
               ports = [ 80 ]
               }
               http {
                 redirects {
                   http_to_https = true
                 }
               }
             }
           
             listener {
               name = "listener-http"
               endpoint {
                 address {
                   external_ipv4_address {
                     address = yandex_vpc_address.stat_address.external_ipv4_address[0].address
                   }
                 }
                 ports = [ 443 ]
               }
               tls {
                 default_handler {
                   http_handler {
                     http_router_id = yandex_alb_http_router.alb-router.id
                   }
                   certificate_ids = [yandex_cm_certificate.imported-cert.id]
                 }
                 sni_handler {
                   name         = "mysite-sni"
                   server_names = ["${var.domain}"]
                   handler {
                     http_handler {
                       http_router_id = yandex_alb_http_router.alb-router.id
                     }
                     certificate_ids = [yandex_cm_certificate.imported-cert.id]
                   }
                 }
               }
             }
           }
           
           # Создание DNS-зоны
           
           resource "yandex_dns_zone" "alb-zone" {
             name        = local.alb_zone_name
             description = "Public zone"
             zone        = "${var.domain}."
             public      = true
           }
           
           # Создание ресурсной записи в DNS-зоне
           
           resource "yandex_dns_recordset" "alb-record" {
             zone_id = yandex_dns_zone.alb-zone.id
             name    = "${var.domain}."
             ttl     = 600
             type    = "A"
             data    = [yandex_alb_load_balancer.alb.listener[0].endpoint[0].address[0].external_ipv4_address[0].address]
             # description - необязательный параметр, описание ресурсной записи
           }
           ```

           {% endcut %}

        1. Файл с пользовательскими данными `tls-termination.auto.tfvars`:

           {% cut "tls-termination.auto.tfvars" %}

           ```hcl
           folder_id    = "<идентификатор_каталога>"
           vm_user      = "<имя_пользователя_ВМ>"
           ssh_key_path = "<путь_к_публичному_SSH-ключу>"
           domain       = "<домен>"
           certificate  = "<путь_к_файлу_с_сертификатом>"
           private_key  = "<путь_к_файлу_с_закрытым_ключом>"
           ```

           {% endcut %}

   {% endlist %}

   Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:
   * [Сеть](../../../vpc/concepts/network.md#network) — [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
   * [Подсети](../../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
   * [Статический публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses) — [yandex_vpc_address]({{ tf-provider-resources-link }}/vpc_address).
   * [Группы безопасности](../../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
   * [TLS-сертификат](../../../certificate-manager/concepts/imported-certificate.md) — [yandex_cm_certificate]({{ tf-provider-resources-link }}/cm_certificate).
   * [Образ ВМ](../../../compute/concepts/image.md) — [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image).
   * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
   * [Роль](../../../iam/concepts/access-control/roles.md) — [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
   * [Группа ВМ](../../../compute/concepts/instance-groups/index.md) — [yandex_compute_instance_group]({{ tf-provider-resources-link }}/compute_instance_group).
   * [Группа бэкендов](../../concepts/backend-group.md) — [yandex_alb_backend_group]({{ tf-provider-resources-link }}/alb_backend_group).
   * [HTTP-роутер](../../concepts/http-router.md) — [yandex_alb_http_router]({{ tf-provider-resources-link }}/alb_http_router).
   * [Виртуальный хост](../../concepts/http-router.md#virtual-host) — [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).
   * [L7-балансировщик](../../concepts/application-load-balancer.md) — [yandex_alb_load_balancer]({{ tf-provider-resources-link }}/alb_load_balancer).
   * [DNS-зона](../../../dns/concepts/dns-zone.md) — [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone).
   * [Ресурсная запись DNS](../../../dns/concepts/resource-record.md) — [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset).

1. В файле `tls-termination.auto.tfvars` задайте пользовательские параметры:
   * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
   * `vm_user` — имя пользователя ВМ.
   * `ssh_key_path` — путь к файлу с публичным SSH-ключом. Подробнее см. [{#T}](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
   * `domain` — домен, на котором будет размещен сайт. 
       Чтобы получить доступ к именам из публичной зоны, вам нужно делегировать домен. Укажите адреса серверов `ns1.{{ dns-ns-host-sld }}` и `ns2.{{ dns-ns-host-sld }}` в личном кабинете вашего регистратора.
   * `certificate` — путь к файлу с [пользовательским сертификатом](../../../certificate-manager/operations/import/cert-create.md#create-file).
   * `private_key` — путь к файлу с закрытым ключом пользовательского сертификата.
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

1. [Получите публичные IP-адреса](../../../compute/operations/instance-groups/get-info.md) — они потребуются далее, чтобы [проверить работу хостинга](#test).

После создания инфраструктуры, [проверьте работу хостинга](#test).

## Проверьте работу хостинга {#test}

Чтобы проверить работу хостинга:

1. Создайте главную страницу сайта — файл `index.html`

    {% cut "Пример файла index.html" %}

    ```html
    <!DOCTYPE html>
    <html>
      <head>
        <title>My site</title>
      </head>
      <body>
        <h1>This is my site</h1>
      </body>
    </html>
    ```

    {% endcut %}

1. Загрузите файл `index.html` на каждую ВМ:

    1. В блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}** на странице виртуальной машины в [консоли управления]({{ link-console-main }}) найдите публичный IP-адрес виртуальной машины.
    1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md) к виртуальной машине по протоколу SSH.
    1. Выдайте права на запись для вашего пользователя на директорию `/var/www/html`:
    
       {% list tabs group=operating_system %}
    
       - Ubuntu {#ubuntu}
    
         ```bash
         sudo chown -R "$USER":www-data /var/www/html
         ```
    
       - CentOS {#centos}
    
         ```bash
         sudo chown -R "$USER":apache /var/www/html
         ```
    
       {% endlist %}
    
    
    1. Загрузите на ВМ файлы сайта с помощью [протокола SCP](https://ru.wikipedia.org/wiki/SCP).
    
       {% list tabs group=operating_system %}
    
       - Linux/macOS {#linux-macos}
    
         Используйте утилиту командной строки `scp`:
    
         ```bash
         scp -r <путь_до_директории_с_файлами> <имя_пользователя_ВМ>@<IP-адрес_виртуальной_машины>:/var/www/html
         ```
    
       - Windows {#windows}
    
         С помощью программы [WinSCP](https://winscp.net/eng/download.php) скопируйте локальную директорию с файлами в директорию `/var/www/html` на ВМ.
    
       {% endlist %}

1. В браузере откройте сайт по адресу `http://my-site.com` — должно произойти перенаправление на страницу `https://my-site.com`, где уже подключен TLS-сертификат из {{ certificate-manager-name }}.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `tls-termination-config.tf` и удалите описание создаваемой инфраструктуры из файла.
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