# Parallel copy

{{ data-transfer-name }} can simultaneously use multiple execution threads for a transfer. This significantly increases transfer throughput and allows using more resources for the transfer. Parallel copy is used for [all types of copy](transfer-lifecycle.md#copy) in _{{ dt-type-copy }}_ and _{{ dt-type-copy-repl }}_ transfers in the {{ dt-status-copy }} [status](transfer-lifecycle.md#statuses).

To enable parallel copy, specify its [settings](#settings). We recommend selecting parallel copy settings individually for each transfer.

## Sources that support parallel copying of one table {#source-databases}

Scaling capabilities depend on the type of source database:

* The [{{ PG }}](../operations/endpoint/source/postgresql.md), [{{ MG }}](../operations/endpoint/source/mongodb.md), and [{{ GP }}](../operations/endpoint/source/greenplum.md) sources support table partitioning and parallel copy of data from a single table. For {{ PG }}, the primary key must be of the `serial` type.
* The [{{ OS }}](../operations/endpoint/source/opensearch.md) and [{{ ES }}](../operations/endpoint/source/elasticsearch.md) sources support parallel copy of data from a single index.
* [{{ CH }}](../operations/endpoint/source/clickhouse.md) sources support parallel partition-based copying. For this, a table must have multiple partitions. A single-partition table will be copied in a single thread. Parallel copying is only available for {{ CH }}-to-{{ CH }} transfers.
* The [{{ objstorage-full-name }}](../operations/endpoint/source/object-storage.md) source supports parallel copy of data from a single folder.

Other sources support parallel copying of multiple tables at the same time (without parallelization within a single table).

## {{ GP }} parallel copy specifics {#special-gp}

The service connects to {{ GP }} cluster segments directly and transfers data from the selected table concurrently from all segments. Data consistency in each segment is ensured through [snapshot isolation]({{ pg-docs }}/transaction-iso.html#XACT-REPEATABLE-READ).

## Settings {#settings}

{% list tabs group=instructions %}

- Management console {#console}


  **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeRegularSnapshot.snapshot_settings.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.SnapshotSettings.parallel_settings.title }}**:

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.ParallelSnapshotSettings.workers_count.title }}**: Number of [workers](index.md#worker) to run concurrently to copy data. Each worker is run on a stand-alone VM with dedicated CPU and RAM resources and a dedicated network connection.

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.ParallelSnapshotSettings.threads_count.title }}**: Number of threads per worker. Each thread is run in a separate container on a worker's VM and copies a single table or its part (depending on the source type).

  For more information on setting up workers and threads, see the [relevant recommendations](#recommendations).


{% endlist %}

## Recommendations for parallel copying {#recommendations}

Make sure you have parallel copy [settings](#settings) for your transfer.

Parallel copying helps speed up data transfer only if the transfer speed is sufficient. It depends on the following factors:

* Read speed from the source database.
* Data processing speed by {{ data-transfer-name }}.
* Speed of inserting data into the target database.

To check the transfer speed, look at the [{{ monitoring-full-name }}](../../monitoring/) charts. The speed is considered sufficient if the following conditions are met:

* In the source cluster and target cluster charts, the consumption of resources, such as CPU, RAM, or disk space, is not nearing the limit values.

* The _Target response time [s]_ transfer chart shows that 95% of records are completed in less than 1 second.

    For the {{ CH }} target, the data reception rate is controlled by the **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTargetAdvancedSettings.flush_interval.title }}** target endpoint setting. The value may exceed 1 second. In which case the _Target response time [s]_ transfer chart must show that 95% of records are completed faster than the time specified in **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTargetAdvancedSettings.flush_interval.title }}**.

When doing parallel copying, you choose the number of workers and the number of threads per worker. The higher these values, the greater the transfer performance, the number of network connections, and the transfer load on source and target. These metrics increase in proportion to the number of workers multiplied by the number of threads within a worker.

To achieve optimal performance and load, test the transfer under different parallel copying settings. Use 2 workers and 4 threads per worker as initial values. These accelerate copying about 8-fold. Proceed to monitor the transfer and follow these recommendations:

* If the copying speed is insufficient while both source and target have free resources, increase the number of workers. You can check the copying speed on the _Target response time [s]_ transfer chart; to look up free resource, refer to the cluster resource consumption charts.

* If you see an unacceptably high load on either source or target, stop the copying, reduce the number of workers, and restart the transfer. You can check the load on the cluster resource consumption charts.

* If the target write time has increased significantly, stop the copying, reduce the number of workers and restart the transfer. You can check the write speed on the _Target response time [s]_ transfer chart.

* If you get the `Instance was restarted` error, reduce the number of threads per worker and restart the transfer.

If you have any setup issues, contact [support]({{ link-console-support }}).

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
