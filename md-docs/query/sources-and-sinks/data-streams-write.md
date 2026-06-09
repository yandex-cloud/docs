# Запись данных в Yandex Data Streams

[Yandex Data Streams](../../data-streams/concepts/index.md) это сервис, позволяющий передавать потоки данных сразу нескольким приложениям для обработки, при этом каждое приложение обрабатывает такие данные независимо от другого.

Пример записи данных в формате `JSON` в Yandex Data Streams.

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

Для чтения данных из Yandex Data Streams необходимо:
1. [Перейти](../../console/operations/select-service.md#select-service) в сервис **Yandex Query** в раздел **Соединения** и нажать кнопку **Создать**.
1. В открывшемся окне в поле **Имя** указать название соединения с Yandex Data Streams.
1. В выпадающем поле **Тип** выбрать `Data Streams`.
1. В выпадающем поле **База данных** выбрать базу данных Yandex Managed Service for YDB, где ранее был создан поток Yandex Data Streams.
1. В поле **Сервисный аккаунт** выбрать сервисный аккаунт, который будет использоваться для чтения данных, или создать новый, выдав ему права [`yds.writer`](../../data-streams/security/index.md).
1. Создать соединение, нажав кнопку **Создать**.

## Модель данных

Данные через Yandex Data Streams передаются в бинарном виде. Запись данных выполняется с помощью SQL-выражений и в общем случае выглядит следующим образом:

```sql
INSERT INTO <соединение>.<имя_потока>
    <выражение> 
FROM 
   <запрос>
```

Где:

- `<соединение>` — название соединения с потоком данных Data Streams, созданного в предыдущем пункте.
- `<имя_потока>` — название потока данных в Data Streams.
- `<запрос>` — запрос-источник данных Yandex Query.

## Пример записи данных

Пример запроса для чтения данных из Yandex Data Streams и записи результатов в Yandex Data Streams.

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
|`yds`| |Название соединения с Yandex Data Streams|
|`input_stream`| |Название потока-источника данных в SQL-запросе|
|`output_stream`| |Название потока-приемника данных в SQL-запросе|
|`host`|Строка|Строковый параметр запроса|
|`count`|Целое|Численный параметр запроса|
|`raw`|Строка|Формат данных. На данный поддерживается только формат `raw` - сырые данные|

Результаты обработки записываются в выходной поток Yandex Data Streams. Для удобства обработки этих данных, данные преобразовываются в формат `JSON`, это выполняется с помощью конструкции:

```sql
    ToBytes(Unwrap(Json::SerializeJson(Yson::From(
    <|"key": value|>,
    <|"key2": 
        <|"child_key": child_value|>,
    |>,
    ))))
```

В документации языка YQL доступно детальное описание модулей [Yson](https://ydb.tech/docs/ru//yql/reference/udf/list/yson), [Json](https://ydb.tech/docs/ru//yql/reference/types/json) и [его функций](https://ydb.tech/docs/ru//yql/reference/builtins/json), [<|"key": value|>](https://ydb.tech/docs/ru//yql/reference/builtins/struct).

## Поддерживаемые форматы записи

В Data Streams можно выполнять запись только в виде байтового потока, который интепретируется на принимающей стороне. 

Настройки форматов файлов и алгоритмов сжатия при записи в Data Streams не применяются.