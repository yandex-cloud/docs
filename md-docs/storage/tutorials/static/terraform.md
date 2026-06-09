# Статический сайт в {{ objstorage-full-name }} с помощью {{ TF }}

Чтобы разместить [статический сайт в {{ objstorage-name }}](index.md) с помощью {{ TF }}:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Проверьте работу сайта](#test-site).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки статического сайта входит:
* плата за хранение данных статического сайта (см. [тарифы {{ objstorage-name }}](../../pricing.md#prices-storage));
* плата за операции с данными (см. [тарифы {{ objstorage-name }}](../../pricing.md#prices-operations));
* плата за исходящий трафик из {{ yandex-cloud }} в интернет (см. [тарифы {{ objstorage-name }}](../../pricing.md#prices-traffic));
* плата за публичные DNS-запросы и [зоны](../../../dns/concepts/dns-zone.md) (см. [тарифы {{ dns-full-name }}](../../../dns/pricing.md)).

## Создайте инфраструктуру {#deploy}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

Чтобы создать инфраструктуру для статического сайта в {{ objstorage-name }} с помощью {{ TF }}:
1. [Установите {{ TF }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).


1. Подготовьте файлы с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовая конфигурация {#ready}

     1. Клонируйте репозиторий с конфигурационными файлами.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-s3-static-website.git
        ```

     1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
        * `static.tf` — конфигурация создаваемой инфраструктуры.
        * `index.html` и `error.html` — главная страница сайта и страница ошибки.

   - Вручную {#manual}

     1. Создайте папку для конфигурационных файлов.
     1. Создайте в папке:
        1. Конфигурационный файл `static.tf`:

           {% cut "static.tf" %}

           ```hcl
           locals {
             folder_id = "<идентификатор_каталога>"
             domain    = "<домен>"
           }
           
           terraform {
             required_providers {
               yandex = {
                 source  = "yandex-cloud/yandex"
                 version = ">= 0.47.0"
               }
             }
           }
           
           provider "yandex" {
             folder_id = local.folder_id
           }
           
           resource "yandex_iam_service_account" "sa" {
             name = "my-sa"
           }
           
           resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
             folder_id = local.folder_id
             role      = "storage.editor"
             member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
           }
           
           resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
             service_account_id = yandex_iam_service_account.sa.id
             description        = "static access key for object storage"
           }
           
           resource "yandex_storage_bucket" "test" {
             access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
             secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
             bucket     = local.domain
             max_size   = 1073741824  
           
             website {
               index_document = "index.html"
               error_document = "error.html"
             }
           
             # Сертификат Certificate Manager
             https {
               certificate_id = data.yandex_cm_certificate.example.id
             }
           }
           
           resource "yandex_storage_bucket_iam_binding" "storage_admin" {
             bucket = local.domain
             role   = "storage.admin"
           
             members = [
               "serviceAccount:${yandex_iam_service_account.sa.id}",
             ]
             depends_on = [yandex_storage_bucket.test]
           }
           
           resource "yandex_storage_bucket_grant" "public_read" {
             bucket = local.domain
             access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
             secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
             acl        = "public-read"
             depends_on = [yandex_storage_bucket_iam_binding.storage_admin]
           }
           
           resource "yandex_cm_certificate" "le-certificate" {
             name    = "my-le-cert"
             domains = ["${local.domain}"]
           
             managed {
             challenge_type = "DNS_CNAME"
             }
           }
           
           resource "yandex_dns_recordset" "validation-record" {
             zone_id = yandex_dns_zone.zone1.id
             name    = yandex_cm_certificate.le-certificate.challenges[0].dns_name
             type    = yandex_cm_certificate.le-certificate.challenges[0].dns_type
             data    = [yandex_cm_certificate.le-certificate.challenges[0].dns_value]
             ttl     = 600
           }
           
           data "yandex_cm_certificate" "example" {
             depends_on      = [yandex_dns_recordset.validation-record]
             certificate_id  = yandex_cm_certificate.le-certificate.id
             #wait_validation = true
           }
           
           resource "yandex_storage_object" "index-html" {
             access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
             secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
             bucket     = yandex_storage_bucket.test.id
             key        = "index.html"
             source     = "index.html"
           }
           
           resource "yandex_storage_object" "error-html" {
             access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
             secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
             bucket     = yandex_storage_bucket.test.id
             key        = "error.html"
             source     = "error.html"
           }
           
           resource "yandex_dns_zone" "zone1" {
             name        = "example-zone-1"
             description = "Public zone"
             zone        = "${local.domain}."
             public      = true
           }
           
           resource "yandex_dns_recordset" "rs2" {
             zone_id = yandex_dns_zone.zone1.id
             name    = "${local.domain}."
             type    = "ANAME"
             ttl     = 600
             data    = ["${local.domain}.website.yandexcloud.net"]
           }
           ```

           {% endcut %}

        1. Файл `index.html` с текстом `Hello world!`:

           {% cut "index.html" %}

           ```html
           <!doctype html>
           <html>
             <head>
               <title>Hello, world!</title>
             </head>
             <body>
               <p>Hello, world!</p>
             </body>
           </html>
           ```

           {% endcut %}

        1. Файл `error.html` с текстом `Error!`:

           {% cut "error.html" %}

           ```html
           <!doctype html>
           <html>
             <head>
               <title>Error!</title>
             </head>
             <body>
               <p>Error!</p>
             </body>
           </html>
           ```

           {% endcut %}

   {% endlist %}

   Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:
    * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
    * [Настройка](../../../iam/concepts/access-control/roles.md) прав доступа на каталог — [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
    * [Статический ключ доступа](../../../iam/concepts/authorization/access-key.md) — [yandex_iam_service_account_static_access_key]({{ tf-provider-resources-link }}/iam_service_account_static_access_key).
    * [Бакет](../../concepts/bucket.md) — [yandex_storage_bucket]({{ tf-provider-resources-link }}/storage_bucket).
    * [Настройка](../../operations/buckets/iam-access.md) прав доступа к бакету с помощью {{ iam-name }} — [yandex_storage_bucket_iam_binding]({{ tf-provider-resources-link }}/storage_bucket_iam_binding).
    * [Настройка](../../operations/buckets/edit-acl.md) прав доступа к бакету с помощью [ACL {{ objstorage-name }}](../../concepts/acl.md) — [yandex_storage_bucket_grant]({{ tf-provider-resources-link }}/storage_bucket_grant).
    * Источник данных о [TLS-сертификате](../../../certificate-manager/concepts/imported-certificate.md) — [yandex_cm_certificate]({{ tf-provider-datasources-link }}/cm_certificate).
    * [Объект](../../concepts/object.md) в бакете — [yandex_storage_object]({{ tf-provider-resources-link }}/storage_object).
    * [DNS-зона](../../../dns/concepts/dns-zone.md) — [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone).
    * [Ресурсная запись DNS](../../../dns/concepts/resource-record.md) — [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset).

1. В файле `static.tf` в блоке `locals` задайте пользовательские параметры:
   * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором будут создаваться ресурсы.
   * `domain` — доменное имя в формате `example.com`, без точки в конце.

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

После создания инфраструктуры, [проверьте работу сайта](#test-site).

## Проверьте работу сайта {#test-site}

Чтобы проверить работу сайта, используйте один из стандартных адресов {{ objstorage-name }}:
* `http://<имя_бакета>.{{ s3-web-host }}`
* `http://{{ s3-web-host }}/<имя_бакета>`

Если вы настроили для сайта собственный домен, используйте его адрес, например `example.com`.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `static.tf` и удалите описание создаваемой инфраструктуры из файла.
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

* [{#T}](console.md).