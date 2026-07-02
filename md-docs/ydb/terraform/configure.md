[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for YDB](../index.md) > Работа с YDB через Terraform > Создание конфигурационных файлов и подключение к YDB

# Создание конфигурационных файлов и подключение к YDB

{% note warning %}

Для работы с текущей инструкцией требуется установленный Terraform провайдер для YDB. Если у вас не установлен провайдер для работы с YDB — ознакомьтесь с разделом [Установка и настройка Terraform и провайдера для подключения к YDB](install.md).

{% endnote %}

Создайте директорию, где будут располагаться конфигурационные файлы Terraform для работы с YDB и создайте файл `main.tf.` Например:
```bash
mkdir ydb_terraform && cd ydb_terraform
touch main.tf
```

## Описание настройки блока провайдера {#tproviders_description}

В начало файла добавьте следующий блок и сохраните файл:

```tf
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = "ru-central1-a" # Зона доступности по умолчанию
}
```

Значение полей блока провайдера:
* `source` — глобальный [адрес источника](https://developer.hashicorp.com/terraform/language/providers/requirements#source-addresses) провайдера;
* `required_version` — минимальная версия Terraform, с которой совместим провайдер;
* `provider` — название провайдера;
* `zone` — [зона доступности](../../overview/concepts/geo-scope.md), в которой по умолчанию будут создаваться все облачные ресурсы.

Выполните в директории с конфигурационными файлами команду `terraform init` — будет произведена инициализация провайдера. В терминале вы увидите сообщение об успешной инсталляции. Теперь, когда Terraform установлен и настроен можно приступать к созданию [бессерверной](serverless-database.md) или [выделенной](dedicated-database.md) базы данных.