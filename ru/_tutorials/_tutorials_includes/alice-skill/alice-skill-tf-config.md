```hcl
# Объявление переменных

variable "folder_id" {
  type = string
}

variable "file_path" {
  type = string
}

variable "language" {
  type = string
}

# Настройка провайдера

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  folder_id = var.folder_id
}

# Создание функции и версии функции

resource "yandex_function" "alice_parrot" {
  name               = "alice-parrot"
  description        = "Yandex Alice skill: Parrot (repeats user input)"
  runtime            = var.language == "python" ? "{{ python-cli-ver }}" : "{{ nodejs-cli-ver }}"
  entrypoint         = var.language == "python" ? "parrot.handler" : "index.handler"
  memory             = 128
  execution_timeout  = 2

  content {
    zip_filename = var.file_path
  }

  user_hash = filesha256(var.file_path)
}
```