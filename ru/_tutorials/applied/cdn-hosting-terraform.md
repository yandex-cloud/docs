1. [Подготовьте облако к работе](#before-you-begin).
1. [Добавьте сертификат в {{ certificate-manager-name }}](#add-certificate).
1. [Создайте инфраструктуру](#deploy).
1. [Проверьте работу CDN](#check-cdn).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../../_tutorials/_tutorials_includes/cdn-hosting/paid-resources.md) %}


## Добавьте сертификат в {{ certificate-manager-name }} {#add-certificate}

{% include [add-certificate](../../_tutorials/_tutorials_includes/cdn-hosting/add-certificate.md) %}


## Создайте инфраструктуру {#deploy}

{% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

Для создания инфраструктуры с помощью {{ TF }}:
1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
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

           {% include [yc-cdn-hosting](../../_tutorials/_tutorials_includes/cdn-hosting/tf-config.md) %}

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

   Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:
   * [TLS-сертификат](../../certificate-manager/concepts/managed-certificate.md) — источник данных [yandex_cm_certificate]({{ tf-provider-datasources-link }}/cm_certificate).
   * [Бакет](../../storage/concepts/bucket.md) — [yandex_storage_bucket]({{ tf-provider-resources-link }}/storage_bucket).
   * [Настройка](../../storage/operations/buckets/edit-acl.md) прав доступа к бакету с помощью [ACL Object Storage](../../storage/concepts/acl.md) — [yandex_storage_bucket_grant]({{ tf-provider-resources-link }}/storage_bucket_grant).
   * [Объект](../../storage/concepts/object.md) — [yandex_storage_object]({{ tf-provider-resources-link }}/storage_object).
   * [DNS-зона](../../dns/concepts/dns-zone.md) — [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone).
   * [Ресурсная запись DNS](../../dns/concepts/resource-record.md) — [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset).
   * [CDN-ресурс](../../cdn/concepts/resource.md) — [yandex_cdn_resource]({{ tf-provider-resources-link }}/cdn_resource).
   * [Группа источников](../../cdn/concepts/origins.md#groups) — [yandex_cdn_origin_group]({{ tf-provider-resources-link }}/cdn_origin_group).

1. В файле `yc-cdn-hosting.auto.tfvars` задайте пользовательские параметры:
   * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
   * `domain` — основное доменное имя, например `example.com`. 
       Чтобы получить доступ к именам из публичной зоны, вам нужно делегировать домен. Укажите адреса серверов `ns1.yandexcloud.net` и `ns2.yandexcloud.net` в личном кабинете вашего регистратора.
   * `cert_id` — идентификатор TLS-сертификата {{ certificate-manager-name }} с пройденной проверкой прав на домен.

1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

{% include [start-warn](../_tutorials_includes/cdn-hosting/start-warn.md) %}


## Проверьте работу CDN {#check-cdn}

{% include [check-cdn](../../_tutorials/_tutorials_includes/cdn-hosting/check-cdn.md) %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `yc-cdn-hosting.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
