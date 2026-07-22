---
title: Запись данных из {{ yq-full-name }} в потоки {{ yds-full-name }}
description: Из статьи вы узнаете, как записывать данные из {{ yq-full-name }} в потоки {{ yds-full-name }}.
---

# Запись данных из {{ yq-full-name }} в потоки {{ yds-full-name }}

[{{ yds-full-name }}](../../data-streams/concepts/index.md) — сервис для передачи потоков данных нескольким приложениям. Каждое приложение обрабатывает данные независимо от других.

Пример записи данных в формате JSON в {{ yds-full-name }}:

```sql
INSERT INTO yds.`output_stream`
SELECT
    ToBytes(Unwrap(Json::SerializeJson(Yson::From(
    <|"predefined":
            <|
                "host": host,
                "count": count,
            |>,
            "optional":
            <|
                "tag": tag
            |>
        |>))))
FROM
    $data;
```

## Настройка соединения {#connect}

Чтобы настроить запись данных в {{ yds-full-name }}:

1. [Перейдите]({{ link-console-yq }}) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. На панели слева выберите **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
1. Нажмите **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. В открывшемся окне в поле **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}** укажите название соединения с {{ yds-full-name }}.
1. В поле **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}** выберите `{{ ui-key.yql.yq-connection.action_datastreams }}`.
1. В поле **{{ ui-key.yql.yq-connection-form.database.input-label }}** выберите базу данных {{ ydb-full-name }}, где ранее был создан поток {{ yds-full-name }}.
1. В поле **{{ ui-key.yql.yq-connection-form.service-account.input-label }}** выберите сервисный аккаунт, который будет использоваться для записи данных, или создайте новый и назначьте ему роль [`yds.writer`](../../data-streams/security/index.md#yds-writer).
1. Нажмите **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

## Модель данных {#data-model}

Данные через {{ yds-full-name }} передаются в бинарном виде. Запись данных выполняется с помощью SQL-выражений и в общем случае выглядит следующим образом:

```sql
INSERT INTO <соединение>.<имя_потока>
    <выражение>
FROM
    <запрос>
```

Где:

* `<соединение>` — название соединения с потоком данных {{ yds-short-name }}, созданного в предыдущем разделе.
* `<имя_потока>` — название потока данных в {{ yds-short-name }}.
* `<выражение>` — выражение, определяющее записываемые данные.
* `<запрос>` — запрос-источник данных {{ yq-full-name }}.

## Пример записи данных {#example}

Пример запроса для чтения данных из {{ yds-full-name }} и записи результатов в {{ yds-full-name }}:

```sql
$data =
SELECT
    JSON_VALUE(Data, "$.host") AS host,
    CAST(JSON_VALUE(Data, "$.count") AS Int) AS count,
    JSON_VALUE(Data, "$.tag") AS tag,
FROM
(
    SELECT
        CAST(Data AS Json) AS Data
    FROM yds.`input_stream`
    WITH(
        format=raw,
        SCHEMA
        (
            Data String
        )
    )
)
WHERE
    JSON_VALUE(Data, "$.tag") = "my_tag";

INSERT INTO yds.`output_stream`
SELECT
    ToBytes(Unwrap(Json::SerializeJson(Yson::From(
    <|"predefined":
            <|
                "host": host,
                "count": count,
            |>,
            "optional":
            <|
                "tag": tag
            |>
        |>))))
FROM
    $data;
```

Где:

#|
|| **Поле** | **Тип** | **Описание** ||
|| `yds` |  | Название соединения с {{ yds-full-name }}. ||
|| `input_stream` |  | Название потока — источника данных в SQL-запросе. ||
|| `output_stream` |  | Название потока — приемника данных в SQL-запросе. ||
|| `host` | Строка | Строковый параметр запроса. ||
|| `count` | Целое число | Числовой параметр запроса. ||
|| `raw` | Строка | Формат данных. На данный момент поддерживается только формат `raw` — необработанные данные. ||
|#

Результаты обработки записываются в выходной поток {{ yds-full-name }}. Чтобы упростить обработку, результаты преобразуются в формат JSON с помощью следующей конструкции:

```sql
    ToBytes(Unwrap(Json::SerializeJson(Yson::From(
    <|"key": value|>,
    <|"key2": 
        <|"child_key": child_value|>,
    |>,
    ))))
```

В документации YQL приведено подробное описание модулей [Yson]({{ ydb.docs }}/yql/reference/udf/list/yson) и [Json]({{ ydb.docs }}/yql/reference/types/json), [функций для работы с JSON]({{ ydb.docs }}/yql/reference/builtins/json) и [структур]({{ ydb.docs }}/yql/reference/builtins/struct).

## Поддерживаемые форматы записи {#supported-formats}

{% include [!](../_includes/supported-yds-write-formats.md) %}
