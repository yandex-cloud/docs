# Performance analysis and tuning

In this tutorial, you'll learn how to:

* Use [performance diagnostic tools](../operations/tools.md) and [monitoring tools](../operations/monitoring.md) to diagnose {{ mmg-name }} cluster performance.
* Troubleshoot identified issues.

{{ mmg-name }} cluster performance drops most often due to one of the following:

* [High CPU and disk I/O utilization](#cpu-io-deficit).
* [Inefficient query execution in {{ MG }}](#inefficient-queries).
* [Locks](#locks).
* [Insufficient disk space](#disk-deficit).

Here are some tips for diagnosing and fixing these issues.

## Before you begin {#before-start}

1. On an external host that has network access to a {{ MG }} host (see [{#T}](../operations/connect.md)), install the `mongostat` and `mongotop` [utilities](../operations/tools.md#monitoring-tools), which provide {{ MG }} performance data.
1. Determine which databases need to be checked for issues.
1. [Create a {{ MG }} user](../operations/cluster-users.md#adduser) with the [`mdbMonitor`](../concepts/users-and-roles.md#mdbMonitor) role for these databases. This is necessary so that you can use `mongostat` and `mongotop`.

## Diagnosing resource shortages {#cpu-io-deficit}

If some of the CPU and disk I/O resources "hit a plateau", that is, the curve of the [graph](../operations/monitoring.md) that was previously steadily ascending has leveled off, it's probably due to a resource shortage, which led to reduced performance. This usually happens when the resource usage reaches its [limit](../concepts/limits.md).

In most cases, high CPU utilization and high Disk IO are due to suboptimal indexes or a large load on the hosts.

Start diagnostics by identifying the load pattern and problematic collections. Use the built-in [{{ MG }} monitoring tools](../operations/tools.md#monitoring-tools). Next, analyze the performance of specific queries using [logs](../operations/tools.md#explore-logs) or [profiler data](../operations/tools.md#explore-profiler).

Pay attention to the following operations:

* Queries that don't use indexes (`planSummary: COLLSCAN`). Such queries may affect both I/O consumption (more reads from the disk) and CPU consumption (data is compressed by default and decompression is required for it). If the required index is present, but the database doesn't use it, you can force its usage with [hint](https://docs.mongodb.com/manual/reference/operator/meta/hint/index.html).
* Queries with large `docsExamined` parameter values (number of scanned documents). This may mean that the currently running indexes are inefficient or additional ones are required.

As soon as performance drops, you can diagnose the problem in real time using a [list of currently running queries](../operations/tools.md#list-running-queries):
* Long operations taking, for example,  more than one second to perform:

   ```javascript
   db.currentOp({"active": true, "secs_running": {"$gt": 1}})
   ```

* Operations to create indexes:

   ```javascript
   db.currentOp({ $or: [{ op: "command", "query.createIndexes": { $exists: true } }, { op: "none", ns: /\.system\.indexes\b/ }] })
   ```

See the examples in the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/method/db.currentOp/#examples).

## Troubleshooting resource shortage issues {#solving-deficit}

[Try optimizing](#optimize) the identified queries. If the load is still high or there is nothing to optimize, the only option is to [upgrade the host class](../operations/update.md#change-resource-preset).

## Diagnosing inefficient query execution {#inefficient-queries}

To identify problematic queries in {{ MG }}:

* Review the [logs](../operations/tools.md#explore-logs). Pay special attention to:
   * For read operations: the `responseLength` field (written as `reslen` in the logs).
   * For write operations: the number of affected documents.
      In the cluster logs, they are displayed in the `nModified`, `keysInserted`, and `keysDeleted` fields. On the [cluster monitoring](../operations/monitoring.md#cluster) page, analyze the **Documents affected on primary**, **Documents affected on secondaries**, and **Documents affected per host** graphs.
* Review the [profiler](../operations/tools.md#explore-profiler) data. Output long-running queries (adjustable with the [`slowOpThreshold` DBMS setting](../concepts/settings-list.md#setting-slow-op-threshold)).

## Troubleshooting issues with inefficient queries {#optimize}

Each individual query can be analyzed in terms of the query plan. Learn more about this in the {{ MG }} documentation:

* [Query analysis guide](https://docs.mongodb.com/manual/tutorial/analyze-query-plan/).
* [Reference for the `db.collection.explain` function](https://docs.mongodb.com/manual/reference/method/db.collection.explain/#db.collection.explain).

Analyze the graphs on the [cluster monitoring](../operations/monitoring.md#cluster) page:

* **Index size on primary, top 5 indexes**.
* **Scan and order per host**.
* **Scanned / returned**.

To more quickly narrow down the search scope, use [indexes](https://docs.mongodb.com/manual/indexes).

{% note warning %}

Each new index slows down writes. Too many indexes may negatively affect write performance.

{% endnote %}

You may be able to optimize read operations by limiting the fields to return ([projection](https://docs.mongodb.com/manual/tutorial/project-fields-from-query-results/)). You usually don't need to return the whole document, only a few fields.

If you cannot optimize the identified queries or manage without them, you can [raise the host class](../operations/update.md#change-resource-preset).

## Diagnosing locks {#localize-locking-issues}

Poor query performance can be caused by locks.

{{ MG }} doesn't provide detailed information on locks. So, there are only indirect ways to find out what's locking a specific query:

* Large or growing `db.serverStatus().metrics.operation.writeConflicts` values may indicate high write contention on some documents.

* Large or growing values on the **Write conflicts per hosts** graph on the [cluster monitoring](../operations/monitoring.md#cluster) page.

* As soon as performance drops, carefully review the [list of currently running queries](../operations/tools.md#list-running-queries):
   * Find operations that hold exclusive locks, for example:

      ```javascript
      db.currentOp({'$or': [{'locks.Global': 'W'}, {'locks.Database': 'W'}, {'locks.Collection': 'W'}]}).inprog
      ```

   * Find operations waiting for locks (the `timeAcquiringMicros` field shows the waiting time):

      ```javascript
      db.currentOp({'waitingForLock': true}).inprog
      db.currentOp({'waitingForLock': true, 'secs_running' : { '$gt' : 1 }}).inprog
      ```

* Pay attention to the following in the [logs](../operations/tools.md#explore-logs) and [profiler](../operations/tools.md#explore-profiler):
   * Operations that waited a long time for locks will have large `timeAcquiringMicros` values.
   * Operations that competed for the same documents will have large `writeConflicts` values.

Learn more about which locks are used by standard [client](https://docs.mongodb.com/manual/faq/concurrency/#what-locks-are-taken-by-some-common-client-operations-) and [administrative](https://docs.mongodb.com/manual/faq/concurrency/#which-administrative-commands-lock-a-database-) commands in the official {{ MG }} documentation.

## Troubleshooting locking issues {#solve-locks}

Detected locks indicate unoptimized queries. Try [optimizing problematic queries](#optimize).

## Diagnosing insufficient disk space {#disk-deficit}

If a cluster shows poor performance combined with a small amount of free disk space, it's possibly because [read-only mode was activated](../concepts/storage.md#manage-storage-space) for one or more hosts in the cluster.

The amount of used disk space is displayed on the **Disk space usage per host, top 5 hosts** graphs on the [cluster monitoring](../operations/monitoring.md#cluster) page.

To monitor storage usage on cluster hosts, [configure an alert](../operations/monitoring.md#read-only-alert).

## Troubleshooting disk space issues {#solve-disk-deficit}

For recommendations on troubleshooting these issues, see [{#T}](../concepts/storage.md#read-only-solutions).
