---
title: What performance analysis tools are available in {{ SD }}
description: In this tutorial, you will learn about performance analysis tools available in {{ SD }}.
---

# Performance analysis tools

## Built-in diagnostic utilities {#monitoring-tools}

{{ SD }} offers utilities to help you get performance data:

* `mongostat`: Collects statistics on CPU and memory usage with {{ SD }} processes.
* `mongotop`: Collects data read/write statistics for each collection.

When calling these utilities, use the connection string with the username and password of the user with the `mdbMonitor` role, for example:

```bash
mongostat 5 --uri="mongodb://{<name_of_user_with_mdbMonitor_role>}:{<password>}@{<host>}:27018/?authSource=admin"
mongotop 5 --uri="mongodb://{<name_of_user_with_mdbMonitor_role>}:{<password>}@{<host>}:27018/?authSource=admin"
```

Here, both utilities provide a set of performance data with a polling interval of 5 seconds.


### Profiler {#explore-profiler}

{{ SD }} has a built-in profiler. It collects query data and then uses it to determine a query optimization strategy. The profiler runs based on the [{{ SD }} settings](../concepts/settings-list.md) that you can set when [creating a cluster](./cluster-create.md) or [updating the DBMS settings](./update.md#change-mongod-config):

* [operationProfiling.mode](../concepts/settings-list.md#setting-operation-profiling).
* [operationProfiling.slowOpThreshold](../concepts/settings-list.md#setting-slow-op-threshold).

{% note warning %}

The use of the `all` value for `operationProfiling.mode` and a value close to `0` for `operationProfiling.slowOpThreshold` will significantly degrade cluster performance.

{% endnote %}

To view the data collected by the profiler, use the `system.profile` collection in each database. Profiler collections can be read by a [user](./cluster-users.md#adduser) with the [`mdbMonitor`](../concepts/users-and-roles.md#mdbMonitor) role. By default, the data is duplicated in the logs.


### Currently running queries {#list-running-queries}

To view queries not pertaining to the current user, run the `db.currentOp` query as a user with the [`mdbMonitor`](../concepts/users-and-roles.md#mdbMonitor) role:

```javascript
db.currentOp()
```

To view the current user's queries, run the `db.currentOp()` query with `ownOps` set to `true`:

```javascript
db.currentOp({ "$ownOps": true })
```

## Logs {#explore-logs}

You can find the most detailed information about {{ SD }} performance in the logs.

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **Yandex StoreDoc**.
    1. Click the cluster name and select the ![image](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_logs }}** tab.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To view **Yandex StoreDoc** logs:

    1. See the description of the CLI command to view the logs:

        ```bash
        {{ yc-mdb-mg }} cluster list-logs --help
        ```

    1. To get all the cluster logs, run the command:

        ```bash
        {{ yc-mdb-mg }} cluster list-logs --id <cluster_ID>
        ```

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.ListLogs](../api-ref/Cluster/listLogs.md) method to execute the following request via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>:logs' \
            --url-query serviceType=<service_type> \
            --url-query columnFilter=<column_list> \
            --url-query fromTime=<time_range_left_boundary> \
            --url-query toTime=<time_range_right_boundary>
        ```

        Where:

        * `serviceType`: Source service type for logs:
        
          * `MONGOD`: {{ SD }} operations log.
          * `AUDIT`: Audit log.

        * `columnFilter`: List of output columns:

          {% include [column-filter-list](../../_includes/mdb/api/column-filter-list.md) %}

          {% include [column-filter-rest](../../_includes/mdb/api/column-filter-rest.md) %}
        
            {% include [from-time-rest](../../_includes/mdb/api/from-time-rest.md) %}

            * `toTime`: The end time of the time range in the same format as `fromTime`.

        You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/listLogs.md#yandex.cloud.mdb.mongodb.v1.ListClusterLogsResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Use the [ClusterService.ListLogs](../api-ref/grpc/Cluster/listLogs.md) call to execute the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "service_type": "<service_type>",
                "column_filter": [
                  "<column_1>", "<column_2>", ..., "<column_N>"
                ],
                "from_time": "<time_range_left_boundary>",
                "to_time": "<time_range_right_boundary>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mongodb.v1.ClusterService.ListLogs
        ```

        Where:

        * `service_type`: Source service type for logs:

          * `MONGOD`: {{ SD }} operations log.
          * `AUDIT`: Audit log.

        * `column_filter`: List of data columns:

          {% include [column-filter-list](../../_includes/mdb/api/column-filter-list.md) %}

          {% include [column-filter-grpc](../../_includes/mdb/api/column-filter-grpc.md) %}

            {% include [from-time-grpc](../../_includes/mdb/api/from-time-grpc.md) %}

            * `to_time`: The end time of the time range in the same format as `from_time`.

        You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/listLogs.md#yandex.cloud.mdb.mongodb.v1.ListClusterLogsResponse) to make sure your request was successful.

{% endlist %}
