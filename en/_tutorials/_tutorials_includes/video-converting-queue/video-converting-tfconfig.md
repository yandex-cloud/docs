```hcl
# Declaring variables

locals {
  folder_id   = "<folder_ID>"
  bucket_name = "<bucket_name>"
}

# Configuring the provider

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

# Creating a service account and assigning roles to it

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

# Creating a static key for the service account

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for database, message queue and bucket"
}

# Creating a secret

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

# Creating a message queue

resource "yandex_message_queue" "converter_queue" {
  name                       = "converter-queue"
  visibility_timeout_seconds = 600
  message_retention_seconds  = 1209600
  receive_wait_time_seconds  = 20

  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  depends_on = [ yandex_resourcemanager_folder_iam_member.ymq-writer ]
}

# Creating a database

resource "yandex_ydb_database_serverless" "api_db" {
  name        = "db-converter"
  location_id = "ru-central1"
}

# Creating a bucket and uploading an archive

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

# Creating an API function

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

# Creating a converter function

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

# Creating a trigger

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