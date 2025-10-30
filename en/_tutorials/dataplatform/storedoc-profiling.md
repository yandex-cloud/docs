# {{ MG }} performance analysis and tuning


In this tutorial, you will learn how to:

* Use [performance diagnostic tools](../../storedoc/operations/tools.md) and [monitoring tools](../../storedoc/operations/monitoring.md).
* Troubleshoot identified issues.

{{ mmg-name }} cluster performance drops most often due to one of the following:

* [High CPU and disk I/O utilization](#cpu-io-deficit).
* [Inefficient query execution in {{ MG }}](#inefficient-queries).
* [Locks](#locks).
* [Insufficient disk space](#disk-deficit).

Here are some tips for diagnosing and fixing these issues.

## Getting started {#before-start}

1. Install the `mongostat` and `mongotop` [utilities](../../storedoc/operations/tools.md#monitoring-tools) on an external host with network access to your {{ MG }} host (see [{#T}](../../storedoc/operations/connect/index.md)) to receive {{ MG }} performance data.
1. Determine which databases need to be checked for issues.
1. [Create a {{ MG }} user](../../storedoc/operations/cluster-users.md#adduser) with the [`mdbMonitor`](../../storedoc/concepts/users-and-roles.md#mdbMonitor) role for these databases. You need to do this in order to use `mongostat` and `mongotop`.

## Diagnosing resource shortages {#cpu-io-deficit}

If any of the CPU and disk I/O resources "hits a plateau", i.e., the [graph](../../storedoc/operations/monitoring.md) that had been steadily ascending levels off, it is probably because the resource is in short supply, resulting in reduced performance. This usually happens when the resource usage reaches its [limit](../../storedoc/concepts/limits.md).

In most cases, high CPU utilization and high Disk IO are due to suboptimal indexes or a large load on the hosts.

Start diagnostics by identifying the load pattern and problematic collections. Use the built-in [{{ MG }} monitoring tools](../../storedoc/operations/tools.md#monitoring-tools). Next, analyze the performance of specific queries using [logs](../../storedoc/operations/tools.md#explore-logs) or [profiler data](../../storedoc/operations/tools.md#explore-profiler).

Pay attention to queries:

* Not using indexes (`planSummary: COLLSCAN`). Such queries may affect both I/O consumption (more reads from the disk) and CPU consumption (data is compressed by default and decompression is required for it). If the required index is present, but the database does not use it, you can force its usage with `hint`.
* With large `docsExamined` values (number of scanned documents). This may mean that the currently running indexes are inefficient or additional ones are required.

As soon as performance drops, you can diagnose the problem in real time using a [list of currently running queries](../../storedoc/operations/tools.md#list-running-queries):

{% list tabs %}

- Queries from all users

    To run these queries, users needs the [`mdbMonitor`](../../storedoc/concepts/users-and-roles.md#mdbMonitor) role.

    * Long queries, such as those taking more than one second to execute:

      ```javascript
      db.currentOp({"active": true, "secs_running": {"$gt": 1}})
      ```

    * Queries to create indexes:

      ```javascript
      db.currentOp({ $or: [{ op: "command", "query.createIndexes": { $exists: true } }, { op: "none", ns: /\.system\.indexes\b/ }] })
      ```

- Queries from the current user

    * Long queries, such as those taking more than one second to execute:

      ```javascript
      db.currentOp({"$ownOps": true, "active": true, "secs_running": {"$gt": 1}})
      ```

    * Queries to create indexes:

      ```javascript
      db.currentOp({ "$ownOps": true, $or: [{ op: "command", "query.createIndexes": { $exists: true } }, { op: "none", ns: /\.system\.indexes\b/ }] })
      ```

{% endlist %}


## Troubleshooting resource shortage issues {#solving-deficit}

[Try optimizing](#optimize) the identified queries. If the load is still high or there is nothing to optimize, the only option is to [upgrade the host class](../../storedoc/operations/update.md#change-resource-preset).

## Diagnosing inefficient query execution {#inefficient-queries}

To identify problematic queries in {{ MG }}:

* Review the [logs](../../storedoc/operations/tools.md#explore-logs). Pay special attention to:

   * For read queries, the `responseLength` field (written as `reslen` in the logs).
   * For write queries, the number of affected documents.
       In the cluster logs, they are displayed in the `nModified`, `keysInserted`, and `keysDeleted` fields. On the [cluster monitoring](../../storedoc/operations/monitoring.md#cluster) page, analyze the **Documents affected on primary**, **Documents affected on secondaries**, and **Documents affected per host** graphs.
* Review the [profiler](../../storedoc/operations/tools.md#explore-profiler) data. Output long-running queries (adjustable with the [`slowOpThreshold` DBMS setting](../../storedoc/concepts/settings-list.md#setting-slow-op-threshold)).

## Troubleshooting issues with inefficient queries {#optimize}

Each individual query can be analyzed in terms of the query plan.

Analyze the graphs on the [cluster monitoring](../../storedoc/operations/monitoring.md#cluster) page:

* **Index size on primary, top 5 indexes**.
* **Scan and order per host**.
* **Scanned / returned**.

To narrow down the search scope quicker, use indexes.

{% note warning %}

Each new index slows down writes. Too many indexes may negatively affect write performance.

{% endnote %}

To optimize read requests, use a projection. In many cases, you need to return only a few fields rather than the entire document.

If you can neither optimize the queries you found nor go without them, [upgrade the host class](../../storedoc/operations/update.md#change-resource-preset).

## Diagnosing locks {#localize-locking-issues}

Poor query performance can be caused by locks.

{{ MG }} does not provide detailed information on locks. There are only indirect ways to find out what is locking a specific query:

* Pay attention to large or growing `db.serverStatus().metrics.operation.writeConflicts` values: they may indicate high write contention on some documents.

* Examine large or growing values using the **Write conflicts per hosts** graph on the [cluster monitoring](../../storedoc/operations/monitoring.md#cluster) page.

* As soon as performance drops, carefully review the [list of currently running queries](../../storedoc/operations/tools.md#list-running-queries):

    {% list tabs %}

    - Queries from all users

        To run these queries, the user needs the [`mdbMonitor`](../../storedoc/concepts/users-and-roles.md#mdbMonitor) role.

        * Find queries that hold exclusive locks, such as:

          ```javascript
          db.currentOp({'$or': [{'locks.Global': 'W'}, {'locks.Database': 'W'}, {'locks.Collection': 'W'} ]}).inprog
          ```

        * Find queries waiting for locks (the `timeAcquiringMicros` field shows the waiting time):

          ```javascript
          db.currentOp({'waitingForLock': true}).inprog
          db.currentOp({'waitingForLock': true, 'secs_running' : { '$gt' : 1 }}).inprog
          ```

    - Queries from the current user

        * Find queries that hold exclusive locks, such as:

          ```javascript
          db.currentOp({"$ownOps": true, '$or': [{'locks.Global': 'W'}, {'locks.Database': 'W'}, {'locks.Collection': 'W'} ]}).inprog
          ```

        * Find queries waiting for locks (the `timeAcquiringMicros` field shows the waiting time):

          ```javascript
          db.currentOp({"$ownOps": true, 'waitingForLock': true}).inprog
          db.currentOp({"$ownOps": true, 'waitingForLock': true, 'secs_running' : { '$gt' : 1 }}).inprog
          ```

    {% endlist %}

* Pay attention to the following in the [logs](../../storedoc/operations/tools.md#explore-logs) and [profiler](../../storedoc/operations/tools.md#explore-profiler):
  * Queries that had waited a long time to get locks will have large `timeAcquiringMicros` values.
  * Queries that had competed for the same documents will have large `writeConflicts` values.


## Troubleshooting locking issues {#solve-locks}

Detected locks indicate unoptimized queries. Try [optimizing problematic queries](#optimize).

## Diagnosing insufficient disk space {#disk-deficit}

If a cluster shows poor performance combined with a small amount of free disk space, one or more hosts in the cluster may have [switched to the "read-only" mode](../../storedoc/concepts/storage.md#manage-storage-space).

The amount of used disk space is displayed on the **Disk space usage per host, top 5 hosts** graphs on the [cluster monitoring](../../storedoc/operations/monitoring.md#cluster) page.

To monitor cluster host storage utilization, [configure an alert](../../storedoc/operations/monitoring.md#read-only-alert).

## Troubleshooting disk space issues {#solve-disk-deficit}

For recommendations on troubleshooting these issues, see [{#T}](../../storedoc/concepts/storage.md#read-only-solutions).
