---
title: Serverless and Dedicated operation modes in {{ ydb-short-name }}
description: 'You can create {{ ydb-short-name }} databases in two modes: dedicated and serverless. Dedicated mode assumes that the resources for tablet instances and YQL queries are selected from the resources explicitly allocated to the compute database. In Serverless mode, the {{ ydb-short-name }} infrastructure determines the amount of computing resources to allocate to the user database.'
keywords:
  - ydb
  - serverless
  - dedicated
---

# Serverless and dedicated operation modes

You can create and use multiple {{ ydb-short-name }} databases. When creating a database, you can select one of the two operating modes: serverless or dedicated. You will not be able to change this mode later.
* A _serverless_ DB does not require you to either configure, administer, or monitor load or manage resources. To create such a database, you only need to enter a name, and you will get the URL for the connection. You are charged for running queries and the actual amount of stored data.
* In a _dedicated_ database, you determine the computing resources that will be reserved for the DB: CPU and RAM on the nodes, the number of nodes, and the storage size. You need to make sure there are sufficient resources to handle the load and add more when required. You are charged for dedicated resources per hour, regardless of their actual use.


For additional information about {{ yandex-cloud }} pricing, see these articles:

* [_Serverless_ DB pricing](../pricing/serverless.md)
* [_Dedicated_ DB pricing](../pricing/dedicated.md)


In {{ yandex-cloud }}, a serverless database supports data operations using both the {{ ydb-short-name }} API and [Document API](../docapi/tools/aws-http.md), an Amazon DynamoDB-compatible HTTP API. You can use this API to perform operations on document tables.

## Serverless database parameters {#serverless-options}

### Limitation: Throughput, RU/s {#capacity}

When running a query to the serverless DB, the system calculates a metric that shows the amount of resources of various types used to run this query. This metric is measured in request units (RUs). The cost of operating a serverless DB depends on the total consumption of RUs.

Since serverless DB resources are indefinitely large, the maximum consumption of RUs over a period of time can also reach any value, leading to excessive charges. For example, this can happen as a result of an error in the code causing an infinite loop of queries.

With the cloud deployment of {{ ydb-short-name }}, there is a limit on the total number of RUs per second at the cloud quota level. However, this limit is technical and large enough to make the potential invoice amount significantly higher than expected. You can only increase this parameter by contacting technical support.

The **Throttling limit** on a Serverless DB allows you to set the maximum consumption rate of RUs per second. With five-minute accumulation of unused RUs, even with small limits (10 RU/s by default when creating a database), you can successfully perform various development and testing tasks and run applications with a small load. The amount of possible charges will be limited to 2,572,000 seconds per month (30 days) multiplied by the price per 1 million RUs. Based on the pricing at the time of this writing (₽13.36), the maximum possible amount of charges per month is about ₽340.

You can change the **Throttling limit** interactively at any time, both increasing and decreasing it without restrictions. This allows you to quickly adjust it as needed, for example, to run a load test. The changes take effect with the minimum technological delay required to propagate information about the new value across {{ ydb-short-name }} nodes.

The **Throttling limit** can be set to zero, which will cause overloading exceptions on any query. This can be useful for testing your application's response to such an exception, as well as for urgently preventing the consumption of resources if your application gets out of control.

The **Throttling limit** can be enabled or disabled. We recommend that you always keep it enabled; however, disabling it may be useful if you need to temporarily get the maximum possible performance from the DB, e.g., to process a batch of queries.

**Specifics of using the throttling limit, RU/s**

If the limit is exceeded, a query is not accepted for execution, which returns the `Throughput limit exceeded` error. This error means that you can safely resend your query later. We recommend that you use the statements supplied as part of the {{ ydb-short-name }} SDK when repeating your query. The proposed statements implement repetition algorithms that use different repetition strategies depending on error type and code: zero delay, exponentially increasing delay, fast or slow repetition, and others.

The limit is triggered with a delay, so the `Throughput limit exceeded` error is returned for a subsequent query rather than the specific query that resulted in exceeding the limit. Once the limit is triggered, queries will not be accepted for execution for a period approximately equal to the ratio of the queries exceeding the limit to the limit itself. For example, if you use 1,000 RUs for running a single query while your limit is 100 RU/sec, new queries will not be accepted for 10 seconds.

To reduce the risk of rejection under uneven load, {{ ydb-short-name }} flexibly applies restrictions using `burst capacity`, a bandwidth reservation feature. As long as you use fewer RUs for processing requests than specified in the restriction, the unused bandwidth is reserved. During peak usage, more bandwidth than specified in the restriction may be temporarily available from the accumulated reserve.

{{ ydb-short-name }} reserves around five minutes of bandwidth. The reserve enables you to run a single query with a cost of about `5 min × 60 s × quota RU/s` without subsequent queries being rejected. The `burst capacity` availability policy may be changed.

The quota for the number of serverless queries is also a tool to protect from paying for resource overruns resulting from application faults or attacks on the service. The `burst capacity` feature enables you to set the quota to the lowest value at which your application works without getting any `Throughput limit exceeded` errors and to keep some margin against an unexpected increase in load.

### Limitation: Maximum amount of data {#volume}


When using a serverless DB, the amount you pay depends on the amount of data stored.

Since the storage size in a serverless DB is indefinitely large, the maximum amount of data that can be stored can also reach any value, leading to excessive charges. For example, this can happen as a result of an error in the code causing data to be inserted in an infinite loop, or accidentally importing the wrong backup.


The **Maximum amount of data** limit for a serverless DB enables you to restrict the amount of data in this DB allowed by {{ ydb-short-name }}. By default, a limit of 50 GB is set for new DBs, which limits your monthly charges for the amount of stored data to approximately ₽650 according to the pricing at the time of this writing (₽13.41 per GB, 1 GB for free).

You can change the **Maximum amount of data** limit interactively at any time, either via the GUI console or the CLI, to increase or reduce it without any limitations. This allows you to quickly adjust it as needed.

We do not recommend setting the **Maximum amount of data** limit below the current actual amount; otherwise, all data modification operations, including `DELETE`, will become unavailable. You will only be able to reduce the amount of data with the `DROP TABLE` or `DROP INDEX` commands. If the limit is accidentally set below the actual size, we recommend returning it to the operating value exceeding the actual size with some redundancy.

## {{ ydb-short-name }} architecture in different operation modes {#arch-diff}

### Separate compute and storage layers {#separate-layers}

{{ ydb-short-name }} has two separate explicit layers: storage and compute. The storage layer is responsible for securely storing data on storage devices and replicating data between nodes to ensure fault tolerance.

In {{ ydb-short-name }}, user data is stored in partitioned tables. Table partitions are stored in shards; typically, one shard stores one partition. To change data in a shard, a tablet is used. It is a component that implements consistent changes in the shard data and solves the distributed consensus issue. You can think of a tablet instance as an object that is generated in the process address space and consumes CPU resources and RAM. Tablets store all their statuses in the storage layer. This means, among other things, that a tablet instance can be raised in any process the storage layer is available from. The {{ ydb-short-name }} compute layer, in a nutshell, consists of tablets and the YQL query execution layer.

Generally, a DB includes both user-defined tables (with tablet instances serving these tables) and system entities. For example, let's assume there is a tablet called `SchemeShard` that serves the data schema of all tables. There is also a coordination system for distributed transactions whose items are also tablets.

### {{ ydb-short-name }} Dedicated mode {#dedicated}

Dedicated mode assumes that the resources for tablet instances and YQL queries are selected from the computing resources explicitly allocated to the DB. Computating resources are VMs that have a certain number of vCPUs and amount of RAM. The task to optimally allocate resources for a DB is currently the user's responsibility. If there are not enough resources to serve the load, the latency of requests increases, which may eventually lead to the denial of service for requests, such as that with the `OVERLOADED` return code. The user can add computing resources (VMs) to the DB using the UI or CLI to ensure the sufficiency of such resources. Adding compute resources to the DB is relatively fast and comparable to the time it takes to start a VM. Subsequently, {{ ydb-short-name }} will automatically balance tablets across a cluster based on the added resources.

### {{ ydb-short-name }} Serverless mode {#serverless}

In the serverless mode, the {{ ydb-short-name }} infrastructure determines the amount of computing resources to allocate for maintaining the user DB. The amount of allocated resources can be both very large (any number of cores) and very small (significantly less than one core). If a user created a DB with a single table with a single entry and hardly ever makes DB queries, {{ ydb-short-name }} uses a small amount of RAM on tablet instances that are part of the user DB. This is possible because the user DB components are objects rather than processes. If the load increases, the DB components start using more CPU time and memory. If load grows to the point where there are not enough VM resources, the {{ ydb-short-name }} infrastructure can balance the system granularly by spawning tablet instances on other VMs.

This technology allows you to package virtual entities (tablet instances) very tightly together into physical resources based on actual consumption. This enables invoicing the user for the performed operations rather than the allocated resources.


