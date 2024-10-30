# Parallel copy

{{ data-transfer-name }} can simultaneously use multiple execution threads for a transfer. This significantly increases transfer throughput and allows using more resources for the transfer. Parallel copy is used for [all types of copy](transfer-lifecycle.md#copy) in _{{ dt-type-copy }}_ and _{{ dt-type-copy-repl }}_ transfers in the {{ dt-status-copy }} [status](transfer-lifecycle.md#statuses).

Scaling capabilities depend on the type of source database:

* The [{{ PG }}](../operations/endpoint/source/postgresql.md), [{{ MG }}](../operations/endpoint/source/mongodb.md), and [{{ GP }}](../operations/endpoint/source/greenplum.md) sources support table partitioning and parallel copy of data from a single table. For {{ PG }}, the primary key must be of the `serial` type.
* The [{{ OS }}](../operations/endpoint/source/opensearch.md) and [{{ ES }}](../operations/endpoint/source/elasticsearch.md) sources support parallel copy of data from a single index.
* [{{ CH }}](../operations/endpoint/source/clickhouse.md) sources support parallel partition-based copying. For this, a table must have multiple partitions. A single-partition table will be copied in a single thread. Parallel copying is only available for {{ CH }}-to-{{ CH }} transfers.
* The [{{ objstorage-full-name }}](../operations/endpoint/source/object-storage.md) source supports parallel copy of data from a single folder.

To enable parallel copy, specify its [settings](#settings). We recommend selecting parallel copy settings individually for each transfer.

## {{ GP }} parallel copy specifics {#special-gp}

The service connects to {{ GP }} cluster segments directly and transfers data from the selected table concurrently from all segments. Data consistency in each segment is ensured through [snapshot isolation]({{ pg-docs }}/transaction-iso.html#XACT-REPEATABLE-READ).

## Settings {#settings}

{% list tabs group=instructions %}

- Management console {#console}


  **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeRegularSnapshot.snapshot_settings.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.SnapshotSettings.parallel_settings.title }}**:

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.ParallelSnapshotSettings.workers_count.title }}**: Number of [workers](index.md#worker) to run concurrently to copy data. Each worker is run on a stand-alone VM with dedicated CPU and RAM resources and a dedicated network connection.

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.ParallelSnapshotSettings.threads_count.title }}**: Number of threads per worker. Each thread is run in a separate container on a worker's VM and copies a single table or its part (depending on the source type).

  The extent of transfer parallelism is determined by the number of workers multiplied by the number of threads within a worker.


{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
