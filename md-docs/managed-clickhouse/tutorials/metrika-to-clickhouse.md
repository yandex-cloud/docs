# Загрузка данных из Яндекс Метрика в витрину ClickHouse®

# Загрузка данных из Яндекс Метрика в витрину ClickHouse® с помощью Yandex Data Transfer


{% note info %}

Передача данных из источника Яндекс Метрика возможна при подключении пакета [Метрика Про](https://yandex.ru/support/metrica/pro/intro.html) или использовании [Data Streaming из Яндекс Метрики](https://yandex.cloud/ru/marketplace/products/varioqub/metrica-data-streaming).

{% endnote %}

С помощью сервиса Data Transfer вы можете перенести данные из счетчика [Яндекс Метрика](https://metrika.yandex.ru/) в кластер ClickHouse®. Такой перенос обеспечивает полноту переносимых данных из Яндекс Метрика и предоставляет возможности для:

* обработки данных средствами ClickHouse®;
* стриминга из ClickHouse® в другие локации;
* визуализации с помощью [Yandex DataLens](https://datalens.ru/promo) или других сервисов.

Чтобы перенести данные:

1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for ClickHouse®: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий ([тарифы Managed Service for ClickHouse®](../pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Virtual Private Cloud](../../vpc/pricing.md)).
* Пакет [Метрика Про](https://yandex.ru/support/metrica/pro/price.html).


## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

1. [Выберите](https://yandex.ru/support/metrica/general/tag-id.html) счетчик Яндекс Метрика или [создайте и установите](https://yandex.ru/support/metrica/general/creating-counter.html) новый счетчик.

1. [Создайте кластер-приемник Managed Service for ClickHouse®](../operations/cluster-create.md) любой подходящей конфигурации.

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт](../../data-transfer/operations/endpoint/index.md#create) для [источника `Metrica`](../../data-transfer/operations/endpoint/source/metrika.md).

    Хиты и визиты переносятся как отдельные таблицы.

1. [Создайте эндпоинт](../../data-transfer/operations/endpoint/index.md#create) для приемника:

    * **Тип базы данных** — `ClickHouse`.
    * **Параметры эндпоинта** → **Тип подключения** — `Managed кластер`.

        Выберите кластер-приемник из списка и укажите [настройки подключения](../../data-transfer/operations/endpoint/target/clickhouse.md) к нему.

1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_Репликация_**, использующий созданные эндпоинты.
1. [Активируйте](../../data-transfer/operations/transfer.md#activate) его.

Трансфер не переносит исторические данные, только текущие. Если трансфер деактивировать и активировать снова:

1. Данные полученные счетчиком Яндекс Метрика, пока трансфер был деактивирован, перенесены не будут.
1. В соответствии с политикой очистки, выбранной в эндпоинте-приемнике, существующие таблицы с данными будут:

    * **Drop** — удалены вместе с данными и созданы заново с теми же именами.
    * **Truncate** — очищены от существующих данных, но сами таблицы и их схемы останутся.
    * **Не очищать** — использоваться для дальнейшей записи данных.

## Проверьте работоспособность трансфера {#verify-transfer}

1. Дождитесь перехода трансфера в статус **Реплицируется**.

1. Убедитесь, что в базу данных Managed Service for ClickHouse® перенеслись данные из счетчика Яндекс Метрика:

    1. [Подключитесь к кластеру](../operations/connect/clients.md#clickhouse-client) с помощью `clickhouse-client`.

    1. Проверьте, что в базе данных появились таблицы хитов и визитов:

        ```sql
        SELECT table FROM system.tables
        WHERE database = '<имя_базы_данных_ClickHouse®>'
        ```

        Результат:

        ```text
        ┌─table───────────────────────┐
        │ hits_dt...                  │
        │ visits_dt...                │
        └─────────────────────────────┘
        ```

    1. Проверьте, что таблицы хитов и визитов содержат данные из счетчика:

        ```sql
        SELECT * FROM <имя_таблицы_хитов_или_визитов>
        ```

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete-transfer).
1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.
1. [Удалите кластер Managed Service for ClickHouse®](../operations/cluster-delete.md).
1. Удалите счетчик Яндекс Метрика из личного кабинета [Метрики Про](https://yandex.ru/support/metrica/pro/intro.html).

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._