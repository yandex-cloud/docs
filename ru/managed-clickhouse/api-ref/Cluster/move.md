---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}:move
    method: post
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the ClickHouse cluster to move.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        destinationFolderId:
          description: |-
            **string**
            Required field. ID of the destination folder.
          type: string
      required:
        - destinationFolderId
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/mdb/clickhouse/v1/api-ref/Cluster/move.md
---

# Managed Service for ClickHouse API, REST: Cluster.Move

Moves a ClickHouse cluster to the specified folder.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}:move
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the ClickHouse cluster to move. ||
|#

## Body parameters {#yandex.cloud.mdb.clickhouse.v1.MoveClusterRequest}

```json
{
  "destinationFolderId": "string"
}
```

#|
||Field | Description ||
|| destinationFolderId | **string**

Required field. ID of the destination folder. ||
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
    "clusterId": "string",
    "sourceFolderId": "string",
    "destinationFolderId": "string"
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
    "labels": "object",
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
            "backgroundPoolSize": "string",
            "backgroundMergesMutationsConcurrencyRatio": "string",
            "backgroundSchedulePoolSize": "string",
            "backgroundFetchesPoolSize": "string",
            "backgroundMovePoolSize": "string",
            "backgroundDistributedSchedulePoolSize": "string",
            "backgroundBufferFlushSchedulePoolSize": "string",
            "backgroundMessageBrokerSchedulePoolSize": "string",
            "backgroundCommonPoolSize": "string",
            "dictionariesLazyLoad": "boolean",
            "logLevel": "string",
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
            "processorsProfileLogEnabled": "boolean",
            "processorsProfileLogRetentionSize": "string",
            "processorsProfileLogRetentionTime": "string",
            "errorLogEnabled": "boolean",
            "errorLogRetentionSize": "string",
            "errorLogRetentionTime": "string",
            "accessControlImprovements": {
              "selectFromSystemDbRequiresGrant": "boolean",
              "selectFromInformationSchemaRequiresGrant": "boolean"
            },
            "maxConnections": "string",
            "maxConcurrentQueries": "string",
            "maxTableSizeToDrop": "string",
            "maxPartitionSizeToDrop": "string",
            "keepAliveTimeout": "string",
            "uncompressedCacheSize": "string",
            "markCacheSize": "string",
            "timezone": "string",
            "geobaseEnabled": "boolean",
            "geobaseUri": "string",
            "defaultDatabase": "string",
            "totalMemoryProfilerStep": "string",
            "totalMemoryTrackerSampleProbability": "number",
            "asyncInsertThreads": "string",
            "backupThreads": "string",
            "restoreThreads": "string",
            "mergeTree": {
              "partsToDelayInsert": "string",
              "partsToThrowInsert": "string",
              "inactivePartsToDelayInsert": "string",
              "inactivePartsToThrowInsert": "string",
              "maxAvgPartSizeForTooManyParts": "string",
              "maxPartsInTotal": "string",
              "maxReplicatedMergesInQueue": "string",
              "numberOfFreeEntriesInPoolToLowerMaxSizeOfMerge": "string",
              "numberOfFreeEntriesInPoolToExecuteMutation": "string",
              "maxBytesToMergeAtMinSpaceInPool": "string",
              "maxBytesToMergeAtMaxSpaceInPool": "string",
              "minBytesForWidePart": "string",
              "minRowsForWidePart": "string",
              "cleanupDelayPeriod": "string",
              "maxCleanupDelayPeriod": "string",
              "mergeSelectingSleepMs": "string",
              "maxMergeSelectingSleepMs": "string",
              "minAgeToForceMergeSeconds": "string",
              "minAgeToForceMergeOnPartitionOnly": "boolean",
              "mergeMaxBlockSize": "string",
              "deduplicateMergeProjectionMode": "string",
              "lightweightMutationProjectionMode": "string",
              "replicatedDeduplicationWindow": "string",
              "replicatedDeduplicationWindowSeconds": "string",
              "fsyncAfterInsert": "boolean",
              "fsyncPartDirectory": "boolean",
              "minCompressedBytesToFsyncAfterFetch": "string",
              "minCompressedBytesToFsyncAfterMerge": "string",
              "minRowsToFsyncAfterMerge": "string",
              "ttlOnlyDropParts": "boolean",
              "mergeWithTtlTimeout": "string",
              "mergeWithRecompressionTtlTimeout": "string",
              "maxNumberOfMergesWithTtlInPool": "string",
              "materializeTtlRecalculateOnly": "boolean",
              "checkSampleColumnIsCorrect": "boolean",
              "allowRemoteFsZeroCopyReplication": "boolean"
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
                  "allowReadExpiredKeys": "boolean",
                  "maxUpdateQueueSize": "string",
                  "updateQueuePushTimeoutMilliseconds": "string",
                  "queryWaitTimeoutMilliseconds": "string",
                  "maxThreadsForUpdates": "string",
                  "initialArraySize": "string",
                  "maxArraySize": "string",
                  "accessToKeyFromAttributes": "boolean"
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
            "queryMaskingRules": [
              {
                "name": "string",
                "regexp": "string",
                "replace": "string"
              }
            ],
            "queryCache": {
              "maxSizeInBytes": "string",
              "maxEntries": "string",
              "maxEntrySizeInBytes": "string",
              "maxEntrySizeInRows": "string"
            },
            "jdbcBridge": {
              "host": "string",
              "port": "string"
            },
            "mysqlProtocol": "boolean",
            "customMacros": [
              {
                "name": "string",
                "value": "string"
              }
            ],
            "builtinDictionariesReloadInterval": "string"
          },
          "userConfig": {
            "backgroundPoolSize": "string",
            "backgroundMergesMutationsConcurrencyRatio": "string",
            "backgroundSchedulePoolSize": "string",
            "backgroundFetchesPoolSize": "string",
            "backgroundMovePoolSize": "string",
            "backgroundDistributedSchedulePoolSize": "string",
            "backgroundBufferFlushSchedulePoolSize": "string",
            "backgroundMessageBrokerSchedulePoolSize": "string",
            "backgroundCommonPoolSize": "string",
            "dictionariesLazyLoad": "boolean",
            "logLevel": "string",
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
            "processorsProfileLogEnabled": "boolean",
            "processorsProfileLogRetentionSize": "string",
            "processorsProfileLogRetentionTime": "string",
            "errorLogEnabled": "boolean",
            "errorLogRetentionSize": "string",
            "errorLogRetentionTime": "string",
            "accessControlImprovements": {
              "selectFromSystemDbRequiresGrant": "boolean",
              "selectFromInformationSchemaRequiresGrant": "boolean"
            },
            "maxConnections": "string",
            "maxConcurrentQueries": "string",
            "maxTableSizeToDrop": "string",
            "maxPartitionSizeToDrop": "string",
            "keepAliveTimeout": "string",
            "uncompressedCacheSize": "string",
            "markCacheSize": "string",
            "timezone": "string",
            "geobaseEnabled": "boolean",
            "geobaseUri": "string",
            "defaultDatabase": "string",
            "totalMemoryProfilerStep": "string",
            "totalMemoryTrackerSampleProbability": "number",
            "asyncInsertThreads": "string",
            "backupThreads": "string",
            "restoreThreads": "string",
            "mergeTree": {
              "partsToDelayInsert": "string",
              "partsToThrowInsert": "string",
              "inactivePartsToDelayInsert": "string",
              "inactivePartsToThrowInsert": "string",
              "maxAvgPartSizeForTooManyParts": "string",
              "maxPartsInTotal": "string",
              "maxReplicatedMergesInQueue": "string",
              "numberOfFreeEntriesInPoolToLowerMaxSizeOfMerge": "string",
              "numberOfFreeEntriesInPoolToExecuteMutation": "string",
              "maxBytesToMergeAtMinSpaceInPool": "string",
              "maxBytesToMergeAtMaxSpaceInPool": "string",
              "minBytesForWidePart": "string",
              "minRowsForWidePart": "string",
              "cleanupDelayPeriod": "string",
              "maxCleanupDelayPeriod": "string",
              "mergeSelectingSleepMs": "string",
              "maxMergeSelectingSleepMs": "string",
              "minAgeToForceMergeSeconds": "string",
              "minAgeToForceMergeOnPartitionOnly": "boolean",
              "mergeMaxBlockSize": "string",
              "deduplicateMergeProjectionMode": "string",
              "lightweightMutationProjectionMode": "string",
              "replicatedDeduplicationWindow": "string",
              "replicatedDeduplicationWindowSeconds": "string",
              "fsyncAfterInsert": "boolean",
              "fsyncPartDirectory": "boolean",
              "minCompressedBytesToFsyncAfterFetch": "string",
              "minCompressedBytesToFsyncAfterMerge": "string",
              "minRowsToFsyncAfterMerge": "string",
              "ttlOnlyDropParts": "boolean",
              "mergeWithTtlTimeout": "string",
              "mergeWithRecompressionTtlTimeout": "string",
              "maxNumberOfMergesWithTtlInPool": "string",
              "materializeTtlRecalculateOnly": "boolean",
              "checkSampleColumnIsCorrect": "boolean",
              "allowRemoteFsZeroCopyReplication": "boolean"
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
                  "allowReadExpiredKeys": "boolean",
                  "maxUpdateQueueSize": "string",
                  "updateQueuePushTimeoutMilliseconds": "string",
                  "queryWaitTimeoutMilliseconds": "string",
                  "maxThreadsForUpdates": "string",
                  "initialArraySize": "string",
                  "maxArraySize": "string",
                  "accessToKeyFromAttributes": "boolean"
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
            "queryMaskingRules": [
              {
                "name": "string",
                "regexp": "string",
                "replace": "string"
              }
            ],
            "queryCache": {
              "maxSizeInBytes": "string",
              "maxEntries": "string",
              "maxEntrySizeInBytes": "string",
              "maxEntrySizeInRows": "string"
            },
            "jdbcBridge": {
              "host": "string",
              "port": "string"
            },
            "mysqlProtocol": "boolean",
            "customMacros": [
              {
                "name": "string",
                "value": "string"
              }
            ],
            "builtinDictionariesReloadInterval": "string"
          },
          "defaultConfig": {
            "backgroundPoolSize": "string",
            "backgroundMergesMutationsConcurrencyRatio": "string",
            "backgroundSchedulePoolSize": "string",
            "backgroundFetchesPoolSize": "string",
            "backgroundMovePoolSize": "string",
            "backgroundDistributedSchedulePoolSize": "string",
            "backgroundBufferFlushSchedulePoolSize": "string",
            "backgroundMessageBrokerSchedulePoolSize": "string",
            "backgroundCommonPoolSize": "string",
            "dictionariesLazyLoad": "boolean",
            "logLevel": "string",
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
            "processorsProfileLogEnabled": "boolean",
            "processorsProfileLogRetentionSize": "string",
            "processorsProfileLogRetentionTime": "string",
            "errorLogEnabled": "boolean",
            "errorLogRetentionSize": "string",
            "errorLogRetentionTime": "string",
            "accessControlImprovements": {
              "selectFromSystemDbRequiresGrant": "boolean",
              "selectFromInformationSchemaRequiresGrant": "boolean"
            },
            "maxConnections": "string",
            "maxConcurrentQueries": "string",
            "maxTableSizeToDrop": "string",
            "maxPartitionSizeToDrop": "string",
            "keepAliveTimeout": "string",
            "uncompressedCacheSize": "string",
            "markCacheSize": "string",
            "timezone": "string",
            "geobaseEnabled": "boolean",
            "geobaseUri": "string",
            "defaultDatabase": "string",
            "totalMemoryProfilerStep": "string",
            "totalMemoryTrackerSampleProbability": "number",
            "asyncInsertThreads": "string",
            "backupThreads": "string",
            "restoreThreads": "string",
            "mergeTree": {
              "partsToDelayInsert": "string",
              "partsToThrowInsert": "string",
              "inactivePartsToDelayInsert": "string",
              "inactivePartsToThrowInsert": "string",
              "maxAvgPartSizeForTooManyParts": "string",
              "maxPartsInTotal": "string",
              "maxReplicatedMergesInQueue": "string",
              "numberOfFreeEntriesInPoolToLowerMaxSizeOfMerge": "string",
              "numberOfFreeEntriesInPoolToExecuteMutation": "string",
              "maxBytesToMergeAtMinSpaceInPool": "string",
              "maxBytesToMergeAtMaxSpaceInPool": "string",
              "minBytesForWidePart": "string",
              "minRowsForWidePart": "string",
              "cleanupDelayPeriod": "string",
              "maxCleanupDelayPeriod": "string",
              "mergeSelectingSleepMs": "string",
              "maxMergeSelectingSleepMs": "string",
              "minAgeToForceMergeSeconds": "string",
              "minAgeToForceMergeOnPartitionOnly": "boolean",
              "mergeMaxBlockSize": "string",
              "deduplicateMergeProjectionMode": "string",
              "lightweightMutationProjectionMode": "string",
              "replicatedDeduplicationWindow": "string",
              "replicatedDeduplicationWindowSeconds": "string",
              "fsyncAfterInsert": "boolean",
              "fsyncPartDirectory": "boolean",
              "minCompressedBytesToFsyncAfterFetch": "string",
              "minCompressedBytesToFsyncAfterMerge": "string",
              "minRowsToFsyncAfterMerge": "string",
              "ttlOnlyDropParts": "boolean",
              "mergeWithTtlTimeout": "string",
              "mergeWithRecompressionTtlTimeout": "string",
              "maxNumberOfMergesWithTtlInPool": "string",
              "materializeTtlRecalculateOnly": "boolean",
              "checkSampleColumnIsCorrect": "boolean",
              "allowRemoteFsZeroCopyReplication": "boolean"
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
                  "allowReadExpiredKeys": "boolean",
                  "maxUpdateQueueSize": "string",
                  "updateQueuePushTimeoutMilliseconds": "string",
                  "queryWaitTimeoutMilliseconds": "string",
                  "maxThreadsForUpdates": "string",
                  "initialArraySize": "string",
                  "maxArraySize": "string",
                  "accessToKeyFromAttributes": "boolean"
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
            "queryMaskingRules": [
              {
                "name": "string",
                "regexp": "string",
                "replace": "string"
              }
            ],
            "queryCache": {
              "maxSizeInBytes": "string",
              "maxEntries": "string",
              "maxEntrySizeInBytes": "string",
              "maxEntrySizeInRows": "string"
            },
            "jdbcBridge": {
              "host": "string",
              "port": "string"
            },
            "mysqlProtocol": "boolean",
            "customMacros": [
              {
                "name": "string",
                "value": "string"
              }
            ],
            "builtinDictionariesReloadInterval": "string"
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        },
        "diskSizeAutoscaling": {
          "plannedUsageThreshold": "string",
          "emergencyUsageThreshold": "string",
          "diskSizeLimit": "string"
        }
      },
      "zookeeper": {
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        },
        "diskSizeAutoscaling": {
          "plannedUsageThreshold": "string",
          "emergencyUsageThreshold": "string",
          "diskSizeLimit": "string"
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
    "deletionProtection": "boolean",
    "diskEncryptionKeyId": "string"
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
|| metadata | **[MoveClusterMetadata](#yandex.cloud.mdb.clickhouse.v1.MoveClusterMetadata)**

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

## MoveClusterMetadata {#yandex.cloud.mdb.clickhouse.v1.MoveClusterMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the ClickHouse cluster being moved. ||
|| sourceFolderId | **string**

ID of the source folder. ||
|| destinationFolderId | **string**

ID of the destination folder. ||
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
|| labels | **object** (map<**string**, **string**>)

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
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.clickhouse.v1.MaintenanceWindow)**

Maintenance window for the cluster. ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.mdb.clickhouse.v1.MaintenanceOperation)**

Planned maintenance operation to be started for the cluster within the nearest `maintenanceWindow`. ||
|| securityGroupIds[] | **string**

User security groups ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the cluster ||
|| diskEncryptionKeyId | **string**

ID of the key to encrypt cluster disks. ||
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
|| backupWindowStart | **[TimeOfDay](#google.type.TimeOfDay)**

Time to start the daily backup, in the UTC timezone. ||
|| access | **[Access](#yandex.cloud.mdb.clickhouse.v1.Access)**

Access policy for external services. ||
|| cloudStorage | **[CloudStorage](#yandex.cloud.mdb.clickhouse.v1.CloudStorage)** ||
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
|| resources | **[Resources](#yandex.cloud.mdb.clickhouse.v1.Resources)**

Resources allocated to ClickHouse hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.clickhouse.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings. ||
|#

## ClickhouseConfigSet {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfigSet}

#|
||Field | Description ||
|| effectiveConfig | **[ClickhouseConfig](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig)**

Required field. Effective configuration (a combination of user-defined configuration and default configuration). ||
|| userConfig | **[ClickhouseConfig](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig)**

Required field. User-defined configuration. ||
|| defaultConfig | **[ClickhouseConfig](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig)**

Required field. Default configuration. ||
|#

## ClickhouseConfig {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig}

ClickHouse configuration settings. Supported settings are a subset of settings described
in [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings).

#|
||Field | Description ||
|| backgroundPoolSize | **string** (int64)

Sets the number of threads performing background merges and mutations for MergeTree-engine tables.

Default value: **16**.

Change of the setting is applied with restart on value decrease and without restart on value increase.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_pool_size). ||
|| backgroundMergesMutationsConcurrencyRatio | **string** (int64)

Sets a ratio between the number of threads and the number of background merges and mutations that can be executed concurrently.

For example, if the ratio equals to **2** and **background_pool_size** is set to **16** then ClickHouse can execute **32** background merges concurrently.
This is possible, because background operations could be suspended and postponed. This is needed to give small merges more execution priority.

Default value: **2**.

Change of the setting is applied with restart on value decrease and without restart on value increase.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_merges_mutations_concurrency_ratio). ||
|| backgroundSchedulePoolSize | **string** (int64)

The maximum number of threads that will be used for constantly executing some lightweight periodic operations
for replicated tables, Kafka streaming, and DNS cache updates.

Default value: **512**.

Change of the setting is applied with restart on value decrease and without restart on value increase.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_schedule_pool_size). ||
|| backgroundFetchesPoolSize | **string** (int64)

The maximum number of threads that will be used for fetching data parts from another replica for MergeTree-engine tables in a background.

Default value: **32** for versions 25.1 and higher, **16** for versions 24.12 and lower.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_fetches_pool_size). ||
|| backgroundMovePoolSize | **string** (int64)

The maximum number of threads that will be used for moving data parts to another disk or volume for MergeTree-engine tables in a background.

Default value: **8**.

Change of the setting is applied with restart on value decrease and without restart on value increase.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_move_pool_size). ||
|| backgroundDistributedSchedulePoolSize | **string** (int64)

The maximum number of threads that will be used for executing distributed sends.

Default value: **16**.

Change of the setting is applied with restart on value decrease and without restart on value increase.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_distributed_schedule_pool_size). ||
|| backgroundBufferFlushSchedulePoolSize | **string** (int64)

The maximum number of threads that will be used for performing flush operations for Buffer-engine tables in the background.

Default value: **16**.

Change of the setting is applied with restart on value decrease and without restart on value increase.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_buffer_flush_schedule_pool_size). ||
|| backgroundMessageBrokerSchedulePoolSize | **string** (int64)

The maximum number of threads that will be used for executing background operations for message streaming.

Default value: **16**.

Change of the setting is applied with restart on value decrease and without restart on value increase.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_message_broker_schedule_pool_size). ||
|| backgroundCommonPoolSize | **string** (int64)

The maximum number of threads that will be used for performing a variety of operations (mostly garbage collection) for MergeTree-engine tables in a background.

Default value: **8**.

Change of the setting is applied with restart on value decrease and without restart on value increase.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_common_pool_size). ||
|| dictionariesLazyLoad | **boolean**

Lazy loading of dictionaries. If enabled, then each dictionary is loaded on the first use. Otherwise, the server loads all dictionaries at startup.

Default value: **true** for versions 25.1 and higher, **false** for versions 24.12 and lower.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#dictionaries_lazy_load). ||
|| logLevel | **enum** (LogLevel)

Logging level.

- `LOG_LEVEL_UNSPECIFIED`
- `TRACE`
- `DEBUG`
- `INFORMATION`
- `WARNING`
- `ERROR` ||
|| queryLogRetentionSize | **string** (int64)

The maximum size that query_log can grow to before old data will be removed. If set to **0**,
automatic removal of query_log data based on size is disabled.

Default value: **1073741824** (1 GiB). ||
|| queryLogRetentionTime | **string** (int64)

The maximum time that query_log records will be retained before removal. If set to **0**, automatic removal of query_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| queryThreadLogEnabled | **boolean**

Enables or disables query_thread_log system table.

Default value: **true**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/query_thread_log). ||
|| queryThreadLogRetentionSize | **string** (int64)

The maximum size that query_thread_log can grow to before old data will be removed. If set to **0**,
automatic removal of query_thread_log data based on size is disabled.

Default value: **536870912** (512 MiB). ||
|| queryThreadLogRetentionTime | **string** (int64)

The maximum time that query_thread_log records will be retained before removal. If set to **0**,
automatic removal of query_thread_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| partLogRetentionSize | **string** (int64)

The maximum size that part_log can grow to before old data will be removed. If set to **0**,
automatic removal of part_log data based on size is disabled.

Default value: **536870912** (512 MiB). ||
|| partLogRetentionTime | **string** (int64)

The maximum time that part_log records will be retained before removal. If set to **0**,
automatic removal of part_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| metricLogEnabled | **boolean**

Enables or disables metric_log system table.

Default value: **false** for versions 25.1 and higher, **true** for versions 24.12 and lower.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/metric_log). ||
|| metricLogRetentionSize | **string** (int64)

The maximum size that metric_log can grow to before old data will be removed. If set to **0**,
automatic removal of metric_log data based on size is disabled.

Default value: **536870912** (512 MiB). ||
|| metricLogRetentionTime | **string** (int64)

The maximum time that metric_log records will be retained before removal. If set to **0**,
automatic removal of metric_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| traceLogEnabled | **boolean**

Enables or disables trace_log system table.

Default value: **true** for versions 25.2 and higher, **false** for versions 25.1 and lower.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/trace_log). ||
|| traceLogRetentionSize | **string** (int64)

The maximum size that trace_log can grow to before old data will be removed. If set to **0**,
automatic removal of trace_log data based on size is disabled.

Default value: **536870912** (512 MiB). ||
|| traceLogRetentionTime | **string** (int64)

The maximum time that trace_log records will be retained before removal. If set to **0**,
automatic removal of trace_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| textLogEnabled | **boolean**

Enables or disables text_log system table.

Default value: **false**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/text_log). ||
|| textLogRetentionSize | **string** (int64)

The maximum size that text_log can grow to before old data will be removed. If set to **0**,
automatic removal of text_log data based on size is disabled.

Default value: **536870912** (512 MiB). ||
|| textLogRetentionTime | **string** (int64)

The maximum time that text_log records will be retained before removal. If set to **0**,
automatic removal of text_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| textLogLevel | **enum** (LogLevel)

Logging level for text_log system table.

Default value: **TRACE**.

Change of the setting is applied with restart.

- `LOG_LEVEL_UNSPECIFIED`
- `TRACE`
- `DEBUG`
- `INFORMATION`
- `WARNING`
- `ERROR` ||
|| opentelemetrySpanLogEnabled | **boolean**

Enables or disables opentelemetry_span_log system table.

Default value: **false**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/opentelemetry_span_log). ||
|| opentelemetrySpanLogRetentionSize | **string** (int64)

The maximum size that opentelemetry_span_log can grow to before old data will be removed. If set to **0**,
automatic removal of opentelemetry_span_log data based on size is disabled.

Default value: **0**. ||
|| opentelemetrySpanLogRetentionTime | **string** (int64)

The maximum time that opentelemetry_span_log records will be retained before removal. If set to **0**,
automatic removal of opentelemetry_span_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| queryViewsLogEnabled | **boolean**

Enables or disables query_views_log system table.

Default value: **false**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/query_views_log). ||
|| queryViewsLogRetentionSize | **string** (int64)

The maximum size that query_views_log can grow to before old data will be removed. If set to **0**,
automatic removal of query_views_log data based on size is disabled.

Default value: **0**. ||
|| queryViewsLogRetentionTime | **string** (int64)

The maximum time that query_views_log records will be retained before removal. If set to **0**,
automatic removal of query_views_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| asynchronousMetricLogEnabled | **boolean**

Enables or disables asynchronous_metric_log system table.

Default value: **false**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/asynchronous_metric_log). ||
|| asynchronousMetricLogRetentionSize | **string** (int64)

The maximum size that asynchronous_metric_log can grow to before old data will be removed. If set to **0**,
automatic removal of asynchronous_metric_log data based on size is disabled.

Default value: **0**. ||
|| asynchronousMetricLogRetentionTime | **string** (int64)

The maximum time that asynchronous_metric_log records will be retained before removal. If set to **0**,
automatic removal of asynchronous_metric_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| sessionLogEnabled | **boolean**

Enables or disables session_log system table.

Default value: **false**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/session_log). ||
|| sessionLogRetentionSize | **string** (int64)

The maximum size that session_log can grow to before old data will be removed. If set to **0**,
automatic removal of session_log data based on size is disabled.

Default value: **0**. ||
|| sessionLogRetentionTime | **string** (int64)

The maximum time that session_log records will be retained before removal. If set to **0**,
automatic removal of session_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| zookeeperLogEnabled | **boolean**

Enables or disables zookeeper_log system table.

Default value: **false**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/zookeeper_log). ||
|| zookeeperLogRetentionSize | **string** (int64)

The maximum size that zookeeper_log can grow to before old data will be removed. If set to **0**,
automatic removal of zookeeper_log data based on size is disabled.

Default value: **0**. ||
|| zookeeperLogRetentionTime | **string** (int64)

The maximum time that zookeeper_log records will be retained before removal. If set to **0**,
automatic removal of zookeeper_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| asynchronousInsertLogEnabled | **boolean**

Enables or disables asynchronous_insert_log system table.

Default value: **false**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/asynchronous_insert_log). ||
|| asynchronousInsertLogRetentionSize | **string** (int64)

The maximum size that asynchronous_insert_log can grow to before old data will be removed. If set to **0**,
automatic removal of asynchronous_insert_log data based on size is disabled.

Default value: **0**. ||
|| asynchronousInsertLogRetentionTime | **string** (int64)

The maximum time that asynchronous_insert_log records will be retained before removal. If set to **0**,
automatic removal of asynchronous_insert_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| processorsProfileLogEnabled | **boolean**

Enables or disables processors_profile_log system table.

Default value: **true** for versions 25.2 and higher, **false** for versions 25.1 and lower.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/processors_profile_log). ||
|| processorsProfileLogRetentionSize | **string** (int64)

The maximum size that processors_profile_log can grow to before old data will be removed. If set to **0**,
automatic removal of processors_profile_log data based on size is disabled.

Default value: **0**. ||
|| processorsProfileLogRetentionTime | **string** (int64)

The maximum time that processors_profile_log records will be retained before removal. If set to **0**,
automatic removal of processors_profile_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| errorLogEnabled | **boolean**

Enables or disables error_log system table.

Default value: **false**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/error_log). ||
|| errorLogRetentionSize | **string** (int64)

The maximum size that error_log can grow to before old data will be removed. If set to **0**,
automatic removal of error_log data based on size is disabled.

Default value: **0**. ||
|| errorLogRetentionTime | **string** (int64)

The maximum time that error_log records will be retained before removal. If set to **0**,
automatic removal of error_log data based on time is disabled.

Default value: **2592000000** (30 days). ||
|| accessControlImprovements | **[AccessControlImprovements](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.AccessControlImprovements)**

Access control settings. ||
|| maxConnections | **string** (int64)

Maximum number of inbound connections.

Default value: **4096**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#max_connections). ||
|| maxConcurrentQueries | **string** (int64)

Maximum number of concurrently executed queries.

Default value: **500**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#max_concurrent_queries). ||
|| maxTableSizeToDrop | **string** (int64)

Maximum size of the table that can be deleted using **DROP** or **TRUNCATE** query.

Default value: **50000000000** (48828125 KiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#max_table_size_to_drop). ||
|| maxPartitionSizeToDrop | **string** (int64)

Maximum size of the partition that can be deleted using **DROP** or **TRUNCATE** query.

Default value: **50000000000** (48828125 KiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#max_partition_size_to_drop). ||
|| keepAliveTimeout | **string** (int64)

The number of seconds that ClickHouse waits for incoming requests for HTTP protocol before closing the connection.

Default value: **30**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#keep_alive_timeout). ||
|| uncompressedCacheSize | **string** (int64)

Cache size (in bytes) for uncompressed data used by table engines from the MergeTree family. **0** means disabled.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#uncompressed_cache_size). ||
|| markCacheSize | **string** (int64)

Maximum size (in bytes) of the cache of "marks" used by MergeTree tables.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#mark_cache_size). ||
|| timezone | **string**

The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier.

Default value: **Europe/Moscow**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#timezone). ||
|| geobaseEnabled | **boolean**

Enables or disables geobase.

Change of the setting is applied with restart. ||
|| geobaseUri | **string**

Address of the archive with the user geobase in Object Storage.

Change of the setting is applied with restart. ||
|| defaultDatabase | **string**

The default database.

Default value: **default**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#default_database). ||
|| totalMemoryProfilerStep | **string** (int64)

Whenever server memory usage becomes larger than every next step in number of bytes the memory profiler will collect
the allocating stack trace. **0** means disabled memory profiler.

Default value: **0**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#total_memory_profiler_step). ||
|| totalMemoryTrackerSampleProbability | **number** (double)

Allows to collect random allocations and de-allocations and writes them in the system.trace_log system table
with trace_type equal to a MemorySample with the specified probability.

Default value: **0**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#total_memory_tracker_sample_probability). ||
|| asyncInsertThreads | **string** (int64)

Maximum number of threads to parse and insert data in background. If set to **0**, asynchronous mode is disabled.

Default value: **16**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#async_insert_threads). ||
|| backupThreads | **string** (int64)

The maximum number of threads to execute **BACKUP** requests.

Default value: **16**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#backup_threads). ||
|| restoreThreads | **string** (int64)

The maximum number of threads to execute **RESTORE** requests.

Default value: **16**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#restore_threads). ||
|| mergeTree | **[MergeTree](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.MergeTree)**

Settings for the MergeTree table engine family.

Change of the settings of **merge_tree** is applied with restart. ||
|| compression[] | **[Compression](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Compression)**

Data compression settings for MergeTree engine tables.

Change of the settings of **compression** is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#compression). ||
|| dictionaries[] | **[ExternalDictionary](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary)**

Configuration of external dictionaries.

Change of the settings of **dictionaries** is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries). ||
|| graphiteRollup[] | **[GraphiteRollup](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup)**

Rollup settings for the GraphiteMergeTree engine tables.

Change of the settings of **graphite_rollup** is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#graphite_rollup). ||
|| kafka | **[Kafka](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Kafka)**

Kafka integration settings.

Change of the settings of **kafka** is applied with restart. ||
|| kafkaTopics[] | **[KafkaTopic](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.KafkaTopic)**

Per-topic Kafka integration settings.

Change of the settings of **kafka_topics** is applied with restart. ||
|| rabbitmq | **[Rabbitmq](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Rabbitmq)**

RabbitMQ integration settings.

Change of the settings of **rabbitmq** is applied with restart. ||
|| queryMaskingRules[] | **[QueryMaskingRule](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryMaskingRule)**

Regexp-based rules, which will be applied to queries as well as all log messages before storing them in server logs,
system.query_log, system.text_log, system.processes tables, and in logs sent to the client. That allows preventing
sensitive data leakage from SQL queries (like names, emails, personal identifiers or credit card numbers) to logs.

Change of the settings of **query_masking_rules** is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#query_masking_rules). ||
|| queryCache | **[QueryCache](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryCache)**

[Query cache](https://clickhouse.com/docs/operations/query-cache) configuration.

Change of the settings of **query_cache** is applied with restart. ||
|| jdbcBridge | **[JdbcBridge](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.JdbcBridge)**

JDBC bridge configuration for queries to external databases.

Change of the settings of **jdbc_bridge** is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/integrations/jdbc/jdbc-with-clickhouse). ||
|| mysqlProtocol | **boolean**

Enables or disables MySQL interface on ClickHouse server

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/interfaces/mysql). ||
|| customMacros[] | **[Macro](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Macro)**

Custom ClickHouse macros. ||
|| builtinDictionariesReloadInterval | **string** (int64)

The interval in seconds before reloading built-in dictionaries.

Default value: **3600**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#builtin_dictionaries_reload_interval). ||
|#

## AccessControlImprovements {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.AccessControlImprovements}

Access control settings.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#access_control_improvements).

#|
||Field | Description ||
|| selectFromSystemDbRequiresGrant | **boolean**

Sets whether **SELECT * FROM system.<table>** requires any grants and can be executed by any user.
If set to true then this query requires **GRANT SELECT ON system.<table>** just as for non-system tables.

Default value: **false**. ||
|| selectFromInformationSchemaRequiresGrant | **boolean**

Sets whether **SELECT * FROM information_schema.<table>** requires any grants and can be executed by any user.
If set to true, then this query requires **GRANT SELECT ON information_schema.<table>**, just as for ordinary tables.

Default value: **false**. ||
|#

## MergeTree {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.MergeTree}

Settings for the MergeTree table engine family.

#|
||Field | Description ||
|| partsToDelayInsert | **string** (int64)

If the number of active parts in a single partition exceeds the **parts_to_delay_insert** value, an **INSERT** artificially slows down.

Default value: **1000** for versions 25.1 and higher, **150** for versions 24.12 and lower.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#parts_to_delay_insert). ||
|| partsToThrowInsert | **string** (int64)

If the number of active parts in a single partition exceeds the **parts_to_throw_insert** value, an **INSERT**
is interrupted with the error "Too many parts (N). Merges are processing significantly slower than inserts".

Default value: **3000** for versions 25.1 and higher, **300** for versions 24.12 and lower.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#parts_to_throw_insert). ||
|| inactivePartsToDelayInsert | **string** (int64)

If the number of inactive parts in a single partition in the table exceeds the **inactive_parts_to_delay_insert** value,
an **INSERT** is artificially slowed down.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#inactive_parts_to_delay_insert). ||
|| inactivePartsToThrowInsert | **string** (int64)

If the number of inactive parts in a single partition more than the **inactive_parts_to_throw_insert** value,
**INSERT** is interrupted with an error.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#inactive_parts_to_throw_insert). ||
|| maxAvgPartSizeForTooManyParts | **string** (int64)

The "Too many parts" check according to **parts_to_delay_insert** and **parts_to_throw_insert** will be active only if the average
part size (in the relevant partition) is not larger than the specified threshold. If it is larger than the specified threshold,
**INSERT** queries will be neither delayed or rejected. This allows to have hundreds of terabytes in a single table on a single server
if the parts are successfully merged to larger parts. This does not affect the thresholds on inactive parts or total parts.

Default value: **1073741824** (1 GiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_avg_part_size_for_too_many_parts). ||
|| maxPartsInTotal | **string** (int64)

If the total number of active parts in all partitions of a table exceeds the **max_parts_in_total** value,
an **INSERT** is interrupted with the error "Too many parts (N)".

Default value: **20000** for versions 25.2 and higher, **100000** for versions 25.1 and lower.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_parts_in_total). ||
|| maxReplicatedMergesInQueue | **string** (int64)

How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue.

Default value: **16**. ||
|| numberOfFreeEntriesInPoolToLowerMaxSizeOfMerge | **string** (int64)

When there is less than the specified number of free entries in pool (or replicated queue), start to lower maximum size of
merge to process (or to put in queue). This is to allow small merges to process - not filling the pool with long running merges.

Default value: **8**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#number_of_free_entries_in_pool_to_lower_max_size_of_merge). ||
|| numberOfFreeEntriesInPoolToExecuteMutation | **string** (int64)

When there is less than specified number of free entries in pool, do not execute part mutations.
This is to leave free threads for regular merges and to avoid "Too many parts" errors.

Default value: **20**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#number_of_free_entries_in_pool_to_execute_mutation). ||
|| maxBytesToMergeAtMinSpaceInPool | **string** (int64)

The maximum total part size (in bytes) to be merged into one part, with the minimum available resources in the background pool.

Default value: **1048576** (1 MiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_bytes_to_merge_at_min_space_in_pool). ||
|| maxBytesToMergeAtMaxSpaceInPool | **string** (int64)

The maximum total parts size (in bytes) to be merged into one part, if there are enough resources available.
Corresponds roughly to the maximum possible part size created by an automatic background merge. **0** means merges will be disabled.

Default value: **161061273600** (150 GiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_bytes_to_merge_at_max_space_in_pool). ||
|| minBytesForWidePart | **string** (int64)

Minimum number of bytes in a data part that can be stored in Wide format.

Default value: **10485760** (10 MiB).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_bytes_for_wide_part). ||
|| minRowsForWidePart | **string** (int64)

Minimum number of rows in a data part that can be stored in Wide format.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_rows_for_wide_part). ||
|| cleanupDelayPeriod | **string** (int64)

Minimum period to clean old queue logs, blocks hashes and parts.

Default value: **30**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#cleanup_delay_period). ||
|| maxCleanupDelayPeriod | **string** (int64)

Maximum period to clean old queue logs, blocks hashes and parts.

Default value: **300** (5 minutes).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_cleanup_delay_period). ||
|| mergeSelectingSleepMs | **string** (int64)

Minimum time to wait before trying to select parts to merge again after no parts were selected. A lower setting value will trigger
selecting tasks in background_schedule_pool frequently which result in large amount of requests to Keeper in large-scale clusters.

Default value: **5000** (5 seconds).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#merge_selecting_sleep_ms). ||
|| maxMergeSelectingSleepMs | **string** (int64)

Maximum time to wait before trying to select parts to merge again after no parts were selected. A lower setting value will trigger
selecting tasks in background_schedule_pool frequently which result in large amount of requests to Keeper in large-scale clusters.

Default value: **60000** (1 minute).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_merge_selecting_sleep_ms). ||
|| minAgeToForceMergeSeconds | **string** (int64)

Merge parts if every part in the range is older than the specified value. **0** means disabled.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_age_to_force_merge_seconds). ||
|| minAgeToForceMergeOnPartitionOnly | **boolean**

Whether **min_age_to_force_merge_seconds** should be applied only on the entire partition and not on subset.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_age_to_force_merge_on_partition_only). ||
|| mergeMaxBlockSize | **string** (int64)

The number of rows that are read from the merged parts into memory.

Default value: **8192**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#merge_max_block_size). ||
|| deduplicateMergeProjectionMode | **enum** (DeduplicateMergeProjectionMode)

Determines the behavior of background merges for MergeTree tables with projections.

Default value: **DEDUPLICATE_MERGE_PROJECTION_MODE_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#deduplicate_merge_projection_mode).

- `DEDUPLICATE_MERGE_PROJECTION_MODE_UNSPECIFIED`
- `DEDUPLICATE_MERGE_PROJECTION_MODE_IGNORE`
- `DEDUPLICATE_MERGE_PROJECTION_MODE_THROW`
- `DEDUPLICATE_MERGE_PROJECTION_MODE_DROP`
- `DEDUPLICATE_MERGE_PROJECTION_MODE_REBUILD` ||
|| lightweightMutationProjectionMode | **enum** (LightweightMutationProjectionMode)

Determines the behavior of lightweight deletes for MergeTree tables with projections.

Default value: **LIGHTWEIGHT_MUTATION_PROJECTION_MODE_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#lightweight_mutation_projection_mode).

- `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_UNSPECIFIED`
- `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_THROW`
- `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_DROP`
- `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_REBUILD` ||
|| replicatedDeduplicationWindow | **string** (int64)

The number of most recently inserted blocks for which ClickHouse Keeper stores hash sums to check for duplicates.

Default value: **1000** for versions 23.11 and higher, **100** for versions 23.10 and lower.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#replicated_deduplication_window). ||
|| replicatedDeduplicationWindowSeconds | **string** (int64)

The number of seconds after which the hash sums of the inserted blocks are removed from ClickHouse Keeper.

Default value: **604800** (7 days).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#replicated_deduplication_window_seconds). ||
|| fsyncAfterInsert | **boolean**

Do fsync for every inserted part. Significantly decreases performance of inserts, not recommended to use with wide parts.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#fsync_after_insert). ||
|| fsyncPartDirectory | **boolean**

Do fsync for part directory after all part operations (writes, renames, etc.).

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#fsync_part_directory). ||
|| minCompressedBytesToFsyncAfterFetch | **string** (int64)

Minimal number of compressed bytes to do fsync for part after fetch. **0** means disabled.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_compressed_bytes_to_fsync_after_fetch). ||
|| minCompressedBytesToFsyncAfterMerge | **string** (int64)

Minimal number of compressed bytes to do fsync for part after merge. **0** means disabled.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_compressed_bytes_to_fsync_after_merge). ||
|| minRowsToFsyncAfterMerge | **string** (int64)

Minimal number of rows to do fsync for part after merge. **0** means disabled.

Default value: **0**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_rows_to_fsync_after_merge). ||
|| ttlOnlyDropParts | **boolean**

Controls whether data parts are fully dropped in MergeTree tables when all rows in that part have expired according to their **TTL** settings.
* **true** - the entire part is dropped if all rows in that part have expired according to their **TTL** settings.
* **false** - only the rows that have expired based on their **TTL** settings are removed.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#ttl_only_drop_parts). ||
|| mergeWithTtlTimeout | **string** (int64)

Minimum delay in seconds before repeating a merge with delete TTL.

Default value: **14400** (4 hours).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#merge_with_ttl_timeout). ||
|| mergeWithRecompressionTtlTimeout | **string** (int64)

Minimum delay in seconds before repeating a merge with recompression TTL.

Default value: **14400** (4 hours).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#merge_with_recompression_ttl_timeout). ||
|| maxNumberOfMergesWithTtlInPool | **string** (int64)

When there is more than specified number of merges with TTL entries in pool, do not assign new merge with TTL.
This is to leave free threads for regular merges and avoid "Too many parts" errors.

Default value: **2**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_number_of_merges_with_ttl_in_pool). ||
|| materializeTtlRecalculateOnly | **boolean**

Only recalculate ttl info when **MATERIALIZE TTL**.

Default value: **true** for versions 25.2 and higher, **false** for versions 25.1 and lower.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#materialize_ttl_recalculate_only). ||
|| checkSampleColumnIsCorrect | **boolean**

Enables the check at table creation, that the data type of a column for sampling or sampling expression is correct.
The data type must be one of unsigned integer types: UInt8, UInt16, UInt32, UInt64.

Default value: **true**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#check_sample_column_is_correct). ||
|| allowRemoteFsZeroCopyReplication | **boolean**

Setting is automatically enabled if cloud storage is enabled, disabled otherwise.

Default value: **true**. ||
|#

## Compression {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Compression}

Compression settings.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#compression).

#|
||Field | Description ||
|| method | **enum** (Method)

Required field. Compression method to use for the specified combination of **min_part_size** and **min_part_size_ratio**.

- `METHOD_UNSPECIFIED`
- `LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4).
- `ZSTD`: [ZSTD compression algorithm](https://facebook.github.io/zstd).
- `LZ4HC`: [LZ4 HC (high compression) algorithm](https://clickhouse.com/docs/sql-reference/statements/create/table#lz4hc). ||
|| minPartSize | **string** (int64)

The minimum size of a data part. ||
|| minPartSizeRatio | **string**

The ratio of the data part size to the table size. ||
|| level | **string** (int64)

Compression level. ||
|#

## ExternalDictionary {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary}

External dictionary configuration.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the external dictionary. ||
|| structure | **[Structure](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure)**

Required field. Structure of the external dictionary. ||
|| layout | **[Layout](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Layout)**

Required field. Layout determining how to store the dictionary in memory.

For details, see https://clickhouse.com/docs/sql-reference/dictionaries#ways-to-store-dictionaries-in-memory. ||
|| fixedLifetime | **string** (int64)

Fixed interval between dictionary updates.

Includes only one of the fields `fixedLifetime`, `lifetimeRange`. ||
|| lifetimeRange | **[Range](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Range)**

Range of intervals between dictionary updates for ClickHouse to choose from.

Includes only one of the fields `fixedLifetime`, `lifetimeRange`. ||
|| httpSource | **[HttpSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource)**

HTTP source for the dictionary.

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`. ||
|| mysqlSource | **[MysqlSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource)**

MySQL source for the dictionary.

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`. ||
|| clickhouseSource | **[ClickhouseSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.ClickhouseSource)**

ClickHouse source for the dictionary.

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`. ||
|| mongodbSource | **[MongodbSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MongodbSource)**

MongoDB source for the dictionary.

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`. ||
|| postgresqlSource | **[PostgresqlSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.PostgresqlSource)**

PostgreSQL source for the dictionary.

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`. ||
|#

## Structure {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure}

Configuration of external dictionary structure.

#|
||Field | Description ||
|| id | **[Id](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Id)**

Single numeric key column for the dictionary. ||
|| key | **[Key](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Key)**

Composite key for the dictionary, containing of one or more key columns.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). ||
|| rangeMin | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**

Field holding the beginning of the range for dictionaries with **RANGE_HASHED** layout.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). ||
|| rangeMax | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**

Field holding the end of the range for dictionaries with **RANGE_HASHED** layout.

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

Default value: **false**. ||
|| injective | **boolean**

Indication of injective mapping "id -> attribute".

Default value: **false**. ||
|#

## Layout {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Layout}

#|
||Field | Description ||
|| type | **enum** (Type)

Required field. Layout type.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#ways-to-store-dictionaries-in-memory).

- `TYPE_UNSPECIFIED`
- `FLAT`: The dictionary is completely stored in memory in the form of flat arrays.
Applicable only for dictionaries with numeric keys of the UInt64 type.
- `HASHED`: The dictionary is completely stored in memory in the form of a hash table.
Applicable only for dictionaries with numeric keys of the UInt64 type.
- `COMPLEX_KEY_HASHED`: The dictionary is completely stored in memory in the form of a hash table.
Applicable for dictionaries with composite keys of arbitrary type.
- `RANGE_HASHED`: The dictionary is stored in memory in the form of a hash table with an ordered array of ranges and their corresponding values.
Applicable only for dictionaries with numeric keys of the UInt64 type.
- `CACHE`: The dictionary is stored in a cache that has a fixed number of cells. These cells contain frequently used elements.
Applicable only for dictionaries with numeric keys of the UInt64 type.
- `COMPLEX_KEY_CACHE`: The dictionary is stored in a cache that has a fixed number of cells. These cells contain frequently used elements.
Applicable for dictionaries with composite keys of arbitrary type.
- `SPARSE_HASHED`: The dictionary is completely stored in memory in the form of a hash table.
It's similar to HASHED layout type but uses less memory in favor of more CPU usage.
Applicable only for dictionaries with numeric keys of the UInt64 type.
- `COMPLEX_KEY_SPARSE_HASHED`: The dictionary is completely stored in memory in the form of a hash table.
It's similar to COMPLEX_KEY_HASHED layout type but uses less memory in favor of more CPU usage.
Applicable for dictionaries with composite keys of arbitrary type.
- `COMPLEX_KEY_RANGE_HASHED`: The dictionary is stored in memory in the form of a hash table with an ordered array of ranges and their corresponding values.
Applicable for dictionaries with composite keys of arbitrary type.
- `DIRECT`: The dictionary is not stored in memory and directly goes to the source during the processing of a request.
Applicable only for dictionaries with numeric keys of the UInt64 type.
- `COMPLEX_KEY_DIRECT`: The dictionary is not stored in memory and directly goes to the source during the processing of a request.
Applicable for dictionaries with composite keys of arbitrary type.
- `IP_TRIE`: The specialized layout type for mapping network prefixes (IP addresses) to metadata such as ASN. ||
|| sizeInCells | **string** (int64)

Number of cells in the cache. Rounded up to a power of two.
Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.

Default value: **1000000000**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache). ||
|| allowReadExpiredKeys | **boolean**

Allows to read expired keys.
Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache). ||
|| maxUpdateQueueSize | **string** (int64)

Max size of update queue.
Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.

Default value: **100000**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache). ||
|| updateQueuePushTimeoutMilliseconds | **string** (int64)

Max timeout in milliseconds for push update task into queue.
Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.

Default value: **10**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache). ||
|| queryWaitTimeoutMilliseconds | **string** (int64)

Max wait timeout in milliseconds for update task to complete.
Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.

Default value: **60000** (1 minute).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache). ||
|| maxThreadsForUpdates | **string** (int64)

Max threads for cache dictionary update.
Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.

Default value: **4**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache). ||
|| initialArraySize | **string** (int64)

Initial dictionary key size.
Applicable only for **FLAT** layout type.

Default value: **1024**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#flat). ||
|| maxArraySize | **string** (int64)

Maximum dictionary key size.
Applicable only for **FLAT** layout type.

Default value: **500000**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#flat). ||
|| accessToKeyFromAttributes | **boolean**

Allows to retrieve key attribute using **dictGetString** function.
Enabling this option increases memory usage.
Applicable only for **IP_TRIE** layout type.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#ip_trie). ||
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

Required field. The data format. Valid values are all formats [supported by ClickHouse SQL dialect](https://clickhouse.com/docs/en/interfaces/formats/). ||
|| headers[] | **[Header](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource.Header)**

HTTP headers. ||
|#

## Header {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource.Header}

#|
||Field | Description ||
|| name | **string**

Required field. Header name. ||
|| value | **string**

Required field. Header value. ||
|#

## MysqlSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource}

#|
||Field | Description ||
|| db | **string**

Required field. Database name. ||
|| table | **string**

Required field. Table name. ||
|| port | **string** (int64)

Port to use when connecting to a replica of the dictionary source. ||
|| user | **string**

Required field. Name of the user for replicas of the dictionary source. ||
|| password | **string**

Password of the user for replicas of the dictionary source. ||
|| replicas[] | **[Replica](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource.Replica)**

List of MySQL replicas of the database used as dictionary source. ||
|| where | **string**

Selection criteria for the data in the specified MySQL table. ||
|| invalidateQuery | **string**

Query for checking the dictionary status, to pull only updated data. ||
|| closeConnection | **boolean**

Should a connection be closed after each request. ||
|| shareConnection | **boolean**

Should a connection be shared for some requests. ||
|#

## Replica {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource.Replica}

#|
||Field | Description ||
|| host | **string**

Required field. MySQL host of the replica. ||
|| priority | **string** (int64)

The priority of the replica that ClickHouse takes into account when connecting.
Replica with the highest priority should have this field set to the lowest number. ||
|| port | **string** (int64)

Port to use when connecting to the replica.
If a port is not specified for a replica, ClickHouse uses the port specified for the source. ||
|| user | **string**

Name of the MySQL database user.
If a user is not specified for a replica, ClickHouse uses the user specified for the source. ||
|| password | **string**

Password of the MySQL database user.
If a password is not specified for a replica, ClickHouse uses the password specified for the source. ||
|#

## ClickhouseSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.ClickhouseSource}

#|
||Field | Description ||
|| db | **string**

Required field. Database name. ||
|| table | **string**

Required field. Table name. ||
|| host | **string**

ClickHouse host. ||
|| port | **string** (int64)

Port to use when connecting to the host. ||
|| user | **string**

Required field. Name of the ClickHouse database user. ||
|| password | **string**

Password of the ClickHouse database user. ||
|| where | **string**

Selection criteria for the data in the specified ClickHouse table. ||
|| secure | **boolean**

Determines whether to use TLS for connection. ||
|#

## MongodbSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MongodbSource}

#|
||Field | Description ||
|| db | **string**

Required field. Database name. ||
|| collection | **string**

Required field. Collection name. ||
|| host | **string**

Required field. MongoDB host. ||
|| port | **string** (int64)

Port to use when connecting to the host. ||
|| user | **string**

Required field. Name of the MongoDB database user. ||
|| password | **string**

Password of the MongoDB database user. ||
|| options | **string**

Dictionary source options. ||
|#

## PostgresqlSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.PostgresqlSource}

#|
||Field | Description ||
|| db | **string**

Required field. Database name. ||
|| table | **string**

Required field. Table name. ||
|| hosts[] | **string**

PostgreSQL hosts. ||
|| port | **string** (int64)

Port to use when connecting to the PostgreSQL hosts. ||
|| user | **string**

Required field. Name of the PostrgreSQL database user. ||
|| password | **string**

Password of the PostrgreSQL database user. ||
|| invalidateQuery | **string**

Query for checking the dictionary status, to pull only updated data. ||
|| sslMode | **enum** (SslMode)

Mode of SSL TCP/IP connection to the PostgreSQL host.

- `SSL_MODE_UNSPECIFIED`
- `DISABLE`: Only try a non-SSL connection.
- `ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.
- `PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.
- `VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).
- `VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate. ||
|#

## GraphiteRollup {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup}

Rollup settings for the GraphiteMergeTree table engine.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#graphite-rollup).

#|
||Field | Description ||
|| name | **string**

Required field. Name for the specified combination of settings for Graphite rollup. ||
|| patterns[] | **[Pattern](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern)**

Pattern to use for the rollup. ||
|| pathColumnName | **string**

The name of the column storing the metric name (Graphite sensor).

Default value: **Path**. ||
|| timeColumnName | **string**

The name of the column storing the time of measuring the metric.

Default value: **Time**. ||
|| valueColumnName | **string**

The name of the column storing the value of the metric at the time set in **time_column_name**.

Default value: **Value**. ||
|| versionColumnName | **string**

The name of the column storing the version of the metric.

Default value: **Timestamp**. ||
|#

## Pattern {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern}

#|
||Field | Description ||
|| regexp | **string**

A pattern for the metric name (a regular or DSL). ||
|| function | **string**

The name of the aggregating function to apply to data whose age falls within the range [age, age + precision].
Accepted functions: **min**, **max**, **any**, **avg**. The average is calculated imprecisely, like the average of the averages. ||
|| retention[] | **[Retention](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern.Retention)**

Retention rules. ||
|#

## Retention {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern.Retention}

#|
||Field | Description ||
|| age | **string** (int64)

The minimum age of the data in seconds. ||
|| precision | **string** (int64)

Precision of determining the age of the data, in seconds. Should be a divisor for 86400 (seconds in a day). ||
|#

## Kafka {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Kafka}

Kafka configuration settings.
For details, see [librdkafka documentation](https://github.com/confluentinc/librdkafka/blob/master/CONFIGURATION.md).

#|
||Field | Description ||
|| securityProtocol | **enum** (SecurityProtocol)

Protocol used to communicate with brokers.

Default value: **SECURITY_PROTOCOL_PLAINTEXT**.

- `SECURITY_PROTOCOL_UNSPECIFIED`
- `SECURITY_PROTOCOL_PLAINTEXT`
- `SECURITY_PROTOCOL_SSL`
- `SECURITY_PROTOCOL_SASL_PLAINTEXT`
- `SECURITY_PROTOCOL_SASL_SSL` ||
|| saslMechanism | **enum** (SaslMechanism)

SASL mechanism to use for authentication.

Default value: **SASL_MECHANISM_GSSAPI**.

- `SASL_MECHANISM_UNSPECIFIED`
- `SASL_MECHANISM_GSSAPI`
- `SASL_MECHANISM_PLAIN`
- `SASL_MECHANISM_SCRAM_SHA_256`
- `SASL_MECHANISM_SCRAM_SHA_512` ||
|| saslUsername | **string**

SASL username for use with the PLAIN and SASL-SCRAM mechanisms. ||
|| saslPassword | **string**

SASL password for use with the PLAIN and SASL-SCRAM mechanisms. ||
|| enableSslCertificateVerification | **boolean**

Enable OpenSSL's builtin broker (server) certificate verification.

Default value: **true**. ||
|| maxPollIntervalMs | **string** (int64)

Maximum allowed time between calls to consume messages for high-level consumers.
If this interval is exceeded the consumer is considered failed and the group will
rebalance in order to reassign the partitions to another consumer group member.

Default value: **300000** (5 minutes). ||
|| sessionTimeoutMs | **string** (int64)

Client group session and failure detection timeout. The consumer sends periodic heartbeats (heartbeat.interval.ms)
to indicate its liveness to the broker. If no hearts are received by the broker for a group member within
the session timeout, the broker will remove the consumer from the group and trigger a rebalance.

Default value: **45000** (45 seconds). ||
|| debug | **enum** (Debug)

Debug context to enable.

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

Action to take when there is no initial offset in offset store or the desired offset is out of range.

Default value: **AUTO_OFFSET_RESET_LARGEST**.

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

Required field. Kafka topic name. ||
|| settings | **[Kafka](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Kafka)**

Required field. Kafka topic settings. ||
|#

## Rabbitmq {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Rabbitmq}

RabbitMQ integration settings.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/engines/table-engines/integrations/rabbitmq).

#|
||Field | Description ||
|| username | **string**

RabbitMQ username. ||
|| password | **string**

RabbitMQ password. ||
|| vhost | **string**

RabbitMQ virtual host. ||
|#

## QueryMaskingRule {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryMaskingRule}

#|
||Field | Description ||
|| name | **string**

Name for the rule. ||
|| regexp | **string**

Required field. RE2 compatible regular expression. ||
|| replace | **string**

Substitution string for sensitive data.

Default value: six asterisks. ||
|#

## QueryCache {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryCache}

Query cache configuration.

#|
||Field | Description ||
|| maxSizeInBytes | **string** (int64)

The maximum cache size in bytes.

Default value: **1073741824** (1 GiB). ||
|| maxEntries | **string** (int64)

The maximum number of **SELECT** query results stored in the cache.

Default value: **1024**. ||
|| maxEntrySizeInBytes | **string** (int64)

The maximum size in bytes **SELECT** query results may have to be saved in the cache.

Default value: **1048576** (1 MiB). ||
|| maxEntrySizeInRows | **string** (int64)

The maximum number of rows **SELECT** query results may have to be saved in the cache.

Default value: **30000000**. ||
|#

## JdbcBridge {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.JdbcBridge}

JDBC bridge configuration for queries to external databases.

#|
||Field | Description ||
|| host | **string**

Required field. Host of jdbc bridge. ||
|| port | **string** (int64)

Port of jdbc bridge.

Default value: **9019**. ||
|#

## Macro {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Macro}

ClickHouse macro.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the macro. ||
|| value | **string**

Required field. Value of the macro. ||
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

## DiskSizeAutoscaling {#yandex.cloud.mdb.clickhouse.v1.DiskSizeAutoscaling}

#|
||Field | Description ||
|| plannedUsageThreshold | **string** (int64)

Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent. ||
|| emergencyUsageThreshold | **string** (int64)

Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent. ||
|| diskSizeLimit | **string** (int64)

Limit on how large the storage for database instances can automatically grow, in bytes. ||
|#

## Zookeeper {#yandex.cloud.mdb.clickhouse.v1.ClusterConfig.Zookeeper}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.clickhouse.v1.Resources)**

Resources allocated to ZooKeeper hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.clickhouse.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings. ||
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