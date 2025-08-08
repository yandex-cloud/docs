---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}/shards/{shardName}
    method: patch
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the ClickHouse cluster the shard belongs to.
            To get the cluster ID, use a [ClusterService.List](/docs/managed-clickhouse/api-ref/Cluster/list#List) request.
          type: string
        shardName:
          description: |-
            **string**
            Required field. Name of the shard to be updated.
            To get the name of a shard, use a [ClusterService.ListShards](/docs/managed-clickhouse/api-ref/Cluster/listShards#ListShards) request.
          pattern: '[a-zA-Z0-9_-]*'
          type: string
      required:
        - clusterId
        - shardName
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        updateMask:
          description: |-
            **string** (field-mask)
            A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
        configSpec:
          description: |-
            **[ShardConfigSpec](/docs/managed-clickhouse/api-ref/Cluster/create#yandex.cloud.mdb.clickhouse.v1.ShardConfigSpec)**
            New configuration for the specified shard.
          $ref: '#/definitions/ShardConfigSpec'
      additionalProperties: false
    definitions:
      AccessControlImprovements:
        type: object
        properties:
          selectFromSystemDbRequiresGrant:
            description: |-
              **boolean**
              Sets whether **SELECT * FROM system.<table>** requires any grants and can be executed by any user.
              If set to true then this query requires **GRANT SELECT ON system.<table>** just as for non-system tables.
              Default value: **false**.
            type: boolean
          selectFromInformationSchemaRequiresGrant:
            description: |-
              **boolean**
              Sets whether **SELECT * FROM information_schema.<table>** requires any grants and can be executed by any user.
              If set to true, then this query requires **GRANT SELECT ON information_schema.<table>**, just as for ordinary tables.
              Default value: **false**.
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
              Default value: **16**.
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
              - `DEDUPLICATE_MERGE_PROJECTION_MODE_UNSPECIFIED`
              - `DEDUPLICATE_MERGE_PROJECTION_MODE_IGNORE`
              - `DEDUPLICATE_MERGE_PROJECTION_MODE_THROW`
              - `DEDUPLICATE_MERGE_PROJECTION_MODE_DROP`
              - `DEDUPLICATE_MERGE_PROJECTION_MODE_REBUILD`
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
              - `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_UNSPECIFIED`
              - `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_THROW`
              - `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_DROP`
              - `LIGHTWEIGHT_MUTATION_PROJECTION_MODE_REBUILD`
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
              Default value: **1000** for versions 23.11 and higher, **100** for versions 23.10 and lower.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#replicated_deduplication_window).
            type: string
            format: int64
          replicatedDeduplicationWindowSeconds:
            description: |-
              **string** (int64)
              The number of seconds after which the hash sums of the inserted blocks are removed from ClickHouse Keeper.
              Default value: **604800** (7 days).
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/settings/merge-tree-settings#replicated_deduplication_window_seconds).
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
            deprecated: true
            type: boolean
      Compression:
        type: object
        properties:
          method:
            description: |-
              **enum** (Method)
              Required field. Compression method to use for the specified combination of **min_part_size** and **min_part_size_ratio**.
              - `METHOD_UNSPECIFIED`
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
              **`Header`**
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
              Required field. MySQL host of the replica.
            type: string
          priority:
            description: |-
              **string** (int64)
              The priority of the replica that ClickHouse takes into account when connecting.
              Replica with the highest priority should have this field set to the lowest number.
            type: string
            format: int64
          port:
            description: |-
              **string** (int64)
              Port to use when connecting to the replica.
              If a port is not specified for a replica, ClickHouse uses the port specified for the source.
            type: string
            format: int64
          user:
            description: |-
              **string**
              Name of the MySQL database user.
              If a user is not specified for a replica, ClickHouse uses the user specified for the source.
            type: string
          password:
            description: |-
              **string**
              Password of the MySQL database user.
              If a password is not specified for a replica, ClickHouse uses the password specified for the source.
            type: string
        required:
          - host
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
              **`Replica`**
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
              - `SSL_MODE_UNSPECIFIED`
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
              **`Retention`**
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
              **`Pattern`**
              Pattern to use for the rollup.
            type: array
            items:
              $ref: '#/definitions/Pattern'
          pathColumnName:
            description: |-
              **string**
              The name of the column storing the metric name (Graphite sensor).
              Default value: **Path**.
            type: string
          timeColumnName:
            description: |-
              **string**
              The name of the column storing the time of measuring the metric.
              Default value: **Time**.
            type: string
          valueColumnName:
            description: |-
              **string**
              The name of the column storing the value of the metric at the time set in **time_column_name**.
              Default value: **Value**.
            type: string
          versionColumnName:
            description: |-
              **string**
              The name of the column storing the version of the metric.
              Default value: **Timestamp**.
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
              - `SECURITY_PROTOCOL_UNSPECIFIED`
              - `SECURITY_PROTOCOL_PLAINTEXT`
              - `SECURITY_PROTOCOL_SSL`
              - `SECURITY_PROTOCOL_SASL_PLAINTEXT`
              - `SECURITY_PROTOCOL_SASL_SSL`
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
              - `SASL_MECHANISM_UNSPECIFIED`
              - `SASL_MECHANISM_GSSAPI`
              - `SASL_MECHANISM_PLAIN`
              - `SASL_MECHANISM_SCRAM_SHA_256`
              - `SASL_MECHANISM_SCRAM_SHA_512`
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
            type: boolean
          maxPollIntervalMs:
            description: |-
              **string** (int64)
              Maximum allowed time between calls to consume messages for high-level consumers.
              If this interval is exceeded the consumer is considered failed and the group will
              rebalance in order to reassign the partitions to another consumer group member.
              Default value: **300000** (5 minutes).
            type: string
            format: int64
          sessionTimeoutMs:
            description: |-
              **string** (int64)
              Client group session and failure detection timeout. The consumer sends periodic heartbeats (heartbeat.interval.ms)
              to indicate its liveness to the broker. If no hearts are received by the broker for a group member within
              the session timeout, the broker will remove the consumer from the group and trigger a rebalance.
              Default value: **45000** (45 seconds).
            type: string
            format: int64
          debug:
            description: |-
              **enum** (Debug)
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
              - `DEBUG_ALL`
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
              - `AUTO_OFFSET_RESET_UNSPECIFIED`
              - `AUTO_OFFSET_RESET_SMALLEST`
              - `AUTO_OFFSET_RESET_EARLIEST`
              - `AUTO_OFFSET_RESET_BEGINNING`
              - `AUTO_OFFSET_RESET_LARGEST`
              - `AUTO_OFFSET_RESET_LATEST`
              - `AUTO_OFFSET_RESET_END`
              - `AUTO_OFFSET_RESET_ERROR`
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
              **`Kafka`**
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
            type: string
            format: int64
          maxEntries:
            description: |-
              **string** (int64)
              The maximum number of **SELECT** query results stored in the cache.
              Default value: **1024**.
            type: string
            format: int64
          maxEntrySizeInBytes:
            description: |-
              **string** (int64)
              The maximum size in bytes **SELECT** query results may have to be saved in the cache.
              Default value: **1048576** (1 MiB).
            type: string
            format: int64
          maxEntrySizeInRows:
            description: |-
              **string** (int64)
              The maximum number of rows **SELECT** query results may have to be saved in the cache.
              Default value: **30000000**.
            type: string
            format: int64
      JdbcBridge:
        type: object
        properties:
          host:
            description: |-
              **string**
              Required field. Host of jdbc bridge.
            type: string
          port:
            description: |-
              **string** (int64)
              Port of jdbc bridge.
              Default value: **9019**.
            type: string
            format: int64
        required:
          - host
      Macro:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Name of the macro.
            pattern: '[a-zA-Z0-9_][a-zA-Z0-9_-]*'
            type: string
          value:
            description: |-
              **string**
              Required field. Value of the macro.
            pattern: '[a-zA-Z0-9_][a-zA-Z0-9_-]*'
            type: string
        required:
          - name
          - value
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
              - `LOG_LEVEL_UNSPECIFIED`
              - `TRACE`
              - `DEBUG`
              - `INFORMATION`
              - `WARNING`
              - `ERROR`
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
            type: string
            format: int64
          queryLogRetentionTime:
            description: |-
              **string** (int64)
              The maximum time that query_log records will be retained before removal. If set to **0**, automatic removal of query_log data based on time is disabled.
              Default value: **2592000000** (30 days).
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
            type: string
            format: int64
          queryThreadLogRetentionTime:
            description: |-
              **string** (int64)
              The maximum time that query_thread_log records will be retained before removal. If set to **0**,
              automatic removal of query_thread_log data based on time is disabled.
              Default value: **2592000000** (30 days).
            type: string
            format: int64
          partLogRetentionSize:
            description: |-
              **string** (int64)
              The maximum size that part_log can grow to before old data will be removed. If set to **0**,
              automatic removal of part_log data based on size is disabled.
              Default value: **536870912** (512 MiB).
            type: string
            format: int64
          partLogRetentionTime:
            description: |-
              **string** (int64)
              The maximum time that part_log records will be retained before removal. If set to **0**,
              automatic removal of part_log data based on time is disabled.
              Default value: **2592000000** (30 days).
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
            type: string
            format: int64
          metricLogRetentionTime:
            description: |-
              **string** (int64)
              The maximum time that metric_log records will be retained before removal. If set to **0**,
              automatic removal of metric_log data based on time is disabled.
              Default value: **2592000000** (30 days).
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
            type: string
            format: int64
          traceLogRetentionTime:
            description: |-
              **string** (int64)
              The maximum time that trace_log records will be retained before removal. If set to **0**,
              automatic removal of trace_log data based on time is disabled.
              Default value: **2592000000** (30 days).
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
            type: string
            format: int64
          textLogRetentionTime:
            description: |-
              **string** (int64)
              The maximum time that text_log records will be retained before removal. If set to **0**,
              automatic removal of text_log data based on time is disabled.
              Default value: **2592000000** (30 days).
            type: string
            format: int64
          textLogLevel:
            description: |-
              **enum** (LogLevel)
              Logging level for text_log system table.
              Default value: **TRACE**.
              Change of the setting is applied with restart.
              - `LOG_LEVEL_UNSPECIFIED`
              - `TRACE`
              - `DEBUG`
              - `INFORMATION`
              - `WARNING`
              - `ERROR`
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
            type: string
            format: int64
          opentelemetrySpanLogRetentionTime:
            description: |-
              **string** (int64)
              The maximum time that opentelemetry_span_log records will be retained before removal. If set to **0**,
              automatic removal of opentelemetry_span_log data based on time is disabled.
              Default value: **2592000000** (30 days).
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
            type: string
            format: int64
          queryViewsLogRetentionTime:
            description: |-
              **string** (int64)
              The maximum time that query_views_log records will be retained before removal. If set to **0**,
              automatic removal of query_views_log data based on time is disabled.
              Default value: **2592000000** (30 days).
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
            type: string
            format: int64
          asynchronousMetricLogRetentionTime:
            description: |-
              **string** (int64)
              The maximum time that asynchronous_metric_log records will be retained before removal. If set to **0**,
              automatic removal of asynchronous_metric_log data based on time is disabled.
              Default value: **2592000000** (30 days).
            type: string
            format: int64
          sessionLogEnabled:
            description: |-
              **boolean**
              Enables or disables session_log system table.
              Default value: **false**.
              Change of the setting is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/system-tables/session_log).
            type: boolean
          sessionLogRetentionSize:
            description: |-
              **string** (int64)
              The maximum size that session_log can grow to before old data will be removed. If set to **0**,
              automatic removal of session_log data based on size is disabled.
              Default value: **0**.
            type: string
            format: int64
          sessionLogRetentionTime:
            description: |-
              **string** (int64)
              The maximum time that session_log records will be retained before removal. If set to **0**,
              automatic removal of session_log data based on time is disabled.
              Default value: **2592000000** (30 days).
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
            type: string
            format: int64
          zookeeperLogRetentionTime:
            description: |-
              **string** (int64)
              The maximum time that zookeeper_log records will be retained before removal. If set to **0**,
              automatic removal of zookeeper_log data based on time is disabled.
              Default value: **2592000000** (30 days).
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
            type: string
            format: int64
          asynchronousInsertLogRetentionTime:
            description: |-
              **string** (int64)
              The maximum time that asynchronous_insert_log records will be retained before removal. If set to **0**,
              automatic removal of asynchronous_insert_log data based on time is disabled.
              Default value: **2592000000** (30 days).
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
            type: string
            format: int64
          processorsProfileLogRetentionTime:
            description: |-
              **string** (int64)
              The maximum time that processors_profile_log records will be retained before removal. If set to **0**,
              automatic removal of processors_profile_log data based on time is disabled.
              Default value: **2592000000** (30 days).
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
            type: string
            format: int64
          errorLogRetentionTime:
            description: |-
              **string** (int64)
              The maximum time that error_log records will be retained before removal. If set to **0**,
              automatic removal of error_log data based on time is disabled.
              Default value: **2592000000** (30 days).
            type: string
            format: int64
          accessControlImprovements:
            description: |-
              **`AccessControlImprovements`**
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
              Default value: **30**.
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
          mergeTree:
            description: |-
              **`MergeTree`**
              Settings for the MergeTree table engine family.
              Change of the settings of **merge_tree** is applied with restart.
            $ref: '#/definitions/MergeTree'
          compression:
            description: |-
              **`Compression`**
              Data compression settings for MergeTree engine tables.
              Change of the settings of **compression** is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#compression).
            type: array
            items:
              $ref: '#/definitions/Compression'
          dictionaries:
            description: |-
              **`ExternalDictionary`**
              Configuration of external dictionaries.
              Change of the settings of **dictionaries** is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries).
            type: array
            items:
              oneOf:
                - type: object
                  properties:
                    fixedLifetime:
                      description: |-
                        **string** (int64)
                        Fixed interval between dictionary updates.
                        Includes only one of the fields `fixedLifetime`, `lifetimeRange`.
                      type: string
                      format: int64
                    lifetimeRange:
                      description: |-
                        **`Range`**
                        Range of intervals between dictionary updates for ClickHouse to choose from.
                        Includes only one of the fields `fixedLifetime`, `lifetimeRange`.
                      $ref: '#/definitions/Range'
                - type: object
                  properties:
                    httpSource:
                      description: |-
                        **`HttpSource`**
                        HTTP source for the dictionary.
                        Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`.
                      $ref: '#/definitions/HttpSource'
                    mysqlSource:
                      description: |-
                        **`MysqlSource`**
                        MySQL source for the dictionary.
                        Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`.
                      $ref: '#/definitions/MysqlSource'
                    clickhouseSource:
                      description: |-
                        **`ClickhouseSource`**
                        ClickHouse source for the dictionary.
                        Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`.
                      $ref: '#/definitions/ClickhouseSource'
                    mongodbSource:
                      description: |-
                        **`MongodbSource`**
                        MongoDB source for the dictionary.
                        Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`.
                      $ref: '#/definitions/MongodbSource'
                    postgresqlSource:
                      description: |-
                        **`PostgresqlSource`**
                        PostgreSQL source for the dictionary.
                        Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`.
                      $ref: '#/definitions/PostgresqlSource'
          graphiteRollup:
            description: |-
              **`GraphiteRollup`**
              Rollup settings for the GraphiteMergeTree engine tables.
              Change of the settings of **graphite_rollup** is applied with restart.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#graphite_rollup).
            type: array
            items:
              $ref: '#/definitions/GraphiteRollup'
          kafka:
            description: |-
              **`Kafka`**
              Kafka integration settings.
              Change of the settings of **kafka** is applied with restart.
            $ref: '#/definitions/Kafka'
          kafkaTopics:
            description: |-
              **`KafkaTopic`**
              Per-topic Kafka integration settings.
              Change of the settings of **kafka_topics** is applied with restart.
            type: array
            items:
              $ref: '#/definitions/KafkaTopic'
          rabbitmq:
            description: |-
              **`Rabbitmq`**
              RabbitMQ integration settings.
              Change of the settings of **rabbitmq** is applied with restart.
            $ref: '#/definitions/Rabbitmq'
          queryMaskingRules:
            description: |-
              **`QueryMaskingRule`**
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
              **`QueryCache`**
              [Query cache](https://clickhouse.com/docs/operations/query-cache) configuration.
              Change of the settings of **query_cache** is applied with restart.
            $ref: '#/definitions/QueryCache'
          jdbcBridge:
            description: |-
              **`JdbcBridge`**
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
              **`Macro`**
              Custom ClickHouse macros.
            type: array
            items:
              $ref: '#/definitions/Macro'
          builtinDictionariesReloadInterval:
            description: |-
              **string** (int64)
              The interval in seconds before reloading built-in dictionaries.
              Default value: **3600**.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#builtin_dictionaries_reload_interval).
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
            type: string
            format: int64
          emergencyUsageThreshold:
            description: |-
              **string** (int64)
              Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent.
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
              **`ClickhouseConfig`**
              Configuration for a ClickHouse server.
            $ref: '#/definitions/ClickhouseConfig'
          resources:
            description: |-
              **[Resources](/docs/managed-clickhouse/api-ref/Cluster/get#yandex.cloud.mdb.clickhouse.v1.Resources)**
              Resources allocated to ClickHouse hosts.
            $ref: '#/definitions/Resources'
          diskSizeAutoscaling:
            description: |-
              **[DiskSizeAutoscaling](/docs/managed-clickhouse/api-ref/Cluster/get#yandex.cloud.mdb.clickhouse.v1.DiskSizeAutoscaling)**
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
sourcePath: en/_api-ref/mdb/clickhouse/v1/api-ref/Cluster/updateShard.md
---

# Managed Service for ClickHouse API, REST: Cluster.UpdateShard

Modifies the specified shard.

## HTTP request

```
PATCH https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}/shards/{shardName}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the ClickHouse cluster the shard belongs to.
To get the cluster ID, use a [ClusterService.List](/docs/managed-clickhouse/api-ref/Cluster/list#List) request. ||
|| shardName | **string**

Required field. Name of the shard to be updated.
To get the name of a shard, use a [ClusterService.ListShards](/docs/managed-clickhouse/api-ref/Cluster/listShards#ListShards) request. ||
|#

## Body parameters {#yandex.cloud.mdb.clickhouse.v1.UpdateClusterShardRequest}

```json
{
  "updateMask": "string",
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
}
```

#|
||Field | Description ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| configSpec | **[ShardConfigSpec](#yandex.cloud.mdb.clickhouse.v1.ShardConfigSpec)**

New configuration for the specified shard. ||
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
    "shardName": "string"
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
        "weight": "string",
        "diskSizeAutoscaling": {
          "plannedUsageThreshold": "string",
          "emergencyUsageThreshold": "string",
          "diskSizeLimit": "string"
        }
      }
    }
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
|| metadata | **[UpdateClusterShardMetadata](#yandex.cloud.mdb.clickhouse.v1.UpdateClusterShardMetadata)**

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
|| response | **[Shard](#yandex.cloud.mdb.clickhouse.v1.Shard)**

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

## UpdateClusterShardMetadata {#yandex.cloud.mdb.clickhouse.v1.UpdateClusterShardMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the cluster that contains the shard being updated. ||
|| shardName | **string**

Name of the shard being updated. ||
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

## Shard {#yandex.cloud.mdb.clickhouse.v1.Shard}

#|
||Field | Description ||
|| name | **string**

Name of the shard. ||
|| clusterId | **string**

ID of the cluster that the shard belongs to. ||
|| config | **[ShardConfig](#yandex.cloud.mdb.clickhouse.v1.ShardConfig)**

Configuration of the shard. ||
|#

## ShardConfig {#yandex.cloud.mdb.clickhouse.v1.ShardConfig}

#|
||Field | Description ||
|| clickhouse | **[Clickhouse](#yandex.cloud.mdb.clickhouse.v1.ShardConfig.Clickhouse)**

ClickHouse configuration for a shard. ||
|#

## Clickhouse {#yandex.cloud.mdb.clickhouse.v1.ShardConfig.Clickhouse}

#|
||Field | Description ||
|| config | **[ClickhouseConfigSet](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfigSet)**

ClickHouse settings for a shard. ||
|| resources | **[Resources](#yandex.cloud.mdb.clickhouse.v1.Resources2)**

Computational resources for a shard. ||
|| weight | **string** (int64)

Relative weight of a shard considered when writing data to the cluster.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/operations/table_engines/distributed/). ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.clickhouse.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings. ||
|#

## ClickhouseConfigSet {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfigSet}

#|
||Field | Description ||
|| effectiveConfig | **[ClickhouseConfig](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig2)**

Required field. Effective configuration (a combination of user-defined configuration and default configuration). ||
|| userConfig | **[ClickhouseConfig](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig2)**

Required field. User-defined configuration. ||
|| defaultConfig | **[ClickhouseConfig](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig2)**

Required field. Default configuration. ||
|#

## ClickhouseConfig {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig2}

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
|| accessControlImprovements | **[AccessControlImprovements](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.AccessControlImprovements2)**

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
|| mergeTree | **[MergeTree](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.MergeTree2)**

Settings for the MergeTree table engine family.

Change of the settings of **merge_tree** is applied with restart. ||
|| compression[] | **[Compression](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Compression2)**

Data compression settings for MergeTree engine tables.

Change of the settings of **compression** is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#compression). ||
|| dictionaries[] | **[ExternalDictionary](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary2)**

Configuration of external dictionaries.

Change of the settings of **dictionaries** is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/sql-reference/dictionaries). ||
|| graphiteRollup[] | **[GraphiteRollup](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup2)**

Rollup settings for the GraphiteMergeTree engine tables.

Change of the settings of **graphite_rollup** is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#graphite_rollup). ||
|| kafka | **[Kafka](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Kafka2)**

Kafka integration settings.

Change of the settings of **kafka** is applied with restart. ||
|| kafkaTopics[] | **[KafkaTopic](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.KafkaTopic2)**

Per-topic Kafka integration settings.

Change of the settings of **kafka_topics** is applied with restart. ||
|| rabbitmq | **[Rabbitmq](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Rabbitmq2)**

RabbitMQ integration settings.

Change of the settings of **rabbitmq** is applied with restart. ||
|| queryMaskingRules[] | **[QueryMaskingRule](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryMaskingRule2)**

Regexp-based rules, which will be applied to queries as well as all log messages before storing them in server logs,
system.query_log, system.text_log, system.processes tables, and in logs sent to the client. That allows preventing
sensitive data leakage from SQL queries (like names, emails, personal identifiers or credit card numbers) to logs.

Change of the settings of **query_masking_rules** is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#query_masking_rules). ||
|| queryCache | **[QueryCache](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryCache2)**

[Query cache](https://clickhouse.com/docs/operations/query-cache) configuration.

Change of the settings of **query_cache** is applied with restart. ||
|| jdbcBridge | **[JdbcBridge](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.JdbcBridge2)**

JDBC bridge configuration for queries to external databases.

Change of the settings of **jdbc_bridge** is applied with restart.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/integrations/jdbc/jdbc-with-clickhouse). ||
|| mysqlProtocol | **boolean**

Enables or disables MySQL interface on ClickHouse server

Default value: **false**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/interfaces/mysql). ||
|| customMacros[] | **[Macro](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Macro2)**

Custom ClickHouse macros. ||
|| builtinDictionariesReloadInterval | **string** (int64)

The interval in seconds before reloading built-in dictionaries.

Default value: **3600**.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#builtin_dictionaries_reload_interval). ||
|#

## AccessControlImprovements {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.AccessControlImprovements2}

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

## MergeTree {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.MergeTree2}

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

## Compression {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Compression2}

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

## ExternalDictionary {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary2}

External dictionary configuration.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the external dictionary. ||
|| structure | **[Structure](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure2)**

Required field. Structure of the external dictionary. ||
|| layout | **[Layout](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Layout2)**

Required field. Layout determining how to store the dictionary in memory.

For details, see https://clickhouse.com/docs/sql-reference/dictionaries#ways-to-store-dictionaries-in-memory. ||
|| fixedLifetime | **string** (int64)

Fixed interval between dictionary updates.

Includes only one of the fields `fixedLifetime`, `lifetimeRange`. ||
|| lifetimeRange | **[Range](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Range2)**

Range of intervals between dictionary updates for ClickHouse to choose from.

Includes only one of the fields `fixedLifetime`, `lifetimeRange`. ||
|| httpSource | **[HttpSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource2)**

HTTP source for the dictionary.

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`. ||
|| mysqlSource | **[MysqlSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource2)**

MySQL source for the dictionary.

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`. ||
|| clickhouseSource | **[ClickhouseSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.ClickhouseSource2)**

ClickHouse source for the dictionary.

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`. ||
|| mongodbSource | **[MongodbSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MongodbSource2)**

MongoDB source for the dictionary.

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`. ||
|| postgresqlSource | **[PostgresqlSource](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.PostgresqlSource2)**

PostgreSQL source for the dictionary.

Includes only one of the fields `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`. ||
|#

## Structure {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure2}

Configuration of external dictionary structure.

#|
||Field | Description ||
|| id | **[Id](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Id2)**

Single numeric key column for the dictionary. ||
|| key | **[Key](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Key2)**

Composite key for the dictionary, containing of one or more key columns.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_structure/#composite-key). ||
|| rangeMin | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute2)**

Field holding the beginning of the range for dictionaries with **RANGE_HASHED** layout.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/query_language/dicts/external_dicts_dict_layout/#range-hashed). ||
|| rangeMax | **[Attribute](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Structure.Attribute2)**

Field holding the end of the range for dictionaries with **RANGE_HASHED** layout.

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

Default value: **false**. ||
|| injective | **boolean**

Indication of injective mapping "id -> attribute".

Default value: **false**. ||
|#

## Layout {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.Layout2}

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

Required field. The data format. Valid values are all formats [supported by ClickHouse SQL dialect](https://clickhouse.com/docs/en/interfaces/formats/). ||
|| headers[] | **[Header](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource.Header2)**

HTTP headers. ||
|#

## Header {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.HttpSource.Header2}

#|
||Field | Description ||
|| name | **string**

Required field. Header name. ||
|| value | **string**

Required field. Header value. ||
|#

## MysqlSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource2}

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
|| replicas[] | **[Replica](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource.Replica2)**

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

## Replica {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MysqlSource.Replica2}

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

## ClickhouseSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.ClickhouseSource2}

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

## MongodbSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.MongodbSource2}

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

## PostgresqlSource {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.ExternalDictionary.PostgresqlSource2}

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

## GraphiteRollup {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup2}

Rollup settings for the GraphiteMergeTree table engine.
For details, see [ClickHouse documentation](https://clickhouse.com/docs/operations/server-configuration-parameters/settings#graphite-rollup).

#|
||Field | Description ||
|| name | **string**

Required field. Name for the specified combination of settings for Graphite rollup. ||
|| patterns[] | **[Pattern](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern2)**

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

## Pattern {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern2}

#|
||Field | Description ||
|| regexp | **string**

A pattern for the metric name (a regular or DSL). ||
|| function | **string**

The name of the aggregating function to apply to data whose age falls within the range [age, age + precision].
Accepted functions: **min**, **max**, **any**, **avg**. The average is calculated imprecisely, like the average of the averages. ||
|| retention[] | **[Retention](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern.Retention2)**

Retention rules. ||
|#

## Retention {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.GraphiteRollup.Pattern.Retention2}

#|
||Field | Description ||
|| age | **string** (int64)

The minimum age of the data in seconds. ||
|| precision | **string** (int64)

Precision of determining the age of the data, in seconds. Should be a divisor for 86400 (seconds in a day). ||
|#

## Kafka {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Kafka2}

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

## KafkaTopic {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.KafkaTopic2}

#|
||Field | Description ||
|| name | **string**

Required field. Kafka topic name. ||
|| settings | **[Kafka](#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Kafka2)**

Required field. Kafka topic settings. ||
|#

## Rabbitmq {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Rabbitmq2}

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

## QueryMaskingRule {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryMaskingRule2}

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

## QueryCache {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.QueryCache2}

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

## JdbcBridge {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.JdbcBridge2}

JDBC bridge configuration for queries to external databases.

#|
||Field | Description ||
|| host | **string**

Required field. Host of jdbc bridge. ||
|| port | **string** (int64)

Port of jdbc bridge.

Default value: **9019**. ||
|#

## Macro {#yandex.cloud.mdb.clickhouse.v1.config.ClickhouseConfig.Macro2}

ClickHouse macro.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the macro. ||
|| value | **string**

Required field. Value of the macro. ||
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

## DiskSizeAutoscaling {#yandex.cloud.mdb.clickhouse.v1.DiskSizeAutoscaling2}

#|
||Field | Description ||
|| plannedUsageThreshold | **string** (int64)

Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent. ||
|| emergencyUsageThreshold | **string** (int64)

Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent. ||
|| diskSizeLimit | **string** (int64)

Limit on how large the storage for database instances can automatically grow, in bytes. ||
|#