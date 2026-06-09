# Потоковая обработка данных из Yandex Data Streams

В этом примере вы выполните [потоковую обработку данных](../concepts/stream-processing.md) о поездках Нью-Йоркского такси. Данные для примера будут записаны с помощью генератора в специально созданный поток [Yandex Data Streams](../../data-streams/index.md).

В результате вы получите общую стоимость первых 10 поездок после начала обработки потоковых данных.

Для выполнения примера:

1. [Подготовьтесь к работе](#before-you-begin).
1. [Создайте поток данных](#create-datastream).
1. [Настройте генерацию данных](#configure-generation).
1. [Выполните запрос](#run-query).
1. [Исследуйте результат](#check-result).

{% note info %}

Yandex Cloud предоставляет набор данных - **поездки Нью-Йоркского такси** - на условиях “как есть” (as is). Yandex Cloud не дает никаких заверений, явных или подразумеваемых, гарантий или условий в отношении использования вами указанного датасета (набора данных). В пределах, разрешенных вашим местным законодательством, Yandex Cloud не несет никакой ответственности за любые убытки или ущерб, включая прямые, побочные, специальные, косвенные, случайные или штрафные, возникшие в результате использования вами датасета.

NYC Taxi and Limousine Commission (TLC):

Данные были собраны и предоставлены NYC Taxi and Limousine Commission (TLC) поставщиками технологий, уполномоченными в рамках Taxicab & Livery Passenger Enhancement Programs (TPEP/LPEP). Данные о поездке не были созданы TLC, и TLC не делает никаких заявлений относительно точности этих данных.

Ознакомьтесь с [источником](https://www1.nyc.gov/site/tlc/about/tlc-trip-record-data.page) датасета и [правилами](https://www1.nyc.gov/home/terms-of-use.page) его использования.

{% endnote %}

## Подготовьтесь к работе {#before-you-begin}

1. Войдите в [консоль управления](https://console.yandex.cloud) или зарегистрируйтесь. Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. На странице [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../../resource-manager/operations/folder/create.md).
1. Подключение к потоку данных будет выполняться от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md). [Создайте](../../iam/operations/sa/create.md#create-sa) сервисный аккаунт с именем `datastream-connection-account` и ролью `ydb.editor`.
1. Потоки данных используют Yandex Managed Service for YDB. [Создайте](../../ydb/quickstart.md#serverless) бессерверную базу данных.

## Создайте поток данных {#create-datastream}

1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать [поток данных](../../data-streams/concepts/glossary.md).
  1. Перейдите в сервис **Data Streams**.
  1. Нажмите кнопку **Создать поток**.
  1. Укажите базу данных Yandex Managed Service for YDB, созданную ранее.
  1. Введите имя потока данных: `yellow-taxi`.
  1. Нажмите кнопку **Создать**.

## Настройте генерацию данных {#configure-generation}

1. Создайте соединение:

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно создать соединение.
    1. Перейдите в сервис **Yandex Query**.
    1. На панели слева выберите ![study](../../_assets/console-icons/graduation-cap.svg) **Учебник**.
    1. Перейдите в **Потоковый** раздел.
    1. В блоке **Создать инфраструктуру для обучения** нажмите кнопку **Создать соединение**.
    1. В открывшемся окне в блоке **Параметры типа соединения** выберите базу данных и сервисный аккаунт, созданные ранее.
    1. Нажмите кнопку **Создать**.

1. Создайте [привязку к данным](../concepts/glossary.md):

    1. Откроется страница для создания привязки к данным.
    1. В блоке **Параметры привязки к данным** выберите поток `yellow-taxi`, созданный ранее.
    1. Нажмите кнопку **Создать**.

Запустится генерация данных в поток `yellow-taxi`. Для управления генератором данных используйте кнопки **Стоп** и **Старт**.

## Выполните запрос {#run-query}

1. В редакторе запросов в интерфейсе Query нажмите кнопку **Новый потоковый запрос**.
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

1. Нажмите кнопку **Выполнить**.

## Исследуйте результат {#check-result}

После выполнения запроса станет доступен результат — общая стоимость `total_amount` первых 10 поездок, совершенных после запуска запроса.

| #  | time | ride_count | total_amount |
| --- | --- | --- | --- |
| 1  | 2022-11-28T16:05:00.000000Z | 10 | 5675.542679843059 |

## См. также {#see-also}

* [Оператор HOP. Параметры окон в потоковой обработке данных](../concepts/stream-processing-windows.md)
* [Агрегатные функции. Синтаксис YQL](https://ydb.tech/docs/ru//yql/reference/builtins/aggregation)
* [Формат SQL-выражения](../sources-and-sinks/data-streams-binding.md#model-dannyh)
* [Потоковый анализ данных](../concepts/stream-processing.md)