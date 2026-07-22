[Документация Yandex Cloud](../../index.md) > [Yandex Query](../index.md) > Источники и приемники данных > Работа с Data Streams > Чтение данных с помощью соединений

# Чтение данных из Data Streams с помощью соединений в Query

Соединения удобно использовать для прототипирования и первоначальной настройки подключения к данным Yandex Data Streams.

[Yandex Data Streams](../../data-streams/concepts/index.md) — сервис для передачи потоков данных нескольким приложениям. Каждое приложение обрабатывает данные независимо от других.

Пример чтения данных в формате JSON из Yandex Data Streams:

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

Чтобы настроить чтение данных из Yandex Data Streams:

1. [Перейдите](https://yq.yandex.cloud) в сервис **Yandex Query**.
1. На панели слева выберите **Соединения**.
1. Нажмите **Создать**.
1. В открывшемся окне в поле **Имя** укажите название соединения с Yandex Data Streams.
1. В выпадающем поле **Тип** выберите `Data Streams`.
1. В поле **Облако и каталог** выберите расположение источника данных.
1. В выпадающем поле **База данных** выберите базу данных Yandex Managed Service for YDB, где ранее был создан поток Yandex Data Streams.
1. В поле **Сервисный аккаунт** выберите сервисный аккаунт, который будет использоваться для чтения данных, или создайте новый, выдав ему права [`yds.editor`](../../data-streams/security/index.md#yds-editor).

   Чтобы использовать сервисный аккаунт, пользователю нужна [роль](../../iam/security/index.md#iam-serviceAccounts-user) `iam.serviceAccounts.user`.

1. Нажмите **Создать**.

## Модель данных {#data-model}

Данные через Yandex Data Streams передаются в бинарном виде. Для чтения данных используйте SQL-выражение следующего вида:

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
* `<соединение>` — название соединения с потоком данных Data Streams, созданного в предыдущем разделе;
* `<имя_потока>` — название потока данных в Data Streams;
* `<фильтр>` — условие фильтрации данных.

## Пример чтения данных {#example}

Пример запроса для чтения данных из Yandex Data Streams:

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
|| `yds` |  | Название соединения с Yandex Data Streams. ||
|| `input_stream` |  | Название потока-источника данных. ||
|| `host` | Строка | Название хоста. ||
|| `count` | Строка | Количество событий. ||
|| `tag` | Строка | Тег события. ||
|| `raw` | Строка | Формат данных. На данный момент поддерживается только формат `raw` — необработанные данные. ||
|#