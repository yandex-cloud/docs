# Поддержка нескольких доменных имен с помощью Terraform

Чтобы создать инфраструктуру для поддержки [нескольких доменных имен](index.md) сайта с помощью Terraform:
1. [Делегируйте доменное имя](#delegate-domain).
1. [Создайте инфраструктуру](#deploy).
1. [Проверьте работу нескольких доменов](#test).


## Делегируйте доменное имя {#delegate-domain}

Вы можете воспользоваться сервисом [Yandex Cloud DNS](../../../../dns/index.md) для управления доменом.

Чтобы делегировать домен сервису Cloud DNS, в личном кабинете вашего регистратора домена укажите в настройках домена адреса DNS-серверов:

* `ns1.yandexcloud.net`
* `ns2.yandexcloud.net`

Делегирование происходит не сразу. Серверы интернет-провайдеров обычно обновляют записи в течение 24 часов (86400 секунд). Это обусловлено значением TTL, в течение которого кешируются записи для доменов.

Проверить делегирование домена можно с помощью [сервиса Whois](https://www.reg.ru/whois/check_site) или утилиты `dig`:

```bash
dig +short NS example.com
```

Результат:

```
ns2.yandexcloud.net.
ns1.yandexcloud.net.
```


## Создайте инфраструктуру {#deploy}


[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../../terraform/index.md).

Для создания инфраструктуры с помощью Terraform:

1. [Установите Terraform](../../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера Yandex Cloud (раздел [Настройте провайдер](../../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).


1. Подготовьте файлы с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовая конфигурация {#ready}

     1. Клонируйте репозиторий с конфигурационными файлами.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-s3-static-website-multiple-domain.git
        ```

     1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
        * `index.html` — файл главной страницы сайта.
        * `website-multiple-domain.tf` — конфигурация создаваемой инфраструктуры.
        * `website-multiple-domain.auto.tfvars` — файл с пользовательскими данными.

   - Вручную {#manual}

     1. Создайте папку для конфигурационных файлов.

     1. Создайте в папке:

        1. Конфигурационный файл `website-multiple-domain.tf`:

           {% cut "website-multiple-domain.tf" %}

           ```hcl
           # Объявление переменных для конфиденциальных параметров
           
           variable "main_domain" {
             type = string
           }
           
           variable "extra_domain" {
             type = string
           }
           
           variable "folder_id" {
             type = string
           }
           
           locals {
             test = [ yandex_dns_zone.zone1.id, yandex_dns_zone.zone2.id]
           }
           
           # Настройка провайдера
           
           terraform {
             required_providers {
               yandex = {
                 source = "yandex-cloud/yandex"
               }
             }
             required_version = ">=0.136.0"
           }
           
           # Создание бакетов
           
           resource "yandex_storage_bucket" "main-bucket" {
             bucket    = var.main_domain
             folder_id = var.folder_id
             anonymous_access_flags {
               read        = true
               list        = true
               config_read = false
             }
             website {
               index_document = "index.html"
               error_document = "error.html"
             }
           
             https {
               certificate_id = data.yandex_cm_certificate.example_by_id.id
             }
           
             depends_on = [data.yandex_cm_certificate.example_by_id]
           }
           
           resource "yandex_storage_bucket" "extra-bucket" {
             bucket    = var.extra_domain
             folder_id = var.folder_id
             anonymous_access_flags {
               read        = true
               list        = true
               config_read = false
             }
             website {
               redirect_all_requests_to = "https://${var.main_domain}"
             }
           
             https {
               certificate_id = data.yandex_cm_certificate.example_by_id.id
             }
           
             depends_on = [data.yandex_cm_certificate.example_by_id]
           }
           
           # Загрузка главной страницы в бакет
           
           resource "yandex_storage_object" "index-page" {
             bucket     = yandex_storage_bucket.main-bucket.id
             key        = "index.html"
             source     = "index.html"
           }
           
           # Создание DNS зон и ресурсных записей
           
           resource "yandex_dns_zone" "zone1" {
             name    = "main-domain-zone"
             zone    = "${var.main_domain}."
             public  = true
           }
           
           resource "yandex_dns_recordset" "rs1" {
             zone_id = yandex_dns_zone.zone1.id
             name    = "@"
             type    = "CNAME"
             ttl     = 600
             data    = ["${var.main_domain}.website.yandexcloud.net"]
           }
           
           resource "yandex_dns_zone" "zone2" {
             name    = "extra-domain-zone"
             zone    = "${var.extra_domain}."
             public  = true
           }
           
           resource "yandex_dns_recordset" "rs2" {
             zone_id = yandex_dns_zone.zone2.id
             name    = "@"
             type    = "CNAME"
             ttl     = 600
             data    = ["${var.extra_domain}.website.yandexcloud.net"]
           }
           
           
           # Создание TLS-сертификата Let's Encrypt
           
           resource "yandex_cm_certificate" "example" {
             name    = "multidomains-cert"
             domains = ["${var.main_domain}", "${var.extra_domain}"]
           
             managed {
               challenge_type  = "DNS_CNAME"
               challenge_count = 2 # for each domain
             }
           }
           
           resource "yandex_dns_recordset" "example" {
             count   = yandex_cm_certificate.example.managed[0].challenge_count
             zone_id = element(local.test, count.index - 1)
             name    = yandex_cm_certificate.example.challenges[count.index].dns_name
             type    = yandex_cm_certificate.example.challenges[count.index].dns_type
             data    = [yandex_cm_certificate.example.challenges[count.index].dns_value]
             ttl     = 600
           }
           
           data "yandex_cm_certificate" "example_by_id" {
             depends_on     = [yandex_dns_recordset.example]
             certificate_id = yandex_cm_certificate.example.id
           }
           ```

           {% endcut %}

        1. Файл с пользовательскими данными `website-multiple-domain.auto.tfvars`:

           {% cut "website-multiple-domain.auto.tfvars" %}

           ```hcl
           folder_id    = "<идентификатор_каталога>"
           main_domain  = "<основной_домен>"
           extra_domain = "<дополнительный_домен>"
           ```

           {% endcut %}

        1. Файл главной страницы сайта `index.html`:

           {% cut "index.html" %}

           ```html
           <!DOCTYPE html>
           <html>
             <head>
               <title>My site</title>
             </head>
             <body>
               <h1>This is my site!</h1>
             </body>
           </html>
           ```

           {% endcut %}

   {% endlist %}

   Более подробную информацию о параметрах используемых ресурсов в Terraform см. в документации провайдера:
   * [Бакет](../../../concepts/bucket.md) — [yandex_storage_bucket](../../../../terraform/resources/storage_bucket.md).
   * [Объект](../../../concepts/object.md) — [yandex_storage_object](../../../../terraform/resources/storage_object.md).
   * [DNS-зона](../../../../dns/concepts/dns-zone.md) — [yandex_dns_zone](../../../../terraform/resources/dns_zone.md).
   * [Ресурсная запись DNS](../../../../dns/concepts/resource-record.md) — [yandex_dns_recordset](../../../../terraform/resources/dns_recordset.md).
   * [TLS-сертификат](../../../../certificate-manager/concepts/managed-certificate.md) — [yandex_cm_certificate](../../../../terraform/resources/cm_certificate.md).

1. В файле `website-multiple-domain.auto.tfvars` задайте пользовательские параметры:
   * `folder_id` — [идентификатор каталога](../../../../resource-manager/operations/folder/get-id.md).
   * `main_domain` — основной домен, например `example.com`.
   * `extra_domain` — дополнительный домен, например `example2.com`.

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


## Проверьте работу нескольких доменов {#test}

Дождитесь выпуска TLS-сертификата и его перехода в статус `Issued`. После этого убедитесь, что переадресация работает: откройте сайт `https://example2.com`, и вы будете переадресованы на `https://example.com`.