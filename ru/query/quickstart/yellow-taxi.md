# Пример анализа данных из {{ objstorage-full-name }}

{{yq-full-name}} может выполнять полноценную аналитическую обработку данных, хранящихся в [{{ objstorage-full-name }}](../../storage/concepts/index.md), на SQL-подобном языке — [YQL](../yql-docs-core/syntax/index.md).

В данном примере возьмем заранее подготовленный набор данных - поездки Нью-Йоркского такси за 2018 год, и посмотрим на распределение времен поездок. 

{% note info %}

{% include [yellow-taxi-disclaimer](../../_includes/query/yellow-taxi-disclaimer.md) %}

{% endnote %}

Данные заранее размещены в {{ objstorage-full-name }} в общедоступном бакете `yq-sample-data` в каталоге `nyc_taxi_csv`.

Для этого необходимо:
1. [Создать подключение к бакету в {{ objstorage-full-name }}](#create_connection).
1. [Выполнить запрос](#run_query).

## Создание подключения { #create_connection }

{% include [objstorage-connection-create](../../_includes/query/create-objstorage-connection.md) %}

## Выполните запрос { #run_query }
В редакторе запросов в интерфейсе {{yq-full-name}} нажмите кнопку **New analytics query**, в текстовом поле введите текст запроса, указанный ниже.

```sql
$data = 
SELECT 
    * 
FROM 
    `yellow-taxi`.object("nyc_taxi_csv/yellow_tripdata_2018-01.csv.gz", CSVWithNames, "Gzip" as compression) 
WITH SCHEMA (
    INT as VendorID,
    Datetime as tpep_pickup_datetime,
    Datetime as tpep_dropoff_datetime,
    Int as passenger_count,
    float as trip_distance,
    String as RatecodeID,
    String as store_and_fwd_flag,
    String as PULocationID,
    String as DOLocationID,
    Int as payment_type,
    Double as fare_amount,
    String as extra,
    Double as mta_tax,
    Double as tip_amount,
    Double as tolls_amount,
    Double as improvement_surcharge,
    Double as total_amount);

$ride_time = 
SELECT
    DateTime::ToMinutes(tpep_dropoff_datetime-tpep_pickup_datetime) as ride_time
FROM 
    $data;

SELECT 
    Histogram::Print(histogram(ride_time)) 
FROM 
    $ride_time;
```

## Результат выполнения запроса
После выполнения запроса станет доступен результат: распределение длительности поездок в такси по числу поездок.

![rides-info](../_assets/yellow-taxi-query.png)