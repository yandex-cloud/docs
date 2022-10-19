---
editable: false
---

# Method create
Creates a ClickHouse cluster in the specified folder.
 

 
## HTTP request {#https-request}
```
POST https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "environment": "string",
  "configSpec": {
    "version": "string",
    "clickhouse": {
      "config": {
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
          "allowRemoteFsZeroCopyReplication": true
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

            // `configSpec.clickhouse.config.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`
            "fixedLifetime": "string",
            "lifetimeRange": {
              "min": "string",
              "max": "string"
            },
            // end of the list of possible fields`configSpec.clickhouse.config.dictionaries[]`

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
        "defaultDatabase": "string",
        "totalMemoryProfilerStep": "integer",
        "totalMemoryTrackerSampleProbability": "number"
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
      "serverless": true,
      "dataTransfer": true,
      "yandexQuery": true
    },
    "cloudStorage": {
      "enabled": true,
      "moveFactor": "number",
      "dataCacheEnabled": true,
      "dataCacheMaxSize": "integer"
    },
    "sqlDatabaseManagement": true,
    "sqlUserManagement": true,
    "adminPassword": "string",
    "embeddedKeeper": true
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
        "readonly": "integer",
        "allowDdl": true,
        "allowIntrospectionFunctions": true,
        "connectTimeout": "integer",
        "connectTimeoutWithFailover": "integer",
        "receiveTimeout": "integer",
        "sendTimeout": "integer",
        "timeoutBeforeCheckingExecutionSpeed": "integer",
        "insertQuorum": "integer",
        "insertQuorumTimeout": "integer",
        "insertQuorumParallel": true,
        "insertNullAsDefault": true,
        "selectSequentialConsistency": true,
        "deduplicateBlocksInDependentMaterializedViews": true,
        "replicationAlterPartitionsSync": "integer",
        "maxReplicaDelayForDistributedQueries": "integer",
        "fallbackToStaleReplicasForDistributedQueries": true,
        "distributedProductMode": "string",
        "distributedAggregationMemoryEfficient": true,
        "distributedDdlTaskTimeout": "integer",
        "skipUnavailableShards": true,
        "compileExpressions": true,
        "minCountToCompileExpression": "integer",
        "maxBlockSize": "integer",
        "minInsertBlockSizeRows": "integer",
        "minInsertBlockSizeBytes": "integer",
        "maxInsertBlockSize": "integer",
        "minBytesToUseDirectIo": "integer",
        "useUncompressedCache": true,
        "mergeTreeMaxRowsToUseCache": "integer",
        "mergeTreeMaxBytesToUseCache": "integer",
        "mergeTreeMinRowsForConcurrentRead": "integer",
        "mergeTreeMinBytesForConcurrentRead": "integer",
        "maxBytesBeforeExternalGroupBy": "integer",
        "maxBytesBeforeExternalSort": "integer",
        "groupByTwoLevelThreshold": "integer",
        "groupByTwoLevelThresholdBytes": "integer",
        "priority": "integer",
        "maxThreads": "integer",
        "maxMemoryUsage": "integer",
        "maxMemoryUsageForUser": "integer",
        "maxNetworkBandwidth": "integer",
        "maxNetworkBandwidthForUser": "integer",
        "maxPartitionsPerInsertBlock": "integer",
        "maxConcurrentQueriesForUser": "integer",
        "forceIndexByDate": true,
        "forcePrimaryKey": true,
        "maxRowsToRead": "integer",
        "maxBytesToRead": "integer",
        "readOverflowMode": "string",
        "maxRowsToGroupBy": "integer",
        "groupByOverflowMode": "string",
        "maxRowsToSort": "integer",
        "maxBytesToSort": "integer",
        "sortOverflowMode": "string",
        "maxResultRows": "integer",
        "maxResultBytes": "integer",
        "resultOverflowMode": "string",
        "maxRowsInDistinct": "integer",
        "maxBytesInDistinct": "integer",
        "distinctOverflowMode": "string",
        "maxRowsToTransfer": "integer",
        "maxBytesToTransfer": "integer",
        "transferOverflowMode": "string",
        "maxExecutionTime": "integer",
        "timeoutOverflowMode": "string",
        "maxRowsInSet": "integer",
        "maxBytesInSet": "integer",
        "setOverflowMode": "string",
        "maxRowsInJoin": "integer",
        "maxBytesInJoin": "integer",
        "joinOverflowMode": "string",
        "joinAlgorithm": [
          "string"
        ],
        "anyJoinDistinctRightTableKeys": true,
        "maxColumnsToRead": "integer",
        "maxTemporaryColumns": "integer",
        "maxTemporaryNonConstColumns": "integer",
        "maxQuerySize": "integer",
        "maxAstDepth": "integer",
        "maxAstElements": "integer",
        "maxExpandedAstElements": "integer",
        "minExecutionSpeed": "integer",
        "minExecutionSpeedBytes": "integer",
        "countDistinctImplementation": "string",
        "inputFormatValuesInterpretExpressions": true,
        "inputFormatDefaultsForOmittedFields": true,
        "inputFormatNullAsDefault": true,
        "dateTimeInputFormat": "string",
        "inputFormatWithNamesUseHeader": true,
        "outputFormatJsonQuote_64BitIntegers": true,
        "outputFormatJsonQuoteDenormals": true,
        "dateTimeOutputFormat": "string",
        "lowCardinalityAllowInNativeFormat": true,
        "allowSuspiciousLowCardinalityTypes": true,
        "emptyResultForAggregationByEmptySet": true,
        "httpConnectionTimeout": "integer",
        "httpReceiveTimeout": "integer",
        "httpSendTimeout": "integer",
        "enableHttpCompression": true,
        "sendProgressInHttpHeaders": true,
        "httpHeadersProgressInterval": "integer",
        "addHttpCorsHeader": true,
        "cancelHttpReadonlyQueriesOnClientClose": true,
        "maxHttpGetRedirects": "integer",
        "joinedSubqueryRequiresAlias": true,
        "joinUseNulls": true,
        "transformNullIn": true,
        "quotaMode": "string",
        "flattenNested": true,
        "formatRegexp": "string",
        "formatRegexpEscapingRule": "string",
        "formatRegexpSkipUnmatched": true,
        "asyncInsert": true,
        "asyncInsertThreads": "integer",
        "waitForAsyncInsert": true,
        "waitForAsyncInsertTimeout": "integer",
        "asyncInsertMaxDataSize": "integer",
        "asyncInsertBusyTimeout": "integer",
        "asyncInsertStaleTimeout": "integer",
        "memoryProfilerStep": "integer",
        "memoryProfilerSampleProbability": "number",
        "compile": true,
        "minCountToCompile": "integer"
      },
      "quotas": [
        {
          "intervalDuration": "integer",
          "queries": "integer",
          "errors": "integer",
          "resultRows": "integer",
          "readRows": "integer",
          "executionTime": "integer"
        }
      ]
    }
  ],
  "hostSpecs": [
    {
      "zoneId": "string",
      "type": "string",
      "subnetId": "string",
      "assignPublicIp": true,
      "shardName": "string"
    }
  ],
  "networkId": "string",
  "shardName": "string",
  "serviceAccountId": "string",
  "securityGroupIds": [
    "string"
  ],
  "deletionProtection": true
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder to create the ClickHouse cluster in.</p> <p>The maximum string length in characters is 50.</p> 
name | **string**<br><p>Required. Name of the ClickHouse cluster. The name must be unique within the folder.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
description | **string**<br><p>Description of the ClickHouse cluster.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Custom labels for the ClickHouse cluster as ``key:value`` pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary".</p> <p>No more than 64 per resource. The maximum string length in characters for each key is 63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
environment | **string**<br><p>Required. Deployment environment of the ClickHouse cluster.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
configSpec | **object**<br><p>Required. Configuration and resources for hosts that should be created for the ClickHouse cluster.</p> 
configSpec.<br>version | **string**<br><p>Version of the ClickHouse server software.</p> 
configSpec.<br>clickhouse | **object**<br><p>Configuration and resources for a ClickHouse server.</p> 
configSpec.<br>clickhouse.<br>config | **object**<br><p>Configuration for a ClickHouse server.</p> <p>ClickHouse configuration options. Detailed description for each set of options is available in <a href="https://clickhouse.com/docs/en/operations/server_settings/settings/">ClickHouse documentation</a>.</p> <p>Any options not listed here are not supported.</p> 
configSpec.<br>clickhouse.<br>config.<br>logLevel | **string**<br><p>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.</p> 
configSpec.<br>clickhouse.<br>config.<br>mergeTree | **object**<br><p>Settings for the MergeTree engine. See description in <a href="https://clickhouse.com/docs/en/operations/server_settings/settings/#merge_tree">ClickHouse documentation</a>.</p> <p>Options specific to the MergeTree table engine.</p> 
configSpec.<br>clickhouse.<br>config.<br>mergeTree.<br>replicatedDeduplicationWindow | **integer** (int64)<br><p>Number of blocks of hashes to keep in ZooKeeper.</p> 
configSpec.<br>clickhouse.<br>config.<br>mergeTree.<br>replicatedDeduplicationWindowSeconds | **integer** (int64)<br><p>Period of time to keep blocks of hashes for.</p> 
configSpec.<br>clickhouse.<br>config.<br>mergeTree.<br>partsToDelayInsert | **integer** (int64)<br><p>If table contains at least that many active parts in single partition, artificially slow down insert into table.</p> 
configSpec.<br>clickhouse.<br>config.<br>mergeTree.<br>partsToThrowInsert | **integer** (int64)<br><p>If more than this number active parts in single partition, throw 'Too many parts ...' exception.</p> 
configSpec.<br>clickhouse.<br>config.<br>mergeTree.<br>inactivePartsToDelayInsert | **integer** (int64)
configSpec.<br>clickhouse.<br>config.<br>mergeTree.<br>inactivePartsToThrowInsert | **integer** (int64)
configSpec.<br>clickhouse.<br>config.<br>mergeTree.<br>maxReplicatedMergesInQueue | **integer** (int64)<br><p>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue.</p> 
configSpec.<br>clickhouse.<br>config.<br>mergeTree.<br>numberOfFreeEntriesInPoolToLowerMaxSizeOfMerge | **integer** (int64)<br><p>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process.</p> 
configSpec.<br>clickhouse.<br>config.<br>mergeTree.<br>maxBytesToMergeAtMinSpaceInPool | **integer** (int64)<br><p>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue).</p> 
configSpec.<br>clickhouse.<br>config.<br>mergeTree.<br>maxBytesToMergeAtMaxSpaceInPool | **integer** (int64)
configSpec.<br>clickhouse.<br>config.<br>mergeTree.<br>minBytesForWidePart | **integer** (int64)<br><p>Minimum number of bytes in a data part that can be stored in <strong>Wide</strong> format.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part">ClickHouse documentation</a>.</p> 
configSpec.<br>clickhouse.<br>config.<br>mergeTree.<br>minRowsForWidePart | **integer** (int64)<br><p>Minimum number of rows in a data part that can be stored in <strong>Wide</strong> format.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree/#min_bytes_for_wide_part">ClickHouse documentation</a>.</p> 
configSpec.<br>clickhouse.<br>config.<br>mergeTree.<br>ttlOnlyDropParts | **boolean** (boolean)<br><p>Enables or disables complete dropping of data parts where all rows are expired in MergeTree tables.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#ttl_only_drop_parts">ClickHouse documentation</a>.</p> 
configSpec.<br>clickhouse.<br>config.<br>mergeTree.<br>allowRemoteFsZeroCopyReplication | **boolean** (boolean)
configSpec.<br>clickhouse.<br>config.<br>compression[] | **object**<br><p>Compression settings for the ClickHouse cluster. See in-depth description in <a href="https://clickhouse.com/docs/en/operations/server_settings/settings/#compression">ClickHouse documentation</a>.</p> 
configSpec.<br>clickhouse.<br>config.<br>compression[].<br>method | **string**<br><p>Compression method to use for the specified combination of ``minPartSize`` and ``minPartSizeRatio``.</p> <ul> <li>LZ4: <a href="https://lz4.github.io/lz4/">LZ4 compression algorithm</a>.</li> <li>ZSTD: <a href="https://facebook.github.io/zstd/">Zstandard compression algorithm</a>.</li> </ul> 
configSpec.<br>clickhouse.<br>config.<br>compression[].<br>minPartSize | **string** (int64)<br><p>Minimum size of a part of a table.</p> <p>The minimum value is 1.</p> 
configSpec.<br>clickhouse.<br>config.<br>compression[].<br>minPartSizeRatio | **number** (double)<br><p>Minimum ratio of a part relative to the size of all the data in the table.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[] | **object**<br><p>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts/">ClickHouse documentation</a>.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>name | **string**<br><p>Required. Name of the external dictionary.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure | **object**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/).
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>id | **object**<br><p>Single numeric key column for the dictionary.</p> <p>Numeric key.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>id.<br>name | **string**<br><p>Required. Name of the numeric key.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>key | **object**<br><p>Composite key for the dictionary, containing of one or more key columns. For details, see <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key">ClickHouse documentation</a>.</p> <p>Complex key.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>key.<br>attributes[] | **object**<br><p>Required. Attributes of a complex key.</p> <p>Must contain at least one element.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>name | **string**<br><p>Required. Name of the column.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>type | **string**<br><p>Required. Type of the column.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: ``false``.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping "id -&gt; attribute". Default value: ``false``.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMin | **object**<br><p>Field holding the beginning of the range for dictionaries with ``RANGE_HASHED`` layout. For details, see <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed">ClickHouse documentation</a>.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMin.<br>name | **string**<br><p>Required. Name of the column.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMin.<br>type | **string**<br><p>Required. Type of the column.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMin.<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMin.<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMin.<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: ``false``.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMin.<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping "id -&gt; attribute". Default value: ``false``.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMax | **object**<br><p>Field holding the end of the range for dictionaries with ``RANGE_HASHED`` layout. For details, see <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed">ClickHouse documentation</a>.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMax.<br>name | **string**<br><p>Required. Name of the column.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMax.<br>type | **string**<br><p>Required. Type of the column.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMax.<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMax.<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMax.<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: ``false``.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMax.<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping "id -&gt; attribute". Default value: ``false``.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>attributes[] | **object**<br><p>Required. Description of the fields available for database queries. For details, see <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes">ClickHouse documentation</a>.</p> <p>Must contain at least one element.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>attributes[].<br>name | **string**<br><p>Required. Name of the column.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>attributes[].<br>type | **string**<br><p>Required. Type of the column.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>attributes[].<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>attributes[].<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>attributes[].<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: ``false``.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>attributes[].<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping "id -&gt; attribute". Default value: ``false``.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>layout | **object**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/).
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>layout.<br>type | **string**<br><p>Required. Layout type for an external dictionary.</p> <ul> <li>FLAT: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li> <li>HASHED: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li> <li>COMPLEX_KEY_HASHED: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li> <li>RANGE_HASHED: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li> <li>CACHE: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li> <li>COMPLEX_KEY_CACHE: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li> </ul> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>layout.<br>sizeInCells | **string** (int64)<br><p>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>fixedLifetime | **string** (int64) <br>`configSpec.clickhouse.config.dictionaries[]` includes only one of the fields `fixedLifetime`, `lifetimeRange`<br><br><p>Fixed interval between dictionary updates.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>lifetimeRange | **object**<br>Range of intervals between dictionary updates for ClickHouse to choose from. <br>`configSpec.clickhouse.config.dictionaries[]` includes only one of the fields `fixedLifetime`, `lifetimeRange`<br>
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>lifetimeRange.<br>min | **string** (int64)<br><p>Minimum dictionary lifetime.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>lifetimeRange.<br>max | **string** (int64)<br><p>Maximum dictionary lifetime.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>httpSource | **object**<br>HTTP source for the dictionary. <br>`configSpec.clickhouse.config.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>httpSource.<br>url | **string**<br><p>Required. URL of the source dictionary available over HTTP.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>httpSource.<br>format | **string**<br><p>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mysqlSource | **object**<br>MySQL source for the dictionary. <br>`configSpec.clickhouse.config.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mysqlSource.<br>db | **string**<br><p>Required. Name of the MySQL database to connect to.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mysqlSource.<br>table | **string**<br><p>Required. Name of the database table to use as a ClickHouse dictionary.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mysqlSource.<br>port | **string** (int64)<br><p>Default port to use when connecting to a replica of the dictionary source.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mysqlSource.<br>user | **string**<br><p>Name of the default user for replicas of the dictionary source.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mysqlSource.<br>password | **string**<br><p>Password of the default user for replicas of the dictionary source.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mysqlSource.<br>replicas[] | **object**<br><p>Required. List of MySQL replicas of the database used as dictionary source.</p> <p>Must contain at least one element.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>host | **string**<br><p>Required. MySQL host of the replica.</p> <p>The maximum string length in characters is 253.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>priority | **string** (int64)<br><p>Required. The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>port | **string** (int64)<br><p>Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>user | **string**<br><p>Name of the MySQL database user.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>password | **string**<br><p>Password of the MySQL database user.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mysqlSource.<br>where | **string**<br><p>Selection criteria for the data in the specified MySQL table.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mysqlSource.<br>invalidateQuery | **string**<br><p>Query for checking the dictionary status, to pull only updated data. For more details, see <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/">ClickHouse documentation on dictionaries</a>.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>clickhouseSource | **object**<br>ClickHouse source for the dictionary. <br>`configSpec.clickhouse.config.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>clickhouseSource.<br>db | **string**<br><p>Required. Name of the ClickHouse database.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>clickhouseSource.<br>table | **string**<br><p>Required. Name of the table in the specified database to be used as the dictionary source.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>clickhouseSource.<br>host | **string**<br><p>Required. ClickHouse host of the specified database.</p> <p>The maximum string length in characters is 253.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>clickhouseSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>clickhouseSource.<br>user | **string**<br><p>Required. Name of the ClickHouse database user.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>clickhouseSource.<br>password | **string**<br><p>Password of the ClickHouse database user.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>clickhouseSource.<br>where | **string**<br><p>Selection criteria for the data in the specified ClickHouse table.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mongodbSource | **object**<br>MongoDB source for the dictionary. <br>`configSpec.clickhouse.config.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mongodbSource.<br>db | **string**<br><p>Required. Name of the MongoDB database.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mongodbSource.<br>collection | **string**<br><p>Required. Name of the collection in the specified database to be used as the dictionary source.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mongodbSource.<br>host | **string**<br><p>Required. MongoDB host of the specified database.</p> <p>The maximum string length in characters is 253.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mongodbSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mongodbSource.<br>user | **string**<br><p>Required. Name of the MongoDB database user.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mongodbSource.<br>password | **string**<br><p>Password of the MongoDB database user.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>postgresqlSource | **object**<br>PostgreSQL source for the dictionary. <br>`configSpec.clickhouse.config.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br>
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>postgresqlSource.<br>db | **string**<br><p>Required. Name of the PostrgreSQL database.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>postgresqlSource.<br>table | **string**<br><p>Required. Name of the table in the specified database to be used as the dictionary source.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>postgresqlSource.<br>hosts[] | **string**<br><p>Required. Name of the PostrgreSQL host</p> <p>Must contain at least one element.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>postgresqlSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>postgresqlSource.<br>user | **string**<br><p>Required. Name of the PostrgreSQL database user.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>postgresqlSource.<br>password | **string**<br><p>Password of the PostrgreSQL database user.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>postgresqlSource.<br>invalidateQuery | **string**<br><p>Query for checking the dictionary status, to pull only updated data. For more details, see <a href="https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_lifetime/">ClickHouse documentation on dictionaries</a>.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>postgresqlSource.<br>sslMode | **string**<br><p>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see <a href="https://www.postgresql.org/docs/current/libpq-ssl.html">PostgreSQL documentation</a>.</p> <ul> <li>DISABLE: Only try a non-SSL connection.</li> <li>ALLOW: First try a non-SSL connection; if that fails, try an SSL connection.</li> <li>PREFER: First try an SSL connection; if that fails, try a non-SSL connection.</li> <li>VERIFY_CA: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li> <li>VERIFY_FULL: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li> </ul> 
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup[] | **object**<br><p>Settings for thinning Graphite data. See in-depth description in <a href="https://clickhouse.com/docs/en/operations/server_settings/settings/#server_settings-graphite_rollup">ClickHouse documentation</a>.</p> 
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup[].<br>name | **string**<br><p>Required. Name for the specified combination of settings for Graphite rollup.</p> 
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup[].<br>patterns[] | **object**<br><p>Required. Pattern to use for the rollup.</p> <p>Must contain at least one element.</p> 
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup[].<br>patterns[].<br>regexp | **string**<br><p>Pattern for metric names.</p> 
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup[].<br>patterns[].<br>function | **string**<br><p>Required. Name of the aggregating function to apply to data of the age specified in ``retention``.</p> 
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup[].<br>patterns[].<br>retention[] | **object**<br><p>Required. Age of data to use for thinning.</p> <p>Must contain at least one element.</p> 
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup[].<br>patterns[].<br>retention[].<br>age | **string** (int64)<br><p>Minimum age of the data in seconds.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup[].<br>patterns[].<br>retention[].<br>precision | **string** (int64)<br><p>Precision of determining the age of the data, in seconds.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>clickhouse.<br>config.<br>kafka | **object**
configSpec.<br>clickhouse.<br>config.<br>kafka.<br>securityProtocol | **string**
configSpec.<br>clickhouse.<br>config.<br>kafka.<br>saslMechanism | **string**
configSpec.<br>clickhouse.<br>config.<br>kafka.<br>saslUsername | **string**
configSpec.<br>clickhouse.<br>config.<br>kafka.<br>saslPassword | **string**
configSpec.<br>clickhouse.<br>config.<br>kafkaTopics[] | **object**
configSpec.<br>clickhouse.<br>config.<br>kafkaTopics[].<br>name | **string**<br><p>Required.</p> 
configSpec.<br>clickhouse.<br>config.<br>kafkaTopics[].<br>settings | **object**<br><p>Required.</p> 
configSpec.<br>clickhouse.<br>config.<br>kafkaTopics[].<br>settings.<br>securityProtocol | **string**
configSpec.<br>clickhouse.<br>config.<br>kafkaTopics[].<br>settings.<br>saslMechanism | **string**
configSpec.<br>clickhouse.<br>config.<br>kafkaTopics[].<br>settings.<br>saslUsername | **string**
configSpec.<br>clickhouse.<br>config.<br>kafkaTopics[].<br>settings.<br>saslPassword | **string**
configSpec.<br>clickhouse.<br>config.<br>rabbitmq | **object**
configSpec.<br>clickhouse.<br>config.<br>rabbitmq.<br>username | **string**<br><p><a href="https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/">RabbitMQ</a> username</p> 
configSpec.<br>clickhouse.<br>config.<br>rabbitmq.<br>password | **string**<br><p><a href="https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/">RabbitMQ</a> password</p> 
configSpec.<br>clickhouse.<br>config.<br>rabbitmq.<br>vhost | **string**<br><p><a href="https://clickhouse.com/docs/en/engines/table-engines/integrations/rabbitmq/">RabbitMQ</a> virtual host</p> 
configSpec.<br>clickhouse.<br>config.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections.</p> <p>The minimum value is 10.</p> 
configSpec.<br>clickhouse.<br>config.<br>maxConcurrentQueries | **integer** (int64)<br><p>Maximum number of simultaneously processed requests.</p> <p>The minimum value is 10.</p> 
configSpec.<br>clickhouse.<br>config.<br>keepAliveTimeout | **integer** (int64)<br><p>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection.</p> 
configSpec.<br>clickhouse.<br>config.<br>uncompressedCacheSize | **integer** (int64)<br><p>Cache size (in bytes) for uncompressed data used by MergeTree tables.</p> 
configSpec.<br>clickhouse.<br>config.<br>markCacheSize | **integer** (int64)<br><p>Approximate size (in bytes) of the cache of "marks" used by MergeTree tables.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>clickhouse.<br>config.<br>maxTableSizeToDrop | **integer** (int64)<br><p>Maximum size of the table that can be deleted using a DROP query.</p> 
configSpec.<br>clickhouse.<br>config.<br>maxPartitionSizeToDrop | **integer** (int64)<br><p>Maximum size of the partition that can be deleted using a DROP query.</p> 
configSpec.<br>clickhouse.<br>config.<br>builtinDictionariesReloadInterval | **integer** (int64)<br><p>The setting is deprecated and has no effect.</p> 
configSpec.<br>clickhouse.<br>config.<br>timezone | **string**<br><p>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier.</p> 
configSpec.<br>clickhouse.<br>config.<br>geobaseUri | **string**<br><p>Address of the archive with the user geobase in Object Storage.</p> 
configSpec.<br>clickhouse.<br>config.<br>queryLogRetentionSize | **integer** (int64)<br><p>The maximum size that query_log can grow to before old data will be removed. If set to 0, automatic removal of query_log data based on size is disabled.</p> 
configSpec.<br>clickhouse.<br>config.<br>queryLogRetentionTime | **integer** (int64)<br><p>The maximum time that query_log records will be retained before removal. If set to 0, automatic removal of query_log data based on time is disabled.</p> 
configSpec.<br>clickhouse.<br>config.<br>queryThreadLogEnabled | **boolean** (boolean)<br><p>Whether query_thread_log system table is enabled.</p> 
configSpec.<br>clickhouse.<br>config.<br>queryThreadLogRetentionSize | **integer** (int64)<br><p>The maximum size that query_thread_log can grow to before old data will be removed. If set to 0, automatic removal of query_thread_log data based on size is disabled.</p> 
configSpec.<br>clickhouse.<br>config.<br>queryThreadLogRetentionTime | **integer** (int64)<br><p>The maximum time that query_thread_log records will be retained before removal. If set to 0, automatic removal of query_thread_log data based on time is disabled.</p> 
configSpec.<br>clickhouse.<br>config.<br>partLogRetentionSize | **integer** (int64)<br><p>The maximum size that part_log can grow to before old data will be removed. If set to 0, automatic removal of part_log data based on size is disabled.</p> 
configSpec.<br>clickhouse.<br>config.<br>partLogRetentionTime | **integer** (int64)<br><p>The maximum time that part_log records will be retained before removal. If set to 0, automatic removal of part_log data based on time is disabled.</p> 
configSpec.<br>clickhouse.<br>config.<br>metricLogEnabled | **boolean** (boolean)<br><p>Whether metric_log system table is enabled.</p> 
configSpec.<br>clickhouse.<br>config.<br>metricLogRetentionSize | **integer** (int64)<br><p>The maximum size that metric_log can grow to before old data will be removed. If set to 0, automatic removal of metric_log data based on size is disabled.</p> 
configSpec.<br>clickhouse.<br>config.<br>metricLogRetentionTime | **integer** (int64)<br><p>The maximum time that metric_log records will be retained before removal. If set to 0, automatic removal of metric_log data based on time is disabled.</p> 
configSpec.<br>clickhouse.<br>config.<br>traceLogEnabled | **boolean** (boolean)<br><p>Whether trace_log system table is enabled.</p> 
configSpec.<br>clickhouse.<br>config.<br>traceLogRetentionSize | **integer** (int64)<br><p>The maximum size that trace_log can grow to before old data will be removed. If set to 0, automatic removal of trace_log data based on size is disabled.</p> 
configSpec.<br>clickhouse.<br>config.<br>traceLogRetentionTime | **integer** (int64)<br><p>The maximum time that trace_log records will be retained before removal. If set to 0, automatic removal of trace_log data based on time is disabled.</p> 
configSpec.<br>clickhouse.<br>config.<br>textLogEnabled | **boolean** (boolean)<br><p>Whether text_log system table is enabled.</p> 
configSpec.<br>clickhouse.<br>config.<br>textLogRetentionSize | **integer** (int64)<br><p>The maximum size that text_log can grow to before old data will be removed. If set to 0, automatic removal of text_log data based on size is disabled.</p> 
configSpec.<br>clickhouse.<br>config.<br>textLogRetentionTime | **integer** (int64)<br><p>The maximum time that text_log records will be retained before removal. If set to 0, automatic removal of text_log data based on time is disabled.</p> 
configSpec.<br>clickhouse.<br>config.<br>textLogLevel | **string**<br><p>Logging level for text_log system table. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.</p> 
configSpec.<br>clickhouse.<br>config.<br>opentelemetrySpanLogEnabled | **boolean** (boolean)
configSpec.<br>clickhouse.<br>config.<br>backgroundPoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
configSpec.<br>clickhouse.<br>config.<br>backgroundSchedulePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
configSpec.<br>clickhouse.<br>config.<br>backgroundFetchesPoolSize | **integer** (int64)<br><p>Sets the number of threads performing background fetches for tables with <strong>ReplicatedMergeTree</strong> engines. Default value: 8.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#background_fetches_pool_size">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>clickhouse.<br>config.<br>backgroundMovePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
configSpec.<br>clickhouse.<br>config.<br>backgroundDistributedSchedulePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
configSpec.<br>clickhouse.<br>config.<br>backgroundBufferFlushSchedulePoolSize | **integer** (int64)<br><p>Value must be greater than 0.</p> 
configSpec.<br>clickhouse.<br>config.<br>defaultDatabase | **string**<br><p>The default database.</p> <p>To get a list of cluster databases, see <a href="https://cloud.yandex.com/en/docs/managed-clickhouse/operations/databases#list-db">Yandex Managed ClickHouse documentation</a>.</p> 
configSpec.<br>clickhouse.<br>config.<br>totalMemoryProfilerStep | **integer** (int64)<br><p>Sets the memory size (in bytes) for a stack trace at every peak allocation step. Default value: <strong>4194304</strong>.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings/#total-memory-profiler-step">ClickHouse documentation</a>.</p> 
configSpec.<br>clickhouse.<br>config.<br>totalMemoryTrackerSampleProbability | **number** (double)
configSpec.<br>clickhouse.<br>resources | **object**<br><p>Resources allocated to ClickHouse hosts.</p> 
configSpec.<br>clickhouse.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-clickhouse/concepts/instance-types">documentation</a></p> 
configSpec.<br>clickhouse.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>clickhouse.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>zookeeper | **object**<br><p>Configuration and resources for a ZooKeeper server.</p> 
configSpec.<br>zookeeper.<br>resources | **object**<br><p>Resources allocated to ZooKeeper hosts. If not set, minimal available resources will be used. All available resource presets can be retrieved with a <a href="/docs/managed-clickhouse/api-ref/ResourcePreset/list">list</a> request.</p> 
configSpec.<br>zookeeper.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-clickhouse/concepts/instance-types">documentation</a></p> 
configSpec.<br>zookeeper.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>zookeeper.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>backupWindowStart | **object**<br><p>Time to start the daily backup, in the UTC timezone.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
configSpec.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value "24:00:00" for scenarios like business closing time.</p> 
configSpec.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
configSpec.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
configSpec.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
configSpec.<br>access | **object**<br><p>Access policy for external services.</p> <p>If you want a specific service to access the ClickHouse cluster, then set the necessary values in this policy.</p> 
configSpec.<br>access.<br>dataLens | **boolean** (boolean)<br><p>Allow to export data from the cluster to DataLens.</p> 
configSpec.<br>access.<br>webSql | **boolean** (boolean)<br><p>Allow SQL queries to the cluster databases from the management console.</p> <p>See <a href="/docs/managed-clickhouse/operations/web-sql-query">SQL queries in the management console</a> for more details.</p> 
configSpec.<br>access.<br>metrika | **boolean** (boolean)<br><p>Allow to import data from Yandex Metrica and AppMetrica to the cluster.</p> <p>See <a href="https://appmetrica.yandex.com/docs/cloud/index.html">AppMetrica documentation</a> for more details.</p> 
configSpec.<br>access.<br>serverless | **boolean** (boolean)<br><p>Allow access to cluster for Serverless.</p> 
configSpec.<br>access.<br>dataTransfer | **boolean** (boolean)<br><p>Allow access for DataTransfer</p> 
configSpec.<br>access.<br>yandexQuery | **boolean** (boolean)<br><p>Allow access for Query</p> 
configSpec.<br>cloudStorage | **object**
configSpec.<br>cloudStorage.<br>enabled | **boolean** (boolean)<br><p>Whether to use Object Storage for storing ClickHouse data.</p> 
configSpec.<br>cloudStorage.<br>moveFactor | **number** (double)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
configSpec.<br>cloudStorage.<br>dataCacheEnabled | **boolean** (boolean)
configSpec.<br>cloudStorage.<br>dataCacheMaxSize | **integer** (int64)
configSpec.<br>sqlDatabaseManagement | **boolean** (boolean)<br><p>Whether database management through SQL commands is enabled.</p> 
configSpec.<br>sqlUserManagement | **boolean** (boolean)<br><p>Whether user management through SQL commands is enabled.</p> 
configSpec.<br>adminPassword | **string**<br><p>Password for user 'admin' that has SQL user management access.</p> 
configSpec.<br>embeddedKeeper | **boolean** (boolean)<br><p>Whether cluster should use embedded Keeper instead of Zookeeper</p> 
databaseSpecs[] | **object**<br><p>Required. Descriptions of databases to be created in the ClickHouse cluster.</p> <p>Must contain at least one element.</p> 
databaseSpecs[].<br>name | **string**<br><p>Required. Name of the ClickHouse database. 1-63 characters long.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
userSpecs[] | **object**<br><p>Required. Descriptions of database users to be created in the ClickHouse cluster.</p> <p>Must contain at least one element.</p> 
userSpecs[].<br>name | **string**<br><p>Required. Name of the ClickHouse user.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_]*``.</p> 
userSpecs[].<br>password | **string**<br><p>Required. Password of the ClickHouse user.</p> <p>The string length in characters must be 8-128.</p> 
userSpecs[].<br>permissions[] | **object**<br><p>Set of permissions to grant to the user. If not set, it's granted permissions to access all databases.</p> 
userSpecs[].<br>permissions[].<br>databaseName | **string**<br><p>Name of the database that the permission grants access to.</p> 
userSpecs[].<br>settings | **object**<br><p>ClickHouse user settings. Supported settings are a limited subset of all settings described in <a href="https://clickhouse.com/docs/en/operations/settings/">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>readonly | **integer** (int64)<br><p>Restricts permissions for non-DDL queries. To restrict permissions for DDL queries, use ``allowDdl`` instead.</p> <ul> <li><strong>0</strong> (default)-no restrictions.</li> <li><strong>1</strong>-only read data queries are allowed.</li> <li><strong>2</strong>-read data and change settings queries are allowed.</li> </ul> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/permissions-for-queries/#settings_readonly">ClickHouse documentation</a>.</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
userSpecs[].<br>settings.<br>allowDdl | **boolean** (boolean)<br><p>Determines whether DDL queries are allowed (e.g., <strong>CREATE</strong>, <strong>ALTER</strong>, <strong>RENAME</strong>, etc).</p> <p>Default value: <strong>true</strong>.</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/permissions-for-queries/#settings_allow_ddl">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>allowIntrospectionFunctions | **boolean** (boolean)<br><p>Enables <a href="https://clickhouse.com/docs/en/sql-reference/functions/introspection">introspections functions</a> for query profiling.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-allow_introspection_functions">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>connectTimeout | **integer** (int64)<br><p>Connection timeout in milliseconds.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>10000</strong>, 10 seconds).</p> <p>Value must be greater than 0.</p> 
userSpecs[].<br>settings.<br>connectTimeoutWithFailover | **integer** (int64)<br><p>The timeout in milliseconds for connecting to a remote server for a Distributed table engine. Applies only if the cluster uses sharding and replication. If unsuccessful, several attempts are made to connect to various replicas.</p> <p>Default value: <strong>50</strong>.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#connect-timeout-with-failover-ms">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
userSpecs[].<br>settings.<br>receiveTimeout | **integer** (int64)<br><p>Receive timeout in milliseconds.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>300000</strong>, 300 seconds or 5 minutes).</p> <p>Value must be greater than 0.</p> 
userSpecs[].<br>settings.<br>sendTimeout | **integer** (int64)<br><p>Send timeout in milliseconds.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>300000</strong>, 300 seconds or 5 minutes).</p> <p>Value must be greater than 0.</p> 
userSpecs[].<br>settings.<br>timeoutBeforeCheckingExecutionSpeed | **integer** (int64)<br><p>Timeout (in seconds) between checks of execution speed. It is checked that execution speed is not less that specified in ``minExecutionSpeed`` parameter.</p> <p>Default value: <strong>10</strong>.</p> 
userSpecs[].<br>settings.<br>insertQuorum | **integer** (int64)<br><p>Enables or disables write quorum for ClickHouse cluster. If the value is less than <strong>2</strong>, then write quorum is disabled, otherwise it is enabled.</p> <p>When used, write quorum guarantees that ClickHouse has written data to the quorum of <strong>insert_quorum</strong> replicas with no errors until the ``insertQuorumTimeout`` expires. All replicas in the quorum are in the consistent state, meaning that they contain linearized data from the previous <strong>INSERT</strong> queries. Employ write quorum, if you need the guarantees that the written data would not be lost in case of one or more replicas failure.</p> <p>You can use ``selectSequentialConsistency`` setting to read the data written with write quorum.</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-insert_quorum">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>insertQuorumTimeout | **integer** (int64)<br><p>Quorum write timeout in milliseconds.</p> <p>If the write quorum is enabled in the cluster, this timeout expires and some data is not written to the ``insertQuorum`` replicas, then ClickHouse will abort the execution of <strong>INSERT</strong> query and return an error. In this case, the client must send the query again to write the data block into the same or another replica.</p> <p>Minimum value: <strong>1000</strong>, 1 second (default: <strong>60000</strong>, 1 minute).</p> <p>The minimum value is 1000.</p> 
userSpecs[].<br>settings.<br>insertQuorumParallel | **boolean** (boolean)<br><p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-insert_quorum_parallel">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>insertNullAsDefault | **boolean** (boolean)<br><p>Enables the insertion of default values instead of NULL into columns with not nullable data type.</p> <p>Default value: <strong>true</strong>.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#insert_null_as_default">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>selectSequentialConsistency | **boolean** (boolean)<br><p>Determines the behavior of <strong>SELECT</strong> queries from the replicated table: if enabled, ClickHouse will terminate a query with error message in case the replica does not have a chunk written with the quorum and will not read the parts that have not yet been written with the quorum.</p> <p>Default value: <strong>false</strong> (sequential consistency is disabled).</p> 
userSpecs[].<br>settings.<br>deduplicateBlocksInDependentMaterializedViews | **boolean** (boolean)<br><p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-deduplicate-blocks-in-dependent-materialized-views">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>replicationAlterPartitionsSync | **integer** (int64)<br><p>Wait mode for asynchronous actions in <strong>ALTER</strong> queries on replicated tables:</p> <ul> <li><strong>0</strong>-do not wait for replicas.</li> <li><strong>1</strong>-only wait for own execution (default).</li> <li><strong>2</strong>-wait for all replicas.</li> </ul> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/sql-reference/statements/alter/#synchronicity-of-alter-queries">ClickHouse documentation</a>.</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
userSpecs[].<br>settings.<br>maxReplicaDelayForDistributedQueries | **integer** (int64)<br><p>Max replica delay in milliseconds. If a replica lags more than the set value, this replica is not used and becomes a stale one.</p> <p>Minimum value: <strong>1000</strong>, 1 second (default: <strong>300000</strong>, 300 seconds or 5 minutes).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_replica_delay_for_distributed_queries">ClickHouse documentation</a>.</p> <p>The minimum value is 1000.</p> 
userSpecs[].<br>settings.<br>fallbackToStaleReplicasForDistributedQueries | **boolean** (boolean)<br><p>Enables or disables query forcing to a stale replica in case the actual data is unavailable. If enabled, ClickHouse will choose the most up-to-date replica and force the query to use the data in this replica. This setting can be used when doing <strong>SELECT</strong> query from a distributed table that points to replicated tables.</p> <p>Default value: <strong>true</strong> (query forcing is enabled).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-fallback_to_stale_replicas_for_distributed_queries">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>distributedProductMode | **string**<br><p>Determine the behavior of distributed subqueries.</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#distributed-product-mode">ClickHouse documentation</a>.</p> <ul> <li>DISTRIBUTED_PRODUCT_MODE_DENY: Default value. Prohibits using these types of subqueries (returns the "Double-distributed in/JOIN subqueries is denied" exception).</li> <li>DISTRIBUTED_PRODUCT_MODE_LOCAL: Replaces the database and table in the subquery with local ones for the destination server (shard), leaving the normal IN/JOIN.</li> <li>DISTRIBUTED_PRODUCT_MODE_GLOBAL: Replaces the IN/JOIN query with GLOBAL IN/GLOBAL JOIN.</li> <li>DISTRIBUTED_PRODUCT_MODE_ALLOW: Allows the use of these types of subqueries.</li> </ul> 
userSpecs[].<br>settings.<br>distributedAggregationMemoryEfficient | **boolean** (boolean)<br><p>Enables of disables memory saving mode when doing distributed aggregation.</p> <p>When ClickHouse works with a distributed query, external aggregation is done on remote servers. Enable this setting to achieve a smaller memory footprint on the server that sourced such a distributed query.</p> <p>Default value: <strong>false</strong> (memory saving mode is disabled).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/sql-reference/statements/select/group-by/#select-group-by-in-external-memory">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>distributedDdlTaskTimeout | **integer** (int64)<br><p>Timeout for DDL queries, in milliseconds.</p> 
userSpecs[].<br>settings.<br>skipUnavailableShards | **boolean** (boolean)<br><p>Enables or disables silent skipping of unavailable shards.</p> <p>A shard is considered unavailable if all its replicas are also unavailable.</p> <p>Default value: <strong>false</strong> (silent skipping is disabled).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-skip_unavailable_shards">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>compileExpressions | **boolean** (boolean)<br><p>Enables or disables expression compilation. If you execute a lot of queries that contain identical expressions, then enable this setting. As a result, such queries may be executed faster due to use of compiled expressions.</p> <p>Use this setting in combination with ``minCountToCompileExpression`` setting.</p> <p>Default value: <strong>false</strong> (expression compilation is disabled).</p> 
userSpecs[].<br>settings.<br>minCountToCompileExpression | **integer** (int64)<br><p>How many identical expressions ClickHouse has to encounter before they are compiled.</p> <p>Minimum value: <strong>0</strong> (default: <strong>3</strong>).</p> <p>For the <strong>0</strong> value compilation is synchronous: a query waits for expression compilation process to complete prior to continuing execution. It is recommended to set this value only for testing purposes.</p> <p>For all other values, compilation is asynchronous: the compilation process executes in a separate thread. When a compiled expression is ready, it will be used by ClickHouse for eligible queries, including the ones that are currently running.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>maxBlockSize | **integer** (int64)<br><p>The maximum block size for reading.</p> <p>Data in ClickHouse is organized and processed by blocks (block is a set of columns' parts). The internal processing cycles for a single block are efficient enough, but there are noticeable expenditures on each block.</p> <p>This setting is a recommendation for size of block (in a count of rows) that should be loaded from tables.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>65536</strong>).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#setting-max_block_size">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
userSpecs[].<br>settings.<br>minInsertBlockSizeRows | **integer** (int64)<br><p>Limits the minimum number of rows in a block to be inserted in a table by <strong>INSERT</strong> query. Blocks that are smaller than the specified value, will be squashed together into the bigger blocks.</p> <p>Minimal value: <strong>0</strong>, block squashing is disabled (default: <strong>1048576</strong>).</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>minInsertBlockSizeBytes | **integer** (int64)<br><p>Limits the minimum number of bytes in a block to be inserted in a table by <strong>INSERT</strong> query. Blocks that are smaller than the specified value, will be squashed together into the bigger blocks.</p> <p>Minimal value: <strong>0</strong>, block squashing is disabled (default: <strong>268435456</strong>, 256 MB).</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>maxInsertBlockSize | **integer** (int64)<br><p>Allows to form blocks of the specified size (in bytes) when inserting data in a table. This setting has effect only if server is creating such blocks by itself.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>1048576</strong>).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_insert_block_size">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
userSpecs[].<br>settings.<br>minBytesToUseDirectIo | **integer** (int64)<br><p>Limits the minimum number of bytes to enable unbuffered direct reads from disk (Direct I/O).</p> <p>By default, ClickHouse does not read data directly from disk, but relies on the filesystem and its cache instead. Such reading strategy is effective when the data volume is small. If the amount of the data to read is huge, it is more effective to read directly from the disk, bypassing the filesystem cache.</p> <p>If the total amount of the data to read is greater than the value of this setting, then ClickHouse will fetch this data directly from the disk.</p> <p>Minimal value and default value: <strong>0</strong>, Direct I/O is disabled.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>useUncompressedCache | **boolean** (boolean)<br><p>Determines whether to use the cache of uncompressed blocks, or not. Using this cache can significantly reduce latency and increase the throughput when a huge amount of small queries is to be processed. Enable this setting for the users who instantiates small queries frequently.</p> <p>This setting has effect only for tables of the MergeTree family.</p> <p>Default value: <strong>false</strong> (uncompressed cache is disabled).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#setting-use_uncompressed_cache">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>mergeTreeMaxRowsToUseCache | **integer** (int64)<br><p>Limits the maximum size in rows of the request that can use the cache of uncompressed data. The cache is not used for requests larger than the specified value.</p> <p>Use this setting in combination with ``useUncompressedCache`` setting.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>128x8192</strong>).</p> <p>Value must be greater than 0.</p> 
userSpecs[].<br>settings.<br>mergeTreeMaxBytesToUseCache | **integer** (int64)<br><p>Limits the maximum size in bytes of the request that can use the cache of uncompressed data. The cache is not used for requests larger than the specified value.</p> <p>Use this setting in combination with ``useUncompressedCache`` setting.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>192x10x1024x1024</strong>).</p> <p>Value must be greater than 0.</p> 
userSpecs[].<br>settings.<br>mergeTreeMinRowsForConcurrentRead | **integer** (int64)<br><p>Limits the minimum number of rows to be read from a file to enable concurrent read. If the number of rows to be read exceeds this value, then ClickHouse will try to use a few threads to read from a file concurrently.</p> <p>This setting has effect only for tables of the MergeTree family.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>20x8192</strong>).</p> <p>Value must be greater than 0.</p> 
userSpecs[].<br>settings.<br>mergeTreeMinBytesForConcurrentRead | **integer** (int64)<br><p>Limits the number of bytes to be read from a file to enable concurrent read. If the number of bytes to be read exceeds this value, then ClickHouse will try to use a few threads to read from a file concurrently.</p> <p>This setting has effect only for tables of the MergeTree family.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>24x10x1024x1024</strong>).</p> <p>Value must be greater than 0.</p> 
userSpecs[].<br>settings.<br>maxBytesBeforeExternalGroupBy | **integer** (int64)<br><p>Sets the threshold of RAM consumption (in bytes) after that the temporary data, collected during the <strong>GROUP BY</strong> operation, should be flushed to disk to limit the RAM comsumption.</p> <p>By default, aggregation is done by employing hash table that resides in RAM. A query can result in aggregation of huge data volumes that can lead to memory exhaustion and abortion of the query (see the ``maxMemoryUsage`` setting). For such queries, you can use this setting to force ClickHouse to do flushing and complete aggregation successfully.</p> <p>Minimal value and default value: <strong>0</strong>, <strong>GROUP BY</strong> in the external memory is disabled.</p> <p>When using aggregation in external memory, it is recommended to set the value of this setting twice as low as the ``maxMemoryUsage`` setting value (by default, the maximum memory usage is limited to ten gigabytes).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/sql-reference/statements/select/group-by/#select-group-by-in-external-memory">ClickHouse documentation</a>.</p> <p>See also: the ``distributedAggregationMemoryEfficient`` setting.</p> 
userSpecs[].<br>settings.<br>maxBytesBeforeExternalSort | **integer** (int64)<br><p>This setting is equivalent of the ``maxBytesBeforeExternalGroupBy`` setting, except for it is for sort operation (<strong>ORDER BY</strong>), not aggregation.</p> 
userSpecs[].<br>settings.<br>groupByTwoLevelThreshold | **integer** (int64)<br><p>Sets the threshold of the number of keys, after that the two-level aggregation should be used.</p> <p>Minimal value: <strong>0</strong>, threshold is not set (default: <strong>10000</strong>).</p> 
userSpecs[].<br>settings.<br>groupByTwoLevelThresholdBytes | **integer** (int64)<br><p>Sets the threshold of the number of bytes, after that the two-level aggregation should be used.</p> <p>Minimal value: <strong>0</strong>, threshold is not set (default: <strong>100000000</strong>).</p> 
userSpecs[].<br>settings.<br>priority | **integer** (int64)<br><p>Sets the priority of a query.</p> <ul> <li><strong>0</strong>-priority is not used.</li> <li><strong>1</strong>-the highest priority.</li> <li>and so on. The higher the number, the lower a query's priority.</li> </ul> <p>This setting should be set up for each query individually.</p> <p>If ClickHouse is working with the high-priority queries, and a low-priority query enters, then the low-priority query is paused until higher-priority queries are completed.</p> <p>Minimal value and default value: <strong>0</strong>, priority is not used.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>maxThreads | **integer** (int64)<br><p>Limits the maximum number of threads to process the request (setting does not take threads that read data from remote servers into account).</p> <p>This setting applies to threads that perform the same stages of the query processing pipeline in parallel.</p> <p>Minimal value and default value: <strong>0</strong> (the thread number is calculated automatically based on the number of physical CPU cores, no HyperThreading cores are taken into account).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_threads">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
userSpecs[].<br>settings.<br>maxMemoryUsage | **integer** (int64)<br><p>Limits the maximum memory usage (in bytes) for processing of a single user's query on a single server. This setting does not take server's free RAM amount or total RAM amount into account.</p> <p>This limitation is enforced for any user's single query on a single server.</p> <p>Minimal value: <strong>0</strong>, no limitation is set. Value that is set in the ClickHouse default config file: <strong>10737418240</strong> (10 GB).</p> <p>If you use ``maxBytesBeforeExternalGroupBy`` or ``maxBytesBeforeExternalSort`` setting, then it is recommended to set their values twice as low as ``maxMemoryUsage`` setting value.</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#settings_max_memory_usage">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>maxMemoryUsageForUser | **integer** (int64)<br><p>Limits the maximum memory usage (in bytes) for processing of user's queries on a single server. This setting does not take server's free RAM amount or total RAM amount into account.</p> <p>This limitation is enforced for all queries that belong to one user and run simultaneously on a single server.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>maxNetworkBandwidth | **integer** (int64)<br><p>The maximum speed of data exchange over the network in bytes per second for a query.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> 
userSpecs[].<br>settings.<br>maxNetworkBandwidthForUser | **integer** (int64)<br><p>The maximum speed of data exchange over the network in bytes per second for all concurrently running user queries.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> 
userSpecs[].<br>settings.<br>maxPartitionsPerInsertBlock | **integer** (int64)<br><p>See in-depth description in <a href="https://clickhouse.com/docs/ru/operations/settings/query-complexity/#max-partitions-per-insert-block">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>maxConcurrentQueriesForUser | **integer** (int64)<br><p>The maximum number of concurrent requests per user. Default value: 0 (no limit).</p> 
userSpecs[].<br>settings.<br>forceIndexByDate | **boolean** (boolean)<br><p>If enabled, query is not executed if the ClickHouse can't use index by date. This setting has effect only for tables of the MergeTree family.</p> <p>Default value: <strong>false</strong> (setting is disabled, query executes even if ClickHouse can't use index by date).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-force_index_by_date">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>forcePrimaryKey | **boolean** (boolean)<br><p>If enabled, query is not executed if the ClickHouse can't use index by primary key. This setting has effect only for tables of the MergeTree family.</p> <p>Default value: <strong>false</strong> (setting is disabled, query executes even if ClickHouse can't use index by primary key).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#force-primary-key">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>maxRowsToRead | **integer** (int64)<br><p>Limits the maximum number of rows that can be read from a table when running a query.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#max-rows-to-read">ClickHouse documentation</a>.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>maxBytesToRead | **integer** (int64)<br><p>Limits the maximum number of bytes (uncompressed data) that can be read from a table when running a query.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>readOverflowMode | **string**<br><p>Determines the behavior on exceeding <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity">limits</a> while reading the data.</p> <ul> <li><strong>throw</strong>-abort query execution, return an error.</li> <li><strong>break</strong>-stop query execution, return partial result.</li> </ul> 
userSpecs[].<br>settings.<br>maxRowsToGroupBy | **integer** (int64)<br><p>Limits the maximum number of unique keys received from aggregation function. This setting helps to reduce RAM consumption while doing aggregation.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>groupByOverflowMode | **string**<br><p>Determines the behavior on exceeding <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity">limits</a> while doing aggregation.</p> <ul> <li><strong>throw</strong>-abort query execution, return an error.</li> <li><strong>break</strong>-stop query execution, return partial result.</li> <li><strong>any</strong>-perform approximate <strong>GROUP BY</strong> operation by continuing aggregation for the keys that got into the set, but don't add new keys to the set.</li> </ul> 
userSpecs[].<br>settings.<br>maxRowsToSort | **integer** (int64)<br><p>Limits the maximum number of rows that can be read from a table for sorting. This setting helps to reduce RAM consumption.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>maxBytesToSort | **integer** (int64)<br><p>Limits the maximum number of bytes (uncompressed data) that can be read from a table for sorting. This setting helps to reduce RAM consumption.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>sortOverflowMode | **string**<br><p>Determines the behavior on exceeding <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity">limits</a> while sorting.</p> <ul> <li><strong>throw</strong>-abort query execution, return an error.</li> <li><strong>break</strong>-stop query execution, return partial result.</li> </ul> 
userSpecs[].<br>settings.<br>maxResultRows | **integer** (int64)<br><p>Limits the number of rows in the result. This limitation is also checked for subqueries and parts of distributed queries that run on remote servers.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>maxResultBytes | **integer** (int64)<br><p>Limits the number of bytes in the result. This limitation is also checked for subqueries and parts of distributed queries that run on remote servers.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>resultOverflowMode | **string**<br><p>Determines the behavior on exceeding <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity">limits</a> while forming result.</p> <ul> <li><strong>throw</strong>-abort query execution, return an error.</li> <li><strong>break</strong>-stop query execution, return partial result.</li> </ul> 
userSpecs[].<br>settings.<br>maxRowsInDistinct | **integer** (int64)<br><p>Limits the maximum number of different rows when using <strong>DISTINCT</strong>.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>maxBytesInDistinct | **integer** (int64)<br><p>Limits the maximum size of a hash table in bytes (uncompressed data) when using <strong>DISTINCT</strong>.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>distinctOverflowMode | **string**<br><p>Determines the behavior on exceeding <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity">limits</a> while doing <strong>DISCTINCT</strong>.</p> <ul> <li><strong>throw</strong>-abort query execution, return an error.</li> <li><strong>break</strong>-stop query execution, return partial result.</li> </ul> 
userSpecs[].<br>settings.<br>maxRowsToTransfer | **integer** (int64)<br><p>Limits the maximum number of rows that can be passed to a remote server or saved in a temporary table when using <strong>GLOBAL IN</strong>.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>maxBytesToTransfer | **integer** (int64)<br><p>Limits the maximum number of bytes (uncompressed data) that can be passed to a remote server or saved in a temporary table when using <strong>GLOBAL IN</strong>.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>transferOverflowMode | **string**<br><p>Determines the behavior on exceeding <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity">limits</a> while doing transfers.</p> <ul> <li><strong>throw</strong>-abort query execution, return an error.</li> <li><strong>break</strong>-stop query execution, return partial result.</li> </ul> 
userSpecs[].<br>settings.<br>maxExecutionTime | **integer** (int64)<br><p>Limits the maximum query execution time in milliseconds. At this moment, this limitation is not checked when passing one of the sorting stages, as well as merging and finalizing aggregation funictions.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>timeoutOverflowMode | **string**<br><p>Determines the behavior on exceeding <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#restrictions-on-query-complexity">limits</a> of execution time.</p> <ul> <li><strong>throw</strong>-abort query execution, return an error.</li> <li><strong>break</strong>-stop query execution, return partial result.</li> </ul> 
userSpecs[].<br>settings.<br>maxRowsInSet | **integer** (int64)<br><p>Limit on the number of rows in the set resulting from the execution of the IN section.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>maxBytesInSet | **integer** (int64)<br><p>Limit on the number of bytes in the set resulting from the execution of the IN section.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>setOverflowMode | **string**<br><p>Determine the behavior on exceeding max_rows_in_set or max_bytes_in_set limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.</p> 
userSpecs[].<br>settings.<br>maxRowsInJoin | **integer** (int64)<br><p>Limit on maximum size of the hash table for JOIN, in rows.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>maxBytesInJoin | **integer** (int64)<br><p>Limit on maximum size of the hash table for JOIN, in bytes.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>joinOverflowMode | **string**<br><p>Determine the behavior on exceeding max_rows_in_join or max_bytes_in_join limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.</p> 
userSpecs[].<br>settings.<br>joinAlgorithm[] | **string**<br><p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-join_algorithm">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>anyJoinDistinctRightTableKeys | **boolean** (boolean)<br><p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#any_join_distinct_right_table_keys">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>maxColumnsToRead | **integer** (int64)<br><p>Limits the maximum number of columns that can be read from a table in a single query. If the query requires to read more columns to complete, then it will be aborted.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>maxTemporaryColumns | **integer** (int64)<br><p>Limits the maximum number of temporary columns that must be kept in RAM at the same time when running a query, including constant columns.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>maxTemporaryNonConstColumns | **integer** (int64)<br><p>Limits the maximum number of temporary columns that must be kept in RAM at the same time when running a query, excluding constant columns.</p> <p>Minimal value and default value: <strong>0</strong>, no limitation is set.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>maxQuerySize | **integer** (int64)<br><p>Limits the size of the part of a query that can be transferred to RAM for parsing with the SQL parser, in bytes.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>262144</strong>).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-max_query_size">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
userSpecs[].<br>settings.<br>maxAstDepth | **integer** (int64)<br><p>Limits the maximum depth of query syntax tree.</p> <p>Executing a big and complex query may result in building a syntax tree of enormous depth. By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.</p> <p>For example, the **SELECT *** query may result in more complex and deeper syntax tree, compared to the <strong>SELECT ... WHERE ...</strong> query, containing constraints and conditions, in the most cases. A user can be forced to construct more optimized queries, if this setting is used.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>1000</strong>). If a too small value is set, it may render ClickHouse unable to execute even simple queries.</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#max-ast-depth">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
userSpecs[].<br>settings.<br>maxAstElements | **integer** (int64)<br><p>Limits the maximum size of query syntax tree in number of nodes.</p> <p>Executing a big and complex query may result in building a syntax tree of enormous size. By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>50000</strong>). If a too small value is set, it may render ClickHouse unable to execute even simple queries.</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/query-complexity/#max-ast-elements">ClickHouse documentation</a>.</p> <p>Value must be greater than 0.</p> 
userSpecs[].<br>settings.<br>maxExpandedAstElements | **integer** (int64)<br><p>Limits the maximum size of query syntax tree in number of nodes after expansion of aliases and the asterisk values.</p> <p>Executing a big and complex query may result in building a syntax tree of enormous size. By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>500000</strong>). If a too small value is set, it may render ClickHouse unable to execute even simple queries.</p> <p>Value must be greater than 0.</p> 
userSpecs[].<br>settings.<br>minExecutionSpeed | **integer** (int64)<br><p>Minimal execution speed in rows per second.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>minExecutionSpeedBytes | **integer** (int64)<br><p>Minimal execution speed in bytes per second.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>countDistinctImplementation | **string**<br><p>Aggregate function to use for implementation of count(DISTINCT ...).</p> 
userSpecs[].<br>settings.<br>inputFormatValuesInterpretExpressions | **boolean** (boolean)<br><p>Enables or disables SQL parser if the fast stream parser cannot parse the data.</p> <p>Enable this setting, if the data that you want to insert into a table contains SQL expressions.</p> <p>For example, the stream parser is unable to parse a value that contains <strong>now()</strong> expression; therefore an <strong>INSERT</strong> query for this value will fail and no data will be inserted into a table. With enabled SQL parser, this expression is parsed correctly: the <strong>now()</strong> expression will be parsed as SQL function, interpreted, and the current date and time will be inserted into the table as a result.</p> <p>This setting has effect only if you use <a href="https://clickhouse.com/docs/en/interfaces/formats/#data-format-values">Values</a> format when inserting data.</p> <p>Default value: <strong>true</strong> (SQL parser is enabled).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#settings-input_format_values_interpret_expressions">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>inputFormatDefaultsForOmittedFields | **boolean** (boolean)<br><p>Enables or disables replacing omitted input values with default values of the respective columns when performing <strong>INSERT</strong> queries.</p> <p>Default value: <strong>true</strong> (replacing is enabled).</p> 
userSpecs[].<br>settings.<br>inputFormatNullAsDefault | **boolean** (boolean)<br><p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#input_format_null_as_default">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>dateTimeInputFormat | **string**<br><p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#date_time_input_format">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>inputFormatWithNamesUseHeader | **boolean** (boolean)<br><p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#input_format_with_names_use_header">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>outputFormatJsonQuote_64BitIntegers | **boolean** (boolean)<br><p>Enables quoting of 64-bit integers in JSON output format.</p> <p>If this setting is enabled, then 64-bit integers (<strong>UInt64</strong> and <strong>Int64</strong>) will be quoted when written to JSON output in order to maintain compatibility with the most of the JavaScript engines. Otherwise, such integers will not be quoted.</p> <p>Default value: <strong>false</strong> (quoting 64-bit integers is disabled).</p> 
userSpecs[].<br>settings.<br>outputFormatJsonQuoteDenormals | **boolean** (boolean)<br><p>Enables special floating-point values (<strong>+nan</strong>, <strong>-nan</strong>, <strong>+inf</strong> and <strong>-inf</strong>) in JSON output format.</p> <p>Default value: <strong>false</strong> (special values do not present in output).</p> 
userSpecs[].<br>settings.<br>dateTimeOutputFormat | **string**<br><p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#date_time_output_format">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>lowCardinalityAllowInNativeFormat | **boolean** (boolean)<br><p>Determines whether to use LowCardinality type in Native format.</p> <ul> <li><strong>true</strong> (default)-yes, use.</li> <li><strong>false</strong>-convert LowCardinality columns to regular columns when doing <strong>SELECT</strong>, and convert regular columns to LowCardinality when doing <strong>INSERT</strong>.</li> </ul> <p>LowCardinality columns (aka sparse columns) store data in more effective way, compared to regular columns, by using hash tables. If data to insert suits this storage format, ClickHouse will place them into LowCardinality column.</p> <p>If you use a third-party ClickHouse client that can't work with LowCardinality columns, then this client will not be able to correctly interpret the result of the query that asks for data stored in LowCardinality column. Disable this setting to convert LowCardinality column to regular column when creating the result, so such clients will be able to process the result.</p> <p>Official ClickHouse client works with LowCardinality columns out-of-the-box.</p> <p>Default value: <strong>true</strong> (LowCardinality columns are used in Native format).</p> 
userSpecs[].<br>settings.<br>allowSuspiciousLowCardinalityTypes | **boolean** (boolean)<br><p>Allows specifying <strong>LowCardinality</strong> modifier for types of small fixed size (8 or less) in CREATE TABLE statements. Enabling this may increase merge times and memory consumption.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#allow_suspicious_low_cardinality_types">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>emptyResultForAggregationByEmptySet | **boolean** (boolean)<br><p>Enables returning of empty result when aggregating without keys (with <strong>GROUP BY</strong> operation absent) on empty set (e.g., <strong>SELECT count(*) FROM table WHERE 0</strong>).</p> <ul> <li><strong>true</strong>-ClickHouse will return an empty result for such queries.</li> <li><strong>false</strong> (default)-ClickHouse will return a single-line result consisting of <strong>NULL</strong> values for aggregation functions, in accordance with SQL standard.</li> </ul> 
userSpecs[].<br>settings.<br>httpConnectionTimeout | **integer** (int64)<br><p>HTTP connection timeout, in milliseconds.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>1000</strong>, 1 second).</p> 
userSpecs[].<br>settings.<br>httpReceiveTimeout | **integer** (int64)<br><p>HTTP receive timeout, in milliseconds.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>1800000</strong>, 1800 seconds, 30 minutes).</p> 
userSpecs[].<br>settings.<br>httpSendTimeout | **integer** (int64)<br><p>HTTP send timeout, in milliseconds.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>1800000</strong>, 1800 seconds, 30 minutes).</p> 
userSpecs[].<br>settings.<br>enableHttpCompression | **boolean** (boolean)<br><p>Enables or disables data compression in HTTP responses.</p> <p>By default, ClickHouse stores data compressed. When executing a query, its result is uncompressed. Use this setting to command ClickHouse to compress the result when sending it via HTTP.</p> <p>Enable this setting and add the <strong>Accept-Encoding: <compression method></strong> HTTP header in a HTTP request to force compression of HTTP response from ClickHouse.</p> <p>ClickHouse support the following compression methods: <strong>gzip</strong>, <strong>br</strong> and <strong>deflate</strong>.</p> <p>Default value: <strong>false</strong> (compression is disabled).</p> <p>See in-depth description in <a href="https://clickhouse.com/docs/en/interfaces/http/">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>sendProgressInHttpHeaders | **boolean** (boolean)<br><p>Enables progress notifications using <strong>X-ClickHouse-Progress</strong> HTTP header.</p> <p>Default value: <strong>false</strong> (notifications disabled).</p> 
userSpecs[].<br>settings.<br>httpHeadersProgressInterval | **integer** (int64)<br><p>Minimum interval between progress notifications with <strong>X-ClickHouse-Progress</strong> HTTP header, in milliseconds.</p> <p>Value must be greater than <strong>0</strong> (default: <strong>100</strong>).</p> 
userSpecs[].<br>settings.<br>addHttpCorsHeader | **boolean** (boolean)<br><p>Adds CORS header in HTTP responses.</p> <p>Default value: <strong>false</strong> (header is not added).</p> 
userSpecs[].<br>settings.<br>cancelHttpReadonlyQueriesOnClientClose | **boolean** (boolean)<br><p>Cancels HTTP read-only queries (e.g. SELECT) when a client closes the connection without waiting for the response.</p> <p>Default value: <strong>false</strong>.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#cancel-http-readonly-queries-on-client-close">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>maxHttpGetRedirects | **integer** (int64)<br><p>Limits the maximum number of HTTP GET redirect hops for <a href="https://clickhouse.com/docs/en/engines/table-engines/special/url">URL-engine</a> tables.</p> <p>If the parameter is set to <strong>0</strong> (default), no hops is allowed.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#setting-max_http_get_redirects">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>joinedSubqueryRequiresAlias | **boolean** (boolean)
userSpecs[].<br>settings.<br>joinUseNulls | **boolean** (boolean)
userSpecs[].<br>settings.<br>transformNullIn | **boolean** (boolean)
userSpecs[].<br>settings.<br>quotaMode | **string**<br><p>Quota accounting mode. Possible values: QUOTA_MODE_DEFAULT, QUOTA_MODE_KEYED and QUOTA_MODE_KEYED_BY_IP.</p> 
userSpecs[].<br>settings.<br>flattenNested | **boolean** (boolean)<br><p>Sets the data format of a <a href="https://clickhouse.com/docs/en/sql-reference/data-types/nested-data-structures/nested">nested</a> columns.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#flatten-nested">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>formatRegexp | **string**<br><p>Regular expression (for Regexp format)</p> 
userSpecs[].<br>settings.<br>formatRegexpEscapingRule | **string**<br><p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#format_regexp_escaping_rule">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>formatRegexpSkipUnmatched | **boolean** (boolean)<br><p>See in-depth description in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#format_regexp_skip_unmatched">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>asyncInsert | **boolean** (boolean)<br><p>Enables asynchronous inserts.</p> <p>Disabled by default.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#async-insert">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>asyncInsertThreads | **integer** (int64)<br><p>The maximum number of threads for background data parsing and insertion.</p> <p>If the parameter is set to <strong>0</strong>, asynchronous insertions are disabled. Default value: <strong>16</strong>.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#async-insert-threads">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>waitForAsyncInsert | **boolean** (boolean)<br><p>Enables waiting for processing of asynchronous insertion. If enabled, server returns OK only after the data is inserted.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#wait-for-async-insert">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>waitForAsyncInsertTimeout | **integer** (int64)<br><p>The timeout (in seconds) for waiting for processing of asynchronous insertion.</p> <p>Default value: <strong>120</strong>.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#wait-for-async-insert-timeout">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>asyncInsertMaxDataSize | **integer** (int64)<br><p>The maximum size of the unparsed data in bytes collected per query before being inserted.</p> <p>If the parameter is set to <strong>0</strong>, asynchronous insertions are disabled. Default value: <strong>100000</strong>.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#async-insert-max-data-size">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>asyncInsertBusyTimeout | **integer** (int64)<br><p>The maximum timeout in milliseconds since the first INSERT query before inserting collected data.</p> <p>If the parameter is set to <strong>0</strong>, the timeout is disabled. Default value: <strong>200</strong>.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#async-insert-busy-timeout-ms">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>asyncInsertStaleTimeout | **integer** (int64)<br><p>The maximum timeout in milliseconds since the last INSERT query before dumping collected data. If enabled, the settings prolongs the ``asyncInsertBusyTimeout`` with every INSERT query as long as ``asyncInsertMaxDataSize`` is not exceeded.</p> <p>More info see in <a href="https://clickhouse.com/docs/en/operations/settings/settings/#async-insert-stale-timeout-ms">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>memoryProfilerStep | **integer** (int64)<br><p>Memory profiler step (in bytes).</p> <p>If the next query step requires more memory than this parameter specifies, the memory profiler collects the allocating stack trace. Values lower than a few megabytes slow down query processing.</p> <p>Default value: <strong>4194304</strong> (4 MB). Zero means disabled memory profiler.</p> 
userSpecs[].<br>settings.<br>memoryProfilerSampleProbability | **number** (double)<br><p>Collect random allocations and deallocations and write them into system.trace_log with 'MemorySample' trace_type. The probability is for every alloc/free regardless to the size of the allocation.</p> <p>Possible values: from <strong>0</strong> to <strong>1</strong>. Default: <strong>0</strong>.</p> 
userSpecs[].<br>settings.<br>compile | **boolean** (boolean)<br><p>The setting is deprecated and has no effect.</p> 
userSpecs[].<br>settings.<br>minCountToCompile | **integer** (int64)<br><p>The setting is deprecated and has no effect.</p> 
userSpecs[].<br>quotas[] | **object**<br><p>Set of quotas assigned to the user.</p> 
userSpecs[].<br>quotas[].<br>intervalDuration | **integer** (int64)<br><p>Duration of interval for quota in milliseconds. Minimal value is 1 second.</p> <p>The minimum value is 1000.</p> 
userSpecs[].<br>quotas[].<br>queries | **integer** (int64)<br><p>The total number of queries. 0 - unlimited.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>quotas[].<br>errors | **integer** (int64)<br><p>The number of queries that threw exception. 0 - unlimited.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>quotas[].<br>resultRows | **integer** (int64)<br><p>The total number of rows given as the result.. 0 - unlimited.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>quotas[].<br>readRows | **integer** (int64)<br><p>The total number of source rows read from tables for running the query, on all remote servers. 0 - unlimited.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>quotas[].<br>executionTime | **integer** (int64)<br><p>The total query execution time, in milliseconds (wall time). 0 - unlimited.</p> <p>The minimum value is 0.</p> 
hostSpecs[] | **object**<br><p>Required. Individual configurations for hosts that should be created for the ClickHouse cluster.</p> <p>Must contain at least one element.</p> 
hostSpecs[].<br>zoneId | **string**<br><p>ID of the availability zone where the host resides. To get a list of available zones, use the <a href="/docs/compute/api-ref/Zone/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
hostSpecs[].<br>type | **string**<br><p>Required. Type of the host to be deployed.</p> <ul> <li>CLICKHOUSE: ClickHouse host.</li> <li>ZOOKEEPER: ZooKeeper host.</li> </ul> 
hostSpecs[].<br>subnetId | **string**<br><p>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the <a href="/docs/managed-clickhouse/api-ref/Cluster#representation">Cluster.networkId</a> field.</p> <p>The maximum string length in characters is 50.</p> 
hostSpecs[].<br>assignPublicIp | **boolean** (boolean)<br><p>Whether the host should get a public IP address on creation.</p> <p>After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with ``assignPublicIp`` set as needed.</p> <p>Possible values:</p> <ul> <li>false - don't assign a public IP to the host.</li> <li>true - the host should have a public IP address.</li> </ul> 
hostSpecs[].<br>shardName | **string**<br><p>Name of the shard that the host is assigned to.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
networkId | **string**<br><p>Required. ID of the network to create the cluster in.</p> <p>The maximum string length in characters is 50.</p> 
shardName | **string**<br><p>Name of the first shard in cluster. If not set, defaults to the value 'shard1'.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
serviceAccountId | **string**<br><p>ID of the service account used for access to Object Storage.</p> 
securityGroupIds[] | **string**<br><p>User security groups</p> 
deletionProtection | **boolean** (boolean)<br><p>Deletion Protection inhibits deletion of the cluster</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 