# Введение в работу с YDB через Terraform

[Terraform](https://www.terraform.io) — это программное обеспечение с открытым исходным кодом от компании HashiCorp для управления облачной инфраструктурой по модели "инфраструктура как код" (Infrastructure as Code). Это значит, что желаемое состояние инфраструктуры описывается в конфигурационных файлах, а Terraform при помощи специальных вспомогательных программ (провайдеров) применяет эти изменения к инфраструктуре. Конфигурационные файлы пишутся на специальном [языке HCL](https://developer.hashicorp.com/terraform/language/syntax) (HashiCorp Configuration Language) и имеют расширение `tf`. HCL очень похож на JSON и оформляется в виде логических блоков в конфигурационных файлах.

С помощью Terraform можно создавать и изменять базы данных YDB, а также управлять ее ресурсами: таблицами, индексами, потоками изменений таблиц. Важно понимать, что конфигурационный файл, который создаётся для управления YDB становится единой точкой управления состоянием базы и все изменения с базой должны производится через него, так как Terraform после каждого успешного применения изменений создает специальный state-файл — текстовое представление текущего состояния базы и при дальнейших изменениях ориентируется на него.

Если внести изменения в состояние БД через конфигурационный файл, а потом еще что-то изменить через Консоль управления или через CLI, то Terraform ничего не узнает об этих изменениях, пока не будут применены команды `terraform plan` или `terraform refresh`. Эти команды заставят Terraform сверить текущее состояние ресурсов с тем, что сохранено в state-файле. Но это не означает, что Terraform автоматически примет новые изменения и обновит файл состояния, так как при следующем вызове команды `terraform apply`, Terraform попытается привести ресурсы к тому состоянию, которое описано в вашем конфигурационном файле, что может привести к перезаписи или удалению ваших внешних изменений. Поэтому очень важно во избежание конфликтов изменений состояния YDB работать через единую точку доступа — конфигурационный файл.

Для подключения терраформа к YDB применяется провайдер `yandex_ydb`, а для аутентификации используется консольный клиент [yc](../../cli/quickstart.md).

В разделе содержатся следующие инструкции:
1. [Получение данных для аутентификации](credentials.md).
1. [Установка и настройка Terraform и провайдера для подключения к YDB](install.md).
1. [Создание конфигурационных файлов и подключение к YDB](configure.md).
1. [Создание и изменение параметров бессерверной базы данных](serverless-database.md).
1. [Создание и изменение параметров выделенной базы данных](dedicated-database.md).
1. [Создание строковых и колоночных таблиц в базе данных](tables.md).
1. [Создание потока изменений таблицы](cdc.md).
1. [Создание вторичных индексов строковых таблиц](row-tables-secondary-index.md).
1. [Создание топиков](topic.md).

## Ресурсы {#resources}

Для Managed Service for YDB поддерживаются следующие ресурсы провайдера Terraform:

| **Ресурс Terraform** | **Ресурс Yandex Cloud** |
| --- | --- |
| [yandex_ydb_database_dedicated](../../terraform/resources/ydb_database_dedicated.md) | База данных [на выделенных ресурсах](../concepts/resources.md#resource-presets) (Dedicated) |
| [yandex_ydb_database_iam_binding](../../terraform/resources/ydb_database_iam_binding.md) | [Привязка](../../iam/concepts/access-control/index.md#access-bindings) прав доступа к базе данных |
| [yandex_ydb_database_serverless](../../terraform/resources/ydb_database_serverless.md) | [Бессерверная](../concepts/resources.md#serverless) база данных (Serverless) |
| [yandex_ydb_topic](../../terraform/resources/ydb_topic.md) | [Топик](https://ydb.tech/docs/ru//concepts/topic) |
| [yandex_ydb_table](../../terraform/resources/ydb_table.md) | [Таблица](https://ydb.tech/docs/ru//concepts/datamodel/table) |
| [yandex_ydb_table_changefeed](../../terraform/resources/ydb_table_changefeed.md) | [Change Data Capture](https://ydb.tech/docs/ru//concepts/cdc) |
| `yandex_ydb_table_index` | [Вторичный индекс таблицы](https://ydb.tech/docs/ru//concepts/secondary_indexes) |

## Источники данных {#data-sources}

Для Managed Service for YDB поддерживаются следующие источники данных провайдера Terraform:

| **Источник данных Terraform** | **Описание** |
| --- | --- |
| [yandex_ydb_database_dedicated](../../terraform/data-sources/ydb_database_dedicated.md) | Информация о базе данных [на выделенных ресурсах](../concepts/resources.md#resource-presets) (Dedicated) |
| [yandex_ydb_database_serverless](../../terraform/data-sources/ydb_database_serverless.md) | Информация о [бессерверной](../concepts/resources.md#serverless) базе данных (Serverless) |