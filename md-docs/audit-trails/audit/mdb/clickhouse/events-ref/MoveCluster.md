[Документация Yandex Cloud](../../../../../index.md) > [Yandex Audit Trails](../../../../index.md) > Справочник аудитных логов (англ.) > mdb.clickhouse > MoveCluster

# Managed Service for ClickHouse Audit Trails Events: MoveCluster

## Event JSON schema {#yandex.cloud.audit.mdb.clickhouse.MoveCluster2-schema}

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
    "clusterName": "string",
    "cluster": {
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
                "replicatedDeduplicationWindowForAsyncInserts": "string",
                "replicatedDeduplicationWindowSecondsForAsyncInserts": "string",
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
                    "accessToKeyFromAttributes": "boolean",
                    "blockSize": "string",
                    "fileSize": "string",
                    "readBufferSize": "string",
                    "writeBufferSize": "string"
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
              "tls": {
                "trustedCertificates": [
                  "string"
                ]
              },
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
                "replicatedDeduplicationWindowForAsyncInserts": "string",
                "replicatedDeduplicationWindowSecondsForAsyncInserts": "string",
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
                    "accessToKeyFromAttributes": "boolean",
                    "blockSize": "string",
                    "fileSize": "string",
                    "readBufferSize": "string",
                    "writeBufferSize": "string"
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
              "tls": {
                "trustedCertificates": [
                  "string"
                ]
              },
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
                "replicatedDeduplicationWindowForAsyncInserts": "string",
                "replicatedDeduplicationWindowSecondsForAsyncInserts": "string",
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
                    "accessToKeyFromAttributes": "boolean",
                    "blockSize": "string",
                    "fileSize": "string",
                    "readBufferSize": "string",
                    "writeBufferSize": "string"
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
              "tls": {
                "trustedCertificates": [
                  "string"
                ]
              },
              "builtinDictionariesReloadInterval": "string"
            }
          },
          "defaultUserSettings": {
            "readonly": "string",
            "allowDdl": "boolean",
            "allowIntrospectionFunctions": "boolean",
            "connectTimeout": "string",
            "connectTimeoutWithFailover": "string",
            "connectTimeoutWithFailoverSecure": "string",
            "connectionsWithFailoverMaxTries": "string",
            "receiveTimeout": "string",
            "sendTimeout": "string",
            "idleConnectionTimeout": "string",
            "timeoutBeforeCheckingExecutionSpeed": "string",
            "insertQuorum": "string",
            "insertQuorumTimeout": "string",
            "insertQuorumParallel": "boolean",
            "selectSequentialConsistency": "boolean",
            "replicationAlterPartitionsSync": "string",
            "maxReplicaDelayForDistributedQueries": "string",
            "fallbackToStaleReplicasForDistributedQueries": "boolean",
            "distributedProductMode": "string",
            "distributedAggregationMemoryEfficient": "boolean",
            "distributedDdlTaskTimeout": "string",
            "distributedDdlOutputMode": "string",
            "skipUnavailableShards": "boolean",
            "useHedgedRequests": "boolean",
            "hedgedConnectionTimeoutMs": "string",
            "loadBalancing": "string",
            "preferLocalhostReplica": "boolean",
            "compileExpressions": "boolean",
            "minCountToCompileExpression": "string",
            "maxBlockSize": "string",
            "minInsertBlockSizeRows": "string",
            "minInsertBlockSizeBytes": "string",
            "maxInsertBlockSize": "string",
            "maxPartitionsPerInsertBlock": "string",
            "minBytesToUseDirectIo": "string",
            "useUncompressedCache": "boolean",
            "mergeTreeMaxRowsToUseCache": "string",
            "mergeTreeMaxBytesToUseCache": "string",
            "mergeTreeMinRowsForConcurrentRead": "string",
            "mergeTreeMinBytesForConcurrentRead": "string",
            "maxBytesBeforeExternalGroupBy": "string",
            "maxBytesRatioBeforeExternalGroupBy": "number",
            "maxBytesRatioBeforeExternalSort": "number",
            "maxBytesBeforeExternalSort": "string",
            "groupByTwoLevelThreshold": "string",
            "groupByTwoLevelThresholdBytes": "string",
            "deduplicateBlocksInDependentMaterializedViews": "boolean",
            "localFilesystemReadMethod": "string",
            "remoteFilesystemReadMethod": "string",
            "priority": "string",
            "maxThreads": "string",
            "maxInsertThreads": "string",
            "maxMemoryUsage": "string",
            "maxMemoryUsageForUser": "string",
            "memoryOvercommitRatioDenominator": "string",
            "memoryOvercommitRatioDenominatorForUser": "string",
            "memoryUsageOvercommitMaxWaitMicroseconds": "string",
            "maxNetworkBandwidth": "string",
            "maxNetworkBandwidthForUser": "string",
            "maxNetworkBytes": "string",
            "maxTemporaryDataOnDiskSizeForQuery": "string",
            "maxTemporaryDataOnDiskSizeForUser": "string",
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
            "maxColumnsToRead": "string",
            "maxTemporaryColumns": "string",
            "maxTemporaryNonConstColumns": "string",
            "maxQuerySize": "string",
            "maxAstDepth": "string",
            "maxAstElements": "string",
            "maxExpandedAstElements": "string",
            "maxParserDepth": "string",
            "minExecutionSpeed": "string",
            "minExecutionSpeedBytes": "string",
            "inputFormatValuesInterpretExpressions": "boolean",
            "inputFormatDefaultsForOmittedFields": "boolean",
            "inputFormatNullAsDefault": "boolean",
            "inputFormatWithNamesUseHeader": "boolean",
            "outputFormatJsonQuote_64bitIntegers": "boolean",
            "outputFormatJsonQuoteDenormals": "boolean",
            "dateTimeInputFormat": "string",
            "dateTimeOutputFormat": "string",
            "lowCardinalityAllowInNativeFormat": "boolean",
            "emptyResultForAggregationByEmptySet": "boolean",
            "formatRegexp": "string",
            "formatRegexpEscapingRule": "string",
            "formatRegexpSkipUnmatched": "boolean",
            "inputFormatParallelParsing": "boolean",
            "inputFormatImportNestedJson": "boolean",
            "formatAvroSchemaRegistryUrl": "string",
            "dataTypeDefaultNullable": "boolean",
            "httpConnectionTimeout": "string",
            "httpReceiveTimeout": "string",
            "httpSendTimeout": "string",
            "enableHttpCompression": "boolean",
            "sendProgressInHttpHeaders": "boolean",
            "httpHeadersProgressInterval": "string",
            "addHttpCorsHeader": "boolean",
            "cancelHttpReadonlyQueriesOnClientClose": "boolean",
            "maxHttpGetRedirects": "string",
            "httpMaxFieldNameSize": "string",
            "httpMaxFieldValueSize": "string",
            "quotaMode": "string",
            "asyncInsert": "boolean",
            "waitForAsyncInsert": "boolean",
            "waitForAsyncInsertTimeout": "string",
            "asyncInsertMaxDataSize": "string",
            "asyncInsertBusyTimeout": "string",
            "asyncInsertUseAdaptiveBusyTimeout": "boolean",
            "logQueryThreads": "boolean",
            "logQueryViews": "boolean",
            "logQueriesProbability": "number",
            "logProcessorsProfiles": "boolean",
            "useQueryCache": "boolean",
            "enableReadsFromQueryCache": "boolean",
            "enableWritesToQueryCache": "boolean",
            "queryCacheMinQueryRuns": "string",
            "queryCacheMinQueryDuration": "string",
            "queryCacheTtl": "string",
            "queryCacheMaxEntries": "string",
            "queryCacheMaxSizeInBytes": "string",
            "queryCacheTag": "string",
            "queryCacheShareBetweenUsers": "boolean",
            "queryCacheNondeterministicFunctionHandling": "string",
            "queryCacheSystemTableHandling": "string",
            "countDistinctImplementation": "string",
            "joinedSubqueryRequiresAlias": "boolean",
            "joinUseNulls": "boolean",
            "transformNullIn": "boolean",
            "insertNullAsDefault": "boolean",
            "joinAlgorithm": [
              "string"
            ],
            "anyJoinDistinctRightTableKeys": "boolean",
            "allowSuspiciousLowCardinalityTypes": "boolean",
            "flattenNested": "boolean",
            "memoryProfilerStep": "string",
            "memoryProfilerSampleProbability": "number",
            "maxFinalThreads": "string",
            "maxReadBufferSize": "string",
            "insertKeeperMaxRetries": "string",
            "doNotMergeAcrossPartitionsSelectFinal": "boolean",
            "ignoreMaterializedViewsWithDroppedTargetTable": "boolean",
            "enableAnalyzer": "boolean",
            "s3UseAdaptiveTimeouts": "boolean",
            "final": "boolean",
            "useHivePartitioning": "boolean",
            "showDataLakeCatalogsInSystemTables": "boolean",
            "compile": "boolean",
            "minCountToCompile": "string",
            "asyncInsertThreads": "string",
            "asyncInsertStaleTimeout": "string"
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
        "backupRetainPeriodDays": "string",
        "performanceDiagnostics": {
          "enabled": "boolean",
          "processesRefreshInterval": "string"
        },
        "fullVersion": "string"
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
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.mdb.clickhouse.MoveCluster2}

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
|| details | **[ClusterEventDetails](#yandex.cloud.audit.mdb.clickhouse.ClusterEventDetails)** ||
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

## ClusterEventDetails {#yandex.cloud.audit.mdb.clickhouse.ClusterEventDetails}

#|
||Field | Description ||
|| clusterId | **string** ||
|| clusterName | **string** ||
|| cluster | **[Cluster](#yandex.cloud.mdb.clickhouse.v1.Cluster)** ||
|#

## Cluster {#yandex.cloud.mdb.clickhouse.v1.Cluster}

#|
||Field | Description ||
|| id | **string** ||
|| folderId | **string** ||
|| createdAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string** ||
|| description | **string** ||
|| labels | **object** (map<**string**, **string**>) ||
|| environment | **enum** (Environment)

- `PRODUCTION`
- `PRESTABLE` ||
|| monitoring[] | **[Monitoring](#yandex.cloud.mdb.clickhouse.v1.Monitoring)** ||
|| config | **[ClusterConfig](#yandex.cloud.mdb.clickhouse.v1.ClusterConfig)** ||
|| networkId | **string** ||
|| health | **enum** (Health)

- `HEALTH_UNKNOWN`
- `ALIVE`
- `DEAD`
- `DEGRADED` ||
|| status | **enum** (Status)

- `STATUS_UNKNOWN`
- `CREATING`
- `RUNNING`
- `ERROR`
- `UPDATING`
- `STOPPING`
- `STOPPED`
- `STARTING` ||
|| serviceAccountId | **string** ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.clickhouse.v1.MaintenanceWindow)** ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.mdb.clickhouse.v1.MaintenanceOperation)** ||
|| securityGroupIds[] | **string** ||
|| deletionProtection | **boolean** ||
|| diskEncryptionKeyId | **string** ||
|#

## Monitoring {#yandex.cloud.mdb.clickhouse.v1.Monitoring}

#|
||Field | Description ||
|| name | **string** ||
|| description | **string** ||
|| link | **string** ||
|#

## ClusterConfig {#yandex.cloud.mdb.clickhouse.v1.ClusterConfig}

#|
||Field | Description ||
|| version | **string** ||
|| clickhouse | **[Clickhouse](#yandex.cloud.mdb.clickhouse.v1.ClusterConfig.Clickhouse)** ||
|| zookeeper | **[Zookeeper](#yandex.cloud.mdb.clickhouse.v1.ClusterConfig.Zookeeper)** ||
|| backupWindowStart | **[TimeOfDay](#google.type.TimeOfDay)** ||
|| access | **[Access](#yandex.cloud.mdb.clickhouse.v1.Access)** ||
|| cloudStorage | **[CloudStorage](#yandex.cloud.mdb.clickhouse.v1.CloudStorage)** ||
|| sqlDatabaseManagement | **boolean** ||
|| sqlUserManagement | **boolean** ||
|| embeddedKeeper | **boolean** ||
|| backupRetainPeriodDays | **string** (int64) ||
|| performanceDiagnostics | **[PerformanceDiagnostics](#yandex.cloud.mdb.clickhouse.v1.PerformanceDiagnostics)** ||
|| fullVersion | **string** ||
|#

## Clickhouse {#yandex.cloud.mdb.clickhouse.v1.ClusterConfig.Clickhouse}

#|
||Field | Description ||
|| config | **[ClickhouseConfigSet](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfigSet)** ||
|| defaultUserSettings | **[UserSettings](#yandex.cloud.mdb.clickhouse.v1.UserSettings)** ||
|| resources | **[Resources](#yandex.cloud.mdb.clickhouse.v1.Resources)** ||
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
|| backgroundPoolSize | **string** (int64) ||
|| backgroundMergesMutationsConcurrencyRatio | **string** (int64) ||
|| backgroundSchedulePoolSize | **string** (int64) ||
|| backgroundFetchesPoolSize | **string** (int64) ||
|| backgroundMovePoolSize | **string** (int64) ||
|| backgroundDistributedSchedulePoolSize | **string** (int64) ||
|| backgroundBufferFlushSchedulePoolSize | **string** (int64) ||
|| backgroundMessageBrokerSchedulePoolSize | **string** (int64) ||
|| backgroundCommonPoolSize | **string** (int64) ||
|| dictionariesLazyLoad | **boolean** ||
|| logLevel | **enum** (LogLevel)

- `TRACE`
- `DEBUG`
- `INFORMATION`
- `WARNING`
- `ERROR` ||
|| queryLogRetentionSize | **string** (int64) ||
|| queryLogRetentionTime | **string** (int64) ||
|| queryThreadLogEnabled | **boolean** ||
|| queryThreadLogRetentionSize | **string** (int64) ||
|| queryThreadLogRetentionTime | **string** (int64) ||
|| partLogRetentionSize | **string** (int64) ||
|| partLogRetentionTime | **string** (int64) ||
|| metricLogEnabled | **boolean** ||
|| metricLogRetentionSize | **string** (int64) ||
|| metricLogRetentionTime | **string** (int64) ||
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
|| opentelemetrySpanLogRetentionSize | **string** (int64) ||
|| opentelemetrySpanLogRetentionTime | **string** (int64) ||
|| queryViewsLogEnabled | **boolean** ||
|| queryViewsLogRetentionSize | **string** (int64) ||
|| queryViewsLogRetentionTime | **string** (int64) ||
|| asynchronousMetricLogEnabled | **boolean** ||
|| asynchronousMetricLogRetentionSize | **string** (int64) ||
|| asynchronousMetricLogRetentionTime | **string** (int64) ||
|| sessionLogEnabled | **boolean** ||
|| sessionLogRetentionSize | **string** (int64) ||
|| sessionLogRetentionTime | **string** (int64) ||
|| zookeeperLogEnabled | **boolean** ||
|| zookeeperLogRetentionSize | **string** (int64) ||
|| zookeeperLogRetentionTime | **string** (int64) ||
|| asynchronousInsertLogEnabled | **boolean** ||
|| asynchronousInsertLogRetentionSize | **string** (int64) ||
|| asynchronousInsertLogRetentionTime | **string** (int64) ||
|| processorsProfileLogEnabled | **boolean** ||
|| processorsProfileLogRetentionSize | **string** (int64) ||
|| processorsProfileLogRetentionTime | **string** (int64) ||
|| errorLogEnabled | **boolean** ||
|| errorLogRetentionSize | **string** (int64) ||
|| errorLogRetentionTime | **string** (int64) ||
|| queryMetricLogEnabled | **boolean** ||
|| queryMetricLogRetentionSize | **string** (int64) ||
|| queryMetricLogRetentionTime | **string** (int64) ||
|| accessControlImprovements | **[AccessControlImprovements](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.AccessControlImprovements)** ||
|| maxConnections | **string** (int64) ||
|| maxConcurrentQueries | **string** (int64) ||
|| maxTableSizeToDrop | **string** (int64) ||
|| maxPartitionSizeToDrop | **string** (int64) ||
|| keepAliveTimeout | **string** (int64) ||
|| uncompressedCacheSize | **string** (int64) ||
|| markCacheSize | **string** (int64) ||
|| timezone | **string** ||
|| geobaseEnabled | **boolean** ||
|| geobaseUri | **string** ||
|| defaultDatabase | **string** ||
|| totalMemoryProfilerStep | **string** (int64) ||
|| totalMemoryTrackerSampleProbability | **number** (double) ||
|| asyncInsertThreads | **string** (int64) ||
|| backupThreads | **string** (int64) ||
|| restoreThreads | **string** (int64) ||
|| vectorSimilarityIndexCacheSize | **string** (int64) ||
|| vectorSimilarityIndexCacheMaxEntries | **string** (int64) ||
|| maxBuildVectorSimilarityIndexThreadPoolSize | **string** (int64) ||
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
|| tls | **[Tls](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Tls)** ||
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
|| inactivePartsToDelayInsert | **string** (int64) ||
|| inactivePartsToThrowInsert | **string** (int64) ||
|| maxAvgPartSizeForTooManyParts | **string** (int64) ||
|| maxPartsInTotal | **string** (int64) ||
|| maxReplicatedMergesInQueue | **string** (int64) ||
|| numberOfFreeEntriesInPoolToLowerMaxSizeOfMerge | **string** (int64) ||
|| numberOfFreeEntriesInPoolToExecuteMutation | **string** (int64) ||
|| numberOfFreeEntriesInPoolToExecuteOptimizeEntirePartition | **string** (int64) ||
|| maxBytesToMergeAtMinSpaceInPool | **string** (int64) ||
|| maxBytesToMergeAtMaxSpaceInPool | **string** (int64) ||
|| minBytesForWidePart | **string** (int64) ||
|| minRowsForWidePart | **string** (int64) ||
|| cleanupDelayPeriod | **string** (int64) ||
|| maxCleanupDelayPeriod | **string** (int64) ||
|| mergeSelectingSleepMs | **string** (int64) ||
|| maxMergeSelectingSleepMs | **string** (int64) ||
|| minAgeToForceMergeSeconds | **string** (int64) ||
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
|| replicatedDeduplicationWindowForAsyncInserts | **string** (int64) ||
|| replicatedDeduplicationWindowSecondsForAsyncInserts | **string** (int64) ||
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
- `IP_TRIE`
- `SSD_CACHE`
- `COMPLEX_KEY_SSD_CACHE` ||
|| sizeInCells | **string** (int64) ||
|| allowReadExpiredKeys | **boolean** ||
|| maxUpdateQueueSize | **string** (int64) ||
|| updateQueuePushTimeoutMilliseconds | **string** (int64) ||
|| queryWaitTimeoutMilliseconds | **string** (int64) ||
|| maxThreadsForUpdates | **string** (int64) ||
|| initialArraySize | **string** (int64) ||
|| maxArraySize | **string** (int64) ||
|| accessToKeyFromAttributes | **boolean** ||
|| blockSize | **string** (int64) ||
|| fileSize | **string** (int64) ||
|| readBufferSize | **string** (int64) ||
|| writeBufferSize | **string** (int64) ||
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
|| port | **string** (int64) ||
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
|| priority | **string** (int64) ||
|| port | **string** (int64) ||
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
|| port | **string** (int64) ||
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
|| port | **string** (int64) ||
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
|| port | **string** (int64) ||
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
|| maxPollIntervalMs | **string** (int64) ||
|| sessionTimeoutMs | **string** (int64) ||
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
|| messageMaxBytes | **string** (int64) ||
|| batchSize | **string** (int64) ||
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
|| maxSizeInBytes | **string** (int64) ||
|| maxEntries | **string** (int64) ||
|| maxEntrySizeInBytes | **string** (int64) ||
|| maxEntrySizeInRows | **string** (int64) ||
|#

## JdbcBridge {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.JdbcBridge}

#|
||Field | Description ||
|| host | **string** ||
|| port | **string** (int64) ||
|#

## Macro {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Macro}

#|
||Field | Description ||
|| name | **string**

The maximum string length in characters is 63. ||
|| value | **string**

The maximum string length in characters is 63. ||
|#

## Tls {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Tls}

#|
||Field | Description ||
|| trustedCertificates[] | **string** ||
|#

## UserSettings {#yandex.cloud.mdb.clickhouse.v1.UserSettings}

#|
||Field | Description ||
|| readonly | **string** (int64) ||
|| allowDdl | **boolean** ||
|| allowIntrospectionFunctions | **boolean** ||
|| connectTimeout | **string** (int64) ||
|| connectTimeoutWithFailover | **string** (int64) ||
|| connectTimeoutWithFailoverSecure | **string** (int64) ||
|| connectionsWithFailoverMaxTries | **string** (int64) ||
|| receiveTimeout | **string** (int64) ||
|| sendTimeout | **string** (int64) ||
|| idleConnectionTimeout | **string** (int64) ||
|| timeoutBeforeCheckingExecutionSpeed | **string** (int64) ||
|| insertQuorum | **string** (int64) ||
|| insertQuorumTimeout | **string** (int64) ||
|| insertQuorumParallel | **boolean** ||
|| selectSequentialConsistency | **boolean** ||
|| replicationAlterPartitionsSync | **string** (int64) ||
|| maxReplicaDelayForDistributedQueries | **string** (int64) ||
|| fallbackToStaleReplicasForDistributedQueries | **boolean** ||
|| distributedProductMode | **enum** (DistributedProductMode)

- `DISTRIBUTED_PRODUCT_MODE_DENY`
- `DISTRIBUTED_PRODUCT_MODE_LOCAL`
- `DISTRIBUTED_PRODUCT_MODE_GLOBAL`
- `DISTRIBUTED_PRODUCT_MODE_ALLOW` ||
|| distributedAggregationMemoryEfficient | **boolean** ||
|| distributedDdlTaskTimeout | **string** (int64) ||
|| distributedDdlOutputMode | **enum** (DistributedDdlOutputMode)

- `DISTRIBUTED_DDL_OUTPUT_MODE_THROW`
- `DISTRIBUTED_DDL_OUTPUT_MODE_NONE`
- `DISTRIBUTED_DDL_OUTPUT_MODE_NULL_STATUS_ON_TIMEOUT`
- `DISTRIBUTED_DDL_OUTPUT_MODE_NEVER_THROW`
- `DISTRIBUTED_DDL_OUTPUT_MODE_NONE_ONLY_ACTIVE`
- `DISTRIBUTED_DDL_OUTPUT_MODE_NULL_STATUS_ON_TIMEOUT_ONLY_ACTIVE`
- `DISTRIBUTED_DDL_OUTPUT_MODE_THROW_ONLY_ACTIVE` ||
|| skipUnavailableShards | **boolean** ||
|| useHedgedRequests | **boolean** ||
|| hedgedConnectionTimeoutMs | **string** (int64) ||
|| loadBalancing | **enum** (LoadBalancing)

- `LOAD_BALANCING_RANDOM`
- `LOAD_BALANCING_NEAREST_HOSTNAME`
- `LOAD_BALANCING_IN_ORDER`
- `LOAD_BALANCING_FIRST_OR_RANDOM`
- `LOAD_BALANCING_ROUND_ROBIN` ||
|| preferLocalhostReplica | **boolean** ||
|| compileExpressions | **boolean** ||
|| minCountToCompileExpression | **string** (int64) ||
|| maxBlockSize | **string** (int64) ||
|| minInsertBlockSizeRows | **string** (int64) ||
|| minInsertBlockSizeBytes | **string** (int64) ||
|| maxInsertBlockSize | **string** (int64) ||
|| maxPartitionsPerInsertBlock | **string** (int64) ||
|| minBytesToUseDirectIo | **string** (int64) ||
|| useUncompressedCache | **boolean** ||
|| mergeTreeMaxRowsToUseCache | **string** (int64) ||
|| mergeTreeMaxBytesToUseCache | **string** (int64) ||
|| mergeTreeMinRowsForConcurrentRead | **string** (int64) ||
|| mergeTreeMinBytesForConcurrentRead | **string** (int64) ||
|| maxBytesBeforeExternalGroupBy | **string** (int64) ||
|| maxBytesRatioBeforeExternalGroupBy | **number** (double) ||
|| maxBytesRatioBeforeExternalSort | **number** (double) ||
|| maxBytesBeforeExternalSort | **string** (int64) ||
|| groupByTwoLevelThreshold | **string** (int64) ||
|| groupByTwoLevelThresholdBytes | **string** (int64) ||
|| deduplicateBlocksInDependentMaterializedViews | **boolean** ||
|| localFilesystemReadMethod | **enum** (LocalFilesystemReadMethod)

- `LOCAL_FILESYSTEM_READ_METHOD_READ`
- `LOCAL_FILESYSTEM_READ_METHOD_PREAD_THREADPOOL`
- `LOCAL_FILESYSTEM_READ_METHOD_PREAD`
- `LOCAL_FILESYSTEM_READ_METHOD_NMAP`
- `LOCAL_FILESYSTEM_READ_METHOD_IO_URING` ||
|| remoteFilesystemReadMethod | **enum** (RemoteFilesystemReadMethod)

- `REMOTE_FILESYSTEM_READ_METHOD_READ`
- `REMOTE_FILESYSTEM_READ_METHOD_THREADPOOL` ||
|| priority | **string** (int64) ||
|| maxThreads | **string** (int64) ||
|| maxInsertThreads | **string** (int64) ||
|| maxMemoryUsage | **string** (int64) ||
|| maxMemoryUsageForUser | **string** (int64) ||
|| memoryOvercommitRatioDenominator | **string** (int64) ||
|| memoryOvercommitRatioDenominatorForUser | **string** (int64) ||
|| memoryUsageOvercommitMaxWaitMicroseconds | **string** (int64) ||
|| maxNetworkBandwidth | **string** (int64) ||
|| maxNetworkBandwidthForUser | **string** (int64) ||
|| maxNetworkBytes | **string** (int64) ||
|| maxTemporaryDataOnDiskSizeForQuery | **string** (int64) ||
|| maxTemporaryDataOnDiskSizeForUser | **string** (int64) ||
|| maxConcurrentQueriesForUser | **string** (int64) ||
|| forceIndexByDate | **boolean** ||
|| forcePrimaryKey | **boolean** ||
|| maxRowsToRead | **string** (int64) ||
|| maxBytesToRead | **string** (int64) ||
|| readOverflowMode | **enum** (OverflowMode)

- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxRowsToGroupBy | **string** (int64) ||
|| groupByOverflowMode | **enum** (GroupByOverflowMode)

- `GROUP_BY_OVERFLOW_MODE_THROW`
- `GROUP_BY_OVERFLOW_MODE_BREAK`
- `GROUP_BY_OVERFLOW_MODE_ANY` ||
|| maxRowsToSort | **string** (int64) ||
|| maxBytesToSort | **string** (int64) ||
|| sortOverflowMode | **enum** (OverflowMode)

- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxResultRows | **string** (int64) ||
|| maxResultBytes | **string** (int64) ||
|| resultOverflowMode | **enum** (OverflowMode)

- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxRowsInDistinct | **string** (int64) ||
|| maxBytesInDistinct | **string** (int64) ||
|| distinctOverflowMode | **enum** (OverflowMode)

- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxRowsToTransfer | **string** (int64) ||
|| maxBytesToTransfer | **string** (int64) ||
|| transferOverflowMode | **enum** (OverflowMode)

- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxExecutionTime | **string** (int64) ||
|| timeoutOverflowMode | **enum** (OverflowMode)

- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxRowsInSet | **string** (int64) ||
|| maxBytesInSet | **string** (int64) ||
|| setOverflowMode | **enum** (OverflowMode)

- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxRowsInJoin | **string** (int64) ||
|| maxBytesInJoin | **string** (int64) ||
|| joinOverflowMode | **enum** (OverflowMode)

- `OVERFLOW_MODE_THROW`
- `OVERFLOW_MODE_BREAK` ||
|| maxColumnsToRead | **string** (int64) ||
|| maxTemporaryColumns | **string** (int64) ||
|| maxTemporaryNonConstColumns | **string** (int64) ||
|| maxQuerySize | **string** (int64) ||
|| maxAstDepth | **string** (int64) ||
|| maxAstElements | **string** (int64) ||
|| maxExpandedAstElements | **string** (int64) ||
|| maxParserDepth | **string** (int64) ||
|| minExecutionSpeed | **string** (int64) ||
|| minExecutionSpeedBytes | **string** (int64) ||
|| inputFormatValuesInterpretExpressions | **boolean** ||
|| inputFormatDefaultsForOmittedFields | **boolean** ||
|| inputFormatNullAsDefault | **boolean** ||
|| inputFormatWithNamesUseHeader | **boolean** ||
|| outputFormatJsonQuote_64bitIntegers | **boolean** ||
|| outputFormatJsonQuoteDenormals | **boolean** ||
|| dateTimeInputFormat | **enum** (DateTimeInputFormat)

- `DATE_TIME_INPUT_FORMAT_BEST_EFFORT`
- `DATE_TIME_INPUT_FORMAT_BASIC`
- `DATE_TIME_INPUT_FORMAT_BEST_EFFORT_US` ||
|| dateTimeOutputFormat | **enum** (DateTimeOutputFormat)

- `DATE_TIME_OUTPUT_FORMAT_SIMPLE`
- `DATE_TIME_OUTPUT_FORMAT_ISO`
- `DATE_TIME_OUTPUT_FORMAT_UNIX_TIMESTAMP` ||
|| lowCardinalityAllowInNativeFormat | **boolean** ||
|| emptyResultForAggregationByEmptySet | **boolean** ||
|| formatRegexp | **string** ||
|| formatRegexpEscapingRule | **enum** (FormatRegexpEscapingRule)

- `FORMAT_REGEXP_ESCAPING_RULE_ESCAPED`
- `FORMAT_REGEXP_ESCAPING_RULE_QUOTED`
- `FORMAT_REGEXP_ESCAPING_RULE_CSV`
- `FORMAT_REGEXP_ESCAPING_RULE_JSON`
- `FORMAT_REGEXP_ESCAPING_RULE_XML`
- `FORMAT_REGEXP_ESCAPING_RULE_RAW` ||
|| formatRegexpSkipUnmatched | **boolean** ||
|| inputFormatParallelParsing | **boolean** ||
|| inputFormatImportNestedJson | **boolean** ||
|| formatAvroSchemaRegistryUrl | **string** ||
|| dataTypeDefaultNullable | **boolean** ||
|| httpConnectionTimeout | **string** (int64) ||
|| httpReceiveTimeout | **string** (int64) ||
|| httpSendTimeout | **string** (int64) ||
|| enableHttpCompression | **boolean** ||
|| sendProgressInHttpHeaders | **boolean** ||
|| httpHeadersProgressInterval | **string** (int64) ||
|| addHttpCorsHeader | **boolean** ||
|| cancelHttpReadonlyQueriesOnClientClose | **boolean** ||
|| maxHttpGetRedirects | **string** (int64) ||
|| httpMaxFieldNameSize | **string** (int64) ||
|| httpMaxFieldValueSize | **string** (int64) ||
|| quotaMode | **enum** (QuotaMode)

- `QUOTA_MODE_DEFAULT`
- `QUOTA_MODE_KEYED`
- `QUOTA_MODE_KEYED_BY_IP` ||
|| asyncInsert | **boolean** ||
|| waitForAsyncInsert | **boolean** ||
|| waitForAsyncInsertTimeout | **string** (int64) ||
|| asyncInsertMaxDataSize | **string** (int64) ||
|| asyncInsertBusyTimeout | **string** (int64) ||
|| asyncInsertUseAdaptiveBusyTimeout | **boolean** ||
|| logQueryThreads | **boolean** ||
|| logQueryViews | **boolean** ||
|| logQueriesProbability | **number** (double) ||
|| logProcessorsProfiles | **boolean** ||
|| useQueryCache | **boolean** ||
|| enableReadsFromQueryCache | **boolean** ||
|| enableWritesToQueryCache | **boolean** ||
|| queryCacheMinQueryRuns | **string** (int64) ||
|| queryCacheMinQueryDuration | **string** (int64) ||
|| queryCacheTtl | **string** (int64) ||
|| queryCacheMaxEntries | **string** (int64) ||
|| queryCacheMaxSizeInBytes | **string** (int64) ||
|| queryCacheTag | **string** ||
|| queryCacheShareBetweenUsers | **boolean** ||
|| queryCacheNondeterministicFunctionHandling | **enum** (QueryCacheNondeterministicFunctionHandling)

- `QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_THROW`
- `QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_SAVE`
- `QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_IGNORE` ||
|| queryCacheSystemTableHandling | **enum** (QueryCacheSystemTableHandling)

- `QUERY_CACHE_SYSTEM_TABLE_HANDLING_THROW`
- `QUERY_CACHE_SYSTEM_TABLE_HANDLING_SAVE`
- `QUERY_CACHE_SYSTEM_TABLE_HANDLING_IGNORE` ||
|| countDistinctImplementation | **enum** (CountDistinctImplementation)

- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_COMBINED`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_COMBINED_64`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_HLL_12`
- `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_EXACT` ||
|| joinedSubqueryRequiresAlias | **boolean** ||
|| joinUseNulls | **boolean** ||
|| transformNullIn | **boolean** ||
|| insertNullAsDefault | **boolean** ||
|| joinAlgorithm[] | **enum** (JoinAlgorithm)

- `JOIN_ALGORITHM_HASH`
- `JOIN_ALGORITHM_PARALLEL_HASH`
- `JOIN_ALGORITHM_PARTIAL_MERGE`
- `JOIN_ALGORITHM_DIRECT`
- `JOIN_ALGORITHM_AUTO`
- `JOIN_ALGORITHM_FULL_SORTING_MERGE`
- `JOIN_ALGORITHM_PREFER_PARTIAL_MERGE` ||
|| anyJoinDistinctRightTableKeys | **boolean** ||
|| allowSuspiciousLowCardinalityTypes | **boolean** ||
|| flattenNested | **boolean** ||
|| memoryProfilerStep | **string** (int64) ||
|| memoryProfilerSampleProbability | **number** (double) ||
|| maxFinalThreads | **string** (int64) ||
|| maxReadBufferSize | **string** (int64) ||
|| insertKeeperMaxRetries | **string** (int64) ||
|| doNotMergeAcrossPartitionsSelectFinal | **boolean** ||
|| ignoreMaterializedViewsWithDroppedTargetTable | **boolean** ||
|| enableAnalyzer | **boolean** ||
|| s3UseAdaptiveTimeouts | **boolean** ||
|| final | **boolean** ||
|| useHivePartitioning | **boolean** ||
|| showDataLakeCatalogsInSystemTables | **boolean** ||
|| compile | **boolean** ||
|| minCountToCompile | **string** (int64) ||
|| asyncInsertThreads | **string** (int64) ||
|| asyncInsertStaleTimeout | **string** (int64) ||
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

## Zookeeper {#yandex.cloud.mdb.clickhouse.v1.ClusterConfig.Zookeeper}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.clickhouse.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.clickhouse.v1.DiskSizeAutoscaling)** ||
|#

## TimeOfDay {#google.type.TimeOfDay}

#|
||Field | Description ||
|| hours | **integer** (int32) ||
|| minutes | **integer** (int32) ||
|| seconds | **integer** (int32) ||
|| nanos | **integer** (int32) ||
|#

## Access {#yandex.cloud.mdb.clickhouse.v1.Access}

#|
||Field | Description ||
|| dataLens | **boolean** ||
|| webSql | **boolean** ||
|| metrika | **boolean** ||
|| serverless | **boolean** ||
|| dataTransfer | **boolean** ||
|| yandexQuery | **boolean** ||
|#

## CloudStorage {#yandex.cloud.mdb.clickhouse.v1.CloudStorage}

#|
||Field | Description ||
|| enabled | **boolean** ||
|| moveFactor | **number** (double)

Acceptable values are 0 to 1, inclusive. ||
|| dataCacheEnabled | **boolean** ||
|| dataCacheMaxSize | **string** (int64) ||
|| preferNotToMerge | **boolean** ||
|#

## PerformanceDiagnostics {#yandex.cloud.mdb.clickhouse.v1.PerformanceDiagnostics}

#|
||Field | Description ||
|| enabled | **boolean** ||
|| processesRefreshInterval | **string** (duration) ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.clickhouse.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **object**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.clickhouse.v1.WeeklyMaintenanceWindow)**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.clickhouse.v1.WeeklyMaintenanceWindow}

#|
||Field | Description ||
|| day | **enum** (WeekDay)

- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **string** (int64)

Acceptable values are 1 to 24, inclusive. ||
|#

## MaintenanceOperation {#yandex.cloud.mdb.clickhouse.v1.MaintenanceOperation}

#|
||Field | Description ||
|| info | **string**

The maximum string length in characters is 256. ||
|| delayedUntil | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#