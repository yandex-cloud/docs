# Пример анализа потоковых данных

{{ yq-full-name }} может выполнять [потоковую обработку](../concepts/stream-processing.md) данных на SQL-подобном языке — [YQL]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/){% endif %}.

В этом примере будем использовать заранее подготовленный набор данных о поездках Нью-Йоркского такси. В результате рассчитаем число и общую стоимость первых поездок. Для этого создадим [поток данных](../../data-streams/concepts/glossary.md) и запишем в него данные с помощью генератора. Затем выполним YQL-запрос для получения числа поездок и их стоимости.

Для выполнения примера:

1. [Подготовьтесь к работе](#before-you-begin).
1. [Создайте поток данных](#create-datastream).
1. [Настройте генерацию данных](#configure-generation).
1. [Выполните запрос](#run-query).
1. [Исследуйте результат](#check-result).

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

## Создайте поток данных {#create-datastream}

{% include [create-stream-tutorial](../../_includes/data-streams/create-stream-tutorial.md) %}

## Настройте генерацию данных {#configure-generation}

{% include [streaming-infra](../_includes/create-tutorial-streaming-infra.md) %}

Запустится генерация данных в поток `yellow-taxi`. Для управления генератором данных используйте кнопки **Стоп** и **Старт**.


## Выполните запрос {#run-query}

1. В редакторе запросов в интерфейсе {{ yq-full-name }} нажмите кнопку **Новый потоковый запрос**.
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
       HOP(CAST(tpep_pickup_datetime as Timestamp), "PT1M", "PT1M", "PT1M");
   ```

1. Нажмите кнопку **Выполнить**.

## Исследуйте результат {#check-result}

После выполнения запроса станет доступен результат: количество и общая стоимость первых поездок, совершенных после запуска запроса.

| #  | time | ride_count | total_amount |
| --- | --- | --- | --- |
| 1  | 2022-11-28T16:05:00.000000Z | 10 | 5675.542679843059 |

#### См. также {#see-also}

* [Оператор HOP. Параметры окон в потоковой обработке данных](../concepts/stream-processing-windows.md)
* [Агрегатные функции. Синтаксис YQL]({{ ydb.docs }}/yql/reference/builtins/aggregation)
* [Формат SQL-выражения](../sources-and-sinks/data-streams-binding.md#model-dannyh)
* [{#T}](../concepts/stream-processing.md)
