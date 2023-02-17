# Пример единого анализа потоковых и аналитических данных 

{{yq-full-name}} разработан в концепции [объединенных потоковых и аналитических вычислений](../concepts/unified-processing.md), это позволяет с помощью единого запроса обрабатывать как потоковые, так и аналитические данные.

В этом примере с помощью единого запроса рассчитаем количество и стоимость поездок в такси, совершаемых в определенных локациях.

Будем использовать набор данных про поездки Нью-Йоркского такси, подготовленный заранее:
* С помощью потокового генератора данных.
* С помощью аналитических данных, которые размещены в {{ objstorage-full-name }} в общедоступном бакете `yq-sample-data` в каталоге `tutorial`.

В обоих случаях используется хранимый в {{ objstorage-full-name }} справочник для фильтрации данных в запросе.

Для выполнения примера:
1. [Подготовьтесь к работе](#before-you-begin).
1. [Проанализируйте данные из {{ objstorage-full-name }}](#analyze-data).
1. [Проанализируйте потоковые данные](#analyze-streaming).
1. [Сделайте выводы](#conclusions).

{% note info %}

{% include [yellow-taxi-disclaimer](../_includes/yellow-taxi-disclaimer.md) %}

{% endnote %}

## Перед началом работы {#before-you-begin}

1. Войдите в [консоль управления]({{ link-console-main }}) или зарегистрируйтесь. Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
{% if product == "yandex-cloud" %}
1. [На странице биллинга]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
{% endif %}
1. Если у вас еще нет каталога, [создайте его](../../resource-manager/operations/folder/create.md).
1. Подключение к потоку данных будет выполняться от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md). [Создайте](../../iam/operations/sa/create.md#create-sa) сервисный аккаунт с именем `datastream-connection-account` и ролью `ydb.editor`.
1. Потоки данных используют {{ ydb-full-name }}. [Создайте](../../ydb/quickstart.md#serverless) бессерверную базу данных.

## Проанализируйте данные из {{ objstorage-full-name }} {#analyze-data}

### Создайте подключение для аналитической обработки данных {#create-binding}

{% include [tutorial-batch](../_includes/create-tutorial-batch-infra.md) %}

### Выполните запрос {#run-query-analytics}

1. В редакторе запросов в интерфейсе {{yq-full-name}} нажмите кнопку **Новый аналитический запрос**.
1. В текстовом поле введите текст запроса:

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
1. Нажмите кнопку **Выполнить**.

### Исследуйте результат {#check-result-analytics}

После выполнения аналитического запроса станет доступен результат: распределение длительности поездок в такси по числу поездок.

| #  | time | PULocationID | total_amount |
| --- | --- | --- | --- |
| 1  | 2017-12-31T22:24:00.000000Z | 120 | 7.54  |
| 2  | 2018-01-01T00:13:00.000000Z | 120 | 48.8  |
| 3  | 2018-01-01T03:25:00.000000Z | 120 | 30.8  |
| 4  | 2018-01-01T11:29:00.000000Z | 120 | 32.88 |
| 5  | 2018-01-01T15:13:00.000000Z | 120 | 9.8   |
| 6  | 2018-01-01T22:03:00.000000Z | 120 | 14.8  |
| 7  | 2018-01-02T19:28:00.000000Z | 120 | 7.3   |
| 8  | 2018-01-03T10:17:00.000000Z | 120 | 81.3  |

## Проанализируйте потоковые данные {#analyze-streaming}

### Создайте поток данных {#create-datastream}

{% include [create-stream-tutorial](../../_includes/data-streams/create-stream-tutorial.md) %}

### Настройте генерацию данных {#configure-generation}

{% include [streaming-infra](../_includes/create-tutorial-streaming-infra.md) %}

Запустится генерация данных в поток `yellow-taxi`. Для управления генератором данных используйте кнопки **Стоп** и **Старт**.

### Выполните запрос {#run-query-streaming}

1. В редакторе запросов в интерфейсе {{yq-full-name}} нажмите кнопку **Новый потоковый запрос**.
1. В текстовом поле введите текст запроса:

   ```sql
   $data = 
   SELECT 
       *
   FROM bindings.`tutorial-streaming`;

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
1. Нажмите кнопку **Выполнить**.

### Исследуйте результат {#check-result-streaming}

После выполнения запроса к потоковым данным станет доступен результат: количество и общая стоимость поездок, совершененных после запуска запроса, в определенных локациях.

| #  | PULocationID | time | total_amount |
| --- | --- | --- | --- |
| 1  | 125 | 2022-02-15T12:03:00.000000Z | 1275.4084 | 
| 2  | 129 | 2022-02-15T12:03:00.000000Z | 1073.0449 |
| 3  | 126 | 2022-02-15T12:03:00.000000Z | 202.85883 |
| 4  | 121 | 2022-02-15T12:03:00.000000Z | 636.8784  |
| 5  | 124 | 2022-02-15T12:03:00.000000Z | 923.87805 |
| 6  | 127 | 2022-02-15T12:04:00.000000Z | 2105.3125 |

## Выводы {#conclusions}

В примере выше использовался единый запрос для анализа данных из {{ objstorage-full-name }} и потоковых данных. Текст SQL-запросов анализа данных одинаков, запросы различаются соединениями с данными: одни данные хранятся в {{ objstorage-full-name }}, а другие в {{ yds-full-name }}.
