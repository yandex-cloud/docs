# Миграция кластера {{ MG }}


Чтобы перенести вашу базу данных {{ MG }} в сервис {{ mmg-name }} (Managed Service for MongoDB), нужно непосредственно перенести данные, закрыть старую базу данных на запись и переключить нагрузку на кластер БД в {{ yandex-cloud }}.

Миграция с помощью {{ data-transfer-name }} позволяет:

* перенести базу без остановки обслуживания пользователей;
* мигрировать со старых версий {{ MG }} на более новые;
* обойтись без создания промежуточной [виртуальной машины](../../glossary/vm.md) или разрешения доступа к вашему кластеру-приемнику {{ mmg-name }} из интернета.

Подробнее см. в разделе [{#T}](../concepts/use-cases.md).

Чтобы использовать этот способ миграции, разрешите подключение к кластеру-источнику из интернета.


## Необходимые платные ресурсы {#paid-resources}

* Кластер {{ SD }}: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы {{ SD }}](../../storedoc/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md)).
* Каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных (см. [тарифы {{ data-transfer-name }}](../pricing.md)).


## Перед началом работы {#before-you-begin}

[Создайте кластер-приемник {{ mmg-name }} (Managed Service for MongoDB)](../../storedoc/operations/cluster-create.md), вычислительная мощность и размер хранилища которого соответствуют среде, в которой развернута мигрируемая база данных.

Имя базы в кластере-приемнике должно совпадать с именем базы-источника.

## Перенос данных {#data-transfer}

# Миграция данных с использованием сервиса {{ data-transfer-full-name }} {#data-transfer}

1. [Подготовьте кластер-источник](../operations/prepare.md#source-mg).
1. [Подготовьте кластер-приемник](../operations/prepare.md#target-mg).
1. [Создайте эндпоинт для источника](../operations/endpoint/index.md#create) со следующими параметрами:
   
   * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `MongoDB`.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoSource.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoSource.connection.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.on_premise.title }}`.
   
       Укажите параметры подключения к кластеру-источнику.
   
   {% note info %}
   
   Так как сервис не поддерживает перенос коллекций `Time Series`, необходимо [исключить](../operations/endpoint/source/mongodb.md#additional-settings) такие коллекции в настройках эндпоинта.
   
   {% endnote %}
1. [Создайте эндпоинт для приемника](../operations/endpoint/index.md#create) со следующими параметрами:
   
   * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `MongoDB`.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoTarget.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoTarget.connection.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.mdb_cluster_id.title }}`.
   
       Укажите идентификатор кластера-приемника.
1. [Создайте трансфер](../operations/transfer.md#create) типа _{{ dt-type-copy-repl }}_, использующий созданные эндпоинты.
   
   Чтобы ускорить копирование больших коллекций (более 1 ГБ), включите [параллельное копирование](../concepts/sharded.md) в настройках трансфера. Укажите два [воркера](../concepts/index.md#worker) или больше. Коллекция разделится на указанное количество частей, которые будут копироваться параллельно.
   
   Чтобы параллельное копирование работало, поля `_id` во всех документах коллекции должны иметь одинаковый тип данных. Если трансфер обнаруживает неоднородность типов, то коллекция не разбивается на части и переносится в одном потоке. При необходимости удалите из коллекции документы с отличающимися типами данных перед началом трансфера.
   
   {% note info %}
   
   Если после активации трансфера в коллекцию добавится документ с отличающимся типом данных, трансфер перенесет его на стадии репликации после параллельного копирования. Однако при повторной активации трансфер не сможет разбить коллекцию на части, так как требование к одинаковому типу поля `_id` во всех документах коллекции не будет выполнено.
   
   {% endnote %}
1. [Активируйте трансфер](../operations/transfer.md#activate).
1. Дождитесь перехода трансфера в статус {{ dt-status-repl }}.
1. Переведите кластер-источник в режим <q>только чтение</q> и переключите нагрузку на кластер-приемник.
1. На странице [мониторинга трансфера](../operations/monitoring.md) дождитесь снижения до нуля характеристики **Maximum data transfer delay**. Это значит, что на кластер-приемник перенесены все изменения, произошедшие в кластере-источнике после завершения копирования данных.
1. [Деактивируйте](../operations/transfer.md#deactivate) трансфер и дождитесь его перехода в статус {{ dt-status-stopped }}.

    Подробнее о статусах трансфера см. в разделе [Жизненный цикл трансфера](../concepts/transfer-lifecycle.md#statuses).

1. [Удалите остановленный трансфер](../operations/transfer.md#delete).
1. [Удалите эндпоинты](../operations/endpoint/index.md#delete) для источника и приемника.

## См. также {#see-also}

Другие способы миграции описаны в [документации {{ mmg-name }} (Managed Service for MongoDB)](../../storedoc/tutorials/data-migration.md).