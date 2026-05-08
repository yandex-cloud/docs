1. [Подготовьте облако к работе](#before-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Проверьте работу сокращателя](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [serverless-paid-resources](../../_includes/serverless/serverless-url-shortener/paid-resources.md) %}

## Создайте инфраструктуру {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

Для создания инфраструктуры с помощью {{ TF }}:
1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовая конфигурация {#ready}

     1. Клонируйте репозиторий с конфигурационными файлами.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-serverless-url-shortener.git
        ```

     1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
         * `serverless-url-shortener.tf` — конфигурация создаваемой инфраструктуры;
         * `serverless-url-shortener.auto.tfvars` — файл с пользовательскими данными;
         * `index.html` — HTML-страница вашего сервиса;
         * `function.zip` — архив с кодом функции {{ sf-name }}.

   - Вручную {#manual}

     1. Создайте папку для конфигурационных файлов.
     1. Создайте в папке:
        1. Конфигурационный файл `serverless-url-shortener.tf`:

           {% cut "serverless-url-shortener.tf" %}

           {% include [serverless-url-shortener](../../_includes/serverless/serverless-url-shortener/tf-config.md) %}

           {% endcut %}

        1. Файл с пользовательскими данными `serverless-url-shortener.auto.tfvars`:

           {% cut "serverless-url-shortener.auto.tfvars" %}

           ```hcl
           cloud_id    = "<идентификатор_облака>" 
           folder_id   = "<идентификатор_каталога>"
           bucket_name = "<имя_бакета>"
           ```

           {% endcut %}

        1. HTML-страница вашего сервиса `index.html`:

           {% cut "index.html" %}

           {% include [serverless-index-html-config](../../_includes/serverless/serverless-url-shortener/html-config.md) %}

           {% endcut %}

        1. Файл с кодом функции {{ sf-name }} `index.py`:

           {% cut "index.py" %}

           {% include [serverless-function-config](../../_includes/serverless/serverless-url-shortener/function-config.md) %}

           {% endcut %}

        1. Файл с параметрами окружения функции {{ sf-name }} `requirements.txt`:

           {% include [serverless-requirements](../../_includes/serverless/serverless-url-shortener/requirements.md) %}

     1. Создайте в папке архив `function.zip`, содержащий файлы `index.py` и `requirements.txt`.

     1. В файле `serverless-url-shortener.auto.tfvars` задайте пользовательские параметры:

          * `cloud_id` — [идентификатор облака](../../resource-manager/operations/cloud/get-id.md).
          * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
          * `bucket_name` — имя [бакета](../../storage/concepts/bucket.md), в котором будут создаваться ресурсы.

   {% endlist %}
   
   Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:
   
   * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
   * [Статический ключ](../../iam/concepts/authorization/access-key.md) — [yandex_iam_service_account_static_access_key]({{ tf-provider-resources-link }}/iam_service_account_static_access_key).
   * [Бакет](../../storage/concepts/bucket.md) — [yandex_storage_bucket]({{ tf-provider-resources-link }}/storage_bucket).
   * [Объект](../../storage/concepts/object.md) — [yandex_storage_object]({{ tf-provider-resources-link }}/storage_object).
   * [База данных {{ ydb-name }}](../../ydb/concepts/resources.md#database) — [yandex_ydb_database_serverless]({{ tf-provider-resources-link }}/ydb_database_serverless).
   * [Таблица {{ ydb-name }}](../../ydb/concepts/dynamodb-tables.md) — [yandex_ydb_table]({{ tf-provider-resources-link }}/ydb_table).
   * [Функция](../../functions/concepts/function.md) — [yandex_function]({{ tf-provider-resources-link }}/function).
   * [API-шлюз](../../api-gateway/concepts/index.md) — [yandex_api_gateway]({{ tf-provider-resources-link }}/api_gateway).

1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

1. Скопируйте `URL`, полученный в результате создания инфраструктуры, чтобы [проверить работу сокращателя ссылок](#test).

## Проверьте работу сокращателя ссылок {#test}

{% include [serverless-test-shortener](../../_includes/serverless/serverless-url-shortener/test-shortener.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `serverless-url-shortener.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}