---
title: What performance analysis tools are available in {{ SD }}
description: In this tutorial, you will learn about performance analysis tools available in {{ SD }}.
---

# Performance analysis tools

## Built-in diagnostic tools {#monitoring-tools}

{{ SD }} provides tools for collecting performance metrics:

* `mongostat`: Collects CPU and memory usage statistics for {{ SD }} processes.
* `mongotop`: Collects read/write statistics for each collection.

To run these tools, use a connection string containing credentials of a user with the `mdbMonitor` role. For example:

```bash
mongostat 5 --uri="mongodb://{<name_of_user_with_mdbMonitor_role>}:{<password>}@{<host>}:27018/?authSource=admin"
mongotop 5 --uri="mongodb://{<name_of_user_with_mdbMonitor_role>}:{<password>}@{<host>}:27018/?authSource=admin"
```

In this example, both utilities continuously output performance metrics, polling the system every 5 seconds.


### Profiler {#explore-profiler}

{{ SD }} Includes a built-in profiler. That collects query data and uses it to generate a query optimization strategy. The profiler’s operation is controlled by the [{{ SD }} settings](../concepts/settings-list.md), which you can configure when [creating a cluster](./cluster-create.md) or [updating the DBMS settings](./update.md#change-mongod-config):

* [operationProfiling.mode](../concepts/settings-list.md#setting-operation-profiling).
* [operationProfiling.slowOpThreshold](../concepts/settings-list.md#setting-slow-op-threshold).

{% note warning %}

Setting `operationProfiling.mode` to `all` and `operationProfiling.slowOpThreshold` to a value near `0` will severely degrade cluster performance.

{% endnote %}

To view the data collected by the profiler, refer to the `system.profile` collection in each database. To read profiler collections, a [user](./cluster-users.md#adduser) must have the [`mdbMonitor`](../concepts/users-and-roles.md#mdbMonitor) role. By default, this data is duplicated in the logs.


### Currently running queries {#list-running-queries}

To view queries executed by other users, run `db.currentOp` under the [`mdbMonitor`](../concepts/users-and-roles.md#mdbMonitor) role:

```javascript
db.currentOp()
```

To view the current user's queries, run `db.currentOp()` with `ownOps` set to `true`:

```javascript
db.currentOp({ "$ownOps": true })
```

## Logs {#explore-logs}

The logs contain the most detailed information about {{ SD }} operation.

{% list tabs group=instructions %}

- Management console {#console}

    1. Open the [folder dashboard]({{ link-console-main }}).
    1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.
    1. Click the name of your cluster and select the ![image](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_logs }}** tab.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To view **Yandex StoreDoc** logs:

    1. See the description of the CLI command for viewing logs:

        ```bash
        {{ yc-mdb-mg }} cluster list-logs --help
        ```

    1. To retrieve all cluster logs, run this command:

        ```bash
        {{ yc-mdb-mg }} cluster list-logs --id <cluster_ID>
        ```

        You can get the cluster ID from the [list of clusters in your folder](./cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.ListLogs](../api-ref/Cluster/listLogs.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>:logs' \
            --url-query serviceType=<service_type> \
            --url-query columnFilter=<column_list> \
            --url-query fromTime=<time_range_start> \
            --url-query toTime=<time_range_end>
        ```

        Where:

        * `serviceType`: Target service type for log retrieval:
        
          * `MONGOD`: {{ SD }} operations log.
          * `AUDIT`: Audit log.

        * `columnFilter`: List of output columns:

          {% include [column-filter-list](../../_includes/mdb/api/column-filter-list.md) %}

          {% include [column-filter-rest](../../_includes/mdb/api/column-filter-rest.md) %}
        
            {% include [from-time-rest](../../_includes/mdb/api/from-time-rest.md) %}

            * `toTime`: End of the time range in the same format as `fromTime`.

        You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/listLogs.md#yandex.cloud.mdb.mongodb.v1.ListClusterLogsResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Call the [ClusterService.ListLogs](../api-ref/grpc/Cluster/listLogs.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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
                "from_time": "<time_range_start>",
                "to_time": "<time_range_end>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mongodb.v1.ClusterService.ListLogs
        ```

        Where:

        * `service_type`: Target service type for log retrieval:

          * `MONGOD`: {{ SD }} operations log.
          * `AUDIT`: Audit log.

        * `column_filter`: List of output columns:

          {% include [column-filter-list](../../_includes/mdb/api/column-filter-list.md) %}

          {% include [column-filter-grpc](../../_includes/mdb/api/column-filter-grpc.md) %}

            {% include [from-time-grpc](../../_includes/mdb/api/from-time-grpc.md) %}

            * `to_time`: End of the time range in the same format as `from_time`.

        You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/listLogs.md#yandex.cloud.mdb.mongodb.v1.ListClusterLogsResponse) to make sure your request was successful.

{% endlist %}
