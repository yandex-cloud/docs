# Пример анализа данных из {{ objstorage-full-name }}

{{yq-full-name}} может выполнять полноценную аналитическую обработку данных, хранящихся в [{{ objstorage-full-name }}](../../storage/concepts/index.md), на SQL-подобном языке — [YQL](https://ydb.tech/ru/docs/yql/reference/syntax/).

В данном примере возьмем заранее подготовленный набор данных - поездки Нью-Йоркского такси за 2019-2021 годы, и посмотрим на распределение времен поездок. 

{% note info %}

{% include [yellow-taxi-disclaimer](../_includes/yellow-taxi-disclaimer.md) %}

{% endnote %}

Данные заранее размещены в {{ objstorage-full-name }} в общедоступном бакете `yq-sample-data` в каталоге `tutorial`.

Для этого необходимо:
1. [Создать подключение к бакету в {{ objstorage-full-name }}](#create_connection).
1. [Выполнить запрос](#run_query).

## Создание подключения { #create_connection }
 
 {% include [tutorial-batch](../_includes/create-tutorial-batch-infra.md) %}

## Выполните запрос { #run_query }
В редакторе запросов в интерфейсе {{yq-full-name}} нажмите кнопку **New analytics query**, в текстовом поле введите текст запроса, указанный ниже.

```sql
$data =
SELECT 
    * 
FROM 
    bindings.`tutorial-analytics`;

$ride_time = 
SELECT
    DateTime::ToMinutes(tpep_dropoff_datetime-tpep_pickup_datetime) as ride_time
FROM $data;

SELECT 
    Histogram::Print(histogram(ride_time)) 
FROM 
    $ride_time;
```

## Результат выполнения запроса
После выполнения запроса станет доступен результат: распределение длительности поездок в такси по числу поездок.

![rides-info](../_assets/yellow-taxi-query.png)