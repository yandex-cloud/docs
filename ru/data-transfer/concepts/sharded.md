# Параллельное копирование

Сервис {{ data-transfer-name }} может одновременно задействовать для трансфера несколько потоков исполнения. Это существенно увеличивает пропускную способность трансфера и позволяет использовать для него больший объем ресурсов. Параллельное копирование применяется для [всех видов копирования](transfer-lifecycle.md#copy) в трансферах типа _{{ dt-type-copy }}_ и _{{ dt-type-copy-repl }}_, находящихся в [статусе](transfer-lifecycle.md#statuses) {{ dt-status-copy }}.

Возможности масштабирования зависят от типа базы-источника:

* Источники [{{ PG }}](../operations/endpoint/source/postgresql.md), [{{ MG }}](../operations/endpoint/source/mongodb.md) и [{{ GP }}](../operations/endpoint/source/greenplum.md) поддерживают разделение таблиц на части и параллельное копирование данных из одной таблицы. Для {{ PG }} первичный ключ должен быть типа `serial`.
* Источники [{{ OS }}](../operations/endpoint/source/opensearch.md) и [{{ ES }}](../operations/endpoint/source/elasticsearch.md) поддерживают параллельное копирование данных из одного индекса.
* Источники [{{ CH }}](../operations/endpoint/source/clickhouse.md) поддерживают параллельное копирование по партициям. Для этого таблица должна иметь несколько партиций. Таблица из одной партиции будет скопирована в один поток. Параллельное копирование доступно только для трансферов из {{ CH }} в {{ CH }}.
* Источник [{{ objstorage-full-name }}](../operations/endpoint/source/object-storage.md) поддерживает параллельное копирование данных из одного каталога.

Чтобы включить параллельное копирование, укажите его [настройки](#settings). Настройки параллельного копирования рекомендуется подбирать для каждого трансфера отдельно.

## Особенности параллельного копирования {{ GP }} {#special-gp}

Сервис подключается напрямую к сегментам кластера {{ GP }} и переносит данные из выбранной таблицы параллельно из всех сегментов. Консистентность данных в каждом сегменте обеспечивается механизмом [Snapshot isolation]({{ pg-docs }}/transaction-iso.html#XACT-REPEATABLE-READ).

## Настройки {#settings}

{% list tabs group=instructions %}

- Консоль управления {#console}


  **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeRegularSnapshot.snapshot_settings.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.SnapshotSettings.parallel_settings.title }}**:

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.ParallelSnapshotSettings.workers_count.title }}** — количество [воркеров](index.md#worker), которые будут параллельно запущены для копирования данных. Каждый воркер запускается на независимой виртуальной машине с собственными ресурсами CPU и RAM и собственным сетевым подключением.

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.ParallelSnapshotSettings.threads_count.title }}** — количество потоков, которое будет запущено в каждом воркере. Каждый поток запускается в отдельном контейнере на виртуальной машине воркера и копирует одну таблицу или ее часть (в зависимости от типа источника).

  Степень распараллеливания трансфера определяется произведением количества воркеров на количество потоков внутри воркера.


{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
