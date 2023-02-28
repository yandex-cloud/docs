# Sharded copy

{{ data-transfer-name }} can use more than a single execution thread for a transfer. The sharded copy functionality helps significantly increase transfer throughput by using more resources for the transfer.

Scaling capabilities are limited by the nature of the source database and the data being transferred. Some sources do not support sharded copy. The algorithm for distributing data across several execution threads (sharding algorithm) depends on the source. That is why we recommend selecting sharding settings individually for each transfer.

## Settings {#settings}

By default, sharded copy is disabled. To enable sharded copy, you need to specify proper transfer settings.

{% list tabs %}

- Management console


  * **Runtime environment**

    * **Number of workers**: Number of workers to run in parallel for replicating data on standalone VM instances. Each virtual machine has dedicated CPU and RAM resources and a dedicated network connection.

    * **Number of threads**: Number of threads to run per worker. One thread copies one table or its part. The extent of transfer parallelism is determined by the number of workers multiplied by the number of threads within a worker.


{% endlist %}
