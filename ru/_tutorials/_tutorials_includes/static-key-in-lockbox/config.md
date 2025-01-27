```hcl
# Объявление пользовательских переменных

locals {
  zone      = "<зона_доступности>"
  folder_id = "<идентификатор_каталога>"
}

terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.47.0"
    }
  }
}

# Настройка провайдера

provider "yandex" {
  zone = local.zone
}

# Создание сервисного аккаунта и назначение ролей

resource "yandex_iam_service_account" "sa" {
  folder_id = local.folder_id
  name      = "storage-bucket-sa"
}

resource "yandex_resourcemanager_folder_iam_member" "sa-admin" {
  folder_id = local.folder_id
  role      = "storage.admin"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "lockboxview" {
  folder_id = local.folder_id
  role      = "lockbox.payloadViewer"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

# Создание секрета

resource "yandex_lockbox_secret" "my_secret" {
  name                = "static-key"
  folder_id           = local.folder_id
  deletion_protection = true
}

# Создание статического ключа доступа

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
  output_to_lockbox {
    secret_id            = yandex_lockbox_secret.my_secret.id
    entry_for_access_key = "key_id"
    entry_for_secret_key = "key"
  }
}

# Источник данных версии секрета

data "yandex_lockbox_secret_version" "my_secret_version" {
  secret_id  = yandex_lockbox_secret.my_secret.id
  version_id = yandex_iam_service_account_static_access_key.sa-static-key.output_to_lockbox_version_id
  depends_on = [
    yandex_lockbox_secret.my_secret
  ]
}

# Выходные переменные

output "key_id" {
  value = data.yandex_lockbox_secret_version.my_secret_version.entries[1].text_value
}

output "key" {
  value = data.yandex_lockbox_secret_version.my_secret_version.entries[0].text_value
}
```