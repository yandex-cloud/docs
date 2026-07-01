# Конвертация видео в GIF на Python с помощью консоли управления

Чтобы создать инфраструктуру для [конвертации видео в GIF на Python](index.md) с помощью консоли управления Yandex Cloud:

1. [Подготовьте облако к работе](#before-begin).
1. [Подготовьте ресурсы](#create-resources).
1. [Создайте API-функцию](#create-api-function).
1. [Создайте функцию-конвертер](#create-converter-function).
1. [Создайте триггер](#create-trigger).
1. [Проверьте работу приложения](#test-app).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:
* плата за вызовы [функций](../../../functions/concepts/function.md) ([тарифы Yandex Cloud Functions](../../../functions/pricing.md));
* плата за выполнение запросов к [базе данных](../../../ydb/concepts/serverless-and-dedicated.md) ([тарифы Yandex Managed Service for YDB](../../../ydb/pricing/serverless.md));
* плата за хранение данных в [бакете](../../concepts/bucket.md) ([тарифы Yandex Object Storage](../../../storage/pricing.md)).


## Подготовьте ресурсы {#create-resources}

1. Клонируйте [репозиторий](https://github.com/yandex-cloud-examples/yc-serverless-video-gif-converter) с конфигурационными файлами:

   ```bash
   git clone https://github.com/yandex-cloud-examples/yc-serverless-video-gif-converter.git
   ```

1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт с именем `ffmpeg-sa` и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему следующие роли:

   * `ymq.reader`;
   * `ymq.writer`;
   * `lockbox.payloadViewer`;
   * `storage.viewer`;
   * `storage.uploader`;
   * `ydb.admin`;
   * `functions.functionInvoker`.

1. [Создайте статический ключ](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) для сервисного аккаунта. Сохраните **Идентификатор ключа** и **Ваш секретный ключ**.
1. [Создайте секрет](../../../lockbox/operations/secret-create.md) с именем `ffmpeg-sa-secret` в Yandex Lockbox:

      1. Выберите **Тип секрета**: **Пользовательский**.
      1. Задайте две пары ключ-значение:

         * Ключ — `ACCESS_KEY_ID`, значение — **Идентификатор ключа** из предыдущего шага.
         * Ключ — `SECRET_ACCESS_KEY`, значение — **Ваш секретный ключ** из предыдущего шага.

         Сохраните **Идентификатор** секрета из блока **Информация о секрете**.

1. [Создайте очередь сообщений](../../../message-queue/operations/message-queue-new-queue.md) с именем `converter-queue` в Yandex Message Queue. Сохраните **URL** очереди из блока **Общая информация**.
1. [Создайте базу данных](../../../ydb/quickstart.md#serverless) YDB в режиме `Serverless`. Сохраните **Эндпоинт** из блока **Document API эндпоинт**.
1.  [Создайте таблицу](../../../ydb/operations/schema.md#create-table)  в базе данных:

    * **Имя** — `tasks`.
    * **Тип таблицы** — [Документная таблица](../../../ydb/operations/schema.md#create-table).
    * **Колонки** — одна колонка с именем `task_id` типа `String`. Установите атрибут [Ключ партицирования](../../../ydb/operations/schema.md#create-table).

1. [Создайте бакет](../../operations/buckets/create.md) с ограниченным доступом в Yandex Object Storage.


## Создайте API-функцию {#create-api-function}

В функции реализуется API, с помощью которого можно выполнять следующие действия:

* `convert`  — передать видео для конвертации. Функция записывает задачу в таблицу `tasks`  с помощью [Document API](../../../ydb/docapi/tools/aws-http.md). 
* `get_task_status` — узнать статус выполнения задачи. Функция проверяет, выполнена ли задача, и возвращает ссылку на GIF-файл.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Создайте](../../../functions/operations/function/function-create.md) функцию с именем `ffmpeg-api`.
  1. [Создайте](../../../functions/operations/function/version-manage.md) версию функции:

     1. Создайте файл `requirements.txt` и укажите в нем библиотеки:

        ```text
        boto3
        yandexcloud
        ```

     1. Создайте файл `index.py` и вставьте в него содержимое файла `ffmpeg-api.py` из архива `ffmpeg-api.zip`.
     1. Укажите следующие параметры:

        * **Среда выполнения** — `python312`.
        * **Точка входа** — `index.handle_api`.
        * **Таймаут** — `5`.
        * **Сервисный аккаунт** — `ffmpeg-sa`.

     1. Добавьте переменные окружения:

        * `DOCAPI_ENDPOINT` — **Эндпоинт** из конфигурации базы данных.
        * `SECRET_ID` — **Идентификатор** секрета Yandex Lockbox.
        * `YMQ_QUEUE_URL` — **URL** очереди Message Queue.

{% endlist %}


## Создайте функцию-конвертер {#create-converter-function}

Функция-конвертер запускается с помощью триггера и выполняет обработку видео, а также отмечает результат выполнения в таблице `tasks`.

Для преобразования видео используется утилита FFmpeg. Размер исполняемого файла FFmpeg — более 70 мегабайт. Чтобы загрузить его вместе с кодом функции, подготовьте ZIP-архив и загрузите его через Object Storage. Подробнее о [форматах загрузки кода](../../../functions/concepts/function.md).

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

  1. [Загрузите](../../operations/objects/upload.md) архив `src.zip` в бакет, созданный ранее.
  1. [Создайте](../../../functions/operations/function/version-manage.md) версию функции:

     1. Укажите следующие параметры:

        * **Среда выполнения** — `python312`.
        * **Источник кода** — способ загрузки `Object Storage`.
        * **Бакет** — имя созданного ранее бакета.
        * **Объект** — `src.zip`.
        * **Точка входа** — `index.handle_process_event`.
        * **Таймаут** — `600`.
        * **Память** — `2048 МБ`.
        * **Сервисный аккаунт** — `ffmpeg-sa`.

     1. Добавьте переменные окружения:

        * `DOCAPI_ENDPOINT` — **Эндпоинт** из конфигурации базы данных.
        * `SECRET_ID` — **Идентификатор** секрета Yandex Lockbox.
        * `YMQ_QUEUE_URL` — **URL** очереди Message Queue.
        * `S3_BUCKET` — имя бакета, созданного ранее.

{% endlist %}


## Создайте триггер {#create-trigger}

Обработка очереди сообщений выполняется с помощью [триггера для Message Queue](../../../functions/concepts/trigger/ymq-trigger.md). Он вызывает функцию-конвертер при поступлении сообщений в очередь `converter-queue`. 

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите создать триггер.
  1. Выберите сервис **Cloud Functions**.
  1. Перейдите на вкладку **Триггеры**.
  1. Нажмите кнопку **Создать триггер**.
  1. В блоке **Базовые параметры**:
     * Введите имя триггера — `ffmpeg-trigger`.
     * В поле **Тип** выберите `Message Queue`.
  1. В блоке **Настройки сообщений Message Queue** выберите очередь сообщений `converter-queue` и сервисный аккаунт с правами на чтение из нее — `ffmpeg-sa`.
  1. В блоке **Настройки функции**:
     * Выберите функцию, которую будет вызывать триггер — `ffmpeg-converter`.
     * Укажите [тег версии функции](../../../functions/concepts/function.md#tag) — `$latest`.
     * Укажите сервисный аккаунт, от имени которого будет вызываться функция — `ffmpeg-sa`.
  1. Нажмите кнопку **Создать триггер**.

{% endlist %}


## Проверьте работу приложения {#test-app}

### Создайте задачу {#create-task}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится функция `ffmpeg-api`.
  1. Выберите сервис **Cloud Functions**.
  1. Выберите функцию `ffmpeg-api`.
  1. Перейдите на вкладку **Тестирование**.
  1. В поле **Входные данные** введите:

     ```json
     {"action":"convert", "src_url":"<ссылка_на_видео>"}
     ```

     Где `<ссылка_на_видео>` — ссылка на сохраненный на [Яндекс Диске](https://disk.yandex.ru) видеофайл в формате [MP4](https://ru.wikipedia.org/wiki/MPEG-4_Part_14).

  1. Нажмите кнопку **Запустить тест**.
  1. В поле **Ответ функции** отобразится идентификатор задачи:

     ```json
     { "task_id": "c4269ceb-8d3a-40fe-95f0-84cf********" }
     ```

{% endlist %}

### Посмотрите статистику очереди {#ymq-stat}

После создания задачи число сообщений в очереди увеличивается на один, и срабатывает триггер. Проверьте, что сообщения поступают в очередь и обрабатываются. Для этого посмотрите статистику очереди.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится очередь `converter-queue`.
  1. Выберите сервис **Message Queue**.
  1. Выберите очередь `converter-queue`.
  1. В блоке **Общая информация** отображается количество сообщений в очереди и в обработке.
  1. Перейдите в раздел **Мониторинг**. Посмотрите графики **Overall queue stats**.

{% endlist %}

### Посмотрите логи функции {#function-logs}

Триггер должен вызывать функцию-конвертер для каждого сообщения в очереди. Чтобы проверить, что функция вызывается, посмотрите ее логи.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится функция `ffmpeg-converter`.
  1. Выберите сервис **Cloud Functions**.
  1. Выберите функцию `ffmpeg-converter`.
  1. Перейдите на вкладку **Логи** и укажите период, за который хотите посмотреть логи.

{% endlist %}

### Получите ссылку на GIF-файл {#get-link}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится функция `ffmpeg-api`.
  1. Выберите сервис **Cloud Functions**.
  1. Выберите функцию `ffmpeg-api`.
  1. Перейдите на вкладку **Тестирование**.
  1. В поле **Входные данные** введите запрос:

     ```json
     {"action":"get_task_status", "task_id":"<идентификатор_задачи>"}
     ```

  1. Нажмите кнопку **Запустить тест**.
  1. Если конвертация видео в GIF-файл не завершилась, в поле **Ответ функции** отобразится ответ:

     ```json
     {
         "ready": false
     }
     ```

     В противном случае вы получите ссылку на GIF-файл:

     ```json
     {
         "ready": true,
         "gif_url": "https://storage.yandexcloud.net/<имя_бакета>/1b4db1a6-f2b2-4b1c-b662-37f7********.gif?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=qxLftbbZ91U695ysemyZ%2F202********ru-central1%2Fs3%2Faws4_request&X-Amz-Date=20210831T110351Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=f4a5fe7848274a09be5b221fbf8a9f6f2b385708cfa351861a4e69df********"
     }
     ```

{% endlist %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../../message-queue/operations/message-queue-delete-queue.md) очередь `converter-queue`.
1. [Удалите](../../../ydb/operations/manage-databases.md#delete-db) базу данных.
1. [Удалите](../../operations/objects/delete.md) все объекты из бакета.
1. [Удалите](../../operations/buckets/delete.md) бакет.
1. [Удалите](../../../functions/operations/function/function-delete.md) функции `ffmpeg-api` и `ffmpeg-converter`.
1. [Удалите](../../../functions/operations/trigger/trigger-delete.md) триггер `ffmpeg-trigger`.

#### Полезные ссылки {#see-also}

* [Конвертация видео в GIF на Python с помощью Terraform](terraform.md)