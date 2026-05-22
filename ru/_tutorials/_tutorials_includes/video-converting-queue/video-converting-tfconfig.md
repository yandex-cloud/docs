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