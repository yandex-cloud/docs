# Потоковая обработка данных из {{ yds-full-name }}

В этом примере вы выполните [потоковую обработку данных](../concepts/stream-processing.md) о поездках Нью-Йоркского такси. Данные для примера будут записаны с помощью генератора в специально созданный поток [{{ yds-full-name }}](../../data-streams/index.yaml).

В результате вы получите общую стоимость первых 10 поездок после начала обработки потоковых данных.

Для выполнения примера:

1. [{#T}](#before-you-begin).
1. [{#T}](#create-datastream).
1. [{#T}](#configure-generation).
1. [{#T}](#run-query).
1. [{#T}](#check-result).

{% note info %}

{% include [yellow-taxi-disclaimer](../_includes/yellow-taxi-disclaimer.md) %}

{% endnote %}

## Подготовьтесь к работе {#before-you-begin}

1. Войдите в [консоль управления]({{ link-console-main }}) или зарегистрируйтесь. Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. На странице [**{{ ui-key.yacloud_billing.billing.label_service }}**]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../../resource-manager/operations/folder/create.md).
1. Подключение к потоку данных будет выполняться от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md). [Создайте](../../iam/operations/sa/create.md#create-sa) сервисный аккаунт с именем `datastream-connection-account` и ролью `ydb.editor`.
1. Потоки данных используют {{ ydb-full-name }}. [Создайте](../../ydb/quickstart.md#serverless) бессерверную базу данных.

## Создайте поток данных {#create-datastream}

{% include [create-stream-tutorial](../../_includes/data-streams/create-stream-tutorial.md) %}

## Настройте генерацию данных {#configure-generation}

{% include [streaming-infra](../_includes/create-tutorial-streaming-infra.md) %}

Запустится генерация данных в поток `yellow-taxi`. Для управления генератором данных используйте кнопки **{{ ui-key.yql.yq-tutorial.stop-stream.button-label }}** и **{{ ui-key.yql.yq-tutorial.run-stream.button-label }}**.

## Выполните запрос {#run-query}

1. В редакторе запросов в интерфейсе {{ yq-name }} нажмите кнопку **{{ ui-key.yql.yq-ide-header.new-streaming-query.button-text }}**.
1. В текстовом поле введите текст запроса:

   ```sql
   $data = 
   SELECT 
       *
   FROM
       bindings.`tutorial-streaming` LIMIT 10;

   SELECT
       HOP_END() AS time,
       COUNT(*) AS ride_count,
       SUM(total_amount) AS total_amount
   FROM 
       $data
   GROUP BY 
       HOP(CAST(tpep_pickup_datetime AS Timestamp), "PT1M", "PT1M", "PT1M");
   ```

1. Нажмите кнопку **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.

## Исследуйте результат {#check-result}

После выполнения запроса станет доступен результат — общая стоимость `total_amount` первых 10 поездок, совершенных после запуска запроса.

| #  | time | ride_count | total_amount |
| --- | --- | --- | --- |
| 1  | 2022-11-28T16:05:00.000000Z | 10 | 5675.542679843059 |

## См. также {#see-also}

* [Оператор HOP. Параметры окон в потоковой обработке данных](../concepts/stream-processing-windows.md)
* [Агрегатные функции. Синтаксис YQL]({{ ydb.docs }}/yql/reference/builtins/aggregation)
* [Формат SQL-выражения](../sources-and-sinks/data-streams-binding.md#model-dannyh)
* [{#T}](../concepts/stream-processing.md)
