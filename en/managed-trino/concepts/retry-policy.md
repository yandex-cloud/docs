# Fault-tolerant query execution in a {{ mtr-name }} cluster

{{ mtr-name }} clusters support the [fault-tolerant execution](https://trino.io/docs/current/admin/fault-tolerant-execution.html) mechanism. By default, when resources are insufficient or a query fails with an error, the [worker](index.md#workers) will stop processing the query and you will need to run it again manually. With fault-tolerant execution enabled, the query or its component task will be retried in the event of failure.

To ensure fault-tolerant query execution when `Fault tolerant execution` is enabled, Exchange Manager regularly exports intermediate results to an {{ objstorage-name }} service bucket. If a query fails, the [coordinator](index.md#coordinator) will assign the retry to another worker, which can use the previously processed data.

{% note info %}

Fault-tolerant execution does not apply to incorrect or misspelled queries.

{% endnote %}

Fault-tolerant execution is only supported for the following [connectors](index.md#connector):

{% include [connectors](../../_includes/managed-trino/retry-policy-connector-list.md) %}

To enable fault-tolerant execution, select the **Retry object type** parameter under **Retry policy** when [creating](../operations/cluster-create.md) or [updating](../operations/cluster-update.md#change-retry-policy) a cluster:

* **Task**: Retries the intermediate task within the query that caused worker failure.

   {% note warning %}

   For high volumes of simple queries, retrying tasks may lead to longer delay in complex batch queries. We recommend creating a dedicated {{ mtr-name }} cluster with task retry settings for complex batch queries.

   {% endnote %}

* **Query**: Retries all [stages of the query](index.md#query-execution) where worker failure occurred.

## Exchange Manager storage types {#exchange-manager-storage}

You can select between two bucket types to use as storage for Exchange Manager intermediate results:

* **Service bucket**: This bucket is created and maintained by {{ mtr-name }} at no extra cost. It requires zero configuration but has limited size. This capacity may be insufficient for queries with large amounts of intermediate data.
* **Custom bucket**: {{ objstorage-name }} bucket you create yourself within your own folder. Bucket capacity is governed by {{ objstorage-name }} [quotas](../../storage/concepts/limits.md), with storage and operation fees applied according to the {{ objstorage-name }} [pricing policy](../../storage/pricing.md).

    To allow a {{ mtr-name }} cluster to write data to a custom bucket, assign the [storage.editor](../../storage/security/index.md#storage-editor) role or a role with equivalent bucket permissions to the cluster's [service account](../../iam/concepts/users/service-accounts.md).

The service bucket is used by default. You can select the storage type when [creating](../operations/cluster-create.md) or [updating](../operations/cluster-update.md#change-retry-policy) a cluster.

For more information about fault-tolerant query execution, see the [official guides](https://trino.io/docs/current/admin/fault-tolerant-execution.html).
