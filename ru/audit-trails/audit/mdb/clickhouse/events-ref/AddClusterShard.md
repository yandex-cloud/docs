---
editable: false
---

# Managed Service for ClickHouse Audit Trails Events: AddClusterShard

## Event JSON schema {#yandex.cloud.audit.mdb.clickhouse.AddClusterShard2-schema}

```json
{
  "eventId": "string",
  "eventSource": "string",
  "eventType": "string",
  "eventTime": "string",
  "authentication": {
    "authenticated": "boolean",
    // Includes only one of the fields `subjectType`
    "subjectType": "string",
    // end of the list of possible fields
    // Includes only one of the fields `subjectId`
    "subjectId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `subjectName`
    "subjectName": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationId`
    "federationId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationName`
    "federationName": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationType`
    "federationType": "string",
    // end of the list of possible fields
    "tokenInfo": {
      "maskedIamToken": "string",
      // Includes only one of the fields `iamTokenId`
      "iamTokenId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorId`
      "impersonatorId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorType`
      "impersonatorType": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorName`
      "impersonatorName": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationId`
      "impersonatorFederationId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationName`
      "impersonatorFederationName": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationType`
      "impersonatorFederationType": "string"
      // end of the list of possible fields
    }
  },
  "authorization": {
    "authorized": "boolean"
  },
  "resourceMetadata": {
    "path": [
      {
        "resourceType": "string",
        "resourceId": "string",
        // Includes only one of the fields `resourceName`
        "resourceName": "string"
        // end of the list of possible fields
      }
    ]
  },
  "requestMetadata": {
    "remoteAddress": "string",
    "userAgent": "string",
    "requestId": "string",
    // Includes only one of the fields `remotePort`
    "remotePort": "string"
    // end of the list of possible fields
  },
  "eventStatus": "string",
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "details": {
    "clusterId": "string",
    "shardName": "string",
    "shard": {
      "name": "string",
      "clusterId": "string",
      "config": {
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
              "queryMetricLogEnabled": "boolean",
              "queryMetricLogRetentionSize": "string",
              "queryMetricLogRetentionTime": "string",
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
              "vectorSimilarityIndexCacheSize": "string",
              "vectorSimilarityIndexCacheMaxEntries": "string",
              "maxBuildVectorSimilarityIndexThreadPoolSize": "string",
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
                "numberOfFreeEntriesInPoolToExecuteOptimizeEntirePartition": "string",
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
                "autoOffsetReset": "string",
                "messageMaxBytes": "string",
                "batchSize": "string"
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
                    "autoOffsetReset": "string",
                    "messageMaxBytes": "string",
                    "batchSize": "string"
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
              "queryMetricLogEnabled": "boolean",
              "queryMetricLogRetentionSize": "string",
              "queryMetricLogRetentionTime": "string",
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
              "vectorSimilarityIndexCacheSize": "string",
              "vectorSimilarityIndexCacheMaxEntries": "string",
              "maxBuildVectorSimilarityIndexThreadPoolSize": "string",
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
                "numberOfFreeEntriesInPoolToExecuteOptimizeEntirePartition": "string",
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
                "autoOffsetReset": "string",
                "messageMaxBytes": "string",
                "batchSize": "string"
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
                    "autoOffsetReset": "string",
                    "messageMaxBytes": "string",
                    "batchSize": "string"
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
              "queryMetricLogEnabled": "boolean",
              "queryMetricLogRetentionSize": "string",
              "queryMetricLogRetentionTime": "string",
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
              "vectorSimilarityIndexCacheSize": "string",
              "vectorSimilarityIndexCacheMaxEntries": "string",
              "maxBuildVectorSimilarityIndexThreadPoolSize": "string",
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
                "numberOfFreeEntriesInPoolToExecuteOptimizeEntirePartition": "string",
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
                "autoOffsetReset": "string",
                "messageMaxBytes": "string",
                "batchSize": "string"
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
                    "autoOffsetReset": "string",
                    "messageMaxBytes": "string",
                    "batchSize": "string"
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
          "weight": "string",
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        }
      }
    },
    "clusterName": "string"
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.mdb.clickhouse.AddClusterShard2}

#|
||Field | Description ||
|| eventId | **string** ||
|| eventSource | **string** ||
|| eventType | **string** ||
|| eventTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| authentication | **[IamAuthentication](#yandex.cloud.audit.IamAuthentication)** ||
|| authorization | **[Authorization](#yandex.cloud.audit.Authorization)** ||
|| resourceMetadata | **[ResourceMetadata](#yandex.cloud.audit.ResourceMetadata)** ||
|| requestMetadata | **[RequestMetadata](#yandex.cloud.audit.RequestMetadata)** ||
|| eventStatus | **enum** (EventStatus)

- `STARTED`
- `ERROR`
- `DONE`
- `CANCELLED`
- `RUNNING` ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation. ||
|| details | **[ShardEventDetails](#yandex.cloud.audit.mdb.clickhouse.ShardEventDetails)** ||
|| requestParameters | **object** ||
|| response | **object** ||
|#

## IamAuthentication {#yandex.cloud.audit.IamAuthentication}

#|
||Field | Description ||
|| authenticated | **boolean** ||
|| subjectType | **enum** (IamSubjectType)

Includes only one of the fields `subjectType`.

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| subjectId | **string**

Includes only one of the fields `subjectId`. ||
|| subjectName | **string**

Includes only one of the fields `subjectName`. ||
|| federationId | **string**

Includes only one of the fields `federationId`. ||
|| federationName | **string**

Includes only one of the fields `federationName`. ||
|| federationType | **enum** (FederationType)

Includes only one of the fields `federationType`.

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|| tokenInfo | **[IamTokenInfo](#yandex.cloud.audit.IamAuthentication.IamTokenInfo)** ||
|#

## IamTokenInfo {#yandex.cloud.audit.IamAuthentication.IamTokenInfo}

#|
||Field | Description ||
|| maskedIamToken | **string** ||
|| iamTokenId | **string**

Includes only one of the fields `iamTokenId`. ||
|| impersonatorId | **string**

Includes only one of the fields `impersonatorId`. ||
|| impersonatorType | **enum** (IamSubjectType)

Includes only one of the fields `impersonatorType`.

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| impersonatorName | **string**

Includes only one of the fields `impersonatorName`. ||
|| impersonatorFederationId | **string**

Includes only one of the fields `impersonatorFederationId`. ||
|| impersonatorFederationName | **string**

Includes only one of the fields `impersonatorFederationName`. ||
|| impersonatorFederationType | **enum** (FederationType)

Includes only one of the fields `impersonatorFederationType`.

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|#

## Authorization {#yandex.cloud.audit.Authorization}

#|
||Field | Description ||
|| authorized | **boolean** ||
|#

## ResourceMetadata {#yandex.cloud.audit.ResourceMetadata}

#|
||Field | Description ||
|| path[] | **[Resource](#yandex.cloud.audit.Resource)** ||
|#

## Resource {#yandex.cloud.audit.Resource}

#|
||Field | Description ||
|| resourceType | **string** ||
|| resourceId | **string** ||
|| resourceName | **string**

Includes only one of the fields `resourceName`. ||
|#

## RequestMetadata {#yandex.cloud.audit.RequestMetadata}

#|
||Field | Description ||
|| remoteAddress | **string** ||
|| userAgent | **string** ||
|| requestId | **string** ||
|| remotePort | **string** (int64)

Includes only one of the fields `remotePort`. ||
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

## ShardEventDetails {#yandex.cloud.audit.mdb.clickhouse.ShardEventDetails}

#|
||Field | Description ||
|| clusterId | **string** ||
|| shardName | **string** ||
|| shard | **[Shard](#yandex.cloud.mdb.clickhouse.v1.Shard)** ||
|| clusterName | **string** ||
|#

## Shard {#yandex.cloud.mdb.clickhouse.v1.Shard}

#|
||Field | Description ||
|| name | **string** ||
|| clusterId | **string** ||
|| config | **[ShardConfig](#yandex.cloud.mdb.clickhouse.v1.ShardConfig)** ||
|#

## ShardConfig {#yandex.cloud.mdb.clickhouse.v1.ShardConfig}

#|
||Field | Description ||
|| clickhouse | **[Clickhouse](#yandex.cloud.mdb.clickhouse.v1.ShardConfig.Clickhouse)** ||
|#

## Clickhouse {#yandex.cloud.mdb.clickhouse.v1.ShardConfig.Clickhouse}

#|
||Field | Description ||
|| config | **[ClickhouseConfigSet](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfigSet)** ||
|| resources | **[Resources](#yandex.cloud.mdb.clickhouse.v1.Resources)** ||
|| weight | **string** (int64) ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.clickhouse.v1.DiskSizeAutoscaling)** ||
|#

## ClickhouseConfigSet {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfigSet}

#|
||Field | Description ||
|| effectiveConfig | **[ClickhouseConfig](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig)** ||
|| userConfig | **[ClickhouseConfig](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig)** ||
|| defaultConfig | **[ClickhouseConfig](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig)** ||
|#

## ClickhouseConfig {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig}

#|
||Field | Description ||
|| backgroundPoolSize | **string** (int64)

The minimum value is 1. ||
|| backgroundMergesMutationsConcurrencyRatio | **string** (int64) ||
|| backgroundSchedulePoolSize | **string** (int64)

The minimum value is 1. ||
|| backgroundFetchesPoolSize | **string** (int64)

The minimum value is 1. ||
|| backgroundMovePoolSize | **string** (int64)

The minimum value is 1. ||
|| backgroundDistributedSchedulePoolSize | **string** (int64)

The minimum value is 1. ||
|| backgroundBufferFlushSchedulePoolSize | **string** (int64)

The minimum value is 1. ||
|| backgroundMessageBrokerSchedulePoolSize | **string** (int64)

The minimum value is 1. ||
|| backgroundCommonPoolSize | **string** (int64)

The minimum value is 1. ||
|| dictionariesLazyLoad | **boolean** ||
|| logLevel | **enum** (LogLevel)

- `TRACE`
- `DEBUG`
- `INFORMATION`
- `WARNING`
- `ERROR` ||
|| queryLogRetentionSize | **string** (int64)

The minimum value is 0. ||
|| queryLogRetentionTime | **string** (int64)

The minimum value is 0. ||
|| queryThreadLogEnabled | **boolean** ||
|| queryThreadLogRetentionSize | **string** (int64)

The minimum value is 0. ||
|| queryThreadLogRetentionTime | **string** (int64)

The minimum value is 0. ||
|| partLogRetentionSize | **string** (int64)

The minimum value is 0. ||
|| partLogRetentionTime | **string** (int64)

The minimum value is 0. ||
|| metricLogEnabled | **boolean** ||
|| metricLogRetentionSize | **string** (int64)

The minimum value is 0. ||
|| metricLogRetentionTime | **string** (int64)

The minimum value is 0. ||
|| traceLogEnabled | **boolean** ||
|| traceLogRetentionSize | **string** (int64) ||
|| traceLogRetentionTime | **string** (int64) ||
|| textLogEnabled | **boolean** ||
|| textLogRetentionSize | **string** (int64) ||
|| textLogRetentionTime | **string** (int64) ||
|| textLogLevel | **enum** (LogLevel)

- `TRACE`
- `DEBUG`
- `INFORMATION`
- `WARNING`
- `ERROR` ||
|| opentelemetrySpanLogEnabled | **boolean** ||
|| opentelemetrySpanLogRetentionSize | **string** (int64)

The minimum value is 0. ||
|| opentelemetrySpanLogRetentionTime | **string** (int64)

The minimum value is 0. ||
|| queryViewsLogEnabled | **boolean** ||
|| queryViewsLogRetentionSize | **string** (int64)

The minimum value is 0. ||
|| queryViewsLogRetentionTime | **string** (int64)

The minimum value is 0. ||
|| asynchronousMetricLogEnabled | **boolean** ||
|| asynchronousMetricLogRetentionSize | **string** (int64)

The minimum value is 0. ||
|| asynchronousMetricLogRetentionTime | **string** (int64)

The minimum value is 0. ||
|| sessionLogEnabled | **boolean** ||
|| sessionLogRetentionSize | **string** (int64)

The minimum value is 0. ||
|| sessionLogRetentionTime | **string** (int64)

The minimum value is 0. ||
|| zookeeperLogEnabled | **boolean** ||
|| zookeeperLogRetentionSize | **string** (int64)

The minimum value is 0. ||
|| zookeeperLogRetentionTime | **string** (int64)

The minimum value is 0. ||
|| asynchronousInsertLogEnabled | **boolean** ||
|| asynchronousInsertLogRetentionSize | **string** (int64)

The minimum value is 0. ||
|| asynchronousInsertLogRetentionTime | **string** (int64)

The minimum value is 0. ||
|| processorsProfileLogEnabled | **boolean** ||
|| processorsProfileLogRetentionSize | **string** (int64)

The minimum value is 0. ||
|| processorsProfileLogRetentionTime | **string** (int64)

The minimum value is 0. ||
|| errorLogEnabled | **boolean** ||
|| errorLogRetentionSize | **string** (int64)

The minimum value is 0. ||
|| errorLogRetentionTime | **string** (int64)

The minimum value is 0. ||
|| queryMetricLogEnabled | **boolean** ||
|| queryMetricLogRetentionSize | **string** (int64)

The minimum value is 0. ||
|| queryMetricLogRetentionTime | **string** (int64)

The minimum value is 0. ||
|| accessControlImprovements | **[AccessControlImprovements](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.AccessControlImprovements)** ||
|| maxConnections | **string** (int64)

Acceptable values are 128 to 8192, inclusive. ||
|| maxConcurrentQueries | **string** (int64)

The minimum value is 100. ||
|| maxTableSizeToDrop | **string** (int64)

The minimum value is 0. ||
|| maxPartitionSizeToDrop | **string** (int64)

The minimum value is 0. ||
|| keepAliveTimeout | **string** (int64) ||
|| uncompressedCacheSize | **string** (int64) ||
|| markCacheSize | **string** (int64) ||
|| timezone | **string** ||
|| geobaseEnabled | **boolean** ||
|| geobaseUri | **string** ||
|| defaultDatabase | **string** ||
|| totalMemoryProfilerStep | **string** (int64) ||
|| totalMemoryTrackerSampleProbability | **number** (double) ||
|| asyncInsertThreads | **string** (int64)

The minimum value is 0. ||
|| backupThreads | **string** (int64) ||
|| restoreThreads | **string** (int64) ||
|| vectorSimilarityIndexCacheSize | **string** (int64)

The minimum value is 0. ||
|| vectorSimilarityIndexCacheMaxEntries | **string** (int64)

The minimum value is 0. ||
|| maxBuildVectorSimilarityIndexThreadPoolSize | **string** (int64)

The minimum value is 0. ||
|| mergeTree | **[MergeTree](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.MergeTree)** ||
|| compression[] | **[Compression](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Compression)** ||
|| dictionaries[] | **[ExternalDictionary](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary)** ||
|| graphiteRollup[] | **[GraphiteRollup](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup)** ||
|| kafka | **[Kafka](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Kafka)** ||
|| kafkaTopics[] | **[KafkaTopic](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.KafkaTopic)** ||
|| rabbitmq | **[Rabbitmq](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Rabbitmq)** ||
|| queryMaskingRules[] | **[QueryMaskingRule](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryMaskingRule)** ||
|| queryCache | **[QueryCache](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryCache)** ||
|| jdbcBridge | **[JdbcBridge](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.JdbcBridge)** ||
|| mysqlProtocol | **boolean** ||
|| customMacros[] | **[Macro](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Macro)** ||
|| builtinDictionariesReloadInterval | **string** (int64) ||
|#

## AccessControlImprovements {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.AccessControlImprovements}

#|
||Field | Description ||
|| selectFromSystemDbRequiresGrant | **boolean** ||
|| selectFromInformationSchemaRequiresGrant | **boolean** ||
|#

## MergeTree {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.MergeTree}

#|
||Field | Description ||
|| partsToDelayInsert | **string** (int64) ||
|| partsToThrowInsert | **string** (int64) ||
|| inactivePartsToDelayInsert | **string** (int64)

The minimum value is 0. ||
|| inactivePartsToThrowInsert | **string** (int64)

The minimum value is 0. ||
|| maxAvgPartSizeForTooManyParts | **string** (int64)

The minimum value is 0. ||
|| maxPartsInTotal | **string** (int64) ||
|| maxReplicatedMergesInQueue | **string** (int64) ||
|| numberOfFreeEntriesInPoolToLowerMaxSizeOfMerge | **string** (int64) ||
|| numberOfFreeEntriesInPoolToExecuteMutation | **string** (int64) ||
|| numberOfFreeEntriesInPoolToExecuteOptimizeEntirePartition | **string** (int64) ||
|| maxBytesToMergeAtMinSpaceInPool | **string** (int64) ||
|| maxBytesToMergeAtMaxSpaceInPool | **string** (int64)

The minimum value is 0. ||
|| minBytesForWidePart | **string** (int64) ||
|| minRowsForWidePart | **string** (int64) ||
|| cleanupDelayPeriod | **string** (int64)

The minimum value is 0. ||
|| maxCleanupDelayPeriod | **string** (int64)

The minimum value is 0. ||
|| mergeSelectingSleepMs | **string** (int64)

The minimum value is 0. ||
|| maxMergeSelectingSleepMs | **string** (int64)

The minimum value is 0. ||
|| minAgeToForceMergeSeconds | **string** (int64)

The minimum value is 0. ||
|| minAgeToForceMergeOnPartitionOnly | **boolean** ||
|| mergeMaxBlockSize | **string** (int64) ||
|| deduplicateMergeProjectionMode | **enum** (DeduplicateMergeProjectionMode)

- `DEDUPLICATE_MERGE_PROJECTION_MODE_IGNORE`
- `DEDUPLICATE_MERGE_PROJECTION_MODE_THROW`
- `DEDUPLICATE_MERGE_PROJECTION_MODE_DROP`
- `DEDUPLICATE_MERGE_PROJECTION_MODE_REBUILD` ||
|| lightweightMutationProjectionMode | **enum** (LightweightMutationProjectionMode)

- `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_THROW`
- `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_DROP`
- `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_REBUILD` ||
|| replicatedDeduplicationWindow | **string** (int64) ||
|| replicatedDeduplicationWindowSeconds | **string** (int64) ||
|| fsyncAfterInsert | **boolean** ||
|| fsyncPartDirectory | **boolean** ||
|| minCompressedBytesToFsyncAfterFetch | **string** (int64) ||
|| minCompressedBytesToFsyncAfterMerge | **string** (int64) ||
|| minRowsToFsyncAfterMerge | **string** (int64) ||
|| ttlOnlyDropParts | **boolean** ||
|| mergeWithTtlTimeout | **string** (int64) ||
|| mergeWithRecompressionTtlTimeout | **string** (int64) ||
|| maxNumberOfMergesWithTtlInPool | **string** (int64) ||
|| materializeTtlRecalculateOnly | **boolean** ||
|| checkSampleColumnIsCorrect | **boolean** ||
|| allowRemoteFsZeroCopyReplication | **boolean** ||
|#

## Compression {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Compression}

#|
||Field | Description ||
|| method | **enum** (Method)

- `LZ4`
- `ZSTD`
- `LZ4HC` ||
|| minPartSize | **string** (int64) ||
|| minPartSizeRatio | **string** ||
|| level | **string** (int64) ||
|#

## ExternalDictionary {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary}

#|
||Field | Description ||
|| name | **string** ||
|| structure | **[Structure](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure)** ||
|| layout | **[Layout](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Layout)** ||
|| fixedLifetime | **string** (int64)

Includes only one of the fields `fixedLifetime`, `lifetimeRange`. ||
|| lifetimeRange | **[Range](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Range)**

Includes only one of the fields `fixedLifetime`, `lifetimeRange`. ||
|| httpSource | **[HttpSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource)**

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`. ||
|| mysqlSource | **[MysqlSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource)**

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`. ||
|| clickhouseSource | **[ClickhouseSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.ClickhouseSource)**

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`. ||
|| mongodbSource | **[MongodbSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MongodbSource)**

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`. ||
|| postgresqlSource | **[PostgresqlSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.PostgresqlSource)**

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`. ||
|#

## Structure {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure}

#|
||Field | Description ||
|| id | **[Id](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Id)** ||
|| key | **[Key](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Key)** ||
|| rangeMin | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)** ||
|| rangeMax | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)** ||
|| attributes[] | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**

The number of elements must be greater than 0. ||
|#

## Id {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Id}

#|
||Field | Description ||
|| name | **string** ||
|#

## Key {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Key}

#|
||Field | Description ||
|| attributes[] | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**

The number of elements must be greater than 0. ||
|#

## Attribute {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute}

#|
||Field | Description ||
|| name | **string** ||
|| type | **string** ||
|| nullValue | **string** ||
|| expression | **string** ||
|| hierarchical | **boolean** ||
|| injective | **boolean** ||
|#

## Layout {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Layout}

#|
||Field | Description ||
|| type | **enum** (Type)

- `FLAT`
- `HASHED`
- `COMPLEX_KEY_HASHED`
- `RANGE_HASHED`
- `CACHE`
- `COMPLEX_KEY_CACHE`
- `SPARSE_HASHED`
- `COMPLEX_KEY_SPARSE_HASHED`
- `COMPLEX_KEY_RANGE_HASHED`
- `DIRECT`
- `COMPLEX_KEY_DIRECT`
- `IP_TRIE` ||
|| sizeInCells | **string** (int64)

The minimum value is 0. ||
|| allowReadExpiredKeys | **boolean** ||
|| maxUpdateQueueSize | **string** (int64)

The minimum value is 0. ||
|| updateQueuePushTimeoutMilliseconds | **string** (int64)

The minimum value is 0. ||
|| queryWaitTimeoutMilliseconds | **string** (int64)

The minimum value is 0. ||
|| maxThreadsForUpdates | **string** (int64)

The minimum value is 0. ||
|| initialArraySize | **string** (int64)

The minimum value is 0. ||
|| maxArraySize | **string** (int64)

The minimum value is 0. ||
|| accessToKeyFromAttributes | **boolean** ||
|#

## Range {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Range}

#|
||Field | Description ||
|| min | **string** (int64) ||
|| max | **string** (int64) ||
|#

## HttpSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource}

#|
||Field | Description ||
|| url | **string** ||
|| format | **string** ||
|| headers[] | **[Header](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource.Header)** ||
|#

## Header {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource.Header}

#|
||Field | Description ||
|| name | **string** ||
|| value | **string** ||
|#

## MysqlSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource}

#|
||Field | Description ||
|| db | **string** ||
|| table | **string** ||
|| port | **string** (int64)

Acceptable values are 0 to 65535, inclusive. ||
|| user | **string** ||
|| password | **string** ||
|| replicas[] | **[Replica](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource.Replica)** ||
|| where | **string** ||
|| invalidateQuery | **string** ||
|| closeConnection | **boolean** ||
|| shareConnection | **boolean** ||
|#

## Replica {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource.Replica}

#|
||Field | Description ||
|| host | **string**

The maximum string length in characters is 253. ||
|| priority | **string** (int64)

The minimum value is 0. ||
|| port | **string** (int64)

Acceptable values are 0 to 65535, inclusive. ||
|| user | **string** ||
|| password | **string** ||
|#

## ClickhouseSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.ClickhouseSource}

#|
||Field | Description ||
|| db | **string** ||
|| table | **string** ||
|| host | **string**

The maximum string length in characters is 253. ||
|| port | **string** (int64)

Acceptable values are 0 to 65535, inclusive. ||
|| user | **string** ||
|| password | **string** ||
|| where | **string** ||
|| secure | **boolean** ||
|#

## MongodbSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MongodbSource}

#|
||Field | Description ||
|| db | **string** ||
|| collection | **string** ||
|| host | **string**

The maximum string length in characters is 253. ||
|| port | **string** (int64)

Acceptable values are 0 to 65535, inclusive. ||
|| user | **string** ||
|| password | **string** ||
|| options | **string** ||
|#

## PostgresqlSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.PostgresqlSource}

#|
||Field | Description ||
|| db | **string** ||
|| table | **string** ||
|| hosts[] | **string** ||
|| port | **string** (int64)

Acceptable values are 0 to 65535, inclusive. ||
|| user | **string** ||
|| password | **string** ||
|| invalidateQuery | **string** ||
|| sslMode | **enum** (SslMode)

- `DISABLE`
- `ALLOW`
- `PREFER`
- `VERIFY_CA`
- `VERIFY_FULL` ||
|#

## GraphiteRollup {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup}

#|
||Field | Description ||
|| name | **string** ||
|| patterns[] | **[Pattern](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern)**

The number of elements must be greater than 0. ||
|| pathColumnName | **string** ||
|| timeColumnName | **string** ||
|| valueColumnName | **string** ||
|| versionColumnName | **string** ||
|#

## Pattern {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern}

#|
||Field | Description ||
|| regexp | **string** ||
|| function | **string** ||
|| retention[] | **[Retention](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern.Retention)** ||
|#

## Retention {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern.Retention}

#|
||Field | Description ||
|| age | **string** (int64) ||
|| precision | **string** (int64) ||
|#

## Kafka {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Kafka}

#|
||Field | Description ||
|| securityProtocol | **enum** (SecurityProtocol)

- `SECURITY_PROTOCOL_PLAINTEXT`
- `SECURITY_PROTOCOL_SSL`
- `SECURITY_PROTOCOL_SASL_PLAINTEXT`
- `SECURITY_PROTOCOL_SASL_SSL` ||
|| saslMechanism | **enum** (SaslMechanism)

- `SASL_MECHANISM_GSSAPI`
- `SASL_MECHANISM_PLAIN`
- `SASL_MECHANISM_SCRAM_SHA_256`
- `SASL_MECHANISM_SCRAM_SHA_512` ||
|| saslUsername | **string** ||
|| saslPassword | **string** ||
|| enableSslCertificateVerification | **boolean** ||
|| maxPollIntervalMs | **string** (int64)

The minimum value is 0. ||
|| sessionTimeoutMs | **string** (int64)

The minimum value is 0. ||
|| debug | **enum** (Debug)

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

- `AUTO_OFFSET_RESET_SMALLEST`
- `AUTO_OFFSET_RESET_EARLIEST`
- `AUTO_OFFSET_RESET_BEGINNING`
- `AUTO_OFFSET_RESET_LARGEST`
- `AUTO_OFFSET_RESET_LATEST`
- `AUTO_OFFSET_RESET_END`
- `AUTO_OFFSET_RESET_ERROR` ||
|| messageMaxBytes | **string** (int64)

Acceptable values are 1000 to 1000000000, inclusive. ||
|| batchSize | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|#

## KafkaTopic {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.KafkaTopic}

#|
||Field | Description ||
|| name | **string** ||
|| settings | **[Kafka](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Kafka)** ||
|#

## Rabbitmq {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Rabbitmq}

#|
||Field | Description ||
|| username | **string** ||
|| password | **string** ||
|| vhost | **string** ||
|#

## QueryMaskingRule {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryMaskingRule}

#|
||Field | Description ||
|| name | **string** ||
|| regexp | **string** ||
|| replace | **string** ||
|#

## QueryCache {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryCache}

#|
||Field | Description ||
|| maxSizeInBytes | **string** (int64)

The minimum value is 0. ||
|| maxEntries | **string** (int64)

The minimum value is 0. ||
|| maxEntrySizeInBytes | **string** (int64)

The minimum value is 0. ||
|| maxEntrySizeInRows | **string** (int64)

The minimum value is 0. ||
|#

## JdbcBridge {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.JdbcBridge}

#|
||Field | Description ||
|| host | **string** ||
|| port | **string** (int64)

Acceptable values are 0 to 65535, inclusive. ||
|#

## Macro {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Macro}

#|
||Field | Description ||
|| name | **string**

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_][a-zA-Z0-9_-]* `. ||
|| value | **string**

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_][a-zA-Z0-9_-]* `. ||
|#

## Resources {#yandex.cloud.mdb.clickhouse.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string** ||
|| diskSize | **string** (int64) ||
|| diskTypeId | **string** ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.clickhouse.v1.DiskSizeAutoscaling}

#|
||Field | Description ||
|| plannedUsageThreshold | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|| emergencyUsageThreshold | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|| diskSizeLimit | **string** (int64) ||
|#