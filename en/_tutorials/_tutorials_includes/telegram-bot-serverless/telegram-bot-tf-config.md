```hcl
# Declaring variables with sensitive data

variable "cloud_id" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "bot_token" {
  type      = string
  sensitive = true
}

# Configuring the provider

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

# Creating a service account

resource "yandex_iam_service_account" "bot_sa" {
  name        = "telegram-bot-sa"
  description = "Service Account for Telegram bot"
}

# Assigning roles to a service account

resource "yandex_resourcemanager_folder_iam_member" "sa_editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.bot_sa.id}"

  depends_on = [yandex_iam_service_account.bot_sa]
}

resource "yandex_resourcemanager_folder_iam_member" "sa_invoker" {
  folder_id = var.folder_id
  role      = "functions.functionInvoker"
  member    = "serviceAccount:${yandex_iam_service_account.bot_sa.id}"

  depends_on = [yandex_iam_service_account.bot_sa]
}

# Creating static access keys

resource "yandex_iam_service_account_static_access_key" "bot_sa_key" {
  service_account_id = yandex_iam_service_account.bot_sa.id
  description        = "Static key for bot service account"

  depends_on = [
    yandex_resourcemanager_folder_iam_member.sa_editor
  ]
}

# Creating a bucket

resource "yandex_storage_bucket" "bot_bucket" {
  bucket     = var.bucket_name
  access_key = yandex_iam_service_account_static_access_key.bot_sa_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.bot_sa_key.secret_key
  anonymous_access_flags {
    read = true
  }

  depends_on = [
    yandex_iam_service_account_static_access_key.bot_sa_key
  ]
}

# Uploading an image to a bucket

resource "yandex_storage_object" "sayhello_png" {
  bucket       = yandex_storage_bucket.bot_bucket.bucket
  key          = "sayhello.png"
  source       = "sayhello.png"
  acl          = "public-read"
  access_key   = yandex_iam_service_account_static_access_key.bot_sa_key.access_key
  secret_key   = yandex_iam_service_account_static_access_key.bot_sa_key.secret_key
  content_type = "image/png"

  depends_on = [yandex_storage_bucket.bot_bucket]
}

# Creating a zip archive for a function

data "archive_file" "function" {
  type        = "zip"
  source {
    content  = templatefile("telegram-bot-function.tpl", {
      API_GW_URL = yandex_api_gateway.bot_gateway.domain
    })
    filename = "index.js"
  }
  source {
    content  = "${file("package.json")}"
    filename = "package.json"
  }
  output_path = "function.zip"

  depends_on = [yandex_api_gateway.bot_gateway]
}

# Creating a public function

resource "yandex_function" "telegram_bot_function" {
  name               = "fshtb-function"
  description        = "Serverless Telegram bot on Node.js"
  runtime            = "nodejs22"
  entrypoint         = "index.handler"
  memory             = 256
  execution_timeout  = 5
  service_account_id = yandex_iam_service_account.bot_sa.id

  environment = {
    BOT_TOKEN = var.bot_token
  }

  content {
    zip_filename = "function.zip"
  }

  user_hash = filesha256("telegram-bot-function.tpl")

  depends_on = [
    yandex_resourcemanager_folder_iam_member.sa_editor,
    yandex_resourcemanager_folder_iam_member.sa_invoker,
    data.archive_file.function
  ]
}

resource "yandex_function_iam_binding" "public_invoker" {
  function_id = yandex_function.telegram_bot_function.id
  role        = "functions.functionInvoker"
  members     = ["system:allUsers"]
}

# Creating an API gateway

resource "yandex_api_gateway" "bot_gateway" {
  name        = "forserverless-hello-telegram-bot"
  description = "API gateway for telegram bot"

  spec = templatefile("telegram-bot-gw-spec.tpl", {
    BUCKET_NAME = yandex_storage_bucket.bot_bucket.id
    OBJECT_NAME = yandex_storage_object.sayhello_png.key
    SA_ID       = yandex_iam_service_account.bot_sa.id
  })
}
```