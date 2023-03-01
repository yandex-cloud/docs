---
noIndex: true
---

# Асинхронная репликация данных из {{ metrika }} в {{ CH }} с помощью {{ data-transfer-full-name }}

С помощью сервиса {{ data-transfer-name }} вы можете перенести данные из счетчика [{{ metrika }}](https://metrika.yandex.ru/) в кластер {{ CH }}. Такой перенос обеспечивает полноту переносимых данных из {{ metrika }} и предоставляет возможности для:

* обработки данных средствами {{ CH }};
* стриминга из {{ CH }} в другие локации;
* визуализации с помощью [{{ datalens-full-name }}]({{ link-datalens-main }}) или других сервисов.

Чтобы перенести данные:

1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

1. [Выберите](https://yandex.ru/support/metrica/general/tag-id.html) счетчик {{ metrika }} или [создайте и установите](https://yandex.ru/support/metrica/general/creating-counter.html) новый счетчик.

1. [Создайте кластер-приемник {{ mch-name }}](../managed-clickhouse/operations/cluster-create.md) любой подходящей конфигурации.

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт](../data-transfer/operations/endpoint/index.md#create) для [источника `{{ metrika-endpoint }}`](../data-transfer/operations/endpoint/source/metrika.md).

    Хиты и визиты переносятся как отдельные таблицы.

1. [Создайте эндпоинт](../data-transfer/operations/endpoint/index.md#create) для приемника:

    * **Тип базы данных** — `{{ CH }}`.
    * **Параметры эндпоинта** → **Настройки подключения** — `Кластер {{ mch-name }}`.

        Выберите кластер-приемник из списка и укажите [настройки подключения](../data-transfer/operations/endpoint/target/clickhouse.md) к нему.

1. [Создайте трансфер](../data-transfer/operations/transfer.md#create) типа _{{ dt-type-repl }}_, использующий созданные эндпоинты.
1. [Активируйте](../data-transfer/operations/transfer.md#activate) его.

Трансфер не переносит исторические данные, только текущие. Если трансфер деактивировать и активировать снова:

1. Данные полученные счетчиком {{ metrika }}, пока трансфер был деактивирован, перенесены не будут.
2. В соответствии с политикой очистки, выбранной в эндпоинте-приемнике, существующие таблицы с данными будут:

    * **Drop** — удалены вместе с данными и созданы заново с теми же именами.
    * **Truncate** — очищены от существующих данных, но сами таблицы и их схемы останутся.
    * **Не очищать** — использоваться для дальнейшей записи данных.

## Проверьте работоспособность трансфера {#verify-transfer}

1. Дождитесь перехода трансфера в статус {{ dt-status-repl }}.

1. Убедитесь, что в базу данных {{ mch-name }} перенеслись данные из счетчика {{ metrika }}:

    1. [Подключитесь к кластеру](../managed-clickhouse/operations/connect.md) с помощью `clickhouse-client`.

    1. Проверьте, что в базе данных появились таблицы хитов и визитов:

        ```sql
        SELECT table FROM system.tables
        WHERE database = '<имя базы данных {{ CH }}>'
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
        SELECT * FROM <имя таблицы хитов или визитов>
        ```

## Удалите созданные ресурсы {#clear-out}

{% include [note before delete resources](../_includes/mdb/note-before-delete-resources.md) %}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, во избежание списания средств за них:

1. [Удалите трансфер](../data-transfer/operations/transfer.md#delete-transfer).
1. [Удалите эндпоинты](../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.
1. [Удалите кластер {{ mch-name }}](../managed-clickhouse/operations/cluster-delete.md).
1. Удалите счетчик {{ metrika }}.
