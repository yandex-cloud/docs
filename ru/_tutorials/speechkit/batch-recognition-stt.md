# Регулярное распознавание аудиофайлов из {{ objstorage-full-name }}

В [API асинхронного распознавания](../../speechkit/stt/api/transcribation-api.md) {{ speechkit-short-name }} реализована интеграция с сервисом {{ objstorage-full-name }}. С ее помощью можно настроить автоматическое распознавание аудиофайлов [поддерживаемых форматов](../../speechkit/formats.md), регулярно загружаемых в бакет {{ objstorage-name }}. Облачная функция в сервисе {{ sf-full-name }} периодически проверяет наличие аудиофайлов в бакете и отправляет их в API {{ speechkit-short-name }} для распознавания. Результат и статус распознавания сохраняются в тот же бакет {{ objstorage-name }}.

Чтобы настроить автоматическое распознавание аудиофайлов с помощью {{ speechkit-short-name }}:

1. [Создайте облачную функцию](#create-function) для чтения файлов из бакета {{ objstorage-name }}, отправки в API и проверки статуса распознавания файлов.
1. [Создайте триггер](#create-trigger) для периодического запуска облачной функции.
1. [Проверьте работу функции](#check-function).

## Перед началом работы {#before-you-begin}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт с именем `asr-batch-sa`.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роли `storage.editor`, `{{ roles-functions-invoker }}` и `{{ roles-speechkit-stt }}` на каталог, в котором аккаунт был создан.
1. [Создайте](../../iam/operations/sa/create-access-key.md) статический ключ доступа для сервисного аккаунта.
1. [Создайте](../../iam/operations/api-key/create.md) API-ключ доступа для сервисного аккаунта.
1. [Создайте](../../storage/operations/buckets/create.md) бакет {{ objstorage-name }} с именем `asr-batch-bucket` в каталоге сервисного аккаунта.
1. Откройте бакет `asr-batch-bucket`, нажмите кнопку **{{ ui-key.yacloud.storage.bucket.button_create }}** и укажите в поле **{{ ui-key.yacloud.storage.bucket.popup-create-folder_field_name}}** значение `input`.
1. [Загрузите](../../storage/operations/objects/upload.md#simple) в папку `input` бакета файл `config.json` с заданным [языком распознавания](../../speechkit/stt/models.md#languages). Файл содержит только один параметр:

   ```json
   {
     "lang": "<код_языка>"
   }
   ```

   {% note info %}

   Если файл `config.json` отсутствует в бакете, для распознавания используется русский язык.

   {% endnote %}

## Создайте облачную функцию {#create-function}

1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где был создан сервисный аккаунт.
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}** и укажите имя функции `asr-batch-function`.
1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.create.button_create }}**.
1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}** выберите среду выполнения `Python` версии `3.8` и нажмите **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
1. Скачайте из репозитория {{ yandex-cloud }} [файл со скриптом](https://github.com/yandex-cloud-examples/yc-speechkit-async-recognizer/blob/main/python/main.py).
1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-source }}** удалите содержимое файла `index.py` и вставьте скачанный скрипт.
1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-source }}** создайте файл `requirements.txt` и добавьте в него код:

   ```text
   boto3
   botocore
   requests
   ```

1. Укажите параметры запуска функции:
   * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** — `index.handler`.
   * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `60`.
   * **{{ ui-key.yacloud.forms.label_service-account-select }}** – `asr-batch-sa`.
1. Добавьте переменные окружения:
   * `S3_BUCKET` – `asr-batch-bucket`.
   * `S3_PREFIX` – `input`.
   * `S3_PREFIX_LOG` – `log`.
   * `S3_PREFIX_OUT` – `out`.
   * `S3_KEY` – ID статического ключа доступа.
   * `S3_SECRET` – секрет статического ключа доступа.
   * `API_KEY` – ID API-ключа.
   * `API_SECRET` – секрет API-ключа.

1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

## Создайте триггер {#create-trigger}

1. В консоли управления выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
1. Выберите **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
1. Нажмите **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
1. Укажите параметры триггера:
   * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_name }}** – `asr-batch-cron`.
   * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** – `{{ ui-key.yacloud.serverless-functions.triggers.form.label_timer }}`.
   * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** – `{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}`.
   * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cron-expression }}** – `{{ ui-key.yacloud.common.button_cron-1min }}`.
   * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function }}** – `asr-batch-function`.
   * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function-tag }}** – `$latest`.
   * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_service-account }}** – `asr-batch-sa`.
1. Нажмите **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

Созданный триггер будет срабатывать ежеминутно и запускать [облачную функцию](#create-function).

## Проверьте работу функции {#check-function}

1. В консоли управления выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** и откройте бакет `asr-batch-bucket`.
1. [Загрузите](../../storage/operations/objects/upload.md#simple) в папку `input` аудиофайлы любого [поддерживаемого формата](../../speechkit/formats.md).
1. Подождите несколько минут и убедитесь, что в бакете появились папки `log` и `out`.
1. Проверьте статус распознавания в папке `log`. Для каждого из отправленных на распознавание аудиофайлов статус сохраняется во вспомогательном файле `<имя_аудиофайла>.json` (например, `audio.mp3.json`). Если в файле содержится параметр `"done": "false"`, то процесс распознавания не завершен.
1. Проверьте результат распознавания в папке `out`. Результат сохраняется в формате JSON в файле с именем `<имя_аудиофайла>.json` (например, `audio.mp3.json`). Подробнее о формате результата распознавания см. раздел [API асинхронного распознавания](../../speechkit/stt/api/transcribation-api.md#get-result-response).

{% note info %}

Для мониторинга выполнения скрипта можно [посмотреть логи функции](../../functions/operations/function/function-logs.md) `asr-batch-function`.

{% endnote %}


#### См. также {#see-also}

* [{#T}](../../speechkit/stt/api/transcribation-api.md)
* [{#T}](../../speechkit/stt/api/transcribation-lpcm.md)
* [{#T}](../../speechkit/stt/api/transcribation-ogg.md)
