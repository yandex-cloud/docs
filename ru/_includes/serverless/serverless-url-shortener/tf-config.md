```hcl
# Объявление переменных для конфиденциальных параметров

variable "cloud_id" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "bucket_name" {
  type = string
}

# Настройка провайдера

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
}

# Создание сервисного аккаунта

resource "yandex_iam_service_account" "shortener_sa" {
  name        = "serverless-shortener"
  description = "Service account for the URL shortener"
}

# Назначение роли сервисному аккаунту

resource "yandex_resourcemanager_folder_iam_member" "shortener_role" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.shortener_sa.id}"
}

# Создание статического ключа

resource "yandex_iam_service_account_static_access_key" "shortener_sa_key" {
  service_account_id = yandex_iam_service_account.shortener_sa.id
  description        = "Static access key for the service account"
}

# Создание бакета

resource "yandex_storage_bucket" "shortener_bucket" {
  bucket     = var.bucket_name
  access_key = yandex_iam_service_account_static_access_key.shortener_sa_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.shortener_sa_key.secret_key
  max_size = 1073741824
  anonymous_access_flags {
    read        = true
    list        = false
    config_read = false
  }

  website {
    index_document = "index.html"
  }
}

# Загрузка объекта в бакет

resource "yandex_storage_object" "shortener_index" {
  bucket        = yandex_storage_bucket.shortener_bucket.bucket
  key           = "index.html"
  source        = "index.html"
  acl           = "public-read"
  access_key    = yandex_iam_service_account_static_access_key.shortener_sa_key.access_key
  secret_key    = yandex_iam_service_account_static_access_key.shortener_sa_key.secret_key
  content_type  = "text/html"
}

# Создание базы данных YDB

resource "yandex_ydb_database_serverless" "shortener_db" {
  name        = "shortener-ydb-main"
  location_id = "{{ region-id }}"
}


# Создание таблицы YDB

resource "yandex_ydb_table" "test_table" {
  path              = "links"
  connection_string = yandex_ydb_database_serverless.shortener_db.ydb_full_endpoint
  column {
    name     = "id"
    type     = "Utf8"
    not_null = true
  }
  column {
    name     = "link"
    type     = "Utf8"
    not_null = true
  }
  primary_key = ["id"]
  
  depends_on = [ yandex_ydb_database_serverless.shortener_db ]
  }

# Создание функции

resource "yandex_function" "shortener_function" {
  name               = "shortener-function-main"
  description        = "Function for the URL shortener"
  runtime            = "python312"
  entrypoint         = "index.handler"
  memory             = 256
  execution_timeout  = 5
  service_account_id = yandex_iam_service_account.shortener_sa.id

  content {
    zip_filename = "function.zip"
  }

  user_hash = filesha256("function.zip")

  environment = {
    endpoint = "grpcs://${yandex_ydb_database_serverless.shortener_db.ydb_api_endpoint}"
    database = yandex_ydb_database_serverless.shortener_db.database_path
  }
}

resource "yandex_function_iam_binding" "public_invoker" {
  function_id = yandex_function.shortener_function.id
  role        = "functions.functionInvoker"
  members     = ["system:allUsers"]
}

# Создание API-шлюза

resource "yandex_api_gateway" "shortener_gateway" {
  name = "shortener-gateway-main"

  spec = jsonencode({
    openapi = "3.0.0"
    info = {
      title   = "Shortener API Gateway"
      version = "1.0.0"
    }
    paths = {
      "/" = {
        get = {
          "x-yc-apigateway-integration" = {
            type               = "object_storage"
            bucket             = yandex_storage_bucket.shortener_bucket.bucket
            object             = "index.html"
            presigned_redirect = false
            service_account_id = yandex_iam_service_account.shortener_sa.id
          }
          operationId = "static"
        }
      }
      "/shorten" = {
        post = {
          "x-yc-apigateway-integration" = {
            type        = "cloud_functions"
            function_id = yandex_function.shortener_function.id
          }
          operationId = "shorten"
        }
      }
      "/r/{id}" = {
        get = {
          "x-yc-apigateway-integration" = {
            type        = "cloud_functions"
            function_id = yandex_function.shortener_function.id
          }
          operationId = "redirect"
          parameters = [
            {
              description = "ID of the shortened link"
              explode     = false
              in          = "path"
              name        = "id"
              required    = true
              schema = {
                type = "string"
              }
              style = "simple"
            }
          ]
        }
      }
    }
  })
}

# URL для работы с сокращателем ссылок

output "url" {
  value = "https://${yandex_api_gateway.shortener_gateway.domain}"
}
```
