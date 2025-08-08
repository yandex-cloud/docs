---
editable: false
sourcePath: en/_api-ref-grpc/dataproc/v1/api-ref/grpc/Cluster/list.md
---

# Yandex Data Processing API, gRPC: ClusterService.List

Retrieves the list of clusters in the specified folder.

## gRPC request

**rpc List ([ListClustersRequest](#yandex.cloud.dataproc.v1.ListClustersRequest)) returns ([ListClustersResponse](#yandex.cloud.dataproc.v1.ListClustersResponse))**

## ListClustersRequest {#yandex.cloud.dataproc.v1.ListClustersRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list clusters in.

To get the folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListClustersResponse.next_page_token](#yandex.cloud.dataproc.v1.ListClustersResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListClustersResponse.next_page_token](#yandex.cloud.dataproc.v1.ListClustersResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters clusters listed in the response.

The expression must specify:
1. The field name. Currently you can use filtering only on [Cluster.name](#yandex.cloud.dataproc.v1.Cluster) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
Example of a filter: `name=my-cluster`. ||
|#

## ListClustersResponse {#yandex.cloud.dataproc.v1.ListClustersResponse}

```json
{
  "clusters": [
    {
      "id": "string",
      "folder_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "map<string, string>",
      "monitoring": [
        {
          "name": "string",
          "description": "string",
          "link": "string"
        }
      ],
      "config": {
        "version_id": "string",
        "hadoop": {
          "services": [
            "Service"
          ],
          "properties": "map<string, string>",
          "ssh_public_keys": [
            "string"
          ],
          "initialization_actions": [
            {
              "uri": "string",
              "args": [
                "string"
              ],
              "timeout": "int64"
            }
          ],
          "oslogin_enabled": "bool"
        }
      },
      "health": "Health",
      "status": "Status",
      "zone_id": "string",
      "service_account_id": "string",
      "bucket": "string",
      "ui_proxy": "bool",
      "security_group_ids": [
        "string"
      ],
      "host_group_ids": [
        "string"
      ],
      "deletion_protection": "bool",
      "log_group_id": "string",
      "environment": "Environment",
      "autoscaling_service_account_id": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| clusters[] | **[Cluster](#yandex.cloud.dataproc.v1.Cluster)**

List of clusters in the specified folder. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListClustersRequest.page_size](#yandex.cloud.dataproc.v1.ListClustersRequest), use `next_page_token` as the value
for the [ListClustersRequest.page_token](#yandex.cloud.dataproc.v1.ListClustersRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Cluster {#yandex.cloud.dataproc.v1.Cluster}

A Yandex Data Processing cluster. For details about the concept, see [documentation](/docs/data-proc/concepts/).

#|
||Field | Description ||
|| id | **string**

ID of the cluster. Generated at creation time. ||
|| folder_id | **string**

ID of the folder that the cluster belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the cluster. The name is unique within the folder. ||
|| description | **string**

Description of the cluster. ||
|| labels | **object** (map<**string**, **string**>)

Cluster labels as `key:value` pairs. ||
|| monitoring[] | **[Monitoring](#yandex.cloud.dataproc.v1.Monitoring)**

Monitoring systems relevant to the cluster. ||
|| config | **[ClusterConfig](#yandex.cloud.dataproc.v1.ClusterConfig)**

Configuration of the cluster. ||
|| health | enum **Health**

Aggregated cluster health.

- `HEALTH_UNKNOWN`: Object is in unknown state (we have no data).
- `ALIVE`: Object is alive and well (for example, all hosts of the cluster are alive).
- `DEAD`: Object is inoperable (it cannot perform any of its essential functions).
- `DEGRADED`: Object is partially alive (it can perform some of its essential functions). ||
|| status | enum **Status**

Cluster status.

- `STATUS_UNKNOWN`: Cluster state is unknown.
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running normally.
- `ERROR`: Cluster encountered a problem and cannot operate.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster stopped.
- `STARTING`: Cluster is starting. ||
|| zone_id | **string**

ID of the availability zone where the cluster resides. ||
|| service_account_id | **string**

ID of service account for the Yandex Data Processing manager agent. ||
|| bucket | **string**

Object Storage bucket to be used for Yandex Data Processing jobs that are run in the cluster. ||
|| ui_proxy | **bool**

Whether UI Proxy feature is enabled. ||
|| security_group_ids[] | **string**

User security groups. ||
|| host_group_ids[] | **string**

Host groups hosting VMs of the cluster. ||
|| deletion_protection | **bool**

Deletion Protection inhibits deletion of the cluster ||
|| log_group_id | **string**

ID of the cloud logging log group to write logs. If not set, default log group for the folder will be used.
To prevent logs from being sent to the cloud set cluster property dataproc:disable_cloud_logging = true ||
|| environment | enum **Environment**

Environment of the cluster

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`
- `PRESTABLE` ||
|| autoscaling_service_account_id | **string**

ID of service account for working with the Instance Groups service. ||
|#

## Monitoring {#yandex.cloud.dataproc.v1.Monitoring}

Metadata of a monitoring system for a Yandex Data Processing cluster.

#|
||Field | Description ||
|| name | **string**

Name of the monitoring system. ||
|| description | **string**

Description of the monitoring system. ||
|| link | **string**

Link to the monitoring system. ||
|#

## ClusterConfig {#yandex.cloud.dataproc.v1.ClusterConfig}

#|
||Field | Description ||
|| version_id | **string**

Image version for cluster provisioning.
All available versions are listed in the [documentation](/docs/data-proc/concepts/environment). ||
|| hadoop | **[HadoopConfig](#yandex.cloud.dataproc.v1.HadoopConfig)**

Yandex Data Processing specific configuration options. ||
|#

## HadoopConfig {#yandex.cloud.dataproc.v1.HadoopConfig}

Hadoop configuration that describes services installed in a cluster,
their properties and settings.

#|
||Field | Description ||
|| services[] | enum **Service**

Set of services used in the cluster (if empty, the default set is used).

- `SERVICE_UNSPECIFIED`
- `HDFS`
- `YARN`
- `MAPREDUCE`
- `HIVE`
- `TEZ`
- `ZOOKEEPER`
- `HBASE`
- `SQOOP`
- `FLUME`
- `SPARK`
- `ZEPPELIN`
- `OOZIE`
- `LIVY` ||
|| properties | **object** (map<**string**, **string**>)

Properties set for all hosts in `*-site.xml` configurations. The key should indicate
the service and the property.

For example, use the key 'hdfs:dfs.replication' to set the `dfs.replication` property
in the file `/etc/hadoop/conf/hdfs-site.xml`. ||
|| ssh_public_keys[] | **string**

List of public SSH keys to access to cluster hosts. ||
|| initialization_actions[] | **[InitializationAction](#yandex.cloud.dataproc.v1.InitializationAction)**

Set of init-actions ||
|| oslogin_enabled | **bool**

Oslogin enable on cluster nodes ||
|#

## InitializationAction {#yandex.cloud.dataproc.v1.InitializationAction}

#|
||Field | Description ||
|| uri | **string**

URI of the executable file ||
|| args[] | **string**

Arguments to the initialization action ||
|| timeout | **int64**

Execution timeout ||
|#