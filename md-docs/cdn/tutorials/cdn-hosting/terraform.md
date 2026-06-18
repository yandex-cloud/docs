# Настройка хостинга статического сайта в бакете Yandex Object Storage с доступом через Yandex Cloud CDN с помощью Terraform



Чтобы создать инфраструктуру для хостинга [сайта в бакете с доступом через Yandex Cloud CDN](index.md) с помощью Terraform:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Добавьте сертификат в Certificate Manager](#add-certificate).
1. [Создайте инфраструктуру](#deploy).
1. [Проверьте работу CDN](#check-cdn).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для сайта в бакете с доступом через CDN входят:
* плата за исходящий трафик с CDN-серверов ([тарифы Cloud CDN](../../pricing.md));
* плата за хранение данных в Object Storage, операции с ними и исходящий трафик ([тарифы Object Storage](../../../storage/pricing.md));
* плата за публичные DNS-запросы и [DNS-зоны](../../../dns/concepts/dns-zone.md), если вы используете [Yandex Cloud DNS](../../../dns/index.md) ([тарифы Cloud DNS](../../../dns/pricing.md)).


## Добавьте сертификат в Certificate Manager {#add-certificate}

Поддерживаются сертификаты из [Yandex Certificate Manager](../../../certificate-manager/index.md). Вы можете [выпустить новый сертификат Let's Encrypt®](../../../certificate-manager/operations/managed/cert-create.md) или [загрузить собственный](../../../certificate-manager/operations/import/cert-create.md).

Сертификат должен находиться в том же [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором расположен ваш CDN-ресурс.

Для сертификата Let's Encrypt® пройдите [проверку прав](../../../certificate-manager/operations/managed/cert-validate.md) на домен, который указан в сертификате.


## Создайте инфраструктуру {#deploy}

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
        git clone https://github.com/yandex-cloud-examples/yc-s3-cdn-hosting.git
        ```

     1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
        * `index.html` — файл главной страницы сайта.
        * `yc-cdn-hosting.tf` — конфигурация создаваемой инфраструктуры.
        * `yc-cdn-hosting.auto.tfvars` — файл с пользовательскими данными.

   - Вручную {#manual}

     1. Создайте папку для конфигурационных файлов.
     1. Создайте в папке:
        1. Файл главной страницы сайта `index.html`:

           {% cut "index.html" %}
           
           ```html
           <!DOCTYPE html>
           <html>
             <head>
               <title>My site</title>
             </head>
             <body>
               <p>The site is working</p>
             </body>
           </html>
           ```
           
           {% endcut %}

        1. Конфигурационный файл `yc-cdn-hosting.tf`:

           {% cut "yc-cdn-hosting.tf" %}

           ```hcl
           # Объявление переменных для конфиденциальных параметров
           
           variable "folder_id" {
             type = string
           }
           
           variable "domain" {
             type = string
           }
           
           variable "cert_id" {
             type = string
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
           
           # Получение информации о TLS-сертификате
           
           data "yandex_cm_certificate" "example_by_id" {
             certificate_id = var.cert_id
           }
           
           # Создание бакета
           
           resource "yandex_storage_bucket" "main-bucket" {
             bucket    = var.domain
             folder_id = var.folder_id
             max_size  = "1073741824"
             website {
               index_document = "index.html"
             }
             https {
               certificate_id = data.yandex_cm_certificate.example_by_id.id
             }
           
             depends_on = [data.yandex_cm_certificate.example_by_id]
           }
           
           # Настройка прав доступа для бакета
           
           resource "yandex_storage_bucket_grant" "my_grant_main" {
             bucket = yandex_storage_bucket.main-bucket.id
             grant {
               uri         = "http://acs.amazonaws.com/groups/global/AllUsers"
               permissions = ["READ"]
               type        = "Group"
             }
             depends_on = [yandex_storage_bucket.main-bucket]
           }
           
           # Загрузка объекта в бакет
           
           resource "yandex_storage_object" "index-page" {
             bucket     = yandex_storage_bucket.main-bucket.id
             key        = "index.html"
             source     = "index.html"
             depends_on = [yandex_storage_bucket_grant.my_grant_main]
           }
           
           # Создание зоны DNS
           
           resource "yandex_dns_zone" "zone1" {
             name   = "mydnszone"
             zone   = "${var.domain}."
             public = true
           }
           
           # Создание записи DNS
           
           resource "yandex_dns_recordset" "rs1" {
             zone_id     = yandex_dns_zone.zone1.id
             name        = "cdn"
             type        = "CNAME"
             ttl         = 600
             data        = ["${data.yandex_cdn_resource.my_resource.provider_cname}"]
             description = "CDN CNAME record"
             depends_on  = [yandex_cdn_resource.my_resource]
           }
           
           # Получение информации о ресурсе CDN
           
           data "yandex_cdn_resource" "my_resource" {
             resource_id = yandex_cdn_resource.my_resource.id
           }
           
           # Создание группы источников
           
           resource "yandex_cdn_origin_group" "my_group" {
             name     = "updates-origin-group"
             use_next = true
             origin {
               source = "${var.domain}.website.yandexcloud.net"
             }
           }
           
           # Создание ресурса CDN
           
           resource "yandex_cdn_resource" "my_resource" {
             cname             = "cdn.${var.domain}"
             active            = true
             origin_protocol   = "http"
             origin_group_name = yandex_cdn_origin_group.my_group.name
             options {
               custom_host_header     = "${var.domain}.website.yandexcloud.net"
               redirect_http_to_https = true
             }
             ssl_certificate {
               type                   = "certificate_manager"
               certificate_manager_id = data.yandex_cm_certificate.example_by_id.id
             }
           }
           ```

           {% endcut %}

        1. Файл с пользовательскими данными `yc-cdn-hosting.auto.tfvars`:

           {% cut "yc-cdn-hosting.auto.tfvars" %}

           ```hcl
           folder_id = "<идентификатор_каталога>"
           domain    = "<доменное_имя>"
           cert_id   = "<идентификатор_TLS-сертификата>"
           ```

           {% endcut %}

   {% endlist %}

   Подробнее о параметрах используемых ресурсов в Terraform смотрите в документации провайдера:
   * [TLS-сертификат](../../../certificate-manager/concepts/managed-certificate.md) — источник данных [yandex_cm_certificate](../../../terraform/data-sources/cm_certificate.md).
   * [Бакет](../../../storage/concepts/bucket.md) — [yandex_storage_bucket](../../../terraform/resources/storage_bucket.md).
   * [Настройка](../../../storage/operations/buckets/edit-acl.md) прав доступа к бакету с помощью [ACL Object Storage](../../../storage/concepts/acl.md) — [yandex_storage_bucket_grant](../../../terraform/resources/storage_bucket_grant.md).
   * [Объект](../../../storage/concepts/object.md) — [yandex_storage_object](../../../terraform/resources/storage_object.md).
   * [DNS-зона](../../../dns/concepts/dns-zone.md) — [yandex_dns_zone](../../../terraform/resources/dns_zone.md).
   * [Ресурсная запись DNS](../../../dns/concepts/resource-record.md) — [yandex_dns_recordset](../../../terraform/resources/dns_recordset.md).
   * [CDN-ресурс](../../concepts/resource.md) — [yandex_cdn_resource](../../../terraform/resources/cdn_resource.md).
   * [Группа источников](../../concepts/origins.md#groups) — [yandex_cdn_origin_group](../../../terraform/resources/cdn_origin_group.md).

1. В файле `yc-cdn-hosting.auto.tfvars` задайте пользовательские параметры:
   * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
   * `domain` — основное доменное имя, например `example.com`. 
       Чтобы получить доступ к именам из публичной зоны, вам нужно делегировать домен. Укажите адреса серверов `ns1.yandexcloud.net` и `ns2.yandexcloud.net` в личном кабинете вашего регистратора.
   * `cert_id` — идентификатор TLS-сертификата Certificate Manager с пройденной проверкой прав на домен.

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

{% note warning %}

После создания CDN-ресурса может пройти до 15 минут, прежде чем ресурс фактически заработает.

Перед тем как приступать к следующим шагам, убедитесь, что вновь созданный CDN-ресурс полностью работоспособен.

{% endnote %}


## Проверьте работу CDN {#check-cdn}

Дождитесь обновления DNS-записей — на это может потребоваться несколько часов.

Проверьте доступность сайта: откройте его по новому URL `cdn.example.com`. Должно произойти перенаправление на страницу `https://cdn.example.com`, где уже подключен TLS-сертификат из Certificate Manager и источником для раздачи является Cloud CDN.


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `yc-cdn-hosting.tf` и удалите описание создаваемой инфраструктуры из файла.
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

* [Настройка хостинга статического сайта в бакете Yandex Object Storage с доступом через Yandex Cloud CDN](console.md)