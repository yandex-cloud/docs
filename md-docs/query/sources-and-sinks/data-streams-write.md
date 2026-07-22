[Документация Yandex Cloud](../../index.md) > [Yandex Query](../index.md) > Источники и приемники данных > Работа с Data Streams > Запись данных

# Запись данных из Yandex Query в потоки Yandex Data Streams

[Yandex Data Streams](../../data-streams/concepts/index.md) — сервис для передачи потоков данных нескольким приложениям. Каждое приложение обрабатывает данные независимо от других.

Пример записи данных в формате JSON в Yandex Data Streams:

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

Чтобы настроить запись данных в Yandex Data Streams:

1. [Перейдите](https://yq.yandex.cloud) в сервис **Yandex Query**.
1. На панели слева выберите **Соединения**.
1. Нажмите **Создать**.
1. В открывшемся окне в поле **Имя** укажите название соединения с Yandex Data Streams.
1. В поле **Тип** выберите `Data Streams`.
1. В поле **База данных** выберите базу данных Yandex Managed Service for YDB, где ранее был создан поток Yandex Data Streams.
1. В поле **Сервисный аккаунт** выберите сервисный аккаунт, который будет использоваться для записи данных, или создайте новый и назначьте ему роль [`yds.writer`](../../data-streams/security/index.md#yds-writer).
1. Нажмите **Создать**.

## Модель данных {#data-model}

Данные через Yandex Data Streams передаются в бинарном виде. Запись данных выполняется с помощью SQL-выражений и в общем случае выглядит следующим образом:

```sql
INSERT INTO <соединение>.<имя_потока>
    <выражение>
FROM
    <запрос>
```

Где:

* `<соединение>` — название соединения с потоком данных Data Streams, созданного в предыдущем разделе.
* `<имя_потока>` — название потока данных в Data Streams.
* `<выражение>` — выражение, определяющее записываемые данные.
* `<запрос>` — запрос-источник данных Yandex Query.

## Пример записи данных {#example}

Пример запроса для чтения данных из Yandex Data Streams и записи результатов в Yandex Data Streams:

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
|| `yds` |  | Название соединения с Yandex Data Streams. ||
|| `input_stream` |  | Название потока — источника данных в SQL-запросе. ||
|| `output_stream` |  | Название потока — приемника данных в SQL-запросе. ||
|| `host` | Строка | Строковый параметр запроса. ||
|| `count` | Целое число | Числовой параметр запроса. ||
|| `raw` | Строка | Формат данных. На данный момент поддерживается только формат `raw` — необработанные данные. ||
|#

Результаты обработки записываются в выходной поток Yandex Data Streams. Чтобы упростить обработку, результаты преобразуются в формат JSON с помощью следующей конструкции:

```sql
    ToBytes(Unwrap(Json::SerializeJson(Yson::From(
    <|"key": value|>,
    <|"key2": 
        <|"child_key": child_value|>,
    |>,
    ))))
```

В документации YQL приведено подробное описание модулей [Yson](https://ydb.tech/docs/ru//yql/reference/udf/list/yson) и [Json](https://ydb.tech/docs/ru//yql/reference/types/json), [функций для работы с JSON](https://ydb.tech/docs/ru//yql/reference/builtins/json) и [структур](https://ydb.tech/docs/ru//yql/reference/builtins/struct).

## Поддерживаемые форматы записи {#supported-formats}

В Data Streams можно выполнять запись только в виде байтового потока, который интепретируется на принимающей стороне. 

Настройки форматов файлов и алгоритмов сжатия при записи в Data Streams не применяются.