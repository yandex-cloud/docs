# Parallel copy

{{ data-transfer-name }} can use more than a single execution thread for a transfer. The parallel copy functionality helps significantly increase transfer throughput by using more resources for the transfer.

Scaling capabilities are limited by the nature of the source database and the data being transferred. Some sources do not support parallel copy. The algorithm for distributing data across several execution threads depends on the source. That is why we recommend selecting parallel copy settings individually for each transfer.

## Settings {#settings}

Parallel copy is disabled by default. To enable parallel copy, specify the proper transfer settings.

{% list tabs %}

- Management console


  **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeRegularSnapshot.snapshot_settings.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.SnapshotSettings.parallel_settings.title }}**:

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.ParallelSnapshotSettings.workers_count.title }}**: Number of workers to run in parallel for replicating data on standalone VM instances. Each virtual machine has dedicated CPU and RAM resources and a dedicated network connection.

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.ParallelSnapshotSettings.threads_count.title }}**: Number of threads to run per worker. One thread copies one table or its part. The extent of transfer parallelism is determined by the number of workers multiplied by the number of threads within a worker.


{% endlist %}
