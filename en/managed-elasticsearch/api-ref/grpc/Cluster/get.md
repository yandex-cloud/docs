---
editable: false
sourcePath: en/_api-ref-grpc/mdb/elasticsearch/v1/api-ref/grpc/Cluster/get.md
---

# Managed Service for Elasticsearch API, gRPC: ClusterService.Get

Returns the specified Elasticsearch cluster.

To get the list of available Elasticsearch clusters, make a [List](/docs/managed-elasticsearch/api-ref/grpc/Cluster/list#List) request.

## gRPC request

**rpc Get ([GetClusterRequest](#yandex.cloud.mdb.elasticsearch.v1.GetClusterRequest)) returns ([Cluster](#yandex.cloud.mdb.elasticsearch.v1.Cluster))**

## GetClusterRequest {#yandex.cloud.mdb.elasticsearch.v1.GetClusterRequest}

```json
{
  "cluster_id": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Elasticsearch cluster to return.

To get the cluster ID, make a [ClusterService.List](/docs/managed-elasticsearch/api-ref/grpc/Cluster/list#List) request. ||
|#

## Cluster {#yandex.cloud.mdb.elasticsearch.v1.Cluster}

```json
{
  "id": "string",
  "folder_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "string",
  "environment": "Environment",
  "monitoring": [
    {
      "name": "string",
      "description": "string",
      "link": "string"
    }
  ],
  "config": {
    "version": "string",
    "elasticsearch": {
      "data_node": {
        // Includes only one of the fields `elasticsearch_config_set_7`
        "elasticsearch_config_set_7": {
          "effective_config": {
            "max_clause_count": "google.protobuf.Int64Value",
            "fielddata_cache_size": "string",
            "reindex_remote_whitelist": "string",
            "reindex_ssl_ca_path": "string"
          },
          "user_config": {
            "max_clause_count": "google.protobuf.Int64Value",
            "fielddata_cache_size": "string",
            "reindex_remote_whitelist": "string",
            "reindex_ssl_ca_path": "string"
          },
          "default_config": {
            "max_clause_count": "google.protobuf.Int64Value",
            "fielddata_cache_size": "string",
            "reindex_remote_whitelist": "string",
            "reindex_ssl_ca_path": "string"
          }
        },
        // end of the list of possible fields
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        }
      },
      "master_node": {
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        }
      },
      "plugins": [
        "string"
      ]
    },
    "edition": "string"
  },
  "network_id": "string",
  "health": "Health",
  "status": "Status",
  "security_group_ids": [
    "string"
  ],
  "service_account_id": "string",
  "deletion_protection": "bool",
  "maintenance_window": {
    // Includes only one of the fields `anytime`, `weekly_maintenance_window`
    "anytime": "AnytimeMaintenanceWindow",
    "weekly_maintenance_window": {
      "day": "WeekDay",
      "hour": "int64"
    }
    // end of the list of possible fields
  },
  "planned_operation": {
    "info": "string",
    "delayed_until": "google.protobuf.Timestamp"
  }
}
```

An Elasticsearch cluster resource.
For more information, see the [Concepts](/docs/managed-elasticsearch/concepts) section of the documentation.

#|
||Field | Description ||
|| id | **string**

ID of the Elasticsearch cluster.
This ID is assigned at creation time. ||
|| folder_id | **string**

ID of the folder that the Elasticsearch cluster belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the Elasticsearch cluster.
The name must be unique within the folder. 1-63 characters long. ||
|| description | **string**

Description of the Elasticsearch cluster. 0-256 characters long. ||
|| labels | **string**

Custom labels for the Elasticsearch cluster as `key:value` pairs.
A maximum of 64 labels per resource is allowed. ||
|| environment | enum **Environment**

Deployment environment of the Elasticsearch cluster.

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Stable environment with a conservative update policy when only hotfixes are applied during regular maintenance.
- `PRESTABLE`: Environment with a more aggressive update policy when new versions are rolled out irrespective of backward compatibility. ||
|| monitoring[] | **[Monitoring](#yandex.cloud.mdb.elasticsearch.v1.Monitoring)**

Description of monitoring systems relevant to the Elasticsearch cluster. ||
|| config | **[ClusterConfig](#yandex.cloud.mdb.elasticsearch.v1.ClusterConfig)**

Configuration of the Elasticsearch cluster. ||
|| network_id | **string**

ID of the network that the cluster belongs to. ||
|| health | enum **Health**

Aggregated cluster health.

- `HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](/docs/managed-elasticsearch/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.elasticsearch.v1.Host) of all hosts in the cluster is `UNKNOWN`).
- `ALIVE`: Cluster is alive and well ([Host.health](/docs/managed-elasticsearch/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.elasticsearch.v1.Host) of all hosts in the cluster is `ALIVE`).
- `DEAD`: Cluster is inoperable ([Host.health](/docs/managed-elasticsearch/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.elasticsearch.v1.Host) of all hosts in the cluster is `DEAD`).
- `DEGRADED`: Cluster is in degraded state ([Host.health](/docs/managed-elasticsearch/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.elasticsearch.v1.Host) of at least one of the hosts in the cluster is not `ALIVE`). ||
|| status | enum **Status**

Current state of the cluster.

- `STATUS_UNKNOWN`: Cluster state is unknown.
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running normally.
- `ERROR`: Cluster encountered a problem and cannot operate.
- `UPDATING`: Cluster is being updated.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster stopped.
- `STARTING`: Cluster is starting. ||
|| security_group_ids[] | **string**

User security groups ||
|| service_account_id | **string**

ID of the service account used for access to Object Storage. ||
|| deletion_protection | **bool**

Deletion Protection inhibits deletion of the cluster ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.mdb.elasticsearch.v1.MaintenanceWindow)**

Window of maintenance operations. ||
|| planned_operation | **[MaintenanceOperation](#yandex.cloud.mdb.elasticsearch.v1.MaintenanceOperation)**

Maintenance operation planned at nearest maintenance_window. ||
|#

## Monitoring {#yandex.cloud.mdb.elasticsearch.v1.Monitoring}

Metadata of monitoring system.

#|
||Field | Description ||
|| name | **string**

Name of the monitoring system. ||
|| description | **string**

Description of the monitoring system. ||
|| link | **string**

Link to the monitoring system charts for the Elasticsearch cluster. ||
|#

## ClusterConfig {#yandex.cloud.mdb.elasticsearch.v1.ClusterConfig}

#|
||Field | Description ||
|| version | **string**

Elasticsearch version. ||
|| elasticsearch | **[Elasticsearch](#yandex.cloud.mdb.elasticsearch.v1.Elasticsearch)**

Configuration and resource allocation for Elasticsearch nodes. ||
|| edition | **string**

ElasticSearch edition. ||
|#

## Elasticsearch {#yandex.cloud.mdb.elasticsearch.v1.Elasticsearch}

#|
||Field | Description ||
|| data_node | **[DataNode](#yandex.cloud.mdb.elasticsearch.v1.Elasticsearch.DataNode)**

Configuration and resource allocation for Elasticsearch data nodes. ||
|| master_node | **[MasterNode](#yandex.cloud.mdb.elasticsearch.v1.Elasticsearch.MasterNode)**

Configuration and resource allocation for Elasticsearch master nodes. ||
|| plugins[] | **string**

Cluster wide plugins ||
|#

## DataNode {#yandex.cloud.mdb.elasticsearch.v1.Elasticsearch.DataNode}

#|
||Field | Description ||
|| elasticsearch_config_set_7 | **[ElasticsearchConfigSet7](#yandex.cloud.mdb.elasticsearch.v1.config.ElasticsearchConfigSet7)**

Elasticsearch 7.x data node configuration.

Includes only one of the fields `elasticsearch_config_set_7`. ||
|| resources | **[Resources](#yandex.cloud.mdb.elasticsearch.v1.Resources)**

Resources allocated to Elasticsearch data nodes. ||
|#

## ElasticsearchConfigSet7 {#yandex.cloud.mdb.elasticsearch.v1.config.ElasticsearchConfigSet7}

Elasticsearch 7.x data node configuration.

#|
||Field | Description ||
|| effective_config | **[ElasticsearchConfig7](#yandex.cloud.mdb.elasticsearch.v1.config.ElasticsearchConfig7)**

Required field. Effective settings for an Elasticsearch cluster (a combination of settings defined in `user_config` and `default_config`). ||
|| user_config | **[ElasticsearchConfig7](#yandex.cloud.mdb.elasticsearch.v1.config.ElasticsearchConfig7)**

User-defined settings for an Elasticsearch cluster. ||
|| default_config | **[ElasticsearchConfig7](#yandex.cloud.mdb.elasticsearch.v1.config.ElasticsearchConfig7)**

Default settings for an Elasticsearch cluster. ||
|#

## ElasticsearchConfig7 {#yandex.cloud.mdb.elasticsearch.v1.config.ElasticsearchConfig7}

Elasticsearch 7.x supported configuration options are listed here.

Detailed description for each set of options is available in [Elasticsearch documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html).

Any options that are not listed here are not supported.

#|
||Field | Description ||
|| max_clause_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of clauses a boolean query can contain.

The limit is in place to prevent searches from becoming too large and taking up too much CPU and memory.
It affects not only Elasticsearch's `bool` query, but many other queries that are implicitly converted to `bool` query by Elastcsearch.

Default value: `1024`.

See in-depth description in [Elasticsearch documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-settings.html). ||
|| fielddata_cache_size | **string**

The maximum percentage or absolute value (10%, 512mb) of heap space that is allocated to field data cache.

All the field values that are placed in this cache, get loaded to memory in order to provide fast document based access to those values.
Building the field data cache for a field can be an expensive operations, so its recommended to have enough memory for this cache, and to keep it loaded.

Default value: unbounded.

See in-depth description in [Elasticsearch documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-fielddata.html). ||
|| reindex_remote_whitelist | **string**

Remote hosts for reindex have to be explicitly allowed in elasticsearch.yml using the reindex.remote.whitelist property.
It can be set to a comma delimited list of allowed remote host and port combinations.
Scheme is ignored, only the host and port are used. ||
|| reindex_ssl_ca_path | **string**

List of paths to PEM encoded certificate files that should be trusted.

See in-depth description in [Elasticsearch documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-reindex.html#reindex-ssl) ||
|#

## Resources {#yandex.cloud.mdb.elasticsearch.v1.Resources}

Computational resources.

#|
||Field | Description ||
|| resource_preset_id | **string**

ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/managed-elasticsearch/concepts/instance-types). ||
|| disk_size | **int64**

Volume of the storage available to a host, in bytes. ||
|| disk_type_id | **string**

Type of the storage environment for the host.
All available types are listed in the [documentation](/docs/managed-elasticsearch/concepts/storage). ||
|#

## MasterNode {#yandex.cloud.mdb.elasticsearch.v1.Elasticsearch.MasterNode}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.elasticsearch.v1.Resources)**

Resources allocated to Elasticsearch master nodes. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.elasticsearch.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.mdb.elasticsearch.v1.AnytimeMaintenanceWindow)**

Includes only one of the fields `anytime`, `weekly_maintenance_window`. ||
|| weekly_maintenance_window | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.elasticsearch.v1.WeeklyMaintenanceWindow)**

Includes only one of the fields `anytime`, `weekly_maintenance_window`. ||
|#

## AnytimeMaintenanceWindow {#yandex.cloud.mdb.elasticsearch.v1.AnytimeMaintenanceWindow}

#|
||Field | Description ||
|| Empty | > ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.elasticsearch.v1.WeeklyMaintenanceWindow}

#|
||Field | Description ||
|| day | enum **WeekDay**

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **int64**

Hour of the day in UTC. ||
|#

## MaintenanceOperation {#yandex.cloud.mdb.elasticsearch.v1.MaintenanceOperation}

#|
||Field | Description ||
|| info | **string** ||
|| delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|#