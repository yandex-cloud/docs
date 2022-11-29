# Serverless and Dedicated operation modes

You can create and use multiple {{ ydb-short-name }} databases. When creating a database, one of two operating modes is selected for each database: Serverless or Dedicated. The mode can't be changed later.
* _Serverless_: A DB that doesn't require you to configure, administer, or monitor load or manage resources. To create a database, you only need to enter a name, and you'll get the URL for the connection. Payment is charged for the execution of queries and the actual amount of stored data.
* _Dedicated_: You determine the computing resources that will be reserved for the database: CPU and RAM on the nodes, the number of nodes, and the storage size. You need to make sure there are sufficient resources to handle the load and add more when necessary. Payment is charged for dedicated resources per hour, regardless of their actual use.

Additional information about {{ yandex-cloud }} pricing:
* For [_Serverless_ databases](../pricing/serverless.md).
* For [_Dedicated_ databases](../pricing/dedicated.md).

In {{ yandex-cloud }}, a serverless database supports data operations using both the {{ ydb-short-name }} API and [Document API](../api-ref/), an Amazon DynamoDB-compatible HTTP API. You can use this API to perform operations on document tables.

## Serverless database parameters {#serverless-options}

### Limitation: Throughput, RU/s {#capacity}

When executing a query to the serverless database, an indicator is calculated that shows the amount of resources of various types used to execute this query. This indicator is measured in Request Units (RUs). The cost of operating a serverless database depends on the total consumption of RUs.

Because serverless database resources are indefinitely large, the maximum consumption of RUs over a period of time can also be any value, leading to surprisingly high charges. For example, this can happen as a result of an error in the code causing an infinite loop of queries.

With the cloud deployment of {{ ydb-short-name }}, there is a limit on the total number of RUs per second at the level of cloud quotas. But this limit is technical and large enough that the potential invoice amount can still be significantly higher than expected. You can only increase this parameter by contacting technical support.

The **Throttling limit** on a serverless database allows you to set the maximum consumption rate of RUs per second. Considering a 5-minute accumulation of unused RUs, even with small limits (10 RU/s by default when creating a database), you can successfully perform various development and testing tasks and run applications with a small load. At the same time, the amount of possible charges will be limited to an upper limit of 2572000 seconds per month (30 days) multiplied by the price per 1 million RUs. Based on the pricing policy as of the date of this documentation (₽13.36), the maximum possible amount of charges per month is about ₽340.

You can change the **Throttling limit** interactively at any time, both increasing and decreasing it without restrictions. This allows you to quickly adjust it as needed, for example, to run a load test. Interactive means that changes take effect with the minimum technological delay required to propagate information about the new value across {{ ydb-short-name }} nodes.

The **Throttling limit** can be set to zero, which will cause overloading exceptions on any query. This can be useful for testing your application's response to such an exception and to prevent the consumption of resources if your application gets out of control.

The **Throttling limit** can be enabled or disabled. We recommend that you always keep it enabled, but disabling it may be useful if you need to temporarily get the maximum possible performance from the database, for example, to process a batch of queries.

**Specifics of using the throttling limit, RU/s**

If the limit is exceeded, a query is not accepted for execution and the `Throughput limit exceeded` error is returned. This error means that you can safely resend your query later. We recommend that you use the statements supplied as part of the {{ ydb-short-name }} SDK when re-sending queries. The proposed statements implement repetition algorithms that use different repetition strategies depending on error type and code: zero delay, exponentially increasing delay, fast or slow repetition, and others.

The limit is triggered with some delay, so the `Throughput limit exceeded` error is returned for a subsequent query rather than the specific query that resulted in exceeding the limit. Once the limit is triggered, queries won't be accepted for execution for a period approximately equal to the ratio of the queries exceeding the limit to the limit itself. For example, if you use 1000 RUs for the execution of a single query while your limit is 100 RU/s, new queries won't be accepted for 10 seconds.

To reduce the risk of rejection under uneven load, {{ ydb-short-name }} flexibly applies restrictions using a bandwidth reservation mechanism (`burst capacity`). As long as you use fewer RU processing requests than specified in the restriction, the unused bandwidth is reserved. During peak usage, more bandwidth than specified in the restriction may be temporarily available from the accumulated reserve.

{{ ydb-short-name }} reserves about 5 minutes of bandwidth. The reserve enables you to run a single query with a cost of about `5 min × 60 s × quota in RU/s` without subsequent queries being rejected. The `burst capacity` availability policy may be changed.

The quota for the number of serverless queries is also a tool to protect from paying for resource overruns resulting from application faults or attacks on the service. The `burst capacity` mechanism enables you to set the quota to the lowest value at which your application works without getting any `Throughput limit exceeded` errors and to keep some margin against an unexpected increase in load.

### Limitation: Maximum amount of data {#volume}

When using a Serverless database, the amount you pay depends on the amount of data stored.

Because the storage size in a serverless database is indefinitely large, the maximum amount of data that can be stored can also be any value, leading to surprisingly high charges. For example, this can happen as the result of an error in the code causing an infinite loop of data being added or if you accidentally import the wrong backup.

The **Maximum amount of data** limit for a serverless database limits the amount of data that {{ ydb-short-name }} allows you to add to this database. By default, a limit of 50 GB is set for new databases, which limits your monthly charges for the amount of stored data to approximately ₽650, according to the pricing policy as of the date of this documentation (₽13.41 per GB, 1 GB for free).

You can change the **Maximum amount of data** limit interactively at any time, both via the graphical console and the CLI and raise or reduce it without limitations. This allows you to quickly adjust it as needed.

We don't recommend setting the **Maximum amount of data** limit below the current actual amount because in this state, all data modification operations, including DELETE, become unavailable. You will only be able to reduce the amount of data with the DROP TABLE or DROP INDEX commands. If the limit is accidentally set below the actual volume, we recommend returning it to the operating value exceeding the actual volume with some redundancy.

## {{ ydb-short-name }} architecture in different operating modes {#arch-diff}

### Separate compute and storage layers {#separate-layers}

Please note that {{ ydb-short-name }} has two separate explicit layers: storage and compute. The storage layer is responsible for securely storing data on storage devices and replicating data between nodes to ensure fault tolerance.

In {{ ydb-short-name }}, user data is stored in tables that are partitioned. A shard is an entity that is responsible for storing a table partition (typically one). An entity called a tablet is responsible for changing data in a shard. It's a component that implements consistent changes in the shard data and solves the issue of distributed consensus. A tablet instance can be viewed as an object that is generated in the process address space and consumes CPU resources and RAM. Tablets store all their statuses in the storage layer. This means, among other things, that a tablet instance can be raised in an arbitrary process that the storage layer is available from. The {{ ydb-short-name }} compute layer essentially consists of tablets and the YQL query execution layer.

It should be noted that the concept of a database comprises user tables and, accordingly, tablet instances serving these tables as well as certain system entities. For example, there is a tablet called SchemeShard. It serves the data schema of all tables. There is a coordination system for distributed transactions whose items are also tablets.

### {{ ydb-short-name }} Dedicated mode {#dedicated}

Dedicated mode assumes that resources for tablet instances and for executing YQL queries are selected from the compute resources explicitly allocated to the database. Computational resources are VMs that have a certain number of vCPUs and some memory. The task of selecting the optimal amount of resources for the DB is currently the user's responsibility. If there aren't enough resources to serve the load, the latency of requests increases, which may eventually lead to the denial of service for requests, such as that with the `OVERLOADED` return code. The user can add compute resources (VMs) to the database in the UI or CLI to ensure it has the necessary amount of computing resources. Adding compute resources to the DB is relatively fast and comparable to the time it takes to start a VM. Subsequently, {{ ydb-short-name }} automatically balances tablets across a cluster taking into account the resources added.

### {{ ydb-short-name }} Serverless mode {#serverless}

In Serverless mode, the {{ ydb-short-name }} infrastructure determines the amount of computing resources to allocate to support a user database. The amount of allocated resources can be either very large (an arbitrary number of cores) or very small (significantly less than one core). If a user created a DB that contains a single table with a single entry and makes DB queries very rarely, {{ ydb-short-name }} actually uses a small amount of RAM on tablet instances that are part of the user DB. This is possible due to the fact that the user database components are objects rather than processes. If the load increases, the DB components start using more CPU time and memory. If load grows to the point where there aren't enough VM resources, the {{ ydb-short-name }} infrastructure can balance the system granularly spawning tablet instances on other VMs.

This technology lets you package virtual entities (tablet instances) very tightly together into physical resources based on actual consumption. This makes it possible to invoice the user for the operations performed rather than the allocated resources.