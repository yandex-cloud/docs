---
editable: false
sourcePath: en/_api-ref/mdb/clickhouse/v1/api-ref/Cluster/getShard.md
---

# Managed Service for ClickHouse API, REST: Cluster.getShard
Returns the specified shard.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}/shards/{shardName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the cluster that the shard belongs to. To get the cluster ID, use a <a href="/docs/managed-clickhouse/api-ref/Cluster/list">list</a> request. To get the name of the database, use a <a href="/docs/managed-clickhouse/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
shardName | <p>Required. Name of the shard to request information about. To get the name of a shard, use a <a href="/docs/managed-clickhouse/api-ref/Cluster/listShards">listShards</a> request.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
  "clusterId": "string",
  "config": {
    "clickhouse": {
      "config": {
        "effectiveConfig": {
          "logLevel": "string",
          "mergeTree": {
            "replicatedDeduplicationWindow": "integer",
            "replicatedDeduplicationWindowSeconds": "integer",
            "partsToDelayInsert": "integer",
            "partsToThrowInsert": "integer",
            "inactivePartsToDelayInsert": "integer",
            "inactivePartsToThrowInsert": "integer",
            "maxReplicatedMergesInQueue": "integer",
            "numberOfFreeEntriesInPoolToLowerMaxSizeOfMerge": "integer",
            "maxBytesToMergeAtMinSpaceInPool": "integer",
            "maxBytesToMergeAtMaxSpaceInPool": "integer",
            "minBytesForWidePart": "integer",
            "minRowsForWidePart": "integer",
            "ttlOnlyDropParts": true,
            "allowRemoteFsZeroCopyReplication": true,
            "mergeWithTtlTimeout": "integer",
            "mergeWithRecompressionTtlTimeout": "integer",
            "maxPartsInTotal": "integer",
            "maxNumberOfMergesWithTtlInPool": "integer",
            "cleanupDelayPeriod": "integer",
            "numberOfFreeEntriesInPoolToExecuteMutation": "integer",
            "maxAvgPartSizeForTooManyParts": "integer",
            "minAgeToForceMergeSeconds": "integer",
            "minAgeToForceMergeOnPartitionOnly": true,
            "mergeSelectingSleepMs": "integer",
            "mergeMaxBlockSize": "integer",
            "checkSampleColumnIsCorrect": true,
            "maxMergeSelectingSleepMs": "integer",
            "maxCleanupDelayPeriod": "integer"
          },
          "compression": [
            {
              "method": "string",
              "minPartSize": "string",
              "minPartSizeRatio": "number",
              "level": "integer"
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
                      "hierarchical": true,
                      "injective": true
                    }
                  ]
                },
                "rangeMin": {
                  "name": "string",
                  "type": "string",
                  "nullValue": "string",
                  "expression": "string",
                  "hierarchical": true,
                  "injective": true
                },
                "rangeMax": {
                  "name": "string",
                  "type": "string",
                  "nullValue": "string",
                  "expression": "string",
                  "hierarchical": true,
                  "injective": true
                },
                "attributes": [
                  {
                    "name": "string",
                    "type": "string",
                    "nullValue": "string",
                    "expression": "string",
                    "hierarchical": true,
                    "injective": true
                  }
                ]
              },
              "layout": {
                "type": "string",
                "sizeInCells": "string",
                "maxArraySize": "string"
              },

              // `config.clickhouse.config.effectiveConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`
              "fixedLifetime": "string",
              "lifetimeRange": {
                "min": "string",
                "max": "string"
              },
              // end of the list of possible fields`config.clickhouse.config.effectiveConfig.dictionaries[]`

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
                "closeConnection": true,
                "shareConnection": true
              },
              "clickhouseSource": {
                "db": "string",
                "table": "string",
                "host": "string",
                "port": "string",
                "user": "string",
                "password": "string",
                "where": "string",
                "secure": true
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
            "enableSslCertificateVerification": true,
            "maxPollIntervalMs": "integer",
            "sessionTimeoutMs": "integer",
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
                "enableSslCertificateVerification": true,
                "maxPollIntervalMs": "integer",
                "sessionTimeoutMs": "integer",
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
          "maxConnections": "integer",
          "maxConcurrentQueries": "integer",
          "keepAliveTimeout": "integer",
          "uncompressedCacheSize": "integer",
          "markCacheSize": "integer",
          "maxTableSizeToDrop": "integer",
          "maxPartitionSizeToDrop": "integer",
          "builtinDictionariesReloadInterval": "integer",
          "timezone": "string",
          "geobaseEnabled": true,
          "geobaseUri": "string",
          "queryLogRetentionSize": "integer",
          "queryLogRetentionTime": "integer",
          "queryThreadLogEnabled": true,
          "queryThreadLogRetentionSize": "integer",
          "queryThreadLogRetentionTime": "integer",
          "partLogRetentionSize": "integer",
          "partLogRetentionTime": "integer",
          "metricLogEnabled": true,
          "metricLogRetentionSize": "integer",
          "metricLogRetentionTime": "integer",
          "traceLogEnabled": true,
          "traceLogRetentionSize": "integer",
          "traceLogRetentionTime": "integer",
          "textLogEnabled": true,
          "textLogRetentionSize": "integer",
          "textLogRetentionTime": "integer",
          "textLogLevel": "string",
          "opentelemetrySpanLogEnabled": true,
          "opentelemetrySpanLogRetentionSize": "integer",
          "opentelemetrySpanLogRetentionTime": "integer",
          "queryViewsLogEnabled": true,
          "queryViewsLogRetentionSize": "integer",
          "queryViewsLogRetentionTime": "integer",
          "asynchronousMetricLogEnabled": true,
          "asynchronousMetricLogRetentionSize": "integer",
          "asynchronousMetricLogRetentionTime": "integer",
          "sessionLogEnabled": true,
          "sessionLogRetentionSize": "integer",
          "sessionLogRetentionTime": "integer",
          "zookeeperLogEnabled": true,
          "zookeeperLogRetentionSize": "integer",
          "zookeeperLogRetentionTime": "integer",
          "asynchronousInsertLogEnabled": true,
          "asynchronousInsertLogRetentionSize": "integer",
          "asynchronousInsertLogRetentionTime": "integer",
          "backgroundPoolSize": "integer",
          "backgroundMergesMutationsConcurrencyRatio": "integer",
          "backgroundSchedulePoolSize": "integer",
          "backgroundFetchesPoolSize": "integer",
          "backgroundMovePoolSize": "integer",
          "backgroundDistributedSchedulePoolSize": "integer",
          "backgroundBufferFlushSchedulePoolSize": "integer",
          "backgroundMessageBrokerSchedulePoolSize": "integer",
          "backgroundCommonPoolSize": "integer",
          "defaultDatabase": "string",
          "totalMemoryProfilerStep": "integer",
          "totalMemoryTrackerSampleProbability": "number",
          "queryMaskingRules": [
            {
              "name": "string",
              "regexp": "string",
              "replace": "string"
            }
          ],
          "dictionariesLazyLoad": true,
          "queryCache": {
            "maxSizeInBytes": "integer",
            "maxEntries": "integer",
            "maxEntrySizeInBytes": "integer",
            "maxEntrySizeInRows": "integer"
          }
        },
        "userConfig": {
          "logLevel": "string",
          "mergeTree": {
            "replicatedDeduplicationWindow": "integer",
            "replicatedDeduplicationWindowSeconds": "integer",
            "partsToDelayInsert": "integer",
            "partsToThrowInsert": "integer",
            "inactivePartsToDelayInsert": "integer",
            "inactivePartsToThrowInsert": "integer",
            "maxReplicatedMergesInQueue": "integer",
            "numberOfFreeEntriesInPoolToLowerMaxSizeOfMerge": "integer",
            "maxBytesToMergeAtMinSpaceInPool": "integer",
            "maxBytesToMergeAtMaxSpaceInPool": "integer",
            "minBytesForWidePart": "integer",
            "minRowsForWidePart": "integer",
            "ttlOnlyDropParts": true,
            "allowRemoteFsZeroCopyReplication": true,
            "mergeWithTtlTimeout": "integer",
            "mergeWithRecompressionTtlTimeout": "integer",
            "maxPartsInTotal": "integer",
            "maxNumberOfMergesWithTtlInPool": "integer",
            "cleanupDelayPeriod": "integer",
            "numberOfFreeEntriesInPoolToExecuteMutation": "integer",
            "maxAvgPartSizeForTooManyParts": "integer",
            "minAgeToForceMergeSeconds": "integer",
            "minAgeToForceMergeOnPartitionOnly": true,
            "mergeSelectingSleepMs": "integer",
            "mergeMaxBlockSize": "integer",
            "checkSampleColumnIsCorrect": true,
            "maxMergeSelectingSleepMs": "integer",
            "maxCleanupDelayPeriod": "integer"
          },
          "compression": [
            {
              "method": "string",
              "minPartSize": "string",
              "minPartSizeRatio": "number",
              "level": "integer"
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
                      "hierarchical": true,
                      "injective": true
                    }
                  ]
                },
                "rangeMin": {
                  "name": "string",
                  "type": "string",
                  "nullValue": "string",
                  "expression": "string",
                  "hierarchical": true,
                  "injective": true
                },
                "rangeMax": {
                  "name": "string",
                  "type": "string",
                  "nullValue": "string",
                  "expression": "string",
                  "hierarchical": true,
                  "injective": true
                },
                "attributes": [
                  {
                    "name": "string",
                    "type": "string",
                    "nullValue": "string",
                    "expression": "string",
                    "hierarchical": true,
                    "injective": true
                  }
                ]
              },
              "layout": {
                "type": "string",
                "sizeInCells": "string",
                "maxArraySize": "string"
              },

              // `config.clickhouse.config.userConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`
              "fixedLifetime": "string",
              "lifetimeRange": {
                "min": "string",
                "max": "string"
              },
              // end of the list of possible fields`config.clickhouse.config.userConfig.dictionaries[]`

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
                "closeConnection": true,
                "shareConnection": true
              },
              "clickhouseSource": {
                "db": "string",
                "table": "string",
                "host": "string",
                "port": "string",
                "user": "string",
                "password": "string",
                "where": "string",
                "secure": true
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
            "enableSslCertificateVerification": true,
            "maxPollIntervalMs": "integer",
            "sessionTimeoutMs": "integer",
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
                "enableSslCertificateVerification": true,
                "maxPollIntervalMs": "integer",
                "sessionTimeoutMs": "integer",
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
          "maxConnections": "integer",
          "maxConcurrentQueries": "integer",
          "keepAliveTimeout": "integer",
          "uncompressedCacheSize": "integer",
          "markCacheSize": "integer",
          "maxTableSizeToDrop": "integer",
          "maxPartitionSizeToDrop": "integer",
          "builtinDictionariesReloadInterval": "integer",
          "timezone": "string",
          "geobaseEnabled": true,
          "geobaseUri": "string",
          "queryLogRetentionSize": "integer",
          "queryLogRetentionTime": "integer",
          "queryThreadLogEnabled": true,
          "queryThreadLogRetentionSize": "integer",
          "queryThreadLogRetentionTime": "integer",
          "partLogRetentionSize": "integer",
          "partLogRetentionTime": "integer",
          "metricLogEnabled": true,
          "metricLogRetentionSize": "integer",
          "metricLogRetentionTime": "integer",
          "traceLogEnabled": true,
          "traceLogRetentionSize": "integer",
          "traceLogRetentionTime": "integer",
          "textLogEnabled": true,
          "textLogRetentionSize": "integer",
          "textLogRetentionTime": "integer",
          "textLogLevel": "string",
          "opentelemetrySpanLogEnabled": true,
          "opentelemetrySpanLogRetentionSize": "integer",
          "opentelemetrySpanLogRetentionTime": "integer",
          "queryViewsLogEnabled": true,
          "queryViewsLogRetentionSize": "integer",
          "queryViewsLogRetentionTime": "integer",
          "asynchronousMetricLogEnabled": true,
          "asynchronousMetricLogRetentionSize": "integer",
          "asynchronousMetricLogRetentionTime": "integer",
          "sessionLogEnabled": true,
          "sessionLogRetentionSize": "integer",
          "sessionLogRetentionTime": "integer",
          "zookeeperLogEnabled": true,
          "zookeeperLogRetentionSize": "integer",
          "zookeeperLogRetentionTime": "integer",
          "asynchronousInsertLogEnabled": true,
          "asynchronousInsertLogRetentionSize": "integer",
          "asynchronousInsertLogRetentionTime": "integer",
          "backgroundPoolSize": "integer",
          "backgroundMergesMutationsConcurrencyRatio": "integer",
          "backgroundSchedulePoolSize": "integer",
          "backgroundFetchesPoolSize": "integer",
          "backgroundMovePoolSize": "integer",
          "backgroundDistributedSchedulePoolSize": "integer",
          "backgroundBufferFlushSchedulePoolSize": "integer",
          "backgroundMessageBrokerSchedulePoolSize": "integer",
          "backgroundCommonPoolSize": "integer",
          "defaultDatabase": "string",
          "totalMemoryProfilerStep": "integer",
          "totalMemoryTrackerSampleProbability": "number",
          "queryMaskingRules": [
            {
              "name": "string",
              "regexp": "string",
              "replace": "string"
            }
          ],
          "dictionariesLazyLoad": true,
          "queryCache": {
            "maxSizeInBytes": "integer",
            "maxEntries": "integer",
            "maxEntrySizeInBytes": "integer",
            "maxEntrySizeInRows": "integer"
          }
        },
        "defaultConfig": {
          "logLevel": "string",
          "mergeTree": {
            "replicatedDeduplicationWindow": "integer",
            "replicatedDeduplicationWindowSeconds": "integer",
            "partsToDelayInsert": "integer",
            "partsToThrowInsert": "integer",
            "inactivePartsToDelayInsert": "integer",
            "inactivePartsToThrowInsert": "integer",
            "maxReplicatedMergesInQueue": "integer",
            "numberOfFreeEntriesInPoolToLowerMaxSizeOfMerge": "integer",
            "maxBytesToMergeAtMinSpaceInPool": "integer",
            "maxBytesToMergeAtMaxSpaceInPool": "integer",
            "minBytesForWidePart": "integer",
            "minRowsForWidePart": "integer",
            "ttlOnlyDropParts": true,
            "allowRemoteFsZeroCopyReplication": true,
            "mergeWithTtlTimeout": "integer",
            "mergeWithRecompressionTtlTimeout": "integer",
            "maxPartsInTotal": "integer",
            "maxNumberOfMergesWithTtlInPool": "integer",
            "cleanupDelayPeriod": "integer",
            "numberOfFreeEntriesInPoolToExecuteMutation": "integer",
            "maxAvgPartSizeForTooManyParts": "integer",
            "minAgeToForceMergeSeconds": "integer",
            "minAgeToForceMergeOnPartitionOnly": true,
            "mergeSelectingSleepMs": "integer",
            "mergeMaxBlockSize": "integer",
            "checkSampleColumnIsCorrect": true,
            "maxMergeSelectingSleepMs": "integer",
            "maxCleanupDelayPeriod": "integer"
          },
          "compression": [
            {
              "method": "string",
              "minPartSize": "string",
              "minPartSizeRatio": "number",
              "level": "integer"
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
                      "hierarchical": true,
                      "injective": true
                    }
                  ]
                },
                "rangeMin": {
                  "name": "string",
                  "type": "string",
                  "nullValue": "string",
                  "expression": "string",
                  "hierarchical": true,
                  "injective": true
                },
                "rangeMax": {
                  "name": "string",
                  "type": "string",
                  "nullValue": "string",
                  "expression": "string",
                  "hierarchical": true,
                  "injective": true
                },
                "attributes": [
                  {
                    "name": "string",
                    "type": "string",
                    "nullValue": "string",
                    "expression": "string",
                    "hierarchical": true,
                    "injective": true
                  }
                ]
              },
              "layout": {
                "type": "string",
                "sizeInCells": "string",
                "maxArraySize": "string"
              },

              // `config.clickhouse.config.defaultConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`
              "fixedLifetime": "string",
              "lifetimeRange": {
                "min": "string",
                "max": "string"
              },
              // end of the list of possible fields`config.clickhouse.config.defaultConfig.dictionaries[]`

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
                "closeConnection": true,
                "shareConnection": true
              },
              "clickhouseSource": {
                "db": "string",
                "table": "string",
                "host": "string",
                "port": "string",
                "user": "string",
                "password": "string",
                "where": "string",
                "secure": true
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
            "enableSslCertificateVerification": true,
            "maxPollIntervalMs": "integer",
            "sessionTimeoutMs": "integer",
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
                "enableSslCertificateVerification": true,
                "maxPollIntervalMs": "integer",
                "sessionTimeoutMs": "integer",
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
          "maxConnections": "integer",
          "maxConcurrentQueries": "integer",
          "keepAliveTimeout": "integer",
          "uncompressedCacheSize": "integer",
          "markCacheSize": "integer",
          "maxTableSizeToDrop": "integer",
          "maxPartitionSizeToDrop": "integer",
          "builtinDictionariesReloadInterval": "integer",
          "timezone": "string",
          "geobaseEnabled": true,
          "geobaseUri": "string",
          "queryLogRetentionSize": "integer",
          "queryLogRetentionTime": "integer",
          "queryThreadLogEnabled": true,
          "queryThreadLogRetentionSize": "integer",
          "queryThreadLogRetentionTime": "integer",
          "partLogRetentionSize": "integer",
          "partLogRetentionTime": "integer",
          "metricLogEnabled": true,
          "metricLogRetentionSize": "integer",
          "metricLogRetentionTime": "integer",
          "traceLogEnabled": true,
          "traceLogRetentionSize": "integer",
          "traceLogRetentionTime": "integer",
          "textLogEnabled": true,
          "textLogRetentionSize": "integer",
          "textLogRetentionTime": "integer",
          "textLogLevel": "string",
          "opentelemetrySpanLogEnabled": true,
          "opentelemetrySpanLogRetentionSize": "integer",
          "opentelemetrySpanLogRetentionTime": "integer",
          "queryViewsLogEnabled": true,
          "queryViewsLogRetentionSize": "integer",
          "queryViewsLogRetentionTime": "integer",
          "asynchronousMetricLogEnabled": true,
          "asynchronousMetricLogRetentionSize": "integer",
          "asynchronousMetricLogRetentionTime": "integer",
          "sessionLogEnabled": true,
          "sessionLogRetentionSize": "integer",
          "sessionLogRetentionTime": "integer",
          "zookeeperLogEnabled": true,
          "zookeeperLogRetentionSize": "integer",
          "zookeeperLogRetentionTime": "integer",
          "asynchronousInsertLogEnabled": true,
          "asynchronousInsertLogRetentionSize": "integer",
          "asynchronousInsertLogRetentionTime": "integer",
          "backgroundPoolSize": "integer",
          "backgroundMergesMutationsConcurrencyRatio": "integer",
          "backgroundSchedulePoolSize": "integer",
          "backgroundFetchesPoolSize": "integer",
          "backgroundMovePoolSize": "integer",
          "backgroundDistributedSchedulePoolSize": "integer",
          "backgroundBufferFlushSchedulePoolSize": "integer",
          "backgroundMessageBrokerSchedulePoolSize": "integer",
          "backgroundCommonPoolSize": "integer",
          "defaultDatabase": "string",
          "totalMemoryProfilerStep": "integer",
          "totalMemoryTrackerSampleProbability": "number",
          "queryMaskingRules": [
            {
              "name": "string",
              "regexp": "string",
              "replace": "string"
            }
          ],
          "dictionariesLazyLoad": true,
          "queryCache": {
            "maxSizeInBytes": "integer",
            "maxEntries": "integer",
            "maxEntrySizeInBytes": "integer",
            "maxEntrySizeInRows": "integer"
          }
        }
      },
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      },
      "weight": "integer"
    }
  }
}
```

 
Field | Description
--- | ---
name | **string**<br><p>Name of the shard.</p> 
clusterId | **string**<br><p>ID of the cluster that the shard belongs to.</p> 
config | **object**<br><p>Configuration of the shard.</p> 
config.<br>clickhouse | **object**<br><p>ClickHouse configuration for a shard.</p> 
config.<br>clickhouse.<br>config | **object**<br><p>ClickHouse settings for a shard.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig | **object**<br><p>Required. Effective settings for a ClickHouse cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> <p>ClickHouse configuration options. Detailed description for each set of options is available in <a href="https://clickhouse.com/docs/en/operations/server_settings/settings/">ClickHouse documentation</a>.</p> <p>Any options not listed here are not supported.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>logLevel | **string**<br><p>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree | **object**<br><p>Settings for the MergeTree engine. See description in <a href="https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree">ClickHouse documentation</a>.</p> <p>Options specific to the MergeTree table engine.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>replicatedDeduplicationWindow | **integer** (int64)<br><p>Number of blocks of hashes to keep in ZooKeeper.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>replicatedDeduplicationWindowSeconds | **integer** (int64)<br><p>Period of time to keep blocks of hashes for.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>partsToDelayInsert | **integer** (int64)<br><p>If table contains at least that many active parts in single partition, artificially slow down insert into table.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>partsToThrowInsert | **integer** (int64)<br><p>If more than this number active parts in single partition, throw 'Too many parts ...' exception.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>inactivePartsToDelayInsert | **integer** (int64)
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>inactivePartsToThrowInsert | **integer** (int64)
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>maxReplicatedMergesInQueue | **integer** (int64)<br><p>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>numberOfFreeEntriesInPoolToLowerMaxSizeOfMerge | **integer** (int64)<br><p>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>maxBytesToMergeAtMinSpaceInPool | **integer** (int64)<br><p>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue).</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>maxBytesToMergeAtMaxSpaceInPool | **integer** (int64)
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>minBytesForWidePart | **integer** (int64)<br><p>Minimum number of bytes in a data part that can be stored in <strong>Wide</strong> format.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>minRowsForWidePart | **integer** (int64)<br><p>Minimum number of rows in a data part that can be stored in <strong>Wide</strong> format.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>ttlOnlyDropParts | **boolean** (boolean)<br><p>Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>allowRemoteFsZeroCopyReplication | **boolean** (boolean)
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>mergeWithTtlTimeout | **integer** (int64)
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>mergeWithRecompressionTtlTimeout | **integer** (int64)
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>maxPartsInTotal | **integer** (int64)
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>maxNumberOfMergesWithTtlInPool | **integer** (int64)
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>cleanupDelayPeriod | **integer** (int64)
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>numberOfFreeEntriesInPoolToExecuteMutation | **integer** (int64)
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>maxAvgPartSizeForTooManyParts | **integer** (int64)<br><p>The 'too many parts' check according to 'parts_to_delay_insert' and 'parts_to_throw_insert' will be active only if the average part size (in the relevant partition) is not larger than the specified threshold. If it is larger than the specified threshold, the INSERTs will be neither delayed or rejected. This allows to have hundreds of terabytes in a single table on a single server if the parts are successfully merged to larger parts. This does not affect the thresholds on inactive parts or total parts. Default: 1 GiB Min version: 22.10 See in-depth description in <a href="https://github.com/ClickHouse/ClickHouse/blob/f9558345e886876b9132d9c018e357f7fa9b22a3/src/Storages/MergeTree/MergeTreeSettings.h#L80">ClickHouse GitHub</a></p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>minAgeToForceMergeSeconds | **integer** (int64)<br><p>Merge parts if every part in the range is older than the value of min_age_to_force_merge_seconds. Default: 0 - disabled Min_version: 22.10 See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#min_age_to_force_merge_seconds">ClickHouse documentation</a></p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>minAgeToForceMergeOnPartitionOnly | **boolean** (boolean)<br><p>Whether min_age_to_force_merge_seconds should be applied only on the entire partition and not on subset. Default: false Min_version: 22.11 See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#min_age_to_force_merge_seconds">ClickHouse documentation</a></p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>mergeSelectingSleepMs | **integer** (int64)<br><p>Sleep time for merge selecting when no part is selected. A lower setting triggers selecting tasks in background_schedule_pool frequently, which results in a large number of requests to ClickHouse Keeper in large-scale clusters. Default: 5000 Min_version: 21.10 See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings#merge_selecting_sleep_ms">ClickHouse documentation</a></p> <p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>mergeMaxBlockSize | **integer** (int64)<br><p>The number of rows that are read from the merged parts into memory. Default: 8192 See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings#merge_max_block_size">ClickHouse documentation</a></p> <p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>checkSampleColumnIsCorrect | **boolean** (boolean)<br><p>Enables the check at table creation, that the data type of a column for sampling or sampling expression is correct. The data type must be one of unsigned <a href="https://clickhouse.com/docs/en/sql-reference/data-types/int-uint">integer types</a>: UInt8, UInt16, UInt32, UInt64. Default: true See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#check_sample_column_is_correct">ClickHouse documentation</a></p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>maxMergeSelectingSleepMs | **integer** (int64)<br><p>Maximum sleep time for merge selecting, a lower setting will trigger selecting tasks in background_schedule_pool frequently which result in large amount of requests to zookeeper in large-scale clusters. Default: 60000 Min_version: 23.6 See in-depth description in <a href="https://github.com/ClickHouse/ClickHouse/blob/4add9db84859bff7410cf934a3904b0414e36e51/src/Storages/MergeTree/MergeTreeSettings.h#L71">ClickHouse GitHub</a></p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>maxCleanupDelayPeriod | **integer** (int64)<br><p>Maximum period to clean old queue logs, blocks hashes and parts. Default: 300 Min_version: 23.6 See in-depth description in <a href="https://github.com/ClickHouse/ClickHouse/blob/4add9db84859bff7410cf934a3904b0414e36e51/src/Storages/MergeTree/MergeTreeSettings.h#L142">ClickHouse GitHub</a></p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>compression[] | **object**<br><p>Compression settings for the ClickHouse cluster. See in-depth description in <a href="https://clickhouse.com/docs/en/operations/server_settings/settings/#compression">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>compression[].<br>method | **string**<br><p>Compression method to use for the specified combination of ``minPartSize`` and ``minPartSizeRatio``.</p> <ul> <li>LZ4: <a href="https://lz4.github.io/lz4/">LZ4 compression algorithm</a>.</li> <li>ZSTD: <a href="https://facebook.github.io/zstd/">Zstandard compression algorithm</a>.</li> </ul> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>compression[].<br>minPartSize | **string** (int64)<br><p>Minimum size of a part of a table.</p> <p>The minimum value is 1.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>compression[].<br>minPartSizeRatio | **number** (double)<br><p>Minimum ratio of a part relative to the size of all the data in the table.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>compression[].<br>level | **integer** (int64)<br><p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[] | **object**<br><p>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts/">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>name | **string**<br><p>Required. Name of the external dictionary.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure | **object**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/).
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>id | **object**<br><p>Single numeric key column for the dictionary.</p> <p>Numeric key.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>id.<br>name | **string**<br><p>Required. Name of the numeric key.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>key | **object**<br><p>Composite key for the dictionary, containing of one or more key columns. For details, see <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key">ClickHouse documentation</a>.</p> <p>Complex key.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[] | **object**<br><p>Required. Attributes of a complex key.</p> <p>Must contain at least one element.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>name | **string**<br><p>Required. Name of the column.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>type | **string**<br><p>Required. Type of the column.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: ``false``.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping "id -&gt; attribute". Default value: ``false``.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>rangeMin | **object**<br><p>Field holding the beginning of the range for dictionaries with ``RANGE_HASHED`` layout. For details, see <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>name | **string**<br><p>Required. Name of the column.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>type | **string**<br><p>Required. Type of the column.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: ``false``.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping "id -&gt; attribute". Default value: ``false``.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>rangeMax | **object**<br><p>Field holding the end of the range for dictionaries with ``RANGE_HASHED`` layout. For details, see <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>name | **string**<br><p>Required. Name of the column.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>type | **string**<br><p>Required. Type of the column.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: ``false``.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping "id -&gt; attribute". Default value: ``false``.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>attributes[] | **object**<br><p>Required. Description of the fields available for database queries. For details, see <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes">ClickHouse documentation</a>.</p> <p>Must contain at least one element.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>name | **string**<br><p>Required. Name of the column.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>type | **string**<br><p>Required. Type of the column.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: ``false``.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping "id -&gt; attribute". Default value: ``false``.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>layout | **object**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/).
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>layout.<br>type | **string**<br><p>Required. Layout type for an external dictionary.</p> <ul> <li>FLAT: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li> <li>HASHED: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li> <li>COMPLEX_KEY_HASHED: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li> <li>RANGE_HASHED: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li> <li>CACHE: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li> <li>COMPLEX_KEY_CACHE: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li> </ul> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>layout.<br>sizeInCells | **string** (int64)<br><p>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>layout.<br>maxArraySize | **string** (int64)<br><p>Maximum dictionary key size. Applicable only for FLAT layout type.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>fixedLifetime | **string** (int64) <br>`config.clickhouse.config.effectiveConfig.dictionaries[]` includes only one of the fields `fixedLifetime`, `lifetimeRange`<br><br><p>Fixed interval between dictionary updates.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>lifetimeRange | **object**<br>Range of intervals between dictionary updates for ClickHouse to choose from. <br>`config.clickhouse.config.effectiveConfig.dictionaries[]` includes only one of the fields `fixedLifetime`, `lifetimeRange`<br>
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>lifetimeRange.<br>min | **string** (int64)<br><p>Minimum dictionary lifetime.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>lifetimeRange.<br>max | **string** (int64)<br><p>Maximum dictionary lifetime.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>httpSource | **object**<br>HTTP source for the dictionary. <br>`config.clickhouse.config.effectiveConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>httpSource.<br>url | **string**<br><p>Required. URL of the source dictionary available over HTTP.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>httpSource.<br>format | **string**<br><p>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>httpSource.<br>headers[] | **object**<br><p>HTTP headers.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>httpSource.<br>headers[].<br>name | **string**<br><p>Required.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>httpSource.<br>headers[].<br>value | **string**<br><p>Required.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mysqlSource | **object**<br>MySQL source for the dictionary. <br>`config.clickhouse.config.effectiveConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mysqlSource.<br>db | **string**<br><p>Required. Name of the MySQL database to connect to.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mysqlSource.<br>table | **string**<br><p>Required. Name of the database table to use as a ClickHouse dictionary.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mysqlSource.<br>port | **string** (int64)<br><p>Default port to use when connecting to a replica of the dictionary source.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mysqlSource.<br>user | **string**<br><p>Name of the default user for replicas of the dictionary source.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mysqlSource.<br>password | **string**<br><p>Password of the default user for replicas of the dictionary source.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[] | **object**<br><p>Required. List of MySQL replicas of the database used as dictionary source.</p> <p>Must contain at least one element.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>host | **string**<br><p>Required. MySQL host of the replica.</p> <p>The maximum string length in characters is 253.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>priority | **string** (int64)<br><p>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number.</p> <p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>port | **string** (int64)<br><p>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>user | **string**<br><p>Name of the MySQL database user.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>password | **string**<br><p>Password of the MySQL database user.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mysqlSource.<br>where | **string**<br><p>Selection criteria for the data in the specified MySQL table.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mysqlSource.<br>invalidateQuery | **string**<br><p>Query for checking the dictionary status, to pull only updated data. For more details, see <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/">ClickHouse documentation on dictionaries</a>.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mysqlSource.<br>closeConnection | **boolean** (boolean)<br><p>Should the connection be closed after each request.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mysqlSource.<br>shareConnection | **boolean** (boolean)<br><p>Should a connection be shared for some requests.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>clickhouseSource | **object**<br>ClickHouse source for the dictionary. <br>`config.clickhouse.config.effectiveConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>clickhouseSource.<br>db | **string**<br><p>Required. Name of the ClickHouse database.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>clickhouseSource.<br>table | **string**<br><p>Required. Name of the table in the specified database to be used as the dictionary source.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>clickhouseSource.<br>host | **string**<br><p>ClickHouse host of the specified database.</p> <p>The maximum string length in characters is 253.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>clickhouseSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>clickhouseSource.<br>user | **string**<br><p>Required. Name of the ClickHouse database user.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>clickhouseSource.<br>password | **string**<br><p>Password of the ClickHouse database user.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>clickhouseSource.<br>where | **string**<br><p>Selection criteria for the data in the specified ClickHouse table.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>clickhouseSource.<br>secure | **boolean** (boolean)<br><p>Use ssl for connection.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mongodbSource | **object**<br>MongoDB source for the dictionary. <br>`config.clickhouse.config.effectiveConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mongodbSource.<br>db | **string**<br><p>Required. Name of the MongoDB database.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mongodbSource.<br>collection | **string**<br><p>Required. Name of the collection in the specified database to be used as the dictionary source.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mongodbSource.<br>host | **string**<br><p>MongoDB host of the specified database.</p> <p>The maximum string length in characters is 253.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mongodbSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mongodbSource.<br>user | **string**<br><p>Required. Name of the MongoDB database user.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mongodbSource.<br>password | **string**<br><p>Password of the MongoDB database user.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mongodbSource.<br>options | **string**
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>postgresqlSource | **object**<br>PostgreSQL source for the dictionary. <br>`config.clickhouse.config.effectiveConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>postgresqlSource.<br>db | **string**<br><p>Required. Name of the PostrgreSQL database.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>postgresqlSource.<br>table | **string**<br><p>Required. Name of the table in the specified database to be used as the dictionary source.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>postgresqlSource.<br>hosts[] | **string**<br><p>Required. Name of the PostrgreSQL host</p> <p>Must contain at least one element.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>postgresqlSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>postgresqlSource.<br>user | **string**<br><p>Required. Name of the PostrgreSQL database user.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>postgresqlSource.<br>password | **string**<br><p>Password of the PostrgreSQL database user.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>postgresqlSource.<br>invalidateQuery | **string**<br><p>Query for checking the dictionary status, to pull only updated data. For more details, see <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/">ClickHouse documentation on dictionaries</a>.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>postgresqlSource.<br>sslMode | **string**<br><p>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see <a href="https://www.postgresql.org/docs/current/libpq-ssl.html">PostgreSQL documentation</a>.</p> <ul> <li>DISABLE: Only try a non-SSL connection.</li> <li>ALLOW: First try a non-SSL connection; if that fails, try an SSL connection.</li> <li>PREFER: First try an SSL connection; if that fails, try a non-SSL connection.</li> <li>VERIFY_CA: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li> <li>VERIFY_FULL: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li> </ul> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>graphiteRollup[] | **object**<br><p>Settings for thinning Graphite data. See in-depth description in <a href="https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>graphiteRollup[].<br>name | **string**<br><p>Required. Name for the specified combination of settings for Graphite rollup.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>graphiteRollup[].<br>patterns[] | **object**<br><p>Required. Pattern to use for the rollup.</p> <p>Must contain at least one element.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>graphiteRollup[].<br>patterns[].<br>regexp | **string**<br><p>Pattern for metric names.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>graphiteRollup[].<br>patterns[].<br>function | **string**<br><p>Required. Name of the aggregating function to apply to data of the age specified in ``retention``.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>graphiteRollup[].<br>patterns[].<br>retention[] | **object**<br><p>Required. Age of data to use for thinning.</p> <p>Must contain at least one element.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>graphiteRollup[].<br>patterns[].<br>retention[].<br>age | **string** (int64)<br><p>Minimum age of the data in seconds.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>graphiteRollup[].<br>patterns[].<br>retention[].<br>precision | **string** (int64)<br><p>Precision of determining the age of the data, in seconds.</p> <p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>graphiteRollup[].<br>pathColumnName | **string**<br><p>The name of the column storing the metric name (Graphite sensor). Default: Path See in-depth description in <a href="https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/graphitemergetree#required-columns">ClickHouse documentation</a></p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>graphiteRollup[].<br>timeColumnName | **string**<br><p>The name of the column storing the time of measuring the metric. Default: Time See in-depth description in <a href="https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/graphitemergetree#required-columns">ClickHouse documentation</a></p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>graphiteRollup[].<br>valueColumnName | **string**<br><p>The name of the column storing the value of the metric at the time set in time_column_name. Default: Value See in-depth description in <a href="https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/graphitemergetree#required-columns">ClickHouse documentation</a></p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>graphiteRollup[].<br>versionColumnName | **string**<br><p>The name of the column storing the version of the metric. Default: Timestamp See in-depth description in <a href="https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/graphitemergetree#required-columns">ClickHouse documentation</a></p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafka | **object**
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafka.<br>securityProtocol | **string**
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafka.<br>saslMechanism | **string**
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafka.<br>saslUsername | **string**
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafka.<br>saslPassword | **string**
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafka.<br>enableSslCertificateVerification | **boolean** (boolean)
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafka.<br>maxPollIntervalMs | **integer** (int64)<br><p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafka.<br>sessionTimeoutMs | **integer** (int64)<br><p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafka.<br>debug | **string**
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafka.<br>autoOffsetReset | **string**
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafkaTopics[] | **object**
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafkaTopics[].<br>name | **string**<br><p>Required.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafkaTopics[].<br>settings | **object**<br><p>Required.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafkaTopics[].<br>settings.<br>securityProtocol | **string**
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafkaTopics[].<br>settings.<br>saslMechanism | **string**
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafkaTopics[].<br>settings.<br>saslUsername | **string**
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafkaTopics[].<br>settings.<br>saslPassword | **string**
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafkaTopics[].<br>settings.<br>enableSslCertificateVerification | **boolean** (boolean)
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafkaTopics[].<br>settings.<br>maxPollIntervalMs | **integer** (int64)<br><p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafkaTopics[].<br>settings.<br>sessionTimeoutMs | **integer** (int64)<br><p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafkaTopics[].<br>settings.<br>debug | **string**
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafkaTopics[].<br>settings.<br>autoOffsetReset | **string**
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>rabbitmq | **object**
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>rabbitmq.<br>username | **string**<br><p><a href="https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/">RabbitMQ</a> username</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>rabbitmq.<br>password | **string**<br><p><a href="https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/">RabbitMQ</a> password</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>rabbitmq.<br>vhost | **string**<br><p><a href="https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/">RabbitMQ</a> virtual host</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections.</p> <p>The minimum value is 10.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>maxConcurrentQueries | **integer** (int64)<br><p>Maximum number of simultaneously processed requests.</p> <p>The minimum value is 10.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>keepAliveTimeout | **integer** (int64)<br><p>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>uncompressedCacheSize | **integer** (int64)<br><p>Cache size (in bytes) for uncompressed data used by MergeTree tables.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>markCacheSize | **integer** (int64)<br><p>Approximate size (in bytes) of the cache of "marks" used by MergeTree tables.</p> <p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>maxTableSizeToDrop | **integer** (int64)<br><p>Maximum size of the table that can be deleted using a DROP query.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>maxPartitionSizeToDrop | **integer** (int64)<br><p>Maximum size of the partition that can be deleted using a DROP query.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>builtinDictionariesReloadInterval | **integer** (int64)<br><p>The setting is deprecated and has no effect.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>timezone | **string**<br><p>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>geobaseEnabled | **boolean** (boolean)<br><p>Enable or disable geobase.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>geobaseUri | **string**<br><p>Address of the archive with the user geobase in Object Storage.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>queryLogRetentionSize | **integer** (int64)<br><p>The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>queryLogRetentionTime | **integer** (int64)<br><p>The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>queryThreadLogEnabled | **boolean** (boolean)<br><p>Whether query_thread_log system table is enabled.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>queryThreadLogRetentionSize | **integer** (int64)<br><p>The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>queryThreadLogRetentionTime | **integer** (int64)<br><p>The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>partLogRetentionSize | **integer** (int64)<br><p>The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>partLogRetentionTime | **integer** (int64)<br><p>The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>metricLogEnabled | **boolean** (boolean)<br><p>Whether metric_log system table is enabled.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>metricLogRetentionSize | **integer** (int64)<br><p>The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>metricLogRetentionTime | **integer** (int64)<br><p>The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>traceLogEnabled | **boolean** (boolean)<br><p>Whether trace_log system table is enabled.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>traceLogRetentionSize | **integer** (int64)<br><p>The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>traceLogRetentionTime | **integer** (int64)<br><p>The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>textLogEnabled | **boolean** (boolean)<br><p>Whether text_log system table is enabled.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>textLogRetentionSize | **integer** (int64)<br><p>The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>textLogRetentionTime | **integer** (int64)<br><p>The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>textLogLevel | **string**<br><p>Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>opentelemetrySpanLogEnabled | **boolean** (boolean)<br><p>Enable or disable opentelemetry_span_log system table. Default value: false.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>opentelemetrySpanLogRetentionSize | **integer** (int64)<br><p>The maximum size that opentelemetry_span_log can grow to before old data will be removed. If set to 0 (default), automatic removal of opentelemetry_span_log data based on size is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>opentelemetrySpanLogRetentionTime | **integer** (int64)<br><p>The maximum time that opentelemetry_span_log records will be retained before removal. If set to 0, automatic removal of opentelemetry_span_log data based on time is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>queryViewsLogEnabled | **boolean** (boolean)<br><p>Enable or disable query_views_log system table. Default value: false.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>queryViewsLogRetentionSize | **integer** (int64)<br><p>The maximum size that query_views_log can grow to before old data will be removed. If set to 0 (default), automatic removal of query_views_log data based on size is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>queryViewsLogRetentionTime | **integer** (int64)<br><p>The maximum time that query_views_log records will be retained before removal. If set to 0, automatic removal of query_views_log data based on time is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>asynchronousMetricLogEnabled | **boolean** (boolean)<br><p>Enable or disable asynchronous_metric_log system table. Default value: false.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>asynchronousMetricLogRetentionSize | **integer** (int64)<br><p>The maximum size that asynchronous_metric_log can grow to before old data will be removed. If set to 0 (default), automatic removal of asynchronous_metric_log data based on size is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>asynchronousMetricLogRetentionTime | **integer** (int64)<br><p>The maximum time that asynchronous_metric_log records will be retained before removal. If set to 0, automatic removal of asynchronous_metric_log data based on time is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>sessionLogEnabled | **boolean** (boolean)<br><p>Enable or disable session_log system table. Default value: false.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>sessionLogRetentionSize | **integer** (int64)<br><p>The maximum size that session_log can grow to before old data will be removed. If set to 0 (default), automatic removal of session_log data based on size is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>sessionLogRetentionTime | **integer** (int64)<br><p>The maximum time that session_log records will be retained before removal. If set to 0, automatic removal of session_log data based on time is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>zookeeperLogEnabled | **boolean** (boolean)<br><p>Enable or disable zookeeper_log system table. Default value: false.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>zookeeperLogRetentionSize | **integer** (int64)<br><p>The maximum size that zookeeper_log can grow to before old data will be removed. If set to 0 (default), automatic removal of zookeeper_log data based on size is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>zookeeperLogRetentionTime | **integer** (int64)<br><p>The maximum time that zookeeper_log records will be retained before removal. If set to 0, automatic removal of zookeeper_log data based on time is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>asynchronousInsertLogEnabled | **boolean** (boolean)<br><p>Enable or disable asynchronous_insert_log system table. Default value: false. Minimal required ClickHouse version: 22.10.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>asynchronousInsertLogRetentionSize | **integer** (int64)<br><p>The maximum size that asynchronous_insert_log can grow to before old data will be removed. If set to 0 (default), automatic removal of asynchronous_insert_log data based on size is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>asynchronousInsertLogRetentionTime | **integer** (int64)<br><p>The maximum time that asynchronous_insert_log records will be retained before removal. If set to 0, automatic removal of asynchronous_insert_log data based on time is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>backgroundPoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>backgroundMergesMutationsConcurrencyRatio | **integer** (int64)<br><p>Sets a ratio between the number of threads and the number of background merges and mutations that can be executed concurrently. For example, if the ratio equals to 2 and background_pool_size is set to 16 then ClickHouse can execute 32 background merges concurrently. This is possible, because background operations could be suspended and postponed. This is needed to give small merges more execution priority. You can only increase this ratio at runtime. To lower it you have to restart the server. The same as for background_pool_size setting background_merges_mutations_concurrency_ratio could be applied from the default profile for backward compatibility. Default: 2 See in-depth description in <a href="https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#background_merges_mutations_concurrency_ratio">ClickHouse documentation</a></p> <p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>backgroundSchedulePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>backgroundFetchesPoolSize | **integer** (int64)<br><p>Sets the number of threads performing background fetches for tables with <strong>ReplicatedMergeTree</strong> engines. Default value: 8.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>backgroundMovePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>backgroundDistributedSchedulePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>backgroundBufferFlushSchedulePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>backgroundMessageBrokerSchedulePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>backgroundCommonPoolSize | **integer** (int64)<br><p>The maximum number of threads that will be used for performing a variety of operations (mostly garbage collection) for *MergeTree-engine tables in a background. Default: 8 See in-depth description in <a href="https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#background_common_pool_size">ClickHouse documentation</a></p> <p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>defaultDatabase | **string**<br><p>The default database.</p> <p>To get a list of cluster databases, see <a href="/docs/managed-clickhouse/operations/databases#list-db">Yandex Managed ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>totalMemoryProfilerStep | **integer** (int64)<br><p>Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: <strong>4194304</strong>.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>totalMemoryTrackerSampleProbability | **number** (double)
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>queryMaskingRules[] | **object**<br><p>Required. Regexp-based rules, which will be applied to queries as well as all log messages before storing them in server logs, system.query_log, system.text_log, system.processes tables, and in logs sent to the client. That allows preventing sensitive data leakage from SQL queries (like names, emails, personal identifiers or credit card numbers) to logs. Change of these settings is applied with ClickHouse restart See in-depth description in <a href="https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#query-masking-rules">ClickHouse documentation</a></p> <p>Must contain at least one element.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>queryMaskingRules[].<br>name | **string**<br><p>Name for the rule.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>queryMaskingRules[].<br>regexp | **string**<br><p>Required. RE2 compatible regular expression. Required.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>queryMaskingRules[].<br>replace | **string**<br><p>Substitution string for sensitive data. Default: six asterisks</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionariesLazyLoad | **boolean** (boolean)<br><p>Lazy loading of dictionaries. Default: true See in-depth description in <a href="https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#dictionaries_lazy_load">ClickHouse documentation</a></p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>queryCache | **object**<br><p><a href="https://clickhouse.com/docs/en/operations/query-cache">Query cache</a> configuration. Min version: 23.5 See in-depth description in <a href="https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#query_cache">ClickHouse documentation</a></p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>queryCache.<br>maxSizeInBytes | **integer** (int64)<br><p>The maximum cache size in bytes. Default: 1073741824 (1 GiB)</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>queryCache.<br>maxEntries | **integer** (int64)<br><p>The maximum number of SELECT query results stored in the cache. Default: 1024</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>queryCache.<br>maxEntrySizeInBytes | **integer** (int64)<br><p>The maximum size in bytes SELECT query results may have to be saved in the cache. Dafault: 1048576 (1 MiB)</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>queryCache.<br>maxEntrySizeInRows | **integer** (int64)<br><p>The maximum number of rows SELECT query results may have to be saved in the cache. Default: 30000000 (30 mil)</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig | **object**<br><p>User-defined settings for a ClickHouse cluster.</p> <p>ClickHouse configuration options. Detailed description for each set of options is available in <a href="https://clickhouse.com/docs/en/operations/server_settings/settings/">ClickHouse documentation</a>.</p> <p>Any options not listed here are not supported.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>logLevel | **string**<br><p>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree | **object**<br><p>Settings for the MergeTree engine. See description in <a href="https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree">ClickHouse documentation</a>.</p> <p>Options specific to the MergeTree table engine.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>replicatedDeduplicationWindow | **integer** (int64)<br><p>Number of blocks of hashes to keep in ZooKeeper.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>replicatedDeduplicationWindowSeconds | **integer** (int64)<br><p>Period of time to keep blocks of hashes for.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>partsToDelayInsert | **integer** (int64)<br><p>If table contains at least that many active parts in single partition, artificially slow down insert into table.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>partsToThrowInsert | **integer** (int64)<br><p>If more than this number active parts in single partition, throw 'Too many parts ...' exception.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>inactivePartsToDelayInsert | **integer** (int64)
config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>inactivePartsToThrowInsert | **integer** (int64)
config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>maxReplicatedMergesInQueue | **integer** (int64)<br><p>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>numberOfFreeEntriesInPoolToLowerMaxSizeOfMerge | **integer** (int64)<br><p>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>maxBytesToMergeAtMinSpaceInPool | **integer** (int64)<br><p>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue).</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>maxBytesToMergeAtMaxSpaceInPool | **integer** (int64)
config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>minBytesForWidePart | **integer** (int64)<br><p>Minimum number of bytes in a data part that can be stored in <strong>Wide</strong> format.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>minRowsForWidePart | **integer** (int64)<br><p>Minimum number of rows in a data part that can be stored in <strong>Wide</strong> format.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>ttlOnlyDropParts | **boolean** (boolean)<br><p>Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>allowRemoteFsZeroCopyReplication | **boolean** (boolean)
config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>mergeWithTtlTimeout | **integer** (int64)
config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>mergeWithRecompressionTtlTimeout | **integer** (int64)
config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>maxPartsInTotal | **integer** (int64)
config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>maxNumberOfMergesWithTtlInPool | **integer** (int64)
config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>cleanupDelayPeriod | **integer** (int64)
config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>numberOfFreeEntriesInPoolToExecuteMutation | **integer** (int64)
config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>maxAvgPartSizeForTooManyParts | **integer** (int64)<br><p>The 'too many parts' check according to 'parts_to_delay_insert' and 'parts_to_throw_insert' will be active only if the average part size (in the relevant partition) is not larger than the specified threshold. If it is larger than the specified threshold, the INSERTs will be neither delayed or rejected. This allows to have hundreds of terabytes in a single table on a single server if the parts are successfully merged to larger parts. This does not affect the thresholds on inactive parts or total parts. Default: 1 GiB Min version: 22.10 See in-depth description in <a href="https://github.com/ClickHouse/ClickHouse/blob/f9558345e886876b9132d9c018e357f7fa9b22a3/src/Storages/MergeTree/MergeTreeSettings.h#L80">ClickHouse GitHub</a></p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>minAgeToForceMergeSeconds | **integer** (int64)<br><p>Merge parts if every part in the range is older than the value of min_age_to_force_merge_seconds. Default: 0 - disabled Min_version: 22.10 See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#min_age_to_force_merge_seconds">ClickHouse documentation</a></p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>minAgeToForceMergeOnPartitionOnly | **boolean** (boolean)<br><p>Whether min_age_to_force_merge_seconds should be applied only on the entire partition and not on subset. Default: false Min_version: 22.11 See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#min_age_to_force_merge_seconds">ClickHouse documentation</a></p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>mergeSelectingSleepMs | **integer** (int64)<br><p>Sleep time for merge selecting when no part is selected. A lower setting triggers selecting tasks in background_schedule_pool frequently, which results in a large number of requests to ClickHouse Keeper in large-scale clusters. Default: 5000 Min_version: 21.10 See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings#merge_selecting_sleep_ms">ClickHouse documentation</a></p> <p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>mergeMaxBlockSize | **integer** (int64)<br><p>The number of rows that are read from the merged parts into memory. Default: 8192 See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings#merge_max_block_size">ClickHouse documentation</a></p> <p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>checkSampleColumnIsCorrect | **boolean** (boolean)<br><p>Enables the check at table creation, that the data type of a column for sampling or sampling expression is correct. The data type must be one of unsigned <a href="https://clickhouse.com/docs/en/sql-reference/data-types/int-uint">integer types</a>: UInt8, UInt16, UInt32, UInt64. Default: true See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#check_sample_column_is_correct">ClickHouse documentation</a></p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>maxMergeSelectingSleepMs | **integer** (int64)<br><p>Maximum sleep time for merge selecting, a lower setting will trigger selecting tasks in background_schedule_pool frequently which result in large amount of requests to zookeeper in large-scale clusters. Default: 60000 Min_version: 23.6 See in-depth description in <a href="https://github.com/ClickHouse/ClickHouse/blob/4add9db84859bff7410cf934a3904b0414e36e51/src/Storages/MergeTree/MergeTreeSettings.h#L71">ClickHouse GitHub</a></p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>maxCleanupDelayPeriod | **integer** (int64)<br><p>Maximum period to clean old queue logs, blocks hashes and parts. Default: 300 Min_version: 23.6 See in-depth description in <a href="https://github.com/ClickHouse/ClickHouse/blob/4add9db84859bff7410cf934a3904b0414e36e51/src/Storages/MergeTree/MergeTreeSettings.h#L142">ClickHouse GitHub</a></p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>compression[] | **object**<br><p>Compression settings for the ClickHouse cluster. See in-depth description in <a href="https://clickhouse.com/docs/en/operations/server_settings/settings/#compression">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>compression[].<br>method | **string**<br><p>Compression method to use for the specified combination of ``minPartSize`` and ``minPartSizeRatio``.</p> <ul> <li>LZ4: <a href="https://lz4.github.io/lz4/">LZ4 compression algorithm</a>.</li> <li>ZSTD: <a href="https://facebook.github.io/zstd/">Zstandard compression algorithm</a>.</li> </ul> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>compression[].<br>minPartSize | **string** (int64)<br><p>Minimum size of a part of a table.</p> <p>The minimum value is 1.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>compression[].<br>minPartSizeRatio | **number** (double)<br><p>Minimum ratio of a part relative to the size of all the data in the table.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>compression[].<br>level | **integer** (int64)<br><p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[] | **object**<br><p>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts/">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>name | **string**<br><p>Required. Name of the external dictionary.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure | **object**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/).
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>id | **object**<br><p>Single numeric key column for the dictionary.</p> <p>Numeric key.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>id.<br>name | **string**<br><p>Required. Name of the numeric key.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>key | **object**<br><p>Composite key for the dictionary, containing of one or more key columns. For details, see <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key">ClickHouse documentation</a>.</p> <p>Complex key.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[] | **object**<br><p>Required. Attributes of a complex key.</p> <p>Must contain at least one element.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>name | **string**<br><p>Required. Name of the column.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>type | **string**<br><p>Required. Type of the column.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: ``false``.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping "id -&gt; attribute". Default value: ``false``.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>rangeMin | **object**<br><p>Field holding the beginning of the range for dictionaries with ``RANGE_HASHED`` layout. For details, see <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>name | **string**<br><p>Required. Name of the column.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>type | **string**<br><p>Required. Type of the column.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: ``false``.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping "id -&gt; attribute". Default value: ``false``.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>rangeMax | **object**<br><p>Field holding the end of the range for dictionaries with ``RANGE_HASHED`` layout. For details, see <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>name | **string**<br><p>Required. Name of the column.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>type | **string**<br><p>Required. Type of the column.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: ``false``.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping "id -&gt; attribute". Default value: ``false``.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>attributes[] | **object**<br><p>Required. Description of the fields available for database queries. For details, see <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes">ClickHouse documentation</a>.</p> <p>Must contain at least one element.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>name | **string**<br><p>Required. Name of the column.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>type | **string**<br><p>Required. Type of the column.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: ``false``.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping "id -&gt; attribute". Default value: ``false``.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>layout | **object**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/).
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>layout.<br>type | **string**<br><p>Required. Layout type for an external dictionary.</p> <ul> <li>FLAT: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li> <li>HASHED: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li> <li>COMPLEX_KEY_HASHED: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li> <li>RANGE_HASHED: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li> <li>CACHE: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li> <li>COMPLEX_KEY_CACHE: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li> </ul> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>layout.<br>sizeInCells | **string** (int64)<br><p>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>layout.<br>maxArraySize | **string** (int64)<br><p>Maximum dictionary key size. Applicable only for FLAT layout type.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>fixedLifetime | **string** (int64) <br>`config.clickhouse.config.userConfig.dictionaries[]` includes only one of the fields `fixedLifetime`, `lifetimeRange`<br><br><p>Fixed interval between dictionary updates.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>lifetimeRange | **object**<br>Range of intervals between dictionary updates for ClickHouse to choose from. <br>`config.clickhouse.config.userConfig.dictionaries[]` includes only one of the fields `fixedLifetime`, `lifetimeRange`<br>
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>lifetimeRange.<br>min | **string** (int64)<br><p>Minimum dictionary lifetime.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>lifetimeRange.<br>max | **string** (int64)<br><p>Maximum dictionary lifetime.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>httpSource | **object**<br>HTTP source for the dictionary. <br>`config.clickhouse.config.userConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>httpSource.<br>url | **string**<br><p>Required. URL of the source dictionary available over HTTP.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>httpSource.<br>format | **string**<br><p>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>httpSource.<br>headers[] | **object**<br><p>HTTP headers.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>httpSource.<br>headers[].<br>name | **string**<br><p>Required.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>httpSource.<br>headers[].<br>value | **string**<br><p>Required.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mysqlSource | **object**<br>MySQL source for the dictionary. <br>`config.clickhouse.config.userConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mysqlSource.<br>db | **string**<br><p>Required. Name of the MySQL database to connect to.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mysqlSource.<br>table | **string**<br><p>Required. Name of the database table to use as a ClickHouse dictionary.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mysqlSource.<br>port | **string** (int64)<br><p>Default port to use when connecting to a replica of the dictionary source.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mysqlSource.<br>user | **string**<br><p>Name of the default user for replicas of the dictionary source.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mysqlSource.<br>password | **string**<br><p>Password of the default user for replicas of the dictionary source.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[] | **object**<br><p>Required. List of MySQL replicas of the database used as dictionary source.</p> <p>Must contain at least one element.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>host | **string**<br><p>Required. MySQL host of the replica.</p> <p>The maximum string length in characters is 253.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>priority | **string** (int64)<br><p>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number.</p> <p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>port | **string** (int64)<br><p>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>user | **string**<br><p>Name of the MySQL database user.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>password | **string**<br><p>Password of the MySQL database user.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mysqlSource.<br>where | **string**<br><p>Selection criteria for the data in the specified MySQL table.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mysqlSource.<br>invalidateQuery | **string**<br><p>Query for checking the dictionary status, to pull only updated data. For more details, see <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/">ClickHouse documentation on dictionaries</a>.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mysqlSource.<br>closeConnection | **boolean** (boolean)<br><p>Should the connection be closed after each request.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mysqlSource.<br>shareConnection | **boolean** (boolean)<br><p>Should a connection be shared for some requests.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>clickhouseSource | **object**<br>ClickHouse source for the dictionary. <br>`config.clickhouse.config.userConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>clickhouseSource.<br>db | **string**<br><p>Required. Name of the ClickHouse database.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>clickhouseSource.<br>table | **string**<br><p>Required. Name of the table in the specified database to be used as the dictionary source.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>clickhouseSource.<br>host | **string**<br><p>ClickHouse host of the specified database.</p> <p>The maximum string length in characters is 253.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>clickhouseSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>clickhouseSource.<br>user | **string**<br><p>Required. Name of the ClickHouse database user.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>clickhouseSource.<br>password | **string**<br><p>Password of the ClickHouse database user.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>clickhouseSource.<br>where | **string**<br><p>Selection criteria for the data in the specified ClickHouse table.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>clickhouseSource.<br>secure | **boolean** (boolean)<br><p>Use ssl for connection.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mongodbSource | **object**<br>MongoDB source for the dictionary. <br>`config.clickhouse.config.userConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mongodbSource.<br>db | **string**<br><p>Required. Name of the MongoDB database.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mongodbSource.<br>collection | **string**<br><p>Required. Name of the collection in the specified database to be used as the dictionary source.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mongodbSource.<br>host | **string**<br><p>MongoDB host of the specified database.</p> <p>The maximum string length in characters is 253.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mongodbSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mongodbSource.<br>user | **string**<br><p>Required. Name of the MongoDB database user.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mongodbSource.<br>password | **string**<br><p>Password of the MongoDB database user.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mongodbSource.<br>options | **string**
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>postgresqlSource | **object**<br>PostgreSQL source for the dictionary. <br>`config.clickhouse.config.userConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>postgresqlSource.<br>db | **string**<br><p>Required. Name of the PostrgreSQL database.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>postgresqlSource.<br>table | **string**<br><p>Required. Name of the table in the specified database to be used as the dictionary source.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>postgresqlSource.<br>hosts[] | **string**<br><p>Required. Name of the PostrgreSQL host</p> <p>Must contain at least one element.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>postgresqlSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>postgresqlSource.<br>user | **string**<br><p>Required. Name of the PostrgreSQL database user.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>postgresqlSource.<br>password | **string**<br><p>Password of the PostrgreSQL database user.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>postgresqlSource.<br>invalidateQuery | **string**<br><p>Query for checking the dictionary status, to pull only updated data. For more details, see <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/">ClickHouse documentation on dictionaries</a>.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>postgresqlSource.<br>sslMode | **string**<br><p>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see <a href="https://www.postgresql.org/docs/current/libpq-ssl.html">PostgreSQL documentation</a>.</p> <ul> <li>DISABLE: Only try a non-SSL connection.</li> <li>ALLOW: First try a non-SSL connection; if that fails, try an SSL connection.</li> <li>PREFER: First try an SSL connection; if that fails, try a non-SSL connection.</li> <li>VERIFY_CA: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li> <li>VERIFY_FULL: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li> </ul> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>graphiteRollup[] | **object**<br><p>Settings for thinning Graphite data. See in-depth description in <a href="https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>graphiteRollup[].<br>name | **string**<br><p>Required. Name for the specified combination of settings for Graphite rollup.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>graphiteRollup[].<br>patterns[] | **object**<br><p>Required. Pattern to use for the rollup.</p> <p>Must contain at least one element.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>graphiteRollup[].<br>patterns[].<br>regexp | **string**<br><p>Pattern for metric names.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>graphiteRollup[].<br>patterns[].<br>function | **string**<br><p>Required. Name of the aggregating function to apply to data of the age specified in ``retention``.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>graphiteRollup[].<br>patterns[].<br>retention[] | **object**<br><p>Required. Age of data to use for thinning.</p> <p>Must contain at least one element.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>graphiteRollup[].<br>patterns[].<br>retention[].<br>age | **string** (int64)<br><p>Minimum age of the data in seconds.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>graphiteRollup[].<br>patterns[].<br>retention[].<br>precision | **string** (int64)<br><p>Precision of determining the age of the data, in seconds.</p> <p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>graphiteRollup[].<br>pathColumnName | **string**<br><p>The name of the column storing the metric name (Graphite sensor). Default: Path See in-depth description in <a href="https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/graphitemergetree#required-columns">ClickHouse documentation</a></p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>graphiteRollup[].<br>timeColumnName | **string**<br><p>The name of the column storing the time of measuring the metric. Default: Time See in-depth description in <a href="https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/graphitemergetree#required-columns">ClickHouse documentation</a></p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>graphiteRollup[].<br>valueColumnName | **string**<br><p>The name of the column storing the value of the metric at the time set in time_column_name. Default: Value See in-depth description in <a href="https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/graphitemergetree#required-columns">ClickHouse documentation</a></p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>graphiteRollup[].<br>versionColumnName | **string**<br><p>The name of the column storing the version of the metric. Default: Timestamp See in-depth description in <a href="https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/graphitemergetree#required-columns">ClickHouse documentation</a></p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafka | **object**
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafka.<br>securityProtocol | **string**
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafka.<br>saslMechanism | **string**
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafka.<br>saslUsername | **string**
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafka.<br>saslPassword | **string**
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafka.<br>enableSslCertificateVerification | **boolean** (boolean)
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafka.<br>maxPollIntervalMs | **integer** (int64)<br><p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafka.<br>sessionTimeoutMs | **integer** (int64)<br><p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafka.<br>debug | **string**
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafka.<br>autoOffsetReset | **string**
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafkaTopics[] | **object**
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafkaTopics[].<br>name | **string**<br><p>Required.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafkaTopics[].<br>settings | **object**<br><p>Required.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafkaTopics[].<br>settings.<br>securityProtocol | **string**
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafkaTopics[].<br>settings.<br>saslMechanism | **string**
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafkaTopics[].<br>settings.<br>saslUsername | **string**
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafkaTopics[].<br>settings.<br>saslPassword | **string**
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafkaTopics[].<br>settings.<br>enableSslCertificateVerification | **boolean** (boolean)
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafkaTopics[].<br>settings.<br>maxPollIntervalMs | **integer** (int64)<br><p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafkaTopics[].<br>settings.<br>sessionTimeoutMs | **integer** (int64)<br><p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafkaTopics[].<br>settings.<br>debug | **string**
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafkaTopics[].<br>settings.<br>autoOffsetReset | **string**
config.<br>clickhouse.<br>config.<br>userConfig.<br>rabbitmq | **object**
config.<br>clickhouse.<br>config.<br>userConfig.<br>rabbitmq.<br>username | **string**<br><p><a href="https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/">RabbitMQ</a> username</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>rabbitmq.<br>password | **string**<br><p><a href="https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/">RabbitMQ</a> password</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>rabbitmq.<br>vhost | **string**<br><p><a href="https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/">RabbitMQ</a> virtual host</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections.</p> <p>The minimum value is 10.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>maxConcurrentQueries | **integer** (int64)<br><p>Maximum number of simultaneously processed requests.</p> <p>The minimum value is 10.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>keepAliveTimeout | **integer** (int64)<br><p>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>uncompressedCacheSize | **integer** (int64)<br><p>Cache size (in bytes) for uncompressed data used by MergeTree tables.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>markCacheSize | **integer** (int64)<br><p>Approximate size (in bytes) of the cache of "marks" used by MergeTree tables.</p> <p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>maxTableSizeToDrop | **integer** (int64)<br><p>Maximum size of the table that can be deleted using a DROP query.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>maxPartitionSizeToDrop | **integer** (int64)<br><p>Maximum size of the partition that can be deleted using a DROP query.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>builtinDictionariesReloadInterval | **integer** (int64)<br><p>The setting is deprecated and has no effect.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>timezone | **string**<br><p>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>geobaseEnabled | **boolean** (boolean)<br><p>Enable or disable geobase.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>geobaseUri | **string**<br><p>Address of the archive with the user geobase in Object Storage.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>queryLogRetentionSize | **integer** (int64)<br><p>The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>queryLogRetentionTime | **integer** (int64)<br><p>The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>queryThreadLogEnabled | **boolean** (boolean)<br><p>Whether query_thread_log system table is enabled.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>queryThreadLogRetentionSize | **integer** (int64)<br><p>The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>queryThreadLogRetentionTime | **integer** (int64)<br><p>The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>partLogRetentionSize | **integer** (int64)<br><p>The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>partLogRetentionTime | **integer** (int64)<br><p>The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>metricLogEnabled | **boolean** (boolean)<br><p>Whether metric_log system table is enabled.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>metricLogRetentionSize | **integer** (int64)<br><p>The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>metricLogRetentionTime | **integer** (int64)<br><p>The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>traceLogEnabled | **boolean** (boolean)<br><p>Whether trace_log system table is enabled.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>traceLogRetentionSize | **integer** (int64)<br><p>The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>traceLogRetentionTime | **integer** (int64)<br><p>The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>textLogEnabled | **boolean** (boolean)<br><p>Whether text_log system table is enabled.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>textLogRetentionSize | **integer** (int64)<br><p>The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>textLogRetentionTime | **integer** (int64)<br><p>The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>textLogLevel | **string**<br><p>Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>opentelemetrySpanLogEnabled | **boolean** (boolean)<br><p>Enable or disable opentelemetry_span_log system table. Default value: false.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>opentelemetrySpanLogRetentionSize | **integer** (int64)<br><p>The maximum size that opentelemetry_span_log can grow to before old data will be removed. If set to 0 (default), automatic removal of opentelemetry_span_log data based on size is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>opentelemetrySpanLogRetentionTime | **integer** (int64)<br><p>The maximum time that opentelemetry_span_log records will be retained before removal. If set to 0, automatic removal of opentelemetry_span_log data based on time is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>queryViewsLogEnabled | **boolean** (boolean)<br><p>Enable or disable query_views_log system table. Default value: false.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>queryViewsLogRetentionSize | **integer** (int64)<br><p>The maximum size that query_views_log can grow to before old data will be removed. If set to 0 (default), automatic removal of query_views_log data based on size is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>queryViewsLogRetentionTime | **integer** (int64)<br><p>The maximum time that query_views_log records will be retained before removal. If set to 0, automatic removal of query_views_log data based on time is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>asynchronousMetricLogEnabled | **boolean** (boolean)<br><p>Enable or disable asynchronous_metric_log system table. Default value: false.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>asynchronousMetricLogRetentionSize | **integer** (int64)<br><p>The maximum size that asynchronous_metric_log can grow to before old data will be removed. If set to 0 (default), automatic removal of asynchronous_metric_log data based on size is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>asynchronousMetricLogRetentionTime | **integer** (int64)<br><p>The maximum time that asynchronous_metric_log records will be retained before removal. If set to 0, automatic removal of asynchronous_metric_log data based on time is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>sessionLogEnabled | **boolean** (boolean)<br><p>Enable or disable session_log system table. Default value: false.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>sessionLogRetentionSize | **integer** (int64)<br><p>The maximum size that session_log can grow to before old data will be removed. If set to 0 (default), automatic removal of session_log data based on size is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>sessionLogRetentionTime | **integer** (int64)<br><p>The maximum time that session_log records will be retained before removal. If set to 0, automatic removal of session_log data based on time is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>zookeeperLogEnabled | **boolean** (boolean)<br><p>Enable or disable zookeeper_log system table. Default value: false.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>zookeeperLogRetentionSize | **integer** (int64)<br><p>The maximum size that zookeeper_log can grow to before old data will be removed. If set to 0 (default), automatic removal of zookeeper_log data based on size is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>zookeeperLogRetentionTime | **integer** (int64)<br><p>The maximum time that zookeeper_log records will be retained before removal. If set to 0, automatic removal of zookeeper_log data based on time is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>asynchronousInsertLogEnabled | **boolean** (boolean)<br><p>Enable or disable asynchronous_insert_log system table. Default value: false. Minimal required ClickHouse version: 22.10.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>asynchronousInsertLogRetentionSize | **integer** (int64)<br><p>The maximum size that asynchronous_insert_log can grow to before old data will be removed. If set to 0 (default), automatic removal of asynchronous_insert_log data based on size is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>asynchronousInsertLogRetentionTime | **integer** (int64)<br><p>The maximum time that asynchronous_insert_log records will be retained before removal. If set to 0, automatic removal of asynchronous_insert_log data based on time is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>backgroundPoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>backgroundMergesMutationsConcurrencyRatio | **integer** (int64)<br><p>Sets a ratio between the number of threads and the number of background merges and mutations that can be executed concurrently. For example, if the ratio equals to 2 and background_pool_size is set to 16 then ClickHouse can execute 32 background merges concurrently. This is possible, because background operations could be suspended and postponed. This is needed to give small merges more execution priority. You can only increase this ratio at runtime. To lower it you have to restart the server. The same as for background_pool_size setting background_merges_mutations_concurrency_ratio could be applied from the default profile for backward compatibility. Default: 2 See in-depth description in <a href="https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#background_merges_mutations_concurrency_ratio">ClickHouse documentation</a></p> <p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>backgroundSchedulePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>backgroundFetchesPoolSize | **integer** (int64)<br><p>Sets the number of threads performing background fetches for tables with <strong>ReplicatedMergeTree</strong> engines. Default value: 8.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>backgroundMovePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>backgroundDistributedSchedulePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>backgroundBufferFlushSchedulePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>backgroundMessageBrokerSchedulePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>backgroundCommonPoolSize | **integer** (int64)<br><p>The maximum number of threads that will be used for performing a variety of operations (mostly garbage collection) for *MergeTree-engine tables in a background. Default: 8 See in-depth description in <a href="https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#background_common_pool_size">ClickHouse documentation</a></p> <p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>defaultDatabase | **string**<br><p>The default database.</p> <p>To get a list of cluster databases, see <a href="/docs/managed-clickhouse/operations/databases#list-db">Yandex Managed ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>totalMemoryProfilerStep | **integer** (int64)<br><p>Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: <strong>4194304</strong>.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>totalMemoryTrackerSampleProbability | **number** (double)
config.<br>clickhouse.<br>config.<br>userConfig.<br>queryMaskingRules[] | **object**<br><p>Required. Regexp-based rules, which will be applied to queries as well as all log messages before storing them in server logs, system.query_log, system.text_log, system.processes tables, and in logs sent to the client. That allows preventing sensitive data leakage from SQL queries (like names, emails, personal identifiers or credit card numbers) to logs. Change of these settings is applied with ClickHouse restart See in-depth description in <a href="https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#query-masking-rules">ClickHouse documentation</a></p> <p>Must contain at least one element.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>queryMaskingRules[].<br>name | **string**<br><p>Name for the rule.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>queryMaskingRules[].<br>regexp | **string**<br><p>Required. RE2 compatible regular expression. Required.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>queryMaskingRules[].<br>replace | **string**<br><p>Substitution string for sensitive data. Default: six asterisks</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionariesLazyLoad | **boolean** (boolean)<br><p>Lazy loading of dictionaries. Default: true See in-depth description in <a href="https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#dictionaries_lazy_load">ClickHouse documentation</a></p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>queryCache | **object**<br><p><a href="https://clickhouse.com/docs/en/operations/query-cache">Query cache</a> configuration. Min version: 23.5 See in-depth description in <a href="https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#query_cache">ClickHouse documentation</a></p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>queryCache.<br>maxSizeInBytes | **integer** (int64)<br><p>The maximum cache size in bytes. Default: 1073741824 (1 GiB)</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>queryCache.<br>maxEntries | **integer** (int64)<br><p>The maximum number of SELECT query results stored in the cache. Default: 1024</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>queryCache.<br>maxEntrySizeInBytes | **integer** (int64)<br><p>The maximum size in bytes SELECT query results may have to be saved in the cache. Dafault: 1048576 (1 MiB)</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>queryCache.<br>maxEntrySizeInRows | **integer** (int64)<br><p>The maximum number of rows SELECT query results may have to be saved in the cache. Default: 30000000 (30 mil)</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig | **object**<br><p>Default configuration for a ClickHouse cluster.</p> <p>ClickHouse configuration options. Detailed description for each set of options is available in <a href="https://clickhouse.com/docs/en/operations/server_settings/settings/">ClickHouse documentation</a>.</p> <p>Any options not listed here are not supported.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>logLevel | **string**<br><p>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree | **object**<br><p>Settings for the MergeTree engine. See description in <a href="https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree">ClickHouse documentation</a>.</p> <p>Options specific to the MergeTree table engine.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>replicatedDeduplicationWindow | **integer** (int64)<br><p>Number of blocks of hashes to keep in ZooKeeper.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>replicatedDeduplicationWindowSeconds | **integer** (int64)<br><p>Period of time to keep blocks of hashes for.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>partsToDelayInsert | **integer** (int64)<br><p>If table contains at least that many active parts in single partition, artificially slow down insert into table.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>partsToThrowInsert | **integer** (int64)<br><p>If more than this number active parts in single partition, throw 'Too many parts ...' exception.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>inactivePartsToDelayInsert | **integer** (int64)
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>inactivePartsToThrowInsert | **integer** (int64)
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>maxReplicatedMergesInQueue | **integer** (int64)<br><p>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>numberOfFreeEntriesInPoolToLowerMaxSizeOfMerge | **integer** (int64)<br><p>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>maxBytesToMergeAtMinSpaceInPool | **integer** (int64)<br><p>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue).</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>maxBytesToMergeAtMaxSpaceInPool | **integer** (int64)
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>minBytesForWidePart | **integer** (int64)<br><p>Minimum number of bytes in a data part that can be stored in <strong>Wide</strong> format.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>minRowsForWidePart | **integer** (int64)<br><p>Minimum number of rows in a data part that can be stored in <strong>Wide</strong> format.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>ttlOnlyDropParts | **boolean** (boolean)<br><p>Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>allowRemoteFsZeroCopyReplication | **boolean** (boolean)
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>mergeWithTtlTimeout | **integer** (int64)
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>mergeWithRecompressionTtlTimeout | **integer** (int64)
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>maxPartsInTotal | **integer** (int64)
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>maxNumberOfMergesWithTtlInPool | **integer** (int64)
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>cleanupDelayPeriod | **integer** (int64)
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>numberOfFreeEntriesInPoolToExecuteMutation | **integer** (int64)
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>maxAvgPartSizeForTooManyParts | **integer** (int64)<br><p>The 'too many parts' check according to 'parts_to_delay_insert' and 'parts_to_throw_insert' will be active only if the average part size (in the relevant partition) is not larger than the specified threshold. If it is larger than the specified threshold, the INSERTs will be neither delayed or rejected. This allows to have hundreds of terabytes in a single table on a single server if the parts are successfully merged to larger parts. This does not affect the thresholds on inactive parts or total parts. Default: 1 GiB Min version: 22.10 See in-depth description in <a href="https://github.com/ClickHouse/ClickHouse/blob/f9558345e886876b9132d9c018e357f7fa9b22a3/src/Storages/MergeTree/MergeTreeSettings.h#L80">ClickHouse GitHub</a></p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>minAgeToForceMergeSeconds | **integer** (int64)<br><p>Merge parts if every part in the range is older than the value of min_age_to_force_merge_seconds. Default: 0 - disabled Min_version: 22.10 See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#min_age_to_force_merge_seconds">ClickHouse documentation</a></p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>minAgeToForceMergeOnPartitionOnly | **boolean** (boolean)<br><p>Whether min_age_to_force_merge_seconds should be applied only on the entire partition and not on subset. Default: false Min_version: 22.11 See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#min_age_to_force_merge_seconds">ClickHouse documentation</a></p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>mergeSelectingSleepMs | **integer** (int64)<br><p>Sleep time for merge selecting when no part is selected. A lower setting triggers selecting tasks in background_schedule_pool frequently, which results in a large number of requests to ClickHouse Keeper in large-scale clusters. Default: 5000 Min_version: 21.10 See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings#merge_selecting_sleep_ms">ClickHouse documentation</a></p> <p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>mergeMaxBlockSize | **integer** (int64)<br><p>The number of rows that are read from the merged parts into memory. Default: 8192 See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings#merge_max_block_size">ClickHouse documentation</a></p> <p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>checkSampleColumnIsCorrect | **boolean** (boolean)<br><p>Enables the check at table creation, that the data type of a column for sampling or sampling expression is correct. The data type must be one of unsigned <a href="https://clickhouse.com/docs/en/sql-reference/data-types/int-uint">integer types</a>: UInt8, UInt16, UInt32, UInt64. Default: true See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#check_sample_column_is_correct">ClickHouse documentation</a></p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>maxMergeSelectingSleepMs | **integer** (int64)<br><p>Maximum sleep time for merge selecting, a lower setting will trigger selecting tasks in background_schedule_pool frequently which result in large amount of requests to zookeeper in large-scale clusters. Default: 60000 Min_version: 23.6 See in-depth description in <a href="https://github.com/ClickHouse/ClickHouse/blob/4add9db84859bff7410cf934a3904b0414e36e51/src/Storages/MergeTree/MergeTreeSettings.h#L71">ClickHouse GitHub</a></p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>maxCleanupDelayPeriod | **integer** (int64)<br><p>Maximum period to clean old queue logs, blocks hashes and parts. Default: 300 Min_version: 23.6 See in-depth description in <a href="https://github.com/ClickHouse/ClickHouse/blob/4add9db84859bff7410cf934a3904b0414e36e51/src/Storages/MergeTree/MergeTreeSettings.h#L142">ClickHouse GitHub</a></p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>compression[] | **object**<br><p>Compression settings for the ClickHouse cluster. See in-depth description in <a href="https://clickhouse.com/docs/en/operations/server_settings/settings/#compression">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>compression[].<br>method | **string**<br><p>Compression method to use for the specified combination of ``minPartSize`` and ``minPartSizeRatio``.</p> <ul> <li>LZ4: <a href="https://lz4.github.io/lz4/">LZ4 compression algorithm</a>.</li> <li>ZSTD: <a href="https://facebook.github.io/zstd/">Zstandard compression algorithm</a>.</li> </ul> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>compression[].<br>minPartSize | **string** (int64)<br><p>Minimum size of a part of a table.</p> <p>The minimum value is 1.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>compression[].<br>minPartSizeRatio | **number** (double)<br><p>Minimum ratio of a part relative to the size of all the data in the table.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>compression[].<br>level | **integer** (int64)<br><p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[] | **object**<br><p>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts/">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>name | **string**<br><p>Required. Name of the external dictionary.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure | **object**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/).
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>id | **object**<br><p>Single numeric key column for the dictionary.</p> <p>Numeric key.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>id.<br>name | **string**<br><p>Required. Name of the numeric key.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>key | **object**<br><p>Composite key for the dictionary, containing of one or more key columns. For details, see <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key">ClickHouse documentation</a>.</p> <p>Complex key.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[] | **object**<br><p>Required. Attributes of a complex key.</p> <p>Must contain at least one element.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>name | **string**<br><p>Required. Name of the column.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>type | **string**<br><p>Required. Type of the column.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: ``false``.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping "id -&gt; attribute". Default value: ``false``.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>rangeMin | **object**<br><p>Field holding the beginning of the range for dictionaries with ``RANGE_HASHED`` layout. For details, see <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>name | **string**<br><p>Required. Name of the column.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>type | **string**<br><p>Required. Type of the column.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: ``false``.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping "id -&gt; attribute". Default value: ``false``.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>rangeMax | **object**<br><p>Field holding the end of the range for dictionaries with ``RANGE_HASHED`` layout. For details, see <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>name | **string**<br><p>Required. Name of the column.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>type | **string**<br><p>Required. Type of the column.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: ``false``.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping "id -&gt; attribute". Default value: ``false``.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>attributes[] | **object**<br><p>Required. Description of the fields available for database queries. For details, see <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes">ClickHouse documentation</a>.</p> <p>Must contain at least one element.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>name | **string**<br><p>Required. Name of the column.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>type | **string**<br><p>Required. Type of the column.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: ``false``.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping "id -&gt; attribute". Default value: ``false``.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>layout | **object**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/).
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>layout.<br>type | **string**<br><p>Required. Layout type for an external dictionary.</p> <ul> <li>FLAT: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li> <li>HASHED: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li> <li>COMPLEX_KEY_HASHED: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li> <li>RANGE_HASHED: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li> <li>CACHE: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li> <li>COMPLEX_KEY_CACHE: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li> </ul> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>layout.<br>sizeInCells | **string** (int64)<br><p>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>layout.<br>maxArraySize | **string** (int64)<br><p>Maximum dictionary key size. Applicable only for FLAT layout type.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>fixedLifetime | **string** (int64) <br>`config.clickhouse.config.defaultConfig.dictionaries[]` includes only one of the fields `fixedLifetime`, `lifetimeRange`<br><br><p>Fixed interval between dictionary updates.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>lifetimeRange | **object**<br>Range of intervals between dictionary updates for ClickHouse to choose from. <br>`config.clickhouse.config.defaultConfig.dictionaries[]` includes only one of the fields `fixedLifetime`, `lifetimeRange`<br>
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>lifetimeRange.<br>min | **string** (int64)<br><p>Minimum dictionary lifetime.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>lifetimeRange.<br>max | **string** (int64)<br><p>Maximum dictionary lifetime.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>httpSource | **object**<br>HTTP source for the dictionary. <br>`config.clickhouse.config.defaultConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>httpSource.<br>url | **string**<br><p>Required. URL of the source dictionary available over HTTP.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>httpSource.<br>format | **string**<br><p>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>httpSource.<br>headers[] | **object**<br><p>HTTP headers.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>httpSource.<br>headers[].<br>name | **string**<br><p>Required.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>httpSource.<br>headers[].<br>value | **string**<br><p>Required.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mysqlSource | **object**<br>MySQL source for the dictionary. <br>`config.clickhouse.config.defaultConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mysqlSource.<br>db | **string**<br><p>Required. Name of the MySQL database to connect to.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mysqlSource.<br>table | **string**<br><p>Required. Name of the database table to use as a ClickHouse dictionary.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mysqlSource.<br>port | **string** (int64)<br><p>Default port to use when connecting to a replica of the dictionary source.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mysqlSource.<br>user | **string**<br><p>Name of the default user for replicas of the dictionary source.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mysqlSource.<br>password | **string**<br><p>Password of the default user for replicas of the dictionary source.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[] | **object**<br><p>Required. List of MySQL replicas of the database used as dictionary source.</p> <p>Must contain at least one element.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>host | **string**<br><p>Required. MySQL host of the replica.</p> <p>The maximum string length in characters is 253.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>priority | **string** (int64)<br><p>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number.</p> <p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>port | **string** (int64)<br><p>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>user | **string**<br><p>Name of the MySQL database user.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>password | **string**<br><p>Password of the MySQL database user.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mysqlSource.<br>where | **string**<br><p>Selection criteria for the data in the specified MySQL table.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mysqlSource.<br>invalidateQuery | **string**<br><p>Query for checking the dictionary status, to pull only updated data. For more details, see <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/">ClickHouse documentation on dictionaries</a>.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mysqlSource.<br>closeConnection | **boolean** (boolean)<br><p>Should the connection be closed after each request.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mysqlSource.<br>shareConnection | **boolean** (boolean)<br><p>Should a connection be shared for some requests.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>clickhouseSource | **object**<br>ClickHouse source for the dictionary. <br>`config.clickhouse.config.defaultConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>clickhouseSource.<br>db | **string**<br><p>Required. Name of the ClickHouse database.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>clickhouseSource.<br>table | **string**<br><p>Required. Name of the table in the specified database to be used as the dictionary source.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>clickhouseSource.<br>host | **string**<br><p>ClickHouse host of the specified database.</p> <p>The maximum string length in characters is 253.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>clickhouseSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>clickhouseSource.<br>user | **string**<br><p>Required. Name of the ClickHouse database user.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>clickhouseSource.<br>password | **string**<br><p>Password of the ClickHouse database user.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>clickhouseSource.<br>where | **string**<br><p>Selection criteria for the data in the specified ClickHouse table.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>clickhouseSource.<br>secure | **boolean** (boolean)<br><p>Use ssl for connection.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mongodbSource | **object**<br>MongoDB source for the dictionary. <br>`config.clickhouse.config.defaultConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mongodbSource.<br>db | **string**<br><p>Required. Name of the MongoDB database.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mongodbSource.<br>collection | **string**<br><p>Required. Name of the collection in the specified database to be used as the dictionary source.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mongodbSource.<br>host | **string**<br><p>MongoDB host of the specified database.</p> <p>The maximum string length in characters is 253.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mongodbSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mongodbSource.<br>user | **string**<br><p>Required. Name of the MongoDB database user.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mongodbSource.<br>password | **string**<br><p>Password of the MongoDB database user.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mongodbSource.<br>options | **string**
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>postgresqlSource | **object**<br>PostgreSQL source for the dictionary. <br>`config.clickhouse.config.defaultConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>postgresqlSource.<br>db | **string**<br><p>Required. Name of the PostrgreSQL database.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>postgresqlSource.<br>table | **string**<br><p>Required. Name of the table in the specified database to be used as the dictionary source.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>postgresqlSource.<br>hosts[] | **string**<br><p>Required. Name of the PostrgreSQL host</p> <p>Must contain at least one element.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>postgresqlSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>postgresqlSource.<br>user | **string**<br><p>Required. Name of the PostrgreSQL database user.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>postgresqlSource.<br>password | **string**<br><p>Password of the PostrgreSQL database user.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>postgresqlSource.<br>invalidateQuery | **string**<br><p>Query for checking the dictionary status, to pull only updated data. For more details, see <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/">ClickHouse documentation on dictionaries</a>.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>postgresqlSource.<br>sslMode | **string**<br><p>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see <a href="https://www.postgresql.org/docs/current/libpq-ssl.html">PostgreSQL documentation</a>.</p> <ul> <li>DISABLE: Only try a non-SSL connection.</li> <li>ALLOW: First try a non-SSL connection; if that fails, try an SSL connection.</li> <li>PREFER: First try an SSL connection; if that fails, try a non-SSL connection.</li> <li>VERIFY_CA: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li> <li>VERIFY_FULL: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li> </ul> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>graphiteRollup[] | **object**<br><p>Settings for thinning Graphite data. See in-depth description in <a href="https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>graphiteRollup[].<br>name | **string**<br><p>Required. Name for the specified combination of settings for Graphite rollup.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>graphiteRollup[].<br>patterns[] | **object**<br><p>Required. Pattern to use for the rollup.</p> <p>Must contain at least one element.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>graphiteRollup[].<br>patterns[].<br>regexp | **string**<br><p>Pattern for metric names.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>graphiteRollup[].<br>patterns[].<br>function | **string**<br><p>Required. Name of the aggregating function to apply to data of the age specified in ``retention``.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>graphiteRollup[].<br>patterns[].<br>retention[] | **object**<br><p>Required. Age of data to use for thinning.</p> <p>Must contain at least one element.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>graphiteRollup[].<br>patterns[].<br>retention[].<br>age | **string** (int64)<br><p>Minimum age of the data in seconds.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>graphiteRollup[].<br>patterns[].<br>retention[].<br>precision | **string** (int64)<br><p>Precision of determining the age of the data, in seconds.</p> <p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>graphiteRollup[].<br>pathColumnName | **string**<br><p>The name of the column storing the metric name (Graphite sensor). Default: Path See in-depth description in <a href="https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/graphitemergetree#required-columns">ClickHouse documentation</a></p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>graphiteRollup[].<br>timeColumnName | **string**<br><p>The name of the column storing the time of measuring the metric. Default: Time See in-depth description in <a href="https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/graphitemergetree#required-columns">ClickHouse documentation</a></p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>graphiteRollup[].<br>valueColumnName | **string**<br><p>The name of the column storing the value of the metric at the time set in time_column_name. Default: Value See in-depth description in <a href="https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/graphitemergetree#required-columns">ClickHouse documentation</a></p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>graphiteRollup[].<br>versionColumnName | **string**<br><p>The name of the column storing the version of the metric. Default: Timestamp See in-depth description in <a href="https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/graphitemergetree#required-columns">ClickHouse documentation</a></p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafka | **object**
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafka.<br>securityProtocol | **string**
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafka.<br>saslMechanism | **string**
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafka.<br>saslUsername | **string**
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafka.<br>saslPassword | **string**
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafka.<br>enableSslCertificateVerification | **boolean** (boolean)
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafka.<br>maxPollIntervalMs | **integer** (int64)<br><p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafka.<br>sessionTimeoutMs | **integer** (int64)<br><p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafka.<br>debug | **string**
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafka.<br>autoOffsetReset | **string**
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafkaTopics[] | **object**
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafkaTopics[].<br>name | **string**<br><p>Required.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafkaTopics[].<br>settings | **object**<br><p>Required.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafkaTopics[].<br>settings.<br>securityProtocol | **string**
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafkaTopics[].<br>settings.<br>saslMechanism | **string**
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafkaTopics[].<br>settings.<br>saslUsername | **string**
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafkaTopics[].<br>settings.<br>saslPassword | **string**
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafkaTopics[].<br>settings.<br>enableSslCertificateVerification | **boolean** (boolean)
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafkaTopics[].<br>settings.<br>maxPollIntervalMs | **integer** (int64)<br><p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafkaTopics[].<br>settings.<br>sessionTimeoutMs | **integer** (int64)<br><p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafkaTopics[].<br>settings.<br>debug | **string**
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafkaTopics[].<br>settings.<br>autoOffsetReset | **string**
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>rabbitmq | **object**
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>rabbitmq.<br>username | **string**<br><p><a href="https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/">RabbitMQ</a> username</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>rabbitmq.<br>password | **string**<br><p><a href="https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/">RabbitMQ</a> password</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>rabbitmq.<br>vhost | **string**<br><p><a href="https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/">RabbitMQ</a> virtual host</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections.</p> <p>The minimum value is 10.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>maxConcurrentQueries | **integer** (int64)<br><p>Maximum number of simultaneously processed requests.</p> <p>The minimum value is 10.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>keepAliveTimeout | **integer** (int64)<br><p>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>uncompressedCacheSize | **integer** (int64)<br><p>Cache size (in bytes) for uncompressed data used by MergeTree tables.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>markCacheSize | **integer** (int64)<br><p>Approximate size (in bytes) of the cache of "marks" used by MergeTree tables.</p> <p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>maxTableSizeToDrop | **integer** (int64)<br><p>Maximum size of the table that can be deleted using a DROP query.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>maxPartitionSizeToDrop | **integer** (int64)<br><p>Maximum size of the partition that can be deleted using a DROP query.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>builtinDictionariesReloadInterval | **integer** (int64)<br><p>The setting is deprecated and has no effect.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>timezone | **string**<br><p>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>geobaseEnabled | **boolean** (boolean)<br><p>Enable or disable geobase.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>geobaseUri | **string**<br><p>Address of the archive with the user geobase in Object Storage.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>queryLogRetentionSize | **integer** (int64)<br><p>The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>queryLogRetentionTime | **integer** (int64)<br><p>The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>queryThreadLogEnabled | **boolean** (boolean)<br><p>Whether query_thread_log system table is enabled.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>queryThreadLogRetentionSize | **integer** (int64)<br><p>The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>queryThreadLogRetentionTime | **integer** (int64)<br><p>The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>partLogRetentionSize | **integer** (int64)<br><p>The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>partLogRetentionTime | **integer** (int64)<br><p>The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>metricLogEnabled | **boolean** (boolean)<br><p>Whether metric_log system table is enabled.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>metricLogRetentionSize | **integer** (int64)<br><p>The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>metricLogRetentionTime | **integer** (int64)<br><p>The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>traceLogEnabled | **boolean** (boolean)<br><p>Whether trace_log system table is enabled.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>traceLogRetentionSize | **integer** (int64)<br><p>The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>traceLogRetentionTime | **integer** (int64)<br><p>The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>textLogEnabled | **boolean** (boolean)<br><p>Whether text_log system table is enabled.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>textLogRetentionSize | **integer** (int64)<br><p>The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>textLogRetentionTime | **integer** (int64)<br><p>The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>textLogLevel | **string**<br><p>Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>opentelemetrySpanLogEnabled | **boolean** (boolean)<br><p>Enable or disable opentelemetry_span_log system table. Default value: false.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>opentelemetrySpanLogRetentionSize | **integer** (int64)<br><p>The maximum size that opentelemetry_span_log can grow to before old data will be removed. If set to 0 (default), automatic removal of opentelemetry_span_log data based on size is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>opentelemetrySpanLogRetentionTime | **integer** (int64)<br><p>The maximum time that opentelemetry_span_log records will be retained before removal. If set to 0, automatic removal of opentelemetry_span_log data based on time is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>queryViewsLogEnabled | **boolean** (boolean)<br><p>Enable or disable query_views_log system table. Default value: false.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>queryViewsLogRetentionSize | **integer** (int64)<br><p>The maximum size that query_views_log can grow to before old data will be removed. If set to 0 (default), automatic removal of query_views_log data based on size is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>queryViewsLogRetentionTime | **integer** (int64)<br><p>The maximum time that query_views_log records will be retained before removal. If set to 0, automatic removal of query_views_log data based on time is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>asynchronousMetricLogEnabled | **boolean** (boolean)<br><p>Enable or disable asynchronous_metric_log system table. Default value: false.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>asynchronousMetricLogRetentionSize | **integer** (int64)<br><p>The maximum size that asynchronous_metric_log can grow to before old data will be removed. If set to 0 (default), automatic removal of asynchronous_metric_log data based on size is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>asynchronousMetricLogRetentionTime | **integer** (int64)<br><p>The maximum time that asynchronous_metric_log records will be retained before removal. If set to 0, automatic removal of asynchronous_metric_log data based on time is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>sessionLogEnabled | **boolean** (boolean)<br><p>Enable or disable session_log system table. Default value: false.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>sessionLogRetentionSize | **integer** (int64)<br><p>The maximum size that session_log can grow to before old data will be removed. If set to 0 (default), automatic removal of session_log data based on size is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>sessionLogRetentionTime | **integer** (int64)<br><p>The maximum time that session_log records will be retained before removal. If set to 0, automatic removal of session_log data based on time is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>zookeeperLogEnabled | **boolean** (boolean)<br><p>Enable or disable zookeeper_log system table. Default value: false.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>zookeeperLogRetentionSize | **integer** (int64)<br><p>The maximum size that zookeeper_log can grow to before old data will be removed. If set to 0 (default), automatic removal of zookeeper_log data based on size is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>zookeeperLogRetentionTime | **integer** (int64)<br><p>The maximum time that zookeeper_log records will be retained before removal. If set to 0, automatic removal of zookeeper_log data based on time is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>asynchronousInsertLogEnabled | **boolean** (boolean)<br><p>Enable or disable asynchronous_insert_log system table. Default value: false. Minimal required ClickHouse version: 22.10.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>asynchronousInsertLogRetentionSize | **integer** (int64)<br><p>The maximum size that asynchronous_insert_log can grow to before old data will be removed. If set to 0 (default), automatic removal of asynchronous_insert_log data based on size is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>asynchronousInsertLogRetentionTime | **integer** (int64)<br><p>The maximum time that asynchronous_insert_log records will be retained before removal. If set to 0, automatic removal of asynchronous_insert_log data based on time is disabled.</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>backgroundPoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>backgroundMergesMutationsConcurrencyRatio | **integer** (int64)<br><p>Sets a ratio between the number of threads and the number of background merges and mutations that can be executed concurrently. For example, if the ratio equals to 2 and background_pool_size is set to 16 then ClickHouse can execute 32 background merges concurrently. This is possible, because background operations could be suspended and postponed. This is needed to give small merges more execution priority. You can only increase this ratio at runtime. To lower it you have to restart the server. The same as for background_pool_size setting background_merges_mutations_concurrency_ratio could be applied from the default profile for backward compatibility. Default: 2 See in-depth description in <a href="https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#background_merges_mutations_concurrency_ratio">ClickHouse documentation</a></p> <p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>backgroundSchedulePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>backgroundFetchesPoolSize | **integer** (int64)<br><p>Sets the number of threads performing background fetches for tables with <strong>ReplicatedMergeTree</strong> engines. Default value: 8.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>backgroundMovePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>backgroundDistributedSchedulePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>backgroundBufferFlushSchedulePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>backgroundMessageBrokerSchedulePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>backgroundCommonPoolSize | **integer** (int64)<br><p>The maximum number of threads that will be used for performing a variety of operations (mostly garbage collection) for *MergeTree-engine tables in a background. Default: 8 See in-depth description in <a href="https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#background_common_pool_size">ClickHouse documentation</a></p> <p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>defaultDatabase | **string**<br><p>The default database.</p> <p>To get a list of cluster databases, see <a href="/docs/managed-clickhouse/operations/databases#list-db">Yandex Managed ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>totalMemoryProfilerStep | **integer** (int64)<br><p>Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: <strong>4194304</strong>.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>totalMemoryTrackerSampleProbability | **number** (double)
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>queryMaskingRules[] | **object**<br><p>Required. Regexp-based rules, which will be applied to queries as well as all log messages before storing them in server logs, system.query_log, system.text_log, system.processes tables, and in logs sent to the client. That allows preventing sensitive data leakage from SQL queries (like names, emails, personal identifiers or credit card numbers) to logs. Change of these settings is applied with ClickHouse restart See in-depth description in <a href="https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#query-masking-rules">ClickHouse documentation</a></p> <p>Must contain at least one element.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>queryMaskingRules[].<br>name | **string**<br><p>Name for the rule.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>queryMaskingRules[].<br>regexp | **string**<br><p>Required. RE2 compatible regular expression. Required.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>queryMaskingRules[].<br>replace | **string**<br><p>Substitution string for sensitive data. Default: six asterisks</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionariesLazyLoad | **boolean** (boolean)<br><p>Lazy loading of dictionaries. Default: true See in-depth description in <a href="https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#dictionaries_lazy_load">ClickHouse documentation</a></p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>queryCache | **object**<br><p><a href="https://clickhouse.com/docs/en/operations/query-cache">Query cache</a> configuration. Min version: 23.5 See in-depth description in <a href="https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#query_cache">ClickHouse documentation</a></p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>queryCache.<br>maxSizeInBytes | **integer** (int64)<br><p>The maximum cache size in bytes. Default: 1073741824 (1 GiB)</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>queryCache.<br>maxEntries | **integer** (int64)<br><p>The maximum number of SELECT query results stored in the cache. Default: 1024</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>queryCache.<br>maxEntrySizeInBytes | **integer** (int64)<br><p>The maximum size in bytes SELECT query results may have to be saved in the cache. Dafault: 1048576 (1 MiB)</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>queryCache.<br>maxEntrySizeInRows | **integer** (int64)<br><p>The maximum number of rows SELECT query results may have to be saved in the cache. Default: 30000000 (30 mil)</p> <p>The minimum value is 0.</p> 
config.<br>clickhouse.<br>resources | **object**<br><p>Computational resources for a shard.</p> 
config.<br>clickhouse.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-clickhouse/concepts/instance-types">documentation</a></p> 
config.<br>clickhouse.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>clickhouse.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>clickhouse.<br>weight | **integer** (int64)<br><p>Relative weight of a shard considered when writing data to the cluster. For details, see <a href="https://clickhouse.com/docs/en/operations/table_engines/distributed/">ClickHouse documentation</a>.</p> 