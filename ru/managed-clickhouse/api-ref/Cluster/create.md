---
editable: false
sourcePath: en/_api-ref/mdb/clickhouse/v1/api-ref/Cluster/create.md
---

# Managed Service for ClickHouse API, REST: Cluster.Create

Creates a ClickHouse cluster in the specified folder.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters
```

## Body parameters {#yandex.cloud.mdb.clickhouse.v1.CreateClusterRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "string",
  "environment": "string",
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
  "databaseSpecs": [
    {
      "name": "string"
    }
  ],
  "userSpecs": [
    {
      "name": "string",
      "password": "string",
      "permissions": [
        {
          "databaseName": "string"
        }
      ],
      "settings": {
        "readonly": "string",
        "allowDdl": "boolean",
        "allowIntrospectionFunctions": "boolean",
        "connectTimeout": "string",
        "connectTimeoutWithFailover": "string",
        "receiveTimeout": "string",
        "sendTimeout": "string",
        "timeoutBeforeCheckingExecutionSpeed": "string",
        "insertQuorum": "string",
        "insertQuorumTimeout": "string",
        "insertQuorumParallel": "boolean",
        "insertNullAsDefault": "boolean",
        "selectSequentialConsistency": "boolean",
        "deduplicateBlocksInDependentMaterializedViews": "boolean",
        "replicationAlterPartitionsSync": "string",
        "maxReplicaDelayForDistributedQueries": "string",
        "fallbackToStaleReplicasForDistributedQueries": "boolean",
        "distributedProductMode": "string",
        "distributedAggregationMemoryEfficient": "boolean",
        "distributedDdlTaskTimeout": "string",
        "skipUnavailableShards": "boolean",
        "compileExpressions": "boolean",
        "minCountToCompileExpression": "string",
        "maxBlockSize": "string",
        "minInsertBlockSizeRows": "string",
        "minInsertBlockSizeBytes": "string",
        "maxInsertBlockSize": "string",
        "minBytesToUseDirectIo": "string",
        "useUncompressedCache": "boolean",
        "mergeTreeMaxRowsToUseCache": "string",
        "mergeTreeMaxBytesToUseCache": "string",
        "mergeTreeMinRowsForConcurrentRead": "string",
        "mergeTreeMinBytesForConcurrentRead": "string",
        "maxBytesBeforeExternalGroupBy": "string",
        "maxBytesBeforeExternalSort": "string",
        "groupByTwoLevelThreshold": "string",
        "groupByTwoLevelThresholdBytes": "string",
        "priority": "string",
        "maxThreads": "string",
        "maxMemoryUsage": "string",
        "maxMemoryUsageForUser": "string",
        "maxNetworkBandwidth": "string",
        "maxNetworkBandwidthForUser": "string",
        "maxPartitionsPerInsertBlock": "string",
        "maxConcurrentQueriesForUser": "string",
        "forceIndexByDate": "boolean",
        "forcePrimaryKey": "boolean",
        "maxRowsToRead": "string",
        "maxBytesToRead": "string",
        "readOverflowMode": "string",
        "maxRowsToGroupBy": "string",
        "groupByOverflowMode": "string",
        "maxRowsToSort": "string",
        "maxBytesToSort": "string",
        "sortOverflowMode": "string",
        "maxResultRows": "string",
        "maxResultBytes": "string",
        "resultOverflowMode": "string",
        "maxRowsInDistinct": "string",
        "maxBytesInDistinct": "string",
        "distinctOverflowMode": "string",
        "maxRowsToTransfer": "string",
        "maxBytesToTransfer": "string",
        "transferOverflowMode": "string",
        "maxExecutionTime": "string",
        "timeoutOverflowMode": "string",
        "maxRowsInSet": "string",
        "maxBytesInSet": "string",
        "setOverflowMode": "string",
        "maxRowsInJoin": "string",
        "maxBytesInJoin": "string",
        "joinOverflowMode": "string",
        "joinAlgorithm": [
          "string"
        ],
        "anyJoinDistinctRightTableKeys": "boolean",
        "maxColumnsToRead": "string",
        "maxTemporaryColumns": "string",
        "maxTemporaryNonConstColumns": "string",
        "maxQuerySize": "string",
        "maxAstDepth": "string",
        "maxAstElements": "string",
        "maxExpandedAstElements": "string",
        "minExecutionSpeed": "string",
        "minExecutionSpeedBytes": "string",
        "countDistinctImplementation": "string",
        "inputFormatValuesInterpretExpressions": "boolean",
        "inputFormatDefaultsForOmittedFields": "boolean",
        "inputFormatNullAsDefault": "boolean",
        "dateTimeInputFormat": "string",
        "inputFormatWithNamesUseHeader": "boolean",
        "outputFormatJsonQuote_64bitIntegers": "boolean",
        "outputFormatJsonQuoteDenormals": "boolean",
        "dateTimeOutputFormat": "string",
        "lowCardinalityAllowInNativeFormat": "boolean",
        "allowSuspiciousLowCardinalityTypes": "boolean",
        "emptyResultForAggregationByEmptySet": "boolean",
        "httpConnectionTimeout": "string",
        "httpReceiveTimeout": "string",
        "httpSendTimeout": "string",
        "enableHttpCompression": "boolean",
        "sendProgressInHttpHeaders": "boolean",
        "httpHeadersProgressInterval": "string",
        "addHttpCorsHeader": "boolean",
        "cancelHttpReadonlyQueriesOnClientClose": "boolean",
        "maxHttpGetRedirects": "string",
        "joinedSubqueryRequiresAlias": "boolean",
        "joinUseNulls": "boolean",
        "transformNullIn": "boolean",
        "quotaMode": "string",
        "flattenNested": "boolean",
        "formatRegexp": "string",
        "formatRegexpEscapingRule": "string",
        "formatRegexpSkipUnmatched": "boolean",
        "asyncInsert": "boolean",
        "asyncInsertThreads": "string",
        "waitForAsyncInsert": "boolean",
        "waitForAsyncInsertTimeout": "string",
        "asyncInsertMaxDataSize": "string",
        "asyncInsertBusyTimeout": "string",
        "asyncInsertStaleTimeout": "string",
        "memoryProfilerStep": "string",
        "memoryProfilerSampleProbability": "number",
        "maxFinalThreads": "string",
        "inputFormatParallelParsing": "boolean",
        "inputFormatImportNestedJson": "boolean",
        "localFilesystemReadMethod": "string",
        "maxReadBufferSize": "string",
        "insertKeeperMaxRetries": "string",
        "maxTemporaryDataOnDiskSizeForUser": "string",
        "maxTemporaryDataOnDiskSizeForQuery": "string",
        "maxParserDepth": "string",
        "remoteFilesystemReadMethod": "string",
        "memoryOvercommitRatioDenominator": "string",
        "memoryOvercommitRatioDenominatorForUser": "string",
        "memoryUsageOvercommitMaxWaitMicroseconds": "string",
        "logQueryThreads": "boolean",
        "maxInsertThreads": "string",
        "useHedgedRequests": "boolean",
        "idleConnectionTimeout": "string",
        "hedgedConnectionTimeoutMs": "string",
        "loadBalancing": "string",
        "preferLocalhostReplica": "boolean",
        "compile": "boolean",
        "minCountToCompile": "string"
      },
      "quotas": [
        {
          "intervalDuration": "string",
          "queries": "string",
          "errors": "string",
          "resultRows": "string",
          "readRows": "string",
          "executionTime": "string"
        }
      ]
    }
  ],
  "hostSpecs": [
    {
      "zoneId": "string",
      "type": "string",
      "subnetId": "string",
      "assignPublicIp": "boolean",
      "shardName": "string"
    }
  ],
  "networkId": "string",
  "shardName": "string",
  "serviceAccountId": "string",
  "securityGroupIds": [
    "string"
  ],
  "deletionProtection": "boolean",
  "maintenanceWindow": {
    // Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
    "anytime": "object",
    "weeklyMaintenanceWindow": {
      "day": "string",
      "hour": "string"
    }
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create the ClickHouse cluster in. ||
|| name | **string**

Required field. Name of the ClickHouse cluster. The name must be unique within the folder. ||
|| description | **string**

Description of the ClickHouse cluster. ||
|| labels | **string**

Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource.
For example, "project": "mvp" or "source": "dictionary". ||
|| environment | **enum** (Environment)

Required field. Deployment environment of the ClickHouse cluster.

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Stable environment with a conservative update policy:
only hotfixes are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions
are rolled out irrespective of backward compatibility. ||
|| configSpec | **[ConfigSpec](#yandex.cloud.mdb.clickhouse.v1.ConfigSpec)**

Required field. Configuration and resources for hosts that should be created for the ClickHouse cluster. ||
|| databaseSpecs[] | **[DatabaseSpec](#yandex.cloud.mdb.clickhouse.v1.DatabaseSpec)**

Descriptions of databases to be created in the ClickHouse cluster. ||
|| userSpecs[] | **[UserSpec](#yandex.cloud.mdb.clickhouse.v1.UserSpec)**

Descriptions of database users to be created in the ClickHouse cluster. ||
|| hostSpecs[] | **[HostSpec](#yandex.cloud.mdb.clickhouse.v1.HostSpec)**

Individual configurations for hosts that should be created for the ClickHouse cluster. ||
|| networkId | **string**

Required field. ID of the network to create the cluster in. ||
|| shardName | **string**

Name of the first shard in cluster. If not set, defaults to the value 'shard1'. ||
|| serviceAccountId | **string**

ID of the service account used for access to Object Storage. ||
|| securityGroupIds[] | **string**

User security groups ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the cluster ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.clickhouse.v1.MaintenanceWindow)**

Window of maintenance operations. ||
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

## DatabaseSpec {#yandex.cloud.mdb.clickhouse.v1.DatabaseSpec}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the ClickHouse database. 1-63 characters long. ||
|#

## UserSpec {#yandex.cloud.mdb.clickhouse.v1.UserSpec}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the ClickHouse user. ||
|| password | **string**

Required field. Password of the ClickHouse user. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.clickhouse.v1.Permission)**

Set of permissions to grant to the user. If not set, it's granted permissions to access all databases. ||
|| settings | **[UserSettings](#yandex.cloud.mdb.clickhouse.v1.UserSettings)** ||
|| quotas[] | **[UserQuota](#yandex.cloud.mdb.clickhouse.v1.UserQuota)**

Set of quotas assigned to the user. ||
|#

## Permission {#yandex.cloud.mdb.clickhouse.v1.Permission}

#|
||Field | Description ||
|| databaseName | **string**

Name of the database that the permission grants access to. ||
|#

## UserSettings {#yandex.cloud.mdb.clickhouse.v1.UserSettings}

ClickHouse user settings. Supported settings are a limited subset of all settings
described in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/).

#|
||Field | Description ||
|| readonly | **string** (int64)

Restricts permissions for non-DDL queries. To restrict permissions for DDL queries, use `allowDdl` instead.
* **0** (default)-no restrictions.
* **1**-only read data queries are allowed.
* **2**-read data and change settings queries are allowed.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/permissions-for-queries/#settings_readonly). ||
|| allowDdl | **boolean**

Determines whether DDL queries are allowed (e.g., **CREATE**, **ALTER**, **RENAME**, etc).

Default value: **true**.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/permissions-for-queries/#settings_allow_ddl). ||
|| allowIntrospectionFunctions | **boolean**

Enables [introspections functions](https://clickhouse.com/docs/en/sql-reference/functions/introspection) for query profiling.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-allow_introspection_functions). ||
|| connectTimeout | **string** (int64)

Connection timeout in milliseconds.

Value must be greater than **0** (default: **10000**, 10 seconds). ||
|| connectTimeoutWithFailover | **string** (int64)

The timeout in milliseconds for connecting to a remote server for a Distributed table engine. Applies only if the cluster uses sharding and replication. If unsuccessful, several attempts are made to connect to various replicas.

Default value: **50**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#connect-timeout-with-failover-ms). ||
|| receiveTimeout | **string** (int64)

Receive timeout in milliseconds.

Value must be greater than **0** (default: **300000**, 300 seconds or 5 minutes). ||
|| sendTimeout | **string** (int64)

Send timeout in milliseconds.

Value must be greater than **0** (default: **300000**, 300 seconds or 5 minutes). ||
|| timeoutBeforeCheckingExecutionSpeed | **string** (int64)

Timeout (in seconds) between checks of execution speed. It is checked that execution speed is not less that specified in `minExecutionSpeed` parameter.

Default value: **10**. ||
|| insertQuorum | **string** (int64)

Enables or disables write quorum for ClickHouse cluster.
If the value is less than **2**, then write quorum is disabled, otherwise it is enabled.

When used, write quorum guarantees that ClickHouse has written data to the quorum of **insert_quorum** replicas with no errors until the `insertQuorumTimeout` expires.
All replicas in the quorum are in the consistent state, meaning that they contain linearized data from the previous **INSERT** queries.
Employ write quorum, if you need the guarantees that the written data would not be lost in case of one or more replicas failure.

You can use `selectSequentialConsistency` setting to read the data written with write quorum.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-insert_quorum). ||
|| insertQuorumTimeout | **string** (int64)

Quorum write timeout in milliseconds.

If the write quorum is enabled in the cluster, this timeout expires and some data is not written to the `insertQuorum` replicas, then ClickHouse will abort the execution of **INSERT** query and return an error.
In this case, the client must send the query again to write the data block into the same or another replica.

Minimum value: **1000**, 1 second (default: **60000**, 1 minute). ||
|| insertQuorumParallel | **boolean**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-insert_quorum_parallel). ||
|| insertNullAsDefault | **boolean**

Enables the insertion of default values instead of NULL into columns with not nullable data type.

Default value: **true**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#insert_null_as_default). ||
|| selectSequentialConsistency | **boolean**

Determines the behavior of **SELECT** queries from the replicated table: if enabled, ClickHouse will terminate a query with error message in case the replica does not have a chunk written with the quorum and will not read the parts that have not yet been written with the quorum.

Default value: **false** (sequential consistency is disabled). ||
|| deduplicateBlocksInDependentMaterializedViews | **boolean**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-deduplicate-blocks-in-dependent-materialized-views). ||
|| replicationAlterPartitionsSync | **string** (int64)

Wait mode for asynchronous actions in **ALTER** queries on replicated tables:

* **0**-do not wait for replicas.
* **1**-only wait for own execution (default).
* **2**-wait for all replicas.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/sql-reference/statements/alter/#synchronicity-of-alter-queries). ||
|| maxReplicaDelayForDistributedQueries | **string** (int64)

Max replica delay in milliseconds. If a replica lags more than the set value, this replica is not used and becomes a stale one.

Minimum value: **1000**, 1 second (default: **300000**, 300 seconds or 5 minutes).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_replica_delay_for_distributed_queries). ||
|| fallbackToStaleReplicasForDistributedQueries | **boolean**

Enables or disables query forcing to a stale replica in case the actual data is unavailable.
If enabled, ClickHouse will choose the most up-to-date replica and force the query to use the data in this replica.
This setting can be used when doing **SELECT** query from a distributed table that points to replicated tables.

Default value: **true** (query forcing is enabled).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-fallback_to_stale_replicas_for_distributed_queries). ||
|| distributedProductMode | **enum** (DistributedProductMode)

Determine the behavior of distributed subqueries.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#distributed-product-mode).

- `DISTRIBUTED_PRODUCT_MODE_UNSPECIFIED`
- `DISTRIBUTED_PRODUCT_MODE_DENY`: Default value. Prohibits using these types of subqueries (returns the "Double-distributed in/JOIN subqueries is denied" exception).
- `DISTRIBUTED_PRODUCT_MODE_LOCAL`: Replaces the database and table in the subquery with local ones for the destination server (shard), leaving the normal IN/JOIN.
- `DISTRIBUTED_PRODUCT_MODE_GLOBAL`: Replaces the IN/JOIN query with GLOBAL IN/GLOBAL JOIN.
- `DISTRIBUTED_PRODUCT_MODE_ALLOW`: Allows the use of these types of subqueries. ||
|| distributedAggregationMemoryEfficient | **boolean**

Enables of disables memory saving mode when doing distributed aggregation.

When ClickHouse works with a distributed query, external aggregation is done on remote servers.
Enable this setting to achieve a smaller memory footprint on the server that sourced such a distributed query.

Default value: **false** (memory saving mode is disabled).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/sql-reference/statements/select/group-by/#select-group-by-in-external-memory). ||
|| distributedDdlTaskTimeout | **string** (int64)

Timeout for DDL queries, in milliseconds. ||
|| skipUnavailableShards | **boolean**

Enables or disables silent skipping of unavailable shards.

A shard is considered unavailable if all its replicas are also unavailable.

Default value: **false** (silent skipping is disabled).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-skip_unavailable_shards). ||
|| compileExpressions | **boolean**

Enables or disables expression compilation.
If you execute a lot of queries that contain identical expressions, then enable this setting.
As a result, such queries may be executed faster due to use of compiled expressions.

Use this setting in combination with `minCountToCompileExpression` setting.

Default value: **false** (expression compilation is disabled). ||
|| minCountToCompileExpression | **string** (int64)

How many identical expressions ClickHouse has to encounter before they are compiled.

Minimum value: **0** (default: **3**).

For the **0** value compilation is synchronous: a query waits for expression compilation process to complete prior to continuing execution.
It is recommended to set this value only for testing purposes.

For all other values, compilation is asynchronous: the compilation process executes in a separate thread.
When a compiled expression is ready, it will be used by ClickHouse for eligible queries, including the ones that are currently running. ||
|| maxBlockSize | **string** (int64)

The maximum block size for reading.

Data in ClickHouse is organized and processed by blocks (block is a set of columns' parts).
The internal processing cycles for a single block are efficient enough, but there are noticeable expenditures on each block.

This setting is a recommendation for size of block (in a count of rows) that should be loaded from tables.

Value must be greater than **0** (default: **65536**).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#setting-max_block_size). ||
|| minInsertBlockSizeRows | **string** (int64)

Limits the minimum number of rows in a block to be inserted in a table by **INSERT** query.
Blocks that are smaller than the specified value, will be squashed together into the bigger blocks.

Minimal value: **0**, block squashing is disabled (default: **1048576**). ||
|| minInsertBlockSizeBytes | **string** (int64)

Limits the minimum number of bytes in a block to be inserted in a table by **INSERT** query.
Blocks that are smaller than the specified value, will be squashed together into the bigger blocks.

Minimal value: **0**, block squashing is disabled (default: **268435456**, 256 MB). ||
|| maxInsertBlockSize | **string** (int64)

Allows to form blocks of the specified size (in bytes) when inserting data in a table.
This setting has effect only if server is creating such blocks by itself.

Value must be greater than **0** (default: **1048576**).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_insert_block_size). ||
|| minBytesToUseDirectIo | **string** (int64)

Limits the minimum number of bytes to enable unbuffered direct reads from disk (Direct I/O).

By default, ClickHouse does not read data directly from disk, but relies on the filesystem and its cache instead.
Such reading strategy is effective when the data volume is small.
If the amount of the data to read is huge, it is more effective to read directly from the disk, bypassing the filesystem cache.

If the total amount of the data to read is greater than the value of this setting, then ClickHouse will fetch this data directly from the disk.

Minimal value and default value: **0**, Direct I/O is disabled. ||
|| useUncompressedCache | **boolean**

Determines whether to use the cache of uncompressed blocks, or not.
Using this cache can significantly reduce latency and increase the throughput when a huge amount of small queries is to be processed.
Enable this setting for the users who instantiates small queries frequently.

This setting has effect only for tables of the MergeTree family.

Default value: **false** (uncompressed cache is disabled).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#setting-use_uncompressed_cache). ||
|| mergeTreeMaxRowsToUseCache | **string** (int64)

Limits the maximum size in rows of the request that can use the cache of uncompressed data. The cache is not used for requests larger
than the specified value.

Use this setting in combination with `useUncompressedCache` setting.

Value must be greater than **0** (default: **128x8192**). ||
|| mergeTreeMaxBytesToUseCache | **string** (int64)

Limits the maximum size in bytes of the request that can use the cache of uncompressed data. The cache is not used for requests larger
than the specified value.

Use this setting in combination with `useUncompressedCache` setting.

Value must be greater than **0** (default: **192x10x1024x1024**). ||
|| mergeTreeMinRowsForConcurrentRead | **string** (int64)

Limits the minimum number of rows to be read from a file to enable concurrent read.
If the number of rows to be read exceeds this value, then ClickHouse will try to use a few threads to read from a file concurrently.

This setting has effect only for tables of the MergeTree family.

Value must be greater than **0** (default: **20x8192**). ||
|| mergeTreeMinBytesForConcurrentRead | **string** (int64)

Limits the number of bytes to be read from a file to enable concurrent read.
If the number of bytes to be read exceeds this value, then ClickHouse will try to use a few threads to read from a file concurrently.

This setting has effect only for tables of the MergeTree family.

Value must be greater than **0** (default: **24x10x1024x1024**). ||
|| maxBytesBeforeExternalGroupBy | **string** (int64)

Sets the threshold of RAM consumption (in bytes) after that the temporary data, collected during the **GROUP BY** operation, should be flushed to disk to limit the RAM comsumption.

By default, aggregation is done by employing hash table that resides in RAM.
A query can result in aggregation of huge data volumes that can lead to memory exhaustion and abortion of the query (see the `maxMemoryUsage` setting).
For such queries, you can use this setting to force ClickHouse to do flushing and complete aggregation successfully.

Minimal value and default value: **0**, **GROUP BY** in the external memory is disabled.

When using aggregation in external memory, it is recommended to set the value of this setting twice as low as the `maxMemoryUsage` setting value (by default, the maximum memory usage is limited to ten gigabytes).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/sql-reference/statements/select/group-by/#select-group-by-in-external-memory).

See also: the `distributedAggregationMemoryEfficient` setting. ||
|| maxBytesBeforeExternalSort | **string** (int64)

This setting is equivalent of the `maxBytesBeforeExternalGroupBy` setting, except for it is for sort operation (**ORDER BY**), not aggregation. ||
|| groupByTwoLevelThreshold | **string** (int64)

Sets the threshold of the number of keys, after that the two-level aggregation should be used.

Minimal value: **0**, threshold is not set (default: **10000**). ||
|| groupByTwoLevelThresholdBytes | **string** (int64)

Sets the threshold of the number of bytes, after that the two-level aggregation should be used.

Minimal value: **0**, threshold is not set (default: **100000000**). ||
|| priority | **string** (int64)

Sets the priority of a query.

* **0**-priority is not used.
* **1**-the highest priority.
* and so on. The higher the number, the lower a query's priority.

This setting should be set up for each query individually.

If ClickHouse is working with the high-priority queries, and a low-priority query enters, then the low-priority query is paused until higher-priority queries are completed.

Minimal value and default value: **0**, priority is not used. ||
|| maxThreads | **string** (int64)

Limits the maximum number of threads to process the request (setting does not take threads that read data from remote servers into account).

This setting applies to threads that perform the same stages of the query processing pipeline in parallel.

Minimal value and default value: **0** (the thread number is calculated automatically based on the number of physical CPU cores, no HyperThreading cores are taken into account).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_threads). ||
|| maxMemoryUsage | **string** (int64)

Limits the maximum memory usage (in bytes) for processing of a single user's query on a single server.
This setting does not take server's free RAM amount or total RAM amount into account.

This limitation is enforced for any user's single query on a single server.

Minimal value: **0**, no limitation is set.
Value that is set in the ClickHouse default config file: **10737418240** (10 GB).

If you use `maxBytesBeforeExternalGroupBy` or `maxBytesBeforeExternalSort` setting, then it is recommended to set their values twice as low as `maxMemoryUsage` setting value.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity/#settings_max_memory_usage). ||
|| maxMemoryUsageForUser | **string** (int64)

Limits the maximum memory usage (in bytes) for processing of user's queries on a single server.
This setting does not take server's free RAM amount or total RAM amount into account.

This limitation is enforced for all queries that belong to one user and run simultaneously on a single server.

Minimal value and default value: **0**, no limitation is set. ||
|| maxNetworkBandwidth | **string** (int64)

The maximum speed of data exchange over the network in bytes per second for a query.

Minimal value and default value: **0**, no limitation is set. ||
|| maxNetworkBandwidthForUser | **string** (int64)

The maximum speed of data exchange over the network in bytes per second for all concurrently running user queries.

Minimal value and default value: **0**, no limitation is set. ||
|| maxPartitionsPerInsertBlock | **string** (int64)

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/ru/operations/settings/query-complexity/#max-partitions-per-insert-block). ||
|| maxConcurrentQueriesForUser | **string** (int64)

The maximum number of concurrent requests per user.
Default value: 0 (no limit). ||
|| forceIndexByDate | **boolean**

If enabled, query is not executed if the ClickHouse can't use index by date.
This setting has effect only for tables of the MergeTree family.

Default value: **false** (setting is disabled, query executes even if ClickHouse can't use index by date).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-force_index_by_date). ||
|| forcePrimaryKey | **boolean**

If enabled, query is not executed if the ClickHouse can't use index by primary key.
This setting has effect only for tables of the MergeTree family.

Default value: **false** (setting is disabled, query executes even if ClickHouse can't use index by primary key).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#force-primary-key). ||
|| maxRowsToRead | **string** (int64)

Limits the maximum number of rows that can be read from a table when running a query.

Minimal value and default value: **0**, no limitation is set.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity/#max-rows-to-read). ||
|| maxBytesToRead | **string** (int64)

Limits the maximum number of bytes (uncompressed data) that can be read from a table when running a query.

Minimal value and default value: **0**, no limitation is set. ||
|| readOverflowMode | **enum** (OverflowMode)

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while reading the data.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxRowsToGroupBy | **string** (int64)

Limits the maximum number of unique keys received from aggregation function.
This setting helps to reduce RAM consumption while doing aggregation.

Minimal value and default value: **0**, no limitation is set. ||
|| groupByOverflowMode | **enum** (GroupByOverflowMode)

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while doing aggregation.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.
* **any**-perform approximate **GROUP BY** operation by continuing aggregation for the keys that got into the set, but don't add new keys to the set.

- `GROUP_BY_OVERFLOW_MODE_UNSPECIFIED`
- `GROUP_BY_OVERFLOW_MODE_THROW`
- `GROUP_BY_OVERFLOW_MODE_BREAK`
- `GROUP_BY_OVERFLOW_MODE_ANY` ||
|| maxRowsToSort | **string** (int64)

Limits the maximum number of rows that can be read from a table for sorting.
This setting helps to reduce RAM consumption.

Minimal value and default value: **0**, no limitation is set. ||
|| maxBytesToSort | **string** (int64)

Limits the maximum number of bytes (uncompressed data) that can be read from a table for sorting.
This setting helps to reduce RAM consumption.

Minimal value and default value: **0**, no limitation is set. ||
|| sortOverflowMode | **enum** (OverflowMode)

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while sorting.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxResultRows | **string** (int64)

Limits the number of rows in the result.
This limitation is also checked for subqueries and parts of distributed queries that run on remote servers.

Minimal value and default value: **0**, no limitation is set. ||
|| maxResultBytes | **string** (int64)

Limits the number of bytes in the result.
This limitation is also checked for subqueries and parts of distributed queries that run on remote servers.

Minimal value and default value: **0**, no limitation is set. ||
|| resultOverflowMode | **enum** (OverflowMode)

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while forming result.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxRowsInDistinct | **string** (int64)

Limits the maximum number of different rows when using **DISTINCT**.

Minimal value and default value: **0**, no limitation is set. ||
|| maxBytesInDistinct | **string** (int64)

Limits the maximum size of a hash table in bytes (uncompressed data) when using **DISTINCT**. ||
|| distinctOverflowMode | **enum** (OverflowMode)

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while doing **DISCTINCT**.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxRowsToTransfer | **string** (int64)

Limits the maximum number of rows that can be passed to a remote server or saved in a temporary table when using **GLOBAL IN**.

Minimal value and default value: **0**, no limitation is set. ||
|| maxBytesToTransfer | **string** (int64)

Limits the maximum number of bytes (uncompressed data) that can be passed to a remote server or saved in a temporary
table when using **GLOBAL IN**.

Minimal value and default value: **0**, no limitation is set. ||
|| transferOverflowMode | **enum** (OverflowMode)

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) while doing transfers.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxExecutionTime | **string** (int64)

Limits the maximum query execution time in milliseconds.
At this moment, this limitation is not checked when passing one of the sorting stages, as well as merging and finalizing aggregation funictions.

Minimal value and default value: **0**, no limitation is set. ||
|| timeoutOverflowMode | **enum** (OverflowMode)

Determines the behavior on exceeding [limits](https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity) of execution time.

* **throw**-abort query execution, return an error.
* **break**-stop query execution, return partial result.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxRowsInSet | **string** (int64)

Limit on the number of rows in the set resulting from the execution of the IN section. ||
|| maxBytesInSet | **string** (int64)

Limit on the number of bytes in the set resulting from the execution of the IN section. ||
|| setOverflowMode | **enum** (OverflowMode)

Determine the behavior on exceeding max_rows_in_set or max_bytes_in_set limit.
Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxRowsInJoin | **string** (int64)

Limit on maximum size of the hash table for JOIN, in rows. ||
|| maxBytesInJoin | **string** (int64)

Limit on maximum size of the hash table for JOIN, in bytes. ||
|| joinOverflowMode | **enum** (OverflowMode)

Determine the behavior on exceeding max_rows_in_join or max_bytes_in_join limit.
Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.

- `OVERFLOW_MODE_UNSPECIFIED`
- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| joinAlgorithm[] | **enum** (JoinAlgorithm)

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-join_algorithm).

- `JOIN_ALGORITHM_UNSPECIFIED`
- `JOIN_ALGORITHM_HASH`
- `JOIN_ALGORITHM_PARALLEL_HASH`
- `JOIN_ALGORITHM_PARTIAL_MERGE`
- `JOIN_ALGORITHM_DIRECT`
- `JOIN_ALGORITHM_AUTO`
- `JOIN_ALGORITHM_FULL_SORTING_MERGE`
- `JOIN_ALGORITHM_PREFER_PARTIAL_MERGE` ||
|| anyJoinDistinctRightTableKeys | **boolean**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#any_join_distinct_right_table_keys). ||
|| maxColumnsToRead | **string** (int64)

Limits the maximum number of columns that can be read from a table in a single query.
If the query requires to read more columns to complete, then it will be aborted.

Minimal value and default value: **0**, no limitation is set. ||
|| maxTemporaryColumns | **string** (int64)

Limits the maximum number of temporary columns that must be kept in RAM at the same time when running a query, including constant columns.

Minimal value and default value: **0**, no limitation is set. ||
|| maxTemporaryNonConstColumns | **string** (int64)

Limits the maximum number of temporary columns that must be kept in RAM at the same time when running a query, excluding constant columns.

Minimal value and default value: **0**, no limitation is set. ||
|| maxQuerySize | **string** (int64)

Limits the size of the part of a query that can be transferred to RAM for parsing with the SQL parser, in bytes.

Value must be greater than **0** (default: **262144**).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_query_size). ||
|| maxAstDepth | **string** (int64)

Limits the maximum depth of query syntax tree.

Executing a big and complex query may result in building a syntax tree of enormous depth.
By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.

For example, the **SELECT *** query may result in more complex and deeper syntax tree, compared to the **SELECT ... WHERE ...** query, containing constraints and conditions, in the most cases.
A user can be forced to construct more optimized queries, if this setting is used.

Value must be greater than **0** (default: **1000**).
If a too small value is set, it may render ClickHouse unable to execute even simple queries.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity/#max-ast-depth). ||
|| maxAstElements | **string** (int64)

Limits the maximum size of query syntax tree in number of nodes.

Executing a big and complex query may result in building a syntax tree of enormous size.
By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.

Value must be greater than **0** (default: **50000**).
If a too small value is set, it may render ClickHouse unable to execute even simple queries.

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity/#max-ast-elements). ||
|| maxExpandedAstElements | **string** (int64)

Limits the maximum size of query syntax tree in number of nodes after expansion of aliases and the asterisk values.

Executing a big and complex query may result in building a syntax tree of enormous size.
By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.

Value must be greater than **0** (default: **500000**).
If a too small value is set, it may render ClickHouse unable to execute even simple queries. ||
|| minExecutionSpeed | **string** (int64)

Minimal execution speed in rows per second. ||
|| minExecutionSpeedBytes | **string** (int64)

Minimal execution speed in bytes per second. ||
|| countDistinctImplementation | **enum** (CountDistinctImplementation)

Aggregate function to use for implementation of count(DISTINCT ...).

- `COUNT_DISTINCT_IMPLEMENTATION_UNSPECIFIED`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_COMBINED`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_COMBINED_64`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_HLL_12`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_EXACT` ||
|| inputFormatValuesInterpretExpressions | **boolean**

Enables or disables SQL parser if the fast stream parser cannot parse the data.

Enable this setting, if the data that you want to insert into a table contains SQL expressions.

For example, the stream parser is unable to parse a value that contains **now()** expression; therefore an **INSERT** query for this value will fail and no data will be inserted into a table.
With enabled SQL parser, this expression is parsed correctly: the **now()** expression will be parsed as SQL function, interpreted, and the current date and time will be inserted into the table as a result.

This setting has effect only if you use [Values](https://clickhouse.com/docs/en/interfaces/formats/#data-format-values) format when inserting data.

Default value: **true** (SQL parser is enabled).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#settings-input_format_values_interpret_expressions). ||
|| inputFormatDefaultsForOmittedFields | **boolean**

Enables or disables replacing omitted input values with default values of the respective columns when performing **INSERT** queries.

Default value: **true** (replacing is enabled). ||
|| inputFormatNullAsDefault | **boolean**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#input_format_null_as_default). ||
|| dateTimeInputFormat | **enum** (DateTimeInputFormat)

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#date_time_input_format).

- `DATE_TIME_INPUT_FORMAT_UNSPECIFIED`
- `DATE_TIME_INPUT_FORMAT_BEST_EFFORT`
- `DATE_TIME_INPUT_FORMAT_BASIC`
- `DATE_TIME_INPUT_FORMAT_BEST_EFFORT_US` ||
|| inputFormatWithNamesUseHeader | **boolean**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#input_format_with_names_use_header). ||
|| outputFormatJsonQuote_64bitIntegers | **boolean**

Enables quoting of 64-bit integers in JSON output format.

If this setting is enabled, then 64-bit integers (**UInt64** and **Int64**) will be quoted when written to JSON output in order to maintain compatibility with the most of the JavaScript engines.
Otherwise, such integers will not be quoted.

Default value: **false** (quoting 64-bit integers is disabled). ||
|| outputFormatJsonQuoteDenormals | **boolean**

Enables special floating-point values (**+nan**, **-nan**, **+inf** and **-inf**) in JSON output format.

Default value: **false** (special values do not present in output). ||
|| dateTimeOutputFormat | **enum** (DateTimeOutputFormat)

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#date_time_output_format).

- `DATE_TIME_OUTPUT_FORMAT_UNSPECIFIED`
- `DATE_TIME_OUTPUT_FORMAT_SIMPLE`
- `DATE_TIME_OUTPUT_FORMAT_ISO`
- `DATE_TIME_OUTPUT_FORMAT_UNIX_TIMESTAMP` ||
|| lowCardinalityAllowInNativeFormat | **boolean**

Determines whether to use LowCardinality type in Native format.

* **true** (default)-yes, use.
* **false**-convert LowCardinality columns to regular columns when doing **SELECT**, and convert regular columns to LowCardinality when doing **INSERT**.

LowCardinality columns (aka sparse columns) store data in more effective way, compared to regular columns, by using hash tables.
If data to insert suits this storage format, ClickHouse will place them into LowCardinality column.

If you use a third-party ClickHouse client that can't work with LowCardinality columns, then this client will not be able to correctly interpret the result of the query that asks for data stored in LowCardinality column.
Disable this setting to convert LowCardinality column to regular column when creating the result, so such clients will be able to process the result.

Official ClickHouse client works with LowCardinality columns out-of-the-box.

Default value: **true** (LowCardinality columns are used in Native format). ||
|| allowSuspiciousLowCardinalityTypes | **boolean**

Allows specifying **LowCardinality** modifier for types of small fixed size (8 or less) in CREATE TABLE statements. Enabling this may increase merge times and memory consumption.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#allow_suspicious_low_cardinality_types). ||
|| emptyResultForAggregationByEmptySet | **boolean**

Enables returning of empty result when aggregating without keys (with **GROUP BY** operation absent) on empty set (e.g., **SELECT count(*) FROM table WHERE 0**).

* **true**-ClickHouse will return an empty result for such queries.
* **false** (default)-ClickHouse will return a single-line result consisting of **NULL** values for aggregation functions, in accordance with SQL standard. ||
|| httpConnectionTimeout | **string** (int64)

HTTP connection timeout, in milliseconds.

Value must be greater than **0** (default: **1000**, 1 second). ||
|| httpReceiveTimeout | **string** (int64)

HTTP receive timeout, in milliseconds.

Value must be greater than **0** (default: **1800000**, 1800 seconds, 30 minutes). ||
|| httpSendTimeout | **string** (int64)

HTTP send timeout, in milliseconds.

Value must be greater than **0** (default: **1800000**, 1800 seconds, 30 minutes). ||
|| enableHttpCompression | **boolean**

Enables or disables data compression in HTTP responses.

By default, ClickHouse stores data compressed. When executing a query, its result is uncompressed.
Use this setting to command ClickHouse to compress the result when sending it via HTTP.

Enable this setting and add the **Accept-Encoding: <compression method>** HTTP header in a HTTP request to force compression of HTTP response from ClickHouse.

ClickHouse support the following compression methods: **gzip**, **br** and **deflate**.

Default value: **false** (compression is disabled).

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/interfaces/http/). ||
|| sendProgressInHttpHeaders | **boolean**

Enables progress notifications using **X-ClickHouse-Progress** HTTP header.

Default value: **false** (notifications disabled). ||
|| httpHeadersProgressInterval | **string** (int64)

Minimum interval between progress notifications with **X-ClickHouse-Progress** HTTP header, in milliseconds.

Value must be greater than **0** (default: **100**). ||
|| addHttpCorsHeader | **boolean**

Adds CORS header in HTTP responses.

Default value: **false** (header is not added). ||
|| cancelHttpReadonlyQueriesOnClientClose | **boolean**

Cancels HTTP read-only queries (e.g. SELECT) when a client closes the connection without waiting for the response.

Default value: **false**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#cancel-http-readonly-queries-on-client-close). ||
|| maxHttpGetRedirects | **string** (int64)

Limits the maximum number of HTTP GET redirect hops for [URL-engine](https://clickhouse.com/docs/en/engines/table-engines/special/url) tables.

If the parameter is set to **0** (default), no hops is allowed.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#setting-max_http_get_redirects). ||
|| joinedSubqueryRequiresAlias | **boolean** ||
|| joinUseNulls | **boolean** ||
|| transformNullIn | **boolean** ||
|| quotaMode | **enum** (QuotaMode)

Quota accounting mode. Possible values: QUOTA_MODE_DEFAULT, QUOTA_MODE_KEYED and QUOTA_MODE_KEYED_BY_IP.

- `QUOTA_MODE_UNSPECIFIED`
- `QUOTA_MODE_DEFAULT`
- `QUOTA_MODE_KEYED`
- `QUOTA_MODE_KEYED_BY_IP` ||
|| flattenNested | **boolean**

Sets the data format of a [nested](https://clickhouse.com/docs/en/sql-reference/data-types/nested-data-structures/nested) columns.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#flatten-nested). ||
|| formatRegexp | **string**

Regular expression (for Regexp format) ||
|| formatRegexpEscapingRule | **enum** (FormatRegexpEscapingRule)

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#format_regexp_escaping_rule).

- `FORMAT_REGEXP_ESCAPING_RULE_UNSPECIFIED`
- `FORMAT_REGEXP_ESCAPING_RULE_ESCAPED`
- `FORMAT_REGEXP_ESCAPING_RULE_QUOTED`
- `FORMAT_REGEXP_ESCAPING_RULE_CSV`
- `FORMAT_REGEXP_ESCAPING_RULE_JSON`
- `FORMAT_REGEXP_ESCAPING_RULE_XML`
- `FORMAT_REGEXP_ESCAPING_RULE_RAW` ||
|| formatRegexpSkipUnmatched | **boolean**

See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#format_regexp_skip_unmatched). ||
|| asyncInsert | **boolean**

Enables asynchronous inserts.

Disabled by default.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#async-insert). ||
|| asyncInsertThreads | **string** (int64)

The maximum number of threads for background data parsing and insertion.

If the parameter is set to **0**, asynchronous insertions are disabled. Default value: **16**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#async-insert-threads). ||
|| waitForAsyncInsert | **boolean**

Enables waiting for processing of asynchronous insertion. If enabled, server returns OK only after the data is inserted.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#wait-for-async-insert). ||
|| waitForAsyncInsertTimeout | **string** (int64)

The timeout (in seconds) for waiting for processing of asynchronous insertion.

Default value: **120**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#wait-for-async-insert-timeout). ||
|| asyncInsertMaxDataSize | **string** (int64)

The maximum size of the unparsed data in bytes collected per query before being inserted.

If the parameter is set to **0**, asynchronous insertions are disabled. Default value: **100000**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#async-insert-max-data-size). ||
|| asyncInsertBusyTimeout | **string** (int64)

The maximum timeout in milliseconds since the first INSERT query before inserting collected data.

If the parameter is set to **0**, the timeout is disabled. Default value: **200**.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#async-insert-busy-timeout-ms). ||
|| asyncInsertStaleTimeout | **string** (int64)

The maximum timeout in milliseconds since the last INSERT query before dumping collected data. If enabled, the settings prolongs the `asyncInsertBusyTimeout` with every INSERT query as long as `asyncInsertMaxDataSize` is not exceeded.

More info see in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings/#async-insert-stale-timeout-ms). ||
|| memoryProfilerStep | **string** (int64)

Memory profiler step (in bytes).

If the next query step requires more memory than this parameter specifies, the memory profiler collects the allocating stack trace. Values lower than a few megabytes slow down query processing.

Default value: **4194304** (4 MB). Zero means disabled memory profiler. ||
|| memoryProfilerSampleProbability | **number** (double)

Collect random allocations and deallocations and write them into system.trace_log with 'MemorySample' trace_type. The probability is for every alloc/free regardless to the size of the allocation.

Possible values: from **0** to **1**. Default: **0**. ||
|| maxFinalThreads | **string** (int64)

Sets the maximum number of parallel threads for the SELECT query data read phase with the FINAL modifier.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#max-final-threads). ||
|| inputFormatParallelParsing | **boolean**

Enables or disables order-preserving parallel parsing of data formats. Supported only for [TSV](https://clickhouse.com/docs/en/interfaces/formats#tabseparated), [TKSV](https://clickhouse.com/docs/en/interfaces/formats#tskv), [CSV](https://clickhouse.com/docs/en/interfaces/formats#csv) and [JSONEachRow](https://clickhouse.com/docs/en/interfaces/formats#jsoneachrow) formats.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#input-format-parallel-parsing) ||
|| inputFormatImportNestedJson | **boolean**

Enables or disables the insertion of JSON data with nested objects.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#input-format-parallel-parsing) ||
|| localFilesystemReadMethod | **enum** (LocalFilesystemReadMethod)

Method of reading data from local filesystem, one of: read, pread, mmap, io_uring, pread_threadpool. The 'io_uring' method is experimental and does not work for Log, TinyLog, StripeLog, File, Set and Join, and other tables with append-able files in presence of concurrent reads and writes.

- `LOCAL_FILESYSTEM_READ_METHOD_UNSPECIFIED`
- `LOCAL_FILESYSTEM_READ_METHOD_READ`
- `LOCAL_FILESYSTEM_READ_METHOD_PREAD_THREADPOOL`
- `LOCAL_FILESYSTEM_READ_METHOD_PREAD`
- `LOCAL_FILESYSTEM_READ_METHOD_NMAP` ||
|| maxReadBufferSize | **string** (int64)

The maximum size of the buffer to read from the filesystem.
See in-depth description in [ClickHouse documentation](https://clickhouse.com/codebrowser/ClickHouse/src/Core/Settings.h.html#DB::SettingsTraits::Data::max_read_buffer_size) ||
|| insertKeeperMaxRetries | **string** (int64)

The setting sets the maximum number of retries for ClickHouse Keeper (or ZooKeeper) requests during insert into replicated MergeTree. Only Keeper requests which failed due to network error, Keeper session timeout, or request timeout are considered for retries.
Default: 20 from 23.2, 0(disabled) before
Min_version: 22.11
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#insert_keeper_max_retries) ||
|| maxTemporaryDataOnDiskSizeForUser | **string** (int64)

The maximum amount of data consumed by temporary files on disk in bytes for all concurrently running user queries. Zero means unlimited.
Default: 0 - unlimited
Min_version: 22.10
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity#settings_max_temporary_data_on_disk_size_for_user) ||
|| maxTemporaryDataOnDiskSizeForQuery | **string** (int64)

The maximum amount of data consumed by temporary files on disk in bytes for all concurrently running queries. Zero means unlimited.
Default: 0 - unlimited
Min_version: 22.10
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/query-complexity#settings_max_temporary_data_on_disk_size_for_query) ||
|| maxParserDepth | **string** (int64)

Limits maximum recursion depth in the recursive descent parser. Allows controlling the stack size.
Default: 1000
Special: 0 - unlimited
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#max_parser_depth) ||
|| remoteFilesystemReadMethod | **enum** (RemoteFilesystemReadMethod)

Method of reading data from remote filesystem, one of: read, threadpool.
Default: read
Min_version: 21.11
See in-depth description in [ClickHouse GitHub](https://github.com/ClickHouse/ClickHouse/blob/f9558345e886876b9132d9c018e357f7fa9b22a3/src/Core/Settings.h#L660)

- `REMOTE_FILESYSTEM_READ_METHOD_UNSPECIFIED`
- `REMOTE_FILESYSTEM_READ_METHOD_READ`
- `REMOTE_FILESYSTEM_READ_METHOD_THREADPOOL` ||
|| memoryOvercommitRatioDenominator | **string** (int64)

It represents soft memory limit in case when hard limit is reached on user level. This value is used to compute overcommit ratio for the query. Zero means skip the query.
Default: 1GiB
Min_version: 22.5
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#memory_overcommit_ratio_denominator) ||
|| memoryOvercommitRatioDenominatorForUser | **string** (int64)

It represents soft memory limit in case when hard limit is reached on global level. This value is used to compute overcommit ratio for the query. Zero means skip the query.
Default: 1GiB
Min_version: 22.5
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#memory_overcommit_ratio_denominator_for_user) ||
|| memoryUsageOvercommitMaxWaitMicroseconds | **string** (int64)

Maximum time thread will wait for memory to be freed in the case of memory overcommit on a user level. If the timeout is reached and memory is not freed, an exception is thrown.
Default: 5000000
Min_version: 22.5
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#memory_usage_overcommit_max_wait_microseconds) ||
|| logQueryThreads | **boolean**

Setting up query threads logging. Query threads log into the [system.query_thread_log](https://clickhouse.com/docs/en/operations/system-tables/query_thread_log) table. This setting has effect only when [log_queries](https://clickhouse.com/docs/en/operations/settings/settings#log-queries) is true. Queries threads run by ClickHouse with this setup are logged according to the rules in the [query_thread_log](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#server_configuration_parameters-query_thread_log) server configuration parameter.
Default: true
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#log_query_threads) ||
|| maxInsertThreads | **string** (int64)

The maximum number of threads to execute the INSERT SELECT query.
Default: 0
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#max_insert_threads) ||
|| useHedgedRequests | **boolean**

Enables hedged requests logic for remote queries. It allows to establish many connections with different replicas for query. New connection is enabled in case existent connection(s) with replica(s) were not established within hedged_connection_timeout or no data was received within receive_data_timeout. Query uses the first connection which send non empty progress packet (or data packet, if allow_changing_replica_until_first_data_packet); other connections are cancelled. Queries with max_parallel_replicas > 1 are supported.
Default: true
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#use_hedged_requests) ||
|| idleConnectionTimeout | **string** (int64)

Timeout to close idle TCP connections after specified number of milliseconds.
Default: 360000 (3600 seconds)
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#idle_connection_timeout) ||
|| hedgedConnectionTimeoutMs | **string** (int64)

Connection timeout for establishing connection with replica for Hedged requests.
Default: 50
See in-depth description in [ClickHouse GitHub](https://github.com/ClickHouse/ClickHouse/blob/f9558345e886876b9132d9c018e357f7fa9b22a3/src/Core/Settings.h#L64) ||
|| loadBalancing | **enum** (LoadBalancing)

Specifies the algorithm of replicas selection that is used for distributed query processing, one of: random, nearest_hostname, in_order, first_or_random, round_robin.
Default: random
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#load_balancing)

- `LOAD_BALANCING_UNSPECIFIED`
- `LOAD_BALANCING_RANDOM`
- `LOAD_BALANCING_NEAREST_HOSTNAME`
- `LOAD_BALANCING_IN_ORDER`
- `LOAD_BALANCING_FIRST_OR_RANDOM`
- `LOAD_BALANCING_ROUND_ROBIN` ||
|| preferLocalhostReplica | **boolean**

Enables/disables preferable using the localhost replica when processing distributed queries.
Default: true
See in-depth description in [ClickHouse documentation](https://clickhouse.com/docs/en/operations/settings/settings#prefer_localhost_replica) ||
|| compile | **boolean**

The setting is deprecated and has no effect. ||
|| minCountToCompile | **string** (int64)

The setting is deprecated and has no effect. ||
|#

## UserQuota {#yandex.cloud.mdb.clickhouse.v1.UserQuota}

ClickHouse quota representation. Each quota associated with an user and limits it resource usage for an interval.
See in-depth description [ClickHouse documentation](https://clickhouse.com/docs/en/operations/quotas/).

#|
||Field | Description ||
|| intervalDuration | **string** (int64)

Duration of interval for quota in milliseconds.
Minimal value is 1 second. ||
|| queries | **string** (int64)

The total number of queries.
0 - unlimited. ||
|| errors | **string** (int64)

The number of queries that threw exception.
0 - unlimited. ||
|| resultRows | **string** (int64)

The total number of rows given as the result..
0 - unlimited. ||
|| readRows | **string** (int64)

The total number of source rows read from tables for running the query, on all remote servers.
0 - unlimited. ||
|| executionTime | **string** (int64)

The total query execution time, in milliseconds (wall time).
0 - unlimited. ||
|#

## HostSpec {#yandex.cloud.mdb.clickhouse.v1.HostSpec}

#|
||Field | Description ||
|| zoneId | **string**

ID of the availability zone where the host resides.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/Zone/list#List) request. ||
|| type | **enum** (Type)

Required field. Type of the host to be deployed.

- `TYPE_UNSPECIFIED`: Host type is unspecified. Default value.
- `CLICKHOUSE`: ClickHouse host.
- `ZOOKEEPER`: ZooKeeper host. ||
|| subnetId | **string**

ID of the subnet that the host should belong to. This subnet should be a part
of the network that the cluster belongs to.
The ID of the network is set in the [Cluster.networkId](#yandex.cloud.mdb.clickhouse.v1.Cluster) field. ||
|| assignPublicIp | **boolean**

Whether the host should get a public IP address on creation.

After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign
a public IP to a host without one, recreate the host with `assignPublicIp` set as needed.

Possible values:
* false - don't assign a public IP to the host.
* true - the host should have a public IP address. ||
|| shardName | **string**

Name of the shard that the host is assigned to. ||
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
|| metadata | **[CreateClusterMetadata](#yandex.cloud.mdb.clickhouse.v1.CreateClusterMetadata)**

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

## CreateClusterMetadata {#yandex.cloud.mdb.clickhouse.v1.CreateClusterMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the ClickHouse cluster that is being created. ||
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