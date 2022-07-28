# Пример анализа потоковых данных

{{yq-full-name}} может выполнять [потоковую обработку](../concepts/stream-processing.md) данных на SQL-подобном языке — [YQL]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/){% endif %}.

В данном примере возьмем заранее подготовленный набор данных - генератор данных про поездки Нью-Йоркского такси, и рассчитаем число поездок и их стоимость за временной интервал. 

Для этого необходимо:
1. [Настроить реквизиты подключения к {{yds-full-name}}](#credentials).
1. [Создать поток данных {{yds-full-name}}](#create_stream).
1. [Запустить генератор данных](#generator_start).
1. [Создать подключение к данным](#create_connection).
1. [Выполнить запрос](#run_query).

### Настройка реквизитов подключения к {{yds-full-name}} { #credentials }

{% include [create-environment](../../_includes/data-streams/create-environment.md) %}


## Создание потока данных {{yds-full-name}} { #create_stream }

Создайте поток данных с именем `yellow-taxi`. Для этого выполните следующие шаги.

{% include [yds-create-stream](../../_includes/data-streams/create-stream-via-console.md) %}

## Запуск генератора данных { #generator_start }

{% include [yellow-taxi-data-generator](../../_includes/query/yellow-taxi-streaming-generator.md) %}

## Создание подключения { #create_connection }

1. Перейдите в интерфейс {{ yq-full-name }} в раздел **Connections** и нажать кнопку **Create**.
1. В открывшемся окне в поле **Name** введите `yds-yellow-taxi`.
1. В выпадающем поле **Type** выберите **Yandex Datastreams**.
1. В поле поле **Database** выберите базу данных {{ydb-name}}, где был создан поток данных `yellow-taxi` в предыдущих пунктах.
1. В поле **Service account** укажите сервисный аккаунт с ролью **admin**, который будет использоваться для доступа к данным. 
1. Создайте подключение, нажав кнопку **Create**.

## Выполнение запроса к потоковым данных { #run_query }

В редакторе запросов в интерфейсе {{yq-full-name}} нажмите кнопку **New streaming query**, в текстовом поле введите текст запроса, указанный ниже.

```sql
$data = 
SELECT 
    CAST(DateTime::MakeDatetime(DateTime::Parse("%Y-%m-%d %H:%M:%S")(JSON_VALUE(Data, "$.tpep_pickup_datetime"))) AS Timestamp) AS tpep_pickup_datetime, 
    CAST(JSON_VALUE(Data, "$.total_amount") AS Float) AS total_amount 
FROM
(
    SELECT 
        CAST(Data AS Json) AS Data 
    FROM 
        `yds-yellow-taxi`.`yellow-taxi` 
    WITH
    (
        format=raw
    )
    LIMIT 10
);

SELECT
    HOP_END() AS time,
    COUNT(*) AS ride_count,
    SUM(total_amount) AS total_amount
FROM 
    $data
GROUP BY 
    HOP(tpep_pickup_datetime, "PT1M", "PT1M", "PT1M");
```

## Результат выполнения запроса
После выполнения запроса станет доступен результат: количество и общая стоимость первых десяти поездок, совершененных после запуска запроса.

![straming-example-result](../_assets/streaming-example-result.png)