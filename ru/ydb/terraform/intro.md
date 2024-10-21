---
title: Введение в работу с {{ ydb-short-name }} через {{ TF }}
description: 'Статья содержит: описание основных команд {{ TF }} CLI, а также список инструкций по работе с {{ ydb-short-name }} с помощью {{ TF }}.'
---

# Введение в работу с {{ ydb-short-name }} через {{ TF }}

[{{ TF }}](https://www.terraform.io) — это программное обеспечение с открытым исходным кодом от компании HashiCorp для управления облачной инфраструктурой по модели "инфраструктура как код" (Infrastructure as Code). Это значит, что желаемое состояние инфраструктуры описывается в конфигурационных файлах, а {{ TF }} при помощи специальных вспомогательных программ (провайдеров) применяет эти изменения к инфраструктуре. Конфигурационные файлы пишутся на специальном [языке HCL](https://developer.hashicorp.com/terraform/language/syntax) (HashiCorp Configuration Language) и имеют расширение `tf`. HCL очень похож на JSON и оформляется в виде логических блоков в конфигурационных файлах.

С помощью {{ TF }} можно создавать и изменять базы данных {{ ydb-short-name }}, а также управлять ее ресурсами: таблицами, индексами, потоками изменений таблиц. Важно понимать, что конфигурационный файл, который создаётся для управления {{ ydb-short-name }} становится единой точкой управления состоянием базы и все изменения с базой должны производится через него, так как {{ TF }} после каждого успешного применения изменений создает специальный state-файл — текстовое представление текущего состояния базы и при дальнейших изменениях ориентируется на него.

Если внести изменения в состояние БД через конфигурационный файл, а потом еще что-то изменить через Консоль управления или через CLI, то {{ TF }} ничего не узнает об этих изменениях, пока не будут применены команды `terraform plan` или `terraform refresh`. Эти команды заставят {{ TF }} сверить текущее состояние ресурсов с тем, что сохранено в state-файле. Но это не означает, что {{ TF }} автоматически примет новые изменения и обновит файл состояния, так как при следующем вызове команды `terraform apply`, {{ TF }} попытается привести ресурсы к тому состоянию, которое описано в вашем конфигурационном файле, что может привести к перезаписи или удалению ваших внешних изменений. Поэтому очень важно во избежание конфликтов изменений состояния {{ ydb-short-name }} работать через единую точку доступа — конфигурационный файл.

Для подключения терраформа к {{ ydb-short-name }} применяется провайдер `yandex_ydb`, а для аутентификации используется консольный клиент [yc](../../cli/quickstart.md).

В разделе содержатся следующие инструкции:
1. [Получение данных для аутентификации](credentials.md).
1. [Установка и настройка {{ TF }} и провайдера для подключения к {{ ydb-short-name }}](install.md). 
1. [Создание конфигурационных файлов и подключение к {{ ydb-short-name }}](configure.md).
1. [Создание и изменение параметров бессерверной базы данных](serverless-database.md).
1. [Создание и изменение параметров выделенной базы данных](dedicated-database.md).
1. [Создание строковых таблиц в базе данных](row-tables.md).
1. [Создание потока изменений таблицы](cdc.md).
1. [Создание вторичных индексов строковых таблиц](row-tables-secondary-index.md).
1. [Создание топиков](topic.md).

## Ресурсы {#resources}

Для {{ ydb-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_ydb_database_dedicated]({{ tf-provider-resources-link }}/ydb_database_dedicated) | База данных [на выделенных ресурсах](../concepts/resources.md#resource-presets) (Dedicated) |
| [yandex_ydb_database_iam_binding]({{ tf-provider-resources-link }}/ydb_database_iam_binding) | [Привязка](../../iam/concepts/access-control/index.md#access-bindings) прав доступа к базе данных |
| [yandex_ydb_database_serverless]({{ tf-provider-resources-link }}/ydb_database_serverless) | [Бессерверная](../concepts/resources.md#serverless) база данных (Serverless) |
| [yandex_ydb_topic]({{ tf-provider-resources-link }}/ydb_topic) | [Топик]({{ ydb.docs }}/concepts/topic) |
| [yandex_ydb_table]({{ tf-provider-resources-link }}/ydb_table) | [Таблица]({{ ydb.docs }}/concepts/datamodel/table) |
| [yandex_ydb_table_changefeed]({{ tf-provider-resources-link }}/ydb_table_changefeed) | [Change Data Capture]({{ ydb.docs }}/concepts/cdc) |
| `yandex_ydb_table_index` | [Вторичный индекс таблицы]({{ ydb.docs }}/concepts/secondary_indexes) |

## Источники данных {#data-sources}

Для {{ ydb-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_ydb_database_dedicated]({{ tf-provider-datasources-link }}/ydb_database_dedicated) | Информация о базе данных [на выделенных ресурсах](../concepts/resources.md#resource-presets) (Dedicated) |
| [yandex_ydb_database_serverless]({{ tf-provider-datasources-link }}/ydb_database_serverless) | Информация о [бессерверной](../concepts/resources.md#serverless) базе данных (Serverless) |
