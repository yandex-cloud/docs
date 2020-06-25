---
editable: false
---

# Method create
Creates a ClickHouse cluster in the specified folder.
 

 
## HTTP request {#https-request}
```
POST https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters
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
        "textLogLevel": "string"
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
    }
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
        "insertQuorum": "integer",
        "connectTimeout": "integer",
        "receiveTimeout": "integer",
        "sendTimeout": "integer",
        "insertQuorumTimeout": "integer",
        "selectSequentialConsistency": true,
        "maxReplicaDelayForDistributedQueries": "integer",
        "fallbackToStaleReplicasForDistributedQueries": true,
        "replicationAlterPartitionsSync": "integer",
        "distributedProductMode": "string",
        "distributedAggregationMemoryEfficient": true,
        "distributedDdlTaskTimeout": "integer",
        "skipUnavailableShards": true,
        "compile": true,
        "minCountToCompile": "integer",
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
        "maxColumnsToRead": "integer",
        "maxTemporaryColumns": "integer",
        "maxTemporaryNonConstColumns": "integer",
        "maxQuerySize": "integer",
        "maxAstDepth": "integer",
        "maxAstElements": "integer",
        "maxExpandedAstElements": "integer",
        "inputFormatValuesInterpretExpressions": true,
        "inputFormatDefaultsForOmittedFields": true,
        "outputFormatJsonQuote_64BitIntegers": true,
        "outputFormatJsonQuoteDenormals": true,
        "lowCardinalityAllowInNativeFormat": true,
        "emptyResultForAggregationByEmptySet": true,
        "httpConnectionTimeout": "integer",
        "httpReceiveTimeout": "integer",
        "httpSendTimeout": "integer",
        "enableHttpCompression": true,
        "sendProgressInHttpHeaders": true,
        "httpHeadersProgressInterval": "integer",
        "addHttpCorsHeader": true
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
  "serviceAccountId": "string"
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder to create the ClickHouse cluster in.</p> <p>The maximum string length in characters is 50.</p> 
name | **string**<br><p>Required. Name of the ClickHouse cluster. The name must be unique within the folder.</p> <p>The maximum string length in characters is 63. Value must match the regular expression <code>[a-zA-Z0-9_-]*</code>.</p> 
description | **string**<br><p>Description of the ClickHouse cluster.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Custom labels for the ClickHouse cluster as <code>key:value</code> pairs. Maximum 64 per resource. For example, &quot;project&quot;: &quot;mvp&quot; or &quot;source&quot;: &quot;dictionary&quot;.</p> <p>No more than 64 per resource. The maximum string length in characters for each key is 63. Each key must match the regular expression <code>[a-z][-_0-9a-z]*</code>. The maximum string length in characters for each value is 63. Each value must match the regular expression <code>[-_0-9a-z]*</code>.</p> 
environment | **string**<br><p>Required. Deployment environment of the ClickHouse cluster.</p> <p>Deployment environment.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
configSpec | **object**<br><p>Required. Configuration and resources for hosts that should be created for the ClickHouse cluster.</p> 
configSpec.<br>version | **string**<br><p>Version of the ClickHouse server software.</p> 
configSpec.<br>clickhouse | **object**<br><p>Configuration and resources for a ClickHouse server.</p> 
configSpec.<br>clickhouse.<br>config | **object**<br><p>Configuration for a ClickHouse server.</p> <p>ClickHouse configuration options. Detailed description for each set of options is available in <a href="https://clickhouse.yandex/docs/ru/operations/server_settings/settings/">ClickHouse documentation</a>.</p> <p>Any options not listed here are not supported.</p> 
configSpec.<br>clickhouse.<br>config.<br>logLevel | **string**<br><p>Logging level for the ClickHouse cluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.</p> 
configSpec.<br>clickhouse.<br>config.<br>mergeTree | **object**<br><p>Settings for the MergeTree engine. See description in <a href="https://clickhouse.yandex/docs/en/operations/server_settings/settings/#merge_tree">ClickHouse documentation</a>.</p> <p>Options specific to the MergeTree table engine.</p> 
configSpec.<br>clickhouse.<br>config.<br>mergeTree.<br>replicatedDeduplicationWindow | **integer** (int64)<br><p>Number of blocks of hashes to keep in ZooKeeper.</p> 
configSpec.<br>clickhouse.<br>config.<br>mergeTree.<br>replicatedDeduplicationWindowSeconds | **integer** (int64)<br><p>Period of time to keep blocks of hashes for.</p> 
configSpec.<br>clickhouse.<br>config.<br>mergeTree.<br>partsToDelayInsert | **integer** (int64)<br><p>If table contains at least that many active parts in single partition, artificially slow down insert into table.</p> 
configSpec.<br>clickhouse.<br>config.<br>mergeTree.<br>partsToThrowInsert | **integer** (int64)<br><p>If more than this number active parts in single partition, throw 'Too many parts ...' exception.</p> 
configSpec.<br>clickhouse.<br>config.<br>mergeTree.<br>maxReplicatedMergesInQueue | **integer** (int64)<br><p>How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue.</p> 
configSpec.<br>clickhouse.<br>config.<br>mergeTree.<br>numberOfFreeEntriesInPoolToLowerMaxSizeOfMerge | **integer** (int64)<br><p>If there is less than specified number of free entries in background pool (or replicated queue), start to lower maximum size of merge to process.</p> 
configSpec.<br>clickhouse.<br>config.<br>mergeTree.<br>maxBytesToMergeAtMinSpaceInPool | **integer** (int64)<br><p>Maximum in total size of parts to merge, when there are minimum free threads in background pool (or entries in replication queue).</p> 
configSpec.<br>clickhouse.<br>config.<br>compression[] | **object**<br><p>Compression settings for the ClickHouse cluster. See in-depth description in <a href="https://clickhouse.yandex/docs/en/operations/server_settings/settings/#compression">ClickHouse documentation</a>.</p> 
configSpec.<br>clickhouse.<br>config.<br>compression[].<br>method | **string**<br><p>Compression method to use for the specified combination of <code>min_part_size</code> and <code>min_part_size_ratio</code>.</p> <ul> <li>LZ4: <a href="https://lz4.github.io/lz4/">LZ4 compression algorithm</a>.</li> <li>ZSTD: <a href="https://facebook.github.io/zstd/">Zstandard compression algorithm</a>.</li> </ul> 
configSpec.<br>clickhouse.<br>config.<br>compression[].<br>minPartSize | **string** (int64)<br><p>Minimum size of a part of a table.</p> <p>The minimum value is 1.</p> 
configSpec.<br>clickhouse.<br>config.<br>compression[].<br>minPartSizeRatio | **number** (double)<br><p>Minimum ratio of a part relative to the size of all the data in the table.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[] | **object**<br><p>Configuration of external dictionaries to be used by the ClickHouse cluster. See in-depth description in <a href="https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts/">ClickHouse documentation</a>.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>name | **string**<br><p>Required. Name of the external dictionary.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure | **object**<br>Required. Set of attributes for the external dictionary. For in-depth description, see [ClickHouse documentation](https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_structure/).<br>
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>id | **object**<br><p>Single numeric key column for the dictionary.</p> <p>Numeric key.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>id.<br>name | **string**<br><p>Required. Name of the numeric key.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>key | **object**<br><p>Composite key for the dictionary, containing of one or more key columns. For details, see <a href="https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key">ClickHouse documentation</a>.</p> <p>Complex key.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>key.<br>attributes[] | **object**<br><p>Required. Attributes of a complex key.</p> <p>Must contain at least one element.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>name | **string**<br><p>Required. Name of the column.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>type | **string**<br><p>Required. Type of the column.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: <code>false</code>.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping &quot;id -&gt; attribute&quot;. Default value: <code>false</code>.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMin | **object**<br><p>Field holding the beginning of the range for dictionaries with <code>RANGE_HASHED</code> layout. For details, see <a href="https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed">ClickHouse documentation</a>.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMin.<br>name | **string**<br><p>Required. Name of the column.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMin.<br>type | **string**<br><p>Required. Type of the column.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMin.<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMin.<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMin.<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: <code>false</code>.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMin.<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping &quot;id -&gt; attribute&quot;. Default value: <code>false</code>.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMax | **object**<br><p>Field holding the end of the range for dictionaries with <code>RANGE_HASHED</code> layout. For details, see <a href="https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed">ClickHouse documentation</a>.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMax.<br>name | **string**<br><p>Required. Name of the column.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMax.<br>type | **string**<br><p>Required. Type of the column.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMax.<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMax.<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMax.<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: <code>false</code>.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMax.<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping &quot;id -&gt; attribute&quot;. Default value: <code>false</code>.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>attributes[] | **object**<br><p>Required. Description of the fields available for database queries. For details, see <a href="https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes">ClickHouse documentation</a>.</p> <p>Must contain at least one element.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>attributes[].<br>name | **string**<br><p>Required. Name of the column.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>attributes[].<br>type | **string**<br><p>Required. Type of the column.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>attributes[].<br>nullValue | **string**<br><p>Default value for an element without data (for example, an empty string).</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>attributes[].<br>expression | **string**<br><p>Expression, describing the attribute, if applicable.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>attributes[].<br>hierarchical | **boolean** (boolean)<br><p>Indication of hierarchy support. Default value: <code>false</code>.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>attributes[].<br>injective | **boolean** (boolean)<br><p>Indication of injective mapping &quot;id -&gt; attribute&quot;. Default value: <code>false</code>.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>layout | **object**<br>Required. Layout for storing the dictionary in memory. For in-depth description, see [ClickHouse documentation](https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_layout/).<br><p>Layout determining how to store the dictionary in memory.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>layout.<br>type | **string**<br><p>Required. Layout type for an external dictionary.</p> <ul> <li>FLAT: The entire dictionary is stored in memory in the form of flat arrays. Available for all dictionary sources.</li> <li>HASHED: The entire dictionary is stored in memory in the form of a hash table. Available for all dictionary sources.</li> <li>COMPLEX_KEY_HASHED: Similar to HASHED, to be used with composite keys. Available for all dictionary sources.</li> <li>RANGE_HASHED: The entire dictionary is stored in memory in the form of a hash table, with an ordered array of ranges and their corresponding values. Available for all dictionary sources.</li> <li>CACHE: The dictionary is stored in a cache with a set number of cells. Available for MySQL, ClickHouse and HTTP dictionary sources.</li> <li>COMPLEX_KEY_CACHE: Similar to CACHE, to be used with composite keys. Available for MySQL, ClickHouse and HTTP dictionary sources.</li> </ul> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>layout.<br>sizeInCells | **string** (int64)<br><p>Number of cells in the cache. Rounded up to a power of two. Applicable only for CACHE and COMPLEX_KEY_CACHE layout types.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>fixedLifetime | **string** (int64) <br>`configSpec.clickhouse.config.dictionaries[]` includes only one of the fields `fixedLifetime`, `lifetimeRange`<br><br><p>Fixed interval between dictionary updates.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>lifetimeRange | **object**<br>Range of intervals between dictionary updates for ClickHouse to choose from. <br>`configSpec.clickhouse.config.dictionaries[]` includes only one of the fields `fixedLifetime`, `lifetimeRange`<br><br>
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>lifetimeRange.<br>min | **string** (int64)<br><p>Minimum dictionary lifetime.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>lifetimeRange.<br>max | **string** (int64)<br><p>Maximum dictionary lifetime.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>httpSource | **object**<br>HTTP source for the dictionary. <br>`configSpec.clickhouse.config.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br><br>
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>httpSource.<br>url | **string**<br><p>Required. URL of the source dictionary available over HTTP.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>httpSource.<br>format | **string**<br><p>Required. The data format. Valid values are all formats supported by ClickHouse SQL dialect.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mysqlSource | **object**<br>MySQL source for the dictionary. <br>`configSpec.clickhouse.config.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br><br>
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
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mysqlSource.<br>invalidateQuery | **string**<br><p>Query for checking the dictionary status, to pull only updated data. For more details, see <a href="https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_lifetime/">ClickHouse documentation on dictionaries</a>.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>clickhouseSource | **object**<br>ClickHouse source for the dictionary. <br>`configSpec.clickhouse.config.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br><br>
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>clickhouseSource.<br>db | **string**<br><p>Required. Name of the ClickHouse database.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>clickhouseSource.<br>table | **string**<br><p>Required. Name of the table in the specified database to be used as the dictionary source.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>clickhouseSource.<br>host | **string**<br><p>Required. ClickHouse host of the specified database.</p> <p>The maximum string length in characters is 253.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>clickhouseSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>clickhouseSource.<br>user | **string**<br><p>Required. Name of the ClickHouse database user.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>clickhouseSource.<br>password | **string**<br><p>Password of the ClickHouse database user.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>clickhouseSource.<br>where | **string**<br><p>Selection criteria for the data in the specified ClickHouse table.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mongodbSource | **object**<br>MongoDB source for the dictionary. <br>`configSpec.clickhouse.config.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br><br>
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mongodbSource.<br>db | **string**<br><p>Required. Name of the MongoDB database.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mongodbSource.<br>collection | **string**<br><p>Required. Name of the collection in the specified database to be used as the dictionary source.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mongodbSource.<br>host | **string**<br><p>Required. MongoDB host of the specified database.</p> <p>The maximum string length in characters is 253.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mongodbSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mongodbSource.<br>user | **string**<br><p>Required. Name of the MongoDB database user.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mongodbSource.<br>password | **string**<br><p>Password of the MongoDB database user.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>postgresqlSource | **object**<br>PostgreSQL source for the dictionary. <br>`configSpec.clickhouse.config.dictionaries[]` includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br><br>
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>postgresqlSource.<br>db | **string**<br><p>Required. Name of the PostrgreSQL database.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>postgresqlSource.<br>table | **string**<br><p>Required. Name of the table in the specified database to be used as the dictionary source.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>postgresqlSource.<br>hosts[] | **string**<br><p>Required. Name of the PostrgreSQL host</p> <p>Must contain at least one element.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>postgresqlSource.<br>port | **string** (int64)<br><p>Port to use when connecting to the host.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>postgresqlSource.<br>user | **string**<br><p>Required. Name of the PostrgreSQL database user.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>postgresqlSource.<br>password | **string**<br><p>Password of the PostrgreSQL database user.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>postgresqlSource.<br>invalidateQuery | **string**<br><p>Query for checking the dictionary status, to pull only updated data. For more details, see <a href="https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_lifetime/">ClickHouse documentation on dictionaries</a>.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>postgresqlSource.<br>sslMode | **string**<br><p>Mode of SSL TCP/IP connection to the PostgreSQL host. For more details, see <a href="https://www.postgresql.org/docs/current/libpq-ssl.html">PostgreSQL documentation</a>.</p> <ul> <li>DISABLE: Only try a non-SSL connection.</li> <li>ALLOW: First try a non-SSL connection; if that fails, try an SSL connection.</li> <li>PREFER: First try an SSL connection; if that fails, try a non-SSL connection.</li> <li>VERIFY_CA: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).</li> <li>VERIFY_FULL: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.</li> </ul> 
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup[] | **object**<br><p>Rollup settings for the GraphiteMergeTree table engine.</p> 
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup[].<br>name | **string**<br><p>Required. Name for the specified combination of settings for Graphite rollup.</p> 
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup[].<br>patterns[] | **object**<br><p>Required. Pattern to use for the rollup.</p> <p>Must contain at least one element.</p> 
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup[].<br>patterns[].<br>regexp | **string**<br><p>Pattern for metric names.</p> 
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup[].<br>patterns[].<br>function | **string**<br><p>Required. Name of the aggregating function to apply to data of the age specified in <code>retention</code>.</p> 
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup[].<br>patterns[].<br>retention[] | **object**<br><p>Required. Age of data to use for thinning.</p> <p>Must contain at least one element.</p> 
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup[].<br>patterns[].<br>retention[].<br>age | **string** (int64)<br><p>Minimum age of the data in seconds.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup[].<br>patterns[].<br>retention[].<br>precision | **string** (int64)<br><p>Precision of determining the age of the data, in seconds.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>clickhouse.<br>config.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections.</p> <p>The minimum value is 10.</p> 
configSpec.<br>clickhouse.<br>config.<br>maxConcurrentQueries | **integer** (int64)<br><p>Maximum number of simultaneously processed requests.</p> <p>The minimum value is 10.</p> 
configSpec.<br>clickhouse.<br>config.<br>keepAliveTimeout | **integer** (int64)<br><p>Number of milliseconds that ClickHouse waits for incoming requests before closing the connection.</p> 
configSpec.<br>clickhouse.<br>config.<br>uncompressedCacheSize | **integer** (int64)<br><p>Cache size (in bytes) for uncompressed data used by MergeTree tables.</p> 
configSpec.<br>clickhouse.<br>config.<br>markCacheSize | **integer** (int64)<br><p>Approximate size (in bytes) of the cache of &quot;marks&quot; used by MergeTree tables.</p> <p>Value must be greater than 5368709120.</p> 
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
configSpec.<br>clickhouse.<br>resources | **object**<br><p>Resources allocated to ClickHouse hosts.</p> 
configSpec.<br>clickhouse.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-clickhouse/concepts/instance-types">documentation</a></p> 
configSpec.<br>clickhouse.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>clickhouse.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd — network HDD drive,</li> <li>network-ssd — network SSD drive,</li> <li>local-ssd — local SSD storage.</li> </ul> 
configSpec.<br>zookeeper | **object**<br><p>Configuration and resources for a ZooKeeper server.</p> 
configSpec.<br>zookeeper.<br>resources | **object**<br><p>Resources allocated to ZooKeeper hosts. If not set, minimal available resources will be used. All available resource presets can be retrieved with a <a href="/docs/managed-clickhouse/api-ref/ResourcePreset/list">list</a> request.</p> 
configSpec.<br>zookeeper.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-clickhouse/concepts/instance-types">documentation</a></p> 
configSpec.<br>zookeeper.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>zookeeper.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd — network HDD drive,</li> <li>network-ssd — network SSD drive,</li> <li>local-ssd — local SSD storage.</li> </ul> 
configSpec.<br>backupWindowStart | **object**<br><p>Time to start the daily backup, in the UTC timezone.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
configSpec.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value &quot;24:00:00&quot; for scenarios like business closing time.</p> 
configSpec.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
configSpec.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
configSpec.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
configSpec.<br>access | **object**<br><p>Access policy to DB</p> 
configSpec.<br>access.<br>dataLens | **boolean** (boolean)<br><p>Allow access for DataLens</p> 
configSpec.<br>access.<br>webSql | **boolean** (boolean)<br><p>Allow access for Web SQL</p> 
configSpec.<br>access.<br>metrika | **boolean** (boolean)<br><p>Allow access for Metrika</p> 
configSpec.<br>access.<br>serverless | **boolean** (boolean)<br><p>Allow access for Serverless</p> 
databaseSpecs[] | **object**<br><p>Required. Descriptions of databases to be created in the ClickHouse cluster.</p> <p>Must contain at least one element.</p> 
databaseSpecs[].<br>name | **string**<br><p>Required. Name of the ClickHouse database. 1-63 characters long.</p> <p>The maximum string length in characters is 63. Value must match the regular expression <code>[a-zA-Z0-9_-]*</code>.</p> 
userSpecs[] | **object**<br><p>Required. Descriptions of database users to be created in the ClickHouse cluster.</p> <p>Must contain at least one element.</p> 
userSpecs[].<br>name | **string**<br><p>Required. Name of the ClickHouse user.</p> <p>The maximum string length in characters is 63. Value must match the regular expression <code>[a-zA-Z0-9_]*</code>.</p> 
userSpecs[].<br>password | **string**<br><p>Required. Password of the ClickHouse user.</p> <p>The string length in characters must be 8-128.</p> 
userSpecs[].<br>permissions[] | **object**<br><p>Set of permissions to grant to the user.</p> 
userSpecs[].<br>permissions[].<br>databaseName | **string**<br><p>Name of the database that the permission grants access to.</p> 
userSpecs[].<br>settings | **object**<br><p>ClickHouse user settings. Supported settings are a limited subset of all settings described in <a href="https://clickhouse.yandex/docs/en/operations/settings/">ClickHouse documentation</a>.</p> 
userSpecs[].<br>settings.<br>readonly | **integer** (int64)<br><p>Restricts permissions for non-DDL queries. Possible values: 0 (default) — no restrictions, 1 — only read data queries are allowed, 2 — read data and change settings queries are allowed.</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
userSpecs[].<br>settings.<br>allowDdl | **boolean** (boolean)<br><p>Whether DDL queries are allowed. Default value: false.</p> 
userSpecs[].<br>settings.<br>insertQuorum | **integer** (int64)<br><p>For INSERT queries in the replicated table, wait writing for the specified number of replicas and linearize the addition of the data.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>connectTimeout | **integer** (int64)<br><p>Connection timeout in milliseconds.</p> <p>Value must be greater than 0.</p> 
userSpecs[].<br>settings.<br>receiveTimeout | **integer** (int64)<br><p>Receive timeout in milliseconds.</p> <p>Value must be greater than 0.</p> 
userSpecs[].<br>settings.<br>sendTimeout | **integer** (int64)<br><p>Send timeout in milliseconds.</p> <p>Value must be greater than 0.</p> 
userSpecs[].<br>settings.<br>insertQuorumTimeout | **integer** (int64)<br><p>Quorum write timeout in milliseconds. Default value: 60000.</p> <p>The minimum value is 1000.</p> 
userSpecs[].<br>settings.<br>selectSequentialConsistency | **boolean** (boolean)<br><p>For SELECT queries from the replicated table, throw an exception if the replica does not have a chunk written with the quorum; do not read the parts that have not yet been written with the quorum.</p> 
userSpecs[].<br>settings.<br>maxReplicaDelayForDistributedQueries | **integer** (int64)<br><p>Max replica delay in milliseconds. If a replica lags more than the set value, this replica is not used. Default value: 300000.</p> <p>The minimum value is 1000.</p> 
userSpecs[].<br>settings.<br>fallbackToStaleReplicasForDistributedQueries | **boolean** (boolean)<br><p>Determine the behavior when all replicas for the queried table are stale. If enabled, the query will be performed anyway. Otherwise, the error will be thrown.</p> 
userSpecs[].<br>settings.<br>replicationAlterPartitionsSync | **integer** (int64)<br><p>Wait mode for ALTER queries on replicated tables. Possible values: 0 - do not wait, 1 - wait for execution only of itself, 2 - wait for everyone.</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
userSpecs[].<br>settings.<br>distributedProductMode | **string**<br><p>Determine the behavior of distributed subqueries. Possible values: DISTRIBUTED_PRODUCT_MODE_DENY, DISTRIBUTED_PRODUCT_MODE_LOCAL, DISTRIBUTED_PRODUCT_MODE_GLOBAL, DISTRIBUTED_PRODUCT_MODE_ALLOW.</p> <ul> <li>DISTRIBUTED_PRODUCT_MODE_DENY: Default value. Prohibits using these types of subqueries (returns the &quot;Double-distributed in/JOIN subqueries is denied&quot; exception).</li> <li>DISTRIBUTED_PRODUCT_MODE_LOCAL: Replaces the database and table in the subquery with local ones for the destination server (shard), leaving the normal IN/JOIN.</li> <li>DISTRIBUTED_PRODUCT_MODE_GLOBAL: Replaces the IN/JOIN query with GLOBAL IN/GLOBAL JOIN.</li> <li>DISTRIBUTED_PRODUCT_MODE_ALLOW: Allows the use of these types of subqueries.</li> </ul> 
userSpecs[].<br>settings.<br>distributedAggregationMemoryEfficient | **boolean** (boolean)<br><p>Whether the memory-saving mode of distributed aggregation is enabled.</p> 
userSpecs[].<br>settings.<br>distributedDdlTaskTimeout | **integer** (int64)<br><p>Timeout for DDL queries, in milliseconds.</p> 
userSpecs[].<br>settings.<br>skipUnavailableShards | **boolean** (boolean)<br><p>Whether unavailable shards can be skipped.</p> 
userSpecs[].<br>settings.<br>compile | **boolean** (boolean)<br><p>Whether query compilation is enabled.</p> 
userSpecs[].<br>settings.<br>minCountToCompile | **integer** (int64)<br><p>The number of structurally identical queries before they are compiled.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>compileExpressions | **boolean** (boolean)<br><p>Whether expression compilation is enabled.</p> 
userSpecs[].<br>settings.<br>minCountToCompileExpression | **integer** (int64)<br><p>The number of identical expressions before they are compiled.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>maxBlockSize | **integer** (int64)<br><p>The maximum block size for reading.</p> <p>Value must be greater than 0.</p> 
userSpecs[].<br>settings.<br>minInsertBlockSizeRows | **integer** (int64)<br><p>Squash blocks passed to INSERT query to specified size in rows, if blocks are not big enough. If set to 0, blocks will never be squashed.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>minInsertBlockSizeBytes | **integer** (int64)<br><p>Squash blocks passed to INSERT query to specified size in bytes, if blocks are not big enough. If set to 0, blocks will never be squashed.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>maxInsertBlockSize | **integer** (int64)<br><p>The maximum block size for insertion.</p> <p>Value must be greater than 0.</p> 
userSpecs[].<br>settings.<br>minBytesToUseDirectIo | **integer** (int64)<br><p>The minimum number of bytes for reading the data with O_DIRECT option during SELECT queries execution.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>useUncompressedCache | **boolean** (boolean)<br><p>Whether to use the cache of uncompressed blocks.</p> 
userSpecs[].<br>settings.<br>mergeTreeMaxRowsToUseCache | **integer** (int64)<br><p>The maximum request size in rows to use the cache of uncompressed data. The cache is not used for requests larger than the specified value.</p> <p>Value must be greater than 0.</p> 
userSpecs[].<br>settings.<br>mergeTreeMaxBytesToUseCache | **integer** (int64)<br><p>The maximum request size in bytes to use the cache of uncompressed data. The cache is not used for requests larger than the specified value.</p> <p>Value must be greater than 0.</p> 
userSpecs[].<br>settings.<br>mergeTreeMinRowsForConcurrentRead | **integer** (int64)<br><p>The minimum number of rows to be read from a file to enable concurrent read.</p> <p>Value must be greater than 0.</p> 
userSpecs[].<br>settings.<br>mergeTreeMinBytesForConcurrentRead | **integer** (int64)<br><p>The minimum number of bytes to be read from a file to enable concurrent read.</p> <p>Value must be greater than 0.</p> 
userSpecs[].<br>settings.<br>maxBytesBeforeExternalGroupBy | **integer** (int64)<br>
userSpecs[].<br>settings.<br>maxBytesBeforeExternalSort | **integer** (int64)<br>
userSpecs[].<br>settings.<br>groupByTwoLevelThreshold | **integer** (int64)<br>
userSpecs[].<br>settings.<br>groupByTwoLevelThresholdBytes | **integer** (int64)<br>
userSpecs[].<br>settings.<br>priority | **integer** (int64)<br><p>Priority of the query.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>maxThreads | **integer** (int64)<br><p>The maximum number of threads to execute the request.</p> <p>Value must be greater than 0.</p> 
userSpecs[].<br>settings.<br>maxMemoryUsage | **integer** (int64)<br><p>The maximum memory usage for processing of a single query.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>maxMemoryUsageForUser | **integer** (int64)<br><p>The maximum memory usage for processing all concurrently running queries for the user.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>maxNetworkBandwidth | **integer** (int64)<br><p>The maximum speed of data exchange over the network in bytes per second for a query.</p> 
userSpecs[].<br>settings.<br>maxNetworkBandwidthForUser | **integer** (int64)<br><p>The maximum speed of data exchange over the network in bytes per second for all concurrently running user queries.</p> 
userSpecs[].<br>settings.<br>forceIndexByDate | **boolean** (boolean)<br><p>Disables query execution if the index can’t be used by date.</p> 
userSpecs[].<br>settings.<br>forcePrimaryKey | **boolean** (boolean)<br><p>Disables query execution if indexing by the primary key is not possible.</p> 
userSpecs[].<br>settings.<br>maxRowsToRead | **integer** (int64)<br><p>The maximum number of rows that can be read from a table when running a query.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>maxBytesToRead | **integer** (int64)<br><p>The maximum number of bytes (uncompressed data) that can be read from a table when running a query.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>readOverflowMode | **string**<br><p>Determine the behavior on exceeding max_rows_to_read or max_bytes_to_read limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.</p> 
userSpecs[].<br>settings.<br>maxRowsToGroupBy | **integer** (int64)<br><p>The maximum number of unique keys received from aggregation.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>groupByOverflowMode | **string**<br><p>Determine the behavior on exceeding max_rows_to_group_by limit. Possible values: GROUP_BY_OVERFLOW_MODE_THROW, GROUP_BY_OVERFLOW_MODE_BREAK, GROUP_BY_OVERFLOW_MODE_ANY.</p> 
userSpecs[].<br>settings.<br>maxRowsToSort | **integer** (int64)<br><p>The maximum number of rows before sorting.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>maxBytesToSort | **integer** (int64)<br><p>The maximum number of bytes before sorting.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>sortOverflowMode | **string**<br><p>Determine the behavior on exceeding max_rows_to_sort or max_bytes_to_sort limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.</p> 
userSpecs[].<br>settings.<br>maxResultRows | **integer** (int64)<br><p>Limit on the number of rows in the result.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>maxResultBytes | **integer** (int64)<br><p>Limit on the number of bytes in the result.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>resultOverflowMode | **string**<br><p>Determine the behavior on exceeding max_result_rows or max_result_bytes limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.</p> 
userSpecs[].<br>settings.<br>maxRowsInDistinct | **integer** (int64)<br><p>The maximum number of different rows when using DISTINCT.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>maxBytesInDistinct | **integer** (int64)<br><p>The maximum number of bytes used by a hash table when using DISTINCT.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>distinctOverflowMode | **string**<br><p>Determine the behavior on exceeding max_rows_in_distinct or max_bytes_in_distinct limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.</p> 
userSpecs[].<br>settings.<br>maxRowsToTransfer | **integer** (int64)<br><p>The maximum number of rows that can be passed to a remote server or saved in a temporary table when using GLOBAL IN.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>maxBytesToTransfer | **integer** (int64)<br><p>The maximum number of bytes (uncompressed data) that can be passed to a remote server or saved in a temporary table when using GLOBAL IN.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>transferOverflowMode | **string**<br><p>Determine the behavior on exceeding max_rows_to_transfer or max_bytes_to_transfer limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.</p> 
userSpecs[].<br>settings.<br>maxExecutionTime | **integer** (int64)<br><p>The maximum query execution time in milliseconds.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>timeoutOverflowMode | **string**<br><p>Determine the behavior on exceeding max_execution_time limit. Possible values: OVERFLOW_MODE_THROW, OVERFLOW_MODE_BREAK.</p> 
userSpecs[].<br>settings.<br>maxColumnsToRead | **integer** (int64)<br><p>The maximum number of columns that can be read from a table in a single query.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>maxTemporaryColumns | **integer** (int64)<br><p>The maximum number of temporary columns that must be kept in RAM at the same time when running a query, including constant columns.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>maxTemporaryNonConstColumns | **integer** (int64)<br><p>The maximum number of temporary columns that must be kept in RAM at the same time when running a query, excluding constant columns.</p> <p>The minimum value is 0.</p> 
userSpecs[].<br>settings.<br>maxQuerySize | **integer** (int64)<br><p>The maximum part of a query that can be taken to RAM for parsing with the SQL parser, in bytes. Default value: 262144.</p> <p>Value must be greater than 0.</p> 
userSpecs[].<br>settings.<br>maxAstDepth | **integer** (int64)<br><p>The maximum depth of query syntax tree. Default value: 1000.</p> <p>Value must be greater than 0.</p> 
userSpecs[].<br>settings.<br>maxAstElements | **integer** (int64)<br><p>The maximum size of query syntax tree in number of nodes. Default value: 50000.</p> <p>Value must be greater than 0.</p> 
userSpecs[].<br>settings.<br>maxExpandedAstElements | **integer** (int64)<br><p>The maximum size of query syntax tree in number of nodes after expansion of aliases and the asterisk. Default value: 500000.</p> <p>Value must be greater than 0.</p> 
userSpecs[].<br>settings.<br>inputFormatValuesInterpretExpressions | **boolean** (boolean)<br><p>Enables or disables the full SQL parser if the fast stream parser cannot parse the data.</p> 
userSpecs[].<br>settings.<br>inputFormatDefaultsForOmittedFields | **boolean** (boolean)<br><p>When performing INSERT queries, replace omitted input column values with default values of the respective columns.</p> 
userSpecs[].<br>settings.<br>outputFormatJsonQuote_64BitIntegers | **boolean** (boolean)<br><p>Whether quoting of 64-bit integers is enabled in JSON output format.</p> 
userSpecs[].<br>settings.<br>outputFormatJsonQuoteDenormals | **boolean** (boolean)<br><p>Whether output of special floating-point values (+nan, -nan, +inf and -inf) is enabled in JSON output format.</p> 
userSpecs[].<br>settings.<br>lowCardinalityAllowInNativeFormat | **boolean** (boolean)<br><p>Whether LowCardinality type is enabled in Native format.</p> 
userSpecs[].<br>settings.<br>emptyResultForAggregationByEmptySet | **boolean** (boolean)<br><p>Return empty result when aggregating without keys on empty set.</p> 
userSpecs[].<br>settings.<br>httpConnectionTimeout | **integer** (int64)<br><p>HTTP connection timeout, in milliseconds.</p> 
userSpecs[].<br>settings.<br>httpReceiveTimeout | **integer** (int64)<br><p>HTTP receive timeout, in milliseconds.</p> 
userSpecs[].<br>settings.<br>httpSendTimeout | **integer** (int64)<br><p>HTTP send timeout, in milliseconds.</p> 
userSpecs[].<br>settings.<br>enableHttpCompression | **boolean** (boolean)<br><p>Whether data compression is enabled in HTTP responses.</p> 
userSpecs[].<br>settings.<br>sendProgressInHttpHeaders | **boolean** (boolean)<br><p>Whether progress notifications using X-ClickHouse-Progress headers are enabled. Default value: false.</p> 
userSpecs[].<br>settings.<br>httpHeadersProgressInterval | **integer** (int64)<br><p>Minimum interval between progress notifications, in milliseconds. Default value: 100.</p> 
userSpecs[].<br>settings.<br>addHttpCorsHeader | **boolean** (boolean)<br><p>Whether CORS header in HTTP responses is enabled. Default value: false.</p> 
userSpecs[].<br>quotas[] | **object**<br><p>ClickHouse quota representation. Each quota associated with an user and limits it resource usage for an interval. See in-depth description <a href="https://clickhouse.yandex/docs/en/operations/quotas/">ClickHouse documentation</a>.</p> 
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
hostSpecs[].<br>assignPublicIp | **boolean** (boolean)<br><p>Whether the host should get a public IP address on creation.</p> <p>After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with <code>assignPublicIp</code> set as needed.</p> <p>Possible values:</p> <ul> <li>false — don't assign a public IP to the host.</li> <li>true — the host should have a public IP address.</li> </ul> 
hostSpecs[].<br>shardName | **string**<br><p>Name of the shard that the host is assigned to.</p> <p>The maximum string length in characters is 63. Value must match the regular expression <code>[a-zA-Z0-9_-]*</code>.</p> 
networkId | **string**<br><p>Required. ID of the network to create the cluster in.</p> <p>The maximum string length in characters is 50.</p> 
shardName | **string**<br><p>Name of the first shard in cluster. If not set, defaults to the value 'shard1'.</p> <p>The maximum string length in characters is 63. Value must match the regular expression <code>[a-zA-Z0-9_-]*</code>.</p> 
serviceAccountId | **string**<br><p>ID of the service account used for access to Yandex Object Storage.</p> 
 
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
done | **boolean** (boolean)<br><p>If the value is <code>false</code>, it means the operation is still in progress. If <code>true</code>, the operation is completed, and either <code>error</code> or <code>response</code> is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 