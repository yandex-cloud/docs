# Чтение данных из Data Streams с помощью соединений в Query

При работе с Yandex Data Streams с помощью соединений удобно выполнять прототипирование, первоначальную настройку подключений к данным.

[Yandex Data Streams](../../data-streams/concepts/index.md) - это сервис, позволяющий передавать потоки данных сразу нескольким приложениям для обработки, при этом каждое приложение обрабатывает такие данные независимо от другого.

Пример чтения данных в формате `Json` из Yandex Data Streams.

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

{% note info %}

Данные из потокового источника передаются в виде бесконечного потока. Чтобы остановить обработку и получить результат в консоли, данные в примере ограничены с помощь оператора `LIMIT`, который задает количество строк результата.

{% endnote %}

## Настройка соединения {#create_connection}

Для чтения данных из Yandex Data Streams необходимо:

1. [Перейти](../../console/operations/select-service.md#select-service) в сервис **Yandex Query** в раздел **Соединения** и нажать кнопку **Создать**.
1. В открывшемся окне в поле **Имя** указать название соединения с Yandex Data Streams.
1. В выпадающем поле **Тип** выбрать `Data Streams`.
1. В поле **Облако и каталог** выберите расположение источника данных.
1. В выпадающем поле **База данных** выбрать базу данных Yandex Managed Service for YDB, где ранее был создан поток Yandex Data Streams.
1. В поле **Сервисный аккаунт** выбрать сервисный аккаунт, который будет использоваться для чтения данных, или создать новый, выдав ему права [`yds.editor`](../../data-streams/security/index.md#yds-editor).

   Чтобы использовать сервисный аккаунт, пользователю нужна [роль](../../iam/security/index.md#iam-serviceAccounts-user) `iam.serviceAccounts.user`.

1. Создать соединение, нажав кнопку **Создать**.

## Модель данных

Данные через Yandex Data Streams передаются в бинарном виде. Чтение данных выполняется с помощью SQL-выражений.

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
WHERE <фильтр>;
```

Где:

- `<соединение>` — название соединения с потоком данных Data Streams, созданного в предыдущем пункте.
- `<имя_потока>` — название потока данных в Data Streams.

## Пример чтения данных

Пример запроса для чтения данных из Yandex Data Streams и записи результатов в Yandex Data Streams.

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

|Поле|Тип|Описание|
|--|---|---|
|`yds`| |Название соединения с Yandex Data Streams|
|`input_stream`| |Название потока-источника данных в SQL-запросе|
|`host`|Строка|Строковый параметр запроса|
|`raw`|Строка|Формат данных. На данный поддерживается только формат `raw` - сырые данные|