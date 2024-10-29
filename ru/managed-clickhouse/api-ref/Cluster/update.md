---
editable: false
sourcePath: en/_api-ref/mdb/clickhouse/v1/api-ref/Cluster/update.md
---

# Managed Service for ClickHouse API, REST: Cluster.Update {#Update}

Updates the specified ClickHouse cluster.

## HTTP request

```
PATCH https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the ClickHouse Cluster resource to update.
To get the ClickHouse cluster ID, use a [ClusterService.List](/docs/managed-clickhouse/api-ref/Cluster/list#List) request. ||
|#

## Body parameters {#yandex.cloud.mdb.clickhouse.v1.UpdateClusterRequest}

```json
{
  "updateMask": "string",
  "description": "string",
  "labels": "string",
  "configSpec": {
    "version": "string",
    "clickhouse": {
      "config": {
        "logLevel": "string",
        "mergeTree": {
          "replicatedDeduplicationWindow": "string",
          "replicatedDeduplicationWindowSeconds": "string",
          "partsToDelayInsert": "string",
          "partsToThrowInsert": "string",
          "inactivePartsToDelayInsert": "string",
          "inactivePartsToThrowInsert": "string",
          "maxReplicatedMergesInQueue": "string",
          "numberOfFreeEntriesInPoolToLowerMaxSizeOfMerge": "string",
          "maxBytesToMergeAtMinSpaceInPool": "string",
          "maxBytesToMergeAtMaxSpaceInPool": "string",
          "minBytesForWidePart": "string",
          "minRowsForWidePart": "string",
          "ttlOnlyDropParts": "boolean",
          "allowRemoteFsZeroCopyReplication": "boolean",
          "mergeWithTtlTimeout": "string",
          "mergeWithRecompressionTtlTimeout": "string",
          "maxPartsInTotal": "string",
          "maxNumberOfMergesWithTtlInPool": "string",
          "cleanupDelayPeriod": "string",
          "numberOfFreeEntriesInPoolToExecuteMutation": "string",
          "maxAvgPartSizeForTooManyParts": "string",
          "minAgeToForceMergeSeconds": "string",
          "minAgeToForceMergeOnPartitionOnly": "boolean",
          "mergeSelectingSleepMs": "string",
          "mergeMaxBlockSize": "string",
          "checkSampleColumnIsCorrect": "boolean",
          "maxMergeSelectingSleepMs": "string",
          "maxCleanupDelayPeriod": "string"
        },
        "compression": [
          {
            "method": "string",
            "minPartSize": "string",
            "minPartSizeRatio": "string",
            "level": "string"
          }
        ],
        "dictionaries": [
          {
            "name": "string",
            "structure": {
              "id": {
                "name": "string"
              },
              "key": {
                "attributes": [
                  {
                    "name": "string",
                    "type": "string",
                    "nullValue": "string",
                    "expression": "string",
                    "hierarchical": "boolean",
                    "injective": "boolean"
                  }
                ]
              },
              "rangeMin": {
                "name": "string",
                "type": "string",
                "nullValue": "string",
                "expression": "string",
                "hierarchical": "boolean",
                "injective": "boolean"
              },
              "rangeMax": {
                "name": "string",
                "type": "string",
                "nullValue": "string",
                "expression": "string",
                "hierarchical": "boolean",
                "injective": "boolean"
              },
              "attributes": [
                {
                  "name": "string",
                  "type": "string",
                  "nullValue": "string",
                  "expression": "string",
                  "hierarchical": "boolean",
                  "injective": "boolean"
                }
              ]
            },
            "layout": {
              "type": "string",
              "sizeInCells": "string",
              "maxArraySize": "string"
            },
            // Includes only one of the fields `fixedLifetime`, `lifetimeRange`
            "fixedLifetime": "string",
            "lifetimeRange": {
              "min": "string",
              "max": "string"
            },
            // end of the list of possible fields
            // Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`
            "httpSource": {
              "url": "string",
              "format": "string",
              "headers": [
                {
                  "name": "string",
                  "value": "string"
                }
              ]
            },
            "mysqlSource": {
              "db": "string",
              "table": "string",
              "port": "string",
              "user": "string",
              "password": "string",
              "replicas": [
                {
                  "host": "string",
                  "priority": "string",
                  "port": "string",
                  "user": "string",
                  "password": "string"
                }
              ],
              "where": "string",
              "invalidateQuery": "string",
              "closeConnection": "boolean",
              "shareConnection": "boolean"
            },
            "clickhouseSource": {
              "db": "string",
              "table": "string",
              "host": "string",
              "port": "string",
              "user": "string",
              "password": "string",
              "where": "string",
              "secure": "boolean"
            },
            "mongodbSource": {
              "db": "string",
              "collection": "string",
              "host": "string",
              "port": "string",
              "user": "string",
              "password": "string",
              "options": "string"
            },
            "postgresqlSource": {
              "db": "string",
              "table": "string",
              "hosts": [
                "string"
              ],
              "port": "string",
              "user": "string",
              "password": "string",
              "invalidateQuery": "string",
              "sslMode": "string"
            }
            // end of the list of possible fields
          }
        ],
        "graphiteRollup": [
          {
            "name": "string",
            "patterns": [
              {
                "regexp": "string",
                "function": "string",
                "retention": [
                  {
                    "age": "string",
                    "precision": "string"
                  }
                ]
              }
            ],
            "pathColumnName": "string",
            "timeColumnName": "string",
            "valueColumnName": "string",
            "versionColumnName": "string"
          }
        ],
        "kafka": {
          "securityProtocol": "string",
          "saslMechanism": "string",
          "saslUsername": "string",
          "saslPassword": "string",
          "enableSslCertificateVerification": "boolean",
          "maxPollIntervalMs": "string",
          "sessionTimeoutMs": "string",
          "debug": "string",
          "autoOffsetReset": "string"
        },
        "kafkaTopics": [
          {
            "name": "string",
            "settings": {
              "securityProtocol": "string",
              "saslMechanism": "string",
              "saslUsername": "string",
              "saslPassword": "string",
              "enableSslCertificateVerification": "boolean",
              "maxPollIntervalMs": "string",
              "sessionTimeoutMs": "string",
              "debug": "string",
              "autoOffsetReset": "string"
            }
          }
        ],
        "rabbitmq": {
          "username": "string",
          "password": "string",
          "vhost": "string"
        },
        "maxConnections": "string",
        "maxConcurrentQueries": "string",
        "keepAliveTimeout": "string",
        "uncompressedCacheSize": "string",
        "markCacheSize": "string",
        "maxTableSizeToDrop": "string",
        "maxPartitionSizeToDrop": "string",
        "builtinDictionariesReloadInterval": "string",
        "timezone": "string",
        "geobaseEnabled": "boolean",
        "geobaseUri": "string",
        "queryLogRetentionSize": "string",
        "queryLogRetentionTime": "string",
        "queryThreadLogEnabled": "boolean",
        "queryThreadLogRetentionSize": "string",
        "queryThreadLogRetentionTime": "string",
        "partLogRetentionSize": "string",
        "partLogRetentionTime": "string",
        "metricLogEnabled": "boolean",
        "metricLogRetentionSize": "string",
        "metricLogRetentionTime": "string",
        "traceLogEnabled": "boolean",
        "traceLogRetentionSize": "string",
        "traceLogRetentionTime": "string",
        "textLogEnabled": "boolean",
        "textLogRetentionSize": "string",
        "textLogRetentionTime": "string",
        "textLogLevel": "string",
        "opentelemetrySpanLogEnabled": "boolean",
        "opentelemetrySpanLogRetentionSize": "string",
        "opentelemetrySpanLogRetentionTime": "string",
        "queryViewsLogEnabled": "boolean",
        "queryViewsLogRetentionSize": "string",
        "queryViewsLogRetentionTime": "string",
        "asynchronousMetricLogEnabled": "boolean",
        "asynchronousMetricLogRetentionSize": "string",
        "asynchronousMetricLogRetentionTime": "string",
        "sessionLogEnabled": "boolean",
        "sessionLogRetentionSize": "string",
        "sessionLogRetentionTime": "string",
        "zookeeperLogEnabled": "boolean",
        "zookeeperLogRetentionSize": "string",
        "zookeeperLogRetentionTime": "string",
        "asynchronousInsertLogEnabled": "boolean",
        "asynchronousInsertLogRetentionSize": "string",
        "asynchronousInsertLogRetentionTime": "string",
        "backgroundPoolSize": "string",
        "backgroundMergesMutationsConcurrencyRatio": "string",
        "backgroundSchedulePoolSize": "string",
        "backgroundFetchesPoolSize": "string",
        "backgroundMovePoolSize": "string",
        "backgroundDistributedSchedulePoolSize": "string",
        "backgroundBufferFlushSchedulePoolSize": "string",
        "backgroundMessageBrokerSchedulePoolSize": "string",
        "backgroundCommonPoolSize": "string",
        "defaultDatabase": "string",
        "totalMemoryProfilerStep": "string",
        "totalMemoryTrackerSampleProbability": "number",
        "queryMaskingRules": [
          {
            "name": "string",
            "regexp": "string",
            "replace": "string"
          }
        ],
        "dictionariesLazyLoad": "boolean",
        "queryCache": {
          "maxSizeInBytes": "string",
          "maxEntries": "string",
          "maxEntrySizeInBytes": "string",
          "maxEntrySizeInRows": "string"
        }
      },
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      }
    },
    "zookeeper": {
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      }
    },
    "backupWindowStart": {
      "hours": "integer",
      "minutes": "integer",
      "seconds": "integer",
      "nanos": "integer"
    },
    "access": {
      "dataLens": "boolean",
      "webSql": "boolean",
      "metrika": "boolean",
      "serverless": "boolean",
      "dataTransfer": "boolean",
      "yandexQuery": "boolean"
    },
    "cloudStorage": {
      "enabled": "boolean",
      "moveFactor": "number",
      "dataCacheEnabled": "boolean",
      "dataCacheMaxSize": "string",
      "preferNotToMerge": "boolean"
    },
    "sqlDatabaseManagement": "boolean",
    "sqlUserManagement": "boolean",
    "adminPassword": "string",
    "embeddedKeeper": "boolean",
    "backupRetainPeriodDays": "string"
  },
  "name": "string",
  "serviceAccountId": "string",
  "maintenanceWindow": {
    // Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
    "anytime": "object",
    "weeklyMaintenanceWindow": {
      "day": "string",
      "hour": "string"
    }
    // end of the list of possible fields
  },
  "securityGroupIds": [
    "string"
  ],
  "deletionProtection": "boolean",
  "networkId": "string"
}
```

#|
||Field | Description ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| description | **string**

New description of the ClickHouse cluster. ||
|| labels | **string**

Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource.
For example, "project": "mvp" or "source": "dictionary".

The new set of labels will completely replace the old ones. To add a label, request the current
set with the [ClusterService.Get](/docs/managed-clickhouse/api-ref/Cluster/get#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set. ||
|| configSpec | **[ConfigSpec](#yandex.cloud.mdb.clickhouse.v1.ConfigSpec)**

New configuration and resources for hosts in the cluster. ||
|| name | **string**

New name for the cluster. ||
|| serviceAccountId | **string**

ID of the service account used for access to Object Storage. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.clickhouse.v1.MaintenanceWindow)**

New maintenance window settings for the cluster. ||
|| securityGroupIds[] | **string**

User security groups ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the cluster ||
|| networkId | **string**

ID of the network to move the cluster to. ||
|#

## ConfigSpec {#yandex.cloud.mdb.clickhouse.v1.ConfigSpec}

#|
||Field | Description ||
|| version | **string**

Version of the ClickHouse server software. ||
|| clickhouse | **[Clickhouse](#yandex.cloud.mdb.clickhouse.v1.ConfigSpec.Clickhouse)**

Configuration and resources for a ClickHouse server. ||
|| zookeeper | **[Zookeeper](#yandex.cloud.mdb.clickhouse.v1.ConfigSpec.Zookeeper)**

Configuration and resources for a ZooKeeper server. ||
|| backupWindowStart | **[TimeOfDay](#google.type.TimeOfDay)**

Time to start the daily backup, in the UTC timezone. ||
|| access | **[Access](#yandex.cloud.mdb.clickhouse.v1.Access)**

Access policy for external services.

If you want a specific service to access the ClickHouse cluster, then set the necessary values in this policy. ||
|| cloudStorage | **[CloudStorage](#yandex.cloud.mdb.clickhouse.v1.CloudStorage)** ||
|| sqlDatabaseManagement | **boolean**

Whether database management through SQL commands is enabled. ||
|| sqlUserManagement | **boolean**

Whether user management through SQL commands is enabled. ||
|| adminPassword | **string**

Password for user 'admin' that has SQL user management access. ||
|| embeddedKeeper | **boolean**

Whether cluster should use embedded Keeper instead of Zookeeper ||
|| backupRetainPeriodDays | **string** (int64)

Retain period of automatically created backup in days ||
|#

## Clickhouse {#yandex.cloud.mdb.clickhouse.v1.ConfigSpec.Clickhouse}

#|
||Field | Description ||
|| config | **[ClickhouseConfig](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig)**

Configuration for a ClickHouse server. ||
|| resources | **[Resources](#yandex.cloud.mdb.clickhouse.v1.Resources)**

Resources allocated to ClickHouse hosts. ||
|#

## ClickhouseConfig {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig}

ClickHouse configuration options. Detailed description for each set of options
is available in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/).

Any options not listed here are not supported.

#|
||Field | Description ||
|| logLevel | **enum** (LogLevel)

Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.

- `LOG_LEVEL_UNSPECIFIED`
- `TRACE`
- `DEBUG`
- `INFORMATION`
- `WARNING`
- `ERROR` ||
|| mergeTree | **[MergeTree](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.MergeTree)**

Settings for the MergeTree engine.
See description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree). ||
|| compression[] | **[Compression](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Compression)**

Compression settings for the ClickHouse cluster.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#compression). ||
|| dictionaries[] | **[ExternalDictionary](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary)**

Configuration of external dictionaries to be used by the ClickHouse cluster.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts/). ||
|| graphiteRollup[] | **[GraphiteRollup](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup)**

Settings for thinning Graphite data.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup). ||
|| kafka | **[Kafka](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Kafka)** ||
|| kafkaTopics[] | **[KafkaTopic](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.KafkaTopic)** ||
|| rabbitmq | **[Rabbitmq](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Rabbitmq)** ||
|| maxConnections | **string** (int64)

Maximum number of inbound connections. ||
|| maxConcurrentQueries | **string** (int64)

Maximum number of simultaneously processed requests. ||
|| keepAliveTimeout | **string** (int64)

Number of milliseconds that ClickHouse waits for incoming requests before closing the connection. ||
|| uncompressedCacheSize | **string** (int64)

Cache size (in bytes) for uncompressed data used by MergeTree tables. ||
|| markCacheSize | **string** (int64)

Approximate size (in bytes) of the cache of "marks" used by MergeTree tables. ||
|| maxTableSizeToDrop | **string** (int64)

Maximum size of the table that can be deleted using a DROP query. ||
|| maxPartitionSizeToDrop | **string** (int64)

Maximum size of the partition that can be deleted using a DROP query. ||
|| builtinDictionariesReloadInterval | **string** (int64)

The setting is deprecated and has no effect. ||
|| timezone | **string**

The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. ||
|| geobaseEnabled | **boolean**

Enable or disable geobase. ||
|| geobaseUri | **string**

Address of the archive with the user geobase in Object Storage. ||
|| queryLogRetentionSize | **string** (int64)

The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of
query_log data based on size is disabled. ||
|| queryLogRetentionTime | **string** (int64)

The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of
query_log data based on time is disabled. ||
|| queryThreadLogEnabled | **boolean**

Whether query_thread_log system table is enabled. ||
|| queryThreadLogRetentionSize | **string** (int64)

The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of
query_thread_log data based on size is disabled. ||
|| queryThreadLogRetentionTime | **string** (int64)

The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of
query_thread_log data based on time is disabled. ||
|| partLogRetentionSize | **string** (int64)

The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of
part_log data based on size is disabled. ||
|| partLogRetentionTime | **string** (int64)

The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of
part_log data based on time is disabled. ||
|| metricLogEnabled | **boolean**

Whether metric_log system table is enabled. ||
|| metricLogRetentionSize | **string** (int64)

The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of
metric_log data based on size is disabled. ||
|| metricLogRetentionTime | **string** (int64)

The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of
metric_log data based on time is disabled. ||
|| traceLogEnabled | **boolean**

Whether trace_log system table is enabled. ||
|| traceLogRetentionSize | **string** (int64)

The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of
trace_log data based on size is disabled. ||
|| traceLogRetentionTime | **string** (int64)

The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of
trace_log data based on time is disabled. ||
|| textLogEnabled | **boolean**

Whether text_log system table is enabled. ||
|| textLogRetentionSize | **string** (int64)

The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of
text_log data based on size is disabled. ||
|| textLogRetentionTime | **string** (int64)

The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of
text_log data based on time is disabled. ||
|| textLogLevel | **enum** (LogLevel)

Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.

- `LOG_LEVEL_UNSPECIFIED`
- `TRACE`
- `DEBUG`
- `INFORMATION`
- `WARNING`
- `ERROR` ||
|| opentelemetrySpanLogEnabled | **boolean**

Enable or disable opentelemetry_span_log system table. Default value: false. ||
|| opentelemetrySpanLogRetentionSize | **string** (int64)

The maximum size that opentelemetry_span_log can grow to before old data will be removed. If set to 0 (default),
automatic removal of opentelemetry_span_log data based on size is disabled. ||
|| opentelemetrySpanLogRetentionTime | **string** (int64)

The maximum time that opentelemetry_span_log records will be retained before removal. If set to 0,
automatic removal of opentelemetry_span_log data based on time is disabled. ||
|| queryViewsLogEnabled | **boolean**

Enable or disable query_views_log system table. Default value: false. ||
|| queryViewsLogRetentionSize | **string** (int64)

The maximum size that query_views_log can grow to before old data will be removed. If set to 0 (default),
automatic removal of query_views_log data based on size is disabled. ||
|| queryViewsLogRetentionTime | **string** (int64)

The maximum time that query_views_log records will be retained before removal. If set to 0,
automatic removal of query_views_log data based on time is disabled. ||
|| asynchronousMetricLogEnabled | **boolean**

Enable or disable asynchronous_metric_log system table. Default value: false. ||
|| asynchronousMetricLogRetentionSize | **string** (int64)

The maximum size that asynchronous_metric_log can grow to before old data will be removed. If set to 0 (default),
automatic removal of asynchronous_metric_log data based on size is disabled. ||
|| asynchronousMetricLogRetentionTime | **string** (int64)

The maximum time that asynchronous_metric_log records will be retained before removal. If set to 0,
automatic removal of asynchronous_metric_log data based on time is disabled. ||
|| sessionLogEnabled | **boolean**

Enable or disable session_log system table. Default value: false. ||
|| sessionLogRetentionSize | **string** (int64)

The maximum size that session_log can grow to before old data will be removed. If set to 0 (default),
automatic removal of session_log data based on size is disabled. ||
|| sessionLogRetentionTime | **string** (int64)

The maximum time that session_log records will be retained before removal. If set to 0,
automatic removal of session_log data based on time is disabled. ||
|| zookeeperLogEnabled | **boolean**

Enable or disable zookeeper_log system table. Default value: false. ||
|| zookeeperLogRetentionSize | **string** (int64)

The maximum size that zookeeper_log can grow to before old data will be removed. If set to 0 (default),
automatic removal of zookeeper_log data based on size is disabled. ||
|| zookeeperLogRetentionTime | **string** (int64)

The maximum time that zookeeper_log records will be retained before removal. If set to 0,
automatic removal of zookeeper_log data based on time is disabled. ||
|| asynchronousInsertLogEnabled | **boolean**

Enable or disable asynchronous_insert_log system table. Default value: false.
Minimal required ClickHouse version: 22.10. ||
|| asynchronousInsertLogRetentionSize | **string** (int64)

The maximum size that asynchronous_insert_log can grow to before old data will be removed. If set to 0 (default),
automatic removal of asynchronous_insert_log data based on size is disabled. ||
|| asynchronousInsertLogRetentionTime | **string** (int64)

The maximum time that asynchronous_insert_log records will be retained before removal. If set to 0,
automatic removal of asynchronous_insert_log data based on time is disabled. ||
|| backgroundPoolSize | **string** (int64) ||
|| backgroundMergesMutationsConcurrencyRatio | **string** (int64)

Sets a ratio between the number of threads and the number of background merges and mutations that can be executed concurrently. For example, if the ratio equals to 2 and background_pool_size is set to 16 then ClickHouse can execute 32 background merges concurrently. This is possible, because background operations could be suspended and postponed. This is needed to give small merges more execution priority. You can only increase this ratio at runtime. To lower it you have to restart the server. The same as for background_pool_size setting background_merges_mutations_concurrency_ratio could be applied from the default profile for backward compatibility.
Default: 2
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#background_merges_mutations_concurrency_ratio) ||
|| backgroundSchedulePoolSize | **string** (int64) ||
|| backgroundFetchesPoolSize | **string** (int64)

Sets the number of threads performing background fetches for tables with **ReplicatedMergeTree** engines. Default value: 8.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size). ||
|| backgroundMovePoolSize | **string** (int64) ||
|| backgroundDistributedSchedulePoolSize | **string** (int64) ||
|| backgroundBufferFlushSchedulePoolSize | **string** (int64) ||
|| backgroundMessageBrokerSchedulePoolSize | **string** (int64) ||
|| backgroundCommonPoolSize | **string** (int64)

The maximum number of threads that will be used for performing a variety of operations (mostly garbage collection) for *MergeTree-engine tables in a background.
Default: 8
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#background_common_pool_size) ||
|| defaultDatabase | **string**

The default database.

To get a list of cluster databases, see [Yandex Managed ClickHouse documentation](/docs/managed-clickhouse/operations/databases#list-db). ||
|| totalMemoryProfilerStep | **string** (int64)

Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: **4194304**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step). ||
|| totalMemoryTrackerSampleProbability | **number** (double) ||
|| queryMaskingRules[] | **[QueryMaskingRule](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryMaskingRule)**

Regexp-based rules, which will be applied to queries as well as all log messages before storing them in server logs, system.query_log, system.text_log, system.processes tables, and in logs sent to the client. That allows preventing sensitive data leakage from SQL queries (like names, emails, personal identifiers or credit card numbers) to logs.
Change of these settings is applied with ClickHouse restart
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#query-masking-rules) ||
|| dictionariesLazyLoad | **boolean**

Lazy loading of dictionaries.
Default: true
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#dictionaries_lazy_load) ||
|| queryCache | **[QueryCache](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryCache)**

[Query cache](https://clickhouse.com/docs/en/operations/query-cache) configuration.
Min version: 23.5
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#query_cache) ||
|#

## MergeTree {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.MergeTree}

Options specific to the MergeTree table engine.

#|
||Field | Description ||
|| replicatedDeduplicationWindow | **string** (int64)

Number of blocks of hashes to keep in ZooKeeper. ||
|| replicatedDeduplicationWindowSeconds | **string** (int64)

Period of time to keep blocks of hashes for. ||
|| partsToDelayInsert | **string** (int64)

If table contains at least that many active parts in single partition, artificially slow down insert into table. ||
|| partsToThrowInsert | **string** (int64)

If more than this number active parts in single partition, throw 'Too many parts ...' exception. ||
|| inactivePartsToDelayInsert | **string** (int64) ||
|| inactivePartsToThrowInsert | **string** (int64) ||
|| maxReplicatedMergesInQueue | **string** (int64)

How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue. ||
|| numberOfFreeEntriesInPoolToLowerMaxSizeOfMerge | **string** (int64)

If there is less than specified number of free entries in background pool (or replicated queue), start to lower
maximum size of merge to process. ||
|| maxBytesToMergeAtMinSpaceInPool | **string** (int64)

Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries
in replication queue). ||
|| maxBytesToMergeAtMaxSpaceInPool | **string** (int64) ||
|| minBytesForWidePart | **string** (int64)

Minimum number of bytes in a data part that can be stored in **Wide** format.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). ||
|| minRowsForWidePart | **string** (int64)

Minimum number of rows in a data part that can be stored in **Wide** format.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). ||
|| ttlOnlyDropParts | **boolean**

Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts). ||
|| allowRemoteFsZeroCopyReplication | **boolean** ||
|| mergeWithTtlTimeout | **string** (int64) ||
|| mergeWithRecompressionTtlTimeout | **string** (int64) ||
|| maxPartsInTotal | **string** (int64) ||
|| maxNumberOfMergesWithTtlInPool | **string** (int64) ||
|| cleanupDelayPeriod | **string** (int64) ||
|| numberOfFreeEntriesInPoolToExecuteMutation | **string** (int64) ||
|| maxAvgPartSizeForTooManyParts | **string** (int64)

The 'too many parts' check according to 'parts_to_delay_insert' and 'parts_to_throw_insert' will be active only if the average part size (in the relevant partition) is not larger than the specified threshold. If it is larger than the specified threshold, the INSERTs will be neither delayed or rejected. This allows to have hundreds of terabytes in a single table on a single server if the parts are successfully merged to larger parts. This does not affect the thresholds on inactive parts or total parts.
Default: 1 GiB
Min version: 22.10
See in-depth description in [ClickHouse GitHub](https://github.com/ClickHouse/ClickHouse/blob/f9558345e886876b9132d9c018e357f7fa9b22a3/src/Storages/MergeTree/MergeTreeSettings.h#L80) ||
|| minAgeToForceMergeSeconds | **string** (int64)

Merge parts if every part in the range is older than the value of min_age_to_force_merge_seconds.
Default: 0 - disabled
Min_version: 22.10
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#min_age_to_force_merge_seconds) ||
|| minAgeToForceMergeOnPartitionOnly | **boolean**

Whether min_age_to_force_merge_seconds should be applied only on the entire partition and not on subset.
Default: false
Min_version: 22.11
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#min_age_to_force_merge_seconds) ||
|| mergeSelectingSleepMs | **string** (int64)

Sleep time for merge selecting when no part is selected. A lower setting triggers selecting tasks in background_schedule_pool frequently, which results in a large number of requests to ClickHouse Keeper in large-scale clusters.
Default: 5000
Min_version: 21.10
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#merge_selecting_sleep_ms) ||
|| mergeMaxBlockSize | **string** (int64)

The number of rows that are read from the merged parts into memory.
Default: 8192
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#merge_max_block_size) ||
|| checkSampleColumnIsCorrect | **boolean**

Enables the check at table creation, that the data type of a column for sampling or sampling expression is correct. The data type must be one of unsigned [integer types](https://clickhouse.com/docs/en/sql-reference/data-types/int-uint): UInt8, UInt16, UInt32, UInt64.
Default: true
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#check_sample_column_is_correct) ||
|| maxMergeSelectingSleepMs | **string** (int64)

Maximum sleep time for merge selecting, a lower setting will trigger selecting tasks in background_schedule_pool frequently which result in large amount of requests to zookeeper in large-scale clusters.
Default: 60000
Min_version: 23.6
See in-depth description in [ClickHouse GitHub](https://github.com/ClickHouse/ClickHouse/blob/4add9db84859bff7410cf934a3904b0414e36e51/src/Storages/MergeTree/MergeTreeSettings.h#L71) ||
|| maxCleanupDelayPeriod | **string** (int64)

Maximum period to clean old queue logs, blocks hashes and parts.
Default: 300
Min_version: 23.6
See in-depth description in [ClickHouse GitHub](https://github.com/ClickHouse/ClickHouse/blob/4add9db84859bff7410cf934a3904b0414e36e51/src/Storages/MergeTree/MergeTreeSettings.h#L142) ||
|#

## Compression {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Compression}

#|
||Field | Description ||
|| method | **enum** (Method)

Compression method to use for the specified combination of `minPartSize` and `minPartSizeRatio`.

- `METHOD_UNSPECIFIED`
- `LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4/).
- `ZSTD`: [Zstandard compression algorithm](https://facebook.github.io/zstd/). ||
|| minPartSize | **string** (int64)

Minimum size of a part of a table. ||
|| minPartSizeRatio | **string**

Minimum ratio of a part relative to the size of all the data in the table. ||
|| level | **string** (int64) ||
|#

## ExternalDictionary {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the external dictionary. ||
|| structure | **[Structure](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure)**

Required field. Set of attributes for the external dictionary.
For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/). ||
|| layout | **[Layout](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Layout)**

Required field. Layout for storing the dictionary in memory.
For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/). ||
|| fixedLifetime | **string** (int64)

Fixed interval between dictionary updates.

Includes only one of the fields `fixedLifetime`, `lifetimeRange`.

Setting for the period of time between dictionary updates.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). ||
|| lifetimeRange | **[Range](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Range)**

Range of intervals between dictionary updates for ClickHouse to choose from.

Includes only one of the fields `fixedLifetime`, `lifetimeRange`.

Setting for the period of time between dictionary updates.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). ||
|| httpSource | **[HttpSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource)**

HTTP source for the dictionary.

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`.

Description of the source for the external dictionary. ||
|| mysqlSource | **[MysqlSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource)**

MySQL source for the dictionary.

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`.

Description of the source for the external dictionary. ||
|| clickhouseSource | **[ClickhouseSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.ClickhouseSource)**

ClickHouse source for the dictionary.

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`.

Description of the source for the external dictionary. ||
|| mongodbSource | **[MongodbSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MongodbSource)**

MongoDB source for the dictionary.

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`.

Description of the source for the external dictionary. ||
|| postgresqlSource | **[PostgresqlSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.PostgresqlSource)**

PostgreSQL source for the dictionary.

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`.

Description of the source for the external dictionary. ||
|#

## Structure {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure}

#|
||Field | Description ||
|| id | **[Id](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Id)**

Single numeric key column for the dictionary. ||
|| key | **[Key](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Key)**

Composite key for the dictionary, containing of one or more key columns.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). ||
|| rangeMin | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**

Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). ||
|| rangeMax | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**

Field holding the end of the range for dictionaries with `RANGE_HASHED` layout.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). ||
|| attributes[] | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**

Description of the fields available for database queries.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes). ||
|#

## Id {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Id}

Numeric key.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the numeric key. ||
|#

## Key {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Key}

Complex key.

#|
||Field | Description ||
|| attributes[] | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**

Attributes of a complex key. ||
|#

## Attribute {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the column. ||
|| type | **string**

Required field. Type of the column. ||
|| nullValue | **string**

Default value for an element without data (for example, an empty string). ||
|| expression | **string**

Expression, describing the attribute, if applicable. ||
|| hierarchical | **boolean**

Indication of hierarchy support.
Default value: `false`. ||
|| injective | **boolean**

Indication of injective mapping "id -> attribute".
Default value: `false`. ||
|#

## Layout {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Layout}

Layout determining how to store the dictionary in memory.

#|
||Field | Description ||
|| type | **enum** (Type)

Required field. Layout type for an external dictionary.

- `TYPE_UNSPECIFIED`
- `FLAT`: The entire dictionary is stored in memory in the form of flat arrays.
Available for all dictionary sources.
- `HASHED`: The entire dictionary is stored in memory in the form of a hash table.
Available for all dictionary sources.
- `COMPLEX_KEY_HASHED`: Similar to HASHED, to be used with composite keys.
Available for all dictionary sources.
- `RANGE_HASHED`: The entire dictionary is stored in memory in the form of a hash table,
with an ordered array of ranges and their corresponding values.
Available for all dictionary sources.
- `CACHE`: The dictionary is stored in a cache with a set number of cells.
Available for MySQL, ClickHouse and HTTP dictionary sources.
- `COMPLEX_KEY_CACHE`: Similar to CACHE, to be used with composite keys.
Available for MySQL, ClickHouse and HTTP dictionary sources. ||
|| sizeInCells | **string** (int64)

Number of cells in the cache. Rounded up to a power of two.
Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. ||
|| maxArraySize | **string** (int64)

Maximum dictionary key size.
Applicable only for FLAT layout type. ||
|#

## Range {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Range}

#|
||Field | Description ||
|| min | **string** (int64)

Minimum dictionary lifetime. ||
|| max | **string** (int64)

Maximum dictionary lifetime. ||
|#

## HttpSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource}

#|
||Field | Description ||
|| url | **string**

Required field. URL of the source dictionary available over HTTP. ||
|| format | **string**

Required field. The data format. Valid values are all formats supported by ClickHouse SQL dialect. ||
|| headers[] | **[Header](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource.Header)**

HTTP headers. ||
|#

## Header {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource.Header}

#|
||Field | Description ||
|| name | **string**

Required field.  ||
|| value | **string**

Required field.  ||
|#

## MysqlSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource}

#|
||Field | Description ||
|| db | **string**

Required field. Name of the MySQL database to connect to. ||
|| table | **string**

Required field. Name of the database table to use as a ClickHouse dictionary. ||
|| port | **string** (int64)

Default port to use when connecting to a replica of the dictionary source. ||
|| user | **string**

Name of the default user for replicas of the dictionary source. ||
|| password | **string**

Password of the default user for replicas of the dictionary source. ||
|| replicas[] | **[Replica](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource.Replica)**

List of MySQL replicas of the database used as dictionary source. ||
|| where | **string**

Selection criteria for the data in the specified MySQL table. ||
|| invalidateQuery | **string**

Query for checking the dictionary status, to pull only updated data.
For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). ||
|| closeConnection | **boolean**

Should the connection be closed after each request. ||
|| shareConnection | **boolean**

Should a connection be shared for some requests. ||
|#

## Replica {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource.Replica}

#|
||Field | Description ||
|| host | **string**

Required field. MySQL host of the replica. ||
|| priority | **string** (int64)

Required field. The priority of the replica that ClickHouse takes into account when connecting.
Replica with the highest priority should have this field set to the lowest number. ||
|| port | **string** (int64)

Port to use when connecting to the replica.
If a port is not specified for a replica, ClickHouse uses the port specified for the source. ||
|| user | **string**

Name of the MySQL database user. ||
|| password | **string**

Password of the MySQL database user. ||
|#

## ClickhouseSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.ClickhouseSource}

#|
||Field | Description ||
|| db | **string**

Required field. Name of the ClickHouse database. ||
|| table | **string**

Required field. Name of the table in the specified database to be used as the dictionary source. ||
|| host | **string**

ClickHouse host of the specified database. ||
|| port | **string** (int64)

Port to use when connecting to the host. ||
|| user | **string**

Required field. Name of the ClickHouse database user. ||
|| password | **string**

Password of the ClickHouse database user. ||
|| where | **string**

Selection criteria for the data in the specified ClickHouse table. ||
|| secure | **boolean**

Use ssl for connection. ||
|#

## MongodbSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MongodbSource}

#|
||Field | Description ||
|| db | **string**

Required field. Name of the MongoDB database. ||
|| collection | **string**

Required field. Name of the collection in the specified database to be used as the dictionary source. ||
|| host | **string**

MongoDB host of the specified database. ||
|| port | **string** (int64)

Port to use when connecting to the host. ||
|| user | **string**

Required field. Name of the MongoDB database user. ||
|| password | **string**

Password of the MongoDB database user. ||
|| options | **string** ||
|#

## PostgresqlSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.PostgresqlSource}

#|
||Field | Description ||
|| db | **string**

Required field. Name of the PostrgreSQL database. ||
|| table | **string**

Required field. Name of the table in the specified database to be used as the dictionary source. ||
|| hosts[] | **string**

Name of the PostrgreSQL host ||
|| port | **string** (int64)

Port to use when connecting to the host. ||
|| user | **string**

Required field. Name of the PostrgreSQL database user. ||
|| password | **string**

Password of the PostrgreSQL database user. ||
|| invalidateQuery | **string**

Query for checking the dictionary status, to pull only updated data.
For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). ||
|| sslMode | **enum** (SslMode)

Mode of SSL TCP/IP connection to the PostgreSQL host.
For more details, see [PostgreSQL documentation](https://www.postgresql.org/docs/current/libpq-ssl.html).

- `SSL_MODE_UNSPECIFIED`
- `DISABLE`: Only try a non-SSL connection.
- `ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.
- `PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.
- `VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).
- `VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate. ||
|#

## GraphiteRollup {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup}

Rollup settings for the GraphiteMergeTree table engine.

#|
||Field | Description ||
|| name | **string**

Required field. Name for the specified combination of settings for Graphite rollup. ||
|| patterns[] | **[Pattern](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern)**

Pattern to use for the rollup. ||
|| pathColumnName | **string**

The name of the column storing the metric name (Graphite sensor).
Default: Path
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/graphitemergetree#required-columns) ||
|| timeColumnName | **string**

The name of the column storing the time of measuring the metric.
Default: Time
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/graphitemergetree#required-columns) ||
|| valueColumnName | **string**

The name of the column storing the value of the metric at the time set in time_column_name.
Default: Value
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/graphitemergetree#required-columns) ||
|| versionColumnName | **string**

The name of the column storing the version of the metric.
Default: Timestamp
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/graphitemergetree#required-columns) ||
|#

## Pattern {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern}

#|
||Field | Description ||
|| regexp | **string**

Pattern for metric names. ||
|| function | **string**

Required field. Name of the aggregating function to apply to data of the age specified in `retention`. ||
|| retention[] | **[Retention](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern.Retention)**

Age of data to use for thinning. ||
|#

## Retention {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern.Retention}

#|
||Field | Description ||
|| age | **string** (int64)

Minimum age of the data in seconds. ||
|| precision | **string** (int64)

Precision of determining the age of the data, in seconds. ||
|#

## Kafka {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Kafka}

#|
||Field | Description ||
|| securityProtocol | **enum** (SecurityProtocol)

- `SECURITY_PROTOCOL_UNSPECIFIED`
- `SECURITY_PROTOCOL_PLAINTEXT`
- `SECURITY_PROTOCOL_SSL`
- `SECURITY_PROTOCOL_SASL_PLAINTEXT`
- `SECURITY_PROTOCOL_SASL_SSL` ||
|| saslMechanism | **enum** (SaslMechanism)

- `SASL_MECHANISM_UNSPECIFIED`
- `SASL_MECHANISM_GSSAPI`
- `SASL_MECHANISM_PLAIN`
- `SASL_MECHANISM_SCRAM_SHA_256`
- `SASL_MECHANISM_SCRAM_SHA_512` ||
|| saslUsername | **string** ||
|| saslPassword | **string** ||
|| enableSslCertificateVerification | **boolean** ||
|| maxPollIntervalMs | **string** (int64) ||
|| sessionTimeoutMs | **string** (int64) ||
|| debug | **enum** (Debug)

- `DEBUG_UNSPECIFIED`
- `DEBUG_GENERIC`
- `DEBUG_BROKER`
- `DEBUG_TOPIC`
- `DEBUG_METADATA`
- `DEBUG_FEATURE`
- `DEBUG_QUEUE`
- `DEBUG_MSG`
- `DEBUG_PROTOCOL`
- `DEBUG_CGRP`
- `DEBUG_SECURITY`
- `DEBUG_FETCH`
- `DEBUG_INTERCEPTOR`
- `DEBUG_PLUGIN`
- `DEBUG_CONSUMER`
- `DEBUG_ADMIN`
- `DEBUG_EOS`
- `DEBUG_MOCK`
- `DEBUG_ASSIGNOR`
- `DEBUG_CONF`
- `DEBUG_TELEMETRY`
- `DEBUG_ALL` ||
|| autoOffsetReset | **enum** (AutoOffsetReset)

- `AUTO_OFFSET_RESET_UNSPECIFIED`
- `AUTO_OFFSET_RESET_SMALLEST`
- `AUTO_OFFSET_RESET_EARLIEST`
- `AUTO_OFFSET_RESET_BEGINNING`
- `AUTO_OFFSET_RESET_LARGEST`
- `AUTO_OFFSET_RESET_LATEST`
- `AUTO_OFFSET_RESET_END`
- `AUTO_OFFSET_RESET_ERROR` ||
|#

## KafkaTopic {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.KafkaTopic}

#|
||Field | Description ||
|| name | **string**

Required field.  ||
|| settings | **[Kafka](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Kafka)**

Required field.  ||
|#

## Rabbitmq {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Rabbitmq}

#|
||Field | Description ||
|| username | **string**

[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) username ||
|| password | **string**

[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) password ||
|| vhost | **string**

[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) virtual host ||
|#

## QueryMaskingRule {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryMaskingRule}

#|
||Field | Description ||
|| name | **string**

Name for the rule. ||
|| regexp | **string**

Required field. RE2 compatible regular expression.
Required. ||
|| replace | **string**

Substitution string for sensitive data.
Default: six asterisks ||
|#

## QueryCache {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryCache}

#|
||Field | Description ||
|| maxSizeInBytes | **string** (int64)

The maximum cache size in bytes.
Default: 1073741824 (1 GiB) ||
|| maxEntries | **string** (int64)

The maximum number of SELECT query results stored in the cache.
Default: 1024 ||
|| maxEntrySizeInBytes | **string** (int64)

The maximum size in bytes SELECT query results may have to be saved in the cache.
Dafault: 1048576 (1 MiB) ||
|| maxEntrySizeInRows | **string** (int64)

The maximum number of rows SELECT query results may have to be saved in the cache.
Default: 30000000 (30 mil) ||
|#

## Resources {#yandex.cloud.mdb.clickhouse.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/managed-clickhouse/concepts/instance-types) ||
|| diskSize | **string** (int64)

Volume of the storage available to a host, in bytes. ||
|| diskTypeId | **string**

Type of the storage environment for the host.
Possible values:
* network-hdd - network HDD drive,
* network-ssd - network SSD drive,
* local-ssd - local SSD storage. ||
|#

## Zookeeper {#yandex.cloud.mdb.clickhouse.v1.ConfigSpec.Zookeeper}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.clickhouse.v1.Resources)**

Resources allocated to ZooKeeper hosts. If not set, minimal available resources will be used.
All available resource presets can be retrieved with a [ResourcePresetService.List](/docs/managed-clickhouse/api-ref/ResourcePreset/list#List) request. ||
|#

## TimeOfDay {#google.type.TimeOfDay}

Represents a time of day. The date and time zone are either not significant
or are specified elsewhere. An API may choose to allow leap seconds. Related
types are [google.type.Date](https://github.com/googleapis/googleapis/blob/master/google/type/date.proto) and [google.protobuf.Timestamp](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto).

#|
||Field | Description ||
|| hours | **integer** (int32)

Hours of day in 24 hour format. Should be from 0 to 23. An API may choose
to allow the value "24:00:00" for scenarios like business closing time. ||
|| minutes | **integer** (int32)

Minutes of hour of day. Must be from 0 to 59. ||
|| seconds | **integer** (int32)

Seconds of minutes of the time. Must normally be from 0 to 59. An API may
allow the value 60 if it allows leap-seconds. ||
|| nanos | **integer** (int32)

Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999. ||
|#

## Access {#yandex.cloud.mdb.clickhouse.v1.Access}

#|
||Field | Description ||
|| dataLens | **boolean**

Allow to export data from the cluster to DataLens. ||
|| webSql | **boolean**

Allow SQL queries to the cluster databases from the management console.

See [SQL queries in the management console](/docs/managed-clickhouse/operations/web-sql-query) for more details. ||
|| metrika | **boolean**

Allow to import data from Yandex Metrica and AppMetrica to the cluster.

See [AppMetrica documentation](https://appmetrica.yandex.com/docs/cloud/index.html) for more details. ||
|| serverless | **boolean**

Allow access to cluster for Serverless. ||
|| dataTransfer | **boolean**

Allow access for DataTransfer ||
|| yandexQuery | **boolean**

Allow access for Query ||
|#

## CloudStorage {#yandex.cloud.mdb.clickhouse.v1.CloudStorage}

#|
||Field | Description ||
|| enabled | **boolean**

Whether to use Object Storage for storing ClickHouse data. ||
|| moveFactor | **number** (double) ||
|| dataCacheEnabled | **boolean** ||
|| dataCacheMaxSize | **string** (int64) ||
|| preferNotToMerge | **boolean** ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.clickhouse.v1.MaintenanceWindow}

A maintenance window settings.

#|
||Field | Description ||
|| anytime | **object**

Maintenance operation can be scheduled anytime.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.

The maintenance policy in effect. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.clickhouse.v1.WeeklyMaintenanceWindow)**

Maintenance operation can be scheduled on a weekly basis.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.

The maintenance policy in effect. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.clickhouse.v1.WeeklyMaintenanceWindow}

Weelky maintenance window settings.

#|
||Field | Description ||
|| day | **enum** (WeekDay)

Day of the week (in `DDD` format).

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **string** (int64)

Hour of the day in UTC (in `HH` format). ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "clusterId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "string",
    "environment": "string",
    "monitoring": [
      {
        "name": "string",
        "description": "string",
        "link": "string"
      }
    ],
    "config": {
      "version": "string",
      "clickhouse": {
        "config": {
          "effectiveConfig": {
            "logLevel": "string",
            "mergeTree": {
              "replicatedDeduplicationWindow": "string",
              "replicatedDeduplicationWindowSeconds": "string",
              "partsToDelayInsert": "string",
              "partsToThrowInsert": "string",
              "inactivePartsToDelayInsert": "string",
              "inactivePartsToThrowInsert": "string",
              "maxReplicatedMergesInQueue": "string",
              "numberOfFreeEntriesInPoolToLowerMaxSizeOfMerge": "string",
              "maxBytesToMergeAtMinSpaceInPool": "string",
              "maxBytesToMergeAtMaxSpaceInPool": "string",
              "minBytesForWidePart": "string",
              "minRowsForWidePart": "string",
              "ttlOnlyDropParts": "boolean",
              "allowRemoteFsZeroCopyReplication": "boolean",
              "mergeWithTtlTimeout": "string",
              "mergeWithRecompressionTtlTimeout": "string",
              "maxPartsInTotal": "string",
              "maxNumberOfMergesWithTtlInPool": "string",
              "cleanupDelayPeriod": "string",
              "numberOfFreeEntriesInPoolToExecuteMutation": "string",
              "maxAvgPartSizeForTooManyParts": "string",
              "minAgeToForceMergeSeconds": "string",
              "minAgeToForceMergeOnPartitionOnly": "boolean",
              "mergeSelectingSleepMs": "string",
              "mergeMaxBlockSize": "string",
              "checkSampleColumnIsCorrect": "boolean",
              "maxMergeSelectingSleepMs": "string",
              "maxCleanupDelayPeriod": "string"
            },
            "compression": [
              {
                "method": "string",
                "minPartSize": "string",
                "minPartSizeRatio": "string",
                "level": "string"
              }
            ],
            "dictionaries": [
              {
                "name": "string",
                "structure": {
                  "id": {
                    "name": "string"
                  },
                  "key": {
                    "attributes": [
                      {
                        "name": "string",
                        "type": "string",
                        "nullValue": "string",
                        "expression": "string",
                        "hierarchical": "boolean",
                        "injective": "boolean"
                      }
                    ]
                  },
                  "rangeMin": {
                    "name": "string",
                    "type": "string",
                    "nullValue": "string",
                    "expression": "string",
                    "hierarchical": "boolean",
                    "injective": "boolean"
                  },
                  "rangeMax": {
                    "name": "string",
                    "type": "string",
                    "nullValue": "string",
                    "expression": "string",
                    "hierarchical": "boolean",
                    "injective": "boolean"
                  },
                  "attributes": [
                    {
                      "name": "string",
                      "type": "string",
                      "nullValue": "string",
                      "expression": "string",
                      "hierarchical": "boolean",
                      "injective": "boolean"
                    }
                  ]
                },
                "layout": {
                  "type": "string",
                  "sizeInCells": "string",
                  "maxArraySize": "string"
                },
                // Includes only one of the fields `fixedLifetime`, `lifetimeRange`
                "fixedLifetime": "string",
                "lifetimeRange": {
                  "min": "string",
                  "max": "string"
                },
                // end of the list of possible fields
                // Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`
                "httpSource": {
                  "url": "string",
                  "format": "string",
                  "headers": [
                    {
                      "name": "string",
                      "value": "string"
                    }
                  ]
                },
                "mysqlSource": {
                  "db": "string",
                  "table": "string",
                  "port": "string",
                  "user": "string",
                  "password": "string",
                  "replicas": [
                    {
                      "host": "string",
                      "priority": "string",
                      "port": "string",
                      "user": "string",
                      "password": "string"
                    }
                  ],
                  "where": "string",
                  "invalidateQuery": "string",
                  "closeConnection": "boolean",
                  "shareConnection": "boolean"
                },
                "clickhouseSource": {
                  "db": "string",
                  "table": "string",
                  "host": "string",
                  "port": "string",
                  "user": "string",
                  "password": "string",
                  "where": "string",
                  "secure": "boolean"
                },
                "mongodbSource": {
                  "db": "string",
                  "collection": "string",
                  "host": "string",
                  "port": "string",
                  "user": "string",
                  "password": "string",
                  "options": "string"
                },
                "postgresqlSource": {
                  "db": "string",
                  "table": "string",
                  "hosts": [
                    "string"
                  ],
                  "port": "string",
                  "user": "string",
                  "password": "string",
                  "invalidateQuery": "string",
                  "sslMode": "string"
                }
                // end of the list of possible fields
              }
            ],
            "graphiteRollup": [
              {
                "name": "string",
                "patterns": [
                  {
                    "regexp": "string",
                    "function": "string",
                    "retention": [
                      {
                        "age": "string",
                        "precision": "string"
                      }
                    ]
                  }
                ],
                "pathColumnName": "string",
                "timeColumnName": "string",
                "valueColumnName": "string",
                "versionColumnName": "string"
              }
            ],
            "kafka": {
              "securityProtocol": "string",
              "saslMechanism": "string",
              "saslUsername": "string",
              "saslPassword": "string",
              "enableSslCertificateVerification": "boolean",
              "maxPollIntervalMs": "string",
              "sessionTimeoutMs": "string",
              "debug": "string",
              "autoOffsetReset": "string"
            },
            "kafkaTopics": [
              {
                "name": "string",
                "settings": {
                  "securityProtocol": "string",
                  "saslMechanism": "string",
                  "saslUsername": "string",
                  "saslPassword": "string",
                  "enableSslCertificateVerification": "boolean",
                  "maxPollIntervalMs": "string",
                  "sessionTimeoutMs": "string",
                  "debug": "string",
                  "autoOffsetReset": "string"
                }
              }
            ],
            "rabbitmq": {
              "username": "string",
              "password": "string",
              "vhost": "string"
            },
            "maxConnections": "string",
            "maxConcurrentQueries": "string",
            "keepAliveTimeout": "string",
            "uncompressedCacheSize": "string",
            "markCacheSize": "string",
            "maxTableSizeToDrop": "string",
            "maxPartitionSizeToDrop": "string",
            "builtinDictionariesReloadInterval": "string",
            "timezone": "string",
            "geobaseEnabled": "boolean",
            "geobaseUri": "string",
            "queryLogRetentionSize": "string",
            "queryLogRetentionTime": "string",
            "queryThreadLogEnabled": "boolean",
            "queryThreadLogRetentionSize": "string",
            "queryThreadLogRetentionTime": "string",
            "partLogRetentionSize": "string",
            "partLogRetentionTime": "string",
            "metricLogEnabled": "boolean",
            "metricLogRetentionSize": "string",
            "metricLogRetentionTime": "string",
            "traceLogEnabled": "boolean",
            "traceLogRetentionSize": "string",
            "traceLogRetentionTime": "string",
            "textLogEnabled": "boolean",
            "textLogRetentionSize": "string",
            "textLogRetentionTime": "string",
            "textLogLevel": "string",
            "opentelemetrySpanLogEnabled": "boolean",
            "opentelemetrySpanLogRetentionSize": "string",
            "opentelemetrySpanLogRetentionTime": "string",
            "queryViewsLogEnabled": "boolean",
            "queryViewsLogRetentionSize": "string",
            "queryViewsLogRetentionTime": "string",
            "asynchronousMetricLogEnabled": "boolean",
            "asynchronousMetricLogRetentionSize": "string",
            "asynchronousMetricLogRetentionTime": "string",
            "sessionLogEnabled": "boolean",
            "sessionLogRetentionSize": "string",
            "sessionLogRetentionTime": "string",
            "zookeeperLogEnabled": "boolean",
            "zookeeperLogRetentionSize": "string",
            "zookeeperLogRetentionTime": "string",
            "asynchronousInsertLogEnabled": "boolean",
            "asynchronousInsertLogRetentionSize": "string",
            "asynchronousInsertLogRetentionTime": "string",
            "backgroundPoolSize": "string",
            "backgroundMergesMutationsConcurrencyRatio": "string",
            "backgroundSchedulePoolSize": "string",
            "backgroundFetchesPoolSize": "string",
            "backgroundMovePoolSize": "string",
            "backgroundDistributedSchedulePoolSize": "string",
            "backgroundBufferFlushSchedulePoolSize": "string",
            "backgroundMessageBrokerSchedulePoolSize": "string",
            "backgroundCommonPoolSize": "string",
            "defaultDatabase": "string",
            "totalMemoryProfilerStep": "string",
            "totalMemoryTrackerSampleProbability": "number",
            "queryMaskingRules": [
              {
                "name": "string",
                "regexp": "string",
                "replace": "string"
              }
            ],
            "dictionariesLazyLoad": "boolean",
            "queryCache": {
              "maxSizeInBytes": "string",
              "maxEntries": "string",
              "maxEntrySizeInBytes": "string",
              "maxEntrySizeInRows": "string"
            }
          },
          "userConfig": {
            "logLevel": "string",
            "mergeTree": {
              "replicatedDeduplicationWindow": "string",
              "replicatedDeduplicationWindowSeconds": "string",
              "partsToDelayInsert": "string",
              "partsToThrowInsert": "string",
              "inactivePartsToDelayInsert": "string",
              "inactivePartsToThrowInsert": "string",
              "maxReplicatedMergesInQueue": "string",
              "numberOfFreeEntriesInPoolToLowerMaxSizeOfMerge": "string",
              "maxBytesToMergeAtMinSpaceInPool": "string",
              "maxBytesToMergeAtMaxSpaceInPool": "string",
              "minBytesForWidePart": "string",
              "minRowsForWidePart": "string",
              "ttlOnlyDropParts": "boolean",
              "allowRemoteFsZeroCopyReplication": "boolean",
              "mergeWithTtlTimeout": "string",
              "mergeWithRecompressionTtlTimeout": "string",
              "maxPartsInTotal": "string",
              "maxNumberOfMergesWithTtlInPool": "string",
              "cleanupDelayPeriod": "string",
              "numberOfFreeEntriesInPoolToExecuteMutation": "string",
              "maxAvgPartSizeForTooManyParts": "string",
              "minAgeToForceMergeSeconds": "string",
              "minAgeToForceMergeOnPartitionOnly": "boolean",
              "mergeSelectingSleepMs": "string",
              "mergeMaxBlockSize": "string",
              "checkSampleColumnIsCorrect": "boolean",
              "maxMergeSelectingSleepMs": "string",
              "maxCleanupDelayPeriod": "string"
            },
            "compression": [
              {
                "method": "string",
                "minPartSize": "string",
                "minPartSizeRatio": "string",
                "level": "string"
              }
            ],
            "dictionaries": [
              {
                "name": "string",
                "structure": {
                  "id": {
                    "name": "string"
                  },
                  "key": {
                    "attributes": [
                      {
                        "name": "string",
                        "type": "string",
                        "nullValue": "string",
                        "expression": "string",
                        "hierarchical": "boolean",
                        "injective": "boolean"
                      }
                    ]
                  },
                  "rangeMin": {
                    "name": "string",
                    "type": "string",
                    "nullValue": "string",
                    "expression": "string",
                    "hierarchical": "boolean",
                    "injective": "boolean"
                  },
                  "rangeMax": {
                    "name": "string",
                    "type": "string",
                    "nullValue": "string",
                    "expression": "string",
                    "hierarchical": "boolean",
                    "injective": "boolean"
                  },
                  "attributes": [
                    {
                      "name": "string",
                      "type": "string",
                      "nullValue": "string",
                      "expression": "string",
                      "hierarchical": "boolean",
                      "injective": "boolean"
                    }
                  ]
                },
                "layout": {
                  "type": "string",
                  "sizeInCells": "string",
                  "maxArraySize": "string"
                },
                // Includes only one of the fields `fixedLifetime`, `lifetimeRange`
                "fixedLifetime": "string",
                "lifetimeRange": {
                  "min": "string",
                  "max": "string"
                },
                // end of the list of possible fields
                // Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`
                "httpSource": {
                  "url": "string",
                  "format": "string",
                  "headers": [
                    {
                      "name": "string",
                      "value": "string"
                    }
                  ]
                },
                "mysqlSource": {
                  "db": "string",
                  "table": "string",
                  "port": "string",
                  "user": "string",
                  "password": "string",
                  "replicas": [
                    {
                      "host": "string",
                      "priority": "string",
                      "port": "string",
                      "user": "string",
                      "password": "string"
                    }
                  ],
                  "where": "string",
                  "invalidateQuery": "string",
                  "closeConnection": "boolean",
                  "shareConnection": "boolean"
                },
                "clickhouseSource": {
                  "db": "string",
                  "table": "string",
                  "host": "string",
                  "port": "string",
                  "user": "string",
                  "password": "string",
                  "where": "string",
                  "secure": "boolean"
                },
                "mongodbSource": {
                  "db": "string",
                  "collection": "string",
                  "host": "string",
                  "port": "string",
                  "user": "string",
                  "password": "string",
                  "options": "string"
                },
                "postgresqlSource": {
                  "db": "string",
                  "table": "string",
                  "hosts": [
                    "string"
                  ],
                  "port": "string",
                  "user": "string",
                  "password": "string",
                  "invalidateQuery": "string",
                  "sslMode": "string"
                }
                // end of the list of possible fields
              }
            ],
            "graphiteRollup": [
              {
                "name": "string",
                "patterns": [
                  {
                    "regexp": "string",
                    "function": "string",
                    "retention": [
                      {
                        "age": "string",
                        "precision": "string"
                      }
                    ]
                  }
                ],
                "pathColumnName": "string",
                "timeColumnName": "string",
                "valueColumnName": "string",
                "versionColumnName": "string"
              }
            ],
            "kafka": {
              "securityProtocol": "string",
              "saslMechanism": "string",
              "saslUsername": "string",
              "saslPassword": "string",
              "enableSslCertificateVerification": "boolean",
              "maxPollIntervalMs": "string",
              "sessionTimeoutMs": "string",
              "debug": "string",
              "autoOffsetReset": "string"
            },
            "kafkaTopics": [
              {
                "name": "string",
                "settings": {
                  "securityProtocol": "string",
                  "saslMechanism": "string",
                  "saslUsername": "string",
                  "saslPassword": "string",
                  "enableSslCertificateVerification": "boolean",
                  "maxPollIntervalMs": "string",
                  "sessionTimeoutMs": "string",
                  "debug": "string",
                  "autoOffsetReset": "string"
                }
              }
            ],
            "rabbitmq": {
              "username": "string",
              "password": "string",
              "vhost": "string"
            },
            "maxConnections": "string",
            "maxConcurrentQueries": "string",
            "keepAliveTimeout": "string",
            "uncompressedCacheSize": "string",
            "markCacheSize": "string",
            "maxTableSizeToDrop": "string",
            "maxPartitionSizeToDrop": "string",
            "builtinDictionariesReloadInterval": "string",
            "timezone": "string",
            "geobaseEnabled": "boolean",
            "geobaseUri": "string",
            "queryLogRetentionSize": "string",
            "queryLogRetentionTime": "string",
            "queryThreadLogEnabled": "boolean",
            "queryThreadLogRetentionSize": "string",
            "queryThreadLogRetentionTime": "string",
            "partLogRetentionSize": "string",
            "partLogRetentionTime": "string",
            "metricLogEnabled": "boolean",
            "metricLogRetentionSize": "string",
            "metricLogRetentionTime": "string",
            "traceLogEnabled": "boolean",
            "traceLogRetentionSize": "string",
            "traceLogRetentionTime": "string",
            "textLogEnabled": "boolean",
            "textLogRetentionSize": "string",
            "textLogRetentionTime": "string",
            "textLogLevel": "string",
            "opentelemetrySpanLogEnabled": "boolean",
            "opentelemetrySpanLogRetentionSize": "string",
            "opentelemetrySpanLogRetentionTime": "string",
            "queryViewsLogEnabled": "boolean",
            "queryViewsLogRetentionSize": "string",
            "queryViewsLogRetentionTime": "string",
            "asynchronousMetricLogEnabled": "boolean",
            "asynchronousMetricLogRetentionSize": "string",
            "asynchronousMetricLogRetentionTime": "string",
            "sessionLogEnabled": "boolean",
            "sessionLogRetentionSize": "string",
            "sessionLogRetentionTime": "string",
            "zookeeperLogEnabled": "boolean",
            "zookeeperLogRetentionSize": "string",
            "zookeeperLogRetentionTime": "string",
            "asynchronousInsertLogEnabled": "boolean",
            "asynchronousInsertLogRetentionSize": "string",
            "asynchronousInsertLogRetentionTime": "string",
            "backgroundPoolSize": "string",
            "backgroundMergesMutationsConcurrencyRatio": "string",
            "backgroundSchedulePoolSize": "string",
            "backgroundFetchesPoolSize": "string",
            "backgroundMovePoolSize": "string",
            "backgroundDistributedSchedulePoolSize": "string",
            "backgroundBufferFlushSchedulePoolSize": "string",
            "backgroundMessageBrokerSchedulePoolSize": "string",
            "backgroundCommonPoolSize": "string",
            "defaultDatabase": "string",
            "totalMemoryProfilerStep": "string",
            "totalMemoryTrackerSampleProbability": "number",
            "queryMaskingRules": [
              {
                "name": "string",
                "regexp": "string",
                "replace": "string"
              }
            ],
            "dictionariesLazyLoad": "boolean",
            "queryCache": {
              "maxSizeInBytes": "string",
              "maxEntries": "string",
              "maxEntrySizeInBytes": "string",
              "maxEntrySizeInRows": "string"
            }
          },
          "defaultConfig": {
            "logLevel": "string",
            "mergeTree": {
              "replicatedDeduplicationWindow": "string",
              "replicatedDeduplicationWindowSeconds": "string",
              "partsToDelayInsert": "string",
              "partsToThrowInsert": "string",
              "inactivePartsToDelayInsert": "string",
              "inactivePartsToThrowInsert": "string",
              "maxReplicatedMergesInQueue": "string",
              "numberOfFreeEntriesInPoolToLowerMaxSizeOfMerge": "string",
              "maxBytesToMergeAtMinSpaceInPool": "string",
              "maxBytesToMergeAtMaxSpaceInPool": "string",
              "minBytesForWidePart": "string",
              "minRowsForWidePart": "string",
              "ttlOnlyDropParts": "boolean",
              "allowRemoteFsZeroCopyReplication": "boolean",
              "mergeWithTtlTimeout": "string",
              "mergeWithRecompressionTtlTimeout": "string",
              "maxPartsInTotal": "string",
              "maxNumberOfMergesWithTtlInPool": "string",
              "cleanupDelayPeriod": "string",
              "numberOfFreeEntriesInPoolToExecuteMutation": "string",
              "maxAvgPartSizeForTooManyParts": "string",
              "minAgeToForceMergeSeconds": "string",
              "minAgeToForceMergeOnPartitionOnly": "boolean",
              "mergeSelectingSleepMs": "string",
              "mergeMaxBlockSize": "string",
              "checkSampleColumnIsCorrect": "boolean",
              "maxMergeSelectingSleepMs": "string",
              "maxCleanupDelayPeriod": "string"
            },
            "compression": [
              {
                "method": "string",
                "minPartSize": "string",
                "minPartSizeRatio": "string",
                "level": "string"
              }
            ],
            "dictionaries": [
              {
                "name": "string",
                "structure": {
                  "id": {
                    "name": "string"
                  },
                  "key": {
                    "attributes": [
                      {
                        "name": "string",
                        "type": "string",
                        "nullValue": "string",
                        "expression": "string",
                        "hierarchical": "boolean",
                        "injective": "boolean"
                      }
                    ]
                  },
                  "rangeMin": {
                    "name": "string",
                    "type": "string",
                    "nullValue": "string",
                    "expression": "string",
                    "hierarchical": "boolean",
                    "injective": "boolean"
                  },
                  "rangeMax": {
                    "name": "string",
                    "type": "string",
                    "nullValue": "string",
                    "expression": "string",
                    "hierarchical": "boolean",
                    "injective": "boolean"
                  },
                  "attributes": [
                    {
                      "name": "string",
                      "type": "string",
                      "nullValue": "string",
                      "expression": "string",
                      "hierarchical": "boolean",
                      "injective": "boolean"
                    }
                  ]
                },
                "layout": {
                  "type": "string",
                  "sizeInCells": "string",
                  "maxArraySize": "string"
                },
                // Includes only one of the fields `fixedLifetime`, `lifetimeRange`
                "fixedLifetime": "string",
                "lifetimeRange": {
                  "min": "string",
                  "max": "string"
                },
                // end of the list of possible fields
                // Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`
                "httpSource": {
                  "url": "string",
                  "format": "string",
                  "headers": [
                    {
                      "name": "string",
                      "value": "string"
                    }
                  ]
                },
                "mysqlSource": {
                  "db": "string",
                  "table": "string",
                  "port": "string",
                  "user": "string",
                  "password": "string",
                  "replicas": [
                    {
                      "host": "string",
                      "priority": "string",
                      "port": "string",
                      "user": "string",
                      "password": "string"
                    }
                  ],
                  "where": "string",
                  "invalidateQuery": "string",
                  "closeConnection": "boolean",
                  "shareConnection": "boolean"
                },
                "clickhouseSource": {
                  "db": "string",
                  "table": "string",
                  "host": "string",
                  "port": "string",
                  "user": "string",
                  "password": "string",
                  "where": "string",
                  "secure": "boolean"
                },
                "mongodbSource": {
                  "db": "string",
                  "collection": "string",
                  "host": "string",
                  "port": "string",
                  "user": "string",
                  "password": "string",
                  "options": "string"
                },
                "postgresqlSource": {
                  "db": "string",
                  "table": "string",
                  "hosts": [
                    "string"
                  ],
                  "port": "string",
                  "user": "string",
                  "password": "string",
                  "invalidateQuery": "string",
                  "sslMode": "string"
                }
                // end of the list of possible fields
              }
            ],
            "graphiteRollup": [
              {
                "name": "string",
                "patterns": [
                  {
                    "regexp": "string",
                    "function": "string",
                    "retention": [
                      {
                        "age": "string",
                        "precision": "string"
                      }
                    ]
                  }
                ],
                "pathColumnName": "string",
                "timeColumnName": "string",
                "valueColumnName": "string",
                "versionColumnName": "string"
              }
            ],
            "kafka": {
              "securityProtocol": "string",
              "saslMechanism": "string",
              "saslUsername": "string",
              "saslPassword": "string",
              "enableSslCertificateVerification": "boolean",
              "maxPollIntervalMs": "string",
              "sessionTimeoutMs": "string",
              "debug": "string",
              "autoOffsetReset": "string"
            },
            "kafkaTopics": [
              {
                "name": "string",
                "settings": {
                  "securityProtocol": "string",
                  "saslMechanism": "string",
                  "saslUsername": "string",
                  "saslPassword": "string",
                  "enableSslCertificateVerification": "boolean",
                  "maxPollIntervalMs": "string",
                  "sessionTimeoutMs": "string",
                  "debug": "string",
                  "autoOffsetReset": "string"
                }
              }
            ],
            "rabbitmq": {
              "username": "string",
              "password": "string",
              "vhost": "string"
            },
            "maxConnections": "string",
            "maxConcurrentQueries": "string",
            "keepAliveTimeout": "string",
            "uncompressedCacheSize": "string",
            "markCacheSize": "string",
            "maxTableSizeToDrop": "string",
            "maxPartitionSizeToDrop": "string",
            "builtinDictionariesReloadInterval": "string",
            "timezone": "string",
            "geobaseEnabled": "boolean",
            "geobaseUri": "string",
            "queryLogRetentionSize": "string",
            "queryLogRetentionTime": "string",
            "queryThreadLogEnabled": "boolean",
            "queryThreadLogRetentionSize": "string",
            "queryThreadLogRetentionTime": "string",
            "partLogRetentionSize": "string",
            "partLogRetentionTime": "string",
            "metricLogEnabled": "boolean",
            "metricLogRetentionSize": "string",
            "metricLogRetentionTime": "string",
            "traceLogEnabled": "boolean",
            "traceLogRetentionSize": "string",
            "traceLogRetentionTime": "string",
            "textLogEnabled": "boolean",
            "textLogRetentionSize": "string",
            "textLogRetentionTime": "string",
            "textLogLevel": "string",
            "opentelemetrySpanLogEnabled": "boolean",
            "opentelemetrySpanLogRetentionSize": "string",
            "opentelemetrySpanLogRetentionTime": "string",
            "queryViewsLogEnabled": "boolean",
            "queryViewsLogRetentionSize": "string",
            "queryViewsLogRetentionTime": "string",
            "asynchronousMetricLogEnabled": "boolean",
            "asynchronousMetricLogRetentionSize": "string",
            "asynchronousMetricLogRetentionTime": "string",
            "sessionLogEnabled": "boolean",
            "sessionLogRetentionSize": "string",
            "sessionLogRetentionTime": "string",
            "zookeeperLogEnabled": "boolean",
            "zookeeperLogRetentionSize": "string",
            "zookeeperLogRetentionTime": "string",
            "asynchronousInsertLogEnabled": "boolean",
            "asynchronousInsertLogRetentionSize": "string",
            "asynchronousInsertLogRetentionTime": "string",
            "backgroundPoolSize": "string",
            "backgroundMergesMutationsConcurrencyRatio": "string",
            "backgroundSchedulePoolSize": "string",
            "backgroundFetchesPoolSize": "string",
            "backgroundMovePoolSize": "string",
            "backgroundDistributedSchedulePoolSize": "string",
            "backgroundBufferFlushSchedulePoolSize": "string",
            "backgroundMessageBrokerSchedulePoolSize": "string",
            "backgroundCommonPoolSize": "string",
            "defaultDatabase": "string",
            "totalMemoryProfilerStep": "string",
            "totalMemoryTrackerSampleProbability": "number",
            "queryMaskingRules": [
              {
                "name": "string",
                "regexp": "string",
                "replace": "string"
              }
            ],
            "dictionariesLazyLoad": "boolean",
            "queryCache": {
              "maxSizeInBytes": "string",
              "maxEntries": "string",
              "maxEntrySizeInBytes": "string",
              "maxEntrySizeInRows": "string"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "zookeeper": {
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "backupWindowStart": {
        "hours": "integer",
        "minutes": "integer",
        "seconds": "integer",
        "nanos": "integer"
      },
      "access": {
        "dataLens": "boolean",
        "webSql": "boolean",
        "metrika": "boolean",
        "serverless": "boolean",
        "dataTransfer": "boolean",
        "yandexQuery": "boolean"
      },
      "cloudStorage": {
        "enabled": "boolean",
        "moveFactor": "number",
        "dataCacheEnabled": "boolean",
        "dataCacheMaxSize": "string",
        "preferNotToMerge": "boolean"
      },
      "sqlDatabaseManagement": "boolean",
      "sqlUserManagement": "boolean",
      "embeddedKeeper": "boolean",
      "backupRetainPeriodDays": "string"
    },
    "networkId": "string",
    "health": "string",
    "status": "string",
    "serviceAccountId": "string",
    "maintenanceWindow": {
      // Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
      "anytime": "object",
      "weeklyMaintenanceWindow": {
        "day": "string",
        "hour": "string"
      }
      // end of the list of possible fields
    },
    "plannedOperation": {
      "info": "string",
      "delayedUntil": "string"
    },
    "securityGroupIds": [
      "string"
    ],
    "deletionProtection": "boolean"
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateClusterMetadata](#yandex.cloud.mdb.clickhouse.v1.UpdateClusterMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Cluster](#yandex.cloud.mdb.clickhouse.v1.Cluster)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## UpdateClusterMetadata {#yandex.cloud.mdb.clickhouse.v1.UpdateClusterMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the ClickHouse Cluster resource that is being updated. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## Cluster {#yandex.cloud.mdb.clickhouse.v1.Cluster}

A ClickHouse Cluster resource. For more information, see the
[Cluster](/docs/managed-clickhouse/concepts) section in the Developer's Guide.

#|
||Field | Description ||
|| id | **string**

ID of the ClickHouse cluster.
This ID is assigned by MDB at creation time. ||
|| folderId | **string**

ID of the folder that the ClickHouse cluster belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the ClickHouse cluster.
The name is unique within the folder. 1-63 characters long. ||
|| description | **string**

Description of the ClickHouse cluster. 0-256 characters long. ||
|| labels | **string**

Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource. ||
|| environment | **enum** (Environment)

Deployment environment of the ClickHouse cluster.

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Stable environment with a conservative update policy:
only hotfixes are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions
are rolled out irrespective of backward compatibility. ||
|| monitoring[] | **[Monitoring](#yandex.cloud.mdb.clickhouse.v1.Monitoring)**

Description of monitoring systems relevant to the ClickHouse cluster. ||
|| config | **[ClusterConfig](#yandex.cloud.mdb.clickhouse.v1.ClusterConfig)**

Configuration of the ClickHouse cluster. ||
|| networkId | **string**

ID of the network that the cluster belongs to. ||
|| health | **enum** (Health)

Aggregated cluster health.

- `HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](/docs/managed-clickhouse/api-ref/Cluster/listHosts#yandex.cloud.mdb.clickhouse.v1.Host) for every host in the cluster is UNKNOWN).
- `ALIVE`: Cluster is alive and well ([Host.health](/docs/managed-clickhouse/api-ref/Cluster/listHosts#yandex.cloud.mdb.clickhouse.v1.Host) for every host in the cluster is ALIVE).
- `DEAD`: Cluster is inoperable ([Host.health](/docs/managed-clickhouse/api-ref/Cluster/listHosts#yandex.cloud.mdb.clickhouse.v1.Host) for every host in the cluster is DEAD).
- `DEGRADED`: Cluster is working below capacity ([Host.health](/docs/managed-clickhouse/api-ref/Cluster/listHosts#yandex.cloud.mdb.clickhouse.v1.Host) for at least one host in the cluster is not ALIVE). ||
|| status | **enum** (Status)

Current state of the cluster.

- `STATUS_UNKNOWN`: Cluster state is unknown.
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running normally.
- `ERROR`: Cluster encountered a problem and cannot operate.
- `UPDATING`: Cluster is being updated.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster stopped.
- `STARTING`: Cluster is starting. ||
|| serviceAccountId | **string**

ID of the service account used for access to Object Storage. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.clickhouse.v1.MaintenanceWindow2)**

Maintenance window for the cluster. ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.mdb.clickhouse.v1.MaintenanceOperation)**

Planned maintenance operation to be started for the cluster within the nearest `maintenanceWindow`. ||
|| securityGroupIds[] | **string**

User security groups ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the cluster ||
|#

## Monitoring {#yandex.cloud.mdb.clickhouse.v1.Monitoring}

Monitoring system metadata.

#|
||Field | Description ||
|| name | **string**

Name of the monitoring system. ||
|| description | **string**

Description of the monitoring system. ||
|| link | **string**

Link to the monitoring system charts for the ClickHouse cluster. ||
|#

## ClusterConfig {#yandex.cloud.mdb.clickhouse.v1.ClusterConfig}

#|
||Field | Description ||
|| version | **string**

Version of the ClickHouse server software. ||
|| clickhouse | **[Clickhouse](#yandex.cloud.mdb.clickhouse.v1.ClusterConfig.Clickhouse)**

Configuration and resource allocation for ClickHouse hosts. ||
|| zookeeper | **[Zookeeper](#yandex.cloud.mdb.clickhouse.v1.ClusterConfig.Zookeeper)**

Configuration and resource allocation for ZooKeeper hosts. ||
|| backupWindowStart | **[TimeOfDay](#google.type.TimeOfDay2)**

Time to start the daily backup, in the UTC timezone. ||
|| access | **[Access](#yandex.cloud.mdb.clickhouse.v1.Access2)**

Access policy for external services. ||
|| cloudStorage | **[CloudStorage](#yandex.cloud.mdb.clickhouse.v1.CloudStorage2)** ||
|| sqlDatabaseManagement | **boolean**

Whether database management through SQL commands is enabled. ||
|| sqlUserManagement | **boolean**

Whether user management through SQL commands is enabled. ||
|| embeddedKeeper | **boolean**

Whether cluster should use embedded Keeper instead of Zookeeper. ||
|| backupRetainPeriodDays | **string** (int64)

Retain period of automatically created backup in days ||
|#

## Clickhouse {#yandex.cloud.mdb.clickhouse.v1.ClusterConfig.Clickhouse}

#|
||Field | Description ||
|| config | **[ClickhouseConfigSet](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfigSet)**

Configuration settings of a ClickHouse server. ||
|| resources | **[Resources](#yandex.cloud.mdb.clickhouse.v1.Resources2)**

Resources allocated to ClickHouse hosts. ||
|#

## ClickhouseConfigSet {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfigSet}

#|
||Field | Description ||
|| effectiveConfig | **[ClickhouseConfig](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig2)**

Required field. Effective settings for a ClickHouse cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[ClickhouseConfig](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig2)**

User-defined settings for a ClickHouse cluster. ||
|| defaultConfig | **[ClickhouseConfig](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig2)**

Default configuration for a ClickHouse cluster. ||
|#

## ClickhouseConfig {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig2}

ClickHouse configuration options. Detailed description for each set of options
is available in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/).

Any options not listed here are not supported.

#|
||Field | Description ||
|| logLevel | **enum** (LogLevel)

Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.

- `LOG_LEVEL_UNSPECIFIED`
- `TRACE`
- `DEBUG`
- `INFORMATION`
- `WARNING`
- `ERROR` ||
|| mergeTree | **[MergeTree](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.MergeTree2)**

Settings for the MergeTree engine.
See description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree). ||
|| compression[] | **[Compression](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Compression2)**

Compression settings for the ClickHouse cluster.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#compression). ||
|| dictionaries[] | **[ExternalDictionary](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary2)**

Configuration of external dictionaries to be used by the ClickHouse cluster.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts/). ||
|| graphiteRollup[] | **[GraphiteRollup](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup2)**

Settings for thinning Graphite data.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup). ||
|| kafka | **[Kafka](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Kafka2)** ||
|| kafkaTopics[] | **[KafkaTopic](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.KafkaTopic2)** ||
|| rabbitmq | **[Rabbitmq](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Rabbitmq2)** ||
|| maxConnections | **string** (int64)

Maximum number of inbound connections. ||
|| maxConcurrentQueries | **string** (int64)

Maximum number of simultaneously processed requests. ||
|| keepAliveTimeout | **string** (int64)

Number of milliseconds that ClickHouse waits for incoming requests before closing the connection. ||
|| uncompressedCacheSize | **string** (int64)

Cache size (in bytes) for uncompressed data used by MergeTree tables. ||
|| markCacheSize | **string** (int64)

Approximate size (in bytes) of the cache of "marks" used by MergeTree tables. ||
|| maxTableSizeToDrop | **string** (int64)

Maximum size of the table that can be deleted using a DROP query. ||
|| maxPartitionSizeToDrop | **string** (int64)

Maximum size of the partition that can be deleted using a DROP query. ||
|| builtinDictionariesReloadInterval | **string** (int64)

The setting is deprecated and has no effect. ||
|| timezone | **string**

The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier. ||
|| geobaseEnabled | **boolean**

Enable or disable geobase. ||
|| geobaseUri | **string**

Address of the archive with the user geobase in Object Storage. ||
|| queryLogRetentionSize | **string** (int64)

The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of
query_log data based on size is disabled. ||
|| queryLogRetentionTime | **string** (int64)

The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of
query_log data based on time is disabled. ||
|| queryThreadLogEnabled | **boolean**

Whether query_thread_log system table is enabled. ||
|| queryThreadLogRetentionSize | **string** (int64)

The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of
query_thread_log data based on size is disabled. ||
|| queryThreadLogRetentionTime | **string** (int64)

The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of
query_thread_log data based on time is disabled. ||
|| partLogRetentionSize | **string** (int64)

The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of
part_log data based on size is disabled. ||
|| partLogRetentionTime | **string** (int64)

The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of
part_log data based on time is disabled. ||
|| metricLogEnabled | **boolean**

Whether metric_log system table is enabled. ||
|| metricLogRetentionSize | **string** (int64)

The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of
metric_log data based on size is disabled. ||
|| metricLogRetentionTime | **string** (int64)

The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of
metric_log data based on time is disabled. ||
|| traceLogEnabled | **boolean**

Whether trace_log system table is enabled. ||
|| traceLogRetentionSize | **string** (int64)

The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of
trace_log data based on size is disabled. ||
|| traceLogRetentionTime | **string** (int64)

The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of
trace_log data based on time is disabled. ||
|| textLogEnabled | **boolean**

Whether text_log system table is enabled. ||
|| textLogRetentionSize | **string** (int64)

The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of
text_log data based on size is disabled. ||
|| textLogRetentionTime | **string** (int64)

The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of
text_log data based on time is disabled. ||
|| textLogLevel | **enum** (LogLevel)

Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.

- `LOG_LEVEL_UNSPECIFIED`
- `TRACE`
- `DEBUG`
- `INFORMATION`
- `WARNING`
- `ERROR` ||
|| opentelemetrySpanLogEnabled | **boolean**

Enable or disable opentelemetry_span_log system table. Default value: false. ||
|| opentelemetrySpanLogRetentionSize | **string** (int64)

The maximum size that opentelemetry_span_log can grow to before old data will be removed. If set to 0 (default),
automatic removal of opentelemetry_span_log data based on size is disabled. ||
|| opentelemetrySpanLogRetentionTime | **string** (int64)

The maximum time that opentelemetry_span_log records will be retained before removal. If set to 0,
automatic removal of opentelemetry_span_log data based on time is disabled. ||
|| queryViewsLogEnabled | **boolean**

Enable or disable query_views_log system table. Default value: false. ||
|| queryViewsLogRetentionSize | **string** (int64)

The maximum size that query_views_log can grow to before old data will be removed. If set to 0 (default),
automatic removal of query_views_log data based on size is disabled. ||
|| queryViewsLogRetentionTime | **string** (int64)

The maximum time that query_views_log records will be retained before removal. If set to 0,
automatic removal of query_views_log data based on time is disabled. ||
|| asynchronousMetricLogEnabled | **boolean**

Enable or disable asynchronous_metric_log system table. Default value: false. ||
|| asynchronousMetricLogRetentionSize | **string** (int64)

The maximum size that asynchronous_metric_log can grow to before old data will be removed. If set to 0 (default),
automatic removal of asynchronous_metric_log data based on size is disabled. ||
|| asynchronousMetricLogRetentionTime | **string** (int64)

The maximum time that asynchronous_metric_log records will be retained before removal. If set to 0,
automatic removal of asynchronous_metric_log data based on time is disabled. ||
|| sessionLogEnabled | **boolean**

Enable or disable session_log system table. Default value: false. ||
|| sessionLogRetentionSize | **string** (int64)

The maximum size that session_log can grow to before old data will be removed. If set to 0 (default),
automatic removal of session_log data based on size is disabled. ||
|| sessionLogRetentionTime | **string** (int64)

The maximum time that session_log records will be retained before removal. If set to 0,
automatic removal of session_log data based on time is disabled. ||
|| zookeeperLogEnabled | **boolean**

Enable or disable zookeeper_log system table. Default value: false. ||
|| zookeeperLogRetentionSize | **string** (int64)

The maximum size that zookeeper_log can grow to before old data will be removed. If set to 0 (default),
automatic removal of zookeeper_log data based on size is disabled. ||
|| zookeeperLogRetentionTime | **string** (int64)

The maximum time that zookeeper_log records will be retained before removal. If set to 0,
automatic removal of zookeeper_log data based on time is disabled. ||
|| asynchronousInsertLogEnabled | **boolean**

Enable or disable asynchronous_insert_log system table. Default value: false.
Minimal required ClickHouse version: 22.10. ||
|| asynchronousInsertLogRetentionSize | **string** (int64)

The maximum size that asynchronous_insert_log can grow to before old data will be removed. If set to 0 (default),
automatic removal of asynchronous_insert_log data based on size is disabled. ||
|| asynchronousInsertLogRetentionTime | **string** (int64)

The maximum time that asynchronous_insert_log records will be retained before removal. If set to 0,
automatic removal of asynchronous_insert_log data based on time is disabled. ||
|| backgroundPoolSize | **string** (int64) ||
|| backgroundMergesMutationsConcurrencyRatio | **string** (int64)

Sets a ratio between the number of threads and the number of background merges and mutations that can be executed concurrently. For example, if the ratio equals to 2 and background_pool_size is set to 16 then ClickHouse can execute 32 background merges concurrently. This is possible, because background operations could be suspended and postponed. This is needed to give small merges more execution priority. You can only increase this ratio at runtime. To lower it you have to restart the server. The same as for background_pool_size setting background_merges_mutations_concurrency_ratio could be applied from the default profile for backward compatibility.
Default: 2
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#background_merges_mutations_concurrency_ratio) ||
|| backgroundSchedulePoolSize | **string** (int64) ||
|| backgroundFetchesPoolSize | **string** (int64)

Sets the number of threads performing background fetches for tables with **ReplicatedMergeTree** engines. Default value: 8.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size). ||
|| backgroundMovePoolSize | **string** (int64) ||
|| backgroundDistributedSchedulePoolSize | **string** (int64) ||
|| backgroundBufferFlushSchedulePoolSize | **string** (int64) ||
|| backgroundMessageBrokerSchedulePoolSize | **string** (int64) ||
|| backgroundCommonPoolSize | **string** (int64)

The maximum number of threads that will be used for performing a variety of operations (mostly garbage collection) for *MergeTree-engine tables in a background.
Default: 8
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#background_common_pool_size) ||
|| defaultDatabase | **string**

The default database.

To get a list of cluster databases, see [Yandex Managed ClickHouse documentation](/docs/managed-clickhouse/operations/databases#list-db). ||
|| totalMemoryProfilerStep | **string** (int64)

Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: **4194304**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step). ||
|| totalMemoryTrackerSampleProbability | **number** (double) ||
|| queryMaskingRules[] | **[QueryMaskingRule](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryMaskingRule2)**

Regexp-based rules, which will be applied to queries as well as all log messages before storing them in server logs, system.query_log, system.text_log, system.processes tables, and in logs sent to the client. That allows preventing sensitive data leakage from SQL queries (like names, emails, personal identifiers or credit card numbers) to logs.
Change of these settings is applied with ClickHouse restart
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#query-masking-rules) ||
|| dictionariesLazyLoad | **boolean**

Lazy loading of dictionaries.
Default: true
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#dictionaries_lazy_load) ||
|| queryCache | **[QueryCache](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryCache2)**

[Query cache](https://clickhouse.com/docs/en/operations/query-cache) configuration.
Min version: 23.5
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#query_cache) ||
|#

## MergeTree {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.MergeTree2}

Options specific to the MergeTree table engine.

#|
||Field | Description ||
|| replicatedDeduplicationWindow | **string** (int64)

Number of blocks of hashes to keep in ZooKeeper. ||
|| replicatedDeduplicationWindowSeconds | **string** (int64)

Period of time to keep blocks of hashes for. ||
|| partsToDelayInsert | **string** (int64)

If table contains at least that many active parts in single partition, artificially slow down insert into table. ||
|| partsToThrowInsert | **string** (int64)

If more than this number active parts in single partition, throw 'Too many parts ...' exception. ||
|| inactivePartsToDelayInsert | **string** (int64) ||
|| inactivePartsToThrowInsert | **string** (int64) ||
|| maxReplicatedMergesInQueue | **string** (int64)

How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue. ||
|| numberOfFreeEntriesInPoolToLowerMaxSizeOfMerge | **string** (int64)

If there is less than specified number of free entries in background pool (or replicated queue), start to lower
maximum size of merge to process. ||
|| maxBytesToMergeAtMinSpaceInPool | **string** (int64)

Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries
in replication queue). ||
|| maxBytesToMergeAtMaxSpaceInPool | **string** (int64) ||
|| minBytesForWidePart | **string** (int64)

Minimum number of bytes in a data part that can be stored in **Wide** format.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). ||
|| minRowsForWidePart | **string** (int64)

Minimum number of rows in a data part that can be stored in **Wide** format.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part). ||
|| ttlOnlyDropParts | **boolean**

Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts). ||
|| allowRemoteFsZeroCopyReplication | **boolean** ||
|| mergeWithTtlTimeout | **string** (int64) ||
|| mergeWithRecompressionTtlTimeout | **string** (int64) ||
|| maxPartsInTotal | **string** (int64) ||
|| maxNumberOfMergesWithTtlInPool | **string** (int64) ||
|| cleanupDelayPeriod | **string** (int64) ||
|| numberOfFreeEntriesInPoolToExecuteMutation | **string** (int64) ||
|| maxAvgPartSizeForTooManyParts | **string** (int64)

The 'too many parts' check according to 'parts_to_delay_insert' and 'parts_to_throw_insert' will be active only if the average part size (in the relevant partition) is not larger than the specified threshold. If it is larger than the specified threshold, the INSERTs will be neither delayed or rejected. This allows to have hundreds of terabytes in a single table on a single server if the parts are successfully merged to larger parts. This does not affect the thresholds on inactive parts or total parts.
Default: 1 GiB
Min version: 22.10
See in-depth description in [ClickHouse GitHub](https://github.com/ClickHouse/ClickHouse/blob/f9558345e886876b9132d9c018e357f7fa9b22a3/src/Storages/MergeTree/MergeTreeSettings.h#L80) ||
|| minAgeToForceMergeSeconds | **string** (int64)

Merge parts if every part in the range is older than the value of min_age_to_force_merge_seconds.
Default: 0 - disabled
Min_version: 22.10
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#min_age_to_force_merge_seconds) ||
|| minAgeToForceMergeOnPartitionOnly | **boolean**

Whether min_age_to_force_merge_seconds should be applied only on the entire partition and not on subset.
Default: false
Min_version: 22.11
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#min_age_to_force_merge_seconds) ||
|| mergeSelectingSleepMs | **string** (int64)

Sleep time for merge selecting when no part is selected. A lower setting triggers selecting tasks in background_schedule_pool frequently, which results in a large number of requests to ClickHouse Keeper in large-scale clusters.
Default: 5000
Min_version: 21.10
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#merge_selecting_sleep_ms) ||
|| mergeMaxBlockSize | **string** (int64)

The number of rows that are read from the merged parts into memory.
Default: 8192
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#merge_max_block_size) ||
|| checkSampleColumnIsCorrect | **boolean**

Enables the check at table creation, that the data type of a column for sampling or sampling expression is correct. The data type must be one of unsigned [integer types](https://clickhouse.com/docs/en/sql-reference/data-types/int-uint): UInt8, UInt16, UInt32, UInt64.
Default: true
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#check_sample_column_is_correct) ||
|| maxMergeSelectingSleepMs | **string** (int64)

Maximum sleep time for merge selecting, a lower setting will trigger selecting tasks in background_schedule_pool frequently which result in large amount of requests to zookeeper in large-scale clusters.
Default: 60000
Min_version: 23.6
See in-depth description in [ClickHouse GitHub](https://github.com/ClickHouse/ClickHouse/blob/4add9db84859bff7410cf934a3904b0414e36e51/src/Storages/MergeTree/MergeTreeSettings.h#L71) ||
|| maxCleanupDelayPeriod | **string** (int64)

Maximum period to clean old queue logs, blocks hashes and parts.
Default: 300
Min_version: 23.6
See in-depth description in [ClickHouse GitHub](https://github.com/ClickHouse/ClickHouse/blob/4add9db84859bff7410cf934a3904b0414e36e51/src/Storages/MergeTree/MergeTreeSettings.h#L142) ||
|#

## Compression {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Compression2}

#|
||Field | Description ||
|| method | **enum** (Method)

Compression method to use for the specified combination of `minPartSize` and `minPartSizeRatio`.

- `METHOD_UNSPECIFIED`
- `LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4/).
- `ZSTD`: [Zstandard compression algorithm](https://facebook.github.io/zstd/). ||
|| minPartSize | **string** (int64)

Minimum size of a part of a table. ||
|| minPartSizeRatio | **string**

Minimum ratio of a part relative to the size of all the data in the table. ||
|| level | **string** (int64) ||
|#

## ExternalDictionary {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary2}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the external dictionary. ||
|| structure | **[Structure](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure2)**

Required field. Set of attributes for the external dictionary.
For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/). ||
|| layout | **[Layout](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Layout2)**

Required field. Layout for storing the dictionary in memory.
For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/). ||
|| fixedLifetime | **string** (int64)

Fixed interval between dictionary updates.

Includes only one of the fields `fixedLifetime`, `lifetimeRange`.

Setting for the period of time between dictionary updates.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). ||
|| lifetimeRange | **[Range](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Range2)**

Range of intervals between dictionary updates for ClickHouse to choose from.

Includes only one of the fields `fixedLifetime`, `lifetimeRange`.

Setting for the period of time between dictionary updates.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). ||
|| httpSource | **[HttpSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource2)**

HTTP source for the dictionary.

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`.

Description of the source for the external dictionary. ||
|| mysqlSource | **[MysqlSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource2)**

MySQL source for the dictionary.

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`.

Description of the source for the external dictionary. ||
|| clickhouseSource | **[ClickhouseSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.ClickhouseSource2)**

ClickHouse source for the dictionary.

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`.

Description of the source for the external dictionary. ||
|| mongodbSource | **[MongodbSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MongodbSource2)**

MongoDB source for the dictionary.

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`.

Description of the source for the external dictionary. ||
|| postgresqlSource | **[PostgresqlSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.PostgresqlSource2)**

PostgreSQL source for the dictionary.

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`.

Description of the source for the external dictionary. ||
|#

## Structure {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure2}

#|
||Field | Description ||
|| id | **[Id](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Id2)**

Single numeric key column for the dictionary. ||
|| key | **[Key](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Key2)**

Composite key for the dictionary, containing of one or more key columns.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). ||
|| rangeMin | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute2)**

Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). ||
|| rangeMax | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute2)**

Field holding the end of the range for dictionaries with `RANGE_HASHED` layout.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). ||
|| attributes[] | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute2)**

Description of the fields available for database queries.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes). ||
|#

## Id {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Id2}

Numeric key.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the numeric key. ||
|#

## Key {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Key2}

Complex key.

#|
||Field | Description ||
|| attributes[] | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute2)**

Attributes of a complex key. ||
|#

## Attribute {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute2}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the column. ||
|| type | **string**

Required field. Type of the column. ||
|| nullValue | **string**

Default value for an element without data (for example, an empty string). ||
|| expression | **string**

Expression, describing the attribute, if applicable. ||
|| hierarchical | **boolean**

Indication of hierarchy support.
Default value: `false`. ||
|| injective | **boolean**

Indication of injective mapping "id -> attribute".
Default value: `false`. ||
|#

## Layout {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Layout2}

Layout determining how to store the dictionary in memory.

#|
||Field | Description ||
|| type | **enum** (Type)

Required field. Layout type for an external dictionary.

- `TYPE_UNSPECIFIED`
- `FLAT`: The entire dictionary is stored in memory in the form of flat arrays.
Available for all dictionary sources.
- `HASHED`: The entire dictionary is stored in memory in the form of a hash table.
Available for all dictionary sources.
- `COMPLEX_KEY_HASHED`: Similar to HASHED, to be used with composite keys.
Available for all dictionary sources.
- `RANGE_HASHED`: The entire dictionary is stored in memory in the form of a hash table,
with an ordered array of ranges and their corresponding values.
Available for all dictionary sources.
- `CACHE`: The dictionary is stored in a cache with a set number of cells.
Available for MySQL, ClickHouse and HTTP dictionary sources.
- `COMPLEX_KEY_CACHE`: Similar to CACHE, to be used with composite keys.
Available for MySQL, ClickHouse and HTTP dictionary sources. ||
|| sizeInCells | **string** (int64)

Number of cells in the cache. Rounded up to a power of two.
Applicable only for CACHE and COMPLEX_KEY_CACHE layout types. ||
|| maxArraySize | **string** (int64)

Maximum dictionary key size.
Applicable only for FLAT layout type. ||
|#

## Range {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Range2}

#|
||Field | Description ||
|| min | **string** (int64)

Minimum dictionary lifetime. ||
|| max | **string** (int64)

Maximum dictionary lifetime. ||
|#

## HttpSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource2}

#|
||Field | Description ||
|| url | **string**

Required field. URL of the source dictionary available over HTTP. ||
|| format | **string**

Required field. The data format. Valid values are all formats supported by ClickHouse SQL dialect. ||
|| headers[] | **[Header](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource.Header2)**

HTTP headers. ||
|#

## Header {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource.Header2}

#|
||Field | Description ||
|| name | **string**

Required field.  ||
|| value | **string**

Required field.  ||
|#

## MysqlSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource2}

#|
||Field | Description ||
|| db | **string**

Required field. Name of the MySQL database to connect to. ||
|| table | **string**

Required field. Name of the database table to use as a ClickHouse dictionary. ||
|| port | **string** (int64)

Default port to use when connecting to a replica of the dictionary source. ||
|| user | **string**

Name of the default user for replicas of the dictionary source. ||
|| password | **string**

Password of the default user for replicas of the dictionary source. ||
|| replicas[] | **[Replica](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource.Replica2)**

List of MySQL replicas of the database used as dictionary source. ||
|| where | **string**

Selection criteria for the data in the specified MySQL table. ||
|| invalidateQuery | **string**

Query for checking the dictionary status, to pull only updated data.
For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). ||
|| closeConnection | **boolean**

Should the connection be closed after each request. ||
|| shareConnection | **boolean**

Should a connection be shared for some requests. ||
|#

## Replica {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource.Replica2}

#|
||Field | Description ||
|| host | **string**

Required field. MySQL host of the replica. ||
|| priority | **string** (int64)

Required field. The priority of the replica that ClickHouse takes into account when connecting.
Replica with the highest priority should have this field set to the lowest number. ||
|| port | **string** (int64)

Port to use when connecting to the replica.
If a port is not specified for a replica, ClickHouse uses the port specified for the source. ||
|| user | **string**

Name of the MySQL database user. ||
|| password | **string**

Password of the MySQL database user. ||
|#

## ClickhouseSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.ClickhouseSource2}

#|
||Field | Description ||
|| db | **string**

Required field. Name of the ClickHouse database. ||
|| table | **string**

Required field. Name of the table in the specified database to be used as the dictionary source. ||
|| host | **string**

ClickHouse host of the specified database. ||
|| port | **string** (int64)

Port to use when connecting to the host. ||
|| user | **string**

Required field. Name of the ClickHouse database user. ||
|| password | **string**

Password of the ClickHouse database user. ||
|| where | **string**

Selection criteria for the data in the specified ClickHouse table. ||
|| secure | **boolean**

Use ssl for connection. ||
|#

## MongodbSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MongodbSource2}

#|
||Field | Description ||
|| db | **string**

Required field. Name of the MongoDB database. ||
|| collection | **string**

Required field. Name of the collection in the specified database to be used as the dictionary source. ||
|| host | **string**

MongoDB host of the specified database. ||
|| port | **string** (int64)

Port to use when connecting to the host. ||
|| user | **string**

Required field. Name of the MongoDB database user. ||
|| password | **string**

Password of the MongoDB database user. ||
|| options | **string** ||
|#

## PostgresqlSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.PostgresqlSource2}

#|
||Field | Description ||
|| db | **string**

Required field. Name of the PostrgreSQL database. ||
|| table | **string**

Required field. Name of the table in the specified database to be used as the dictionary source. ||
|| hosts[] | **string**

Name of the PostrgreSQL host ||
|| port | **string** (int64)

Port to use when connecting to the host. ||
|| user | **string**

Required field. Name of the PostrgreSQL database user. ||
|| password | **string**

Password of the PostrgreSQL database user. ||
|| invalidateQuery | **string**

Query for checking the dictionary status, to pull only updated data.
For more details, see [ClickHouse documentation on dictionaries](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/). ||
|| sslMode | **enum** (SslMode)

Mode of SSL TCP/IP connection to the PostgreSQL host.
For more details, see [PostgreSQL documentation](https://www.postgresql.org/docs/current/libpq-ssl.html).

- `SSL_MODE_UNSPECIFIED`
- `DISABLE`: Only try a non-SSL connection.
- `ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.
- `PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.
- `VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).
- `VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate. ||
|#

## GraphiteRollup {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup2}

Rollup settings for the GraphiteMergeTree table engine.

#|
||Field | Description ||
|| name | **string**

Required field. Name for the specified combination of settings for Graphite rollup. ||
|| patterns[] | **[Pattern](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern2)**

Pattern to use for the rollup. ||
|| pathColumnName | **string**

The name of the column storing the metric name (Graphite sensor).
Default: Path
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/graphitemergetree#required-columns) ||
|| timeColumnName | **string**

The name of the column storing the time of measuring the metric.
Default: Time
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/graphitemergetree#required-columns) ||
|| valueColumnName | **string**

The name of the column storing the value of the metric at the time set in time_column_name.
Default: Value
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/graphitemergetree#required-columns) ||
|| versionColumnName | **string**

The name of the column storing the version of the metric.
Default: Timestamp
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/graphitemergetree#required-columns) ||
|#

## Pattern {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern2}

#|
||Field | Description ||
|| regexp | **string**

Pattern for metric names. ||
|| function | **string**

Required field. Name of the aggregating function to apply to data of the age specified in `retention`. ||
|| retention[] | **[Retention](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern.Retention2)**

Age of data to use for thinning. ||
|#

## Retention {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern.Retention2}

#|
||Field | Description ||
|| age | **string** (int64)

Minimum age of the data in seconds. ||
|| precision | **string** (int64)

Precision of determining the age of the data, in seconds. ||
|#

## Kafka {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Kafka2}

#|
||Field | Description ||
|| securityProtocol | **enum** (SecurityProtocol)

- `SECURITY_PROTOCOL_UNSPECIFIED`
- `SECURITY_PROTOCOL_PLAINTEXT`
- `SECURITY_PROTOCOL_SSL`
- `SECURITY_PROTOCOL_SASL_PLAINTEXT`
- `SECURITY_PROTOCOL_SASL_SSL` ||
|| saslMechanism | **enum** (SaslMechanism)

- `SASL_MECHANISM_UNSPECIFIED`
- `SASL_MECHANISM_GSSAPI`
- `SASL_MECHANISM_PLAIN`
- `SASL_MECHANISM_SCRAM_SHA_256`
- `SASL_MECHANISM_SCRAM_SHA_512` ||
|| saslUsername | **string** ||
|| saslPassword | **string** ||
|| enableSslCertificateVerification | **boolean** ||
|| maxPollIntervalMs | **string** (int64) ||
|| sessionTimeoutMs | **string** (int64) ||
|| debug | **enum** (Debug)

- `DEBUG_UNSPECIFIED`
- `DEBUG_GENERIC`
- `DEBUG_BROKER`
- `DEBUG_TOPIC`
- `DEBUG_METADATA`
- `DEBUG_FEATURE`
- `DEBUG_QUEUE`
- `DEBUG_MSG`
- `DEBUG_PROTOCOL`
- `DEBUG_CGRP`
- `DEBUG_SECURITY`
- `DEBUG_FETCH`
- `DEBUG_INTERCEPTOR`
- `DEBUG_PLUGIN`
- `DEBUG_CONSUMER`
- `DEBUG_ADMIN`
- `DEBUG_EOS`
- `DEBUG_MOCK`
- `DEBUG_ASSIGNOR`
- `DEBUG_CONF`
- `DEBUG_TELEMETRY`
- `DEBUG_ALL` ||
|| autoOffsetReset | **enum** (AutoOffsetReset)

- `AUTO_OFFSET_RESET_UNSPECIFIED`
- `AUTO_OFFSET_RESET_SMALLEST`
- `AUTO_OFFSET_RESET_EARLIEST`
- `AUTO_OFFSET_RESET_BEGINNING`
- `AUTO_OFFSET_RESET_LARGEST`
- `AUTO_OFFSET_RESET_LATEST`
- `AUTO_OFFSET_RESET_END`
- `AUTO_OFFSET_RESET_ERROR` ||
|#

## KafkaTopic {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.KafkaTopic2}

#|
||Field | Description ||
|| name | **string**

Required field.  ||
|| settings | **[Kafka](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Kafka2)**

Required field.  ||
|#

## Rabbitmq {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Rabbitmq2}

#|
||Field | Description ||
|| username | **string**

[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) username ||
|| password | **string**

[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) password ||
|| vhost | **string**

[RabbitMQ](https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/) virtual host ||
|#

## QueryMaskingRule {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryMaskingRule2}

#|
||Field | Description ||
|| name | **string**

Name for the rule. ||
|| regexp | **string**

Required field. RE2 compatible regular expression.
Required. ||
|| replace | **string**

Substitution string for sensitive data.
Default: six asterisks ||
|#

## QueryCache {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryCache2}

#|
||Field | Description ||
|| maxSizeInBytes | **string** (int64)

The maximum cache size in bytes.
Default: 1073741824 (1 GiB) ||
|| maxEntries | **string** (int64)

The maximum number of SELECT query results stored in the cache.
Default: 1024 ||
|| maxEntrySizeInBytes | **string** (int64)

The maximum size in bytes SELECT query results may have to be saved in the cache.
Dafault: 1048576 (1 MiB) ||
|| maxEntrySizeInRows | **string** (int64)

The maximum number of rows SELECT query results may have to be saved in the cache.
Default: 30000000 (30 mil) ||
|#

## Resources {#yandex.cloud.mdb.clickhouse.v1.Resources2}

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/managed-clickhouse/concepts/instance-types) ||
|| diskSize | **string** (int64)

Volume of the storage available to a host, in bytes. ||
|| diskTypeId | **string**

Type of the storage environment for the host.
Possible values:
* network-hdd - network HDD drive,
* network-ssd - network SSD drive,
* local-ssd - local SSD storage. ||
|#

## Zookeeper {#yandex.cloud.mdb.clickhouse.v1.ClusterConfig.Zookeeper}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.clickhouse.v1.Resources2)**

Resources allocated to ZooKeeper hosts. ||
|#

## TimeOfDay {#google.type.TimeOfDay2}

Represents a time of day. The date and time zone are either not significant
or are specified elsewhere. An API may choose to allow leap seconds. Related
types are [google.type.Date](https://github.com/googleapis/googleapis/blob/master/google/type/date.proto) and [google.protobuf.Timestamp](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto).

#|
||Field | Description ||
|| hours | **integer** (int32)

Hours of day in 24 hour format. Should be from 0 to 23. An API may choose
to allow the value "24:00:00" for scenarios like business closing time. ||
|| minutes | **integer** (int32)

Minutes of hour of day. Must be from 0 to 59. ||
|| seconds | **integer** (int32)

Seconds of minutes of the time. Must normally be from 0 to 59. An API may
allow the value 60 if it allows leap-seconds. ||
|| nanos | **integer** (int32)

Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999. ||
|#

## Access {#yandex.cloud.mdb.clickhouse.v1.Access2}

#|
||Field | Description ||
|| dataLens | **boolean**

Allow to export data from the cluster to DataLens. ||
|| webSql | **boolean**

Allow SQL queries to the cluster databases from the management console.

See [SQL queries in the management console](/docs/managed-clickhouse/operations/web-sql-query) for more details. ||
|| metrika | **boolean**

Allow to import data from Yandex Metrica and AppMetrica to the cluster.

See [AppMetrica documentation](https://appmetrica.yandex.com/docs/cloud/index.html) for more details. ||
|| serverless | **boolean**

Allow access to cluster for Serverless. ||
|| dataTransfer | **boolean**

Allow access for DataTransfer ||
|| yandexQuery | **boolean**

Allow access for Query ||
|#

## CloudStorage {#yandex.cloud.mdb.clickhouse.v1.CloudStorage2}

#|
||Field | Description ||
|| enabled | **boolean**

Whether to use Object Storage for storing ClickHouse data. ||
|| moveFactor | **number** (double) ||
|| dataCacheEnabled | **boolean** ||
|| dataCacheMaxSize | **string** (int64) ||
|| preferNotToMerge | **boolean** ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.clickhouse.v1.MaintenanceWindow2}

A maintenance window settings.

#|
||Field | Description ||
|| anytime | **object**

Maintenance operation can be scheduled anytime.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.

The maintenance policy in effect. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.clickhouse.v1.WeeklyMaintenanceWindow2)**

Maintenance operation can be scheduled on a weekly basis.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.

The maintenance policy in effect. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.clickhouse.v1.WeeklyMaintenanceWindow2}

Weelky maintenance window settings.

#|
||Field | Description ||
|| day | **enum** (WeekDay)

Day of the week (in `DDD` format).

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **string** (int64)

Hour of the day in UTC (in `HH` format). ||
|#

## MaintenanceOperation {#yandex.cloud.mdb.clickhouse.v1.MaintenanceOperation}

A planned maintenance operation.

#|
||Field | Description ||
|| info | **string**

Information about this maintenance operation. ||
|| delayedUntil | **string** (date-time)

Time until which this maintenance operation is delayed.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#