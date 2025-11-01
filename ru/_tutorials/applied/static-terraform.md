1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Проверьте работу сайта](#test-site).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [static-paid-resources](../_tutorials_includes/static-paid-resources.md) %}

## Создайте инфраструктуру {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

Чтобы создать инфраструктуру для статического сайта в {{ objstorage-name }} с помощью {{ TF }}:
1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
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

           {% include [static-tf-config](../../_includes/web/static-tf-config.md) %}

           {% endcut %}

        1. Файл `index.html` с текстом `Hello world!`:

           {% cut "index.html" %}

           {% include [static-tf-config](../../_includes/web/index-html-config.md) %}

           {% endcut %}

        1. Файл `error.html` с текстом `Error!`:

           {% cut "error.html" %}

           {% include [static-tf-config](../../_includes/web/error-html-config.md) %}

           {% endcut %}

   {% endlist %}

   Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:
    * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
    * [Настройка](../../iam/concepts/access-control/roles.md) прав доступа на каталог — [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
    * [Статический ключ доступа](../../iam/concepts/authorization/access-key.md) — [yandex_iam_service_account_static_access_key]({{ tf-provider-resources-link }}/iam_service_account_static_access_key).
    * [Бакет](../../storage/concepts/bucket.md) — [yandex_storage_bucket]({{ tf-provider-resources-link }}/storage_bucket).
    * [Настройка](../../storage/operations/buckets/iam-access.md) прав доступа к бакету с помощью {{ iam-name }} — [yandex_storage_bucket_iam_binding]({{ tf-provider-resources-link }}/storage_bucket_iam_binding).
    * [Настройка](../../storage/operations/buckets/edit-acl.md) прав доступа к бакету с помощью [ACL {{ objstorage-name }}](../../storage/concepts/acl.md) — [yandex_storage_bucket_grant]({{ tf-provider-resources-link }}/storage_bucket_grant).
    * Источник данных о [TLS-сертификате](../../certificate-manager/concepts/imported-certificate.md) — [yandex_cm_certificate]({{ tf-provider-datasources-link }}/cm_certificate).
    * [Объект](../../storage/concepts/object.md) в бакете — [yandex_storage_object]({{ tf-provider-resources-link }}/storage_object).
    * [DNS-зона](../../dns/concepts/dns-zone.md) — [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone).
    * [Ресурсная запись DNS](../../dns/concepts/resource-record.md) — [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset).

1. В файле `static.tf` в блоке `locals` задайте пользовательские параметры:
   * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором будут создаваться ресурсы.
   * `domain` — доменное имя в формате `example.com`, без точки в конце.

1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

После создания инфраструктуры, [проверьте работу сайта](#test-site).

## Проверьте работу сайта {#test-site}

{% include [static-test-site](../_tutorials_includes/static-test-site.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `static.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}