# Интеграция L7-балансировщика с Cloud CDN и Object Storage с помощью Terraform


{% note info %}

Для реализации решения вам понадобится домен. В качестве примера будет использовано доменное имя `example.com`.

{% endnote %}

Чтобы создать инфраструктуру для [интеграции](index.md) L7-балансировщика с Yandex Cloud CDN и Yandex Object Storage с помощью [Terraform](../../../terraform/index.md):

1. [Подготовьте облако к работе](#before-you-begin).
1. [Разверните инфраструктуру для интеграции L7-балансировщика с Cloud CDN и Object Storage](#deploy).
1. [Протестируйте работу решения](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за хранение данных в Object Storage, операции с ними и исходящий трафик ([тарифы Object Storage](../../../storage/pricing.md));
* плата за использование вычислительных ресурсов L7-балансировщика ([тарифы Application Load Balancer](../../pricing.md));
* плата за исходящий трафик с CDN-серверов ([тарифы Cloud CDN](../../../cdn/pricing.md));
* плата за публичные DNS-запросы и DNS-зоны, если вы используете Yandex Cloud DNS ([тарифы Cloud DNS](../../../dns/pricing.md)).

## Разверните инфраструктуру для интеграции L7-балансировщика с Cloud CDN и Object Storage {#deploy}

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

Для создания инфраструктуры с помощью Terraform:
1. [Установите Terraform](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера Yandex Cloud (раздел [Настройте провайдер](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовая конфигурация {#ready}

      1. Клонируйте репозиторий с конфигурационными файлами.

         ```bash
         git clone https://github.com/yandex-cloud-examples/cdn-storage-integration-config
         ```

      1. Перейдите в папку с репозиторием. В ней должны появиться следующие файлы:
          * `cdn-storage-integration-config.tf` — файл конфигурации создаваемой инфраструктуры.
          * `cdn-storage-integration.auto.tfvars` — файл со значениями пользовательских переменных.
          * `index.html` — тестовый файл сервиса, используемый при проверке работоспособности решения.

    - Вручную {#manual}

      1. Создайте папку для конфигурационных файлов и в этой папке:

          1. Создайте файл `index.html` со следующим содержимым:
             
             ```html
             <!DOCTYPE html>
             <html>
               <head>
                 <title>My service</title>
               </head>
               <body>
                 <p>The service is working</p>
               </body>
             </html>
             ```
          1. Создайте конфигурационный файл `cdn-storage-integration-config.tf`:

              {% cut "**cdn-storage-integration-config.tf**" %}

              ```hcl
              # Объявление переменных
              
              variable "folder_id" {
                type = string
              }
              
              variable "domain_name" {
                type = string
              }
              
              variable "bucket_name" {
                type = string
              }
              
              variable "index_file_path" {
                type = string
              }
              
              locals {
                network_name     = "example-network"
                subneta_name     = "example-subnet-ru-central1-a"
                subnetb_name     = "example-subnet-ru-central1-b"
                subnetd_name     = "example-subnet-ru-central1-d"
                sg_name          = "example-sg"
                object_key       = "index.html"
                domain_zone_name = "my-domain-zone"
                cert_name        = "mymanagedcert"
                origin_gp_name   = "example-origin-group"
                bg_name          = "example-bg"
                backend_name     = "example-backend"
                router_name      = "example-router"
                vh_name          = "example-vh"
                route_name       = "example-route"   
                alb_name         = "example-balancer"
                listener_name    = "example-listener"
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
              
              # Создание публичной DNS-зоны
              
              resource "yandex_dns_zone" "my-domain-zone" {
                name    = local.domain_zone_name
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
              
              # Создание CNAME-записи для валидации доменов при выпуске сертификата
              
              resource "yandex_dns_recordset" "validation-record" {
                count   = yandex_cm_certificate.le-certificate.managed[0].challenge_count
                zone_id = yandex_dns_zone.my-domain-zone.id
                name    = yandex_cm_certificate.le-certificate.challenges[count.index].dns_name
                type    = yandex_cm_certificate.le-certificate.challenges[count.index].dns_type
                ttl     = 600
                data    = [yandex_cm_certificate.le-certificate.challenges[count.index].dns_value]
              }
              
              # Ожидание валидации доменов и выпуска сертификата Let's Encrypt
              
              data "yandex_cm_certificate" "example-com" {
                depends_on      = [yandex_dns_recordset.validation-record]
                certificate_id  = yandex_cm_certificate.le-certificate.id
                wait_validation = true
              }
              
              # Создание сети
              
              resource "yandex_vpc_network" "my-network" {
                name = local.network_name
              }
              
              # Создание подсетей
              
              resource "yandex_vpc_subnet" "my-subnet-a" {
                name           = local.subneta_name
                zone           = "ru-central1-a"
                network_id     = yandex_vpc_network.my-network.id
                v4_cidr_blocks = ["192.168.1.0/24"]
              }
              
              resource "yandex_vpc_subnet" "my-subnet-b" {
                name           = local.subnetb_name
                zone           = "ru-central1-b"
                network_id     = yandex_vpc_network.my-network.id
                v4_cidr_blocks = ["192.168.2.0/24"]
              }
              
              resource "yandex_vpc_subnet" "my-subnet-d" {
                name           = local.subnetd_name
                zone           = "ru-central1-d"
                network_id     = yandex_vpc_network.my-network.id
                v4_cidr_blocks = ["192.168.3.0/24"]
              }
              
              # Создание группы безопасности
              
              resource "yandex_vpc_security_group" "my-sg" {
                name        = local.sg_name
                network_id  = yandex_vpc_network.my-network.id
              
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
                  protocol          = "TCP"
                  description       = "healthchecks"
                  predefined_target = "loadbalancer_healthchecks"
                  port              = 30080
                }
              
                egress {
                  protocol       = "ANY"
                  description    = "any"
                  v4_cidr_blocks = ["0.0.0.0/0"]
                  from_port      = 0
                  to_port        = 65535
                }
              }
              
              # Создание бакета
              
              resource "yandex_storage_bucket" "cdn-source-bucket" {
                bucket      = var.bucket_name
                folder_id   = var.folder_id
              
                anonymous_access_flags {
                  read = true
                  list = true
                }
              }
              
              # Загрузка в бакет главной страницы тестового сервиса
              
              resource "yandex_storage_object" "index-object" {
                bucket        = yandex_storage_bucket.cdn-source-bucket.bucket
                key           = local.object_key
                source        = var.index_file_path
                content_type  = "text/html"
              }
              
              # Создание группы бэкендов
              
              resource "yandex_alb_backend_group" "test-backend-group" {
                name                     = local.bg_name
                http_backend {
                  name                   = local.backend_name
                  weight                 = 100
                  port                   = 80
                  storage_bucket         = var.bucket_name
                }
              }
              
              # Создание HTTP-роутера
              
              resource "yandex_alb_http_router" "my-router" {
                name          = local.router_name
              }
              
              # Создание виртуального хоста
              
              resource "yandex_alb_virtual_host" "my-virtual-host" {
                name           = local.vh_name
                http_router_id = yandex_alb_http_router.my-router.id
              
                route {
                  name = local.route_name
              
                  http_route {
                    http_match {
                      http_method = ["GET"]
                      path {
                        prefix = "/"
                      }
                    }
              
                    http_route_action {
                      backend_group_id = yandex_alb_backend_group.test-backend-group.id
                    }
                  }
                }
              
                authority = [var.domain_name]
              }
              
              # Создание L7-балансировщика
              
              resource "yandex_alb_load_balancer" "my-balancer" {
                name               = local.alb_name
                network_id         = yandex_vpc_network.my-network.id
                security_group_ids = [yandex_vpc_security_group.my-sg.id]
              
                allocation_policy {
                  location {
                    zone_id   = "ru-central1-a"
                    subnet_id = yandex_vpc_subnet.my-subnet-a.id
                  }
              
                  location {
                    zone_id   = "ru-central1-b"
                    subnet_id = yandex_vpc_subnet.my-subnet-b.id
                  }
              
                  location {
                    zone_id   = "ru-central1-d"
                    subnet_id = yandex_vpc_subnet.my-subnet-d.id
                  }
                }
              
                listener {
                  name = local.listener_name
                  endpoint {
                    address {
                      external_ipv4_address {
                      }
                    }
                    ports = [80]
                  }
                  http {
                    handler {
                      http_router_id = yandex_alb_http_router.my-router.id
                    }
                  }
                }
              }
              
              # Создание группы источников CDN
              
              resource "yandex_cdn_origin_group" "my-origin-group" {
                name = local.origin_gp_name
                origin {
                  source = yandex_alb_load_balancer.my-balancer.listener[0].endpoint[0].address[0].external_ipv4_address[0].address
                }
              }
              
              # Создание CDN-ресурса
              
              resource "yandex_cdn_resource" "my-resource" {
                cname               = var.domain_name
                active              = true
                origin_protocol     = "http"
                origin_group_id     = yandex_cdn_origin_group.my-origin-group.id
                ssl_certificate {
                  type = "certificate_manager"
                  certificate_manager_id = data.yandex_cm_certificate.example-com.id
                }
                options {
                  redirect_http_to_https = true
                  forward_host_header    = true
                }
              }
              
              # Создание CNAME-записи для CDN-ресурса
              
              resource "yandex_dns_recordset" "cdn-cname" {
                zone_id = yandex_dns_zone.my-domain-zone.id
                name    = "${var.domain_name}."
                type    = "CNAME"
                ttl     = 600
                data    = [yandex_cdn_resource.my-resource.provider_cname]
              }
              ```

              {% endcut %}

          1. Создайте файл с пользовательскими данными `cdn-storage-integration.auto.tfvars`:

              **cdn-storage-integration.auto.tfvars**

              ```hcl
              folder_id       = "<идентификатор_каталога>"
              bucket_name     = "<имя_бакета>"
              domain_name     = "<имя_домена>"
              index_file_path = "<локальный_путь_к_файлу_index.html>"
              ```

    {% endlist %}

    Более подробную информацию о параметрах используемых ресурсов в Terraform см. в документации провайдера:

    * [Сеть](../../../vpc/concepts/network.md#network) — [yandex_vpc_network](../../../terraform/resources/vpc_network.md).
    * [Подсеть](../../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet](../../../terraform/resources/vpc_subnet.md).
    * [Группа безопасности](../../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group](../../../terraform/resources/vpc_security_group.md).
    * [DNS-зона](../../../dns/concepts/dns-zone.md) — [yandex_dns_zone](../../../terraform/resources/dns_zone.md).
    * [Ресурсная запись DNS](../../../dns/concepts/resource-record.md) — [yandex_dns_recordset](../../../terraform/resources/dns_recordset.md).
    * [TLS-Сертификат](../../../certificate-manager/concepts/managed-certificate.md) — [yandex_cm_certificate](../../../terraform/resources/cm_certificate.md).
    * [Бакет](../../../storage/concepts/bucket.md) — [yandex_storage_bucket](../../../terraform/resources/storage_bucket.md).
    * [Объект](../../../storage/concepts/object.md) — [yandex_storage_object](../../../terraform/resources/storage_object.md).
    * [Группа источников](../../../cdn/concepts/origins.md#groups) — [yandex_cdn_origin_group](../../../terraform/resources/cdn_origin_group.md).
    * [CDN-ресурс](../../../cdn/concepts/resource.md) — [yandex_cdn_resource](../../../terraform/resources/cdn_resource.md).
    * [Группа бэкендов](../../concepts/backend-group.md) — [yandex_alb_backend_group](../../../terraform/resources/alb_backend_group.md).
    * [HTTP-роутер](../../concepts/http-router.md) — [yandex_alb_http_router](../../../terraform/resources/alb_http_router.md).
    * [Виртуальный хост](../../concepts/http-router.md#virtual-host) — [yandex_alb_virtual_host](../../../terraform/resources/alb_virtual_host.md).
    * [L7-балансировщик нагрузки](../../concepts/application-load-balancer.md) — [yandex_alb_load_balancer](../../../terraform/resources/alb_load_balancer.md).

1. В файле `cdn-storage-integration.auto.tfvars` задайте значения пользовательских переменных:
    * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
    * `bucket_name` — имя бакета в соответствии с [правилами именования](../../../storage/concepts/bucket.md#naming).
    * `domain_name` — имя домена, на котором будет размещен тестовый сервис.

        Чтобы получить доступ к именам из публичной зоны, вам нужно делегировать домен. Укажите адреса серверов `ns1.yandexcloud.net` и `ns2.yandexcloud.net` в личном кабинете вашего регистратора доменных имен.
    * `index_file_path` — локальный путь к файлу `index.html` с содержимым тестового сервиса. Например: `/Users/MyUser/Repos/cdn-storage-integration/index.html`.

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

В результате в выбранном каталоге будет создана и настроена вся необходимая инфраструктура.

## Протестируйте работу решения {#test}

Чтобы проверить работу сервиса, откройте в браузере адрес `https://example.com/index.html` (где вместо `example.com` — имя вашего домена). Если все было настроено правильно, вы должны увидеть страницу с таким содержанием:

```html
<!DOCTYPE html>
<html>
  <head>
    <title>My service</title>
  </head>
  <body>
    <p>The service is working</p>
  </body>
</html>
```

## Как удалить созданные ресурсы {#clear-out}

{% note warning %}

Прежде чем удалять инфраструктуру, [удалите](../../../storage/operations/objects/delete.md) все объекты в созданном бакете.

{% endnote %}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `cdn-storage-integration-config.tf` и удалите описание создаваемой инфраструктуры из файла.
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

* [Интеграция L7-балансировщика с Cloud CDN и Object Storage с помощью консоли управления](console.md)