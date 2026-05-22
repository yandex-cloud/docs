# {{ MG }} performance analysis and tuning


In this tutorial, you will learn how to:

* Use [performance diagnostic](../../storedoc/operations/tools.md) and [monitoring](../../storedoc/operations/monitoring.md) tools.
* Troubleshoot identified issues.

{{ mmg-name }} cluster performance decline most often stems from one of the following causes:

* [High CPU and disk I/O usage](#cpu-io-deficit).
* [Inefficient {{ MG }} queries](#inefficient-queries).
* [Locks](#locks).
* [Insufficient disk space](#disk-deficit).

The following are tips for diagnosing and resolving these issues.

## Getting started {#before-start}

1. Install the `mongostat` and `mongotop` [utilities](../../storedoc/operations/tools.md#monitoring-tools) on an external host with network access to your {{ MG }} host (see [{#T}](../../storedoc/operations/connect/index.md)) to receive {{ MG }} performance data.
1. Determine which databases need to be checked for issues.
1. To use `mongostat` and `mongotop`, [create a {{ MG }} user](../../storedoc/operations/cluster-users.md#adduser) with the [`mdbMonitor`](../../storedoc/concepts/users-and-roles.md#mdbMonitor) role for these databases.

## Diagnosing resource shortages {#cpu-io-deficit}

If any of the CPU and disk I/O resources plateaued, i.e., a previously growing [chart](../../storedoc/operations/monitoring.md) leveled off, it may indicate that the resource has become a bottleneck, leading to performance degradation. This usually happens when resource consumption reaches its [limit](../../storedoc/concepts/limits.md).

In most cases, high CPU and disk I/O usage are caused by inefficient indexes or excessive host workload.

Start diagnostics by analyzing the workload pattern and identifying problematic collections using the built-in [{{ MG }} monitoring tools](../../storedoc/operations/tools.md#monitoring-tools). Next, analyze the performance of specific queries using [logs](../../storedoc/operations/tools.md#explore-logs) or [profiler data](../../storedoc/operations/tools.md#explore-profiler).

Take note of the following queries:

* Non-indexed queries (`planSummary: COLLSCAN`). Such queries can increase both I/O consumption due to more disk reads and CPU usage, since data is compressed by default and requires decompression. If the required index exists but the database is not using it, you can force index usage via `hint`.
* Queries with large `docsExamined` values, indicating a high volume of scanned documents. This may indicate that the existing indexes are inefficient or that additional ones are required.

When performance drops, you can diagnose the problem in real time using the [list of active queries](../../storedoc/operations/tools.md#list-running-queries):

{% list tabs %}

- All users’ queries:

    To view these queries, you need the [`mdbMonitor`](../../storedoc/concepts/users-and-roles.md#mdbMonitor) role.

    * Long queries, e.g., those running longer than one second:

      ```javascript
      db.currentOp({"active": true, "secs_running": {"$gt": 1}})
      ```

    * Index creation queries:

      ```javascript
      db.currentOp({ $or: [{ op: "command", "query.createIndexes": { $exists: true } }, { op: "none", ns: /\.system\.indexes\b/ }] })
      ```

- Current user’s queries:

    * Long queries, e.g., those running longer than one second:

      ```javascript
      db.currentOp({"$ownOps": true, "active": true, "secs_running": {"$gt": 1}})
      ```

    * Index creation queries:

      ```javascript
      db.currentOp({ "$ownOps": true, $or: [{ op: "command", "query.createIndexes": { $exists: true } }, { op: "none", ns: /\.system\.indexes\b/ }] })
      ```

{% endlist %}


## Troubleshooting resource shortages {#solving-deficit}

[Try optimizing](#optimize) the problematic queries you have identified. If the load remains high after optimization, you have to [upgrade the host class](../../storedoc/operations/update.md#change-resource-preset).

## Diagnosing inefficient queries {#inefficient-queries}

To identify problematic queries in {{ MG }}:

* Review the [logs](../../storedoc/operations/tools.md#explore-logs). Pay special attention to the following:

   * For read queries, look at the `responseLength` (`reslen`) field.
   * For write queries, look at the number of documents affected.
       In the `nModified`, `keysInserted`, and `keysDeleted` fields of the cluster logs. On the [cluster monitoring](../../storedoc/operations/monitoring.md#cluster) page, review the following charts: **Documents affected on primary**, **Documents affected on secondaries**, and **Documents affected per host**.
* Review the [profiler](../../storedoc/operations/tools.md#explore-profiler) data. Retrieve long-running queries by using the [`slowOpThreshold`](../../storedoc/concepts/settings-list.md#setting-slow-op-threshold) DBMS setting.

## Troubleshooting inefficient queries {#optimize}

You can analyze the execution plan of each individual query.

Examine the charts on the [cluster monitoring](../../storedoc/operations/monitoring.md#cluster) page:

* **Index size on primary, top 5 indexes**.
* **Scan and order per host**.
* **Scanned / returned**.

Use indexes to speed up queries.

{% note warning %}

Each index you add slows down write operations. An excessive number of indexes may negatively affect write performance.

{% endnote %}

Use projection to optimize read queries. In many cases, you do not need to retrieve the entire document; a subset of its fields is enough.

If you can neither optimize troublesome queries nor eliminate them, you have to [upgrade the host class](../../storedoc/operations/update.md#change-resource-preset).

## Diagnosing locks {#localize-locking-issues}

Poor query performance can result from locks.

{{ MG }} does not provide detailed information about locks. You can only use indirect methods to find out what is locking a specific query:

* Pay attention to large or growing `db.serverStatus().metrics.operation.writeConflicts` values, as they may indicate high write contention on certain documents.

* Examine large or growing values using the **Write conflicts per hosts** graph on the [cluster monitoring](../../storedoc/operations/monitoring.md#cluster) page.

* When performance drops, closely review the [list of currently running queries](../../storedoc/operations/tools.md#list-running-queries):

    {% list tabs %}

    - All users’ queries:

        To view these queries, you need the [`mdbMonitor`](../../storedoc/concepts/users-and-roles.md#mdbMonitor) role.

        * Identify queries that hold exclusive locks, such as:

          ```javascript
          db.currentOp({'$or': [{'locks.Global': 'W'}, {'locks.Database': 'W'}, {'locks.Collection': 'W'} ]}).inprog
          ```

        * Identify queries waiting for locks; their wait time is shown in the `timeAcquiringMicros` field:

          ```javascript
          db.currentOp({'waitingForLock': true}).inprog
          db.currentOp({'waitingForLock': true, 'secs_running' : { '$gt' : 1 }}).inprog
          ```

    - Current user’s queries:

        * Identify queries that hold exclusive locks, such as:

          ```javascript
          db.currentOp({"$ownOps": true, '$or': [{'locks.Global': 'W'}, {'locks.Database': 'W'}, {'locks.Collection': 'W'} ]}).inprog
          ```

        * Identify queries waiting for locks; their wait time is shown in the `timeAcquiringMicros` field:

          ```javascript
          db.currentOp({"$ownOps": true, 'waitingForLock': true}).inprog
          db.currentOp({"$ownOps": true, 'waitingForLock': true, 'secs_running' : { '$gt' : 1 }}).inprog
          ```

    {% endlist %}

* In the [logs](../../storedoc/operations/tools.md#explore-logs) and [profiler](../../storedoc/operations/tools.md#explore-profiler), note the following:
  * Queries with large `timeAcquiringMicros` values, indicating long wait time to acquire locks.
  * Queries with large `writeConflicts` values, indicating contention for the same documents.


## Troubleshooting locking issues {#solve-locks}

The detected locks indicate unoptimized queries. Try [optimizing the problematic queries](#optimize).

## Diagnosing disk space shortages {#disk-deficit}

If a cluster shows poor performance when its free disk space is limited, one or more cluster hosts may have [switched to "read-only" mode](../../storedoc/concepts/storage.md#manage-storage-space).

The amount of used disk space is displayed on the **Disk space usage per host, top 5 hosts** graphs on the [cluster monitoring](../../storedoc/operations/monitoring.md#cluster) page.

[Configure an alert](../../storedoc/operations/monitoring.md#read-only-alert) to track storage use on cluster hosts.

## Troubleshooting disk space issues {#solve-disk-deficit}

For troubleshooting recommendations, see [{#T}](../../storedoc/concepts/storage.md#read-only-solutions).
