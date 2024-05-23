---
noIndex: true
---

# Загрузка данных из {{ metrika }} в витрину {{ CH }} с помощью {{ data-transfer-full-name }}


{% include [note-metrica-pro](../../_includes/data-transfer/note-metrica-pro.md) %}

С помощью сервиса {{ data-transfer-name }} вы можете перенести данные из счетчика [{{ metrika }}]({{ metrika-link }}) в кластер {{ CH }}. Такой перенос обеспечивает полноту переносимых данных из {{ metrika }} и предоставляет возможности для:

* обработки данных средствами {{ CH }};
* стриминга из {{ CH }} в другие локации;
* визуализации с помощью [{{ datalens-full-name }}]({{ link-datalens-main }}) или других сервисов.

Чтобы перенести данные:

1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

1. [Выберите]({{ link-yandex }}/support/metrica/general/tag-id.html) счетчик {{ metrika }} или [создайте и установите]({{ link-yandex }}/support/metrica/general/creating-counter.html) новый счетчик.

1. [Создайте кластер-приемник {{ mch-name }}](../../managed-clickhouse/operations/cluster-create.md) любой подходящей конфигурации.

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт](../../data-transfer/operations/endpoint/index.md#create) для [источника `{{ metrika-endpoint }}`](../../data-transfer/operations/endpoint/source/metrika.md).

    Хиты и визиты переносятся как отдельные таблицы.

1. [Создайте эндпоинт](../../data-transfer/operations/endpoint/index.md#create) для приемника:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `ClickHouse`.
    * **Параметры эндпоинта** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseManaged.mdb_cluster_id.title }}`.

        Выберите кластер-приемник из списка и укажите [настройки подключения](../../data-transfer/operations/endpoint/target/clickhouse.md) к нему.

1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}_**, использующий созданные эндпоинты.
1. [Активируйте](../../data-transfer/operations/transfer.md#activate) его.

Трансфер не переносит исторические данные, только текущие. Если трансфер деактивировать и активировать снова:

1. Данные полученные счетчиком {{ metrika }}, пока трансфер был деактивирован, перенесены не будут.
2. В соответствии с политикой очистки, выбранной в эндпоинте-приемнике, существующие таблицы с данными будут:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}** — удалены вместе с данными и созданы заново с теми же именами.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}** — очищены от существующих данных, но сами таблицы и их схемы останутся.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}** — использоваться для дальнейшей записи данных.

## Проверьте работоспособность трансфера {#verify-transfer}

1. Дождитесь перехода трансфера в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

1. Убедитесь, что в базу данных {{ mch-name }} перенеслись данные из счетчика {{ metrika }}:

    1. [Подключитесь к кластеру](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) с помощью `clickhouse-client`.

    1. Проверьте, что в базе данных появились таблицы хитов и визитов:

        ```sql
        SELECT table FROM system.tables
        WHERE database = '<имя_базы_данных_{{ CH }}>'
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

{% include [note before delete resources](../../_includes/mdb/note-before-delete-resources.md) %}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete-transfer).
1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.
1. [Удалите кластер {{ mch-name }}](../../managed-clickhouse/operations/cluster-delete.md).
1. Удалите счетчик {{ metrika }} из личного кабинета [Метрики Про]({{ link-yandex }}/support/metrica/pro/intro.html).
