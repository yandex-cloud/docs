---
title: Как настроить поддержку нескольких доменных имен для сайта с помощью {{ TF }}
description: Следуя данной инструкции, вы сможете настроить поддержку нескольких доменных имен для сайта с помощью {{ TF }}.
---

# Поддержка нескольких доменных имен с помощью {{ TF }}

Чтобы создать инфраструктуру для поддержки [нескольких доменных имен](index.md) сайта с помощью {{ TF }}:
1. [Делегируйте доменное имя](#delegate-domain).
1. [Создайте инфраструктуру](#deploy).
1. [Проверьте работу нескольких доменов](#test).


## Делегируйте доменное имя {#delegate-domain}

Вы можете воспользоваться сервисом [{{ dns-full-name }}](../../../../dns/) для управления доменом.

{% include [dns-delegate](../../../../_tutorials/_tutorials_includes/bind-domain-vm/dns-delegate.md) %}


## Создайте инфраструктуру {#deploy}


{% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

Для создания инфраструктуры с помощью {{ TF }}:

1. [Установите {{ TF }}](../../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).


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

           {% include [website-multiple-domain-tf](../../../../_includes/storage/website-multiple-domain-tf.md) %}

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

   Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:
   * [Бакет](../../../concepts/bucket.md) — [yandex_storage_bucket]({{ tf-provider-resources-link }}/storage_bucket).
   * [Объект](../../../concepts/object.md) — [yandex_storage_object]({{ tf-provider-resources-link }}/storage_object).
   * [DNS-зона](../../../../dns/concepts/dns-zone.md) — [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone).
   * [Ресурсная запись DNS](../../../../dns/concepts/resource-record.md) — [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset).
   * [TLS-сертификат](../../../../certificate-manager/concepts/managed-certificate.md) — [yandex_cm_certificate]({{ tf-provider-resources-link }}/cm_certificate).

1. В файле `website-multiple-domain.auto.tfvars` задайте пользовательские параметры:
   * `folder_id` — [идентификатор каталога](../../../../resource-manager/operations/folder/get-id.md).
   * `main_domain` — основной домен, например `example.com`.
   * `extra_domain` — дополнительный домен, например `example2.com`.

1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}


## Проверьте работу нескольких доменов {#test}

{% include [website-multiple-domain-test](../../../../_includes/storage/website-multiple-domain-test.md) %}
