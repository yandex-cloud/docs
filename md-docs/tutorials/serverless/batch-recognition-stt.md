[Документация Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > [Бессерверные технологии](index.md) > Рабочие процессы и автоматизация на Serverless > Регулярное распознавание аудиофайлов из Object Storage

# Регулярное распознавание аудиофайлов из Yandex Object Storage

# Регулярное распознавание аудиофайлов из Yandex Object Storage


В [API асинхронного распознавания](https://aistudio.yandex.ru/docs/ru/speechkit/stt/api/transcribation-api) SpeechKit реализована интеграция с сервисом Yandex Object Storage. С ее помощью можно настроить автоматическое распознавание аудиофайлов [поддерживаемых форматов](https://aistudio.yandex.ru/docs/ru/speechkit/formats), регулярно загружаемых в бакет Object Storage. Облачная функция в сервисе Yandex Cloud Functions периодически проверяет наличие аудиофайлов в бакете и отправляет их в API SpeechKit для распознавания. Результат и статус распознавания сохраняются в тот же бакет Object Storage.

Чтобы настроить автоматическое распознавание аудиофайлов с помощью SpeechKit:

1. [Создайте облачную функцию](#create-function) для чтения файлов из бакета Object Storage, отправки в API и проверки статуса распознавания файлов.
1. [Создайте триггер](#create-trigger) для периодического запуска облачной функции.
1. [Проверьте работу функции](#check-function).

## Перед началом работы {#before-you-begin}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт с именем `asr-batch-sa`.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роли `storage.editor`, `functions.functionInvoker` и `ai.speechkit-stt.user` на каталог, в котором аккаунт был создан.
1. [Создайте](../../iam/operations/authentication/manage-access-keys.md#create-access-key) статический ключ доступа для сервисного аккаунта.


1. [Создайте](../../iam/operations/authentication/manage-api-keys.md#create-api-key) API-ключ доступа для сервисного аккаунта.
1. [Создайте](../../storage/operations/buckets/create.md) бакет Object Storage с именем `asr-batch-bucket` в каталоге сервисного аккаунта.
1. Откройте бакет `asr-batch-bucket`, нажмите кнопку **Создать папку** и укажите в поле **Имя папки** значение `input`.
1. [Загрузите](../../storage/operations/objects/upload.md#simple) в папку `input` бакета файл `config.json` с заданным [языком распознавания](https://aistudio.yandex.ru/docs/ru/speechkit/stt/models#languages). Файл содержит только один параметр:

   ```json
   {
     "lang": "<код_языка>"
   }
   ```

   {% note info %}

   Если файл `config.json` отсутствует в бакете, для распознавания используется русский язык.

   {% endnote %}

## Создайте облачную функцию {#create-function}

1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором был создан сервисный аккаунт.
1. Перейдите в сервис **Cloud Functions**.
1. Нажмите кнопку **Создать функцию** и укажите имя функции `asr-batch-function`.
1. Нажмите кнопку **Создать**.
1. В блоке **Редактор** выберите среду выполнения `Python` версии `3.8` и нажмите **Продолжить**.
1. Скачайте из репозитория Yandex Cloud [файл со скриптом](https://github.com/yandex-cloud-examples/yc-speechkit-async-recognizer/blob/main/examples/asr-batch-function/functions/main.py).
1. В блоке **Код функции** удалите содержимое файла `index.py` и вставьте скачанный скрипт.
1. В блоке **Код функции** создайте файл `requirements.txt` и добавьте в него код:

   ```text
   boto3
   botocore
   requests
   ```

1. Укажите параметры запуска функции:
   * **Точка входа** — `index.handler`.
   * **Таймаут** — `60`.
   * **Сервисный аккаунт** – `asr-batch-sa`.
1. Добавьте переменные окружения:
   * `S3_BUCKET` – `asr-batch-bucket`.
   * `S3_PREFIX` – `input`.
   * `S3_PREFIX_LOG` – `log`.
   * `S3_PREFIX_OUT` – `out`.
   * `S3_KEY` – ID статического ключа доступа.
   * `S3_SECRET` – секрет статического ключа доступа.
   * `API_KEY` – ID API-ключа.
   * `API_SECRET` – секрет API-ключа.

1. Нажмите кнопку **Сохранить изменения**.

## Создайте триггер {#create-trigger}

1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором была создана функция.
1. Перейдите в сервис **Cloud Functions**.
1. Выберите **Триггеры**.
1. Нажмите **Создать триггер**.
1. Укажите параметры триггера:
   * **Имя** – `asr-batch-cron`.
   * **Тип** – `Таймер`.
   * **Запускаемый ресурс** – `Функция`.
   * **Cron-выражение** – `Каждую минуту`.
   * **Функция** – `asr-batch-function`.
   * **Тег версии функции** – `$latest`.
   * **Сервисный аккаунт** – `asr-batch-sa`.
1. Нажмите **Создать триггер**.

Созданный триггер будет срабатывать ежеминутно и запускать [облачную функцию](#create-function).

## Проверьте работу функции {#check-function}

1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором была создана функция.
1. Перейдите в сервис **Object Storage** и откройте бакет `asr-batch-bucket`.
1. [Загрузите](../../storage/operations/objects/upload.md#simple) в папку `input` аудиофайлы любого [поддерживаемого формата](https://aistudio.yandex.ru/docs/ru/speechkit/formats).
1. Подождите несколько минут и убедитесь, что в бакете появились папки `log` и `out`.
1. Проверьте статус распознавания в папке `log`. Для каждого из отправленных на распознавание аудиофайлов статус сохраняется во вспомогательном файле `<имя_аудиофайла>.json` (например, `audio.mp3.json`). Если в файле содержится параметр `"done": "false"`, то процесс распознавания не завершен.
1. Проверьте результат распознавания в папке `out`. Результат сохраняется в формате JSON в файле с именем `<имя_аудиофайла>.json` (например, `audio.mp3.json`). Подробнее о формате результата распознавания смотрите в разделе [API асинхронного распознавания](https://aistudio.yandex.ru/docs/ru/speechkit/stt/api/transcribation-api#get-result-response).

{% note info %}

Для мониторинга выполнения скрипта можно [посмотреть логи функции](../../functions/operations/function/function-logs.md) `asr-batch-function`.

{% endnote %}


#### Полезные ссылки {#see-also}


* [API v2 асинхронного распознавания](https://aistudio.yandex.ru/docs/ru/speechkit/stt/api/transcribation-api)
* [Асинхронное распознавание аудиофайлов в формате LPCM в API v2](https://aistudio.yandex.ru/docs/ru/speechkit/stt/api/transcribation-lpcm)
* [Асинхронное распознавание аудиофайлов в формате OggOpus в API v2](https://aistudio.yandex.ru/docs/ru/speechkit/stt/api/transcribation-ogg)