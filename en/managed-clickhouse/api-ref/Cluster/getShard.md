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
            "numberOfFreeEntriesInPoolToExecuteMutation": "integer"
          },
          "compression": [
            {
              "method": "string",
              "minPartSize": "string",
              "minPartSizeRatio": "number"
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
                "sizeInCells": "string"
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
                "format": "string"
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
                "invalidateQuery": "string"
              },
              "clickhouseSource": {
                "db": "string",
                "table": "string",
                "host": "string",
                "port": "string",
                "user": "string",
                "password": "string",
                "where": "string"
              },
              "mongodbSource": {
                "db": "string",
                "collection": "string",
                "host": "string",
                "port": "string",
                "user": "string",
                "password": "string"
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
              ]
            }
          ],
          "kafka": {
            "securityProtocol": "string",
            "saslMechanism": "string",
            "saslUsername": "string",
            "saslPassword": "string"
          },
          "kafkaTopics": [
            {
              "name": "string",
              "settings": {
                "securityProtocol": "string",
                "saslMechanism": "string",
                "saslUsername": "string",
                "saslPassword": "string"
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
          "backgroundPoolSize": "integer",
          "backgroundSchedulePoolSize": "integer",
          "backgroundFetchesPoolSize": "integer",
          "backgroundMovePoolSize": "integer",
          "backgroundDistributedSchedulePoolSize": "integer",
          "backgroundBufferFlushSchedulePoolSize": "integer",
          "backgroundMessageBrokerSchedulePoolSize": "integer",
          "defaultDatabase": "string",
          "totalMemoryProfilerStep": "integer",
          "totalMemoryTrackerSampleProbability": "number"
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
            "numberOfFreeEntriesInPoolToExecuteMutation": "integer"
          },
          "compression": [
            {
              "method": "string",
              "minPartSize": "string",
              "minPartSizeRatio": "number"
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
                "sizeInCells": "string"
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
                "format": "string"
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
                "invalidateQuery": "string"
              },
              "clickhouseSource": {
                "db": "string",
                "table": "string",
                "host": "string",
                "port": "string",
                "user": "string",
                "password": "string",
                "where": "string"
              },
              "mongodbSource": {
                "db": "string",
                "collection": "string",
                "host": "string",
                "port": "string",
                "user": "string",
                "password": "string"
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
              ]
            }
          ],
          "kafka": {
            "securityProtocol": "string",
            "saslMechanism": "string",
            "saslUsername": "string",
            "saslPassword": "string"
          },
          "kafkaTopics": [
            {
              "name": "string",
              "settings": {
                "securityProtocol": "string",
                "saslMechanism": "string",
                "saslUsername": "string",
                "saslPassword": "string"
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
          "backgroundPoolSize": "integer",
          "backgroundSchedulePoolSize": "integer",
          "backgroundFetchesPoolSize": "integer",
          "backgroundMovePoolSize": "integer",
          "backgroundDistributedSchedulePoolSize": "integer",
          "backgroundBufferFlushSchedulePoolSize": "integer",
          "backgroundMessageBrokerSchedulePoolSize": "integer",
          "defaultDatabase": "string",
          "totalMemoryProfilerStep": "integer",
          "totalMemoryTrackerSampleProbability": "number"
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
            "numberOfFreeEntriesInPoolToExecuteMutation": "integer"
          },
          "compression": [
            {
              "method": "string",
              "minPartSize": "string",
              "minPartSizeRatio": "number"
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
                "sizeInCells": "string"
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
                "format": "string"
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
                "invalidateQuery": "string"
              },
              "clickhouseSource": {
                "db": "string",
                "table": "string",
                "host": "string",
                "port": "string",
                "user": "string",
                "password": "string",
                "where": "string"
              },
              "mongodbSource": {
                "db": "string",
                "collection": "string",
                "host": "string",
                "port": "string",
                "user": "string",
                "password": "string"
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
              ]
            }
          ],
          "kafka": {
            "securityProtocol": "string",
            "saslMechanism": "string",
            "saslUsername": "string",
            "saslPassword": "string"
          },
          "kafkaTopics": [
            {
              "name": "string",
              "settings": {
                "securityProtocol": "string",
                "saslMechanism": "string",
                "saslUsername": "string",
                "saslPassword": "string"
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
          "backgroundPoolSize": "integer",
          "backgroundSchedulePoolSize": "integer",
          "backgroundFetchesPoolSize": "integer",
          "backgroundMovePoolSize": "integer",
          "backgroundDistributedSchedulePoolSize": "integer",
          "backgroundBufferFlushSchedulePoolSize": "integer",
          "backgroundMessageBrokerSchedulePoolSize": "integer",
          "defaultDatabase": "string",
          "totalMemoryProfilerStep": "integer",
          "totalMemoryTrackerSampleProbability": "number"
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
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>compression[] | **object**<br><p>Compression settings for the ClickHouse cluster. See in-depth description in <a href="https://clickhouse.com/docs/en/operations/server_settings/settings/#compression">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>compression[].<br>method | **string**<br><p>Compression method to use for the specified combination of ``minPartSize`` and ``minPartSizeRatio``.</p> <ul> <li>LZ4: <a href="https://lz4.github.io/lz4/">LZ4 compression algorithm</a>.</li> <li>ZSTD: <a href="https://facebook.github.io/zstd/">Zstandard compression algorithm</a>.</li> </ul> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>compression[].<br>minPartSize | **string** (int64)<br><p>Minimum size of a part of a table.</p> <p>The minimum value is 1.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>compression[].<br>minPartSizeRatio | **number** (double)<br><p>Minimum ratio of a part relative to the size of all the data in the table.</p> 
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
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>fixedLifetime | **string** (int64) <br>`config.clickhouse.config.effectiveConfig.dictionaries[]` includes only one of the fields `fixedLifetime`, `lifetimeRange`<br><br><p>Fixed interval between dictionary updates.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>lifetimeRange | **object**<br>Range of intervals between dictionary updates for ClickHouse to choose from. <br>`config.clickhouse.config.effectiveConfig.dictionaries[]` includes only one of the fields `fixedLifetime`, `lifetimeRange`<br>
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>lifetimeRange.<br>min | **string** (int64)<br><p>Minimum dictionary lifetime.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>lifetimeRange.<br>max | **string** (int64)<br><p>Maximum dictionary lifetime.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>httpSource | **object**<br>HTTP source for the dictionary. <br>`config.clickhouse.config.effectiveConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>httpSource.<br>url | **string**<br><p>Required. URL of the source dictionary available over HTTP.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>httpSource.<br>format | **string**<br><p>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect.</p> 
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
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>clickhouseSource | **object**<br>ClickHouse source for the dictionary. <br>`config.clickhouse.config.effectiveConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>clickhouseSource.<br>db | **string**<br><p>Required. Name of the ClickHouse database.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>clickhouseSource.<br>table | **string**<br><p>Required. Name of the table in the specified database to be used as the dictionary source.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>clickhouseSource.<br>host | **string**<br><p>Required. ClickHouse host of the specified database.</p> <p>The maximum string length in characters is 253.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>clickhouseSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>clickhouseSource.<br>user | **string**<br><p>Required. Name of the ClickHouse database user.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>clickhouseSource.<br>password | **string**<br><p>Password of the ClickHouse database user.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>clickhouseSource.<br>where | **string**<br><p>Selection criteria for the data in the specified ClickHouse table.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mongodbSource | **object**<br>MongoDB source for the dictionary. <br>`config.clickhouse.config.effectiveConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mongodbSource.<br>db | **string**<br><p>Required. Name of the MongoDB database.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mongodbSource.<br>collection | **string**<br><p>Required. Name of the collection in the specified database to be used as the dictionary source.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mongodbSource.<br>host | **string**<br><p>Required. MongoDB host of the specified database.</p> <p>The maximum string length in characters is 253.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mongodbSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mongodbSource.<br>user | **string**<br><p>Required. Name of the MongoDB database user.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mongodbSource.<br>password | **string**<br><p>Password of the MongoDB database user.</p> 
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
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafka | **object**
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafka.<br>securityProtocol | **string**
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafka.<br>saslMechanism | **string**
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafka.<br>saslUsername | **string**
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafka.<br>saslPassword | **string**
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafkaTopics[] | **object**
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafkaTopics[].<br>name | **string**<br><p>Required.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafkaTopics[].<br>settings | **object**<br><p>Required.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafkaTopics[].<br>settings.<br>securityProtocol | **string**
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafkaTopics[].<br>settings.<br>saslMechanism | **string**
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafkaTopics[].<br>settings.<br>saslUsername | **string**
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafkaTopics[].<br>settings.<br>saslPassword | **string**
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
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>opentelemetrySpanLogEnabled | **boolean** (boolean)
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>backgroundPoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>backgroundSchedulePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>backgroundFetchesPoolSize | **integer** (int64)<br><p>Sets the number of threads performing background fetches for tables with <strong>ReplicatedMergeTree</strong> engines. Default value: 8.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>backgroundMovePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>backgroundDistributedSchedulePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>backgroundBufferFlushSchedulePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>backgroundMessageBrokerSchedulePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>defaultDatabase | **string**<br><p>The default database.</p> <p>To get a list of cluster databases, see <a href="https://cloud.yandex.com/en/docs/managed-clickhouse/operations/databases#list-db">Yandex Managed ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>totalMemoryProfilerStep | **integer** (int64)<br><p>Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: <strong>4194304</strong>.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>totalMemoryTrackerSampleProbability | **number** (double)
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
config.<br>clickhouse.<br>config.<br>userConfig.<br>compression[] | **object**<br><p>Compression settings for the ClickHouse cluster. See in-depth description in <a href="https://clickhouse.com/docs/en/operations/server_settings/settings/#compression">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>compression[].<br>method | **string**<br><p>Compression method to use for the specified combination of ``minPartSize`` and ``minPartSizeRatio``.</p> <ul> <li>LZ4: <a href="https://lz4.github.io/lz4/">LZ4 compression algorithm</a>.</li> <li>ZSTD: <a href="https://facebook.github.io/zstd/">Zstandard compression algorithm</a>.</li> </ul> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>compression[].<br>minPartSize | **string** (int64)<br><p>Minimum size of a part of a table.</p> <p>The minimum value is 1.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>compression[].<br>minPartSizeRatio | **number** (double)<br><p>Minimum ratio of a part relative to the size of all the data in the table.</p> 
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
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>fixedLifetime | **string** (int64) <br>`config.clickhouse.config.userConfig.dictionaries[]` includes only one of the fields `fixedLifetime`, `lifetimeRange`<br><br><p>Fixed interval between dictionary updates.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>lifetimeRange | **object**<br>Range of intervals between dictionary updates for ClickHouse to choose from. <br>`config.clickhouse.config.userConfig.dictionaries[]` includes only one of the fields `fixedLifetime`, `lifetimeRange`<br>
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>lifetimeRange.<br>min | **string** (int64)<br><p>Minimum dictionary lifetime.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>lifetimeRange.<br>max | **string** (int64)<br><p>Maximum dictionary lifetime.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>httpSource | **object**<br>HTTP source for the dictionary. <br>`config.clickhouse.config.userConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>httpSource.<br>url | **string**<br><p>Required. URL of the source dictionary available over HTTP.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>httpSource.<br>format | **string**<br><p>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect.</p> 
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
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>clickhouseSource | **object**<br>ClickHouse source for the dictionary. <br>`config.clickhouse.config.userConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>clickhouseSource.<br>db | **string**<br><p>Required. Name of the ClickHouse database.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>clickhouseSource.<br>table | **string**<br><p>Required. Name of the table in the specified database to be used as the dictionary source.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>clickhouseSource.<br>host | **string**<br><p>Required. ClickHouse host of the specified database.</p> <p>The maximum string length in characters is 253.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>clickhouseSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>clickhouseSource.<br>user | **string**<br><p>Required. Name of the ClickHouse database user.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>clickhouseSource.<br>password | **string**<br><p>Password of the ClickHouse database user.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>clickhouseSource.<br>where | **string**<br><p>Selection criteria for the data in the specified ClickHouse table.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mongodbSource | **object**<br>MongoDB source for the dictionary. <br>`config.clickhouse.config.userConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mongodbSource.<br>db | **string**<br><p>Required. Name of the MongoDB database.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mongodbSource.<br>collection | **string**<br><p>Required. Name of the collection in the specified database to be used as the dictionary source.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mongodbSource.<br>host | **string**<br><p>Required. MongoDB host of the specified database.</p> <p>The maximum string length in characters is 253.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mongodbSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mongodbSource.<br>user | **string**<br><p>Required. Name of the MongoDB database user.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mongodbSource.<br>password | **string**<br><p>Password of the MongoDB database user.</p> 
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
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafka | **object**
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafka.<br>securityProtocol | **string**
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafka.<br>saslMechanism | **string**
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafka.<br>saslUsername | **string**
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafka.<br>saslPassword | **string**
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafkaTopics[] | **object**
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafkaTopics[].<br>name | **string**<br><p>Required.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafkaTopics[].<br>settings | **object**<br><p>Required.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafkaTopics[].<br>settings.<br>securityProtocol | **string**
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafkaTopics[].<br>settings.<br>saslMechanism | **string**
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafkaTopics[].<br>settings.<br>saslUsername | **string**
config.<br>clickhouse.<br>config.<br>userConfig.<br>kafkaTopics[].<br>settings.<br>saslPassword | **string**
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
config.<br>clickhouse.<br>config.<br>userConfig.<br>opentelemetrySpanLogEnabled | **boolean** (boolean)
config.<br>clickhouse.<br>config.<br>userConfig.<br>backgroundPoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>backgroundSchedulePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>backgroundFetchesPoolSize | **integer** (int64)<br><p>Sets the number of threads performing background fetches for tables with <strong>ReplicatedMergeTree</strong> engines. Default value: 8.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>backgroundMovePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>backgroundDistributedSchedulePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>backgroundBufferFlushSchedulePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>backgroundMessageBrokerSchedulePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>defaultDatabase | **string**<br><p>The default database.</p> <p>To get a list of cluster databases, see <a href="https://cloud.yandex.com/en/docs/managed-clickhouse/operations/databases#list-db">Yandex Managed ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>totalMemoryProfilerStep | **integer** (int64)<br><p>Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: <strong>4194304</strong>.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>userConfig.<br>totalMemoryTrackerSampleProbability | **number** (double)
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
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>compression[] | **object**<br><p>Compression settings for the ClickHouse cluster. See in-depth description in <a href="https://clickhouse.com/docs/en/operations/server_settings/settings/#compression">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>compression[].<br>method | **string**<br><p>Compression method to use for the specified combination of ``minPartSize`` and ``minPartSizeRatio``.</p> <ul> <li>LZ4: <a href="https://lz4.github.io/lz4/">LZ4 compression algorithm</a>.</li> <li>ZSTD: <a href="https://facebook.github.io/zstd/">Zstandard compression algorithm</a>.</li> </ul> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>compression[].<br>minPartSize | **string** (int64)<br><p>Minimum size of a part of a table.</p> <p>The minimum value is 1.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>compression[].<br>minPartSizeRatio | **number** (double)<br><p>Minimum ratio of a part relative to the size of all the data in the table.</p> 
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
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>fixedLifetime | **string** (int64) <br>`config.clickhouse.config.defaultConfig.dictionaries[]` includes only one of the fields `fixedLifetime`, `lifetimeRange`<br><br><p>Fixed interval between dictionary updates.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>lifetimeRange | **object**<br>Range of intervals between dictionary updates for ClickHouse to choose from. <br>`config.clickhouse.config.defaultConfig.dictionaries[]` includes only one of the fields `fixedLifetime`, `lifetimeRange`<br>
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>lifetimeRange.<br>min | **string** (int64)<br><p>Minimum dictionary lifetime.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>lifetimeRange.<br>max | **string** (int64)<br><p>Maximum dictionary lifetime.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>httpSource | **object**<br>HTTP source for the dictionary. <br>`config.clickhouse.config.defaultConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>httpSource.<br>url | **string**<br><p>Required. URL of the source dictionary available over HTTP.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>httpSource.<br>format | **string**<br><p>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect.</p> 
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
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>clickhouseSource | **object**<br>ClickHouse source for the dictionary. <br>`config.clickhouse.config.defaultConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>clickhouseSource.<br>db | **string**<br><p>Required. Name of the ClickHouse database.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>clickhouseSource.<br>table | **string**<br><p>Required. Name of the table in the specified database to be used as the dictionary source.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>clickhouseSource.<br>host | **string**<br><p>Required. ClickHouse host of the specified database.</p> <p>The maximum string length in characters is 253.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>clickhouseSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>clickhouseSource.<br>user | **string**<br><p>Required. Name of the ClickHouse database user.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>clickhouseSource.<br>password | **string**<br><p>Password of the ClickHouse database user.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>clickhouseSource.<br>where | **string**<br><p>Selection criteria for the data in the specified ClickHouse table.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mongodbSource | **object**<br>MongoDB source for the dictionary. <br>`config.clickhouse.config.defaultConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mongodbSource.<br>db | **string**<br><p>Required. Name of the MongoDB database.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mongodbSource.<br>collection | **string**<br><p>Required. Name of the collection in the specified database to be used as the dictionary source.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mongodbSource.<br>host | **string**<br><p>Required. MongoDB host of the specified database.</p> <p>The maximum string length in characters is 253.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mongodbSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mongodbSource.<br>user | **string**<br><p>Required. Name of the MongoDB database user.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mongodbSource.<br>password | **string**<br><p>Password of the MongoDB database user.</p> 
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
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafka | **object**
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafka.<br>securityProtocol | **string**
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafka.<br>saslMechanism | **string**
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafka.<br>saslUsername | **string**
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafka.<br>saslPassword | **string**
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafkaTopics[] | **object**
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafkaTopics[].<br>name | **string**<br><p>Required.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafkaTopics[].<br>settings | **object**<br><p>Required.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafkaTopics[].<br>settings.<br>securityProtocol | **string**
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafkaTopics[].<br>settings.<br>saslMechanism | **string**
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafkaTopics[].<br>settings.<br>saslUsername | **string**
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafkaTopics[].<br>settings.<br>saslPassword | **string**
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
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>opentelemetrySpanLogEnabled | **boolean** (boolean)
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>backgroundPoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>backgroundSchedulePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>backgroundFetchesPoolSize | **integer** (int64)<br><p>Sets the number of threads performing background fetches for tables with <strong>ReplicatedMergeTree</strong> engines. Default value: 8.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>backgroundMovePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>backgroundDistributedSchedulePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>backgroundBufferFlushSchedulePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>backgroundMessageBrokerSchedulePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>defaultDatabase | **string**<br><p>The default database.</p> <p>To get a list of cluster databases, see <a href="https://cloud.yandex.com/en/docs/managed-clickhouse/operations/databases#list-db">Yandex Managed ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>totalMemoryProfilerStep | **integer** (int64)<br><p>Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: <strong>4194304</strong>.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step">ClickHouse documentation</a>.</p> 
config.<br>clickhouse.<br>config.<br>defaultConfig.<br>totalMemoryTrackerSampleProbability | **number** (double)
config.<br>clickhouse.<br>resources | **object**<br><p>Computational resources for a shard.</p> 
config.<br>clickhouse.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-clickhouse/concepts/instance-types">documentation</a></p> 
config.<br>clickhouse.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>clickhouse.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>clickhouse.<br>weight | **integer** (int64)<br><p>Relative weight of a shard considered when writing data to the cluster. For details, see <a href="https://clickhouse.com/docs/en/operations/table_engines/distributed/">ClickHouse documentation</a>.</p> 