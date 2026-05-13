# Конвертация видео в GIF на Python с помощью Terraform

Чтобы создать инфраструктуру для [конвертации видео в GIF на Python](index.md) с помощью Terraform:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Создайте таблицу](#create-table).
1. [Проверьте работу приложения](#test-app).


## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:
* плата за вызовы [функций](../../../functions/concepts/function.md) (см. [тарифы Yandex Cloud Functions](../../../functions/pricing.md));
* плата за выполнение запросов к [базе данных](../../../ydb/concepts/serverless-and-dedicated.md) (см. [тарифы Yandex Managed Service for YDB](../../../ydb/pricing/serverless.md));
* плата за хранение данных в [бакете](../../../storage/concepts/bucket.md) (см. [тарифы Yandex Object Storage](../../../storage/pricing.md)).


## Создайте инфраструктуру {#deploy}

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

Для создания инфраструктуры с помощью Terraform:
1. [Установите Terraform](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера Yandex Cloud (раздел [Настройте провайдер](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
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

           ```hcl
           # Объявление переменных
           
           locals {
             folder_id   = "<идентификатор_каталога>"
             bucket_name = "<имя_бакета>"
           }
           
           # Настройка провайдера
           
           terraform {
             required_providers {
               yandex = {
                 source  = "yandex-cloud/yandex"
               }
             }
           }
           
           provider "yandex" {
             folder_id = local.folder_id
           }
           
           # Создание сервисного аккаунта и назначение ему ролей
           
           resource "yandex_iam_service_account" "sa" {
             name = "ffmpeg-sa"
           }
           
           resource "yandex_resourcemanager_folder_iam_member" "ymq-reader" {
             folder_id = local.folder_id
             role      = "ymq.reader"
             member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
           }
           
           resource "yandex_resourcemanager_folder_iam_member" "ymq-writer" {
             folder_id = local.folder_id
             role      = "ymq.writer"
             member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
           }
           
           resource "yandex_resourcemanager_folder_iam_member" "lockbox-payload-viewer" {
             folder_id = local.folder_id
             role      = "lockbox.payloadViewer"
             member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
           }
           
           resource "yandex_resourcemanager_folder_iam_member" "storage-editor" {
             folder_id = local.folder_id
             role      = "storage.editor"
             member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
           }
           
           resource "yandex_resourcemanager_folder_iam_member" "storage-uploader" {
             folder_id = local.folder_id
             role      = "storage.uploader"
             member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
           }
           
           resource "yandex_resourcemanager_folder_iam_member" "ydb-admin" {
             folder_id = local.folder_id
             role      = "ydb.admin"
             member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
           }
           
           resource "yandex_resourcemanager_folder_iam_member" "serverless-functions-invoker" {
             folder_id = local.folder_id
             role      = "serverless.functions.invoker"
             member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
           }
           
           # Создание статического ключа для сервисного аккаунта
           
           resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
             service_account_id = yandex_iam_service_account.sa.id
             description        = "static access key for database, message queue and bucket"
           }
           
           # Создание секрета
           
           resource "yandex_lockbox_secret" "secretmq" {
             name = "ffmpeg-sa-secret"
           }
           
           resource "yandex_lockbox_secret_version" "my_version" {
             secret_id = yandex_lockbox_secret.secretmq.id
             entries {
               key        = "ACCESS_KEY_ID"
               text_value = yandex_iam_service_account_static_access_key.sa-static-key.access_key
             }
               entries {
               key        = "SECRET_ACCESS_KEY"
               text_value = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
             }
           }
           
           # Создание очереди сообщений
           
           resource "yandex_message_queue" "converter_queue" {
             name                       = "converter-queue"
             visibility_timeout_seconds = 600
             message_retention_seconds  = 1209600
             receive_wait_time_seconds  = 20
           
             access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
             secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
             depends_on = [ yandex_resourcemanager_folder_iam_member.ymq-writer ]
           }
           
           # Создание базы данных
           
           resource "yandex_ydb_database_serverless" "api_db" {
             name        = "db-converter"
             location_id = "ru-central1"
           }
           
           # Создание бакета и загрузка архива
           
           resource "yandex_storage_bucket" "conv_func_bucket" {
             folder_id  = local.folder_id
             access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
             secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
             bucket     = local.bucket_name
           }
           
           resource "yandex_storage_object" "archive" {
             access_key   = yandex_iam_service_account_static_access_key.sa-static-key.access_key
             secret_key   = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
             bucket       = yandex_storage_bucket.conv_func_bucket.id
             key          = "src.zip"
             source       = "src.zip"
             content_type = "application/zip"
           }
           
           # Создание API-функции
           
           resource "yandex_function" "api-function" {
             name               = "ffmpeg-api"
             runtime            = "python312"
             user_hash          = filesha256("ffmpeg-api.zip")
             memory             = "256"
             entrypoint         = "index.handle_api"
             execution_timeout  = "5"
             service_account_id = yandex_iam_service_account.sa.id
             environment = {
               DOCAPI_ENDPOINT = yandex_ydb_database_serverless.api_db.document_api_endpoint
               YMQ_QUEUE_URL   = yandex_message_queue.converter_queue.id
               SECRET_ID       = yandex_lockbox_secret.secretmq.id
             }
             content {
               zip_filename = "ffmpeg-api.zip"
             }
           }
           
           # Создание функции-конвертера
           
           resource "yandex_function" "converter" {
             name               = "ffmpeg-converter"
             runtime            = "python312"
             user_hash          = filesha256("src.zip")
             memory             = "2048"
             entrypoint         = "index.handle_process_event"
             execution_timeout  = "600"
             service_account_id = yandex_iam_service_account.sa.id
             environment = {
               DOCAPI_ENDPOINT = yandex_ydb_database_serverless.api_db.document_api_endpoint
               YMQ_QUEUE_URL   = yandex_message_queue.converter_queue.id
               S3_BUCKET       = yandex_storage_bucket.conv_func_bucket.id
               SECRET_ID       = yandex_lockbox_secret.secretmq.id
             }
             package {
               bucket_name = yandex_storage_bucket.conv_func_bucket.id
               object_name = "src.zip"
             }
           }
           
           # Создание триггера
           
           resource "yandex_function_trigger" "converter_trigger" {
             name = "ffmpeg-trigger"
             message_queue {
               queue_id           = yandex_message_queue.converter_queue.arn
               service_account_id = yandex_iam_service_account.sa.id
               batch_size         = "1"
               batch_cutoff       = "10"
               visibility_timeout = 600
             }
             function {
               id                 = yandex_function.converter.id
               tag                = "$latest"
               service_account_id = yandex_iam_service_account.sa.id
             }
           }
           ```

           {% endcut %}

        1. Для API-функции:
           1. Создайте файл `index.py` и вставьте в него содержимое:

              {% cut "index.py для API-функции" %}

              ```python
              import json
              import os
              import subprocess
              import uuid
              from urllib.parse import urlencode
              
              import boto3
              import requests
              import yandexcloud
              from yandex.cloud.lockbox.v1.payload_service_pb2 import GetPayloadRequest
              from yandex.cloud.lockbox.v1.payload_service_pb2_grpc import PayloadServiceStub
              
              boto_session = None
              storage_client = None
              docapi_table = None
              ymq_queue = None
              
              
              def get_boto_session():
                  global boto_session
                  if boto_session is not None:
                      return boto_session
              
                  # initialize lockbox and read secret value
                  yc_sdk = yandexcloud.SDK()
                  channel = yc_sdk._channels.channel("lockbox-payload")
                  lockbox = PayloadServiceStub(channel)
                  response = lockbox.Get(GetPayloadRequest(secret_id=os.environ['SECRET_ID']))
              
                  # extract values from secret
                  access_key = None
                  secret_key = None
                  for entry in response.entries:
                      if entry.key == 'ACCESS_KEY_ID':
                          access_key = entry.text_value
                      elif entry.key == 'SECRET_ACCESS_KEY':
                          secret_key = entry.text_value
                  if access_key is None or secret_key is None:
                      raise Exception("secrets required")
                  print("Key id: " + access_key)
              
                  # initialize boto session
                  boto_session = boto3.session.Session(
                      aws_access_key_id=access_key,
                      aws_secret_access_key=secret_key
                  )
                  return boto_session
              
              
              def get_ymq_queue():
                  global ymq_queue
                  if ymq_queue is not None:
                      return ymq_queue
              
                  ymq_queue = get_boto_session().resource(
                      service_name='sqs',
                      endpoint_url='https://message-queue.api.cloud.yandex.net',
                      region_name='ru-central1'
                  ).Queue(os.environ['YMQ_QUEUE_URL'])
                  return ymq_queue
              
              
              def get_docapi_table():
                  global docapi_table
                  if docapi_table is not None:
                      return docapi_table
              
                  docapi_table = get_boto_session().resource(
                      'dynamodb',
                      endpoint_url=os.environ['DOCAPI_ENDPOINT'],
                      region_name='ru-central1'
                  ).Table('tasks')
                  return docapi_table
              
              
              def get_storage_client():
                  global storage_client
                  if storage_client is not None:
                      return storage_client
              
                  storage_client = get_boto_session().client(
                      service_name='s3',
                      endpoint_url='https://storage.yandexcloud.net',
                      region_name='ru-central1'
                  )
                  return storage_client
              
              # API handler
              
              def create_task(src_url):
                  task_id = str(uuid.uuid4())
                  get_docapi_table().put_item(Item={
                      'task_id': task_id,
                      'ready': False
                  })
                  get_ymq_queue().send_message(MessageBody=json.dumps({'task_id': task_id, "src": src_url}))
                  return {
                      'task_id': task_id
                  }
              
              
              def get_task_status(task_id):
                  task = get_docapi_table().get_item(Key={
                      "task_id": task_id
                  })
                  if task['Item']['ready']:
                      return {
                          'ready': True,
                          'gif_url': task['Item']['gif_url']
                      }
                  return {'ready': False}
              
              
              def handle_api(event, context):
                  action = event['action']
                  if action == 'convert':
                      return create_task(event['src_url'])
                  elif action == 'get_task_status':
                      return get_task_status(event['task_id'])
                  else:
                      return {"error": "unknown action: " + action}
              ```

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

              ```python
              import json
              import os
              import subprocess
              import uuid
              from urllib.parse import urlencode
              
              import boto3
              import requests
              import yandexcloud
              from yandex.cloud.lockbox.v1.payload_service_pb2 import GetPayloadRequest
              from yandex.cloud.lockbox.v1.payload_service_pb2_grpc import PayloadServiceStub
              
              boto_session = None
              storage_client = None
              docapi_table = None
              ymq_queue = None
              
              
              def get_boto_session():
                  global boto_session
                  if boto_session is not None:
                      return boto_session
              
                  # initialize lockbox and read secret value
                  yc_sdk = yandexcloud.SDK()
                  channel = yc_sdk._channels.channel("lockbox-payload")
                  lockbox = PayloadServiceStub(channel)
                  response = lockbox.Get(GetPayloadRequest(secret_id=os.environ['SECRET_ID']))
              
                  # extract values from secret
                  access_key = None
                  secret_key = None
                  for entry in response.entries:
                      if entry.key == 'ACCESS_KEY_ID':
                          access_key = entry.text_value
                      elif entry.key == 'SECRET_ACCESS_KEY':
                          secret_key = entry.text_value
                  if access_key is None or secret_key is None:
                      raise Exception("secrets required")
                  print("Key id: " + access_key)
              
                  # initialize boto session
                  boto_session = boto3.session.Session(
                      aws_access_key_id=access_key,
                      aws_secret_access_key=secret_key
                  )
                  return boto_session
              
              
              def get_ymq_queue():
                  global ymq_queue
                  if ymq_queue is not None:
                      return ymq_queue
              
                  ymq_queue = get_boto_session().resource(
                      service_name='sqs',
                      endpoint_url='https://message-queue.api.cloud.yandex.net',
                      region_name='ru-central1'
                  ).Queue(os.environ['YMQ_QUEUE_URL'])
                  return ymq_queue
              
              
              def get_docapi_table():
                  global docapi_table
                  if docapi_table is not None:
                      return docapi_table
              
                  docapi_table = get_boto_session().resource(
                      'dynamodb',
                      endpoint_url=os.environ['DOCAPI_ENDPOINT'],
                      region_name='ru-central1'
                  ).Table('tasks')
                  return docapi_table
              
              
              def get_storage_client():
                  global storage_client
                  if storage_client is not None:
                      return storage_client
              
                  storage_client = get_boto_session().client(
                      service_name='s3',
                      endpoint_url='https://storage.yandexcloud.net',
                      region_name='ru-central1'
                  )
                  return storage_client
              
              # Converter handler
              
              def download_from_ya_disk(public_key, dst):
                  api_call_url = 'https://cloud-api.yandex.net/v1/disk/public/resources/download?' + \
                                 urlencode(dict(public_key=public_key))
                  response = requests.get(api_call_url)
                  download_url = response.json()['href']
                  download_response = requests.get(download_url)
                  with open(dst, 'wb') as video_file:
                      video_file.write(download_response.content)
              
              
              def upload_and_presign(file_path, object_name):
                  client = get_storage_client()
                  bucket = os.environ['S3_BUCKET']
                  client.upload_file(file_path, bucket, object_name)
                  return client.generate_presigned_url('get_object', Params={'Bucket': bucket, 'Key': object_name}, ExpiresIn=3600)
              
              
              def handle_process_event(event, context):
                  for message in event['messages']:
                      task_json = json.loads(message['details']['message']['body'])
                      task_id = task_json['task_id']
                      # Download video
                      download_from_ya_disk(task_json['src'], '/tmp/video.mp4')
                      # Convert with ffmpeg
                      subprocess.run(['ffmpeg', '-i', '/tmp/video.mp4', '-r', '10', '-s', '320x240', '/tmp/result.gif'])
                      result_object = task_id + ".gif"
                      # Upload to Object Storage and generate presigned url
                      result_download_url = upload_and_presign('/tmp/result.gif', result_object)
                      # Update task status in DocAPI
                      get_docapi_table().update_item(
                          Key={'task_id': task_id},
                          AttributeUpdates={
                              'ready': {'Value': True, 'Action': 'PUT'},
                              'gif_url': {'Value': result_download_url, 'Action': 'PUT'},
                          }
                      )
                  return "OK"
              ```

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

   Более подробную информацию о параметрах используемых ресурсов в Terraform см. в документации провайдера:
   * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account](../../../terraform/resources/iam_service_account.md).
   * [Роль](../../../iam/concepts/access-control/roles.md) — [yandex_resourcemanager_folder_iam_member](../../../terraform/resources/resourcemanager_folder_iam_member.md)
   * [Секрет](../../../lockbox/concepts/secret.md) — [yandex_lockbox_secret](../../../terraform/resources/lockbox_secret.md)
   * [Версия секрета](../../../lockbox/concepts/secret.md#version) — [yandex_lockbox_secret_version](../../../terraform/resources/lockbox_secret_version.md)
   * [Очередь сообщений](../../concepts/queue.md) — [yandex_message_queue](../../../terraform/resources/message_queue.md)
   * [База данных YDB](../../concepts/queue.md) — [yandex_ydb_database_serverless](../../../terraform/resources/ydb_database_serverless.md)
   * [Бакет](../../../storage/concepts/bucket.md) — [yandex_storage_bucket](../../../terraform/resources/storage_bucket.md)
   * [Объект бакета](../../../storage/concepts/object.md) — [yandex_storage_object](../../../terraform/resources/storage_object.md)
   * [Функция](../../../functions/concepts/function.md) — [yandex_function](../../../terraform/resources/function.md)
   * [Триггер](../../../functions/concepts/trigger/ymq-trigger.md) — [yandex_function_trigger](../../../terraform/resources/function_trigger.md)

1. В файле `video-converting.tf` задайте пользовательские параметры:
   * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
   * `bucket` — имя бакета.

1. Создайте ресурсы:

   1. В терминале перейдите в директорию с конфигурационным файлом.
   1. Проверьте корректность конфигурации с помощью команды:
   
      ```bash
      terraform validate
      ```
   
      Если конфигурация является корректной, появится сообщение:
   
      ```bash
      Success! The configuration is valid.
      ```
   
   1. Выполните команду:
   
      ```bash
      terraform plan
      ```
   
      В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
   1. Примените изменения конфигурации:
   
      ```bash
      terraform apply
      ```
   
   1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

После создания инфраструктуры [создайте таблицу](#create-table) в базе данных YDB.




## Создайте таблицу {#create-table}

1.  [Создайте таблицу](../../../ydb/operations/schema.md#create-table)  в базе данных YDB:

    * **Имя** — `tasks`.
    * **Тип таблицы** — [Документная таблица](../../../ydb/operations/schema.md#create-table).
    * **Колонки** — одна колонка с именем `task_id` типа `String`. Установите атрибут [Ключ партицирования](../../../ydb/operations/schema.md#create-table).

После создания таблицы [проверьте работу приложения](#test-app).



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

1. Откройте конфигурационный файл `video-converting.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    1. В терминале перейдите в директорию с конфигурационным файлом.
    1. Проверьте корректность конфигурации с помощью команды:
    
       ```bash
       terraform validate
       ```
    
       Если конфигурация является корректной, появится сообщение:
    
       ```bash
       Success! The configuration is valid.
       ```
    
    1. Выполните команду:
    
       ```bash
       terraform plan
       ```
    
       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
    1. Примените изменения конфигурации:
    
       ```bash
       terraform apply
       ```
    
    1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

#### См. также {#see-also}

* [Конвертация видео в GIF на Python с помощью консоли управления](console.md)