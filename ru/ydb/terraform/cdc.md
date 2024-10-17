---
title: Создание поток изменений таблицы {{ ydb-full-name }} с помощью {{ TF }}
description: Следуя данной инструкции, вы сможете создать или изменить параметры потока изменений таблицы {{ ydb-short-name }}.
---

# Создание потока изменений таблицы

[Поток измений таблицы](https://ydb.tech/docs/ru/concepts/cdc) или Change Data Capture (CDC) — это механизм оповещения об изменениях данных в конкретной таблице. Когда в таблице добавляется, обновляется или удаляется строка, CDC формирует запись о произошедшем изменении с указанием первичного ключа строки и пишет ее в соответствующую данному ключу партицию топика. [Топик](https://ydb.tech/docs/ru/concepts/topic) — это сущность для хранения неструктурированных сообщений, предназначенная для их доставки множеству подписчиков. Фактически, топик — это именованный набор сообщений.

## Описание ресурса yandex_ydb_table_changefeed {#table_changefeed_description}

Создать поток изменений таблицы можно с помощью ресурса `yandex_ydb_table_changefeed`:

```tf
resource "yandex_ydb_table_changefeed" "ydb_changefeed" {
  table_id = yandex_ydb_table.test_table_2.id
  name = "changefeed"
  mode = "NEW_IMAGE"
  format = "JSON"

  consumer {
    name = "test_consumer"
  }
}
```

В создании потока изменений таблицы мы использовали следующий набор полей:
* `table_id` — идентификатор таблицы, для которой создается поток изменений;
* `name` — название потока изменений;
* `mode` — режим работы потока изменений. Все доступные режимы работы потока изменений описаны в [документации](https://ydb.tech/docs/ru/yql/reference/syntax/alter_table#changefeed-options).  
* `format` — формат потока изменений. Доступен только JSON формат.

Полное описание всех полей ресурса `yandex_ydb_table_changefeed`:
| **Название поля** | **Тип** | **Описание** |
| --- | --- | --- |
|table_path|`string`<br>`required`|Путь до таблицы|
|connection_string|`string`<br>`required`|Строка соединения, конфликтует с `table_id`|
|database_id|`string`<br>`required`|Идентификатор базы данных, конфликтует с `table_path` и `connection_string`|
|table_id|`string`<br>`required`|Terraform-идентификатор таблицы|
|name|`string`<br>`required`|Имя потока изменений|
|mode|`string`<br>`required`|[Режим работы потока изменений](https://ydb.tech/docs/ru/yql/reference/syntax/alter_table#changefeed-options)|
|format|`string`<br>`required`|Формат потока изменений|
|virtual_timestamps|`bool`<br>`optional`|Использование [виртуальных таймстеймпов](https://ydb.tech/docs/ru/concepts/cdc#virtual-timestamps)|
|retention_period|`string`<br>`optional`|Время хранения данных в топике в формате [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601)|
|consumer|`array[consumer]`<br>`optional`|Консьюмеры (читатели) для потока изменений|

При инициализации ресурса `yandex_ydb_table_changefeed` можно указать только одно поле соединения: `connection_string`, `table_path` или `table_id`. При указании нескольких полей соединения между ними возникают конфликты. Например, поле `table_id` с указанием относительной ссылки в формате: `<ресурс>.<идентификатор>.<параметр>` — `yandex_ydb_table.test_table_2.id`.

Внутри ресурса потока изменений располагается блок `consumer`. [Consumer](https://ydb.tech/docs/ru/concepts/topic#consumer) (читатель) — это именованная сущность для чтения данных из топика. У читателя несколько полей настроек. Главное поле — `name` (имя читателя). При инициализации ресурса `yandex_ydb_table_changefeed` можно задать несколько читателей, а можно не создавать ни одного, но тогда невозможно будет читать данные из потока изменений.

Полный перечень полей блока `consumer`:
| **Название поля** | **Тип** | **Описание** |
| --- | --- | --- |
| name | `string`<br>`required` | Имя читателя |
| supported_codecs | `array[string]`<br>`optional` | Поддерживаемые кодировки данных |
| starting_message_timestamp_ms | `integer`<br>`optional` | Временная метка в формате UNIX timestamp, с которой читатель начнет читать данные |

Имя читателя используется в SDK или CLI для [чтения данных](https://ydb.tech/docs/ru/best_practices/cdc#read) из топика.