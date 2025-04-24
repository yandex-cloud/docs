---
editable: false
sourcePath: en/_api-ref/dataproc/v1/api-ref/Cluster/list.md
---

# Yandex Data Processing API, REST: Cluster.List

Retrieves the list of clusters in the specified folder.

## HTTP request

```
GET https://dataproc.{{ api-host }}/dataproc/v1/clusters
```

## Query parameters {#yandex.cloud.dataproc.v1.ListClustersRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list clusters in.

To get the folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListClustersResponse.nextPageToken](#yandex.cloud.dataproc.v1.ListClustersResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListClustersResponse.nextPageToken](#yandex.cloud.dataproc.v1.ListClustersResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters clusters listed in the response.

The expression must specify:
1. The field name. Currently you can use filtering only on [Cluster.name](#yandex.cloud.dataproc.v1.Cluster) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
Example of a filter: `name=my-cluster`. ||
|#

## Response {#yandex.cloud.dataproc.v1.ListClustersResponse}

**HTTP Code: 200 - OK**

```json
{
  "clusters": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "monitoring": [
        {
          "name": "string",
          "description": "string",
          "link": "string"
        }
      ],
      "config": {
        "versionId": "string",
        "hadoop": {
          "services": [
            "string"
          ],
          "properties": "object",
          "sshPublicKeys": [
            "string"
          ],
          "initializationActions": [
            {
              "uri": "string",
              "args": [
                "string"
              ],
              "timeout": "string"
            }
          ],
          "osloginEnabled": "boolean"
        }
      },
      "health": "string",
      "status": "string",
      "zoneId": "string",
      "serviceAccountId": "string",
      "bucket": "string",
      "uiProxy": "boolean",
      "securityGroupIds": [
        "string"
      ],
      "hostGroupIds": [
        "string"
      ],
      "deletionProtection": "boolean",
      "logGroupId": "string",
      "environment": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| clusters[] | **[Cluster](#yandex.cloud.dataproc.v1.Cluster)**

List of clusters in the specified folder. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListClustersRequest.pageSize](#yandex.cloud.dataproc.v1.ListClustersRequest), use `next_page_token` as the value
for the [ListClustersRequest.pageToken](#yandex.cloud.dataproc.v1.ListClustersRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Cluster {#yandex.cloud.dataproc.v1.Cluster}

A Yandex Data Processing cluster. For details about the concept, see [documentation](/docs/data-proc/concepts/).

#|
||Field | Description ||
|| id | **string**

ID of the cluster. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the cluster belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
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
|| health | **enum** (Health)

Aggregated cluster health.

- `HEALTH_UNKNOWN`: Object is in unknown state (we have no data).
- `ALIVE`: Object is alive and well (for example, all hosts of the cluster are alive).
- `DEAD`: Object is inoperable (it cannot perform any of its essential functions).
- `DEGRADED`: Object is partially alive (it can perform some of its essential functions). ||
|| status | **enum** (Status)

Cluster status.

- `STATUS_UNKNOWN`: Cluster state is unknown.
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running normally.
- `ERROR`: Cluster encountered a problem and cannot operate.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster stopped.
- `STARTING`: Cluster is starting. ||
|| zoneId | **string**

ID of the availability zone where the cluster resides. ||
|| serviceAccountId | **string**

ID of service account for the Yandex Data Processing manager agent. ||
|| bucket | **string**

Object Storage bucket to be used for Yandex Data Processing jobs that are run in the cluster. ||
|| uiProxy | **boolean**

Whether UI Proxy feature is enabled. ||
|| securityGroupIds[] | **string**

User security groups. ||
|| hostGroupIds[] | **string**

Host groups hosting VMs of the cluster. ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the cluster ||
|| logGroupId | **string**

ID of the cloud logging log group to write logs. If not set, default log group for the folder will be used.
To prevent logs from being sent to the cloud set cluster property dataproc:disable_cloud_logging = true ||
|| environment | **enum** (Environment)

Environment of the cluster

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`
- `PRESTABLE` ||
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
|| versionId | **string**

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
|| services[] | **enum** (Service)

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
|| sshPublicKeys[] | **string**

List of public SSH keys to access to cluster hosts. ||
|| initializationActions[] | **[InitializationAction](#yandex.cloud.dataproc.v1.InitializationAction)**

Set of init-actions ||
|| osloginEnabled | **boolean**

Oslogin enable on cluster nodes ||
|#

## InitializationAction {#yandex.cloud.dataproc.v1.InitializationAction}

#|
||Field | Description ||
|| uri | **string**

URI of the executable file ||
|| args[] | **string**

Arguments to the initialization action ||
|| timeout | **string** (int64)

Execution timeout ||
|#