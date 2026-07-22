---
title: Запись данных в {{ objstorage-full-name }}
description: Из статьи вы узнаете, как записывать данные из {{ yq-full-name }} в {{ objstorage-full-name }} через соединения и привязки к данным.
---

# Запись данных в {{ objstorage-full-name }}


В {{ yq-full-name }} для записи данных в бакет {{ objstorage-full-name }} можно использовать [соединения](#connection-write) или [привязки к данным](#bindings-write).

Пример записи данных в формате `JSON` с использованием привязки к данным:

```sql
INSERT INTO `my_binding`
SELECT
    "value" AS value, "name" AS name
FROM
    $data;
```

Список поддерживаемых форматов и алгоритмов сжатия данных приведен в разделе [Поддерживаемые форматы записи](#write-formats).

## Запись данных через соединение {#connection-write}

Запись данных с помощью соединений удобно использовать для прототипирования и первоначальной настройки. Для записи данных в бакет создайте [соединение](object-storage.md#create-connection) с {{ objstorage-short-name }} и используйте SQL-выражение:

```sql
INSERT INTO <соединение>.<путь>
    WITH
    (
        format='<формат_данных>',
        compression='<формат_сжатия>'
    )
SELECT
    <выражение>
FROM
    <запрос>
```

Где:

* `<соединение>` — название соединения с {{ objstorage-short-name }}.
* `<путь>` — путь внутри бакета, куда будут записаны данные.
* `<формат_данных>` — формат записываемых данных;
* `<формат_сжатия>` — алгоритм сжатия данных;
* `<выражение>` — выражение, определяющее записываемые данные;
* `<запрос>` — запрос-источник данных {{ yq-name }}.

### Пример {#connection-write-example}

Пример запроса для записи данных в {{ objstorage-short-name }} с использованием соединения:

```sql
INSERT INTO `connection`.`test/`
    WITH
    (
        format='csv_with_names'
    )
SELECT
    "value" AS value, "name" AS name
```

Где:

* `connection` — название соединения с {{ objstorage-short-name }}.
* `test/`— путь внутри бакета, куда будут записаны данные.

## Запись данных через привязки к данным {#bindings-write}

Если записывать данные нужно регулярно, то удобно делать это с помощью привязок к данным. При этом нет необходимости указывать все детали работы с этими данными в каждом запросе. Для записи данных в бакет создайте [привязку к данным](object-storage-binding.md) в {{ objstorage-short-name }} и используйте SQL-выражение:

```sql
INSERT INTO `<привязка>`
SELECT
    <выражение>
FROM
    <запрос>
```

Где:

* `<привязка>` — название привязки к данным в {{ objstorage-short-name }}.
* `<выражение>` — выражение, определяющее записываемые данные;
* `<запрос>` — запрос-источник данных {{ yq-name }}.

### Пример {#bindings-write-example}

Пример запроса для записи данных в {{ objstorage-short-name }} с помощью привязки к данным:

```sql
INSERT INTO `test`
SELECT
    "value" AS value, "name" AS name
```

Где:

* `test` — название привязки к данным в {{ objstorage-short-name }}.

## Поддерживаемые форматы записи {#write-formats}

{% include [!](../_includes/supported-objstorage-write-formats.md) %}
