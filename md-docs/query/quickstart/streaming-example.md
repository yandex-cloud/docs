# Потоковая обработка данных из {{ yds-full-name }}

В этом примере вы выполните [потоковую обработку данных](../concepts/stream-processing.md) о поездках Нью-Йоркского такси. Данные для примера будут записаны с помощью генератора в специально созданный поток [{{ yds-full-name }}](../../data-streams/index.md).

В результате вы получите общую стоимость первых 10 поездок после начала обработки потоковых данных.

Для выполнения примера:

1. [Подготовьтесь к работе](#before-you-begin).
1. [Создайте поток данных](#create-datastream).
1. [Настройте генерацию данных](#configure-generation).
1. [Выполните запрос](#run-query).
1. [Исследуйте результат](#check-result).

{% note info %}

{{ yandex-cloud }} предоставляет набор данных - **поездки Нью-Йоркского такси** - на условиях “как есть” (as is). {{ yandex-cloud }} не дает никаких заверений, явных или подразумеваемых, гарантий или условий в отношении использования вами указанного датасета (набора данных). В пределах, разрешенных вашим местным законодательством, {{ yandex-cloud }} не несет никакой ответственности за любые убытки или ущерб, включая прямые, побочные, специальные, косвенные, случайные или штрафные, возникшие в результате использования вами датасета.

NYC Taxi and Limousine Commission (TLC):

Данные были собраны и предоставлены NYC Taxi and Limousine Commission (TLC) поставщиками технологий, уполномоченными в рамках Taxicab & Livery Passenger Enhancement Programs (TPEP/LPEP). Данные о поездке не были созданы TLC, и TLC не делает никаких заявлений относительно точности этих данных.

Ознакомьтесь с [источником](https://www1.nyc.gov/site/tlc/about/tlc-trip-record-data.page) датасета и [правилами](https://www1.nyc.gov/home/terms-of-use.page) его использования.

{% endnote %}

## Подготовьтесь к работе {#before-you-begin}

1. Войдите в [консоль управления]({{ link-console-main }}) или зарегистрируйтесь. Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. На странице [**{{ ui-key.yacloud_billing.billing.label_service }}**]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../../resource-manager/operations/folder/create.md).
1. Подключение к потоку данных будет выполняться от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md). [Создайте](../../iam/operations/sa/create.md#create-sa) сервисный аккаунт с именем `datastream-connection-account` и ролью `ydb.editor`.
1. Потоки данных используют {{ ydb-full-name }}. [Создайте](../../ydb/quickstart.md#serverless) бессерверную базу данных.

## Создайте поток данных {#create-datastream}

1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать [поток данных](../../data-streams/concepts/glossary.md).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.data-streams.button_create-stream }}**.
  1. Укажите базу данных {{ ydb-full-name }}, созданную ранее.
  1. Введите имя потока данных: `yellow-taxi`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

## Настройте генерацию данных {#configure-generation}

1. Создайте соединение:

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать соединение.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
    1. На панели слева выберите ![study](../../_assets/console-icons/graduation-cap.svg) **{{ ui-key.yql.yq-navigation.tutorial.menu-text }}**.
    1. Перейдите в **{{ ui-key.yql.yq-tutorial.tutorial-type-toggle.option-streaming }}** раздел.
    1. В блоке **{{ ui-key.yql.yq-tutorial.create-tutorial-infrastructure.label }}** нажмите кнопку **{{ ui-key.yql.yq-tutorial.create-connection.button-label }}**.
    1. В открывшемся окне в блоке **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}** выберите базу данных и сервисный аккаунт, созданные ранее.
    1. Нажмите кнопку **{{ ui-key.yql.yq-binding-form.binding-create.button-text }}**.

1. Создайте [привязку к данным](../concepts/glossary.md):

    1. Откроется страница для создания привязки к данным.
    1. В блоке **{{ ui-key.yql.yq-binding-form.binding-parameters.title }}** выберите поток `yellow-taxi`, созданный ранее.
    1. Нажмите кнопку **{{ ui-key.yql.yq-binding-form.binding-create.button-text }}**.

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