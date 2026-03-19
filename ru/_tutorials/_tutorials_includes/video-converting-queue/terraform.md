1. [Подготовьте облако к работе](#before-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Создайте таблицу](#create-table).
1. [Проверьте работу приложения](#test-app).


## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](paid-resources.md) %}


## Создайте инфраструктуру {#deploy}

{% include [terraform-definition](../terraform-definition.md) %}

Для создания инфраструктуры с помощью {{ TF }}:
1. [Установите {{ TF }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовая конфигурация {#ready}

     1. Клонируйте репозиторий с конфигурационными файлами.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-serverless-video-gif-converter.git
        ```

     1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
        * `video-converting.tf` — конфигурация создаваемой инфраструктуры.
        * `ffmpeg-api.zip` — архив с API-функцией.
        * `src.zip` — архив с функцией-конвертером.

   - Вручную {#manual}

     1. Создайте папку для конфигурационных файлов.
     1. Создайте в папке:
        1. Конфигурационный файл `video-converting.tf`:

           {% cut "video-converting.tf" %}

           {% include [video-converting-tfconfig](video-converting-tfconfig.md) %}

           {% endcut %}

        1. Для API-функции:
           1. Создайте файл `index.py` и вставьте в него содержимое:

              {% cut "index.py для API-функции" %}

              {% include [index-api-code](index-api-code.md) %}

              {% endcut %}

           1. Создайте файл `requirements.txt` и укажите в нем библиотеки:

               ```text
               boto3
               yandexcloud
               ```

           1. Создайте в папке архив `ffmpeg-api.zip`, содержащий файлы `index.py` и `requirements.txt`.

        1. Для функции-конвертера:
           1. Создайте файл `index.py` и вставьте в него содержимое:

              {% cut "index.py для функции-конвертера" %}

              {% include [index-converter-code](index-converter-code.md) %}

              {% endcut %}

           1. Создайте файл `requirements.txt` и укажите в нем библиотеки:

               ```text
               boto3
               requests
               yandexcloud
               ```

           1. Подготовьте исполняемый файл FFmpeg. На [официальном сайте FFmpeg](http://ffmpeg.org/download.html) в разделе **Linux Static Builds** загрузите архив с 64-битной версией FFmpeg и сделайте файл исполняемым, выполнив команду `chmod +x ffmpeg`.

           1. Создайте в папке архив `src.zip`, содержащий файлы `index.py` и `requirements.txt`, и исполняемый файл FFmpeg.

   {% endlist %}

   Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:
   * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
   * [Роль](../../../iam/concepts/access-control/roles.md) — [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member)
   * [Секрет](../../../lockbox/concepts/secret.md) — [yandex_lockbox_secret]({{ tf-provider-resources-link }}/lockbox_secret)
   * [Версия секрета](../../../lockbox/concepts/secret.md#version) — [yandex_lockbox_secret_version]({{ tf-provider-resources-link }}/yandex_lockbox_secret_version)
   * [Очередь сообщений](../../../message-queue/concepts/queue.md) — [yandex_message_queue]({{ tf-provider-resources-link }}/message_queue)
   * [База данных YDB](../../../message-queue/concepts/queue.md) — [yandex_ydb_database_serverless]({{ tf-provider-resources-link }}/ydb_database_serverless)
   * [Бакет](../../../storage/concepts/bucket.md) — [yandex_storage_bucket]({{ tf-provider-resources-link }}/yandex_storage_bucket)
   * [Объект бакета](../../../storage/concepts/object.md) — [yandex_storage_object]({{ tf-provider-resources-link }}/yandex_storage_object)
   * [Функция](../../../functions/concepts/function.md) — [yandex_function]({{ tf-provider-resources-link }}/yandex_function)
   * [Триггер](../../../functions/concepts/trigger/ymq-trigger.md) — [yandex_function_trigger]({{ tf-provider-resources-link }}/yandex_function_trigger)

1. В файле `video-converting.tf` задайте пользовательские параметры:
   * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
   * `bucket` — имя бакета.

1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../terraform-validate-plan-apply.md) %}

После создания инфраструктуры [создайте таблицу](#create-table) в базе данных YDB.




## Создайте таблицу {#create-table}

1.  [Создайте таблицу](../../../ydb/operations/schema.md#create-table)  в базе данных YDB:

    * **{{ ui-key.yacloud.ydb.table.form.field_name }}** — `tasks`.
    * **{{ ui-key.yacloud.ydb.table.form.field_type }}** — [{{ ui-key.yacloud.ydb.table.form.label_document-table }}](../../../ydb/operations/schema.md#create-table).
    * **{{ ui-key.yacloud.ydb.table.form.label_columns }}** — одна колонка с именем `task_id` типа `String`. Установите атрибут [{{ ui-key.yacloud.ydb.table.form.column_shard }}](../../../ydb/operations/schema.md#create-table).

После создания таблицы [проверьте работу приложения](#test-app).



## Проверьте работу приложения {#test-app}

{% include [test-app](test-app.md) %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `video-converting.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../terraform-validate-plan-apply.md) %}
