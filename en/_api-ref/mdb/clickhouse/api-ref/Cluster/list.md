---
editable: false
---

# Method list
Retrieves a list of ClickHouse clusters that belong
to the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list ClickHouse clusters in. To get the folder ID, use a [list](/docs/resource-manager/api-ref/Folder/list) request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/managed-clickhouse/api-ref/Cluster/list#query_params), the service returns a [nextPageToken](/docs/managed-clickhouse/api-ref/Cluster/list#responses) that can be used to get the next page of results in subsequent list requests.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/managed-clickhouse/api-ref/Cluster/list#query_params) to the [nextPageToken](/docs/managed-clickhouse/api-ref/Cluster/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently you can only use filtering with the [Cluster.name](/docs/managed-clickhouse/api-ref/Cluster#representation) field. 2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Мust be 1-63 characters long and match the regular expression `^[a-zA-Z0-9_-]+$`.  The maximum string length in characters is 1000.
 
## Response {#responses}
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
                "replicatedDeduplicationWindow": "integer",
                "replicatedDeduplicationWindowSeconds": "integer",
                "partsToDelayInsert": "integer",
                "partsToThrowInsert": "integer",
                "maxReplicatedMergesInQueue": "integer",
                "numberOfFreeEntriesInPoolToLowerMaxSizeOfMerge": "integer",
                "maxBytesToMergeAtMinSpaceInPool": "integer"
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

                  // `clusters[].config.clickhouse.config.effectiveConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`
                  "fixedLifetime": "string",
                  "lifetimeRange": {
                    "min": "string",
                    "max": "string"
                  },
                  // end of the list of possible fields`clusters[].config.clickhouse.config.effectiveConfig.dictionaries[]`

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
                "password": "string"
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
              "backgroundPoolSize": "integer",
              "backgroundSchedulePoolSize": "integer"
            },
            "userConfig": {
              "logLevel": "string",
              "mergeTree": {
                "replicatedDeduplicationWindow": "integer",
                "replicatedDeduplicationWindowSeconds": "integer",
                "partsToDelayInsert": "integer",
                "partsToThrowInsert": "integer",
                "maxReplicatedMergesInQueue": "integer",
                "numberOfFreeEntriesInPoolToLowerMaxSizeOfMerge": "integer",
                "maxBytesToMergeAtMinSpaceInPool": "integer"
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

                  // `clusters[].config.clickhouse.config.userConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`
                  "fixedLifetime": "string",
                  "lifetimeRange": {
                    "min": "string",
                    "max": "string"
                  },
                  // end of the list of possible fields`clusters[].config.clickhouse.config.userConfig.dictionaries[]`

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
                "password": "string"
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
              "backgroundPoolSize": "integer",
              "backgroundSchedulePoolSize": "integer"
            },
            "defaultConfig": {
              "logLevel": "string",
              "mergeTree": {
                "replicatedDeduplicationWindow": "integer",
                "replicatedDeduplicationWindowSeconds": "integer",
                "partsToDelayInsert": "integer",
                "partsToThrowInsert": "integer",
                "maxReplicatedMergesInQueue": "integer",
                "numberOfFreeEntriesInPoolToLowerMaxSizeOfMerge": "integer",
                "maxBytesToMergeAtMinSpaceInPool": "integer"
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

                  // `clusters[].config.clickhouse.config.defaultConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`
                  "fixedLifetime": "string",
                  "lifetimeRange": {
                    "min": "string",
                    "max": "string"
                  },
                  // end of the list of possible fields`clusters[].config.clickhouse.config.defaultConfig.dictionaries[]`

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
                "password": "string"
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
              "backgroundPoolSize": "integer",
              "backgroundSchedulePoolSize": "integer"
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
          "dataLens": true,
          "webSql": true,
          "metrika": true,
          "serverless": true
        },
        "cloudStorage": {
          "enabled": true
        },
        "sqlDatabaseManagement": true,
        "sqlUserManagement": true
      },
      "networkId": "string",
      "health": "string",
      "status": "string",
      "serviceAccountId": "string",
      "maintenanceWindow": {

        // `clusters[].maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
        "anytime": {},
        "weeklyMaintenanceWindow": {
          "day": "string",
          "hour": "string"
        },
        // end of the list of possible fields`clusters[].maintenanceWindow`

      },
      "plannedOperation": {
        "info": "string",
        "delayedUntil": "string"
      },
      "securityGroupIds": [
        "string"
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
clusters[] | **object**<br><p>A ClickHouse Cluster resource. For more information, see the <a href="/docs/managed-clickhouse/concepts">Cluster</a> section in the Developer's Guide.</p> 
clusters[].<br>id | **string**<br><p>ID of the ClickHouse cluster. This ID is assigned by MDB at creation time.</p> 
clusters[].<br>folderId | **string**<br><p>ID of the folder that the ClickHouse cluster belongs to.</p> 
clusters[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
clusters[].<br>name | **string**<br><p>Name of the ClickHouse cluster. The name is unique within the folder. 1-63 characters long.</p> 
clusters[].<br>description | **string**<br><p>Description of the ClickHouse cluster. 0-256 characters long.</p> 
clusters[].<br>labels | **object**<br><p>Custom labels for the ClickHouse cluster as `key:value` pairs. Maximum 64 per resource.</p> 
clusters[].<br>environment | **string**<br><p>Deployment environment of the ClickHouse cluster.</p> <p>Deployment environment.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
clusters[].<br>monitoring[] | **object**<br><p>Monitoring system metadata.</p> 
clusters[].<br>monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>link | **string**<br><p>Link to the monitoring system charts for the ClickHouse cluster.</p> 
clusters[].<br>config | **object**<br><p>Configuration of the ClickHouse cluster.</p> 
clusters[].<br>config.<br>version | **string**<br><p>Version of the ClickHouse server software.</p> 
clusters[].<br>config.<br>clickhouse | **object**<br><p>Configuration and resource allocation for ClickHouse hosts.</p> 
clusters[].<br>config.<br>clickhouse.<br>config | **object**<br><p>Configuration settings of a ClickHouse server.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig | **object**<br><p>Required. Effective settings for a ClickHouse cluster (a combination of settings defined in `userConfig` and `defaultConfig`).</p> <p>ClickHouse configuration options. Detailed description for each set of options is available in <a href="https://clickhouse.yandex/docs/en/operations/server_settings/settings/">ClickHouse documentation</a>.</p> <p>Any options not listed here are not supported.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>logLevel | **string**<br><p>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree | **object**<br><p>Settings for the MergeTree engine. See description in <a href="https://clickhouse.yandex/docs/en/operations/server_settings/settings/#merge_tree">ClickHouse documentation</a>.</p> <p>Options specific to the MergeTree table engine.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>replicatedDeduplicationWindow | **integer** (int64)<br><p>Number of blocks of hashes to keep in ZooKeeper.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>replicatedDeduplicationWindowSeconds | **integer** (int64)<br><p>Period of time to keep blocks of hashes for.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>partsToDelayInsert | **integer** (int64)<br><p>If table contains at least that many active parts in single partition, artificially slow down insert into table.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>partsToThrowInsert | **integer** (int64)<br><p>If more than this number active parts in single partition, throw 'Too many parts ...' exception.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>maxReplicatedMergesInQueue | **integer** (int64)<br><p>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>numberOfFreeEntriesInPoolToLowerMaxSizeOfMerge | **integer** (int64)<br><p>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>mergeTree.<br>maxBytesToMergeAtMinSpaceInPool | **integer** (int64)<br><p>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue).</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>compression[] | **object**<br><p>Compression settings for the ClickHouse cluster. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/server_settings/settings/#compression">ClickHouse documentation</a>.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>compression[].<br>method | **string**<br><p>Compression method to use for the specified combination of `min_part_size` and `min_part_size_ratio`.</p> <ul> <li>LZ4: <a href="https://lz4.github.io/lz4/">LZ4 compression algorithm</a>.</li> <li>ZSTD: <a href="https://facebook.github.io/zstd/">Zstandard compression algorithm</a>.</li> </ul> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>compression[].<br>minPartSize | **string** (int64)<br><p>Minimum size of a part of a table.</p> <p>The minimum value is 1.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>compression[].<br>minPartSizeRatio | **number** (double)<br><p>Minimum ratio of a part relative to the size of all the data in the table.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[] | **object**<br><p>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in <a href="https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts/">ClickHouse documentation</a>.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>name | **string**<br><p>Required. Name of the external dictionary.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure | **object**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_structure/).<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>id | **object**<br><p>Single numeric key column for the dictionary.</p> <p>Numeric key.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>id.<br>name | **string**<br><p>Required. Name of the numeric key.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>key | **object**<br><p>Composite key for the dictionary, containing of one or more key columns. For details, see <a href="https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key">ClickHouse documentation</a>.</p> <p>Complex key.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[] | **object**<br><p>Required. Attributes of a complex key.</p> <p>Must contain at least one element.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>name | **string**<br><p>Required. Name of the column.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>type | **string**<br><p>Required. Type of the column.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: `false`.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping &quot;id -&gt; attribute&quot;. Default value: `false`.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>rangeMin | **object**<br><p>Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout. For details, see <a href="https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed">ClickHouse documentation</a>.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>name | **string**<br><p>Required. Name of the column.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>type | **string**<br><p>Required. Type of the column.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: `false`.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping &quot;id -&gt; attribute&quot;. Default value: `false`.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>rangeMax | **object**<br><p>Field holding the end of the range for dictionaries with `RANGE_HASHED` layout. For details, see <a href="https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed">ClickHouse documentation</a>.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>name | **string**<br><p>Required. Name of the column.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>type | **string**<br><p>Required. Type of the column.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: `false`.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping &quot;id -&gt; attribute&quot;. Default value: `false`.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>attributes[] | **object**<br><p>Required. Description of the fields available for database queries. For details, see <a href="https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes">ClickHouse documentation</a>.</p> <p>Must contain at least one element.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>name | **string**<br><p>Required. Name of the column.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>type | **string**<br><p>Required. Type of the column.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: `false`.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping &quot;id -&gt; attribute&quot;. Default value: `false`.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>layout | **object**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_layout/).<br><p>Layout determining how to store the dictionary in memory.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>layout.<br>type | **string**<br><p>Required. Layout type for an external dictionary.</p> <ul> <li>FLAT: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li> <li>HASHED: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li> <li>COMPLEX_KEY_HASHED: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li> <li>RANGE_HASHED: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li> <li>CACHE: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li> <li>COMPLEX_KEY_CACHE: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li> </ul> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>layout.<br>sizeInCells | **string** (int64)<br><p>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>fixedLifetime | **string** (int64) <br>`clusters[].config.clickhouse.config.effectiveConfig.dictionaries[]` includes only one of the fields `fixedLifetime`, `lifetimeRange`<br><br><p>Fixed interval between dictionary updates.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>lifetimeRange | **object**<br>Range of intervals between dictionary updates for ClickHouse to choose from. <br>`clusters[].config.clickhouse.config.effectiveConfig.dictionaries[]` includes only one of the fields `fixedLifetime`, `lifetimeRange`<br><br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>lifetimeRange.<br>min | **string** (int64)<br><p>Minimum dictionary lifetime.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>lifetimeRange.<br>max | **string** (int64)<br><p>Maximum dictionary lifetime.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>httpSource | **object**<br>HTTP source for the dictionary. <br>`clusters[].config.clickhouse.config.effectiveConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br><br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>httpSource.<br>url | **string**<br><p>Required. URL of the source dictionary available over HTTP.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>httpSource.<br>format | **string**<br><p>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mysqlSource | **object**<br>MySQL source for the dictionary. <br>`clusters[].config.clickhouse.config.effectiveConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br><br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mysqlSource.<br>db | **string**<br><p>Required. Name of the MySQL database to connect to.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mysqlSource.<br>table | **string**<br><p>Required. Name of the database table to use as a ClickHouse dictionary.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mysqlSource.<br>port | **string** (int64)<br><p>Default port to use when connecting to a replica of the dictionary source.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mysqlSource.<br>user | **string**<br><p>Name of the default user for replicas of the dictionary source.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mysqlSource.<br>password | **string**<br><p>Password of the default user for replicas of the dictionary source.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[] | **object**<br><p>Required. List of MySQL replicas of the database used as dictionary source.</p> <p>Must contain at least one element.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>host | **string**<br><p>Required. MySQL host of the replica.</p> <p>The maximum string length in characters is 253.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>priority | **string** (int64)<br><p>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number.</p> <p>Value must be greater than 0.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>port | **string** (int64)<br><p>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>user | **string**<br><p>Name of the MySQL database user.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>password | **string**<br><p>Password of the MySQL database user.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mysqlSource.<br>where | **string**<br><p>Selection criteria for the data in the specified MySQL table.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mysqlSource.<br>invalidateQuery | **string**<br><p>Query for checking the dictionary status, to pull only updated data. For more details, see <a href="https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_lifetime/">ClickHouse documentation on dictionaries</a>.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>clickhouseSource | **object**<br>ClickHouse source for the dictionary. <br>`clusters[].config.clickhouse.config.effectiveConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br><br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>clickhouseSource.<br>db | **string**<br><p>Required. Name of the ClickHouse database.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>clickhouseSource.<br>table | **string**<br><p>Required. Name of the table in the specified database to be used as the dictionary source.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>clickhouseSource.<br>host | **string**<br><p>Required. ClickHouse host of the specified database.</p> <p>The maximum string length in characters is 253.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>clickhouseSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>clickhouseSource.<br>user | **string**<br><p>Required. Name of the ClickHouse database user.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>clickhouseSource.<br>password | **string**<br><p>Password of the ClickHouse database user.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>clickhouseSource.<br>where | **string**<br><p>Selection criteria for the data in the specified ClickHouse table.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mongodbSource | **object**<br>MongoDB source for the dictionary. <br>`clusters[].config.clickhouse.config.effectiveConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br><br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mongodbSource.<br>db | **string**<br><p>Required. Name of the MongoDB database.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mongodbSource.<br>collection | **string**<br><p>Required. Name of the collection in the specified database to be used as the dictionary source.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mongodbSource.<br>host | **string**<br><p>Required. MongoDB host of the specified database.</p> <p>The maximum string length in characters is 253.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mongodbSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mongodbSource.<br>user | **string**<br><p>Required. Name of the MongoDB database user.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>mongodbSource.<br>password | **string**<br><p>Password of the MongoDB database user.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>postgresqlSource | **object**<br>PostgreSQL source for the dictionary. <br>`clusters[].config.clickhouse.config.effectiveConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br><br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>postgresqlSource.<br>db | **string**<br><p>Required. Name of the PostrgreSQL database.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>postgresqlSource.<br>table | **string**<br><p>Required. Name of the table in the specified database to be used as the dictionary source.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>postgresqlSource.<br>hosts[] | **string**<br><p>Required. Name of the PostrgreSQL host</p> <p>Must contain at least one element.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>postgresqlSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>postgresqlSource.<br>user | **string**<br><p>Required. Name of the PostrgreSQL database user.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>postgresqlSource.<br>password | **string**<br><p>Password of the PostrgreSQL database user.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>postgresqlSource.<br>invalidateQuery | **string**<br><p>Query for checking the dictionary status, to pull only updated data. For more details, see <a href="https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_lifetime/">ClickHouse documentation on dictionaries</a>.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>dictionaries[].<br>postgresqlSource.<br>sslMode | **string**<br><p>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see <a href="https://www.postgresql.org/docs/current/libpq-ssl.html">PostgreSQL documentation</a>.</p> <ul> <li>DISABLE: Only try a non-SSL connection.</li> <li>ALLOW: First try a non-SSL connection; if that fails, try an SSL connection.</li> <li>PREFER: First try an SSL connection; if that fails, try a non-SSL connection.</li> <li>VERIFY_CA: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li> <li>VERIFY_FULL: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li> </ul> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>graphiteRollup[] | **object**<br><p>Rollup settings for the GraphiteMergeTree table engine.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>graphiteRollup[].<br>name | **string**<br><p>Required. Name for the specified combination of settings for Graphite rollup.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>graphiteRollup[].<br>patterns[] | **object**<br><p>Required. Pattern to use for the rollup.</p> <p>Must contain at least one element.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>graphiteRollup[].<br>patterns[].<br>regexp | **string**<br><p>Pattern for metric names.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>graphiteRollup[].<br>patterns[].<br>function | **string**<br><p>Required. Name of the aggregating function to apply to data of the age specified in `retention`.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>graphiteRollup[].<br>patterns[].<br>retention[] | **object**<br><p>Required. Age of data to use for thinning.</p> <p>Must contain at least one element.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>graphiteRollup[].<br>patterns[].<br>retention[].<br>age | **string** (int64)<br><p>Minimum age of the data in seconds.</p> <p>Value must be greater than 0.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>graphiteRollup[].<br>patterns[].<br>retention[].<br>precision | **string** (int64)<br><p>Precision of determining the age of the data, in seconds.</p> <p>Value must be greater than 0.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafka | **object**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafka.<br>securityProtocol | **string**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafka.<br>saslMechanism | **string**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafka.<br>saslUsername | **string**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafka.<br>saslPassword | **string**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafkaTopics[] | **object**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafkaTopics[].<br>name | **string**<br><p>Required.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafkaTopics[].<br>settings | **object**<br><p>Required.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafkaTopics[].<br>settings.<br>securityProtocol | **string**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafkaTopics[].<br>settings.<br>saslMechanism | **string**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafkaTopics[].<br>settings.<br>saslUsername | **string**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>kafkaTopics[].<br>settings.<br>saslPassword | **string**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>rabbitmq | **object**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>rabbitmq.<br>username | **string**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>rabbitmq.<br>password | **string**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections.</p> <p>The minimum value is 10.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>maxConcurrentQueries | **integer** (int64)<br><p>Maximum number of simultaneously processed requests.</p> <p>The minimum value is 10.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>keepAliveTimeout | **integer** (int64)<br><p>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>uncompressedCacheSize | **integer** (int64)<br><p>Cache size (in bytes) for uncompressed data used by MergeTree tables.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>markCacheSize | **integer** (int64)<br><p>Approximate size (in bytes) of the cache of &quot;marks&quot; used by MergeTree tables.</p> <p>Value must be greater than 0.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>maxTableSizeToDrop | **integer** (int64)<br><p>Maximum size of the table that can be deleted using a DROP query.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>maxPartitionSizeToDrop | **integer** (int64)<br><p>Maximum size of the partition that can be deleted using a DROP query.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>builtinDictionariesReloadInterval | **integer** (int64)<br><p>The setting is deprecated and has no effect.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>timezone | **string**<br><p>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>geobaseUri | **string**<br><p>Address of the archive with the user geobase in Object Storage.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>queryLogRetentionSize | **integer** (int64)<br><p>The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>queryLogRetentionTime | **integer** (int64)<br><p>The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>queryThreadLogEnabled | **boolean** (boolean)<br><p>Whether query_thread_log system table is enabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>queryThreadLogRetentionSize | **integer** (int64)<br><p>The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>queryThreadLogRetentionTime | **integer** (int64)<br><p>The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>partLogRetentionSize | **integer** (int64)<br><p>The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>partLogRetentionTime | **integer** (int64)<br><p>The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>metricLogEnabled | **boolean** (boolean)<br><p>Whether metric_log system table is enabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>metricLogRetentionSize | **integer** (int64)<br><p>The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>metricLogRetentionTime | **integer** (int64)<br><p>The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>traceLogEnabled | **boolean** (boolean)<br><p>Whether trace_log system table is enabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>traceLogRetentionSize | **integer** (int64)<br><p>The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>traceLogRetentionTime | **integer** (int64)<br><p>The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>textLogEnabled | **boolean** (boolean)<br><p>Whether text_log system table is enabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>textLogRetentionSize | **integer** (int64)<br><p>The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>textLogRetentionTime | **integer** (int64)<br><p>The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>textLogLevel | **string**<br><p>Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>backgroundPoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>effectiveConfig.<br>backgroundSchedulePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig | **object**<br><p>User-defined settings for a ClickHouse cluster.</p> <p>ClickHouse configuration options. Detailed description for each set of options is available in <a href="https://clickhouse.yandex/docs/en/operations/server_settings/settings/">ClickHouse documentation</a>.</p> <p>Any options not listed here are not supported.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>logLevel | **string**<br><p>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree | **object**<br><p>Settings for the MergeTree engine. See description in <a href="https://clickhouse.yandex/docs/en/operations/server_settings/settings/#merge_tree">ClickHouse documentation</a>.</p> <p>Options specific to the MergeTree table engine.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>replicatedDeduplicationWindow | **integer** (int64)<br><p>Number of blocks of hashes to keep in ZooKeeper.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>replicatedDeduplicationWindowSeconds | **integer** (int64)<br><p>Period of time to keep blocks of hashes for.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>partsToDelayInsert | **integer** (int64)<br><p>If table contains at least that many active parts in single partition, artificially slow down insert into table.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>partsToThrowInsert | **integer** (int64)<br><p>If more than this number active parts in single partition, throw 'Too many parts ...' exception.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>maxReplicatedMergesInQueue | **integer** (int64)<br><p>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>numberOfFreeEntriesInPoolToLowerMaxSizeOfMerge | **integer** (int64)<br><p>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>mergeTree.<br>maxBytesToMergeAtMinSpaceInPool | **integer** (int64)<br><p>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue).</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>compression[] | **object**<br><p>Compression settings for the ClickHouse cluster. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/server_settings/settings/#compression">ClickHouse documentation</a>.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>compression[].<br>method | **string**<br><p>Compression method to use for the specified combination of `min_part_size` and `min_part_size_ratio`.</p> <ul> <li>LZ4: <a href="https://lz4.github.io/lz4/">LZ4 compression algorithm</a>.</li> <li>ZSTD: <a href="https://facebook.github.io/zstd/">Zstandard compression algorithm</a>.</li> </ul> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>compression[].<br>minPartSize | **string** (int64)<br><p>Minimum size of a part of a table.</p> <p>The minimum value is 1.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>compression[].<br>minPartSizeRatio | **number** (double)<br><p>Minimum ratio of a part relative to the size of all the data in the table.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[] | **object**<br><p>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in <a href="https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts/">ClickHouse documentation</a>.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>name | **string**<br><p>Required. Name of the external dictionary.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure | **object**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_structure/).<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>id | **object**<br><p>Single numeric key column for the dictionary.</p> <p>Numeric key.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>id.<br>name | **string**<br><p>Required. Name of the numeric key.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>key | **object**<br><p>Composite key for the dictionary, containing of one or more key columns. For details, see <a href="https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key">ClickHouse documentation</a>.</p> <p>Complex key.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[] | **object**<br><p>Required. Attributes of a complex key.</p> <p>Must contain at least one element.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>name | **string**<br><p>Required. Name of the column.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>type | **string**<br><p>Required. Type of the column.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: `false`.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping &quot;id -&gt; attribute&quot;. Default value: `false`.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>rangeMin | **object**<br><p>Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout. For details, see <a href="https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed">ClickHouse documentation</a>.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>name | **string**<br><p>Required. Name of the column.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>type | **string**<br><p>Required. Type of the column.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: `false`.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping &quot;id -&gt; attribute&quot;. Default value: `false`.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>rangeMax | **object**<br><p>Field holding the end of the range for dictionaries with `RANGE_HASHED` layout. For details, see <a href="https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed">ClickHouse documentation</a>.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>name | **string**<br><p>Required. Name of the column.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>type | **string**<br><p>Required. Type of the column.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: `false`.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping &quot;id -&gt; attribute&quot;. Default value: `false`.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>attributes[] | **object**<br><p>Required. Description of the fields available for database queries. For details, see <a href="https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes">ClickHouse documentation</a>.</p> <p>Must contain at least one element.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>name | **string**<br><p>Required. Name of the column.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>type | **string**<br><p>Required. Type of the column.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: `false`.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping &quot;id -&gt; attribute&quot;. Default value: `false`.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>layout | **object**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_layout/).<br><p>Layout determining how to store the dictionary in memory.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>layout.<br>type | **string**<br><p>Required. Layout type for an external dictionary.</p> <ul> <li>FLAT: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li> <li>HASHED: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li> <li>COMPLEX_KEY_HASHED: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li> <li>RANGE_HASHED: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li> <li>CACHE: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li> <li>COMPLEX_KEY_CACHE: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li> </ul> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>layout.<br>sizeInCells | **string** (int64)<br><p>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>fixedLifetime | **string** (int64) <br>`clusters[].config.clickhouse.config.userConfig.dictionaries[]` includes only one of the fields `fixedLifetime`, `lifetimeRange`<br><br><p>Fixed interval between dictionary updates.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>lifetimeRange | **object**<br>Range of intervals between dictionary updates for ClickHouse to choose from. <br>`clusters[].config.clickhouse.config.userConfig.dictionaries[]` includes only one of the fields `fixedLifetime`, `lifetimeRange`<br><br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>lifetimeRange.<br>min | **string** (int64)<br><p>Minimum dictionary lifetime.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>lifetimeRange.<br>max | **string** (int64)<br><p>Maximum dictionary lifetime.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>httpSource | **object**<br>HTTP source for the dictionary. <br>`clusters[].config.clickhouse.config.userConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br><br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>httpSource.<br>url | **string**<br><p>Required. URL of the source dictionary available over HTTP.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>httpSource.<br>format | **string**<br><p>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mysqlSource | **object**<br>MySQL source for the dictionary. <br>`clusters[].config.clickhouse.config.userConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br><br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mysqlSource.<br>db | **string**<br><p>Required. Name of the MySQL database to connect to.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mysqlSource.<br>table | **string**<br><p>Required. Name of the database table to use as a ClickHouse dictionary.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mysqlSource.<br>port | **string** (int64)<br><p>Default port to use when connecting to a replica of the dictionary source.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mysqlSource.<br>user | **string**<br><p>Name of the default user for replicas of the dictionary source.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mysqlSource.<br>password | **string**<br><p>Password of the default user for replicas of the dictionary source.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[] | **object**<br><p>Required. List of MySQL replicas of the database used as dictionary source.</p> <p>Must contain at least one element.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>host | **string**<br><p>Required. MySQL host of the replica.</p> <p>The maximum string length in characters is 253.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>priority | **string** (int64)<br><p>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number.</p> <p>Value must be greater than 0.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>port | **string** (int64)<br><p>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>user | **string**<br><p>Name of the MySQL database user.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>password | **string**<br><p>Password of the MySQL database user.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mysqlSource.<br>where | **string**<br><p>Selection criteria for the data in the specified MySQL table.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mysqlSource.<br>invalidateQuery | **string**<br><p>Query for checking the dictionary status, to pull only updated data. For more details, see <a href="https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_lifetime/">ClickHouse documentation on dictionaries</a>.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>clickhouseSource | **object**<br>ClickHouse source for the dictionary. <br>`clusters[].config.clickhouse.config.userConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br><br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>clickhouseSource.<br>db | **string**<br><p>Required. Name of the ClickHouse database.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>clickhouseSource.<br>table | **string**<br><p>Required. Name of the table in the specified database to be used as the dictionary source.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>clickhouseSource.<br>host | **string**<br><p>Required. ClickHouse host of the specified database.</p> <p>The maximum string length in characters is 253.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>clickhouseSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>clickhouseSource.<br>user | **string**<br><p>Required. Name of the ClickHouse database user.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>clickhouseSource.<br>password | **string**<br><p>Password of the ClickHouse database user.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>clickhouseSource.<br>where | **string**<br><p>Selection criteria for the data in the specified ClickHouse table.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mongodbSource | **object**<br>MongoDB source for the dictionary. <br>`clusters[].config.clickhouse.config.userConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br><br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mongodbSource.<br>db | **string**<br><p>Required. Name of the MongoDB database.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mongodbSource.<br>collection | **string**<br><p>Required. Name of the collection in the specified database to be used as the dictionary source.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mongodbSource.<br>host | **string**<br><p>Required. MongoDB host of the specified database.</p> <p>The maximum string length in characters is 253.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mongodbSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mongodbSource.<br>user | **string**<br><p>Required. Name of the MongoDB database user.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>mongodbSource.<br>password | **string**<br><p>Password of the MongoDB database user.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>postgresqlSource | **object**<br>PostgreSQL source for the dictionary. <br>`clusters[].config.clickhouse.config.userConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br><br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>postgresqlSource.<br>db | **string**<br><p>Required. Name of the PostrgreSQL database.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>postgresqlSource.<br>table | **string**<br><p>Required. Name of the table in the specified database to be used as the dictionary source.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>postgresqlSource.<br>hosts[] | **string**<br><p>Required. Name of the PostrgreSQL host</p> <p>Must contain at least one element.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>postgresqlSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>postgresqlSource.<br>user | **string**<br><p>Required. Name of the PostrgreSQL database user.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>postgresqlSource.<br>password | **string**<br><p>Password of the PostrgreSQL database user.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>postgresqlSource.<br>invalidateQuery | **string**<br><p>Query for checking the dictionary status, to pull only updated data. For more details, see <a href="https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_lifetime/">ClickHouse documentation on dictionaries</a>.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>dictionaries[].<br>postgresqlSource.<br>sslMode | **string**<br><p>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see <a href="https://www.postgresql.org/docs/current/libpq-ssl.html">PostgreSQL documentation</a>.</p> <ul> <li>DISABLE: Only try a non-SSL connection.</li> <li>ALLOW: First try a non-SSL connection; if that fails, try an SSL connection.</li> <li>PREFER: First try an SSL connection; if that fails, try a non-SSL connection.</li> <li>VERIFY_CA: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li> <li>VERIFY_FULL: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li> </ul> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>graphiteRollup[] | **object**<br><p>Rollup settings for the GraphiteMergeTree table engine.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>graphiteRollup[].<br>name | **string**<br><p>Required. Name for the specified combination of settings for Graphite rollup.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>graphiteRollup[].<br>patterns[] | **object**<br><p>Required. Pattern to use for the rollup.</p> <p>Must contain at least one element.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>graphiteRollup[].<br>patterns[].<br>regexp | **string**<br><p>Pattern for metric names.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>graphiteRollup[].<br>patterns[].<br>function | **string**<br><p>Required. Name of the aggregating function to apply to data of the age specified in `retention`.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>graphiteRollup[].<br>patterns[].<br>retention[] | **object**<br><p>Required. Age of data to use for thinning.</p> <p>Must contain at least one element.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>graphiteRollup[].<br>patterns[].<br>retention[].<br>age | **string** (int64)<br><p>Minimum age of the data in seconds.</p> <p>Value must be greater than 0.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>graphiteRollup[].<br>patterns[].<br>retention[].<br>precision | **string** (int64)<br><p>Precision of determining the age of the data, in seconds.</p> <p>Value must be greater than 0.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>kafka | **object**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>kafka.<br>securityProtocol | **string**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>kafka.<br>saslMechanism | **string**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>kafka.<br>saslUsername | **string**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>kafka.<br>saslPassword | **string**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>kafkaTopics[] | **object**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>kafkaTopics[].<br>name | **string**<br><p>Required.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>kafkaTopics[].<br>settings | **object**<br><p>Required.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>kafkaTopics[].<br>settings.<br>securityProtocol | **string**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>kafkaTopics[].<br>settings.<br>saslMechanism | **string**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>kafkaTopics[].<br>settings.<br>saslUsername | **string**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>kafkaTopics[].<br>settings.<br>saslPassword | **string**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>rabbitmq | **object**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>rabbitmq.<br>username | **string**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>rabbitmq.<br>password | **string**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections.</p> <p>The minimum value is 10.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>maxConcurrentQueries | **integer** (int64)<br><p>Maximum number of simultaneously processed requests.</p> <p>The minimum value is 10.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>keepAliveTimeout | **integer** (int64)<br><p>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>uncompressedCacheSize | **integer** (int64)<br><p>Cache size (in bytes) for uncompressed data used by MergeTree tables.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>markCacheSize | **integer** (int64)<br><p>Approximate size (in bytes) of the cache of &quot;marks&quot; used by MergeTree tables.</p> <p>Value must be greater than 0.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>maxTableSizeToDrop | **integer** (int64)<br><p>Maximum size of the table that can be deleted using a DROP query.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>maxPartitionSizeToDrop | **integer** (int64)<br><p>Maximum size of the partition that can be deleted using a DROP query.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>builtinDictionariesReloadInterval | **integer** (int64)<br><p>The setting is deprecated and has no effect.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>timezone | **string**<br><p>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>geobaseUri | **string**<br><p>Address of the archive with the user geobase in Object Storage.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>queryLogRetentionSize | **integer** (int64)<br><p>The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>queryLogRetentionTime | **integer** (int64)<br><p>The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>queryThreadLogEnabled | **boolean** (boolean)<br><p>Whether query_thread_log system table is enabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>queryThreadLogRetentionSize | **integer** (int64)<br><p>The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>queryThreadLogRetentionTime | **integer** (int64)<br><p>The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>partLogRetentionSize | **integer** (int64)<br><p>The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>partLogRetentionTime | **integer** (int64)<br><p>The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>metricLogEnabled | **boolean** (boolean)<br><p>Whether metric_log system table is enabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>metricLogRetentionSize | **integer** (int64)<br><p>The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>metricLogRetentionTime | **integer** (int64)<br><p>The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>traceLogEnabled | **boolean** (boolean)<br><p>Whether trace_log system table is enabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>traceLogRetentionSize | **integer** (int64)<br><p>The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>traceLogRetentionTime | **integer** (int64)<br><p>The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>textLogEnabled | **boolean** (boolean)<br><p>Whether text_log system table is enabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>textLogRetentionSize | **integer** (int64)<br><p>The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>textLogRetentionTime | **integer** (int64)<br><p>The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>textLogLevel | **string**<br><p>Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>backgroundPoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>userConfig.<br>backgroundSchedulePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig | **object**<br><p>Default configuration for a ClickHouse cluster.</p> <p>ClickHouse configuration options. Detailed description for each set of options is available in <a href="https://clickhouse.yandex/docs/en/operations/server_settings/settings/">ClickHouse documentation</a>.</p> <p>Any options not listed here are not supported.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>logLevel | **string**<br><p>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree | **object**<br><p>Settings for the MergeTree engine. See description in <a href="https://clickhouse.yandex/docs/en/operations/server_settings/settings/#merge_tree">ClickHouse documentation</a>.</p> <p>Options specific to the MergeTree table engine.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>replicatedDeduplicationWindow | **integer** (int64)<br><p>Number of blocks of hashes to keep in ZooKeeper.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>replicatedDeduplicationWindowSeconds | **integer** (int64)<br><p>Period of time to keep blocks of hashes for.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>partsToDelayInsert | **integer** (int64)<br><p>If table contains at least that many active parts in single partition, artificially slow down insert into table.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>partsToThrowInsert | **integer** (int64)<br><p>If more than this number active parts in single partition, throw 'Too many parts ...' exception.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>maxReplicatedMergesInQueue | **integer** (int64)<br><p>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>numberOfFreeEntriesInPoolToLowerMaxSizeOfMerge | **integer** (int64)<br><p>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>mergeTree.<br>maxBytesToMergeAtMinSpaceInPool | **integer** (int64)<br><p>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue).</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>compression[] | **object**<br><p>Compression settings for the ClickHouse cluster. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/server_settings/settings/#compression">ClickHouse documentation</a>.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>compression[].<br>method | **string**<br><p>Compression method to use for the specified combination of `min_part_size` and `min_part_size_ratio`.</p> <ul> <li>LZ4: <a href="https://lz4.github.io/lz4/">LZ4 compression algorithm</a>.</li> <li>ZSTD: <a href="https://facebook.github.io/zstd/">Zstandard compression algorithm</a>.</li> </ul> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>compression[].<br>minPartSize | **string** (int64)<br><p>Minimum size of a part of a table.</p> <p>The minimum value is 1.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>compression[].<br>minPartSizeRatio | **number** (double)<br><p>Minimum ratio of a part relative to the size of all the data in the table.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[] | **object**<br><p>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in <a href="https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts/">ClickHouse documentation</a>.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>name | **string**<br><p>Required. Name of the external dictionary.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure | **object**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_structure/).<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>id | **object**<br><p>Single numeric key column for the dictionary.</p> <p>Numeric key.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>id.<br>name | **string**<br><p>Required. Name of the numeric key.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>key | **object**<br><p>Composite key for the dictionary, containing of one or more key columns. For details, see <a href="https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key">ClickHouse documentation</a>.</p> <p>Complex key.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[] | **object**<br><p>Required. Attributes of a complex key.</p> <p>Must contain at least one element.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>name | **string**<br><p>Required. Name of the column.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>type | **string**<br><p>Required. Type of the column.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: `false`.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping &quot;id -&gt; attribute&quot;. Default value: `false`.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>rangeMin | **object**<br><p>Field holding the beginning of the range for dictionaries with `RANGE_HASHED` layout. For details, see <a href="https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed">ClickHouse documentation</a>.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>name | **string**<br><p>Required. Name of the column.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>type | **string**<br><p>Required. Type of the column.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: `false`.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>rangeMin.<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping &quot;id -&gt; attribute&quot;. Default value: `false`.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>rangeMax | **object**<br><p>Field holding the end of the range for dictionaries with `RANGE_HASHED` layout. For details, see <a href="https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed">ClickHouse documentation</a>.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>name | **string**<br><p>Required. Name of the column.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>type | **string**<br><p>Required. Type of the column.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: `false`.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>rangeMax.<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping &quot;id -&gt; attribute&quot;. Default value: `false`.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>attributes[] | **object**<br><p>Required. Description of the fields available for database queries. For details, see <a href="https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes">ClickHouse documentation</a>.</p> <p>Must contain at least one element.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>name | **string**<br><p>Required. Name of the column.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>type | **string**<br><p>Required. Type of the column.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: `false`.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>structure.<br>attributes[].<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping &quot;id -&gt; attribute&quot;. Default value: `false`.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>layout | **object**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_layout/).<br><p>Layout determining how to store the dictionary in memory.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>layout.<br>type | **string**<br><p>Required. Layout type for an external dictionary.</p> <ul> <li>FLAT: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li> <li>HASHED: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li> <li>COMPLEX_KEY_HASHED: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li> <li>RANGE_HASHED: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li> <li>CACHE: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li> <li>COMPLEX_KEY_CACHE: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li> </ul> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>layout.<br>sizeInCells | **string** (int64)<br><p>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>fixedLifetime | **string** (int64) <br>`clusters[].config.clickhouse.config.defaultConfig.dictionaries[]` includes only one of the fields `fixedLifetime`, `lifetimeRange`<br><br><p>Fixed interval between dictionary updates.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>lifetimeRange | **object**<br>Range of intervals between dictionary updates for ClickHouse to choose from. <br>`clusters[].config.clickhouse.config.defaultConfig.dictionaries[]` includes only one of the fields `fixedLifetime`, `lifetimeRange`<br><br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>lifetimeRange.<br>min | **string** (int64)<br><p>Minimum dictionary lifetime.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>lifetimeRange.<br>max | **string** (int64)<br><p>Maximum dictionary lifetime.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>httpSource | **object**<br>HTTP source for the dictionary. <br>`clusters[].config.clickhouse.config.defaultConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br><br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>httpSource.<br>url | **string**<br><p>Required. URL of the source dictionary available over HTTP.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>httpSource.<br>format | **string**<br><p>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mysqlSource | **object**<br>MySQL source for the dictionary. <br>`clusters[].config.clickhouse.config.defaultConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br><br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mysqlSource.<br>db | **string**<br><p>Required. Name of the MySQL database to connect to.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mysqlSource.<br>table | **string**<br><p>Required. Name of the database table to use as a ClickHouse dictionary.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mysqlSource.<br>port | **string** (int64)<br><p>Default port to use when connecting to a replica of the dictionary source.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mysqlSource.<br>user | **string**<br><p>Name of the default user for replicas of the dictionary source.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mysqlSource.<br>password | **string**<br><p>Password of the default user for replicas of the dictionary source.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[] | **object**<br><p>Required. List of MySQL replicas of the database used as dictionary source.</p> <p>Must contain at least one element.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>host | **string**<br><p>Required. MySQL host of the replica.</p> <p>The maximum string length in characters is 253.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>priority | **string** (int64)<br><p>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number.</p> <p>Value must be greater than 0.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>port | **string** (int64)<br><p>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>user | **string**<br><p>Name of the MySQL database user.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>password | **string**<br><p>Password of the MySQL database user.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mysqlSource.<br>where | **string**<br><p>Selection criteria for the data in the specified MySQL table.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mysqlSource.<br>invalidateQuery | **string**<br><p>Query for checking the dictionary status, to pull only updated data. For more details, see <a href="https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_lifetime/">ClickHouse documentation on dictionaries</a>.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>clickhouseSource | **object**<br>ClickHouse source for the dictionary. <br>`clusters[].config.clickhouse.config.defaultConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br><br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>clickhouseSource.<br>db | **string**<br><p>Required. Name of the ClickHouse database.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>clickhouseSource.<br>table | **string**<br><p>Required. Name of the table in the specified database to be used as the dictionary source.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>clickhouseSource.<br>host | **string**<br><p>Required. ClickHouse host of the specified database.</p> <p>The maximum string length in characters is 253.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>clickhouseSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>clickhouseSource.<br>user | **string**<br><p>Required. Name of the ClickHouse database user.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>clickhouseSource.<br>password | **string**<br><p>Password of the ClickHouse database user.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>clickhouseSource.<br>where | **string**<br><p>Selection criteria for the data in the specified ClickHouse table.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mongodbSource | **object**<br>MongoDB source for the dictionary. <br>`clusters[].config.clickhouse.config.defaultConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br><br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mongodbSource.<br>db | **string**<br><p>Required. Name of the MongoDB database.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mongodbSource.<br>collection | **string**<br><p>Required. Name of the collection in the specified database to be used as the dictionary source.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mongodbSource.<br>host | **string**<br><p>Required. MongoDB host of the specified database.</p> <p>The maximum string length in characters is 253.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mongodbSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mongodbSource.<br>user | **string**<br><p>Required. Name of the MongoDB database user.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>mongodbSource.<br>password | **string**<br><p>Password of the MongoDB database user.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>postgresqlSource | **object**<br>PostgreSQL source for the dictionary. <br>`clusters[].config.clickhouse.config.defaultConfig.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br><br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>postgresqlSource.<br>db | **string**<br><p>Required. Name of the PostrgreSQL database.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>postgresqlSource.<br>table | **string**<br><p>Required. Name of the table in the specified database to be used as the dictionary source.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>postgresqlSource.<br>hosts[] | **string**<br><p>Required. Name of the PostrgreSQL host</p> <p>Must contain at least one element.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>postgresqlSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>postgresqlSource.<br>user | **string**<br><p>Required. Name of the PostrgreSQL database user.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>postgresqlSource.<br>password | **string**<br><p>Password of the PostrgreSQL database user.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>postgresqlSource.<br>invalidateQuery | **string**<br><p>Query for checking the dictionary status, to pull only updated data. For more details, see <a href="https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_lifetime/">ClickHouse documentation on dictionaries</a>.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>dictionaries[].<br>postgresqlSource.<br>sslMode | **string**<br><p>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see <a href="https://www.postgresql.org/docs/current/libpq-ssl.html">PostgreSQL documentation</a>.</p> <ul> <li>DISABLE: Only try a non-SSL connection.</li> <li>ALLOW: First try a non-SSL connection; if that fails, try an SSL connection.</li> <li>PREFER: First try an SSL connection; if that fails, try a non-SSL connection.</li> <li>VERIFY_CA: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li> <li>VERIFY_FULL: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li> </ul> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>graphiteRollup[] | **object**<br><p>Rollup settings for the GraphiteMergeTree table engine.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>graphiteRollup[].<br>name | **string**<br><p>Required. Name for the specified combination of settings for Graphite rollup.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>graphiteRollup[].<br>patterns[] | **object**<br><p>Required. Pattern to use for the rollup.</p> <p>Must contain at least one element.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>graphiteRollup[].<br>patterns[].<br>regexp | **string**<br><p>Pattern for metric names.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>graphiteRollup[].<br>patterns[].<br>function | **string**<br><p>Required. Name of the aggregating function to apply to data of the age specified in `retention`.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>graphiteRollup[].<br>patterns[].<br>retention[] | **object**<br><p>Required. Age of data to use for thinning.</p> <p>Must contain at least one element.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>graphiteRollup[].<br>patterns[].<br>retention[].<br>age | **string** (int64)<br><p>Minimum age of the data in seconds.</p> <p>Value must be greater than 0.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>graphiteRollup[].<br>patterns[].<br>retention[].<br>precision | **string** (int64)<br><p>Precision of determining the age of the data, in seconds.</p> <p>Value must be greater than 0.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafka | **object**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafka.<br>securityProtocol | **string**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafka.<br>saslMechanism | **string**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafka.<br>saslUsername | **string**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafka.<br>saslPassword | **string**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafkaTopics[] | **object**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafkaTopics[].<br>name | **string**<br><p>Required.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafkaTopics[].<br>settings | **object**<br><p>Required.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafkaTopics[].<br>settings.<br>securityProtocol | **string**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafkaTopics[].<br>settings.<br>saslMechanism | **string**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafkaTopics[].<br>settings.<br>saslUsername | **string**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>kafkaTopics[].<br>settings.<br>saslPassword | **string**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>rabbitmq | **object**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>rabbitmq.<br>username | **string**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>rabbitmq.<br>password | **string**<br>
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections.</p> <p>The minimum value is 10.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>maxConcurrentQueries | **integer** (int64)<br><p>Maximum number of simultaneously processed requests.</p> <p>The minimum value is 10.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>keepAliveTimeout | **integer** (int64)<br><p>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>uncompressedCacheSize | **integer** (int64)<br><p>Cache size (in bytes) for uncompressed data used by MergeTree tables.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>markCacheSize | **integer** (int64)<br><p>Approximate size (in bytes) of the cache of &quot;marks&quot; used by MergeTree tables.</p> <p>Value must be greater than 0.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>maxTableSizeToDrop | **integer** (int64)<br><p>Maximum size of the table that can be deleted using a DROP query.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>maxPartitionSizeToDrop | **integer** (int64)<br><p>Maximum size of the partition that can be deleted using a DROP query.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>builtinDictionariesReloadInterval | **integer** (int64)<br><p>The setting is deprecated and has no effect.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>timezone | **string**<br><p>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>geobaseUri | **string**<br><p>Address of the archive with the user geobase in Object Storage.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>queryLogRetentionSize | **integer** (int64)<br><p>The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>queryLogRetentionTime | **integer** (int64)<br><p>The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>queryThreadLogEnabled | **boolean** (boolean)<br><p>Whether query_thread_log system table is enabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>queryThreadLogRetentionSize | **integer** (int64)<br><p>The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>queryThreadLogRetentionTime | **integer** (int64)<br><p>The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>partLogRetentionSize | **integer** (int64)<br><p>The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>partLogRetentionTime | **integer** (int64)<br><p>The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>metricLogEnabled | **boolean** (boolean)<br><p>Whether metric_log system table is enabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>metricLogRetentionSize | **integer** (int64)<br><p>The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>metricLogRetentionTime | **integer** (int64)<br><p>The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>traceLogEnabled | **boolean** (boolean)<br><p>Whether trace_log system table is enabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>traceLogRetentionSize | **integer** (int64)<br><p>The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>traceLogRetentionTime | **integer** (int64)<br><p>The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>textLogEnabled | **boolean** (boolean)<br><p>Whether text_log system table is enabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>textLogRetentionSize | **integer** (int64)<br><p>The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>textLogRetentionTime | **integer** (int64)<br><p>The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>textLogLevel | **string**<br><p>Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>backgroundPoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
clusters[].<br>config.<br>clickhouse.<br>config.<br>defaultConfig.<br>backgroundSchedulePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
clusters[].<br>config.<br>clickhouse.<br>resources | **object**<br><p>Resources allocated to ClickHouse hosts.</p> 
clusters[].<br>config.<br>clickhouse.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-clickhouse/concepts/instance-types">documentation</a></p> 
clusters[].<br>config.<br>clickhouse.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
clusters[].<br>config.<br>clickhouse.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd — network HDD drive,</li> <li>network-ssd — network SSD drive,</li> <li>local-ssd — local SSD storage.</li> </ul> 
clusters[].<br>config.<br>zookeeper | **object**<br><p>Configuration and resource allocation for ZooKeeper hosts.</p> 
clusters[].<br>config.<br>zookeeper.<br>resources | **object**<br><p>Resources allocated to ZooKeeper hosts.</p> 
clusters[].<br>config.<br>zookeeper.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-clickhouse/concepts/instance-types">documentation</a></p> 
clusters[].<br>config.<br>zookeeper.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
clusters[].<br>config.<br>zookeeper.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd — network HDD drive,</li> <li>network-ssd — network SSD drive,</li> <li>local-ssd — local SSD storage.</li> </ul> 
clusters[].<br>config.<br>backupWindowStart | **object**<br><p>Time to start the daily backup, in the UTC timezone.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value &quot;24:00:00&quot; for scenarios like business closing time.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
clusters[].<br>config.<br>access | **object**<br><p>Access policy for external services.</p> 
clusters[].<br>config.<br>access.<br>dataLens | **boolean** (boolean)<br><p>Allow to export data from the cluster to Yandex DataLens.</p> 
clusters[].<br>config.<br>access.<br>webSql | **boolean** (boolean)<br><p>Allow SQL queries to the cluster databases from the Yandex.Cloud management console.</p> <p>See <a href="/docs/managed-clickhouse/operations/web-sql-query">SQL queries in the management console</a> for more details.</p> 
clusters[].<br>config.<br>access.<br>metrika | **boolean** (boolean)<br><p>Allow to import data from Yandex.Metrica and AppMetrica to the cluster.</p> <p>See <a href="https://appmetrica.yandex.com/docs/cloud/index.html">Export data to Yandex.Cloud</a> for more details.</p> 
clusters[].<br>config.<br>access.<br>serverless | **boolean** (boolean)<br><p>Allow access to cluster for Serverless.</p> 
clusters[].<br>config.<br>cloudStorage | **object**<br>
clusters[].<br>config.<br>cloudStorage.<br>enabled | **boolean** (boolean)<br><p>Whether to use Yandex Object Storage for storing ClickHouse data.</p> 
clusters[].<br>config.<br>sqlDatabaseManagement | **boolean** (boolean)<br><p>Whether database management through SQL commands is enabled.</p> 
clusters[].<br>config.<br>sqlUserManagement | **boolean** (boolean)<br><p>Whether user management through SQL commands is enabled.</p> 
clusters[].<br>networkId | **string**<br><p>ID of the network that the cluster belongs to.</p> 
clusters[].<br>health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: State of the cluster is unknown (`health` for every host in the cluster is UNKNOWN).</li> <li>ALIVE: Cluster is alive and well (`health` for every host in the cluster is ALIVE).</li> <li>DEAD: Cluster is inoperable (`health` for every host in the cluster is DEAD).</li> <li>DEGRADED: Cluster is working below capacity (`health` for at least one host in the cluster is not ALIVE).</li> </ul> 
clusters[].<br>status | **string**<br><p>Current state of the cluster.</p> <ul> <li>STATUS_UNKNOWN: Cluster state is unknown.</li> <li>CREATING: Cluster is being created.</li> <li>RUNNING: Cluster is running normally.</li> <li>ERROR: Cluster encountered a problem and cannot operate.</li> <li>UPDATING: Cluster is being updated.</li> <li>STOPPING: Cluster is stopping.</li> <li>STOPPED: Cluster stopped.</li> <li>STARTING: Cluster is starting.</li> </ul> 
clusters[].<br>serviceAccountId | **string**<br><p>ID of the service account used for access to Yandex Object Storage.</p> 
clusters[].<br>maintenanceWindow | **object**<br><p>Window of maintenance operations.</p> 
clusters[].<br>maintenanceWindow.<br>anytime | **object** <br>`clusters[].maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br><br>
clusters[].<br>maintenanceWindow.<br>weeklyMaintenanceWindow | **object** <br>`clusters[].maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br><br>
clusters[].<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>day | **string**<br>
clusters[].<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>hour | **string** (int64)<br><p>Hour of the day in UTC.</p> <p>Acceptable values are 1 to 24, inclusive.</p> 
clusters[].<br>plannedOperation | **object**<br><p>Maintenance operation planned at nearest maintenance_window.</p> 
clusters[].<br>plannedOperation.<br>info | **string**<br><p>The maximum string length in characters is 256.</p> 
clusters[].<br>plannedOperation.<br>delayedUntil | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
clusters[].<br>securityGroupIds[] | **string**<br><p>User security groups</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-clickhouse/api-ref/Cluster/list#query_params">pageSize</a>, use the <a href="/docs/managed-clickhouse/api-ref/Cluster/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-clickhouse/api-ref/Cluster/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-clickhouse/api-ref/Cluster/list#responses">nextPageToken</a> to continue paging through the results.</p> 