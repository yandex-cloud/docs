# Пример единого анализа потоковых и аналитических данных 

{{yq-full-name}} разработан в концепции [объединенных потоковых и аналитических вычислений](../concepts/unified-processing.md), это позволяет с помощью единого запроса обрабатывать как потоковые, так и аналитические данные.

В примере ниже рассчитаем количество совершаемых поездок в такси и их стоимость, которые выполняются только в определенных локациях над аналитическими и потоковыми данными с помощью единого запроса. Оба запроса используют хранимый в {{ objstorage-full-name }} справочник для фильтрации данных в запросе.

В данном примере будут использоваться два заранее подготовленных набора данных:
1. Потоковый генератор данных про поездки Нью-Йоркского такси, по нему будем рассчитывать число поездок и их стоимость за временной интервал. Генератор запускается в рамках инфраструктуры обучения {{yq-full-name}}.
1. Аналитические данные заранее размещены в {{ objstorage-full-name }} в общедоступном бакете `yq-sample-data` в каталоге `tutorial`.

{% note info %}

{% include [yellow-taxi-disclaimer](../_includes/yellow-taxi-disclaimer.md) %}

{% endnote %}

Для этого необходимо:
1. [Создать инфраструктуру для потоковых данных](#generator_start).
1. [Создать инфраструктуру для аналитических данных](#batch_start).
1. [Выполнить аналитический запрос](#run_query_analytics).
1. [Выполнить потоковый запрос](#run_query_streaming).


## Подготовительные шаги {#prepare}
Для начала работы необходимо выполнить следующие подготовительные шаги.

### Инфраструктура для потоковых данных {{yds-full-name}} { #create_stream }

Создайте поток данных с именем `yellow-taxi`. Для этого выполните следующие шаги.

{% include [yds-create-stream](../../_includes/data-streams/create-stream-via-console.md) %}

Создайте инфраструктуру для генерации данных:

{% include [streaming-infra](../_includes/create-tutorial-streaming-infra.md) %}

По окончании создания инфраструктуры, запустится генерация данных в поток `yellow-taxi`.

### Инфраструктура для аналитических данных { #batch_start }

{% include [tutorial-batch](../_includes/create-tutorial-batch-infra.md) %}


## Выполнение аналитического запроса { #run_query_analytics }

В редакторе запросов в интерфейсе {{ yq-full-name }} нажмите кнопку **New Analytics Query**, в текстовом поле введите текст запроса, указанный ниже.

```sql
$data = 
SELECT 
    *
FROM 
    `bindings`.`tutorial-analytics`;

$locations = 
SELECT 
    PULocationID
FROM 
    `tutorial-analytics`.`nyc_taxi_sample/example_locations.csv`
WITH 
(
    format=csv_with_names,
    SCHEMA 
    (
        PULocationID String 
    )
);

$time = 
SELECT
    HOP_END() AS time,
    rides.PULocationID AS PULocationID,
    SUM(total_amount) AS total_amount    
FROM $data AS rides
INNER JOIN $locations AS locations
    ON rides.PULocationID=locations.PULocationID
GROUP BY 
    HOP(cast(tpep_pickup_datetime AS Timestamp?), "PT1M", "PT1M", "PT1M"),
    rides.PULocationID;

SELECT 
    * 
FROM 
    $time;
```

### Результат выполнения запроса
После выполнения запроса станет доступен результат: распределение длительности поездок в такси по числу поездок.

![rides-info](../../_assets/query/unified-analytics-example.png)

## Выполнение запроса к потоковым данным { #run_query_streaming }

В редакторе запросов в интерфейсе {{yq-full-name}} нажмите кнопку **New streaming query**, в текстовом поле введите текст запроса, указанный ниже.

```sql
$data = 
SELECT 
    *
FROM bindings.`tutorial-streaming`
LIMIT 10;

$locations = 
SELECT 
    PULocationID
FROM 
    `tutorial-analytics`.`nyc_taxi_sample/example_locations.csv`
WITH 
(
    format=csv_with_names,
    SCHEMA 
    (
        PULocationID String 
    )
);

$time = 
SELECT
    HOP_END() AS time,
    rides.PULocationID AS PULocationID,
    SUM(total_amount) AS total_amount    
FROM $data AS rides
INNER JOIN $locations AS locations
    ON rides.PULocationID=locations.PULocationID
GROUP BY 
    HOP(cast(tpep_pickup_datetime AS Timestamp?), "PT1M", "PT1M", "PT1M"),
    rides.PULocationID;

SELECT 
    * 
FROM 
    $time;
```

### Результат выполнения запроса
После выполнения запроса станет доступен результат: количество и общая стоимость первых десяти поездок, совершенных после запуска запроса, в определенных локациях.

![unified-streaming-example](../../_assets/query/unified-streaming-example.png)

## Выводы

В обоих примерах выше использовался единый запрос для анализа аналитических и потоковых данных. Запросы различаются подключениями к данным: одни данные хранятся в {{ objstorage-full-name }}, а другие в {{ yds-full-name }}. 

Текст SQL-запроса анализа данных одинаков для обоих сценариев.