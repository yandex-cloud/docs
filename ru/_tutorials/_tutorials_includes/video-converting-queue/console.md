1. [Подготовьте облако к работе](#before-begin).
1. [Подготовьте ресурсы](#create-resources).
1. [Создайте API-функцию](#create-api-function).
1. [Создайте функцию-конвертер](#create-converter-function).
1. [Создайте триггер](#create-trigger).
1. [Проверьте работу приложения](#test-app).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](paid-resources.md) %}

## Подготовьте ресурсы {#create-resources}

1. Клонируйте [репозиторий](https://github.com/yandex-cloud-examples/yc-serverless-video-gif-converter) с конфигурационными файлами:

   ```bash
   git clone https://github.com/yandex-cloud-examples/yc-serverless-video-gif-converter.git
   ```

1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт `ffmpeg-sa` и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему роли:

   * `ymq.reader`;
   * `ymq.writer`;
   * `{{ roles-lockbox-payloadviewer }}`;
   * `storage.viewer`;
   * `storage.uploader`;
   * `ydb.admin`;
   * `{{ roles-functions-invoker }}`.

1. [Создайте статический ключ](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) для сервисного аккаунта. Сохраните идентификатор ключа и секретный ключ.
1. [Создайте секрет](../../../lockbox/operations/secret-create.md) `ffmpeg-sa-secret` в {{ lockbox-name }}:

      1. Выберите тип секрета **{{ ui-key.yacloud.lockbox.FormFields.title_secret-type-custom }}**.
      1. Задайте две пары ключ-значение:

         * Ключ — `ACCESS_KEY_ID`, значение — идентификатор ключа из предыдущего шага.
         * Ключ — `SECRET_ACCESS_KEY`, значение — секретный ключ из предыдущего шага.

         Сохраните идентификатор секрета из блока **{{ ui-key.yacloud.lockbox.SecretOverviewPage.label_secret-general-section }}**.

1. [Создайте очередь сообщений](../../../message-queue/operations/message-queue-new-queue.md) `converter-queue` в {{ message-queue-full-name }}. Перейдите в созданную очередь и сохраните значение поля **{{ ui-key.yacloud.ymq.queue.overview.label_url }}** из блока **{{ ui-key.yacloud.ymq.queue.overview.section_base }}**.
1. [Создайте базу данных](../../../ydb/quickstart.md#serverless) {{ ydb-short-name }} в режиме `{{ ui-key.yacloud.ydb.forms.label_serverless-type }}`. Перейдите в созданную БД и сохраните значение поля **{{ ui-key.yacloud.ydb.overview.label_document-endpoint }}** из блока **{{ ui-key.yacloud.ydb.overview.section_connection }}**.
1. [Создайте таблицу](../../../ydb/operations/schema.md#create-table) в базе данных:

    * **{{ ui-key.yacloud.ydb.table.form.field_name }}** — `tasks`.
    * **{{ ui-key.yacloud.ydb.table.form.field_type }}** — [{{ ui-key.yacloud.ydb.table.form.label_document-table }}](../../../ydb/operations/schema.md#create-table).
    * **{{ ui-key.yacloud.ydb.table.form.label_columns }}** — одна колонка с именем `task_id` типа `String`. Установите атрибут [{{ ui-key.yacloud.ydb.table.form.column_shard }}](../../../ydb/operations/schema.md#create-table).

1. [Создайте бакет](../../../storage/operations/buckets/create) с ограниченным доступом в {{ objstorage-full-name }}.


## Создайте API-функцию {#create-api-function}

В функции реализуется API, с помощью которого можно выполнять следующие действия:

* `convert`  — передать видео для конвертации. Функция записывает задачу в таблицу `tasks`  с помощью [Document API](../../../ydb/docapi/tools/aws-http.md). 
* `get_task_status` — узнать статус выполнения задачи. Функция проверяет, выполнена ли задача, и возвращает ссылку на GIF-файл.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Создайте функцию](../../../functions/operations/function/function-create.md) с именем `ffmpeg-api`.
  1. [Создайте версию функции](../../../functions/operations/function/version-manage.md):

     1. Создайте файл `requirements.txt` и укажите в нем библиотеки:

        ```text
        boto3
        requests
        yandexcloud
        ```

     1. Создайте файл `index.py` и вставьте в него содержимое файла `index.py` из архива `ffmpeg-api.zip`.

        Также можно загрузить готовый архив `ffmpeg-api.zip` на странице создания версии функции.

     1. Укажите параметры:

        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}** — `python312`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** — `index.handle_api`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `5`.
        * **{{ ui-key.yacloud.forms.label_service-account-select }}** — `ffmpeg-sa`.

     1. Добавьте переменные окружения:

        * `DOCAPI_ENDPOINT` — **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** из конфигурации базы данных.
        * `SECRET_ID` — **{{ ui-key.yacloud.lockbox.SecretOverviewPage.label_secret-id }}** секрета {{ lockbox-name }}.
        * `YMQ_QUEUE_URL` — **{{ ui-key.yacloud.ymq.queue.overview.label_url }}** очереди {{ message-queue-name }}.

{% endlist %}


## Создайте функцию-конвертер {#create-converter-function}

Функция-конвертер запускается с помощью триггера и выполняет обработку видео, а также отмечает результат выполнения в таблице `tasks`.

Для преобразования видео используется утилита FFmpeg. Размер исполняемого файла FFmpeg — более 70 мегабайт. Чтобы загрузить его вместе с кодом функции, подготовьте ZIP-архив и загрузите его через {{ objstorage-name }}. Подробнее о [форматах загрузки кода](../../../functions/concepts/function.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Создайте](../../../functions/operations/function/function-create.md) функцию с именем `ffmpeg-converter`.
  1. Подготовьте ZIP-архив `src.zip` со следующими файлами:

     * Файл `requirements.txt`:

       ```text
       boto3
       requests
       yandexcloud
       ```
      
     * Файл `index.py` с содержимым файла `ffmpeg-converter.py` из архива `src.zip`.
     * Исполняемый файл FFmpeg. На [официальном сайте FFmpeg](http://ffmpeg.org/download.html) в разделе **Linux Static Builds** загрузите архив с 64-битной версией FFmpeg и сделайте файл исполняемым, выполнив команду `chmod +x ffmpeg`.

  1. [Загрузите архив](../../../storage/operations/objects/upload.md) `src.zip` в бакет, созданный ранее.
  1. [Создайте версию функции](../../../functions/operations/function/version-manage.md):

     1. Укажите параметры:

        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}** — `python312`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_code-source }}** — способ загрузки `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-storage }}`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_bucket }}** — имя созданного ранее бакета.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_object }}** — `src.zip`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** — `index.handle_process_event`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `600`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}** — `2048 {{ ui-key.yacloud.common.units.label_megabyte }}`.
        * **{{ ui-key.yacloud.forms.label_service-account-select }}** — `ffmpeg-sa`.

     1. Добавьте переменные окружения:

        * `DOCAPI_ENDPOINT` — Document API эндпоинт из конфигурации базы данных.
        * `SECRET_ID` — идентификатор секрета {{ lockbox-name }}.
        * `YMQ_QUEUE_URL` — URL очереди {{ message-queue-name }}.
        * `S3_BUCKET` — имя бакета.

{% endlist %}


## Создайте триггер {#create-trigger}

Обработка очереди сообщений выполняется с помощью [триггера для {{ message-queue-name }}](../../../functions/concepts/trigger/ymq-trigger.md). Он вызывает функцию-конвертер при поступлении сообщений в очередь `converter-queue`. 

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать триггер.
  1. [Перейдите]({{ link-console-main }}/link/functions) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}** и выберите созданную функцию.
  1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:
     * Введите имя триггера `ffmpeg-trigger`.
     * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_ymq }}`.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_ymq }}** выберите очередь сообщений `converter-queue` и сервисный аккаунт `ffmpeg-sa` с правами на чтение из очереди.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**:
     * Выберите функцию `ffmpeg-converter`.
     * Укажите [тег версии функции](../../../functions/concepts/function.md#tag) `$latest`.
     * Укажите сервисный аккаунт `ffmpeg-sa`, от имени которого будет вызываться функция.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

{% endlist %}


## Проверьте работу приложения {#test-app}

{% include [test-app](test-app.md) %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../../message-queue/operations/message-queue-delete-queue.md) очередь `converter-queue`.
1. [Удалите](../../../ydb/operations/manage-databases.md#delete-db) базу данных.
1. [Удалите](../../../storage/operations/objects/delete.md) все объекты из бакета.
1. [Удалите](../../../storage/operations/buckets/delete.md) бакет.
1. [Удалите](../../../functions/operations/function/function-delete.md) функции `ffmpeg-api` и `ffmpeg-converter`.
1. [Удалите](../../../functions/operations/trigger/trigger-delete.md) триггер `ffmpeg-trigger`.
