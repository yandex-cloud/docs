# Миграция данных с использованием сервиса {{ data-transfer-full-name }} {#data-transfer}

1. [Подготовьте кластер-источник](../../data-transfer/operations/prepare.md#source-mg).
1. [Подготовьте кластер-приемник](../../data-transfer/operations/prepare.md#target-mg).
1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/index.md#create) со следующими параметрами:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `{{ ui-key.yacloud.data-transfer.label_endpoint-type-MONGO_V2 }}`.
    * **{{ ui-key.yacloud.data-transfer.forms.section-endpoint }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoSource.connection.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.on_premise.title }}`.

        Укажите параметры подключения к кластеру-источнику.

    {% note info %}

    Так как сервис не поддерживает перенос [коллекций Time Series]({{ mg.docs.comd }}/core/timeseries-collections/), необходимо [исключить](../../data-transfer/operations/endpoint/source/mongodb.md#additional-settings) такие коллекции в настройках эндпоинта.

    {% endnote %}

1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/index.md#create) со следующими параметрами:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `{{ ui-key.yacloud.data-transfer.label_endpoint-type-MONGO_V2 }}`.
    * **{{ ui-key.yacloud.data-transfer.forms.section-endpoint }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoTarget.connection.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.mdb_cluster_id.title }}`.

        Укажите идентификатор кластера-приемника.

1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа _{{ dt-type-copy-repl }}_, использующий созданные эндпоинты.

   Чтобы ускорить копирование больших коллекций (более 1 ГБ), включите [параллельное копирование](../../data-transfer/concepts/sharded.md) в настройках трансфера. Укажите два воркера или больше. Коллекция разделится на указанное количество частей, которые будут копироваться параллельно.

   Чтобы параллельное копирование работало, [тип данных](https://www.mongodb.com/docs/manual/reference/bson-types) поля `_id` у всех документов коллекции должен быть одинаковым. Если трансфер обнаруживает неоднородность типов, то коллекция не разбивается на части и переносится в одном потоке. При необходимости перед началом трансфера удалите из коллекции документы с отличающимися типами данных.

   {% note info %}

   Если после активации трансфера в коллекцию добавится документ с отличающимся типом данных, трансфер перенесет его на стадии репликации, после параллельного копирования. Но при повторной активации трансфер не сможет разбить коллекцию на части, так как требование к типу поля `_id` во всех документах коллекции не будет выполнено.

   {% endnote %}

1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate).
1. Дождитесь перехода трансфера в статус {{ dt-status-repl }}.
1. Переведите кластер-источник в режим <q>только чтение</q> и переключите нагрузку на кластер-приемник.
1. На странице [мониторинга трансфера](../../data-transfer/operations/monitoring.md) дождитесь снижения до нуля характеристики **Maximum lag on delivery**. Это значит, что на кластер-приемник перенесены все изменения, произошедшие в кластере-источнике после завершения копирования данных.
1. [Деактивируйте](../../data-transfer/operations/transfer.md#deactivate) трансфер и дождитесь его перехода в статус {{ dt-status-stopped }}.

    Подробнее о статусах трансфера см. в разделе [Жизненный цикл трансфера](../../data-transfer/concepts/transfer-lifecycle.md#statuses).

1. [Удалите остановленный трансфер](../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.
