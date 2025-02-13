# Конвертация видео в GIF на Python

Вы создадите видеоконвертер с использованием утилиты [FFmpeg](https://ffmpeg.org/) и сервиса {{ message-queue-full-name }}. Руководство предназначено для пользователей Linux и macOS.


[Смотреть видеоинструкцию о конвертировании с {{ message-queue-full-name }} на YouTube](https://www.youtube.com/watch?v=uyIMvEtr3cI).



Чтобы создать приложение:

1. [Подготовьте облако к работе](#before-begin).
1. [Подготовьте ресурсы](#create-resources).
1. [Создайте API-функцию](#create-api-function).
1. [Создайте функцию-конвертер](#create-converter-function).
1. [Создайте триггер](#create-trigger).
1. [Проверьте работу приложения](#test-app).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:

* плата за вызовы функций (см. [тарифы {{ sf-full-name }}](../../functions/pricing.md));
* плата за выполнение запросов к базе данных  (см. [тарифы {{ ydb-full-name }}](../../ydb/pricing/serverless.md)); 
* плата за хранение данных в бакете (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing.md)).

## Подготовьте ресурсы {#create-resources}

1. [Скачайте](https://{{ s3-storage-host }}/doc-files/video-converting.zip) архив с файлами, необходимыми для создания видеоконвертера.
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт с именем `ffmpeg-sa` и [назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему следующие роли:

   * `ymq.reader`;
   * `ymq.writer`;
   * `{{ roles-lockbox-payloadviewer }}`;
   * `storage.viewer`;
   * `storage.uploader`;
   * `ydb.admin`;
   * `{{ roles-functions-invoker }}`.

1. [Создайте статический ключ](../../iam/operations/sa/create-access-key.md) для сервисного аккаунта. Сохраните **Идентификатор ключа** и **Ваш секретный ключ**.
1. [Создайте секрет](../../lockbox/quickstart.md) с именем `ffmpeg-sa-secret` в {{ lockbox-name }}. В блоке **{{ ui-key.yacloud.lockbox.label_version-dialog-title }}** задайте:

   * Ключ — `ACCESS_KEY_ID`, значение — **Идентификатор ключа** из предыдущего шага.
   * Ключ — `SECRET_ACCESS_KEY`, значение — **Ваш секретный ключ** из предыдущего шага.

   Сохраните **{{ ui-key.yacloud.lockbox.label_secret-id }}** секрета из блока **{{ ui-key.yacloud.lockbox.label_secret-general-section }}**.

1. [Создайте очередь сообщений](../../message-queue/operations/message-queue-new-queue.md) с именем `converter-queue` в {{ message-queue-full-name }}. Сохраните **{{ ui-key.yacloud.ymq.queue.overview.label_url }}** очереди из блока **{{ ui-key.yacloud.ymq.queue.overview.section_base }}**.
1. [Создайте базу данных](../../ydb/quickstart.md#serverless) {{ ydb-short-name }} в режиме `{{ ui-key.yacloud.ydb.forms.label_serverless-type }}`. Сохраните **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** из блока **{{ ui-key.yacloud.ydb.overview.label_document-endpoint }}**.
1.  [Создайте таблицу](../../ydb/operations/schema.md#create-table)  в базе данных:

    * **{{ ui-key.yacloud.ydb.table.form.field_name }}** — `tasks`.
    * **{{ ui-key.yacloud.ydb.table.form.field_type }}** —  [{{ ui-key.yacloud.ydb.table.form.label_document-table }}](../../ydb/operations/schema.md#create-table). 
    * **{{ ui-key.yacloud.ydb.table.form.label_columns }}** — одна колонка с именем `task_id` типа `String`.  Установите атрибут [{{ ui-key.yacloud.ydb.table.form.column_shard }}](../../ydb/operations/schema.md#create-table). 

1. [Создайте бакет](../../storage/operations/buckets/create) с ограниченным доступом в {{ objstorage-full-name }}.

## Создайте API-функцию {#create-api-function}

В функции реализуется API, с помощью которого можно выполнять следующие действия:

* `convert` — передать видео для конвертации. Функция записывает задачу в таблицу `tasks`  с помощью [Document API](../../ydb/docapi/tools/aws-http.md). 
* `get_task_status` — узнать статус выполнения задачи. Функция проверяет, выполнена ли задача, и возвращает ссылку на GIF-файл.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Создайте](../../functions/operations/function/function-create.md) функцию с именем `ffmpeg-api`.
  1. [Создайте](../../functions/operations/function/version-manage.md) версию функции:

     1. Создайте файл `requirements.txt` и укажите в нем библиотеку:

        ```
        boto3
        ```

     1. Создайте файл `index.py` и вставьте в него содержимое файла `ffmpeg-api.py` из архива.
     1. Укажите следующие параметры:

        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}** — `python37`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** — `index.handle_api`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `5`.
        * **{{ ui-key.yacloud.forms.label_service-account-select }}** — `ffmpeg-sa`.

     1. Добавьте переменные окружения:

        * `DOCAPI_ENDPOINT` — **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** из конфигурации базы данных.
        * `SECRET_ID` — **{{ ui-key.yacloud.lockbox.label_secret-id }}** секрета {{ lockbox-name }}.
        * `YMQ_QUEUE_URL` — **{{ ui-key.yacloud.ymq.queue.overview.label_url }}** очереди {{ message-queue-name }}.

{% endlist %}

## Создайте функцию-конвертер {#create-converter-function}

Функция-конвертер запускается с помощью триггера и выполняет обработку видео, а также отмечает результат выполнения в таблице `tasks`.

Для преобразования видео используется утилита FFmpeg. Размер исполняемого файла FFmpeg более 70 мегабайт. Чтобы загрузить его вместе с кодом функции, подготовьте ZIP-архив и загрузите его через {{ objstorage-name }}. Подробнее о [форматах загрузки кода](../../functions/concepts/function.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Создайте](../../functions/operations/function/function-create.md) функцию с именем `ffmpeg-converter`.
  1. Подготовьте ZIP-архив `src.zip` со следующими файлами:

     * Файл `requirements.txt`:

       ```
       boto3
       requests
       ```
      
     * Файл `index.py` с содержимым файла `ffmpeg-converter.py` из архива.
     * Исполняемый файл FFmpeg. На [официальном сайте FFmpeg](http://ffmpeg.org/download.html), в разделе **Linux Static Builds**, загрузите архив с 64-битной версией FFmpeg и сделайте файл исполняемым, выполнив команду `chmod +x ffmpeg`.

  1. [Загрузите](../../storage/operations/objects/upload.md) архив `src.zip` в бакет, созданный ранее.
  1. [Создайте](../../functions/operations/function/version-manage.md) версию функции:

     1. Укажите следующие параметры:

        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}** — `python37`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** — способ загрузки `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-storage }}`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_bucket }}** — имя созданного ранее бакета.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_object }}** — `src.zip`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** — `index.handle_process_event`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `600`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}** — `2048 {{ ui-key.yacloud.common.units.label_megabyte }}`.
        * **{{ ui-key.yacloud.forms.label_service-account-select }}** — `ffmpeg-sa`.

     1. Добавьте переменные окружения:

        * `DOCAPI_ENDPOINT` — **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** из конфигурации базы данных;
        * `SECRET_ID` — **{{ ui-key.yacloud.lockbox.label_secret-id }}** секрета {{ lockbox-name }};
        * `YMQ_QUEUE_URL` — **{{ ui-key.yacloud.ymq.queue.overview.label_url }}** очереди {{ message-queue-name }};
        * `S3_BUCKET` — имя бакета, созданного ранее.

{% endlist %}

## Создайте триггер {#create-trigger}

Обработка очереди сообщений выполняется с помощью [триггера для {{ message-queue-name }}](../../functions/concepts/trigger/ymq-trigger.md). Он вызывает функцию-конвертер при поступлении сообщений в очередь `converter-queue`. 

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:
     * Введите имя триггера — `ffmpeg-trigger`.
     * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_ymq }}`.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_ymq }}** выберите очередь сообщений `converter-queue` и сервисный аккаунт c правами на чтение из нее — `ffmpeg-sa`.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**:
     * Выберите функцию, которую будет вызывать триггер — `ffmpeg-converter`.
     * Укажите [тег версии функции](../../functions/concepts/function.md#tag) — `$latest`.
     * Укажите сервисный аккаунт, от имени которого будет вызываться функция — `ffmpeg-sa`.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

{% endlist %}

## Проверьте работу приложения {#test-app}

### Создайте задачу {#create-task}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится функция `ffmpeg-api`.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Выберите функцию `ffmpeg-api`.
  1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}**.
  1. В поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_payload }}** введите:

     ```json
     {"action":"convert", "src_url":"<ссылка_на_видео>"}
     ```

     Где `<ссылка_на_видео>` — ссылка на сохраненный на [Яндекс Диске](https://disk.yandex.ru) видеофайл в формате [MP4](https://ru.wikipedia.org/wiki/MPEG-4_Part_14).

  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}**.
  1. В поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_function-output }}** отобразится идентификатор задачи:

     ```json
     { "task_id": "c4269ceb-8d3a-40fe-95f0-84cf********" }
     ```

{% endlist %}

### Посмотрите статистику очереди {#ymq-stat}

После создания задачи число сообщений в очереди увеличивается на один и срабатывает триггер. Проверьте, что сообщения поступают в очередь и обрабатываются. Для этого посмотрите статистику очереди.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится очередь `converter-queue`.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
  1. Выберите очередь `converter-queue`.
  1. В блоке **{{ ui-key.yacloud.ymq.queue.overview.section_base }}** отображается количество сообщений в очереди и обработке.
  1. Перейдите в раздел **{{ ui-key.yacloud.common.monitoring }}**. Посмотрите графики **Overall queue stats**.

{% endlist %}

### Посмотрите логи функции {#function-logs}

Триггер должен вызывать функцию-конвертер для каждого сообщения в очереди. Чтобы проверить, что функция вызывается, посмотрите ее логи.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится функция `ffmpeg-converter`.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Выберите функцию `ffmpeg-converter`.
  1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-functions.item.switch_logs }}** и укажите период, за который хотите их посмотреть.

{% endlist %}

### Получите ссылку на GIF-файл {#get-link}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится функция `ffmpeg-api`.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Выберите функцию `ffmpeg-api`.
  1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}**.
  1. В поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_payload }}** введите запрос:

     ```json
     {"action":"get_task_status", "task_id":"<идентификатор_задачи>"}
     ```

  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}**.
  1. Если конвертация видео в GIF-файл не завершилась, в поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_function-output }}** отобразится ответ:

     ```json
     {
         "ready": false
     }
     ```

     В противном случае вы получите ссылку на GIF-файл:

     ```json
     {
         "ready": true,
         "gif_url": "https://{{ s3-storage-host }}/<имя_бакета>/1b4db1a6-f2b2-4b1c-b662-37f7********.gif?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=qxLftbbZ91U695ysemyZ%2F202********{{ region-id }}%2Fs3%2Faws4_request&X-Amz-Date=20210831T110351Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=f4a5fe7848274a09be5b221fbf8a9f6f2b385708cfa351861a4e69df********"
     }
     ```

{% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу инфраструктуры и перестать платить за созданные ресурсы:

1. [Удалите](../../message-queue/operations/message-queue-delete-queue.md) очередь `converter-queue`.
1. [Удалите](../../ydb/operations/manage-databases.md#delete-db) базу данных.
1. [Удалите](../../storage/operations/objects/delete.md) все объекты из бакета.
1. [Удалите](../../storage/operations/buckets/delete.md) бакет.
1. [Удалите](../../functions/operations/function/function-delete.md) функции `ffmpeg-api` и `ffmpeg-converter`.
1. [Удалите](../../functions/operations/trigger/trigger-delete.md) триггер `ffmpeg-trigger`.
