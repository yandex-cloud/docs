# Cluster monitoring and diagnostics tools

## Monitoring cluster status {#cluster-resources}

To view the main cluster performance metrics:

1. Go to the folder page and select **{{ mmg-name }}**.
1. Click on the name of the cluster and open the **Monitoring** tab.

The tab displays the number of operations on the primary host, the number of cluster connections, storage use on the primary {{ MG }} host, the total data volume, the {{ MG }} index volume, and other characteristics.

You can change the time interval for which the graphs are displayed by selecting the preset options (hour, day, week, month) or specifying it manually.

## Resource monitoring {#resources-deficit}

You can monitor resource usage on hosts in a {{ mmg-name }} cluster (most importantly on a host with the PRIMARY role) as follows:

1. Go to the folder page and select **{{ mmg-name }}**.
1. Click on the name of the cluster you want and select the **Hosts** tab.
1. Click on the name of the host you want.

## Diagnostics tools {#performance-instruments}

We recommend starting by reviewing [general monitoring strategies](https://docs.mongodb.com/manual/administration/monitoring/) for built-in {{ MG }} tools.

### Monitoring utilities {#use-monitoring-tools}

{{ MG }} offers utilities to help you get performance data:
   - [mongostat](https://docs.mongodb.com/database-tools/mongostat/#bin.mongostat): Collects statistics on CPU and memory usage with {{ MG }} processes.
   - [mongotop](https://docs.mongodb.com/database-tools/mongotop/#bin.mongotop): Collects data read/write statistics for each collection.

When calling these utilities, use the connection string with the username and password of the user with the `mdbMonitor` role, for example:

```bash
mongostat 5 --uri="mongodb://{username_with_mdbMonitor_role}:{user_password}@{host}:27018/?authSource=admin"
mongotop 5 --uri="mongodb://{username_with_mdbMonitor_role}:{user_password}@{хост}:27018/?authSource=admin"
```

Here, both utilities provide a set of performance data with a polling interval of 5 seconds.

### Profiler {#explore-profiler}

{{ MG }} has a [built-in profiler](https://docs.mongodb.com/manual/reference/database-profiler/). The profiler collects query data. It then uses this data to determine a query optimization strategy. The {{ MG }} profiler supports the following settings:
  - `operationProfiling.mode`: The DBMS profiler's mode:
     - `all`: Collects information about all queries in progress.
     - `slowOp` (default): Only collects information about slow operations (in execution longer than the threshold set by `operationProfiling.slowOpThreshold`).
     - `off`: Profiling is disabled.
  - `operationProfiling.slowOpThreshold`: The amount of time (in milliseconds) to perform an operation before considering it slow.

    The minimum value is `0` and the maximum is `36000000` (10 hours). The defaults value is `300`.

{% note info %}

   On production clusters, we don't recommend:
     - Setting the `operationProfiling.slowOpThreshold` too low.
     - Logging absolutely all operations (`operationProfiling.mode=all`), because the overhead for profiling and logging of all queries is very high.

{% endnote %}

To change the values of the profiler parameters, [use the CLI or API](../operations/update#change-mongod-config).

To view the data collected by the profiler, use the `system.profile` collection in each database. Profiler collections are read-only to the [user](../operations/cluster-users#adduser) with the [`mdbMonitor`](../concepts/users-and-roles#mdbMonitor) role. By default, the data is duplicated in the logs.

For more information about configuring the profiler and how to interpret its results, see the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/database-profiler/).

### Currently running queries {#list-running-queries}

To view the current user's queries, in the db.currentOp() operation, specify the [option](https://docs.mongodb.com/manual/reference/method/db.currentOp/#behavior) `ownOps`:

```
db.currentOp( { "$ownOps": true } )
```

To view queries not related to the current user, under the user with the [`mdbMonitor`](../concepts/users-and-roles#mdbMonitor) role, run the [db.currentOp() operation](https://docs.mongodb.com/manual/reference/method/db.currentOp/):

```
db.currentOp()
```

### Logs {#explore-logs}

The most detailed information about {{ MG }} application performance is given in the {{ MG }} logs.

{% list tabs %}

- Management console

  To view the logs:

  1. Go to the folder page and select **{{ mmg-name }}**.
  1. Select a cluster and open the **Logs** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To view the **{{ mmg-name }}** logs:

  1. View a description of the CLI command to view the logs:

     ```
     {{ yc-mdb-mg }} cluster list-logs --help
     ```

  2. To get all the cluster logs, run the command:

     ```
     {{ yc-mdb-mg }} cluster list-logs --id  <clusterId>
     ```

     In the `--id` parameter, specify the **{{ mmg-name }}** cluster ID. The cluster ID can be requested with a [list of clusters in the folder](../operations/cluster-list.md).

- API

  To view the logs, use the [listLogs](../api-ref/Cluster/listLogs.md) API method: pass the ID of the required cluster in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](../operations/cluster-list.md#list-clusters).

{% endlist %}
