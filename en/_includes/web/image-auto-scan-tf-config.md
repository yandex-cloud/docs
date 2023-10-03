```hcl
# Declaring variables for user-defined parameters

variable "zone" {
  type = string
}

variable "folder_id" {
  type = string
}

# Adding other variables

locals {
  sa_scanner_name    = "scanner"
  sa_invoker_name    = "invoker"
  registry_name      = "my-registry"
  function_name      = "scan-on-push"
}

# Specifying provider settings

terraform {
  required_providers {
    yandex    = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.47.0"
    }
  }
}

provider "yandex" {
  folder_id = var.folder_id
}

# Creating service accounts

resource "yandex_iam_service_account" "scanner" {
  name        = local.sa_scanner_name
  description = "SA for Container Registry"
  folder_id   = var.folder_id
}

resource "yandex_iam_service_account" "invoker" {
  name        = local.sa_invoker_name
  description = "SA for Cloud Functions"
  folder_id   = var.folder_id
}

# Assigning roles to service accounts

resource "yandex_resourcemanager_folder_iam_member" "sa-role-scanner" {
  folder_id   = var.folder_id
  role        = "container-registry.images.scanner"
  member      = "serviceAccount:${yandex_iam_service_account.scanner.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "sa-role-invoker" {
  folder_id   = var.folder_id
  role        = "serverless.functions.invoker"
  member      = "serviceAccount:${yandex_iam_service_account.invoker.id}"
}

# Creating a container registry

resource "yandex_container_registry" "my-reg" {
  name      = local.registry_name
  folder_id = var.folder_id
}

# Creating a function

resource "yandex_function" "test-function" {
  name               = local.function_name
  user_hash          = "my-first-function"
  runtime            = "bash"
  entrypoint         = "handler.sh"
  memory             = "128"
  execution_timeout  = "60"
  service_account_id = yandex_iam_service_account.scanner.id
  content {
    zip_filename   = "function.zip"
  }
}
```
