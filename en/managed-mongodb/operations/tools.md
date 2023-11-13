# Performance analysis tools

## Built-in diagnostic utilities {#monitoring-tools}

{{ MG }} offers utilities to help you get performance data:

* [mongostat](https://docs.mongodb.com/database-tools/mongostat/#bin.mongostat): Collects statistics on CPU and memory usage with {{ MG }} processes.
* [mongotop](https://docs.mongodb.com/database-tools/mongotop/#bin.mongotop): Collects data read/write statistics for each collection.

When calling these utilities, use the connection string with the username and password of the user with the `mdbMonitor` role, for example:

```bash
mongostat 5 --uri="mongodb://{<name_of_user_with_mdbMonitor_role>}:{<password>}@{<host>}:27018/?authSource=admin"
mongotop 5 --uri="mongodb://{<name_of_user_with_mdbMonitor_role>}:{<password>}@{<host>}:27018/?authSource=admin"
```

Here, both utilities provide a set of performance data with a polling interval of 5 seconds.

For more information about using `monostat` and `mongotop`, see the [{{ MG }} documentation](https://docs.mongodb.com/manual/administration/monitoring/).

### Profiler {#explore-profiler}

{{ MG }} has a [built-in profiler](https://docs.mongodb.com/manual/reference/database-profiler/). It collects query data and then uses it to determine a query optimization strategy. The profiler runs based on the [{{ MG }} settings](../concepts/settings-list.md) that you can set when [creating a cluster](./cluster-create.md) or [updating the DBMS settings](./update.md#change-mongod-config):

* [operationProfiling.mode](../concepts/settings-list.md#setting-operation-profiling);
* [operationProfiling.slowOpThreshold](../concepts/settings-list.md#setting-slow-op-threshold).

{% note warning %}

The `all` value for `operationProfiling.mode` and a value close to `0` for `operationProfiling.slowOpThreshold` significantly degrade cluster performance.

{% endnote %}

To view the data collected by the profiler, use the `system.profile` collection in each database. Profiler collections are read-only to the [user](./cluster-users.md#adduser) with the [`mdbMonitor`](../concepts/users-and-roles.md#mdbMonitor) role. By default, the data is duplicated in the logs.

For more information about configuring the profiler and how to interpret its results, see the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/database-profiler/).

### Currently running queries {#list-running-queries}

To view queries that do not pertain to the current user, run the [db.currentOp()](https://docs.mongodb.com/manual/reference/method/db.currentOp/) query under the user with the [`mdbMonitor`](../concepts/users-and-roles.md#mdbMonitor) role:

```javascript
db.currentOp()
```

To view the current user's queries, run the `db.currentOp()` query with the `true` value to [configure](https://docs.mongodb.com/manual/reference/method/db.currentOp/#behavior) `ownOps`:

```javascript
db.currentOp({ "$ownOps": true })
```

## Logs {#explore-logs}

You can find the most detailed information about {{ MG }} performance in the logs.

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
   1. Click the cluster name and select the ![image](../../_assets/logs.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_logs }}** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To view the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** logs:

   1. View a description of the CLI command to view the logs:

      ```bash
      {{ yc-mdb-mg }} cluster list-logs --help
      ```

   1. To get all the cluster logs, run the command:

      ```bash
      {{ yc-mdb-mg }} cluster list-logs --id <cluster_ID>
      ```

      You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

- API

   To view logs, use the [listLogs](../api-ref/Cluster/listLogs.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListLogs](../api-ref/grpc/cluster_service.md#ListLogs) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

{% endlist %}
