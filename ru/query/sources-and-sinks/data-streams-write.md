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

## Настройка подключения 
Для чтения данных из {{ yds-full-name }} необходимо:
1. Перейти в интерфейс {{ yq-full-name }} в раздел **Connections** и нажать кнопку **Create**.
1. В открывшемся окне в поле **Name** указать название подключения к {{ yds-full-name }}.
1. В выпадающем поле **Type** выбрать **Data Streams**.
1. В выпадающем поле **Database** выбрать базу данных {{ydb-full-name}}, где ранее был создан поток {{yds-full-name}}.
1. В поле **Service account** выбрать сервисный аккаунт, который будет использоваться для чтения данных, или создать новый, выдав ему права [`yds.writer`](../../data-streams//security/index.md). 
1. Создать подключение, нажав кнопку **Create**.

## Модель данных

Данные через {{yds-full-name }} передаются в бинарном виде. Запись данных выполняется с помощью SQL-выражений и в общем случае выглядит следующим образом:

```sql
INSERT INTO <yds_connection_name>.<stream_name>
    <expression> 
FROM 
   <query>
```

Где:

- `yds_connection_name` — название подключения к потоку данных {{yds-short-name}}, созданного в предыдущем пункте.
- `stream_name` — название потока данных в {{yds-short-name}}.
- `query` — запрос-источник данных {{ yq-full-name }}.

## Пример записи данных

Пример запроса для чтения данных из {{ yds-full-name }} и записи результатов в {{ yds-full-name }}.

```sql
$data = 
SELECT 
    JSON_VALUE(Data, "$.host") as host,
    CAST(JSON_VALUE(Data, "$.count") as Int) as count,
    JSON_VALUE(Data, "$.tag") as tag,    
FROM 
(
    SELECT
        CAST(Data as Json) as Data
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
|`yds`| |Название подключения к {{ yds-full-name }}|
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

В документации языка YQL доступно детальное описание модулей [Yson](https://ydb.tech/ru/docs/yql/reference/udf/list/yson), [Json](https://ydb.tech/ru/docs/yql/reference/types/json) и [его функций](https://ydb.tech/ru/docs/yql/reference/builtins/json), [<|"key": value|>](https://ydb.tech/ru/docs/yql/reference/builtins/struct).

## Поддерживаемые форматы записи

{% include [!](../_includes/supported-yds-write-formats.md) %}
