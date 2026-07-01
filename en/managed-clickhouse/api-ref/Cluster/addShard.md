---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}/shards
    method: post
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the ClickHouse cluster to add a shard to.
            To get the ClickHouse cluster ID, use a [ClusterService.List](/docs/managed-clickhouse/api-ref/Cluster/list#List) request.
            The maximum string length in characters is 50.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        shardName:
          description: |-
            **string**
            Required field. Name for the new shard.
            The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_][a-zA-Z0-9_-]* `.
          pattern: '[a-zA-Z0-9_][a-zA-Z0-9_-]*'
          type: string
        configSpec:
          description: |-
            **[ShardConfigSpec](#yandex.cloud.mdb.clickhouse.v1.ShardConfigSpec)**
            Configuration of the new shard.
          $ref: '#/definitions/ShardConfigSpec'
        hostSpecs:
          description: |-
            **[HostSpec](#yandex.cloud.mdb.clickhouse.v1.HostSpec)**
            Configurations for ClickHouse hosts that should be created with the shard.
          type: array
          items:
            $ref: '#/definitions/HostSpec'
        copySchema:
          description: |-
            **boolean**
            Whether to copy schema to hosts of the shard to be created. The schema is copied from hosts of an existing shard.
          type: boolean
      required:
        - shardName
      additionalProperties: false
    definitions:
      AccessControlImprovements:
        type: object
        properties:
          selectFromSystemDbRequiresGrant:
            description: |-
              **boolean**
              Sets whether **SELECT * FROM system.&lt;table&gt;** requires any grants and can be executed by any user.
              If set to true then this query requires **GRANT SELECT ON system.&lt;table&gt;** just as for non-system tables.
              Default value: **false**.
            default: '**false**'
            type: boolean
          selectFromInformationSchemaRequiresGrant:
            description: |-
              **boolean**
              Sets whether **SELECT * FROM information_schema.&lt;table&gt;** requires any grants and can be executed by any user.
              If set to true, then this query requires **GRANT SELECT ON information_schema.&lt;table&gt;**, just as for ordinary tables.
              Default value: **false**.
            default: '**false**'
            type: boolean
      MergeTree:
        type: object
        properties:
          partsToDelayInsert:
            description: |-
              **string** (int64)
              If the number of active parts in a single partition exceeds the **parts_to_delay_insert** value, an **INSERT** artificially slows down.
              Default value: **1000** for versions 25.1 and higher, **150** for versions 24.12 and lower.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#parts_to_delay_insert).
            type: string
            format: int64
          partsToThrowInsert:
            description: |-
              **string** (int64)
              If the number of active parts in a single partition exceeds the **parts_to_throw_insert** value, an **INSERT**
              is interrupted with the error "Too many parts (N). Merges are processing significantly slower than inserts".
              Default value: **3000** for versions 25.1 and higher, **300** for versions 24.12 and lower.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#parts_to_throw_insert).
            type: string
            format: int64
          inactivePartsToDelayInsert:
            description: |-
              **string** (int64)
              If the number of inactive parts in a single partition in the table exceeds the **inactive_parts_to_delay_insert** value,
              an **INSERT** is artificially slowed down.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#inactive_parts_to_delay_insert).
            type: string
            format: int64
          inactivePartsToThrowInsert:
            description: |-
              **string** (int64)
              If the number of inactive parts in a single partition more than the **inactive_parts_to_throw_insert** value,
              **INSERT** is interrupted with an error.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#inactive_parts_to_throw_insert).
            type: string
            format: int64
          maxAvgPartSizeForTooManyParts:
            description: |-
              **string** (int64)
              The "Too many parts" check according to **parts_to_delay_insert** and **parts_to_throw_insert** will be active only if the average
              part size (in the relevant partition) is not larger than the specified threshold. If it is larger than the specified threshold,
              **INSERT** queries will be neither delayed or rejected. This allows to have hundreds of terabytes in a single table on a single server
              if the parts are successfully merged to larger parts. This does not affect the thresholds on inactive parts or total parts.
              Default value: **1073741824** (1 GiB).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_avg_part_size_for_too_many_parts).
            type: string
            format: int64
          maxPartsInTotal:
            description: |-
              **string** (int64)
              If the total number of active parts in all partitions of a table exceeds the **max_parts_in_total** value,
              an **INSERT** is interrupted with the error "Too many parts (N)".
              Default value: **20000** for versions 25.2 and higher, **100000** for versions 25.1 and lower.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_parts_in_total).
            type: string
            format: int64
          maxReplicatedMergesInQueue:
            description: |-
              **string** (int64)
              How many tasks of merging and mutating parts are allowed simultaneously in ReplicatedMergeTree queue.
              Default value: **32** for versions 25.8 and higher, **16** for versions 25.7 and lower.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_replicated_merges_in_queue).
            type: string
            format: int64
          numberOfFreeEntriesInPoolToLowerMaxSizeOfMerge:
            description: |-
              **string** (int64)
              When there is less than the specified number of free entries in pool (or replicated queue), start to lower maximum size of
              merge to process (or to put in queue). This is to allow small merges to process - not filling the pool with long running merges.
              Default value: **8**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#number_of_free_entries_in_pool_to_lower_max_size_of_merge).
            type: string
            format: int64
          numberOfFreeEntriesInPoolToExecuteMutation:
            description: |-
              **string** (int64)
              When there is less than specified number of free entries in pool, do not execute part mutations.
              This is to leave free threads for regular merges and to avoid "Too many parts" errors.
              Default value: **20**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#number_of_free_entries_in_pool_to_execute_mutation).
            type: string
            format: int64
          numberOfFreeEntriesInPoolToExecuteOptimizeEntirePartition:
            description: |-
              **string** (int64)
              When there is less than specified number of free entries in pool, do not execute optimizing entire partition in the background (this task generated when set min_age_to_force_merge_seconds and enable min_age_to_force_merge_on_partition_only).
              This is to leave free threads for regular merges and avoid "Too many parts".
              Default value: **25**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#number_of_free_entries_in_pool_to_execute_optimize_entire_partition).
            type: string
            format: int64
          maxBytesToMergeAtMinSpaceInPool:
            description: |-
              **string** (int64)
              The maximum total part size (in bytes) to be merged into one part, with the minimum available resources in the background pool.
              Default value: **1048576** (1 MiB).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_bytes_to_merge_at_min_space_in_pool).
            type: string
            format: int64
          maxBytesToMergeAtMaxSpaceInPool:
            description: |-
              **string** (int64)
              The maximum total parts size (in bytes) to be merged into one part, if there are enough resources available.
              Corresponds roughly to the maximum possible part size created by an automatic background merge. **0** means merges will be disabled.
              Default value: **161061273600** (150 GiB).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_bytes_to_merge_at_max_space_in_pool).
            type: string
            format: int64
          minBytesForWidePart:
            description: |-
              **string** (int64)
              Minimum number of bytes in a data part that can be stored in Wide format.
              Default value: **10485760** (10 MiB).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_bytes_for_wide_part).
            type: string
            format: int64
          minRowsForWidePart:
            description: |-
              **string** (int64)
              Minimum number of rows in a data part that can be stored in Wide format.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_rows_for_wide_part).
            type: string
            format: int64
          cleanupDelayPeriod:
            description: |-
              **string** (int64)
              Minimum period to clean old queue logs, blocks hashes and parts.
              Default value: **30**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#cleanup_delay_period).
            type: string
            format: int64
          maxCleanupDelayPeriod:
            description: |-
              **string** (int64)
              Maximum period to clean old queue logs, blocks hashes and parts.
              Default value: **300** (5 minutes).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_cleanup_delay_period).
            type: string
            format: int64
          mergeSelectingSleepMs:
            description: |-
              **string** (int64)
              Minimum time to wait before trying to select parts to merge again after no parts were selected. A lower setting value will trigger
              selecting tasks in background_schedule_pool frequently which result in large amount of requests to Keeper in large-scale clusters.
              Default value: **5000** (5 seconds).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#merge_selecting_sleep_ms).
            type: string
            format: int64
          maxMergeSelectingSleepMs:
            description: |-
              **string** (int64)
              Maximum time to wait before trying to select parts to merge again after no parts were selected. A lower setting value will trigger
              selecting tasks in background_schedule_pool frequently which result in large amount of requests to Keeper in large-scale clusters.
              Default value: **60000** (1 minute).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_merge_selecting_sleep_ms).
            type: string
            format: int64
          minAgeToForceMergeSeconds:
            description: |-
              **string** (int64)
              Merge parts if every part in the range is older than the specified value. **0** means disabled.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_age_to_force_merge_seconds).
            type: string
            format: int64
          minAgeToForceMergeOnPartitionOnly:
            description: |-
              **boolean**
              Whether **min_age_to_force_merge_seconds** should be applied only on the entire partition and not on subset.
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_age_to_force_merge_on_partition_only).
            type: boolean
          mergeMaxBlockSize:
            description: |-
              **string** (int64)
              The number of rows that are read from the merged parts into memory.
              Default value: **8192**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#merge_max_block_size).
            type: string
            format: int64
          deduplicateMergeProjectionMode:
            description: |-
              **enum** (DeduplicateMergeProjectionMode)
              Determines the behavior of background merges for MergeTree tables with projections.
              Default value: **DEDUPLICATE_MERGE_PROJECTION_MODE_THROW**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#deduplicate_merge_projection_mode).
              - `DEDUPLICATE_MERGE_PROJECTION_MODE_IGNORE`: Ignore projections during the merge without rebuilding them. Kept for compatibility only; may result in incorrect query answers.
              - `DEDUPLICATE_MERGE_PROJECTION_MODE_THROW`: Throw an exception and refuse to merge if a projection exists.
              - `DEDUPLICATE_MERGE_PROJECTION_MODE_DROP`: Drop projections before merging and do not rebuild them afterwards.
              - `DEDUPLICATE_MERGE_PROJECTION_MODE_REBUILD`: Rebuild projections during the merge.
            type: string
            enum:
              - DEDUPLICATE_MERGE_PROJECTION_MODE_UNSPECIFIED
              - DEDUPLICATE_MERGE_PROJECTION_MODE_IGNORE
              - DEDUPLICATE_MERGE_PROJECTION_MODE_THROW
              - DEDUPLICATE_MERGE_PROJECTION_MODE_DROP
              - DEDUPLICATE_MERGE_PROJECTION_MODE_REBUILD
          lightweightMutationProjectionMode:
            description: |-
              **enum** (LightweightMutationProjectionMode)
              Determines the behavior of lightweight deletes for MergeTree tables with projections.
              Default value: **LIGHTWEIGHT_MUTATION_PROJECTION_MODE_THROW**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#lightweight_mutation_projection_mode).
              - `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_THROW`: Throw an exception if a projection exists.
              - `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_DROP`: Drop projections and proceed with the lightweight mutation without rebuilding them.
              - `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_REBUILD`: Rebuild projections after applying the lightweight mutation.
            type: string
            enum:
              - LIGHTWEIGHT_MUTATION_PROJECTION_MODE_UNSPECIFIED
              - LIGHTWEIGHT_MUTATION_PROJECTION_MODE_THROW
              - LIGHTWEIGHT_MUTATION_PROJECTION_MODE_DROP
              - LIGHTWEIGHT_MUTATION_PROJECTION_MODE_REBUILD
          replicatedDeduplicationWindow:
            description: |-
              **string** (int64)
              The number of most recently inserted blocks for which ClickHouse Keeper stores hash sums to check for duplicates.
              Default value: **10000** for versions 25.9 and higher, **1000** for versions from 23.11 to 25.8, **100** for versions 23.10 and lower.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#replicated_deduplication_window).
            type: string
            format: int64
          replicatedDeduplicationWindowSeconds:
            description: |-
              **string** (int64)
              The number of seconds after which the hash sums of the inserted blocks are removed from ClickHouse Keeper.
              Default value: **3600** (1 hour) for versions 25.10 and higher, **604800** (7 days) for versions 25.9 and lower.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#replicated_deduplication_window_seconds).
            type: string
            format: int64
          replicatedDeduplicationWindowForAsyncInserts:
            description: |-
              **string** (int64)
              The number of most recently async inserted blocks for which ClickHouse Keeper stores hash sums to check for duplicates.
              Default value: **10000**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#replicated_deduplication_window_for_async_inserts).
            type: string
            format: int64
          replicatedDeduplicationWindowSecondsForAsyncInserts:
            description: |-
              **string** (int64)
              The number of seconds after which the hash sums of the async inserts are removed from ClickHouse Keeper.
              Default value: **604800** (7 days).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#replicated_deduplication_window_seconds_for_async_inserts).
            type: string
            format: int64
          fsyncAfterInsert:
            description: |-
              **boolean**
              Do fsync for every inserted part. Significantly decreases performance of inserts, not recommended to use with wide parts.
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#fsync_after_insert).
            type: boolean
          fsyncPartDirectory:
            description: |-
              **boolean**
              Do fsync for part directory after all part operations (writes, renames, etc.).
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#fsync_part_directory).
            type: boolean
          minCompressedBytesToFsyncAfterFetch:
            description: |-
              **string** (int64)
              Minimal number of compressed bytes to do fsync for part after fetch. **0** means disabled.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_compressed_bytes_to_fsync_after_fetch).
            type: string
            format: int64
          minCompressedBytesToFsyncAfterMerge:
            description: |-
              **string** (int64)
              Minimal number of compressed bytes to do fsync for part after merge. **0** means disabled.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_compressed_bytes_to_fsync_after_merge).
            type: string
            format: int64
          minRowsToFsyncAfterMerge:
            description: |-
              **string** (int64)
              Minimal number of rows to do fsync for part after merge. **0** means disabled.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#min_rows_to_fsync_after_merge).
            type: string
            format: int64
          ttlOnlyDropParts:
            description: |-
              **boolean**
              Controls whether data parts are fully dropped in MergeTree tables when all rows in that part have expired according to their **TTL** settings.
              * **true** - the entire part is dropped if all rows in that part have expired according to their **TTL** settings.
              * **false** - only the rows that have expired based on their **TTL** settings are removed.
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#ttl_only_drop_parts).
            type: boolean
          mergeWithTtlTimeout:
            description: |-
              **string** (int64)
              Minimum delay in seconds before repeating a merge with delete TTL.
              Default value: **14400** (4 hours).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#merge_with_ttl_timeout).
            type: string
            format: int64
          mergeWithRecompressionTtlTimeout:
            description: |-
              **string** (int64)
              Minimum delay in seconds before repeating a merge with recompression TTL.
              Default value: **14400** (4 hours).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#merge_with_recompression_ttl_timeout).
            type: string
            format: int64
          maxNumberOfMergesWithTtlInPool:
            description: |-
              **string** (int64)
              When there is more than specified number of merges with TTL entries in pool, do not assign new merge with TTL.
              This is to leave free threads for regular merges and avoid "Too many parts" errors.
              Default value: **2**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_number_of_merges_with_ttl_in_pool).
            type: string
            format: int64
          materializeTtlRecalculateOnly:
            description: |-
              **boolean**
              Only recalculate ttl info when **MATERIALIZE TTL**.
              Default value: **true** for versions 25.2 and higher, **false** for versions 25.1 and lower.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#materialize_ttl_recalculate_only).
            type: boolean
          checkSampleColumnIsCorrect:
            description: |-
              **boolean**
              Enables the check at table creation, that the data type of a column for sampling or sampling expression is correct.
              The data type must be one of unsigned integer types: UInt8, UInt16, UInt32, UInt64.
              Default value: **true**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#check_sample_column_is_correct).
            type: boolean
          allowRemoteFsZeroCopyReplication:
            description: |-
              **boolean**
              Setting is automatically enabled if cloud storage is enabled, disabled otherwise.
              Default value: **true**.
            default: '**true**'
            deprecated: true
            type: boolean
      Compression:
        type: object
        properties:
          method:
            description: |-
              **enum** (Method)
              Required field. Compression method to use for the specified combination of **min_part_size** and **min_part_size_ratio**.
              - `LZ4`: [LZ4 compression algorithm](https://lz4.github.io/lz4).
              - `ZSTD`: [ZSTD compression algorithm](https://facebook.github.io/zstd).
              - `LZ4HC`: [LZ4 HC (high compression) algorithm](https://clickhouse.com/docs/sql-reference/statements/create/table#lz4hc).
            type: string
            enum:
              - METHOD_UNSPECIFIED
              - LZ4
              - ZSTD
              - LZ4HC
          minPartSize:
            description: |-
              **string** (int64)
              The minimum size of a data part.
            type: string
            format: int64
          minPartSizeRatio:
            description: |-
              **string**
              The ratio of the data part size to the table size.
            type: string
          level:
            description: |-
              **string** (int64)
              Compression level.
            type: string
            format: int64
        required:
          - method
      Id:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Name of the numeric key.
            type: string
        required:
          - name
      Attribute:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Name of the column.
            type: string
          type:
            description: |-
              **string**
              Required field. Type of the column.
            type: string
          nullValue:
            description: |-
              **string**
              Default value for an element without data (for example, an empty string).
            type: string
          expression:
            description: |-
              **string**
              Expression, describing the attribute, if applicable.
            type: string
          hierarchical:
            description: |-
              **boolean**
              Indication of hierarchy support.
              Default value: **false**.
            default: false
            type: boolean
          injective:
            description: |-
              **boolean**
              Indication of injective mapping "id -> attribute".
              Default value: **false**.
            default: false
            type: boolean
        required:
          - name
          - type
      Key:
        type: object
        properties:
          attributes:
            description: |-
              **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**
              Attributes of a complex key.
              The number of elements must be greater than 0.
            type: array
            items:
              $ref: '#/definitions/Attribute'
      Structure:
        type: object
        properties:
          id:
            description: |-
              **[Id](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Id)**
              Single numeric key column for the dictionary.
            $ref: '#/definitions/Id'
          key:
            description: |-
              **[Key](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Key)**
              Composite key for the dictionary, containing of one or more key columns.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key).
            $ref: '#/definitions/Key'
          rangeMin:
            description: |-
              **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**
              Field holding the beginning of the range for dictionaries with **RANGE_HASHED** layout.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed).
            $ref: '#/definitions/Attribute'
          rangeMax:
            description: |-
              **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**
              Field holding the end of the range for dictionaries with **RANGE_HASHED** layout.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed).
            $ref: '#/definitions/Attribute'
          attributes:
            description: |-
              **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute)**
              Description of the fields available for database queries.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes).
              The number of elements must be greater than 0.
            type: array
            items:
              $ref: '#/definitions/Attribute'
      Layout:
        type: object
        properties:
          type:
            description: |-
              **enum** (Type)
              Required field. Layout type.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#ways-to-store-dictionaries-in-memory).
              - `CLICKHOUSE`: ClickHouse host.
              - `ZOOKEEPER`: ZooKeeper host.
              - `KEEPER`: ClickHouse Keeper host.
            type: string
            enum:
              - TYPE_UNSPECIFIED
              - CLICKHOUSE
              - ZOOKEEPER
              - KEEPER
          sizeInCells:
            description: |-
              **string** (int64)
              Number of cells in the cache. Rounded up to a power of two.
              Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.
              Default value: **1000000000**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache).
            type: string
            format: int64
          allowReadExpiredKeys:
            description: |-
              **boolean**
              Allows to read expired keys.
              Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache).
            type: boolean
          maxUpdateQueueSize:
            description: |-
              **string** (int64)
              Max size of update queue.
              Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.
              Default value: **100000**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache).
            type: string
            format: int64
          updateQueuePushTimeoutMilliseconds:
            description: |-
              **string** (int64)
              Max timeout in milliseconds for push update task into queue.
              Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.
              Default value: **10**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache).
            type: string
            format: int64
          queryWaitTimeoutMilliseconds:
            description: |-
              **string** (int64)
              Max wait timeout in milliseconds for update task to complete.
              Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.
              Default value: **60000** (1 minute).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache).
            type: string
            format: int64
          maxThreadsForUpdates:
            description: |-
              **string** (int64)
              Max threads for cache dictionary update.
              Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types.
              Default value: **4**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#cache).
            type: string
            format: int64
          initialArraySize:
            description: |-
              **string** (int64)
              Initial dictionary key size.
              Applicable only for **FLAT** layout type.
              Default value: **1024**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#flat).
            type: string
            format: int64
          maxArraySize:
            description: |-
              **string** (int64)
              Maximum dictionary key size.
              Applicable only for **FLAT** layout type.
              Default value: **500000**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#flat).
            type: string
            format: int64
          accessToKeyFromAttributes:
            description: |-
              **boolean**
              Allows to retrieve key attribute using **dictGetString** function.
              Enabling this option increases memory usage.
              Applicable only for **IP_TRIE** layout type.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries#ip_trie).
            type: boolean
          blockSize:
            description: |-
              **string** (int64)
              Elementary read block size in bytes. Recommended to match SSD page size.
              Applicable only for **SSD_CACHE** and **COMPLEX_KEY_SSD_CACHE** layout types.
              Default value: **4096**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/statements/create/dictionary/layouts/ssd-cache#ssd_cache).
            type: string
            format: int64
          fileSize:
            description: |-
              **string** (int64)
              Maximum cache file size in bytes.
              Applicable only for **SSD_CACHE** and **COMPLEX_KEY_SSD_CACHE** layout types.
              Default value: **4294967296**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/statements/create/dictionary/layouts/ssd-cache#ssd_cache).
            type: string
            format: int64
          readBufferSize:
            description: |-
              **string** (int64)
              RAM buffer size for reading from SSD in bytes.
              Applicable only for **SSD_CACHE** and **COMPLEX_KEY_SSD_CACHE** layout types.
              Default value: **65536**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/statements/create/dictionary/layouts/ssd-cache#ssd_cache).
            type: string
            format: int64
          writeBufferSize:
            description: |-
              **string** (int64)
              RAM buffer size for writing to SSD in bytes.
              Applicable only for **SSD_CACHE** and **COMPLEX_KEY_SSD_CACHE** layout types.
              Default value: **4096**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/statements/create/dictionary/layouts/ssd-cache#ssd_cache).
            type: string
            format: int64
        required:
          - type
      Range:
        type: object
        properties:
          min:
            description: |-
              **string** (int64)
              Minimum dictionary lifetime.
            type: string
            format: int64
          max:
            description: |-
              **string** (int64)
              Maximum dictionary lifetime.
            type: string
            format: int64
      Header:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Header name.
            type: string
          value:
            description: |-
              **string**
              Required field. Header value.
            type: string
        required:
          - name
          - value
      HttpSource:
        type: object
        properties:
          url:
            description: |-
              **string**
              Required field. URL of the source dictionary available over HTTP.
            type: string
          format:
            description: |-
              **string**
              Required field. The data format. Valid values are all formats [supported by ClickHouse SQL dialect](https://clickhouse.com/docs/en/interfaces/formats/).
            type: string
          headers:
            description: |-
              **[Header](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource.Header)**
              HTTP headers.
            type: array
            items:
              $ref: '#/definitions/Header'
        required:
          - url
          - format
      Replica:
        type: object
        properties:
          host:
            description: |-
              **string**
              Name (FQDN) or IP address of the external replica host.
            type: string
          port:
            description: |-
              **string** (int64)
              Port to connect to the external replica. If not specified, the default ClickHouse port is used.
            type: string
            format: int64
          secure:
            description: |-
              **boolean**
              Whether to use a secure (SSL/TLS) connection when connecting to the external replica.
            type: boolean
          user:
            description: |-
              **string**
              Name of the user to authenticate with on the external replica.
            type: string
          password:
            description: |-
              **string**
              Password of the user to authenticate with on the external replica.
            type: string
          priority:
            description: |-
              **string** (int64)
              Priority of the external replica for load balancing.
              The replica with the lowest priority value is preferred when establishing a connection.
            type: string
            format: int64
      MysqlSource:
        type: object
        properties:
          db:
            description: |-
              **string**
              Required field. Database name.
            type: string
          table:
            description: |-
              **string**
              Required field. Table name.
            type: string
          port:
            description: |-
              **string** (int64)
              Port to use when connecting to a replica of the dictionary source.
            type: string
            format: int64
          user:
            description: |-
              **string**
              Required field. Name of the user for replicas of the dictionary source.
            type: string
          password:
            description: |-
              **string**
              Password of the user for replicas of the dictionary source.
            type: string
          replicas:
            description: |-
              **[Replica](/docs/managed-clickhouse/api-ref/Cluster/getShardGroup#yandex.cloud.mdb.clickhouse.v1.ExternalShard.Replica)**
              List of MySQL replicas of the database used as dictionary source.
            type: array
            items:
              $ref: '#/definitions/Replica'
          where:
            description: |-
              **string**
              Selection criteria for the data in the specified MySQL table.
            type: string
          invalidateQuery:
            description: |-
              **string**
              Query for checking the dictionary status, to pull only updated data.
            type: string
          closeConnection:
            description: |-
              **boolean**
              Should a connection be closed after each request.
            type: boolean
          shareConnection:
            description: |-
              **boolean**
              Should a connection be shared for some requests.
            type: boolean
        required:
          - db
          - table
          - user
      ClickhouseSource:
        type: object
        properties:
          db:
            description: |-
              **string**
              Required field. Database name.
            type: string
          table:
            description: |-
              **string**
              Required field. Table name.
            type: string
          host:
            description: |-
              **string**
              ClickHouse host.
              The maximum string length in characters is 253.
            type: string
          port:
            description: |-
              **string** (int64)
              Port to use when connecting to the host.
            type: string
            format: int64
          user:
            description: |-
              **string**
              Required field. Name of the ClickHouse database user.
            type: string
          password:
            description: |-
              **string**
              Password of the ClickHouse database user.
            type: string
          where:
            description: |-
              **string**
              Selection criteria for the data in the specified ClickHouse table.
            type: string
          secure:
            description: |-
              **boolean**
              Determines whether to use TLS for connection.
            type: boolean
        required:
          - db
          - table
          - user
      MongodbSource:
        type: object
        properties:
          db:
            description: |-
              **string**
              Required field. Database name.
            type: string
          collection:
            description: |-
              **string**
              Required field. Collection name.
            type: string
          host:
            description: |-
              **string**
              Required field. MongoDB host.
              The maximum string length in characters is 253.
            type: string
          port:
            description: |-
              **string** (int64)
              Port to use when connecting to the host.
            type: string
            format: int64
          user:
            description: |-
              **string**
              Required field. Name of the MongoDB database user.
            type: string
          password:
            description: |-
              **string**
              Password of the MongoDB database user.
            type: string
          options:
            description: |-
              **string**
              Dictionary source options.
            type: string
        required:
          - db
          - collection
          - host
          - user
      PostgresqlSource:
        type: object
        properties:
          db:
            description: |-
              **string**
              Required field. Database name.
            type: string
          table:
            description: |-
              **string**
              Required field. Table name.
            type: string
          hosts:
            description: |-
              **string**
              PostgreSQL hosts.
            type: array
            items:
              type: string
          port:
            description: |-
              **string** (int64)
              Port to use when connecting to the PostgreSQL hosts.
            type: string
            format: int64
          user:
            description: |-
              **string**
              Required field. Name of the PostrgreSQL database user.
            type: string
          password:
            description: |-
              **string**
              Password of the PostrgreSQL database user.
            type: string
          invalidateQuery:
            description: |-
              **string**
              Query for checking the dictionary status, to pull only updated data.
            type: string
          sslMode:
            description: |-
              **enum** (SslMode)
              Mode of SSL TCP/IP connection to the PostgreSQL host.
              - `DISABLE`: Only try a non-SSL connection.
              - `ALLOW`: First try a non-SSL connection; if that fails, try an SSL connection.
              - `PREFER`: First try an SSL connection; if that fails, try a non-SSL connection.
              - `VERIFY_CA`: Only try an SSL connection, and verify that the server certificate is issued by a trusted certificate authority (CA).
              - `VERIFY_FULL`: Only try an SSL connection, verify that the server certificate is issued by a trusted CA and that the requested server host name matches that in the certificate.
            type: string
            enum:
              - SSL_MODE_UNSPECIFIED
              - DISABLE
              - ALLOW
              - PREFER
              - VERIFY_CA
              - VERIFY_FULL
        required:
          - db
          - table
          - user
      ExternalDictionary:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Name of the external dictionary.
            type: string
          structure:
            description: |-
              **[Structure](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure)**
              Required field. Structure of the external dictionary.
            $ref: '#/definitions/Structure'
          layout:
            description: |-
              **[Layout](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Layout)**
              Required field. Layout determining how to store the dictionary in memory.
              For details, see https://clickhouse.com/docs/sql-reference/dictionaries#ways-to-store-dictionaries-in-memory.
            $ref: '#/definitions/Layout'
          fixedLifetime:
            description: |-
              **string** (int64)
              Fixed interval between dictionary updates.
              Includes only one of the fields `fixedLifetime`, `lifetimeRange`.
            type: string
            format: int64
          lifetimeRange:
            description: |-
              **[Range](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Range)**
              Range of intervals between dictionary updates for ClickHouse to choose from.
              Includes only one of the fields `fixedLifetime`, `lifetimeRange`.
            $ref: '#/definitions/Range'
          httpSource:
            description: |-
              **[HttpSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource)**
              HTTP source for the dictionary.
              Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`.
            $ref: '#/definitions/HttpSource'
          mysqlSource:
            description: |-
              **[MysqlSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource)**
              MySQL source for the dictionary.
              Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`.
            $ref: '#/definitions/MysqlSource'
          clickhouseSource:
            description: |-
              **[ClickhouseSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.ClickhouseSource)**
              ClickHouse source for the dictionary.
              Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`.
            $ref: '#/definitions/ClickhouseSource'
          mongodbSource:
            description: |-
              **[MongodbSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MongodbSource)**
              MongoDB source for the dictionary.
              Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`.
            $ref: '#/definitions/MongodbSource'
          postgresqlSource:
            description: |-
              **[PostgresqlSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.PostgresqlSource)**
              PostgreSQL source for the dictionary.
              Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`.
            $ref: '#/definitions/PostgresqlSource'
        required:
          - name
          - structure
          - layout
        allOf:
          - oneOf:
              - required:
                  - fixedLifetime
              - required:
                  - lifetimeRange
          - oneOf:
              - required:
                  - httpSource
              - required:
                  - mysqlSource
              - required:
                  - clickhouseSource
              - required:
                  - mongodbSource
              - required:
                  - postgresqlSource
      Retention:
        type: object
        properties:
          age:
            description: |-
              **string** (int64)
              The minimum age of the data in seconds.
            type: string
            format: int64
          precision:
            description: |-
              **string** (int64)
              Precision of determining the age of the data, in seconds. Should be a divisor for 86400 (seconds in a day).
            type: string
            format: int64
      Pattern:
        type: object
        properties:
          regexp:
            description: |-
              **string**
              A pattern for the metric name (a regular or DSL).
            type: string
          function:
            description: |-
              **string**
              The name of the aggregating function to apply to data whose age falls within the range [age, age + precision].
              Accepted functions: **min**, **max**, **any**, **avg**. The average is calculated imprecisely, like the average of the averages.
            type: string
          retention:
            description: |-
              **[Retention](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern.Retention)**
              Retention rules.
            type: array
            items:
              $ref: '#/definitions/Retention'
      GraphiteRollup:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Name for the specified combination of settings for Graphite rollup.
            type: string
          patterns:
            description: |-
              **[Pattern](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern)**
              Pattern to use for the rollup.
              The number of elements must be greater than 0.
            type: array
            items:
              $ref: '#/definitions/Pattern'
          pathColumnName:
            description: |-
              **string**
              The name of the column storing the metric name (Graphite sensor).
              Default value: **Path**.
            default: '**Path**'
            type: string
          timeColumnName:
            description: |-
              **string**
              The name of the column storing the time of measuring the metric.
              Default value: **Time**.
            default: '**Time**'
            type: string
          valueColumnName:
            description: |-
              **string**
              The name of the column storing the value of the metric at the time set in **time_column_name**.
              Default value: **Value**.
            default: '**Value**'
            type: string
          versionColumnName:
            description: |-
              **string**
              The name of the column storing the version of the metric.
              Default value: **Timestamp**.
            default: '**Timestamp**'
            type: string
        required:
          - name
      Kafka:
        type: object
        properties:
          securityProtocol:
            description: |-
              **enum** (SecurityProtocol)
              Protocol used to communicate with brokers.
              Default value: **SECURITY_PROTOCOL_PLAINTEXT**.
              - `SECURITY_PROTOCOL_PLAINTEXT`: Unencrypted, unauthenticated connection.
              - `SECURITY_PROTOCOL_SSL`: SSL/TLS encrypted connection.
              - `SECURITY_PROTOCOL_SASL_PLAINTEXT`: SASL authenticated, unencrypted connection.
              - `SECURITY_PROTOCOL_SASL_SSL`: SASL authenticated, SSL/TLS encrypted connection.
            default: '**SECURITY_PROTOCOL_PLAINTEXT**'
            type: string
            enum:
              - SECURITY_PROTOCOL_UNSPECIFIED
              - SECURITY_PROTOCOL_PLAINTEXT
              - SECURITY_PROTOCOL_SSL
              - SECURITY_PROTOCOL_SASL_PLAINTEXT
              - SECURITY_PROTOCOL_SASL_SSL
          saslMechanism:
            description: |-
              **enum** (SaslMechanism)
              SASL mechanism to use for authentication.
              Default value: **SASL_MECHANISM_GSSAPI**.
              - `SASL_MECHANISM_GSSAPI`: Kerberos-based authentication (GSSAPI).
              - `SASL_MECHANISM_PLAIN`: Simple username/password authentication.
              - `SASL_MECHANISM_SCRAM_SHA_256`: SCRAM authentication using SHA-256 hashing.
              - `SASL_MECHANISM_SCRAM_SHA_512`: SCRAM authentication using SHA-512 hashing.
            default: '**SASL_MECHANISM_GSSAPI**'
            type: string
            enum:
              - SASL_MECHANISM_UNSPECIFIED
              - SASL_MECHANISM_GSSAPI
              - SASL_MECHANISM_PLAIN
              - SASL_MECHANISM_SCRAM_SHA_256
              - SASL_MECHANISM_SCRAM_SHA_512
          saslUsername:
            description: |-
              **string**
              SASL username for use with the PLAIN and SASL-SCRAM mechanisms.
            type: string
          saslPassword:
            description: |-
              **string**
              SASL password for use with the PLAIN and SASL-SCRAM mechanisms.
            type: string
          enableSslCertificateVerification:
            description: |-
              **boolean**
              Enable OpenSSL's builtin broker (server) certificate verification.
              Default value: **true**.
            default: '**true**'
            type: boolean
          maxPollIntervalMs:
            description: |-
              **string** (int64)
              Maximum allowed time between calls to consume messages for high-level consumers.
              If this interval is exceeded the consumer is considered failed and the group will
              rebalance in order to reassign the partitions to another consumer group member.
              Default value: **300000** (5 minutes).
            default: '**300000** (5 minutes)'
            type: string
            format: int64
          sessionTimeoutMs:
            description: |-
              **string** (int64)
              Client group session and failure detection timeout. The consumer sends periodic heartbeats (heartbeat.interval.ms)
              to indicate its liveness to the broker. If no hearts are received by the broker for a group member within
              the session timeout, the broker will remove the consumer from the group and trigger a rebalance.
              Default value: **45000** (45 seconds).
            default: '**45000** (45 seconds)'
            type: string
            format: int64
          debug:
            description: |-
              **enum** (Debug)
              Debug context to enable.
              - `DEBUG_GENERIC`: Generic client debugging.
              - `DEBUG_BROKER`: Broker connection debugging.
              - `DEBUG_TOPIC`: Topic metadata debugging.
              - `DEBUG_METADATA`: Metadata request and response debugging.
              - `DEBUG_FEATURE`: Feature flag debugging.
              - `DEBUG_QUEUE`: Message queue debugging.
              - `DEBUG_MSG`: Message-level debugging.
              - `DEBUG_PROTOCOL`: Protocol-level debugging.
              - `DEBUG_CGRP`: Consumer group debugging.
              - `DEBUG_SECURITY`: Security and authentication debugging.
              - `DEBUG_FETCH`: Message fetch debugging.
              - `DEBUG_INTERCEPTOR`: Interceptor plugin debugging.
              - `DEBUG_PLUGIN`: Plugin debugging.
              - `DEBUG_CONSUMER`: Consumer-level debugging.
              - `DEBUG_ADMIN`: Admin API debugging.
              - `DEBUG_EOS`: Exactly-once semantics (EOS) debugging.
              - `DEBUG_MOCK`: Mock cluster debugging.
              - `DEBUG_ASSIGNOR`: Partition assignor debugging.
              - `DEBUG_CONF`: Configuration debugging.
              - `DEBUG_TELEMETRY`: Telemetry debugging.
              - `DEBUG_ALL`: Enable all debug contexts.
            type: string
            enum:
              - DEBUG_UNSPECIFIED
              - DEBUG_GENERIC
              - DEBUG_BROKER
              - DEBUG_TOPIC
              - DEBUG_METADATA
              - DEBUG_FEATURE
              - DEBUG_QUEUE
              - DEBUG_MSG
              - DEBUG_PROTOCOL
              - DEBUG_CGRP
              - DEBUG_SECURITY
              - DEBUG_FETCH
              - DEBUG_INTERCEPTOR
              - DEBUG_PLUGIN
              - DEBUG_CONSUMER
              - DEBUG_ADMIN
              - DEBUG_EOS
              - DEBUG_MOCK
              - DEBUG_ASSIGNOR
              - DEBUG_CONF
              - DEBUG_TELEMETRY
              - DEBUG_ALL
          autoOffsetReset:
            description: |-
              **enum** (AutoOffsetReset)
              Action to take when there is no initial offset in offset store or the desired offset is out of range.
              Default value: **AUTO_OFFSET_RESET_LARGEST**.
              - `AUTO_OFFSET_RESET_SMALLEST`: Reset offset to the earliest available message (alias for earliest).
              - `AUTO_OFFSET_RESET_EARLIEST`: Reset offset to the earliest available message.
              - `AUTO_OFFSET_RESET_BEGINNING`: Reset offset to the beginning of the partition (alias for earliest).
              - `AUTO_OFFSET_RESET_LARGEST`: Reset offset to the latest available message (alias for latest).
              - `AUTO_OFFSET_RESET_LATEST`: Reset offset to the latest available message.
              - `AUTO_OFFSET_RESET_END`: Reset offset to the end of the partition (alias for latest).
              - `AUTO_OFFSET_RESET_ERROR`: Trigger an error if no initial offset exists or the offset is out of range.
            default: '**AUTO_OFFSET_RESET_LARGEST**'
            type: string
            enum:
              - AUTO_OFFSET_RESET_UNSPECIFIED
              - AUTO_OFFSET_RESET_SMALLEST
              - AUTO_OFFSET_RESET_EARLIEST
              - AUTO_OFFSET_RESET_BEGINNING
              - AUTO_OFFSET_RESET_LARGEST
              - AUTO_OFFSET_RESET_LATEST
              - AUTO_OFFSET_RESET_END
              - AUTO_OFFSET_RESET_ERROR
          messageMaxBytes:
            description: |-
              **string** (int64)
              Maximum Kafka protocol request message size.
              Default value: **1000000**.
            default: '**1000000**'
            type: string
            format: int64
          batchSize:
            description: |-
              **string** (int64)
              Maximum size (in bytes) of all messages batched in one MessageSet, including protocol framing overhead.
              Default value: **1000000**.
            default: '**1000000**'
            type: string
            format: int64
      KafkaTopic:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Kafka topic name.
            type: string
          settings:
            description: |-
              **[Kafka](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Kafka)**
              Required field. Kafka topic settings.
            $ref: '#/definitions/Kafka'
        required:
          - name
          - settings
      Rabbitmq:
        type: object
        properties:
          username:
            description: |-
              **string**
              RabbitMQ username.
            type: string
          password:
            description: |-
              **string**
              RabbitMQ password.
            type: string
          vhost:
            description: |-
              **string**
              RabbitMQ virtual host.
            type: string
      QueryMaskingRule:
        type: object
        properties:
          name:
            description: |-
              **string**
              Name for the rule.
            type: string
          regexp:
            description: |-
              **string**
              Required field. RE2 compatible regular expression.
            type: string
          replace:
            description: |-
              **string**
              Substitution string for sensitive data.
              Default value: six asterisks.
            default: six asterisks
            type: string
        required:
          - regexp
      QueryCache:
        type: object
        properties:
          maxSizeInBytes:
            description: |-
              **string** (int64)
              The maximum cache size in bytes.
              Default value: **1073741824** (1 GiB).
            default: '**1073741824** (1 GiB)'
            type: string
            format: int64
          maxEntries:
            description: |-
              **string** (int64)
              The maximum number of **SELECT** query results stored in the cache.
              Default value: **1024**.
            default: '**1024**'
            type: string
            format: int64
          maxEntrySizeInBytes:
            description: |-
              **string** (int64)
              The maximum size in bytes **SELECT** query results may have to be saved in the cache.
              Default value: **1048576** (1 MiB).
            default: '**1048576** (1 MiB)'
            type: string
            format: int64
          maxEntrySizeInRows:
            description: |-
              **string** (int64)
              The maximum number of rows **SELECT** query results may have to be saved in the cache.
              Default value: **30000000**.
            default: '**30000000**'
            type: string
            format: int64
      JdbcBridge:
        type: object
        properties:
          host:
            description: |-
              **string**
              Host of jdbc bridge.
            type: string
          port:
            description: |-
              **string** (int64)
              Port of jdbc bridge.
              Default value: **9019**.
            default: '**9019**'
            type: string
            format: int64
      Macro:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Name of the macro.
              The maximum string length in characters is 63.
            type: string
          value:
            description: |-
              **string**
              Required field. Value of the macro.
              The maximum string length in characters is 63.
            type: string
        required:
          - name
          - value
      Tls:
        type: object
        properties:
          trustedCertificates:
            description: |-
              **string**
              CA certificates in PEM format. Each element must contain a single self-signed CA certificate
              or a certificate chain ordered as leaf -> intermediates -> self-signed root.
              Change of the setting is applied with restart.
            type: array
            items:
              type: string
      ClickhouseConfig:
        type: object
        properties:
          backgroundPoolSize:
            description: |-
              **string** (int64)
              Sets the number of threads performing background merges and mutations for MergeTree-engine tables.
              Default value: **16**.
              Change of the setting is applied with restart on value decrease and without restart on value increase.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_pool_size).
            type: string
            format: int64
          backgroundMergesMutationsConcurrencyRatio:
            description: |-
              **string** (int64)
              Sets a ratio between the number of threads and the number of background merges and mutations that can be executed concurrently.
              For example, if the ratio equals to **2** and **background_pool_size** is set to **16** then ClickHouse can execute **32** background merges concurrently.
              This is possible, because background operations could be suspended and postponed. This is needed to give small merges more execution priority.
              Default value: **2**.
              Change of the setting is applied with restart on value decrease and without restart on value increase.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_merges_mutations_concurrency_ratio).
            type: string
            format: int64
          backgroundSchedulePoolSize:
            description: |-
              **string** (int64)
              The maximum number of threads that will be used for constantly executing some lightweight periodic operations
              for replicated tables, Kafka streaming, and DNS cache updates.
              Default value: **512**.
              Change of the setting is applied with restart on value decrease and without restart on value increase.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_schedule_pool_size).
            type: string
            format: int64
          backgroundFetchesPoolSize:
            description: |-
              **string** (int64)
              The maximum number of threads that will be used for fetching data parts from another replica for MergeTree-engine tables in a background.
              Default value: **32** for versions 25.1 and higher, **16** for versions 24.12 and lower.
              Change of the setting is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_fetches_pool_size).
            type: string
            format: int64
          backgroundMovePoolSize:
            description: |-
              **string** (int64)
              The maximum number of threads that will be used for moving data parts to another disk or volume for MergeTree-engine tables in a background.
              Default value: **8**.
              Change of the setting is applied with restart on value decrease and without restart on value increase.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_move_pool_size).
            type: string
            format: int64
          backgroundDistributedSchedulePoolSize:
            description: |-
              **string** (int64)
              The maximum number of threads that will be used for executing distributed sends.
              Default value: **16**.
              Change of the setting is applied with restart on value decrease and without restart on value increase.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_distributed_schedule_pool_size).
            type: string
            format: int64
          backgroundBufferFlushSchedulePoolSize:
            description: |-
              **string** (int64)
              The maximum number of threads that will be used for performing flush operations for Buffer-engine tables in the background.
              Default value: **16**.
              Change of the setting is applied with restart on value decrease and without restart on value increase.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_buffer_flush_schedule_pool_size).
            type: string
            format: int64
          backgroundMessageBrokerSchedulePoolSize:
            description: |-
              **string** (int64)
              The maximum number of threads that will be used for executing background operations for message streaming.
              Default value: **16**.
              Change of the setting is applied with restart on value decrease and without restart on value increase.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_message_broker_schedule_pool_size).
            type: string
            format: int64
          backgroundCommonPoolSize:
            description: |-
              **string** (int64)
              The maximum number of threads that will be used for performing a variety of operations (mostly garbage collection) for MergeTree-engine tables in a background.
              Default value: **8**.
              Change of the setting is applied with restart on value decrease and without restart on value increase.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#background_common_pool_size).
            type: string
            format: int64
          dictionariesLazyLoad:
            description: |-
              **boolean**
              Lazy loading of dictionaries. If enabled, then each dictionary is loaded on the first use. Otherwise, the server loads all dictionaries at startup.
              Default value: **true** for versions 25.1 and higher, **false** for versions 24.12 and lower.
              Change of the setting is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#dictionaries_lazy_load).
            type: boolean
          logLevel:
            description: |-
              **enum** (LogLevel)
              Logging level.
              - `TRACE`: All messages including trace-level debug information.
              - `DEBUG`: All messages including debug-level information.
              - `INFORMATION`: Informational messages, warnings, and errors.
              - `WARNING`: Warnings and errors only.
              - `ERROR`: Errors only.
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - TRACE
              - DEBUG
              - INFORMATION
              - WARNING
              - ERROR
          queryLogRetentionSize:
            description: |-
              **string** (int64)
              The maximum size that query_log can grow to before old data will be removed. If set to **0**,
              automatic removal of query_log data based on size is disabled.
              Default value: **1073741824** (1 GiB).
            default: '**1073741824** (1 GiB)'
            type: string
            format: int64
          queryLogRetentionTime:
            description: |-
              **string** (int64)
              The maximum time that query_log records will be retained before removal. If set to **0**, automatic removal of query_log data based on time is disabled.
              Default value: **2592000000** (30 days).
            default: '**2592000000** (30 days)'
            type: string
            format: int64
          queryThreadLogEnabled:
            description: |-
              **boolean**
              Enables or disables query_thread_log system table.
              Default value: **true**.
              Change of the setting is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/query_thread_log).
            type: boolean
          queryThreadLogRetentionSize:
            description: |-
              **string** (int64)
              The maximum size that query_thread_log can grow to before old data will be removed. If set to **0**,
              automatic removal of query_thread_log data based on size is disabled.
              Default value: **536870912** (512 MiB).
            default: '**536870912** (512 MiB)'
            type: string
            format: int64
          queryThreadLogRetentionTime:
            description: |-
              **string** (int64)
              The maximum time that query_thread_log records will be retained before removal. If set to **0**,
              automatic removal of query_thread_log data based on time is disabled.
              Default value: **2592000000** (30 days).
            default: '**2592000000** (30 days)'
            type: string
            format: int64
          partLogRetentionSize:
            description: |-
              **string** (int64)
              The maximum size that part_log can grow to before old data will be removed. If set to **0**,
              automatic removal of part_log data based on size is disabled.
              Default value: **536870912** (512 MiB).
            default: '**536870912** (512 MiB)'
            type: string
            format: int64
          partLogRetentionTime:
            description: |-
              **string** (int64)
              The maximum time that part_log records will be retained before removal. If set to **0**,
              automatic removal of part_log data based on time is disabled.
              Default value: **2592000000** (30 days).
            default: '**2592000000** (30 days)'
            type: string
            format: int64
          metricLogEnabled:
            description: |-
              **boolean**
              Enables or disables metric_log system table.
              Default value: **false** for versions 25.1 and higher, **true** for versions 24.12 and lower.
              Change of the setting is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/metric_log).
            type: boolean
          metricLogRetentionSize:
            description: |-
              **string** (int64)
              The maximum size that metric_log can grow to before old data will be removed. If set to **0**,
              automatic removal of metric_log data based on size is disabled.
              Default value: **536870912** (512 MiB).
            default: '**536870912** (512 MiB)'
            type: string
            format: int64
          metricLogRetentionTime:
            description: |-
              **string** (int64)
              The maximum time that metric_log records will be retained before removal. If set to **0**,
              automatic removal of metric_log data based on time is disabled.
              Default value: **2592000000** (30 days).
            default: '**2592000000** (30 days)'
            type: string
            format: int64
          traceLogEnabled:
            description: |-
              **boolean**
              Enables or disables trace_log system table.
              Default value: **true** for versions 25.2 and higher, **false** for versions 25.1 and lower.
              Change of the setting is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/trace_log).
            type: boolean
          traceLogRetentionSize:
            description: |-
              **string** (int64)
              The maximum size that trace_log can grow to before old data will be removed. If set to **0**,
              automatic removal of trace_log data based on size is disabled.
              Default value: **536870912** (512 MiB).
            default: '**536870912** (512 MiB)'
            type: string
            format: int64
          traceLogRetentionTime:
            description: |-
              **string** (int64)
              The maximum time that trace_log records will be retained before removal. If set to **0**,
              automatic removal of trace_log data based on time is disabled.
              Default value: **2592000000** (30 days).
            default: '**2592000000** (30 days)'
            type: string
            format: int64
          textLogEnabled:
            description: |-
              **boolean**
              Enables or disables text_log system table.
              Default value: **false**.
              Change of the setting is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/text_log).
            type: boolean
          textLogRetentionSize:
            description: |-
              **string** (int64)
              The maximum size that text_log can grow to before old data will be removed. If set to **0**,
              automatic removal of text_log data based on size is disabled.
              Default value: **536870912** (512 MiB).
            default: '**536870912** (512 MiB)'
            type: string
            format: int64
          textLogRetentionTime:
            description: |-
              **string** (int64)
              The maximum time that text_log records will be retained before removal. If set to **0**,
              automatic removal of text_log data based on time is disabled.
              Default value: **2592000000** (30 days).
            default: '**2592000000** (30 days)'
            type: string
            format: int64
          textLogLevel:
            description: |-
              **enum** (LogLevel)
              Logging level for text_log system table.
              Default value: **TRACE**.
              Change of the setting is applied with restart.
              - `TRACE`: All messages including trace-level debug information.
              - `DEBUG`: All messages including debug-level information.
              - `INFORMATION`: Informational messages, warnings, and errors.
              - `WARNING`: Warnings and errors only.
              - `ERROR`: Errors only.
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - TRACE
              - DEBUG
              - INFORMATION
              - WARNING
              - ERROR
          opentelemetrySpanLogEnabled:
            description: |-
              **boolean**
              Enables or disables opentelemetry_span_log system table.
              Default value: **false**.
              Change of the setting is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/opentelemetry_span_log).
            type: boolean
          opentelemetrySpanLogRetentionSize:
            description: |-
              **string** (int64)
              The maximum size that opentelemetry_span_log can grow to before old data will be removed. If set to **0**,
              automatic removal of opentelemetry_span_log data based on size is disabled.
              Default value: **0**.
            default: '**0**'
            type: string
            format: int64
          opentelemetrySpanLogRetentionTime:
            description: |-
              **string** (int64)
              The maximum time that opentelemetry_span_log records will be retained before removal. If set to **0**,
              automatic removal of opentelemetry_span_log data based on time is disabled.
              Default value: **2592000000** (30 days).
            default: '**2592000000** (30 days)'
            type: string
            format: int64
          queryViewsLogEnabled:
            description: |-
              **boolean**
              Enables or disables query_views_log system table.
              Default value: **false**.
              Change of the setting is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/query_views_log).
            type: boolean
          queryViewsLogRetentionSize:
            description: |-
              **string** (int64)
              The maximum size that query_views_log can grow to before old data will be removed. If set to **0**,
              automatic removal of query_views_log data based on size is disabled.
              Default value: **0**.
            default: '**0**'
            type: string
            format: int64
          queryViewsLogRetentionTime:
            description: |-
              **string** (int64)
              The maximum time that query_views_log records will be retained before removal. If set to **0**,
              automatic removal of query_views_log data based on time is disabled.
              Default value: **2592000000** (30 days).
            default: '**2592000000** (30 days)'
            type: string
            format: int64
          asynchronousMetricLogEnabled:
            description: |-
              **boolean**
              Enables or disables asynchronous_metric_log system table.
              Default value: **false**.
              Change of the setting is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/asynchronous_metric_log).
            type: boolean
          asynchronousMetricLogRetentionSize:
            description: |-
              **string** (int64)
              The maximum size that asynchronous_metric_log can grow to before old data will be removed. If set to **0**,
              automatic removal of asynchronous_metric_log data based on size is disabled.
              Default value: **0**.
            default: '**0**'
            type: string
            format: int64
          asynchronousMetricLogRetentionTime:
            description: |-
              **string** (int64)
              The maximum time that asynchronous_metric_log records will be retained before removal. If set to **0**,
              automatic removal of asynchronous_metric_log data based on time is disabled.
              Default value: **2592000000** (30 days).
            default: '**2592000000** (30 days)'
            type: string
            format: int64
          sessionLogEnabled:
            description: |-
              **boolean**
              Enables or disables session_log system table.
              Default value: **true** for versions 25.3 and higher, **false** for versions 25.2 and lower.
              Change of the setting is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/session_log).
            type: boolean
          sessionLogRetentionSize:
            description: |-
              **string** (int64)
              The maximum size that session_log can grow to before old data will be removed. If set to **0**,
              automatic removal of session_log data based on size is disabled.
              Default value: **536870912** (512 MiB) for versions 25.3 and higher, **0** for versions 25.2 and lower.
            default: '**536870912** (512 MiB) for versions 25.3 and higher, **0** for versions 25.2 and lower'
            type: string
            format: int64
          sessionLogRetentionTime:
            description: |-
              **string** (int64)
              The maximum time that session_log records will be retained before removal. If set to **0**,
              automatic removal of session_log data based on time is disabled.
              Default value: **2592000000** (30 days).
            default: '**2592000000** (30 days)'
            type: string
            format: int64
          zookeeperLogEnabled:
            description: |-
              **boolean**
              Enables or disables zookeeper_log system table.
              Default value: **false**.
              Change of the setting is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/zookeeper_log).
            type: boolean
          zookeeperLogRetentionSize:
            description: |-
              **string** (int64)
              The maximum size that zookeeper_log can grow to before old data will be removed. If set to **0**,
              automatic removal of zookeeper_log data based on size is disabled.
              Default value: **0**.
            default: '**0**'
            type: string
            format: int64
          zookeeperLogRetentionTime:
            description: |-
              **string** (int64)
              The maximum time that zookeeper_log records will be retained before removal. If set to **0**,
              automatic removal of zookeeper_log data based on time is disabled.
              Default value: **2592000000** (30 days).
            default: '**2592000000** (30 days)'
            type: string
            format: int64
          asynchronousInsertLogEnabled:
            description: |-
              **boolean**
              Enables or disables asynchronous_insert_log system table.
              Default value: **false**.
              Change of the setting is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/asynchronous_insert_log).
            type: boolean
          asynchronousInsertLogRetentionSize:
            description: |-
              **string** (int64)
              The maximum size that asynchronous_insert_log can grow to before old data will be removed. If set to **0**,
              automatic removal of asynchronous_insert_log data based on size is disabled.
              Default value: **0**.
            default: '**0**'
            type: string
            format: int64
          asynchronousInsertLogRetentionTime:
            description: |-
              **string** (int64)
              The maximum time that asynchronous_insert_log records will be retained before removal. If set to **0**,
              automatic removal of asynchronous_insert_log data based on time is disabled.
              Default value: **2592000000** (30 days).
            default: '**2592000000** (30 days)'
            type: string
            format: int64
          processorsProfileLogEnabled:
            description: |-
              **boolean**
              Enables or disables processors_profile_log system table.
              Default value: **true** for versions 25.2 and higher, **false** for versions 25.1 and lower.
              Change of the setting is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/processors_profile_log).
            type: boolean
          processorsProfileLogRetentionSize:
            description: |-
              **string** (int64)
              The maximum size that processors_profile_log can grow to before old data will be removed. If set to **0**,
              automatic removal of processors_profile_log data based on size is disabled.
              Default value: **0**.
            default: '**0**'
            type: string
            format: int64
          processorsProfileLogRetentionTime:
            description: |-
              **string** (int64)
              The maximum time that processors_profile_log records will be retained before removal. If set to **0**,
              automatic removal of processors_profile_log data based on time is disabled.
              Default value: **2592000000** (30 days).
            default: '**2592000000** (30 days)'
            type: string
            format: int64
          errorLogEnabled:
            description: |-
              **boolean**
              Enables or disables error_log system table.
              Default value: **false**.
              Change of the setting is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/error_log).
            type: boolean
          errorLogRetentionSize:
            description: |-
              **string** (int64)
              The maximum size that error_log can grow to before old data will be removed. If set to **0**,
              automatic removal of error_log data based on size is disabled.
              Default value: **0**.
            default: '**0**'
            type: string
            format: int64
          errorLogRetentionTime:
            description: |-
              **string** (int64)
              The maximum time that error_log records will be retained before removal. If set to **0**,
              automatic removal of error_log data based on time is disabled.
              Default value: **2592000000** (30 days).
            default: '**2592000000** (30 days)'
            type: string
            format: int64
          queryMetricLogEnabled:
            description: |-
              **boolean**
              Enables or disables query_metric_log system table.
              Default value: **false**.
              Change of the setting is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/query_metric_log).
            type: boolean
          queryMetricLogRetentionSize:
            description: |-
              **string** (int64)
              The maximum size that query_metric_log can grow to before old data will be removed. If set to **0**,
              automatic removal of query_metric_log data based on size is disabled.
              Default value: **536870912** (512 MiB).
            default: '**536870912** (512 MiB)'
            type: string
            format: int64
          queryMetricLogRetentionTime:
            description: |-
              **string** (int64)
              The maximum time that query_metric_log records will be retained before removal. If set to **0**,
              automatic removal of query_metric_log data based on time is disabled.
              Default value: **2592000000** (30 days).
            default: '**2592000000** (30 days)'
            type: string
            format: int64
          accessControlImprovements:
            description: |-
              **[AccessControlImprovements](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.AccessControlImprovements)**
              Access control settings.
            $ref: '#/definitions/AccessControlImprovements'
          maxConnections:
            description: |-
              **string** (int64)
              Maximum number of inbound connections.
              Default value: **4096**.
              Change of the setting is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#max_connections).
            type: string
            format: int64
          maxConcurrentQueries:
            description: |-
              **string** (int64)
              Maximum number of concurrently executed queries.
              Default value: **500**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#max_concurrent_queries).
            type: string
            format: int64
          maxTableSizeToDrop:
            description: |-
              **string** (int64)
              Maximum size of the table that can be deleted using **DROP** or **TRUNCATE** query.
              Default value: **50000000000** (48828125 KiB).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#max_table_size_to_drop).
            type: string
            format: int64
          maxPartitionSizeToDrop:
            description: |-
              **string** (int64)
              Maximum size of the partition that can be deleted using **DROP** or **TRUNCATE** query.
              Default value: **50000000000** (48828125 KiB).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#max_partition_size_to_drop).
            type: string
            format: int64
          keepAliveTimeout:
            description: |-
              **string** (int64)
              The number of seconds that ClickHouse waits for incoming requests for HTTP protocol before closing the connection.
              Default value: **3** for versions 25.10 and higher, **30** for versions 25.9 and lower.
              Change of the setting is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#keep_alive_timeout).
            type: string
            format: int64
          uncompressedCacheSize:
            description: |-
              **string** (int64)
              Cache size (in bytes) for uncompressed data used by table engines from the MergeTree family. **0** means disabled.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#uncompressed_cache_size).
            type: string
            format: int64
          markCacheSize:
            description: |-
              **string** (int64)
              Maximum size (in bytes) of the cache of "marks" used by MergeTree tables.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#mark_cache_size).
            type: string
            format: int64
          timezone:
            description: |-
              **string**
              The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier.
              Default value: **Europe/Moscow**.
              Change of the setting is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#timezone).
            type: string
          geobaseEnabled:
            description: |-
              **boolean**
              Enables or disables geobase.
              Default value: **false** for versions 25.8 and higher, **true** for versions 25.7 and lower.
              Change of the setting is applied with restart.
            type: boolean
          geobaseUri:
            description: |-
              **string**
              Address of the archive with the user geobase in Object Storage.
              Change of the setting is applied with restart.
            type: string
          defaultDatabase:
            description: |-
              **string**
              The default database.
              Default value: **default**.
              Change of the setting is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#default_database).
            type: string
          totalMemoryProfilerStep:
            description: |-
              **string** (int64)
              Whenever server memory usage becomes larger than every next step in number of bytes the memory profiler will collect
              the allocating stack trace. **0** means disabled memory profiler.
              Default value: **0**.
              Change of the setting is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#total_memory_profiler_step).
            type: string
            format: int64
          totalMemoryTrackerSampleProbability:
            description: |-
              **number** (double)
              Allows to collect random allocations and de-allocations and writes them in the system.trace_log system table
              with trace_type equal to a MemorySample with the specified probability.
              Default value: **0**.
              Change of the setting is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#total_memory_tracker_sample_probability).
            type: number
            format: double
          asyncInsertThreads:
            description: |-
              **string** (int64)
              Maximum number of threads to parse and insert data in background. If set to **0**, asynchronous mode is disabled.
              Default value: **16**.
              Change of the setting is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#async_insert_threads).
            type: string
            format: int64
          backupThreads:
            description: |-
              **string** (int64)
              The maximum number of threads to execute **BACKUP** requests.
              Default value: **16**.
              Change of the setting is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#backup_threads).
            type: string
            format: int64
          restoreThreads:
            description: |-
              **string** (int64)
              The maximum number of threads to execute **RESTORE** requests.
              Default value: **16**.
              Change of the setting is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#restore_threads).
            type: string
            format: int64
          vectorSimilarityIndexCacheSize:
            description: |-
              **string** (int64)
              Size of cache for vector similarity indexes, in bytes. **0** means disabled.
              Default value: **5368709120** (5 GiB).
              Change of the setting is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#vector_similarity_index_cache_size).
            type: string
            format: int64
          vectorSimilarityIndexCacheMaxEntries:
            description: |-
              **string** (int64)
              Size of cache for vector similarity indexes, in entries. **0** means disabled.
              Default value: **10000000**.
              Change of the setting is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#vector_similarity_index_cache_max_entries).
            type: string
            format: int64
          maxBuildVectorSimilarityIndexThreadPoolSize:
            description: |-
              **string** (int64)
              The maximum number of threads to use for building vector indexes. **0** means unlimited.
              Default value: **16**.
              Change of the setting is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#max_build_vector_similarity_index_thread_pool_size).
            type: string
            format: int64
          mergeTree:
            description: |-
              **[MergeTree](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.MergeTree)**
              Settings for the MergeTree table engine family.
              Change of the settings of **merge_tree** is applied with restart.
            $ref: '#/definitions/MergeTree'
          compression:
            description: |-
              **[Compression](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Compression)**
              Data compression settings for MergeTree engine tables.
              Change of the settings of **compression** is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#compression).
            type: array
            items:
              $ref: '#/definitions/Compression'
          dictionaries:
            description: |-
              **[ExternalDictionary](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary)**
              Configuration of external dictionaries.
              Change of the settings of **dictionaries** is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries).
            type: array
            items:
              $ref: '#/definitions/ExternalDictionary'
          graphiteRollup:
            description: |-
              **[GraphiteRollup](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup)**
              Rollup settings for the GraphiteMergeTree engine tables.
              Change of the settings of **graphite_rollup** is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#graphite_rollup).
            type: array
            items:
              $ref: '#/definitions/GraphiteRollup'
          kafka:
            description: |-
              **[Kafka](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Kafka)**
              Kafka integration settings.
              Change of the settings of **kafka** is applied with restart.
            $ref: '#/definitions/Kafka'
          kafkaTopics:
            description: |-
              **[KafkaTopic](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.KafkaTopic)**
              Per-topic Kafka integration settings.
              Change of the settings of **kafka_topics** is applied with restart.
            deprecated: true
            type: array
            items:
              $ref: '#/definitions/KafkaTopic'
          rabbitmq:
            description: |-
              **[Rabbitmq](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Rabbitmq)**
              RabbitMQ integration settings.
              Change of the settings of **rabbitmq** is applied with restart.
            $ref: '#/definitions/Rabbitmq'
          queryMaskingRules:
            description: |-
              **[QueryMaskingRule](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryMaskingRule)**
              Regexp-based rules, which will be applied to queries as well as all log messages before storing them in server logs,
              system.query_log, system.text_log, system.processes tables, and in logs sent to the client. That allows preventing
              sensitive data leakage from SQL queries (like names, emails, personal identifiers or credit card numbers) to logs.
              Change of the settings of **query_masking_rules** is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#query_masking_rules).
            type: array
            items:
              $ref: '#/definitions/QueryMaskingRule'
          queryCache:
            description: |-
              **[QueryCache](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryCache)**
              [Query cache](https://clickhouse.com/docs/operations/query-cache) configuration.
              Change of the settings of **query_cache** is applied with restart.
            $ref: '#/definitions/QueryCache'
          jdbcBridge:
            description: |-
              **[JdbcBridge](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.JdbcBridge)**
              JDBC bridge configuration for queries to external databases.
              Change of the settings of **jdbc_bridge** is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/integrations/jdbc/jdbc-with-clickhouse).
            $ref: '#/definitions/JdbcBridge'
          mysqlProtocol:
            description: |-
              **boolean**
              Enables or disables MySQL interface on ClickHouse server
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/interfaces/mysql).
            type: boolean
          customMacros:
            description: |-
              **[Macro](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Macro)**
              Custom ClickHouse macros.
            type: array
            items:
              $ref: '#/definitions/Macro'
          tls:
            description: |-
              **[Tls](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Tls)**
              TLS configuration for outgoing connections from ClickHouse.
              Change of the settings of **tls** is applied with restart.
            $ref: '#/definitions/Tls'
          builtinDictionariesReloadInterval:
            description: |-
              **string** (int64)
              The interval in seconds before reloading built-in dictionaries.
              Default value: **3600**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#builtin_dictionaries_reload_interval).
            deprecated: true
            type: string
            format: int64
      UserSettings:
        type: object
        properties:
          readonly:
            description: |-
              **string** (int64)
              Restricts permissions for non-DDL queries. To restrict permissions for DDL queries, use **allow_ddl** instead.
              * **0** - no restrictions.
              * **1** - only read data queries are allowed.
              * **2** - read data and change settings queries are allowed.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/permissions-for-queries#readonly).
            type: string
            format: int64
          allowDdl:
            description: |-
              **boolean**
              Allows or denies DDL queries (e.g., **CREATE**, **ALTER**, **RENAME**, etc).
              Default value: **true**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/permissions-for-queries#allow_ddl).
            type: boolean
          allowIntrospectionFunctions:
            description: |-
              **boolean**
              Enables or disables introspection functions for query profiling.
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#allow_introspection_functions).
            type: boolean
          connectTimeout:
            description: |-
              **string** (int64)
              Connection timeout in milliseconds.
              Default value: **10000** (10 seconds).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#connect_timeout).
            type: string
            format: int64
          connectTimeoutWithFailover:
            description: |-
              **string** (int64)
              The timeout in milliseconds for connecting to a remote server for a Distributed table engine.
              Applies only if the cluster uses sharding and replication. If unsuccessful, several attempts are made to connect to various replicas.
              Default value: **1000** (1 second).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#connect_timeout_with_failover_ms).
            type: string
            format: int64
          connectTimeoutWithFailoverSecure:
            description: |-
              **string** (int64)
              The timeout in milliseconds for connecting to a remote server for a Distributed table engine, for secure connections.
              Applies only if the cluster uses sharding and replication. If unsuccessful, several attempts are made to connect to various replicas.
              Default value: **1000** (1 second).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#connect_timeout_with_failover_secure_ms).
            type: string
            format: int64
          connectionsWithFailoverMaxTries:
            description: |-
              **string** (int64)
              The maximum number of connection attempts with each replica for the Distributed table engine.
              Default value: **3**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#connections_with_failover_max_tries).
            type: string
            format: int64
          receiveTimeout:
            description: |-
              **string** (int64)
              Receive timeout in milliseconds.
              Default value: **300000** (5 minutes).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#receive_timeout).
            type: string
            format: int64
          sendTimeout:
            description: |-
              **string** (int64)
              Send timeout in milliseconds.
              Default value: **300000** (5 minutes).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#send_timeout).
            type: string
            format: int64
          idleConnectionTimeout:
            description: |-
              **string** (int64)
              Timeout to close idle TCP connections after specified time has elapsed, in milliseconds.
              Default value: **3600000** (1 hour).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#idle_connection_timeout).
            type: string
            format: int64
          timeoutBeforeCheckingExecutionSpeed:
            description: |-
              **string** (int64)
              Checks that the speed is not too low after the specified time has elapsed, in milliseconds. It is checked that execution speed
              is not less that specified in **min_execution_speed** parameter.
              Default value: **60000** (1 minute).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#timeout_before_checking_execution_speed).
            type: string
            format: int64
          insertQuorum:
            description: |-
              **string** (int64)
              Enables or disables the quorum writes. If the value is less than **2**, then the quorum writes is disabled, otherwise it is enabled.
              When used, write quorum guarantees that ClickHouse has written data to the quorum of **insert_quorum** replicas with no errors
              until the **insert_quorum_timeout** expires. All replicas in the quorum are in the consistent state, meaning that they contain
              linearized data from the previous **INSERT** queries. Employ write quorum, if you need the guarantees that the written data
              would not be lost in case of one or more replicas failure.
              You can use **select_sequential_consistency** setting to read the data written with write quorum.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#insert_quorum).
            type: string
            format: int64
          insertQuorumTimeout:
            description: |-
              **string** (int64)
              Quorum write timeout in milliseconds.
              If the write quorum is enabled in the cluster, this timeout expires and some data is not written to the **insert_quorum** replicas,
              then ClickHouse will abort the execution of **INSERT** query and return an error. In this case, the client must send the query again
              to write the data block into the same or another replica.
              Default value: **600000** (10 minutes).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#insert_quorum_timeout).
            type: string
            format: int64
          insertQuorumParallel:
            description: |-
              **boolean**
              Enables or disables parallelism for quorum **INSERT** queries.
              Default value: **true**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#insert_quorum_parallel).
            type: boolean
          selectSequentialConsistency:
            description: |-
              **boolean**
              Determines the behavior of **SELECT** queries from replicated tables. If enabled, ClickHouse will terminate a query with error message in case
              the replica does not have a chunk written with the quorum and will not read the parts that have not yet been written with the quorum.
              Default value: **true**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#select_sequential_consistency).
            type: boolean
          replicationAlterPartitionsSync:
            description: |-
              **string** (int64)
              Wait mode for asynchronous actions in **ALTER** queries on replicated tables.
              * **0** - do not wait for replicas.
              * **1** - only wait for own execution.
              * **2** - wait for all replicas.
              Default value: **1**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#alter_sync).
            type: string
            format: int64
          maxReplicaDelayForDistributedQueries:
            description: |-
              **string** (int64)
              Max replica delay in milliseconds. If a replica lags more than the set value, this replica is not used and becomes a stale one.
              Default value: **300000** (5 minutes).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_replica_delay_for_distributed_queries).
            type: string
            format: int64
          fallbackToStaleReplicasForDistributedQueries:
            description: |-
              **boolean**
              Enables or disables query forcing to a stale replica in case the actual data is unavailable.
              If enabled, ClickHouse will choose the most up-to-date replica and force the query to use the data in this replica.
              This setting can be used when doing **SELECT** query from a distributed table that points to replicated tables.
              Default value: **true**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#fallback_to_stale_replicas_for_distributed_queries).
            type: boolean
          distributedProductMode:
            description: |-
              **enum** (DistributedProductMode)
              Determines the behavior of distributed subqueries.
              Default value: **DISTRIBUTED_PRODUCT_MODE_DENY**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#distributed_product_mode).
              - `DISTRIBUTED_PRODUCT_MODE_DENY`: Prohibits using these types of subqueries (returns the "Double-distributed in/JOIN subqueries is denied" exception).
              - `DISTRIBUTED_PRODUCT_MODE_LOCAL`: Replaces the database and table in the subquery with local ones for the destination server (shard), leaving the normal IN/JOIN.
              - `DISTRIBUTED_PRODUCT_MODE_GLOBAL`: Replaces the IN/JOIN query with GLOBAL IN/GLOBAL JOIN.
              - `DISTRIBUTED_PRODUCT_MODE_ALLOW`: Allows the use of these types of subqueries.
            type: string
            enum:
              - DISTRIBUTED_PRODUCT_MODE_UNSPECIFIED
              - DISTRIBUTED_PRODUCT_MODE_DENY
              - DISTRIBUTED_PRODUCT_MODE_LOCAL
              - DISTRIBUTED_PRODUCT_MODE_GLOBAL
              - DISTRIBUTED_PRODUCT_MODE_ALLOW
          distributedAggregationMemoryEfficient:
            description: |-
              **boolean**
              Enables of disables memory saving mode when doing distributed aggregation.
              When ClickHouse works with a distributed query, external aggregation is done on remote servers.
              Enable this setting to achieve a smaller memory footprint on the server that sourced such a distributed query.
              Default value: **true**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#distributed_aggregation_memory_efficient).
            type: boolean
          distributedDdlTaskTimeout:
            description: |-
              **string** (int64)
              Timeout for DDL queries, in milliseconds.
              Default value: **180000** (3 minutes).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#distributed_ddl_task_timeout).
            type: string
            format: int64
          distributedDdlOutputMode:
            description: |-
              **enum** (DistributedDdlOutputMode)
              Determines the format of distributed DDL query result.
              Default value: **DISTRIBUTED_DDL_OUTPUT_MODE_THROW_ONLY_ACTIVE** for versions 26.3 and higher, **DISTRIBUTED_DDL_OUTPUT_MODE_THROW** for versions 26.2 and lower.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#distributed_ddl_output_mode).
              - `DISTRIBUTED_DDL_OUTPUT_MODE_THROW`: Returns result set with query execution status for all hosts where query is finished. If query has failed on some hosts, then it will rethrow the first exception.
              If query is not finished yet on some hosts and **distributed_ddl_task_timeout** exceeded, then it throws **TIMEOUT_EXCEEDED** exception.
              - `DISTRIBUTED_DDL_OUTPUT_MODE_NONE`: Like **DISTRIBUTED_DDL_OUTPUT_MODE_THROW**, but distributed DDL query returns no result set.
              - `DISTRIBUTED_DDL_OUTPUT_MODE_NULL_STATUS_ON_TIMEOUT`: Returns **NULL** as execution status in some rows of result set instead of throwing **TIMEOUT_EXCEEDED** if query is not finished on the corresponding hosts.
              - `DISTRIBUTED_DDL_OUTPUT_MODE_NEVER_THROW`: Do not throw **TIMEOUT_EXCEEDED** and do not rethrow exceptions if query has failed on some hosts.
              - `DISTRIBUTED_DDL_OUTPUT_MODE_NONE_ONLY_ACTIVE`: Like **DISTRIBUTED_DDL_OUTPUT_MODE_NONE**, but doesn't wait for inactive replicas of the **Replicated** database.
              With this mode it's impossible to figure out that the query was not executed on some replica and will be executed in background.
              - `DISTRIBUTED_DDL_OUTPUT_MODE_NULL_STATUS_ON_TIMEOUT_ONLY_ACTIVE`: Like **DISTRIBUTED_DDL_OUTPUT_MODE_NULL_STATUS_ON_TIMEOUT**, but doesn't wait for inactive replicas of the **Replicated** database.
              - `DISTRIBUTED_DDL_OUTPUT_MODE_THROW_ONLY_ACTIVE`: Like **DISTRIBUTED_DDL_OUTPUT_MODE_THROW**, but doesn't wait for inactive replicas of the **Replicated** database.
            type: string
            enum:
              - DISTRIBUTED_DDL_OUTPUT_MODE_UNSPECIFIED
              - DISTRIBUTED_DDL_OUTPUT_MODE_THROW
              - DISTRIBUTED_DDL_OUTPUT_MODE_NONE
              - DISTRIBUTED_DDL_OUTPUT_MODE_NULL_STATUS_ON_TIMEOUT
              - DISTRIBUTED_DDL_OUTPUT_MODE_NEVER_THROW
              - DISTRIBUTED_DDL_OUTPUT_MODE_NONE_ONLY_ACTIVE
              - DISTRIBUTED_DDL_OUTPUT_MODE_NULL_STATUS_ON_TIMEOUT_ONLY_ACTIVE
              - DISTRIBUTED_DDL_OUTPUT_MODE_THROW_ONLY_ACTIVE
          skipUnavailableShards:
            description: |-
              **boolean**
              Enables or disables silent skipping of unavailable shards.
              A shard is considered unavailable if all its replicas are also unavailable.
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#skip_unavailable_shards).
            type: boolean
          useHedgedRequests:
            description: |-
              **boolean**
              Enables or disables hedged requests logic for remote queries.
              It allows to establish many connections with different replicas for query. New connection is enabled in case existent connection(s) with replica(s)
              were not established within **hedged_connection_timeout** or no data was received within **receive_data_timeout**. Query uses the first connection
              which send non empty progress packet, other connections are cancelled.
              Default value: **true**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#use_hedged_requests).
            type: boolean
          hedgedConnectionTimeoutMs:
            description: |-
              **string** (int64)
              Connection timeout for establishing connection with replica for Hedged requests.
              Default value: **50**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#hedged_connection_timeout_ms).
            type: string
            format: int64
          loadBalancing:
            description: |-
              **enum** (LoadBalancing)
              Algorithm of replicas selection that is used for distributed query processing.
              Default value: **LOAD_BALANCING_RANDOM**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#load_balancing).
              - `LOAD_BALANCING_RANDOM`: Select a replica at random for each query.
              - `LOAD_BALANCING_NEAREST_HOSTNAME`: Prefer replicas whose hostname is lexicographically closest to the current server's hostname.
              - `LOAD_BALANCING_IN_ORDER`: Select replicas in the order defined in the configuration, failing over to the next on error.
              - `LOAD_BALANCING_FIRST_OR_RANDOM`: Always try the first replica; fall back to a random replica if it is unavailable or has errors.
              - `LOAD_BALANCING_ROUND_ROBIN`: Cycle through replicas sequentially in a round-robin fashion.
            type: string
            enum:
              - LOAD_BALANCING_UNSPECIFIED
              - LOAD_BALANCING_RANDOM
              - LOAD_BALANCING_NEAREST_HOSTNAME
              - LOAD_BALANCING_IN_ORDER
              - LOAD_BALANCING_FIRST_OR_RANDOM
              - LOAD_BALANCING_ROUND_ROBIN
          preferLocalhostReplica:
            description: |-
              **boolean**
              Enable or disable preferable using the localhost replica when processing distributed queries.
              Default value: **true**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#prefer_localhost_replica).
            type: boolean
          compileExpressions:
            description: |-
              **boolean**
              Enable or disable expression compilation to native code.
              If you execute a lot of queries that contain identical expressions, then enable this setting.
              As a result, such queries may be executed faster due to use of compiled expressions.
              Use this setting in combination with **min_count_to_compile_expression** setting.
              Default value: **true** for versions 25.5 and higher, **false** for versions 25.4 and lower.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#compile_expressions).
            type: boolean
          minCountToCompileExpression:
            description: |-
              **string** (int64)
              How many identical expressions ClickHouse has to encounter before they are compiled.
              For the **0** value compilation is synchronous: a query waits for expression compilation process to complete prior to continuing execution.
              It is recommended to set this value only for testing purposes.
              For all other values, compilation is asynchronous: the compilation process executes in a separate thread.
              When a compiled expression is ready, it will be used by ClickHouse for eligible queries, including the ones that are currently running.
              Default value: **3**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#min_count_to_compile_expression).
            type: string
            format: int64
          maxBlockSize:
            description: |-
              **string** (int64)
              Sets the recommended maximum number of rows to include in a single block when loading data from tables.
              Blocks the size of **max_block_size** are not always loaded from the table: if ClickHouse determines that less data needs to be retrieved,
              a smaller block is processed.
              The block size should not be too small to avoid noticeable costs when processing each block. It should also not be too large to ensure that
              queries with a **LIMIT** clause execute quickly after processing the first block. When setting **max_block_size**, the goal should be to avoid
              consuming too much memory when extracting a large number of columns in multiple threads and to preserve at least some cache locality.
              Default value: **65409**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_block_size).
            type: string
            format: int64
          minInsertBlockSizeRows:
            description: |-
              **string** (int64)
              Limits the minimum number of rows in a block to be inserted in a table by **INSERT** query. Blocks that are smaller than the specified value,
              will be squashed together into the bigger blocks. If set to **0**, block squashing is disabled.
              Default value: **1048449**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#min_insert_block_size_rows).
            type: string
            format: int64
          minInsertBlockSizeBytes:
            description: |-
              **string** (int64)
              Limits the minimum number of bytes in a block to be inserted in a table by **INSERT** query. Blocks that are smaller than the specified value,
              will be squashed together into the bigger blocks. If set to **0**, block squashing is disabled.
              Default value: **268402944**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#min_insert_block_size_bytes).
            type: string
            format: int64
          maxInsertBlockSize:
            description: |-
              **string** (int64)
              The size of blocks (in a count of rows) to form for insertion into a table.
              This setting only applies in cases when the server forms the blocks. For example, for an **INSERT** via the HTTP interface, the server parses
              the data format and forms blocks of the specified size. But when using clickhouse-client, the client parses the data itself, and
              the **max_insert_block_size** setting on the server does not affect the size of the inserted blocks. The setting also does not have a purpose
              when using **INSERT SELECT**, since data is inserted using the same blocks that are formed after **SELECT**.
              Default value: **1048449**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_insert_block_size).
            type: string
            format: int64
          maxPartitionsPerInsertBlock:
            description: |-
              **string** (int64)
              When inserting data, ClickHouse calculates the number of partitions in the inserted block.
              If the number of partitions is more than **max_partitions_per_insert_block**, ClickHouse throws an exception.
              Default value: **100**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/query-complexity#settings-max_partitions_per_insert_block).
            type: string
            format: int64
          minBytesToUseDirectIo:
            description: |-
              **string** (int64)
              Limits the minimum number of bytes to enable unbuffered direct reads from disk (Direct I/O). If set to **0**, Direct I/O is disabled.
              By default, ClickHouse does not read data directly from disk, but relies on the filesystem and its cache instead. Such reading strategy
              is effective when the data volume is small. If the amount of the data to read is huge, it is more effective to read directly from the disk,
              bypassing the filesystem cache.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#min_bytes_to_use_direct_io).
            type: string
            format: int64
          useUncompressedCache:
            description: |-
              **boolean**
              Determines whether to use the cache of uncompressed blocks, or not.
              Using this cache can significantly reduce latency and increase the throughput when a huge amount of small queries is to be processed.
              Enable this setting for the users who instantiates small queries frequently.
              This setting has effect only for tables of the MergeTree family.
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#use_uncompressed_cache).
            type: boolean
          mergeTreeMaxRowsToUseCache:
            description: |-
              **string** (int64)
              Limits the maximum size in rows of the request that can use the cache of uncompressed data. The cache is not used for requests larger than the specified value.
              Use this setting in combination with **use_uncompressed_cache** setting.
              Default value: **1048576**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#merge_tree_max_rows_to_use_cache).
            type: string
            format: int64
          mergeTreeMaxBytesToUseCache:
            description: |-
              **string** (int64)
              Limits the maximum size in bytes of the request that can use the cache of uncompressed data. The cache is not used for requests larger than the specified value.
              Use this setting in combination with **use_uncompressed_cache** setting.
              Default value: **2013265920** (1920 MiB).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#merge_tree_max_bytes_to_use_cache).
            type: string
            format: int64
          mergeTreeMinRowsForConcurrentRead:
            description: |-
              **string** (int64)
              Limits the minimum number of rows to be read from a file to enable concurrent read.
              If the number of rows to be read exceeds this value, then ClickHouse will try to use a few threads to read from a file concurrently.
              This setting has effect only for tables of the MergeTree family.
              Default value: **163840**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#merge_tree_min_rows_for_concurrent_read).
            type: string
            format: int64
          mergeTreeMinBytesForConcurrentRead:
            description: |-
              **string** (int64)
              Limits the number of bytes to be read from a file to enable concurrent read.
              If the number of bytes to be read exceeds this value, then ClickHouse will try to use a few threads to read from a file concurrently.
              This setting has effect only for tables of the MergeTree family.
              Default value: **251658240** (240 MiB).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#merge_tree_min_bytes_for_concurrent_read).
            type: string
            format: int64
          maxBytesBeforeExternalGroupBy:
            description: |-
              **string** (int64)
              Sets the threshold of RAM consumption (in bytes) after that the temporary data, collected during the **GROUP BY** operation,
              should be flushed to disk to limit the RAM consumption. If set to **0**, **GROUP BY** in the external memory is disabled.
              By default, aggregation is done by employing hash table that resides in RAM. A query can result in aggregation of huge data
              volumes that can lead to memory exhaustion and abortion of the query (see the **max_memory_usage** setting). For such queries,
              you can use this setting to force ClickHouse to do flushing and complete aggregation successfully.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_bytes_before_external_group_by).
            type: string
            format: int64
          maxBytesRatioBeforeExternalGroupBy:
            description: |-
              **number** (double)
              The ratio of available memory that is allowed for GROUP BY. Once reached, external memory is used for aggregation.
              For example, if set to 0.6, GROUP BY will allow using 60% of the available memory (to server/user/merges) at the beginning of the execution, after that, it will start using external aggregation.
              Default value: **0** for versions 24.12 and lower, **0.5** for versions 25.1 and higher.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_bytes_ratio_before_external_group_by).
            type: number
            format: double
          maxBytesRatioBeforeExternalSort:
            description: |-
              **number** (double)
              The ratio of available memory that is allowed for ORDER BY. Once reached, external sort is used.
              For example, if set to 0.6, ORDER BY will allow using 60% of available memory (to server/user/merges) at the beginning of the execution, after that, it will start using external sort.
              Note, that max_bytes_before_external_sort is still respected, spilling to disk will be done only if the sorting block is bigger then max_bytes_before_external_sort.
              Default value: **0** for versions 24.12 and lower, **0.5** for versions 25.1 and higher.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_bytes_ratio_before_external_sort).
            type: number
            format: double
          maxBytesBeforeExternalSort:
            description: |-
              **string** (int64)
              Sets the threshold of RAM consumption (in bytes) after that the temporary data, collected during the **ORDER BY** operation,
              should be flushed to disk to limit the RAM consumption. If set to **0**, **ORDER BY** in the external memory is disabled.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_bytes_before_external_sort).
            type: string
            format: int64
          groupByTwoLevelThreshold:
            description: |-
              **string** (int64)
              Sets the threshold of the number of keys, after that the two-level aggregation should be used. **0** means threshold is not set.
              Default value: **100000**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#group_by_two_level_threshold).
            type: string
            format: int64
          groupByTwoLevelThresholdBytes:
            description: |-
              **string** (int64)
              Sets the threshold of the number of bytes, after that the two-level aggregation should be used. **0** means threshold is not set.
              Default value: **50000000**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#group_by_two_level_threshold_bytes).
            type: string
            format: int64
          deduplicateBlocksInDependentMaterializedViews:
            description: |-
              **boolean**
              Enables or disables the deduplication check for materialized views that receive data from replicated tables.
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#deduplicate_blocks_in_dependent_materialized_views).
            type: boolean
          localFilesystemReadMethod:
            description: |-
              **enum** (LocalFilesystemReadMethod)
              Method of reading data from local filesystem.
              The LOCAL_FILESYSTEM_READ_METHOD_IO_URING is experimental and does not work for Log, TinyLog, StripeLog, File, Set and Join, and
              other tables with append-able files in presence of concurrent reads and writes.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#local_filesystem_read_method).
              - `LOCAL_FILESYSTEM_READ_METHOD_READ`: Use the read() system call.
              - `LOCAL_FILESYSTEM_READ_METHOD_PREAD_THREADPOOL`: Use pread() system calls dispatched via a thread pool.
              - `LOCAL_FILESYSTEM_READ_METHOD_PREAD`: Use the pread() system call.
              - `LOCAL_FILESYSTEM_READ_METHOD_NMAP`: Use memory-mapped I/O (mmap).
              - `LOCAL_FILESYSTEM_READ_METHOD_IO_URING`: Use Linux io_uring for asynchronous I/O.
            type: string
            enum:
              - LOCAL_FILESYSTEM_READ_METHOD_UNSPECIFIED
              - LOCAL_FILESYSTEM_READ_METHOD_READ
              - LOCAL_FILESYSTEM_READ_METHOD_PREAD_THREADPOOL
              - LOCAL_FILESYSTEM_READ_METHOD_PREAD
              - LOCAL_FILESYSTEM_READ_METHOD_NMAP
              - LOCAL_FILESYSTEM_READ_METHOD_IO_URING
          remoteFilesystemReadMethod:
            description: |-
              **enum** (RemoteFilesystemReadMethod)
              Method of reading data from remote filesystem.
              Default value: **REMOTE_FILESYSTEM_READ_METHOD_THREADPOOL**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#remote_filesystem_read_method).
              - `REMOTE_FILESYSTEM_READ_METHOD_READ`: Read data synchronously.
              - `REMOTE_FILESYSTEM_READ_METHOD_THREADPOOL`: Read data using a thread pool for parallelism.
            type: string
            enum:
              - REMOTE_FILESYSTEM_READ_METHOD_UNSPECIFIED
              - REMOTE_FILESYSTEM_READ_METHOD_READ
              - REMOTE_FILESYSTEM_READ_METHOD_THREADPOOL
          priority:
            description: |-
              **string** (int64)
              Sets the priority of a query.
              * **0** - priorities are not used.
              * **1** - the highest priority.
              * and so on. The higher the number, the lower a query's priority.
              If ClickHouse is working with the high-priority queries, and a low-priority query enters, then the low-priority query
              is paused until higher-priority queries are completed.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#priority).
            type: string
            format: int64
          maxThreads:
            description: |-
              **string** (int64)
              Limits the maximum number of threads to process the request. If set to **0**, the number of threads is calculated automatically based on the number of available CPU cores.
              The setting applies to threads that perform the same stages of the query processing pipeline in parallel. It does not take threads that read data from remote servers into account.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_threads).
            type: string
            format: int64
          maxInsertThreads:
            description: |-
              **string** (int64)
              The maximum number of threads to execute the **INSERT SELECT** query.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_insert_threads).
            type: string
            format: int64
          maxMemoryUsage:
            description: |-
              **string** (int64)
              Limits the maximum memory usage (in bytes) for processing of a single user's query on a single server. **0** means unlimited.
              This limitation is enforced for any user's single query on a single server.
              If you use **max_bytes_before_external_group_by** or **max_bytes_before_external_sort** setting, then it is recommended to set
              their values twice as low as **max_memory_usage** setting value.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_memory_usage).
            type: string
            format: int64
          maxMemoryUsageForUser:
            description: |-
              **string** (int64)
              Limits the maximum memory usage (in bytes) for processing of user's queries on a single server. **0** means unlimited.
              This limitation is enforced for all queries that belong to one user and run simultaneously on a single server.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_memory_usage_for_user).
            type: string
            format: int64
          memoryOvercommitRatioDenominator:
            description: |-
              **string** (int64)
              It represents the soft memory limit when the hard limit is reached on the global level.
              This value is used to compute the overcommit ratio for the query. **0** means skip the query.
              Default value: **1073741824** (1 GiB).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#memory_overcommit_ratio_denominator).
            type: string
            format: int64
          memoryOvercommitRatioDenominatorForUser:
            description: |-
              **string** (int64)
              It represents the soft memory limit when the hard limit is reached on the user level.
              This value is used to compute the overcommit ratio for the user. **0** means skip the query.
              Default value: **1073741824** (1 GiB).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#memory_overcommit_ratio_denominator_for_user).
            type: string
            format: int64
          memoryUsageOvercommitMaxWaitMicroseconds:
            description: |-
              **string** (int64)
              Maximum time thread will wait for memory to be freed in the case of memory overcommit. If the timeout is reached and memory is not freed, an exception is thrown.
              Default value: **5000000** (5 seconds).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#memory_usage_overcommit_max_wait_microseconds).
            type: string
            format: int64
          maxNetworkBandwidth:
            description: |-
              **string** (int64)
              The maximum speed of data exchange over the network in bytes per second for a query. **0** means unlimited.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_network_bandwidth).
            type: string
            format: int64
          maxNetworkBandwidthForUser:
            description: |-
              **string** (int64)
              The maximum speed of data exchange over the network in bytes per second for all concurrently running user queries. **0** means unlimited.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_network_bandwidth_for_user).
            type: string
            format: int64
          maxNetworkBytes:
            description: |-
              **string** (int64)
              Limits the data volume (in bytes) that is received or transmitted over the network when executing a query.
              This setting applies to every individual query.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_network_bytes).
            type: string
            format: int64
          maxTemporaryDataOnDiskSizeForQuery:
            description: |-
              **string** (int64)
              The maximum amount of data consumed by temporary files on disk in bytes for all concurrently running queries. **0** means unlimited.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/query-complexity#settings_max_temporary_data_on_disk_size_for_query).
            type: string
            format: int64
          maxTemporaryDataOnDiskSizeForUser:
            description: |-
              **string** (int64)
              The maximum amount of data consumed by temporary files on disk in bytes for all concurrently running user queries. **0** means unlimited.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/query-complexity#settings_max_temporary_data_on_disk_size_for_user).
            type: string
            format: int64
          maxConcurrentQueriesForUser:
            description: |-
              **string** (int64)
              The maximum number of simultaneously processed queries per user. **0** means unlimited.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_concurrent_queries_for_user).
            type: string
            format: int64
          forceIndexByDate:
            description: |-
              **boolean**
              Disables query execution if the index cannot be used by date.
              This setting has effect only for tables of the MergeTree family.
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#force_index_by_date).
            type: boolean
          forcePrimaryKey:
            description: |-
              **boolean**
              Disables query execution if indexing by the primary key cannot be used.
              This setting has effect only for tables of the MergeTree family.
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#force_primary_key).
            type: boolean
          maxRowsToRead:
            description: |-
              **string** (int64)
              Limits the maximum number of rows that can be read from a table when running a query.  **0** means unlimited.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/query-complexity#max-rows-to-read).
            type: string
            format: int64
          maxBytesToRead:
            description: |-
              **string** (int64)
              Limits the maximum number of bytes (uncompressed data) that can be read from a table when running a query.  **0** means unlimited.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/query-complexity#max-bytes-to-read).
            type: string
            format: int64
          readOverflowMode:
            description: |-
              **enum** (OverflowMode)
              Determines the behavior on exceeding limits while reading the data.
              Default value: **OVERFLOW_MODE_THROW**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#read_overflow_mode).
              - `OVERFLOW_MODE_THROW`: Abort query execution and return an error.
              - `OVERFLOW_MODE_BREAK`: Return a partial result.
            type: string
            enum:
              - OVERFLOW_MODE_UNSPECIFIED
              - OVERFLOW_MODE_THROW
              - OVERFLOW_MODE_BREAK
          maxRowsToGroupBy:
            description: |-
              **string** (int64)
              Limits the maximum number of unique keys received from aggregation. **0** means unlimited.
              This setting lets you limit RAM consumption when aggregating.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_rows_to_group_by).
            type: string
            format: int64
          groupByOverflowMode:
            description: |-
              **enum** (GroupByOverflowMode)
              Determines the behavior on exceeding limits while doing aggregation.
              Default value: **GROUP_BY_OVERFLOW_MODE_THROW**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#group_by_overflow_mode).
              - `GROUP_BY_OVERFLOW_MODE_THROW`: Abort query execution and return an error.
              - `GROUP_BY_OVERFLOW_MODE_BREAK`: Return a partial result.
              - `GROUP_BY_OVERFLOW_MODE_ANY`: Continuing aggregation for the keys that got into the set, but do not add new keys to the set.
            type: string
            enum:
              - GROUP_BY_OVERFLOW_MODE_UNSPECIFIED
              - GROUP_BY_OVERFLOW_MODE_THROW
              - GROUP_BY_OVERFLOW_MODE_BREAK
              - GROUP_BY_OVERFLOW_MODE_ANY
          maxRowsToSort:
            description: |-
              **string** (int64)
              Limits the maximum number of rows that can be read from a table for sorting. **0** means unlimited.
              This setting lets you to limit RAM consumption when sorting
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_rows_to_sort).
            type: string
            format: int64
          maxBytesToSort:
            description: |-
              **string** (int64)
              Limits the maximum number of bytes (uncompressed data) that can be read from a table for sorting. **0** means unlimited.
              This setting lets you to limit RAM consumption when sorting
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_bytes_to_sort).
            type: string
            format: int64
          sortOverflowMode:
            description: |-
              **enum** (OverflowMode)
              Determines the behavior on exceeding limits while sorting.
              Default value: **OVERFLOW_MODE_THROW**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#sort_overflow_mode).
              - `OVERFLOW_MODE_THROW`: Abort query execution and return an error.
              - `OVERFLOW_MODE_BREAK`: Return a partial result.
            type: string
            enum:
              - OVERFLOW_MODE_UNSPECIFIED
              - OVERFLOW_MODE_THROW
              - OVERFLOW_MODE_BREAK
          maxResultRows:
            description: |-
              **string** (int64)
              Limits the number of rows in the result. **0** means unlimited.
              This limitation is also checked for subqueries and parts of distributed queries that run on remote servers.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_result_rows).
            type: string
            format: int64
          maxResultBytes:
            description: |-
              **string** (int64)
              Limits the result size in bytes (uncompressed data). **0** means unlimited.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_result_bytes).
            type: string
            format: int64
          resultOverflowMode:
            description: |-
              **enum** (OverflowMode)
              Determines the behavior on exceeding limits while forming result.
              Default value: **OVERFLOW_MODE_THROW**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#result_overflow_mode).
              - `OVERFLOW_MODE_THROW`: Abort query execution and return an error.
              - `OVERFLOW_MODE_BREAK`: Return a partial result.
            type: string
            enum:
              - OVERFLOW_MODE_UNSPECIFIED
              - OVERFLOW_MODE_THROW
              - OVERFLOW_MODE_BREAK
          maxRowsInDistinct:
            description: |-
              **string** (int64)
              Limits the maximum number of different rows in the state, which is used for performing **DISTINCT**. **0** means unlimited.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_rows_in_distinct).
            type: string
            format: int64
          maxBytesInDistinct:
            description: |-
              **string** (int64)
              Limits the maximum number of bytes (uncompressed data) in the state, which is used for performing **DISTINCT**. **0** means unlimited.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_bytes_in_distinct).
            type: string
            format: int64
          distinctOverflowMode:
            description: |-
              **enum** (OverflowMode)
              Determines the behavior on exceeding limits while performing **DISTINCT**.
              Default value: **OVERFLOW_MODE_THROW**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#distinct_overflow_mode).
              - `OVERFLOW_MODE_THROW`: Abort query execution and return an error.
              - `OVERFLOW_MODE_BREAK`: Return a partial result.
            type: string
            enum:
              - OVERFLOW_MODE_UNSPECIFIED
              - OVERFLOW_MODE_THROW
              - OVERFLOW_MODE_BREAK
          maxRowsToTransfer:
            description: |-
              **string** (int64)
              Limits the maximum number of rows that can be passed to a remote server or saved in a temporary table when using **GLOBAL IN|JOIN**. **0** means unlimited.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_rows_to_transfer).
            type: string
            format: int64
          maxBytesToTransfer:
            description: |-
              **string** (int64)
              Limits the maximum number of bytes (uncompressed data) that can be passed to a remote server or saved in a temporary table when using **GLOBAL IN|JOIN**.
              **0** means unlimited.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_bytes_to_transfer).
            type: string
            format: int64
          transferOverflowMode:
            description: |-
              **enum** (OverflowMode)
              Determines the behavior on exceeding limits while transfering data.
              Default value: **OVERFLOW_MODE_THROW**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#transfer_overflow_mode).
              - `OVERFLOW_MODE_THROW`: Abort query execution and return an error.
              - `OVERFLOW_MODE_BREAK`: Return a partial result.
            type: string
            enum:
              - OVERFLOW_MODE_UNSPECIFIED
              - OVERFLOW_MODE_THROW
              - OVERFLOW_MODE_BREAK
          maxExecutionTime:
            description: |-
              **string** (int64)
              Limits the maximum query execution time in milliseconds. **0** means unlimited.
              The timeout is checked and the query can stop only in designated places during data processing.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_execution_time).
            type: string
            format: int64
          timeoutOverflowMode:
            description: |-
              **enum** (OverflowMode)
              Determines the behavior on exceeding limits of execution time.
              Default value: **OVERFLOW_MODE_THROW**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#timeout_overflow_mode).
              - `OVERFLOW_MODE_THROW`: Abort query execution and return an error.
              - `OVERFLOW_MODE_BREAK`: Return a partial result.
            type: string
            enum:
              - OVERFLOW_MODE_UNSPECIFIED
              - OVERFLOW_MODE_THROW
              - OVERFLOW_MODE_BREAK
          maxRowsInSet:
            description: |-
              **string** (int64)
              Limits on the maximum number of rows in the set resulting from the execution of the **IN** section. **0** means unlimited.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_rows_in_set).
            type: string
            format: int64
          maxBytesInSet:
            description: |-
              **string** (int64)
              Limits on the maximum number of bytes (uncompressed data) in the set resulting from the execution of the **IN** section. **0** means unlimited.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_bytes_in_set).
            type: string
            format: int64
          setOverflowMode:
            description: |-
              **enum** (OverflowMode)
              Determines the behavior on exceeding max_rows_in_set or max_bytes_in_set limit.
              Default value: **OVERFLOW_MODE_THROW**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#set_overflow_mode).
              - `OVERFLOW_MODE_THROW`: Abort query execution and return an error.
              - `OVERFLOW_MODE_BREAK`: Return a partial result.
            type: string
            enum:
              - OVERFLOW_MODE_UNSPECIFIED
              - OVERFLOW_MODE_THROW
              - OVERFLOW_MODE_BREAK
          maxRowsInJoin:
            description: |-
              **string** (int64)
              Limits the maximum number of rows in the hash table that is used when joining tables. **0** means unlimited.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_rows_in_join).
            type: string
            format: int64
          maxBytesInJoin:
            description: |-
              **string** (int64)
              Limits the maximum number of bytes in the hash table that is used when joining tables. **0** means unlimited.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_bytes_in_join).
            type: string
            format: int64
          joinOverflowMode:
            description: |-
              **enum** (OverflowMode)
              Determines the behavior on exceeding max_rows_in_join or max_bytes_in_join limit.
              Default value: **OVERFLOW_MODE_THROW**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#join_overflow_mode).
              - `OVERFLOW_MODE_THROW`: Abort query execution and return an error.
              - `OVERFLOW_MODE_BREAK`: Return a partial result.
            type: string
            enum:
              - OVERFLOW_MODE_UNSPECIFIED
              - OVERFLOW_MODE_THROW
              - OVERFLOW_MODE_BREAK
          maxColumnsToRead:
            description: |-
              **string** (int64)
              Limits the maximum number of columns that can be read from a table in a single query. **0** means unlimited.
              If the query requires to read more columns to complete, then it will be aborted.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_columns_to_read).
            type: string
            format: int64
          maxTemporaryColumns:
            description: |-
              **string** (int64)
              Limits the maximum number of temporary columns that must be kept in RAM simultaneously when running a query, including constant columns. **0** means unlimited.
              If the query generates more than the specified number of temporary columns in memory as a result of intermediate calculation, then it will be aborted.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_temporary_columns).
            type: string
            format: int64
          maxTemporaryNonConstColumns:
            description: |-
              **string** (int64)
              Limits the maximum number of temporary columns that must be kept in RAM simultaneously when running a query, not including constant columns. **0** means unlimited.
              If the query generates more than the specified number of temporary columns in memory as a result of intermediate calculation, then it will be aborted.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_temporary_non_const_columns).
            type: string
            format: int64
          maxQuerySize:
            description: |-
              **string** (int64)
              Limits the size of the part of a query that can be transferred to RAM for parsing with the SQL parser, in bytes.
              Data in the **VALUES** clause of **INSERT** queries is processed by a separate stream parser (that consumes O(1) RAM) and not affected by this restriction.
              Default value: **262144** (256 KiB).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_query_size).
            type: string
            format: int64
          maxAstDepth:
            description: |-
              **string** (int64)
              Limits the maximum depth of query syntax tree.
              Executing a big and complex query may result in building a syntax tree of enormous depth.
              By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.
              Default value: **1000**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_ast_depth).
            type: string
            format: int64
          maxAstElements:
            description: |-
              **string** (int64)
              Limits the maximum size of query syntax tree in number of nodes.
              Executing a big and complex query may result in building a syntax tree of enormous size.
              By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.
              Default value: **50000**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_ast_elements).
            type: string
            format: int64
          maxExpandedAstElements:
            description: |-
              **string** (int64)
              Limits the maximum size of query syntax tree in number of nodes after expansion of aliases and the asterisk values.
              Executing a big and complex query may result in building a syntax tree of enormous size.
              By using this setting, you can prohibit execution of over-sized or non-optimized queries for huge tables.
              Default value: **500000**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_expanded_ast_elements).
            type: string
            format: int64
          maxParserDepth:
            description: |-
              **string** (int64)
              Limits maximum recursion depth in the recursive descent parser. Allows controlling the stack size. If set to **0**, recursion depth is unlimited.
              Default value: **1000**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_parser_depth).
            type: string
            format: int64
          minExecutionSpeed:
            description: |-
              **string** (int64)
              Minimal execution speed in rows per second. Checked on every data block when timeout_before_checking_execution_speed expires.
              If the execution speed is lower, an exception is thrown. **0** means unlimited.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#min_execution_speed).
            type: string
            format: int64
          minExecutionSpeedBytes:
            description: |-
              **string** (int64)
              Minimal execution speed in bytes per second. Checked on every data block when timeout_before_checking_execution_speed expires.
              If the execution speed is lower, an exception is thrown. **0** means unlimited.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#min_execution_speed_bytes).
            type: string
            format: int64
          inputFormatValuesInterpretExpressions:
            description: |-
              **boolean**
              Enables or disables SQL parser if the fast stream parser cannot parse the data.
              Enable this setting, if the data that you want to insert into a table contains SQL expressions.
              For example, the stream parser is unable to parse a value that contains **now()** expression; therefore an **INSERT** query for this value
              will fail and no data will be inserted into a table. With enabled SQL parser, this expression is parsed correctly: the **now()** expression
              will be parsed as SQL function, interpreted, and the current date and time will be inserted into the table as a result.
              This setting has effect only if you use [Values](https://clickhouse.com/docs/en/interfaces/formats/#data-format-values) format when inserting data.
              Default value: **true**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#input_format_values_interpret_expressions).
            type: boolean
          inputFormatDefaultsForOmittedFields:
            description: |-
              **boolean**
              Enables or disables replacing omitted input values with default values of the respective columns when performing **INSERT** queries.
              Default value: **true**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#input_format_defaults_for_omitted_fields).
            type: boolean
          inputFormatNullAsDefault:
            description: |-
              **boolean**
              Enables or disables the initialization of **NULL** fields with default values, if data type of these fields is not nullable.
              Default value: **true**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#input_format_null_as_default).
            type: boolean
          inputFormatWithNamesUseHeader:
            description: |-
              **boolean**
              Enables or disables checking the column order when inserting data.
              Default value: **true**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#input_format_with_names_use_header).
            type: boolean
          outputFormatJsonQuote_64bitIntegers:
            description: |-
              **boolean**
              Enables or disables quoting of 64-bit integers in JSON output format.
              If this setting is enabled, then 64-bit integers (**UInt64** and **Int64**) will be quoted when written to JSON output
              in order to maintain compatibility with the most of the JavaScript engines. Otherwise, such integers will not be quoted.
              Default value: **false** for versions 25.8 and higher, **true** for versions 25.7 and lower.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#output_format_json_quote_64bit_integers).
            type: boolean
          outputFormatJsonQuoteDenormals:
            description: |-
              **boolean**
              Enables special floating-point values (**+nan**, **-nan**, **+inf** and **-inf**) in JSON output format.
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#output_format_json_quote_denormals).
            type: boolean
          dateTimeInputFormat:
            description: |-
              **enum** (DateTimeInputFormat)
              Specifies which of date time parsers to use.
              Default value: **DATE_TIME_INPUT_FORMAT_BASIC**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#date_time_input_format).
              - `DATE_TIME_INPUT_FORMAT_BEST_EFFORT`: Parse the basic YYYY-MM-DD HH:MM:SS format and all ISO 8601 date and time formats.
              - `DATE_TIME_INPUT_FORMAT_BASIC`: Parse date/time in YYYY-MM-DD or YYYY-MM-DD HH:MM:SS format only.
              - `DATE_TIME_INPUT_FORMAT_BEST_EFFORT_US`: Like best_effort but interprets ambiguous dates (e.g., MM/DD/YYYY) using US conventions (month-first).
            type: string
            enum:
              - DATE_TIME_INPUT_FORMAT_UNSPECIFIED
              - DATE_TIME_INPUT_FORMAT_BEST_EFFORT
              - DATE_TIME_INPUT_FORMAT_BASIC
              - DATE_TIME_INPUT_FORMAT_BEST_EFFORT_US
          dateTimeOutputFormat:
            description: |-
              **enum** (DateTimeOutputFormat)
              Specifies which of date time output formats to use.
              Default value: **DATE_TIME_OUTPUT_FORMAT_SIMPLE**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#date_time_output_format).
              - `DATE_TIME_OUTPUT_FORMAT_SIMPLE`: Output date/time in a simple human-readable format (e.g. 2024-01-01 12:00:00).
              - `DATE_TIME_OUTPUT_FORMAT_ISO`: Output date/time in ISO 8601 format (e.g. 2024-01-01T12:00:00Z).
              - `DATE_TIME_OUTPUT_FORMAT_UNIX_TIMESTAMP`: Output date/time as a Unix timestamp (seconds since epoch).
            type: string
            enum:
              - DATE_TIME_OUTPUT_FORMAT_UNSPECIFIED
              - DATE_TIME_OUTPUT_FORMAT_SIMPLE
              - DATE_TIME_OUTPUT_FORMAT_ISO
              - DATE_TIME_OUTPUT_FORMAT_UNIX_TIMESTAMP
          lowCardinalityAllowInNativeFormat:
            description: |-
              **boolean**
              Allows or restricts using the LowCardinality data type with the Native format.
              LowCardinality columns (aka sparse columns) store data in more effective way, compared to regular columns, by using hash tables.
              If data to insert suits this storage format, ClickHouse will place them into LowCardinality column.
              If you use a third-party ClickHouse client that can't work with LowCardinality columns, then this client will not be able to correctly interpret
              the result of the query that asks for data stored in LowCardinality column. Disable this setting to convert LowCardinality column to regular column
              when creating the result, so such clients will be able to process the result.
              Official ClickHouse client works with LowCardinality columns out-of-the-box.
              Default value: **true**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#low_cardinality_allow_in_native_format).
            type: boolean
          emptyResultForAggregationByEmptySet:
            description: |-
              **boolean**
              Enables or disables returning of empty result when aggregating without keys (with **GROUP BY** operation absent) on empty set (e.g., **SELECT count(*) FROM table WHERE 0**).
              * **true** - ClickHouse will return an empty result for such queries.
              * **false** - ClickHouse will return a single-line result consisting of **NULL** values for aggregation functions, in accordance with SQL standard.
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#empty_result_for_aggregation_by_empty_set).
            type: boolean
          formatRegexp:
            description: |-
              **string**
              Regular expression (for Regexp format).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#format_regexp).
            type: string
          formatRegexpEscapingRule:
            description: |-
              **enum** (FormatRegexpEscapingRule)
              Field escaping rule (for Regexp format).
              Default value: **FORMAT_REGEXP_ESCAPING_RULE_RAW**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#format_regexp_escaping_rule).
              - `FORMAT_REGEXP_ESCAPING_RULE_ESCAPED`: Apply backslash escaping (as in TSV format).
              - `FORMAT_REGEXP_ESCAPING_RULE_QUOTED`: Apply quoting escaping (as in Values format).
              - `FORMAT_REGEXP_ESCAPING_RULE_CSV`: Apply CSV escaping rules.
              - `FORMAT_REGEXP_ESCAPING_RULE_JSON`: Apply JSON escaping rules.
              - `FORMAT_REGEXP_ESCAPING_RULE_XML`: Apply XML escaping rules.
              - `FORMAT_REGEXP_ESCAPING_RULE_RAW`: No escaping; use raw field values (as in TSVRaw format).
            type: string
            enum:
              - FORMAT_REGEXP_ESCAPING_RULE_UNSPECIFIED
              - FORMAT_REGEXP_ESCAPING_RULE_ESCAPED
              - FORMAT_REGEXP_ESCAPING_RULE_QUOTED
              - FORMAT_REGEXP_ESCAPING_RULE_CSV
              - FORMAT_REGEXP_ESCAPING_RULE_JSON
              - FORMAT_REGEXP_ESCAPING_RULE_XML
              - FORMAT_REGEXP_ESCAPING_RULE_RAW
          formatRegexpSkipUnmatched:
            description: |-
              **boolean**
              Skip lines unmatched by regular expression (for Regexp format)
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#format_regexp_skip_unmatched).
            type: boolean
          inputFormatParallelParsing:
            description: |-
              **boolean**
              Enables or disables order-preserving parallel parsing of data formats. Supported only for TSV, TSKV, CSV and JSONEachRow formats.
              Default value: **true**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#input_format_parallel_parsing).
            type: boolean
          inputFormatImportNestedJson:
            description: |-
              **boolean**
              Enables or disables the insertion of JSON data with nested objects.
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#input_format_import_nested_json).
            type: boolean
          formatAvroSchemaRegistryUrl:
            description: |-
              **string**
              Avro schema registry URL.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/formats#format_avro_schema_registry_url).
            type: string
          dataTypeDefaultNullable:
            description: |-
              **boolean**
              Allows data types without explicit modifiers **NULL** or **NOT NULL** in column definition will be Nullable.
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#data_type_default_nullable).
            type: boolean
          httpConnectionTimeout:
            description: |-
              **string** (int64)
              HTTP connection timeout, in milliseconds.
              Default value: **1000** (1 second).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#http_connection_timeout).
            type: string
            format: int64
          httpReceiveTimeout:
            description: |-
              **string** (int64)
              HTTP receive timeout, in milliseconds.
              Default value: **30000** (30 seconds).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#http_receive_timeout).
            type: string
            format: int64
          httpSendTimeout:
            description: |-
              **string** (int64)
              HTTP send timeout, in milliseconds.
              Default value: **30000** (30 seconds).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#http_send_timeout).
            type: string
            format: int64
          enableHttpCompression:
            description: |-
              **boolean**
              Enables or disables data compression in HTTP responses.
              By default, ClickHouse stores data compressed. When executing a query, its result is uncompressed.
              Use this setting to command ClickHouse to compress the result when sending it via HTTP.
              Enable this setting and add the **Accept-Encoding: &lt;compression method&gt;** HTTP header in a HTTP request to force compression of HTTP response from ClickHouse.
              ClickHouse support the following compression methods: **gzip**, **br** and **deflate**.
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#enable_http_compression).
            type: boolean
          sendProgressInHttpHeaders:
            description: |-
              **boolean**
              Enables or disables progress notifications using **X-ClickHouse-Progress** HTTP header.
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#send_progress_in_http_headers).
            type: boolean
          httpHeadersProgressInterval:
            description: |-
              **string** (int64)
              Minimum interval between progress notifications with **X-ClickHouse-Progress** HTTP header, in milliseconds.
              Default value: **100**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#http_headers_progress_interval_ms).
            type: string
            format: int64
          addHttpCorsHeader:
            description: |-
              **boolean**
              Adds CORS header in HTTP responses.
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#add_http_cors_header).
            type: boolean
          cancelHttpReadonlyQueriesOnClientClose:
            description: |-
              **boolean**
              Cancels HTTP read-only queries (e.g. **SELECT**) when a client closes the connection without waiting for the response.
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#cancel_http_readonly_queries_on_client_close).
            type: boolean
          maxHttpGetRedirects:
            description: |-
              **string** (int64)
              Limits the maximum number of HTTP GET redirect hops. If set to **0**, no hops is allowed.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_http_get_redirects).
            type: string
            format: int64
          httpMaxFieldNameSize:
            description: |-
              **string** (int64)
              Maximum length of field name in HTTP header.
              Default value: **4096** (4 KiB) for versions 26.4 and higher, **131072** (128 KiB) for versions 26.3 and lower.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#http_max_field_name_size).
            type: string
            format: int64
          httpMaxFieldValueSize:
            description: |-
              **string** (int64)
              Maximum length of field value in HTTP header.
              Default value: **131072**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#http_max_field_value_size).
            type: string
            format: int64
          quotaMode:
            description: |-
              **enum** (QuotaMode)
              Quota accounting mode.
              Default value: **QUOTA_MODE_DEFAULT**.
              - `QUOTA_MODE_DEFAULT`: Track resource usage as a single shared quota across all users without per-user separation.
              - `QUOTA_MODE_KEYED`: Track quota separately per unique quota key value passed in the query parameter.
              - `QUOTA_MODE_KEYED_BY_IP`: Track quota separately per client IP address.
            default: '**QUOTA_MODE_DEFAULT**'
            type: string
            enum:
              - QUOTA_MODE_UNSPECIFIED
              - QUOTA_MODE_DEFAULT
              - QUOTA_MODE_KEYED
              - QUOTA_MODE_KEYED_BY_IP
          asyncInsert:
            description: |-
              **boolean**
              If enabled, data from **INSERT** query is stored in queue and later flushed to table in background.
              Default value: **true** for versions 26.3 and higher, **false** for versions 26.2 and lower.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#async_insert).
            type: boolean
          waitForAsyncInsert:
            description: |-
              **boolean**
              Enables or disables waiting for processing of asynchronous insertion. If enabled, server returns OK only after the data is inserted.
              Default value: **true**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#wait_for_async_insert).
            type: boolean
          waitForAsyncInsertTimeout:
            description: |-
              **string** (int64)
              Timeout for waiting for processing asynchronous inserts, in seconds.
              Default value: **120** (2 minutes).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#wait_for_async_insert_timeout).
            type: string
            format: int64
          asyncInsertMaxDataSize:
            description: |-
              **string** (int64)
              The maximum size of the unparsed data in bytes collected per query before being inserted.
              Default value: **10485760** (10 MiB).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#async_insert_max_data_size).
            type: string
            format: int64
          asyncInsertBusyTimeout:
            description: |-
              **string** (int64)
              Maximum time to wait before dumping collected data per query since the first data appeared.
              Default value: **200**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#async_insert_busy_timeout_max_ms).
            type: string
            format: int64
          asyncInsertUseAdaptiveBusyTimeout:
            description: |-
              **boolean**
              Enables of disables adaptive busy timeout for asynchronous inserts.
              Default value: **true**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#async_insert_use_adaptive_busy_timeout).
            type: boolean
          logQueryThreads:
            description: |-
              **boolean**
              Enables or disables query threads logging to the the system.query_thread_log table.
              This setting has effect only when **log_queries** setting is enabled.
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#log_query_threads).
            type: boolean
          logQueryViews:
            description: |-
              **boolean**
              Enables or disables query views logging to the the system.query_views_log table.
              Default value: **true**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#log_query_views).
            type: boolean
          logQueriesProbability:
            description: |-
              **number** (double)
              Log queries with the specified probability.
              Default value: **1**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#log_queries_probability).
            type: number
            format: double
          logProcessorsProfiles:
            description: |-
              **boolean**
              Enables or disables logging of processors level profiling data to the the system.processors_profile_log table.
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#log_processors_profiles).
            type: boolean
          useQueryCache:
            description: |-
              **boolean**
              If turned on, **SELECT** queries may utilize the query cache.
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#use_query_cache).
            type: boolean
          enableReadsFromQueryCache:
            description: |-
              **boolean**
              If turned on, results of **SELECT** queries are retrieved from the query cache.
              Default value: **true**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#enable_reads_from_query_cache).
            type: boolean
          enableWritesToQueryCache:
            description: |-
              **boolean**
              If turned on, results of **SELECT** queries are stored in the query cache.
              Default value: **true**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#enable_writes_to_query_cache).
            type: boolean
          queryCacheMinQueryRuns:
            description: |-
              **string** (int64)
              Minimum number of times a **SELECT** query must run before its result is stored in the query cache.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#query_cache_min_query_runs).
            type: string
            format: int64
          queryCacheMinQueryDuration:
            description: |-
              **string** (int64)
              Minimum duration in milliseconds a query needs to run for its result to be stored in the query cache.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#query_cache_min_query_duration).
            type: string
            format: int64
          queryCacheTtl:
            description: |-
              **string** (int64)
              After this time in seconds entries in the query cache become stale.
              Default value: **60** (1 minute).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#query_cache_ttl).
            type: string
            format: int64
          queryCacheMaxEntries:
            description: |-
              **string** (int64)
              The maximum number of query results the current user may store in the query cache. **0** means unlimited.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#query_cache_max_entries).
            type: string
            format: int64
          queryCacheMaxSizeInBytes:
            description: |-
              **string** (int64)
              The maximum amount of memory (in bytes) the current user may allocate in the query cache. **0** means unlimited.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#query_cache_max_size_in_bytes).
            type: string
            format: int64
          queryCacheTag:
            description: |-
              **string**
              A string which acts as a label for query cache entries. The same queries with different tags are considered different by the query cache.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#query_cache_tag).
            type: string
          queryCacheShareBetweenUsers:
            description: |-
              **boolean**
              If turned on, the result of **SELECT** queries cached in the query cache can be read by other users.
              It is not recommended to enable this setting due to security reasons.
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#query_cache_share_between_users).
            type: boolean
          queryCacheNondeterministicFunctionHandling:
            description: |-
              **enum** (QueryCacheNondeterministicFunctionHandling)
              Controls how the query cache handles **SELECT** queries with non-deterministic functions like rand() or now().
              Default value: **QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_THROW**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#query_cache_nondeterministic_function_handling).
              - `QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_THROW`: Throw an exception and don't cache the query result.
              - `QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_SAVE`: Cache the query result.
              - `QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_IGNORE`: Don't cache the query result and don't throw an exception.
            type: string
            enum:
              - QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_UNSPECIFIED
              - QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_THROW
              - QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_SAVE
              - QUERY_CACHE_NONDETERMINISTIC_FUNCTION_HANDLING_IGNORE
          queryCacheSystemTableHandling:
            description: |-
              **enum** (QueryCacheSystemTableHandling)
              Controls how the query cache handles **SELECT** queries against system tables.
              Default value: **QUERY_CACHE_SYSTEM_TABLE_HANDLING_THROW**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#query_cache_system_table_handling).
              - `QUERY_CACHE_SYSTEM_TABLE_HANDLING_THROW`: Throw an exception and don't cache the query result.
              - `QUERY_CACHE_SYSTEM_TABLE_HANDLING_SAVE`: Cache the query result.
              - `QUERY_CACHE_SYSTEM_TABLE_HANDLING_IGNORE`: Don't cache the query result and don't throw an exception.
            type: string
            enum:
              - QUERY_CACHE_SYSTEM_TABLE_HANDLING_UNSPECIFIED
              - QUERY_CACHE_SYSTEM_TABLE_HANDLING_THROW
              - QUERY_CACHE_SYSTEM_TABLE_HANDLING_SAVE
              - QUERY_CACHE_SYSTEM_TABLE_HANDLING_IGNORE
          countDistinctImplementation:
            description: |-
              **enum** (CountDistinctImplementation)
              Specifies which of the uniq* functions should be used to perform the **COUNT(DISTINCT ...)** construction.
              Default value: **COUNT_DISTINCT_IMPLEMENTATION_UNIQ_EXACT**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#count_distinct_implementation).
              - `COUNT_DISTINCT_IMPLEMENTATION_UNIQ`: Approximate count using an adaptive sampling algorithm. Fast with low memory usage; recommended for most scenarios.
              - `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_COMBINED`: Adaptive approximate count combining multiple algorithms for better accuracy than uniq.
              - `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_COMBINED_64`: Like uniqCombined but uses 64-bit hashing for better accuracy with large cardinalities.
              - `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_HLL_12`: Approximate count using HyperLogLog with 2^12 cells.
              - `COUNT_DISTINCT_IMPLEMENTATION_UNIQ_EXACT`: Exact count using a hash set. Higher memory usage but fully accurate.
            type: string
            enum:
              - COUNT_DISTINCT_IMPLEMENTATION_UNSPECIFIED
              - COUNT_DISTINCT_IMPLEMENTATION_UNIQ
              - COUNT_DISTINCT_IMPLEMENTATION_UNIQ_COMBINED
              - COUNT_DISTINCT_IMPLEMENTATION_UNIQ_COMBINED_64
              - COUNT_DISTINCT_IMPLEMENTATION_UNIQ_HLL_12
              - COUNT_DISTINCT_IMPLEMENTATION_UNIQ_EXACT
          joinedSubqueryRequiresAlias:
            description: |-
              **boolean**
              Force joined subqueries and table functions to have aliases for correct name qualification.
              Default value: **true**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#joined_subquery_requires_alias).
            type: boolean
          joinUseNulls:
            description: |-
              **boolean**
              Determines **JOIN** behavior on filling empty cells when merging tables. If enabled, the empty cells are filled with **NULL**.
              Otherwise, the empty cells are filled with the default value of the corresponding field type.
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#join_use_nulls).
            type: boolean
          transformNullIn:
            description: |-
              **boolean**
              Enables equality of **NULL** values for **IN** operator.
              By default, **NULL** values can't be compared because **NULL** means undefined value. Thus, comparison **expr = NULL** must always return false.
              With this setting enabled **NULL = NULL** returns true for **IN** operator.
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#transform_null_in).
            type: boolean
          insertNullAsDefault:
            description: |-
              **boolean**
              Enables or disables the insertion of default values instead of **NULL** into columns with not nullable data type.
              If column type is not nullable and this setting is disabled, then inserting NULL causes an exception.
              If column type is nullable, then NULL values are inserted as is, regardless of this setting.
              Default value: **true**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#insert_null_as_default).
            type: boolean
          joinAlgorithm:
            description: |-
              **enum** (JoinAlgorithm)
              Specifies which JOIN algorithm to use.
              Default value: **JOIN_ALGORITHM_DIRECT,JOIN_ALGORITHM_PARALLEL_HASH,JOIN_ALGORITHM_HASH** for versions 24.12 and higher, **JOIN_ALGORITHM_DIRECT,JOIN_ALGORITHM_AUTO** for versions from 23.8 to 24.11, **JOIN_ALGORITHM_AUTO** for versions 23.7 and lower.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#join_algorithm).
              - `JOIN_ALGORITHM_HASH`: Use a hash join algorithm.
              - `JOIN_ALGORITHM_PARALLEL_HASH`: Build several hash tables concurrently to speed up the build phase, at the cost of higher memory usage.
              - `JOIN_ALGORITHM_PARTIAL_MERGE`: Sort-based join that minimizes memory usage by processing sorted chunks of the right table; slower than hash join.
              - `JOIN_ALGORITHM_DIRECT`: Directly look up join keys in a dictionary-backed table (Dictionary, Join, or EmbeddedRocksDB engine). Supports LEFT ANY join only.
              - `JOIN_ALGORITHM_AUTO`: Automatically choose the best join algorithm at runtime based on available memory and data size.
              - `JOIN_ALGORITHM_FULL_SORTING_MERGE`: Non-memory-bound sort-merge join; can skip the sort phase when both tables are pre-sorted on the join key.
              - `JOIN_ALGORITHM_PREFER_PARTIAL_MERGE`: Prefer partial_merge join when applicable, falling back to hash join otherwise.
            type: array
            items:
              type: string
              enum:
                - JOIN_ALGORITHM_UNSPECIFIED
                - JOIN_ALGORITHM_HASH
                - JOIN_ALGORITHM_PARALLEL_HASH
                - JOIN_ALGORITHM_PARTIAL_MERGE
                - JOIN_ALGORITHM_DIRECT
                - JOIN_ALGORITHM_AUTO
                - JOIN_ALGORITHM_FULL_SORTING_MERGE
                - JOIN_ALGORITHM_PREFER_PARTIAL_MERGE
          anyJoinDistinctRightTableKeys:
            description: |-
              **boolean**
              Enables legacy ClickHouse server behaviour in **ANY INNER|LEFT JOIN** operations.
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#any_join_distinct_right_table_keys).
            type: boolean
          allowSuspiciousLowCardinalityTypes:
            description: |-
              **boolean**
              Allows or restricts using LowCardinality with data types with fixed size of 8 bytes or less.
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#allow_suspicious_low_cardinality_types).
            type: boolean
          flattenNested:
            description: |-
              **boolean**
              Sets the data format of nested columns.
              Default value: **true**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#flatten_nested).
            type: boolean
          memoryProfilerStep:
            description: |-
              **string** (int64)
              Sets the step of memory profiler. Whenever query memory usage becomes larger than every next step in number of bytes the memory profiler
              will collect the allocating stacktrace and will write it into trace_log. If set to **0**, memory profiler is disabled.
              Default value: **4194304**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#memory_profiler_step).
            type: string
            format: int64
          memoryProfilerSampleProbability:
            description: |-
              **number** (double)
              Collect random allocations and deallocations and write them into system.trace_log with MemorySample trace_type.
              The probability is for every alloc/free regardless to the size of the allocation.
              Default value: **0**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#memory_profiler_sample_probability).
            type: number
            format: double
          maxFinalThreads:
            description: |-
              **string** (int64)
              Sets the maximum number of parallel threads for the **SELECT** query data read phase with the **FINAL** modifier.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_final_threads).
            type: string
            format: int64
          maxReadBufferSize:
            description: |-
              **string** (int64)
              The maximum size of the buffer to read from the filesystem.
              Default value: **1048576** (1 MiB).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#max_read_buffer_size).
            type: string
            format: int64
          insertKeeperMaxRetries:
            description: |-
              **string** (int64)
              The setting sets the maximum number of retries for ClickHouse Keeper (or ZooKeeper) requests during insert into replicated MergeTree tables.
              Only Keeper requests which failed due to network error, Keeper session timeout or request timeout are considered for retries.
              Default value: **20**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#insert_keeper_max_retries).
            type: string
            format: int64
          doNotMergeAcrossPartitionsSelectFinal:
            description: |-
              **boolean**
              Enable or disable independent processing of partitions for **SELECT** queries with **FINAL**.
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/guides/replacing-merge-tree#exploiting-partitions-with-replacingmergetree).
            type: boolean
          ignoreMaterializedViewsWithDroppedTargetTable:
            description: |-
              **boolean**
              Ignore materialized views with dropped target table during pushing to views.
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#ignore_materialized_views_with_dropped_target_table).
            type: boolean
          enableAnalyzer:
            description: |-
              **boolean**
              Enables or disables new query analyzer.
              Default value: **true** for versions 25.9 and higher, **false** for version 25.8, **true** for versions from 25.5 to 25.7, **false** for versions 25.4 and lower.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/guides/developer/understanding-query-execution-with-the-analyzer#analyzer).
            type: boolean
          s3UseAdaptiveTimeouts:
            description: |-
              **boolean**
              Enables or disables adaptive timeouts for S3 requests.
              * **true** - for all S3 requests first two attempts are made with low send and receive timeouts.
              * **false** - all attempts are made with identical timeouts.
              Default value: **true**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#s3_use_adaptive_timeouts).
            type: boolean
          final:
            description: |-
              **boolean**
              If enabled, automatically applies **FINAL** modifier to all tables in a query, to tables where **FINAL** is applicable,
              including joined tables and tables in sub-queries, and distributed tables.
              Default value: **false**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#final).
            type: boolean
          useHivePartitioning:
            description: |-
              **boolean**
              When enabled, ClickHouse will detect Hive-style partitioning in path (/name=value/) in file-like table engines
              File/S3/URL/HDFS/AzureBlobStorage and will allow to use partition columns as virtual columns in the query.
              These virtual columns will have the same names as in the partitioned path, but starting with _.
              Default value: **true** for versions 25.1 and higher, **false** for versions 24.12 and lower.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#use_hive_partitioning).
            type: boolean
          showDataLakeCatalogsInSystemTables:
            description: |-
              **boolean**
              Enables or disables showing data lake catalogs in system tables.
              Default value: **false** for versions 25.10 and higher, **true** for versions 25.9 and lower.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/settings#show_data_lake_catalogs_in_system_tables).
            type: boolean
          compile:
            description: |-
              **boolean**
              The setting is deprecated and has no effect.
            deprecated: true
            type: boolean
          minCountToCompile:
            description: |-
              **string** (int64)
              The setting is deprecated and has no effect.
            deprecated: true
            type: string
            format: int64
          asyncInsertThreads:
            description: |-
              **string** (int64)
              The setting is deprecated and has no effect.
            deprecated: true
            type: string
            format: int64
          asyncInsertStaleTimeout:
            description: |-
              **string** (int64)
              The setting is deprecated and has no effect.
            deprecated: true
            type: string
            format: int64
      Resources:
        type: object
        properties:
          resourcePresetId:
            description: |-
              **string**
              ID of the preset for computational resources available to a host (CPU, memory etc.).
              All available presets are listed in the [documentation](/docs/managed-clickhouse/concepts/instance-types)
            type: string
          diskSize:
            description: |-
              **string** (int64)
              Volume of the storage available to a host, in bytes.
            type: string
            format: int64
          diskTypeId:
            description: |-
              **string**
              Type of the storage environment for the host.
              Possible values:
              * network-hdd - network HDD drive,
              * network-ssd - network SSD drive,
              * local-ssd - local SSD storage.
            type: string
      DiskSizeAutoscaling:
        type: object
        properties:
          plannedUsageThreshold:
            description: |-
              **string** (int64)
              Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
              Acceptable values are 0 to 100, inclusive.
            type: string
            format: int64
          emergencyUsageThreshold:
            description: |-
              **string** (int64)
              Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent.
              Acceptable values are 0 to 100, inclusive.
            type: string
            format: int64
          diskSizeLimit:
            description: |-
              **string** (int64)
              Limit on how large the storage for database instances can automatically grow, in bytes.
            type: string
            format: int64
      Clickhouse:
        type: object
        properties:
          config:
            description: |-
              **[ClickhouseConfig](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig)**
              Configuration for a ClickHouse server.
            $ref: '#/definitions/ClickhouseConfig'
          defaultUserSettings:
            description: |-
              **[UserSettings](/docs/managed-clickhouse/api-ref/Cluster/get#yandex.cloud.mdb.clickhouse.v1.UserSettings)**
              Default user settings.
            $ref: '#/definitions/UserSettings'
          resources:
            description: |-
              **[Resources](#yandex.cloud.mdb.clickhouse.v1.Resources)**
              Resources allocated to ClickHouse hosts.
            $ref: '#/definitions/Resources'
          diskSizeAutoscaling:
            description: |-
              **[DiskSizeAutoscaling](#yandex.cloud.mdb.clickhouse.v1.DiskSizeAutoscaling)**
              Disk size autoscaling settings.
            $ref: '#/definitions/DiskSizeAutoscaling'
      ShardConfigSpec:
        type: object
        properties:
          clickhouse:
            description: |-
              **[Clickhouse](/docs/managed-clickhouse/api-ref/Cluster/create#yandex.cloud.mdb.clickhouse.v1.ConfigSpec.Clickhouse)**
              ClickHouse configuration for a shard.
            $ref: '#/definitions/Clickhouse'
      HostSpec:
        type: object
        properties:
          zoneId:
            description: |-
              **string**
              ID of the availability zone where the host resides.
              To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/Zone/list#List) request.
              The maximum string length in characters is 50.
            type: string
          type:
            description: |-
              **enum** (Type)
              Required field. Type of the host to be deployed.
              - `CLICKHOUSE`: ClickHouse host.
              - `ZOOKEEPER`: ZooKeeper host.
              - `KEEPER`: ClickHouse Keeper host.
            type: string
            enum:
              - TYPE_UNSPECIFIED
              - CLICKHOUSE
              - ZOOKEEPER
              - KEEPER
          subnetId:
            description: |-
              **string**
              ID of the subnet that the host should belong to. This subnet should be a part
              of the network that the cluster belongs to.
              The ID of the network is set in the [Cluster.networkId](/docs/managed-clickhouse/api-ref/Cluster/get#yandex.cloud.mdb.clickhouse.v1.Cluster) field.
              The maximum string length in characters is 50.
            type: string
          assignPublicIp:
            description: |-
              **boolean**
              Whether the host should get a public IP address on creation.
              After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign
              a public IP to a host without one, recreate the host with [assignPublicIp](/docs/managed-clickhouse/api-ref/Cluster/updateHosts#yandex.cloud.mdb.clickhouse.v1.UpdateHostSpec) set as needed.
              Possible values:
              * false - don't assign a public IP to the host.
              * true - the host should have a public IP address.
            type: boolean
          shardName:
            description: |-
              **string**
              Name of the shard that the host is assigned to.
              The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
            pattern: '[a-zA-Z0-9_-]*'
            type: string
        required:
          - type
---

# Managed Service for ClickHouse API, REST: Cluster.AddShard

Creates a new shard in the specified cluster.
Deprecated. Use **AddShards** instead.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}/shards
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the ClickHouse cluster to add a shard to.
To get the ClickHouse cluster ID, use a [ClusterService.List](/docs/managed-clickhouse/api-ref/Cluster/list#List) request.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.mdb.clickhouse.v1.AddClusterShardRequest}

```json
{
  "shardName": "string",
  "configSpec": {
    "clickhouse": {
      "config": {
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
  },
  "hostSpecs": [
    {
      "zoneId": "string",
      "type": "string",
      "subnetId": "string",
      "assignPublicIp": "boolean",
      "shardName": "string"
    }
  ],
  "copySchema": "boolean"
}
```

#|
||Field | Description ||
|| shardName | **string**

Required field. Name for the new shard.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_][a-zA-Z0-9_-]* `. ||
|| configSpec | **[ShardConfigSpec](#yandex.cloud.mdb.clickhouse.v1.ShardConfigSpec)**

Configuration of the new shard. ||
|| hostSpecs[] | **[HostSpec](#yandex.cloud.mdb.clickhouse.v1.HostSpec)**

Configurations for ClickHouse hosts that should be created with the shard. ||
|| copySchema | **boolean**

Whether to copy schema to hosts of the shard to be created. The schema is copied from hosts of an existing shard. ||
|#

## ShardConfigSpec {#yandex.cloud.mdb.clickhouse.v1.ShardConfigSpec}

#|
||Field | Description ||
|| clickhouse | **[Clickhouse](#yandex.cloud.mdb.clickhouse.v1.ShardConfigSpec.Clickhouse)**

ClickHouse configuration for a shard. ||
|#

## Clickhouse {#yandex.cloud.mdb.clickhouse.v1.ShardConfigSpec.Clickhouse}

#|
||Field | Description ||
|| config | **[ClickhouseConfig](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig)**

ClickHouse settings for the shard. ||
|| resources | **[Resources](#yandex.cloud.mdb.clickhouse.v1.Resources)**

Computational resources for the shard. ||
|| weight | **string** (int64)

Relative weight of the shard considered when writing data to the cluster.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/operations/table_engines/distributed/). ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.clickhouse.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings. ||
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

- `TRACE`: All messages including trace-level debug information.
- `DEBUG`: All messages including debug-level information.
- `INFORMATION`: Informational messages, warnings, and errors.
- `WARNING`: Warnings and errors only.
- `ERROR`: Errors only. ||
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

- `TRACE`: All messages including trace-level debug information.
- `DEBUG`: All messages including debug-level information.
- `INFORMATION`: Informational messages, warnings, and errors.
- `WARNING`: Warnings and errors only.
- `ERROR`: Errors only. ||
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

Default value: **true** for versions 25.3 and higher, **false** for versions 25.2 and lower.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/session_log). ||
|| sessionLogRetentionSize | **string** (int64)

The maximum size that session_log can grow to before old data will be removed. If set to **0**,
automatic removal of session_log data based on size is disabled.

Default value: **536870912** (512 MiB) for versions 25.3 and higher, **0** for versions 25.2 and lower. ||
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
|| queryMetricLogEnabled | **boolean**

Enables or disables query_metric_log system table.

Default value: **false**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/query_metric_log). ||
|| queryMetricLogRetentionSize | **string** (int64)

The maximum size that query_metric_log can grow to before old data will be removed. If set to **0**,
automatic removal of query_metric_log data based on size is disabled.

Default value: **536870912** (512 MiB). ||
|| queryMetricLogRetentionTime | **string** (int64)

The maximum time that query_metric_log records will be retained before removal. If set to **0**,
automatic removal of query_metric_log data based on time is disabled.

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

Default value: **3** for versions 25.10 and higher, **30** for versions 25.9 and lower.

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

Default value: **false** for versions 25.8 and higher, **true** for versions 25.7 and lower.

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
|| vectorSimilarityIndexCacheSize | **string** (int64)

Size of cache for vector similarity indexes, in bytes. **0** means disabled.

Default value: **5368709120** (5 GiB).

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#vector_similarity_index_cache_size). ||
|| vectorSimilarityIndexCacheMaxEntries | **string** (int64)

Size of cache for vector similarity indexes, in entries. **0** means disabled.

Default value: **10000000**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#vector_similarity_index_cache_max_entries). ||
|| maxBuildVectorSimilarityIndexThreadPoolSize | **string** (int64)

The maximum number of threads to use for building vector indexes. **0** means unlimited.

Default value: **16**.

Change of the setting is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#max_build_vector_similarity_index_thread_pool_size). ||
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
|| tls | **[Tls](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Tls)**

TLS configuration for outgoing connections from ClickHouse.

Change of the settings of **tls** is applied with restart. ||
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

Sets whether **SELECT * FROM system.&lt;table&gt;** requires any grants and can be executed by any user.
If set to true then this query requires **GRANT SELECT ON system.&lt;table&gt;** just as for non-system tables.

Default value: **false**. ||
|| selectFromInformationSchemaRequiresGrant | **boolean**

Sets whether **SELECT * FROM information_schema.&lt;table&gt;** requires any grants and can be executed by any user.
If set to true, then this query requires **GRANT SELECT ON information_schema.&lt;table&gt;**, just as for ordinary tables.

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

Default value: **32** for versions 25.8 and higher, **16** for versions 25.7 and lower.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#max_replicated_merges_in_queue). ||
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
|| numberOfFreeEntriesInPoolToExecuteOptimizeEntirePartition | **string** (int64)

When there is less than specified number of free entries in pool, do not execute optimizing entire partition in the background (this task generated when set min_age_to_force_merge_seconds and enable min_age_to_force_merge_on_partition_only).
This is to leave free threads for regular merges and avoid "Too many parts".

Default value: **25**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#number_of_free_entries_in_pool_to_execute_optimize_entire_partition). ||
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

- `DEDUPLICATE_MERGE_PROJECTION_MODE_IGNORE`: Ignore projections during the merge without rebuilding them. Kept for compatibility only; may result in incorrect query answers.
- `DEDUPLICATE_MERGE_PROJECTION_MODE_THROW`: Throw an exception and refuse to merge if a projection exists.
- `DEDUPLICATE_MERGE_PROJECTION_MODE_DROP`: Drop projections before merging and do not rebuild them afterwards.
- `DEDUPLICATE_MERGE_PROJECTION_MODE_REBUILD`: Rebuild projections during the merge. ||
|| lightweightMutationProjectionMode | **enum** (LightweightMutationProjectionMode)

Determines the behavior of lightweight deletes for MergeTree tables with projections.

Default value: **LIGHTWEIGHT_MUTATION_PROJECTION_MODE_THROW**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#lightweight_mutation_projection_mode).

- `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_THROW`: Throw an exception if a projection exists.
- `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_DROP`: Drop projections and proceed with the lightweight mutation without rebuilding them.
- `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_REBUILD`: Rebuild projections after applying the lightweight mutation. ||
|| replicatedDeduplicationWindow | **string** (int64)

The number of most recently inserted blocks for which ClickHouse Keeper stores hash sums to check for duplicates.

Default value: **10000** for versions 25.9 and higher, **1000** for versions from 23.11 to 25.8, **100** for versions 23.10 and lower.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#replicated_deduplication_window). ||
|| replicatedDeduplicationWindowSeconds | **string** (int64)

The number of seconds after which the hash sums of the inserted blocks are removed from ClickHouse Keeper.

Default value: **3600** (1 hour) for versions 25.10 and higher, **604800** (7 days) for versions 25.9 and lower.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#replicated_deduplication_window_seconds). ||
|| replicatedDeduplicationWindowForAsyncInserts | **string** (int64)

The number of most recently async inserted blocks for which ClickHouse Keeper stores hash sums to check for duplicates.

Default value: **10000**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#replicated_deduplication_window_for_async_inserts). ||
|| replicatedDeduplicationWindowSecondsForAsyncInserts | **string** (int64)

The number of seconds after which the hash sums of the async inserts are removed from ClickHouse Keeper.

Default value: **604800** (7 days).

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#replicated_deduplication_window_seconds_for_async_inserts). ||
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

For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#attributes).

The number of elements must be greater than 0. ||
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

Attributes of a complex key.

The number of elements must be greater than 0. ||
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
- `IP_TRIE`: The specialized layout type for mapping network prefixes (IP addresses) to metadata such as ASN.
- `SSD_CACHE`: Similar to cache, but stores data on SSD and index in RAM.
Applicable only for dictionaries with numeric keys of the UInt64 type.
- `COMPLEX_KEY_SSD_CACHE`: Similar to complex_key_cache, but stores data on SSD and index in RAM.
Applicable for dictionaries with composite keys of arbitrary type. ||
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
|| blockSize | **string** (int64)

Elementary read block size in bytes. Recommended to match SSD page size.
Applicable only for **SSD_CACHE** and **COMPLEX_KEY_SSD_CACHE** layout types.

Default value: **4096**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/statements/create/dictionary/layouts/ssd-cache#ssd_cache). ||
|| fileSize | **string** (int64)

Maximum cache file size in bytes.
Applicable only for **SSD_CACHE** and **COMPLEX_KEY_SSD_CACHE** layout types.

Default value: **4294967296**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/statements/create/dictionary/layouts/ssd-cache#ssd_cache). ||
|| readBufferSize | **string** (int64)

RAM buffer size for reading from SSD in bytes.
Applicable only for **SSD_CACHE** and **COMPLEX_KEY_SSD_CACHE** layout types.

Default value: **65536**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/statements/create/dictionary/layouts/ssd-cache#ssd_cache). ||
|| writeBufferSize | **string** (int64)

RAM buffer size for writing to SSD in bytes.
Applicable only for **SSD_CACHE** and **COMPLEX_KEY_SSD_CACHE** layout types.

Default value: **4096**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/statements/create/dictionary/layouts/ssd-cache#ssd_cache). ||
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

Required field. MySQL host of the replica.

The maximum string length in characters is 253. ||
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

ClickHouse host.

The maximum string length in characters is 253. ||
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

Required field. MongoDB host.

The maximum string length in characters is 253. ||
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

Pattern to use for the rollup.

The number of elements must be greater than 0. ||
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

- `SECURITY_PROTOCOL_PLAINTEXT`: Unencrypted, unauthenticated connection.
- `SECURITY_PROTOCOL_SSL`: SSL/TLS encrypted connection.
- `SECURITY_PROTOCOL_SASL_PLAINTEXT`: SASL authenticated, unencrypted connection.
- `SECURITY_PROTOCOL_SASL_SSL`: SASL authenticated, SSL/TLS encrypted connection. ||
|| saslMechanism | **enum** (SaslMechanism)

SASL mechanism to use for authentication.

Default value: **SASL_MECHANISM_GSSAPI**.

- `SASL_MECHANISM_GSSAPI`: Kerberos-based authentication (GSSAPI).
- `SASL_MECHANISM_PLAIN`: Simple username/password authentication.
- `SASL_MECHANISM_SCRAM_SHA_256`: SCRAM authentication using SHA-256 hashing.
- `SASL_MECHANISM_SCRAM_SHA_512`: SCRAM authentication using SHA-512 hashing. ||
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

- `DEBUG_GENERIC`: Generic client debugging.
- `DEBUG_BROKER`: Broker connection debugging.
- `DEBUG_TOPIC`: Topic metadata debugging.
- `DEBUG_METADATA`: Metadata request and response debugging.
- `DEBUG_FEATURE`: Feature flag debugging.
- `DEBUG_QUEUE`: Message queue debugging.
- `DEBUG_MSG`: Message-level debugging.
- `DEBUG_PROTOCOL`: Protocol-level debugging.
- `DEBUG_CGRP`: Consumer group debugging.
- `DEBUG_SECURITY`: Security and authentication debugging.
- `DEBUG_FETCH`: Message fetch debugging.
- `DEBUG_INTERCEPTOR`: Interceptor plugin debugging.
- `DEBUG_PLUGIN`: Plugin debugging.
- `DEBUG_CONSUMER`: Consumer-level debugging.
- `DEBUG_ADMIN`: Admin API debugging.
- `DEBUG_EOS`: Exactly-once semantics (EOS) debugging.
- `DEBUG_MOCK`: Mock cluster debugging.
- `DEBUG_ASSIGNOR`: Partition assignor debugging.
- `DEBUG_CONF`: Configuration debugging.
- `DEBUG_TELEMETRY`: Telemetry debugging.
- `DEBUG_ALL`: Enable all debug contexts. ||
|| autoOffsetReset | **enum** (AutoOffsetReset)

Action to take when there is no initial offset in offset store or the desired offset is out of range.

Default value: **AUTO_OFFSET_RESET_LARGEST**.

- `AUTO_OFFSET_RESET_SMALLEST`: Reset offset to the earliest available message (alias for earliest).
- `AUTO_OFFSET_RESET_EARLIEST`: Reset offset to the earliest available message.
- `AUTO_OFFSET_RESET_BEGINNING`: Reset offset to the beginning of the partition (alias for earliest).
- `AUTO_OFFSET_RESET_LARGEST`: Reset offset to the latest available message (alias for latest).
- `AUTO_OFFSET_RESET_LATEST`: Reset offset to the latest available message.
- `AUTO_OFFSET_RESET_END`: Reset offset to the end of the partition (alias for latest).
- `AUTO_OFFSET_RESET_ERROR`: Trigger an error if no initial offset exists or the offset is out of range. ||
|| messageMaxBytes | **string** (int64)

Maximum Kafka protocol request message size.

Default value: **1000000**. ||
|| batchSize | **string** (int64)

Maximum size (in bytes) of all messages batched in one MessageSet, including protocol framing overhead.

Default value: **1000000**. ||
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

Host of jdbc bridge. ||
|| port | **string** (int64)

Port of jdbc bridge.

Default value: **9019**. ||
|#

## Macro {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Macro}

ClickHouse macro.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the macro.

The maximum string length in characters is 63. ||
|| value | **string**

Required field. Value of the macro.

The maximum string length in characters is 63. ||
|#

## Tls {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Tls}

TLS configuration for outgoing connections from ClickHouse (e.g. remote tables, dictionaries).

#|
||Field | Description ||
|| trustedCertificates[] | **string**

CA certificates in PEM format. Each element must contain a single self-signed CA certificate
or a certificate chain ordered as leaf -> intermediates -> self-signed root.

Change of the setting is applied with restart. ||
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

Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.

Acceptable values are 0 to 100, inclusive. ||
|| emergencyUsageThreshold | **string** (int64)

Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent.

Acceptable values are 0 to 100, inclusive. ||
|| diskSizeLimit | **string** (int64)

Limit on how large the storage for database instances can automatically grow, in bytes. ||
|#

## HostSpec {#yandex.cloud.mdb.clickhouse.v1.HostSpec}

#|
||Field | Description ||
|| zoneId | **string**

ID of the availability zone where the host resides.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/Zone/list#List) request.

The maximum string length in characters is 50. ||
|| type | **enum** (Type)

Required field. Type of the host to be deployed.

- `CLICKHOUSE`: ClickHouse host.
- `ZOOKEEPER`: ZooKeeper host.
- `KEEPER`: ClickHouse Keeper host. ||
|| subnetId | **string**

ID of the subnet that the host should belong to. This subnet should be a part
of the network that the cluster belongs to.
The ID of the network is set in the [Cluster.networkId](/docs/managed-clickhouse/api-ref/Cluster/get#yandex.cloud.mdb.clickhouse.v1.Cluster) field.

The maximum string length in characters is 50. ||
|| assignPublicIp | **boolean**

Whether the host should get a public IP address on creation.
After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign
a public IP to a host without one, recreate the host with `assignPublicIp` set as needed.
Possible values:
* false - don't assign a public IP to the host.
* true - the host should have a public IP address. ||
|| shardName | **string**

Name of the shard that the host is assigned to.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
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
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
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
|| metadata | **object**

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
|| response | **object**

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