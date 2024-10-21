---
title: Управление конфигурацией топиков {{ydb-short-name}}
description: В инструкции описаны свойства ресурса yandex_ydb_topic для управления конфигурацией топиков {{ydb-short-name}}.
---

# Управление конфигурацией топиков {{ydb-short-name}}

Для работы с [топиками]({{ ydb.docs }}/concepts/topic) используется ресурс `yandex_ydb_topic`.

{% note info %}

Рекомендуем создавать топик в отдельном каталоге. Топик в корне БД затрудняет читаемость ее структуры.

{% endnote %}

## Описание ресурса yandex_ydb_topic {#yandex_ydb_topic_description}

Пример использования ресурса `yandex_ydb_topic`:

```tf
resource "yandex_ydb_topic" "ydb_topic" {
  database_endpoint = yandex_ydb_database_serverless.database1.ydb_full_endpoint  # пример подключения к БД
  name              = "test_dir/test_topic"
  supported_codecs  = ["zstd"]

  consumer {
    name             = "test-consumer1"
    starting_message_timestamp_ms = 0
    supported_codecs = ["zstd","raw"]
  }

  consumer {
    name             = "test-consumer2"
    starting_message_timestamp_ms = 2000
    supported_codecs = ["zstd"]
  }

  consumer {
    name             = "test-consumer3"
    starting_message_timestamp_ms = 0
    supported_codecs = ["zstd"]
  }
}
```

Поддерживаются следующие поля:
| **Название поля** | **Тип** | **Описание** |
| --- | --- | --- |
|`name`|`string`<br>`required`|Имя топика|
|`database_endpoint`|`string`<br>`required`|Полный путь до базы данных|
|`retention_period_ms`|`number`<br>`optional`|Длительность хранения данных в миллисекундах, значение по умолчанию — `86400000` (сутки)|
|`partitions_count`|`number`<br>`optional`|Количество партиций, значение по умолчанию — `2`|
|`supported_codecs`|`list(string)`<br>`optional`|Поддерживаемые кодеки сжатия данных, значение по умолчанию — `"gzip", "raw", "zstd"`,<br>можно использовать их комбинации|
|`consumer`|`consumer`|Читатели для топика|

{% note info %}

Читателя (consumer) можно создать, используя {{ TF }}, но нельзя удалить. Читателя можно удалить в [консоли управления]({{ link-console-main }}) или с помощью [{{ ydb-short-name }} CLI]({{ ydb.docs }}/reference/ydb-cli/install).

{% endnote %}

Описание читателя данных ([consumer]({{ ydb.docs }}/concepts/topic#consumer)):
| **Название поля** | **Тип** | **Описание** |
| --- | --- | --- |
|`name`|`string`<br>`required`|Имя читателя|
|`supported_codecs`|`list(string)`<br>`optional`|Поддерживаемые кодировки сжатия данных, по умолчанию — `"gzip", "raw", "zstd"`, можно использовать их комбинации|
|`starting_message_timestamp_ms`|`number`<br>`optional`|Временная метка в формате [UNIX timestamp](https://ru.wikipedia.org/wiki/Unix-время) в миллисекундах, с которой читатель начнет читать данные, по умолчанию — 0, то есть с начала поставки|
