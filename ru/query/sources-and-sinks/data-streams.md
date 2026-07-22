---
title: Чтение данных из {{ yds-full-name }} с помощью соединений в {{ yq-full-name }}
description: Из статьи вы узнаете, как настроить соединение и читать данные из {{ yds-full-name }} с помощью {{ yq-full-name }}.
---

# Чтение данных из {{ yds-name }} с помощью соединений в {{ yq-name }}

Соединения удобно использовать для прототипирования и первоначальной настройки подключения к данным {{ yds-full-name }}.

[{{ yds-full-name }}](../../data-streams/concepts/index.md) — сервис для передачи потоков данных нескольким приложениям. Каждое приложение обрабатывает данные независимо от других.

Пример чтения данных в формате JSON из {{ yds-full-name }}:

```sql
SELECT
    JSON_VALUE(CAST(Data AS Json), "$.action") AS action
FROM yds.`input_stream`
WITH (
    format=raw,
    SCHEMA
    (
        Data String
    )
)
LIMIT 10;
```

{% include [limit](../_includes/select-limit.md) %}

## Настройка соединения {#create_connection}

Чтобы настроить чтение данных из {{ yds-full-name }}:

{% include [create-connection](../_includes/create-connection.md) %}

## Модель данных {#data-model}

Данные через {{ yds-full-name }} передаются в бинарном виде. Для чтения данных используйте SQL-выражение следующего вида:

```sql
SELECT
    <выражение>
FROM
    <соединение>.<имя_потока>
WITH
(
    format=raw,
    SCHEMA
    (
        Data String
    )
)
WHERE
    <фильтр>;
```

Где:

* `<выражение>` — выражение, определяющее результат запроса;
* `<соединение>` — название соединения с потоком данных {{ yds-short-name }}, созданного в предыдущем разделе;
* `<имя_потока>` — название потока данных в {{ yds-short-name }};
* `<фильтр>` — условие фильтрации данных.

## Пример чтения данных {#example}

Пример запроса для чтения данных из {{ yds-full-name }}:

```sql
$data =
SELECT
    JSON_VALUE(Data, "$.host") AS host,
    JSON_VALUE(Data, "$.count") AS count,
    JSON_VALUE(Data, "$.tag") AS tag,
FROM
(
    SELECT
        CAST(Data AS Json) AS Data
    FROM yds.`input_stream`
    WITH
    (
        format=raw,
        SCHEMA
        (
            Data String
        )
    )
)
WHERE
    JSON_VALUE(Data, "$.tag") = "my_tag";

SELECT
    *
FROM
    $data
LIMIT 10;
```

Где:

#|
|| **Поле** | **Тип** | **Описание** ||
|| `yds` |  | Название соединения с {{ yds-full-name }}. ||
|| `input_stream` |  | Название потока-источника данных. ||
|| `host` | Строка | Название хоста. ||
|| `count` | Строка | Количество событий. ||
|| `tag` | Строка | Тег события. ||
|| `raw` | Строка | Формат данных. На данный момент поддерживается только формат `raw` — необработанные данные. ||
|#
