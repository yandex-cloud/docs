# Fault-tolerant query execution in a {{ mtr-name }} cluster

{{ mtr-name }} clusters support the [fault-tolerant execution](https://trino.io/docs/current/admin/fault-tolerant-execution.html) mechanism. By default, when resources are insufficient or a query fails with an error, the [worker](index.md#workers) will stop processing the query and you will need to run it again manually. With fault-tolerant execution enabled, the query or its component task will be retried in the event of failure.

To ensure fault-tolerant execution of queries, Exchange Manager regularly exports intermediate results to an {{ objstorage-name }} service bucket. If a query fails, the [coordinator](index.md#coordinator) will assign the retry to another worker, which can use the previously processed data.

{% note info %}

Fault-tolerant execution does not apply to incorrect or misspelled queries.

{% endnote %}

Fault-tolerant execution is only supported for the following [connectors](index.md#connector):

{% include [connectors](../../_includes/managed-trino/retry-policy-connector-list.md) %}

To enable fault-tolerant execution, select the **Retry object type** parameter under **Retry policy** when [creating](../operations/cluster-create.md) or [updating](../operations/cluster-update.md) a cluster:

* **Task**: Retries an intermediate task within the query which caused worker failure.

   {% note warning %}

   For high volumes of simple queries, retrying tasks may lead to longer delay in complex batch queries. We recommend creating a dedicated {{ mtr-name }} cluster with task retry settings for complex batch queries.

   {% endnote %}

* **Query**: Retries the [entire query](index.md#query-execution) which caused worker failure.

For more information about fault-tolerant query execution, see the [official documentation](https://trino.io/docs/current/admin/fault-tolerant-execution.html).
