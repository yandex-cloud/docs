# Запись данных в {{ yds-full-name }}

[{{ yds-full-name }}](../../data-streams/concepts/index.md) это сервис, позволяющий передавать потоки данных сразу нескольким приложениям для обработки, при этом каждое приложение обрабатывает такие данные независимо от другого.

Пример записи данных в формате `JSON` в {{ yds-full-name }}.

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

Для чтения данных из {{ yds-full-name }} необходимо:
1. Перейти в интерфейс {{ yq-full-name }} в раздел **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}** и нажать кнопку **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. В открывшемся окне в поле **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}** указать название соединения с {{ yds-full-name }}.
1. В выпадающем поле **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}** выбрать `{{ ui-key.yql.yq-connection.action_datastreams }}`.
1. В выпадающем поле **{{ ui-key.yql.yq-connection-form.database.input-label }}** выбрать базу данных {{ ydb-full-name }}, где ранее был создан поток {{ yds-full-name }}.
1. В поле **{{ ui-key.yql.yq-connection-form.service-account.input-label }}** выбрать сервисный аккаунт, который будет использоваться для чтения данных, или создать новый, выдав ему права [`yds.writer`](../../data-streams/security/index.md).
1. Создать соединение, нажав кнопку **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

## Модель данных

Данные через {{ yds-full-name }} передаются в бинарном виде. Запись данных выполняется с помощью SQL-выражений и в общем случае выглядит следующим образом:

```sql
INSERT INTO <соединение>.<имя_потока>
    <выражение> 
FROM 
   <запрос>
```

Где:

- `<соединение>` — название соединения с потоком данных {{ yds-short-name }}, созданного в предыдущем пункте.
- `<имя_потока>` — название потока данных в {{ yds-short-name }}.
- `<запрос>` — запрос-источник данных {{ yq-full-name }}.

## Пример записи данных

Пример запроса для чтения данных из {{ yds-full-name }} и записи результатов в {{ yds-full-name }}.

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

|Поле|Тип|Описание|
|--|---|---|
|`yds`| |Название соединения с {{ yds-full-name }}|
|`input_stream`| |Название потока-источника данных в SQL-запросе|
|`output_stream`| |Название потока-приемника данных в SQL-запросе|
|`host`|Строка|Строковый параметр запроса|
|`count`|Целое|Численный параметр запроса|
|`raw`|Строка|Формат данных. На данный поддерживается только формат `raw` - сырые данные|

Результаты обработки записываются в выходной поток {{ yds-full-name }}. Для удобства обработки этих данных, данные преобразовываются в формат `JSON`, это выполняется с помощью конструкции:

```sql
    ToBytes(Unwrap(Json::SerializeJson(Yson::From(
    <|"key": value|>,
    <|"key2": 
        <|"child_key": child_value|>,
    |>,
    ))))
```

В документации языка YQL доступно детальное описание модулей [Yson](https://ydb.tech/docs/ru/yql/reference/udf/list/yson), [Json](https://ydb.tech/docs/ru/yql/reference/types/json) и [его функций](https://ydb.tech/docs/ru/yql/reference/builtins/json), [<|"key": value|>](https://ydb.tech/docs/ru/yql/reference/builtins/struct).

## Поддерживаемые форматы записи

{% include [!](../_includes/supported-yds-write-formats.md) %}
