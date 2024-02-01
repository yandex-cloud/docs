# Единый анализ потоковых и аналитических данных

В этом примере вы рассчитаете стоимость поездок в такси в определенных локациях с помощью единого запроса к [аналитическим](../concepts/batch-processing.md) и [потоковым](../concepts/stream-processing.md) данным.

Текст SQL-запроса для обработки обоих видов данных совпадает, различаются только [соединения](../concepts/glossary.md#connection) и [привязки к данным](../concepts/glossary.md#binding) для бакета и потока.

Данные для аналитической обработки предварительно размещены в бакете [{{ objstorage-full-name }}](../../storage/index.yaml) в файлах формата [Parquet](https://parquet.apache.org/docs/file-format/). Потоковые данные будут записаны с помощью генератора в специально созданный поток [{{ yds-full-name }}](../../data-streams/index.yaml).

В обоих случаях используется хранимый в {{ objstorage-name }} справочник для фильтрации данных в запросе.

Для выполнения примера:

1. [{#T}](#before-you-begin).
1. [{#T}](#batch).
1. [{#T}](#stream).

{% note info %}

{% include [yellow-taxi-disclaimer](../_includes/yellow-taxi-disclaimer.md) %}

{% endnote %}

## Подготовьтесь к работе {#before-you-begin}

1. Войдите в [консоль управления]({{ link-console-main }}) или зарегистрируйтесь. Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. На странице [**Биллинг**]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../../resource-manager/operations/folder/create.md).
1. Подключение к потоку данных будет выполняться от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md). [Создайте](../../iam/operations/sa/create.md#create-sa) сервисный аккаунт с именем `datastream-connection-account` и ролью `ydb.editor`.
1. Потоки данных используют {{ ydb-full-name }}. [Создайте](../../ydb/quickstart.md#serverless) бессерверную базу данных.

## Проанализируйте данные из {{ objstorage-name }} {#batch}

### Подключитесь к данным для аналитической обработки {#batch-create-binding}

{% include [tutorial-batch](../_includes/create-tutorial-batch-infra.md) %}

### Выполните запрос {#batch-run-query}

1. В редакторе запросов в интерфейсе {{ yq-name }} нажмите кнопку **Новый аналитический запрос**.
1. В текстовом поле введите текст запроса:

   ```sql
   $data =
   SELECT
       *
   FROM
       `tutorial-analytics`;

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
       HOP(CAST(tpep_pickup_datetime AS Timestamp?), "PT1M", "PT1M", "PT1M"),
       rides.PULocationID;

   SELECT
       *
   FROM
       $time;
   ```

1. Нажмите кнопку **Выполнить**.

### Исследуйте результат {#batch-check-result}

После выполнения аналитического запроса станет доступен результат — распределение стоимости поездок в такси в определенных локациях.

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

## Проанализируйте потоковые данные из {{ yds-name }} {#stream}

### Создайте поток данных {#stream-create-datastream}

{% include [create-stream-tutorial](../../_includes/data-streams/create-stream-tutorial.md) %}

### Настройте генерацию данных {#stream-configure-generation}

{% include [streaming-infra](../_includes/create-tutorial-streaming-infra.md) %}

Запустится генерация данных в поток `yellow-taxi`. Для управления генератором данных используйте кнопки **Стоп** и **Старт**.

### Выполните запрос {#stream-run-query}

1. В редакторе запросов в интерфейсе {{ yq-name }} нажмите кнопку **Новый потоковый запрос**.
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

### Исследуйте результат {#stream-check-result}

После запуска запроса к потоковым данным станет доступен результат — общая стоимость поездок `total_amount` в определенных локациях `PULocationID`, совершенных после запуска запроса.

| #  | PULocationID | time | total_amount |
| --- | --- | --- | --- |
| 1  | 125 | 2022-02-15T12:03:00.000000Z | 1275.4084 |
| 2  | 129 | 2022-02-15T12:03:00.000000Z | 1073.0449 |
| 3  | 126 | 2022-02-15T12:03:00.000000Z | 202.85883 |
| 4  | 121 | 2022-02-15T12:03:00.000000Z | 636.8784  |
| 5  | 124 | 2022-02-15T12:03:00.000000Z | 923.87805 |
| 6  | 127 | 2022-02-15T12:04:00.000000Z | 2105.3125 |
| ... |

## См. также {#see-also}

* [Оператор HOP. Параметры окон в потоковой обработке данных](../concepts/stream-processing-windows.md)
* [Агрегатные функции. Синтаксис YQL]({{ ydb.docs }}/yql/reference/builtins/aggregation)
* [Формат SQL-выражения](../sources-and-sinks/data-streams-binding.md#model-dannyh)
* [{#T}](../concepts/batch-processing.md)
* [{#T}](../concepts/stream-processing.md)
