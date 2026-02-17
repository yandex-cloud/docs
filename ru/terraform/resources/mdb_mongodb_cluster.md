---
subcategory: Managed Service for MongoDB
---

# yandex_mdb_mongodb_cluster (Resource)

Manages a MongoDB cluster within the Yandex Cloud. For more information, see [the official documentation](https://yandex.cloud/docs/managed-mongodb/concepts).

## Example usage

```terraform
//
// Create a new MDB MongoDB Cluster.
//
resource "yandex_mdb_mongodb_cluster" "my_cluster" {
  name        = "test"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.foo.id

  cluster_config {
    version = "4.2"
  }

  labels = {
    test_key = "test_value"
  }

  database {
    name = "testdb"
  }

  user {
    name     = "john"
    password = "password"
    permission {
      database_name = "testdb"
    }
  }

  resources_mongod {
    resource_preset_id = "s2.small"
    disk_size          = 16
    disk_type_id       = "network-hdd"
  }

  resources_mongos {
    resource_preset_id = "s2.small"
    disk_size          = 14
    disk_type_id       = "network-hdd"
  }

  resources_mongocfg {
    resource_preset_id = "s2.small"
    disk_size          = 14
    disk_type_id       = "network-hdd"
  }

  host {
    zone_id   = "ru-central1-d"
    subnet_id = yandex_vpc_subnet.foo.id
  }

  maintenance_window {
    type = "ANYTIME"
  }
}

// Auxiliary resources
resource "yandex_vpc_network" "foo" {}

resource "yandex_vpc_subnet" "foo" {
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.1.0.0/24"]
}
```

## Arguments & Attributes Reference

- `cluster_id` (String). The ID of the cluster.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (String). The resource description.
- `disk_encryption_key_id` (String). ID of the KMS key for cluster disk encryption.
- `environment` (**Required**)(String). Deployment environment of the MongoDB cluster. Can be either `PRESTABLE` or `PRODUCTION`.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `health` (*Read-Only*) (String). Aggregated health of the cluster. Can be either `ALIVE`, `DEGRADED`, `DEAD` or `HEALTH_UNKNOWN`. For more information see `health` field of JSON representation in [the official documentation](https://yandex.cloud/docs/managed-mongodb/api-ref/Cluster/).
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (**Required**)(String). The resource name.
- `network_id` (**Required**)(String). The `VPC Network ID` of subnets which resource attached to.
- `security_group_ids` (Set Of String). The list of security groups applied to resource or their components.
- `sharded` (*Read-Only*) (Bool). MongoDB Cluster mode enabled/disabled.
- `status` (*Read-Only*) (String). Status of the cluster. Can be either `CREATING`, `STARTING`, `RUNNING`, `UPDATING`, `STOPPING`, `STOPPED`, `ERROR` or `STATUS_UNKNOWN`. For more information see `status` field of JSON representation in [the official documentation](https://yandex.cloud/docs/managed-mongodb/api-ref/Cluster/).
- `cluster_config` [Block]. Configuration of the MongoDB subcluster.
  - `backup_retain_period_days` (Number). Retain period of automatically created backup in days.
  - `feature_compatibility_version` (String). Feature compatibility version of MongoDB. If not provided version is taken. Can be either `6.0`, `5.0`, `4.4` and `4.2`.
  - `version` (**Required**)(String). Version of the MongoDB server software. Can be either `4.2`, `4.4`, `4.4-enterprise`, `5.0`, `5.0-enterprise`, `6.0` and `6.0-enterprise`.
  - `access` [Block]. Access policy to the MongoDB cluster.
    - `data_lens` (Bool). Allow access for [Yandex DataLens](https://yandex.cloud/services/datalens).
    - `data_transfer` (Bool). Allow access for [DataTransfer](https://yandex.cloud/services/data-transfer).
    - `web_sql` (Bool). Allow access for [WebSQL](https://yandex.cloud/ru/docs/websql/).
  - `backup_window_start` [Block]. Time to start the daily backup, in the UTC timezone.
    - `hours` (Number). The hour at which backup will be started.
    - `minutes` (Number). The minute at which backup will be started.
  - `mongocfg` [Block]. Configuration of the mongocfg service.
    - `chaining_allowed` (Bool). Chained replication setting. For more information, see the [chainingAllowed](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-chainingAllowed) description in the official documentation.
    - `audit_log` [Block]. A set of audit log settings (see the [auditLog](https://www.mongodb.com/docs/manual/reference/configuration-options/#auditlog-options) option). Available only in enterprise edition.
      - `filter` (String). Configuration of the audit log filter in JSON format. For more information see [auditLog.filter](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-auditLog.filter) description in the official documentation. Available only in enterprise edition.
    - `net` [Block].  A set of network settings (see the [net](https://www.mongodb.com/docs/manual/reference/configuration-options/#net-options) option).
      - `max_incoming_connections` (Number). The maximum number of simultaneous connections that host will accept. For more information, see the [net.maxIncomingConnections](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-net.maxIncomingConnections) description in the official documentation.
    - `operation_profiling` [Block]. A set of profiling settings (see the [operationProfiling](https://www.mongodb.com/docs/manual/reference/configuration-options/#operationprofiling-options) option).
      - `mode` (String). Specifies which operations should be profiled. The following profiler levels are available: off, slow_op, all. For more information, see the [operationProfiling.mode](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-operationProfiling.mode) description in the official documentation.
      - `slow_op_threshold` (Number). The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow. For more information, see the [operationProfiling.slowOpThresholdMs](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-operationProfiling.slowOpThresholdMs) description in the official documentation.
    - `oplog` [Block]. A set of oplog settings (see the [oplog](https://www.mongodb.com/docs/manual/core/replica-set-oplog) option).
      - `max_size_percent` (Number). The maximum size of the oplog, as a percentage of the total storage size. For more information, see the [oplog.oplogSizeMB](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-replication.oplogSizeMB) description in the official documentation.
      - `min_retention_hours` (Number). The minimum number of hours to preserve an oplog entry, where decimal values represent the fractions of an hour. For more information, see the [oplog.minRetentionHours](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-replication.oplogSizeMB) description in the official documentation.
    - `set_parameter` [Block]. A set of MongoDB Server Parameters (see the [setParameter](https://www.mongodb.com/docs/manual/reference/configuration-options/#setparameter-option) option).
      - `audit_authorization_success` (Bool). Enables the auditing of authorization successes. Can be either true or false. For more information, see the [auditAuthorizationSuccess](https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.auditAuthorizationSuccess) description in the official documentation. Available only in enterprise edition.
      - `enable_flow_control` (Bool). Enables the flow control. Can be either true or false. For more information, see the [enableFlowControl](https://www.mongodb.com/docs/rapid/reference/parameters/#mongodb-parameter-param.enableFlowControl) description in the official documentation.
    - `storage` [Block]. A set of storage settings (see the [storage](https://www.mongodb.com/docs/manual/reference/configuration-options/#storage-options) option).
      - `wired_tiger` [Block]. The WiredTiger engine settings. (see the [storage.wiredTiger](https://www.mongodb.com/docs/manual/reference/configuration-options/#storage.wiredtiger-options) option).
        - `cache_size` (Number). Defines the maximum size of the internal cache that WiredTiger will use for all data in percents. For more information, see the [storage.wiredTiger.engineConfig.cacheSize](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-storage.wiredTiger.engineConfig.cacheSizePct) description in the official documentation.
        - `cache_size_gb` (Number). Defines the maximum size of the internal cache that WiredTiger will use for all data. For more information, see the [storage.wiredTiger.engineConfig.cacheSizeGB](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-storage.wiredTiger.engineConfig.cacheSizeGB) description in the official documentation.
  - `mongod` [Block]. Configuration of the mongod service.
    - `chaining_allowed` (Bool). Chained replication setting. For more information, see the [chainingAllowed](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-chainingAllowed) description in the official documentation.
    - `audit_log` [Block]. A set of audit log settings (see the [auditLog](https://www.mongodb.com/docs/manual/reference/configuration-options/#auditlog-options) option). Available only in enterprise edition.
      - `filter` (String). Configuration of the audit log filter in JSON format. For more information see [auditLog.filter](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-auditLog.filter) description in the official documentation. Available only in enterprise edition.
      - `runtime_configuration` (Bool). Specifies if a node allows runtime configuration of audit filters and the auditAuthorizationSuccess variable. For more information see [auditLog.runtimeConfiguration](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-auditLog.runtimeConfiguration) description in the official documentation. Available only in enterprise edition.
    - `net` [Block]. A set of network settings (see the [net](https://www.mongodb.com/docs/manual/reference/configuration-options/#net-options) option).
      - `compressors` (List Of String). Specifies the default compressor(s) to use for communication between this mongod or mongos. Accepts array of compressors. Order matters. Available compressors: snappy, zlib, zstd, disabled. To disable network compression, make `disabled` the only value. For more information, see the [net.Compression.Compressors](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-net.compression.compressors) description in the official documentation.
      - `max_incoming_connections` (Number). The maximum number of simultaneous connections that host will accept. For more information, see the [net.maxIncomingConnections](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-net.maxIncomingConnections) description in the official documentation.
    - `operation_profiling` [Block]. A set of profiling settings (see the [operationProfiling](https://www.mongodb.com/docs/manual/reference/configuration-options/#operationprofiling-options) option).
      - `mode` (String). Specifies which operations should be profiled. The following profiler levels are available: off, slow_op, all. For more information, see the [operationProfiling.mode](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-operationProfiling.mode) description in the official documentation.
      - `slow_op_sample_rate` (Number). The fraction of slow operations that should be profiled or logged. Accepts values between 0 and 1, inclusive. For more information, see the [operationProfiling.slowOpSampleRate](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-operationProfiling.slowOpSampleRate) description in the official documentation.
      - `slow_op_threshold` (Number). The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow. For more information, see the [operationProfiling.slowOpThresholdMs](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-operationProfiling.slowOpThresholdMs) description in the official documentation.
    - `oplog` [Block]. A set of oplog settings (see the [oplog](https://www.mongodb.com/docs/manual/core/replica-set-oplog) option).
      - `max_size_percent` (Number). The maximum size of the oplog, as a percentage of the total storage size. For more information, see the [oplog.oplogSizeMB](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-replication.oplogSizeMB) description in the official documentation.
      - `min_retention_hours` (Number). The minimum number of hours to preserve an oplog entry, where decimal values represent the fractions of an hour. For more information, see the [oplog.minRetentionHours](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-replication.oplogSizeMB) description in the official documentation.
    - `security` [Block]. A set of MongoDB Security settings (see the [security](https://www.mongodb.com/docs/manual/reference/configuration-options/#security-options) option). Available only in enterprise edition.
      - `enable_encryption` (Bool). Enables the encryption for the WiredTiger storage engine. Can be either true or false. For more information see [security.enableEncryption](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-security.enableEncryption) description in the official documentation. Available only in enterprise edition.
      - `kmip` [Block]. Configuration of the third party key management appliance via the Key Management Interoperability Protocol (KMIP) (see [Encryption tutorial](https://www.mongodb.com/docs/rapid/tutorial/configure-encryption) ). Requires `enable_encryption` to be true. The structure is documented below. Available only in enterprise edition.
        - `client_certificate` (String). String containing the client certificate used for authenticating MongoDB to the KMIP server. For more information see [security.kmip.clientCertificateFile](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-security.kmip.clientCertificateFile) description in the official documentation.
        - `key_identifier` (String). Unique KMIP identifier for an existing key within the KMIP server. For more information see [security.kmip.keyIdentifier](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-security.kmip.keyIdentifier) description in the official documentation.
        - `port` (Number). Port number to use to communicate with the KMIP server. Default: 5696 For more information see [security.kmip.port](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-security.kmip.port) description in the official documentation.
        - `server_ca` (String). Path to CA File. Used for validating secure client connection to KMIP server. For more information see [security.kmip.serverCAFile](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-security.kmip.serverCAFile) description in the official documentation.
        - `server_name` (String). Hostname or IP address of the KMIP server to connect to. For more information see [security.kmip.serverName](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-security.kmip.serverName) description in the official documentation.
    - `set_parameter` [Block]. A set of MongoDB Server Parameters (see the [setParameter](https://www.mongodb.com/docs/manual/reference/configuration-options/#setparameter-option) option).
      - `audit_authorization_success` (Bool). Enables the auditing of authorization successes. Can be either true or false. For more information, see the [auditAuthorizationSuccess](https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.auditAuthorizationSuccess) description in the official documentation. Available only in enterprise edition.
      - `enable_flow_control` (Bool). Enables the flow control. Can be either true or false. For more information, see the [enableFlowControl](https://www.mongodb.com/docs/rapid/reference/parameters/#mongodb-parameter-param.enableFlowControl) description in the official documentation.
      - `flow_control_target_lag_seconds` (Number). The target maximum majority committed lag when running with flow control. For more information, see the [flowControlTargetLagSeconds](https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.flowControlTargetLagSeconds) description in the official documentation.
      - `flow_control_warn_threshold_seconds` (Number). The amount of time to wait to log a warning once the flow control mechanism detects the majority commit point has not moved. For more information, see the [flowControlWarnThresholdSeconds](https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.flowControlWarnThresholdSeconds) description in the official documentation.
      - `migrate_clone_insertion_batch_delay_ms` (Number). Time in milliseconds to wait between batches of insertions during cloning step of the migration process. For more information, see the [migrateCloneInsertionBatchDelayMs](https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.migrateCloneInsertionBatchDelayMS) description in the official documentation.
      - `migrate_clone_insertion_batch_size` (Number). The maximum number of documents to insert in a single batch during the cloning step of the migration process. For more information, see the [migrateCloneInsertionBatchSize](https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.migrateCloneInsertionBatchSize) description in the official documentation.
      - `min_snapshot_history_window_in_seconds` (Number). The minimum time window in seconds for which the storage engine keeps the snapshot history. For more information, see the [minSnapshotHistoryWindowInSeconds](https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.minSnapshotHistoryWindowInSeconds) description in the official documentation.
      - `orphan_cleanup_delay_secs` (Number). Minimum delay before a migrated chunk is deleted from the source shard. For more information, see the [orphanCleanupDelaySecs](https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.orphanCleanupDelaySecs) description in the official documentation.
      - `persisted_chunk_cache_update_max_batch_size` (Number). Specifies the maximum batch size used for updating the persisted chunk cache. For more information, see the [persistedChunkCacheUpdateMaxBatchSize](https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.persistedChunkCacheUpdateMaxBatchSize) description in the official documentation.
      - `range_deleter_batch_delay_ms` (Number). The amount of time in milliseconds to wait before the next batch of deletion during the cleanup stage of chunk migration (or the cleanupOrphaned command). For more information, see the [rangeDeleterBatchDelayMS](https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.rangeDeleterBatchDelayMS) description in the official documentation.
      - `range_deleter_batch_size` (Number). The maximum number of documents in each batch to delete during the cleanup stage of chunk migration (or the cleanupOrphaned command). For more information, see the [rangeDeleterBatchSize](https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.rangeDeleterBatchSize) description in the official documentation.
      - `mirror_reads` [Block]. A set of MongoDB Mirror Reads settings (see the [mirrorReads](https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.mirrorReads) option).
        - `max_time_ms` (Number). The maximum time in milliseconds for the mirrored reads. For more information see [mirrorReads.maxTimeMS](https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.mirrorReads) description in the official documentation
        - `sampling_rate` (Number). The sampling rate used to mirror a subset of operations that support mirroring. For more information see [mirrorReads.samplingRate](https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.mirrorReads) description in the official documentation
    - `storage` [Block]. A set of storage settings (see the [storage](https://www.mongodb.com/docs/manual/reference/configuration-options/#storage-options) option).
      - `journal` [Block]. The durability journal to ensure data files remain valid and recoverable.
        - `commit_interval` (Number). The maximum amount of time in milliseconds that the mongod process allows between journal operations. For more information, see the [storage.journal.commitIntervalMs](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-storage.journal.commitIntervalMs) description in the official documentation.
      - `wired_tiger` [Block]. The WiredTiger engine settings. (see the [storage.wiredTiger](https://www.mongodb.com/docs/manual/reference/configuration-options/#storage.wiredtiger-options) option). These settings available only on `mongod` hosts.
        - `block_compressor` (String). Specifies the default compression for collection data. You can override this on a per-collection basis when creating collections. Available compressors are: none, snappy, zlib, zstd. This setting available only on `mongod` hosts. For more information, see the [storage.wiredTiger.collectionConfig.blockCompressor](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-storage.wiredTiger.collectionConfig.blockCompressor) description in the official documentation.
        - `cache_size` (Number). Defines the maximum size of the internal cache that WiredTiger will use for all data in percents. For more information, see the [storage.wiredTiger.engineConfig.cacheSize](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-storage.wiredTiger.engineConfig.cacheSizePct) description in the official documentation.
        - `cache_size_gb` (Number). Defines the maximum size of the internal cache that WiredTiger will use for all data. For more information, see the [storage.wiredTiger.engineConfig.cacheSizeGB](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-storage.wiredTiger.engineConfig.cacheSizeGB) description in the official documentation.
        - `prefix_compression` (Bool). Enables or disables prefix compression for index data. Сan be either true or false. For more information, see the [storage.wiredTiger.indexConfig.prefixCompression](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-storage.wiredTiger.indexConfig.prefixCompression) description in the official documentation.
  - `mongos` [Block]. Configuration of the mongos service.
    - `chunk_size` (Number). The size of the chunk, in bytes. For more information, see the [chunkSize](https://www.mongodb.com/docs/manual/tutorial/modify-chunk-size-in-sharded-cluster) description in the official documentation.
    - `audit_log` [Block]. A set of audit log settings (see the [auditLog](https://www.mongodb.com/docs/manual/reference/configuration-options/#auditlog-options) option). Available only in enterprise edition.
      - `filter` (String). Configuration of the audit log filter in JSON format. For more information see [auditLog.filter](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-auditLog.filter) description in the official documentation. Available only in enterprise edition.
    - `net` [Block]. A set of network settings (see the [net](https://www.mongodb.com/docs/manual/reference/configuration-options/#net-options) option).
      - `compressors` (List Of String). Specifies the default compressor(s) to use for communication between this mongod or mongos. Accepts array of compressors. Order matters. Available compressors: snappy, zlib, zstd, disabled. To disable network compression, make `disabled` the only value. For more information, see the [net.Compression.Compressors](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-net.compression.compressors) description in the official documentation.
      - `max_incoming_connections` (Number). The maximum number of simultaneous connections that host will accept. For more information, see the [net.maxIncomingConnections](https://www.mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-net.maxIncomingConnections) description in the official documentation.
    - `set_parameter` [Block]. A set of MongoDB Server Parameters (see the [setParameter](https://www.mongodb.com/docs/manual/reference/configuration-options/#setparameter-option) option).
      - `audit_authorization_success` (Bool). Enables the auditing of authorization successes. Can be either true or false. For more information, see the [auditAuthorizationSuccess](https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.auditAuthorizationSuccess) description in the official documentation. Available only in enterprise edition.
      - `read_hedging_mode` (String). Specifies whether mongos supports hedged reads for those read operations whose read preference have enabled the hedged read option. For more information, see the [readHedgingMode](https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.readHedgingMode) description in the official documentation.
      - `sharding_task_executor_pool_host_timeout_ms` (Number). Maximum time that mongos goes without communication to a host before mongos drops all connections to the host. For more information, see the [shardingTaskExecutorPoolHostTimeoutMS](https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.ShardingTaskExecutorPoolHostTimeoutMS) description in the official documentation.
      - `sharding_task_executor_pool_max_connecting` (Number). Maximum number of simultaneous initiating connections (including pending connections in setup/refresh state) each TaskExecutor connection pool can have to a mongod instance. For more information, see the [shardingTaskExecutorPoolMaxConnecting](https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.ShardingTaskExecutorPoolMaxConnecting) description in the official documentation.
      - `sharding_task_executor_pool_max_size` (Number). Maximum number of outbound connections each TaskExecutor connection pool can open to any given mongod instance. For more information, see the [shardingTaskExecutorPoolMaxSize](https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.ShardingTaskExecutorPoolMaxSize) description in the official documentation.
      - `sharding_task_executor_pool_max_size_for_config_servers` (Number). Optional override for ShardingTaskExecutorPoolMaxSize to set the maximum number of outbound connections each TaskExecutor connection pool can open to a configuration server. For more information, see the [shardingTaskExecutorPoolMaxSizeForConfigServers](https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.ShardingTaskExecutorPoolMaxSizeForConfigServers) description in the official documentation.
      - `sharding_task_executor_pool_min_size` (Number). Minimum number of outbound connections each TaskExecutor connection pool can open to any given mongod instance. For more information, see the [shardingTaskExecutorPoolMinSize](https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.ShardingTaskExecutorPoolMinSize) description in the official documentation.
      - `sharding_task_executor_pool_min_size_for_config_servers` (Number). Optional override for ShardingTaskExecutorPoolMinSize to set the minimum number of outbound connections each TaskExecutor connection pool can open to a configuration server. For more information, see the [shardingTaskExecutorPoolMinSizeForConfigServers](https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.ShardingTaskExecutorPoolMinSizeForConfigServers) description in the official documentation.
      - `sharding_task_executor_pool_refresh_requirement_ms` (Number). Maximum time the mongos waits before attempting to heartbeat an idle connection in the pool. For more information, see the [shardingTaskExecutorPoolRefreshRequirementMS](https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.ShardingTaskExecutorPoolRefreshRequirementMS) description in the official documentation.
      - `sharding_task_executor_pool_refresh_timeout_ms` (Number). Maximum time the mongos waits for a heartbeat before timing out the heartbeat. For more information, see the [shardingTaskExecutorPoolRefreshTimeoutMS](https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.ShardingTaskExecutorPoolRefreshTimeoutMS) description in the official documentation.
      - `sharding_task_executor_pool_replica_set_matching` (String). On a mongos instance, this parameter sets the policy that determines the minimum size limit of its connection pools to nodes within replica sets. For more information, see the [shardingTaskExecutorPoolReplicaSetMatching](https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.ShardingTaskExecutorPoolReplicaSetMatching) description in the official documentation.
      - `warm_min_connections_in_sharding_task_executor_pool_on_startup` (Bool). Configures a mongos instance to prewarm its connection pool on startup. For more information, see the [warmMinConnectionsInShardingTaskExecutorPoolOnStartup](https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.warmMinConnectionsInShardingTaskExecutorPoolOnStartup) description in the official documentation.
      - `warm_min_connections_in_sharding_task_executor_pool_on_startup_wait_ms` (Number). Sets the timeout threshold in milliseconds for a mongos to wait for ShardingTaskExecutorPoolMinSize connections to be established per shard host when using the warmMinConnectionsInShardingTaskExecutorPoolOnStartup parameter. For more information, see the [warmMinConnectionsInShardingTaskExecutorPoolOnStartupWaitMS](https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.warmMinConnectionsInShardingTaskExecutorPoolOnStartupWaitMS) description in the official documentation.
  - `performance_diagnostics` [Block]. Performance diagnostics to the MongoDB cluster.
    - `enabled` (Bool). Enable or disable performance diagnostics.
- `database` [Block]. A database of the MongoDB cluster.
  - `name` (**Required**)(String). The name of the database.
- `disk_size_autoscaling_mongocfg` [Block]. Disk size autoscaling settings for mongocfg.
  - `disk_size_limit` (**Required**)(Number). Limit of disk size after autoscaling (GiB).
  - `emergency_usage_threshold` (Number). Immediate autoscaling disk usage (percent).
  - `planned_usage_threshold` (Number). Maintenance window autoscaling disk usage (percent).
- `disk_size_autoscaling_mongod` [Block]. Disk size autoscaling settings for mongod.
  - `disk_size_limit` (**Required**)(Number). Limit of disk size after autoscaling (GiB).
  - `emergency_usage_threshold` (Number). Immediate autoscaling disk usage (percent).
  - `planned_usage_threshold` (Number). Maintenance window autoscaling disk usage (percent).
- `disk_size_autoscaling_mongoinfra` [Block]. Disk size autoscaling settings for mongoinfra.
  - `disk_size_limit` (**Required**)(Number). Limit of disk size after autoscaling (GiB).
  - `emergency_usage_threshold` (Number). Immediate autoscaling disk usage (percent).
  - `planned_usage_threshold` (Number). Maintenance window autoscaling disk usage (percent).
- `disk_size_autoscaling_mongos` [Block]. Disk size autoscaling settings for mongos.
  - `disk_size_limit` (**Required**)(Number). Limit of disk size after autoscaling (GiB).
  - `emergency_usage_threshold` (Number). Immediate autoscaling disk usage (percent).
  - `planned_usage_threshold` (Number). Maintenance window autoscaling disk usage (percent).
- `host` [Block]. A host of the MongoDB cluster.
  - `assign_public_ip` (Bool). Should this host have assigned public IP assigned. Can be either `true` or `false`.
  - `health` (*Read-Only*) (String). The health of the host.
  - `name` (*Read-Only*) (String). The fully qualified domain name of the host. Computed on server side.
  - `role` (String). The role of the cluster (either PRIMARY or SECONDARY).
  - `shard_name` (String). The name of the shard to which the host belongs. Only for sharded cluster.
  - `subnet_id` (**Required**)(String). The ID of the subnet, to which the host belongs. The subnet must be a part of the network to which the cluster belongs.
  - `type` (String). Type of Mongo daemon which runs on this host (mongod, mongos, mongocfg, mongoinfra). Defaults to `mongod`.
  - `zone_id` (**Required**)(String). The [availability zone](https://yandex.cloud/docs/overview/concepts/geo-scope) where resource is located. If it is not provided, the default provider zone will be used.
  - `host_parameters` [Block]. The parameters of mongod host in replicaset.
    - `hidden` (Bool). Should this host be hidden in replicaset. Can be either `true` of `false`. For more information see [the official documentation](https://www.mongodb.com/docs/current/reference/replica-configuration/#mongodb-rsconf-rsconf.members-n-.hidden).
    - `priority` (Number). A floating point number that indicates the relative likelihood of a replica set member to become the primary. For more information see [the official documentation](https://www.mongodb.com/docs/current/reference/replica-configuration/#mongodb-rsconf-rsconf.members-n-.priority).
    - `secondary_delay_secs` (Number). The number of seconds `behind` the primary that this replica set member should `lag`. For more information see [the official documentation](https://www.mongodb.com/docs/current/reference/replica-configuration/#mongodb-rsconf-rsconf.members-n-.secondaryDelaySecs).
    - `tags` (Map Of String). A set of key/value pairs to assign for the replica set member. For more information see [the official documentation](https://www.mongodb.com/docs/current/reference/replica-configuration/#mongodb-rsconf-rsconf.members-n-.tags).
- `maintenance_window` [Block]. Maintenance window settings of the MongoDB cluster.
  - `day` (String). Day of week for maintenance window if window type is weekly. Possible values: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`.
  - `hour` (Number). Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly.
  - `type` (**Required**)(String). Type of maintenance window. Can be either `ANYTIME` or `WEEKLY`. A day and hour of window need to be specified with weekly window.
- `resources` [Block]. (**DEPRECATED**, use `resources_*` instead) Resources allocated to hosts of the MongoDB cluster.
  - `disk_size` (**Required**)(Number). Volume of the storage available to a MongoDB host, in gigabytes.
  - `disk_type_id` (**Required**)(String). Type of the storage of MongoDB hosts. For more information see [the official documentation](https://yandex.cloud/docs/managed-clickhouse/concepts/storage).
  - `resource_preset_id` (**Required**)(String). The ID of the preset for computational resources available to a MongoDB host (CPU, memory etc.). For more information, see [the official documentation](https://yandex.cloud/docs/managed-mongodb/concepts).
- `resources_mongocfg` [Block]. Resources allocated to `mongocfg` hosts of the MongoDB cluster.
  - `disk_size` (**Required**)(Number). Volume of the storage available to a MongoDB host, in gigabytes.
  - `disk_type_id` (**Required**)(String). Type of the storage of MongoDB hosts. For more information see [the official documentation](https://yandex.cloud/docs/managed-clickhouse/concepts/storage).
  - `resource_preset_id` (**Required**)(String). The ID of the preset for computational resources available to a MongoDB host (CPU, memory etc.). For more information, see [the official documentation](https://yandex.cloud/docs/managed-mongodb/concepts).
- `resources_mongod` [Block]. Resources allocated to `mongod` hosts of the MongoDB cluster.
  - `disk_size` (**Required**)(Number). Volume of the storage available to a MongoDB host, in gigabytes.
  - `disk_type_id` (**Required**)(String). Type of the storage of MongoDB hosts. For more information see [the official documentation](https://yandex.cloud/docs/managed-clickhouse/concepts/storage).
  - `resource_preset_id` (**Required**)(String). The ID of the preset for computational resources available to a MongoDB host (CPU, memory etc.). For more information, see [the official documentation](https://yandex.cloud/docs/managed-mongodb/concepts).
- `resources_mongoinfra` [Block]. Resources allocated to `mongoinfra` hosts of the MongoDB cluster.
  - `disk_size` (**Required**)(Number). Volume of the storage available to a MongoDB host, in gigabytes.
  - `disk_type_id` (**Required**)(String). Type of the storage of MongoDB hosts. For more information see [the official documentation](https://yandex.cloud/docs/managed-clickhouse/concepts/storage).
  - `resource_preset_id` (**Required**)(String). The ID of the preset for computational resources available to a MongoDB host (CPU, memory etc.). For more information, see [the official documentation](https://yandex.cloud/docs/managed-mongodb/concepts).
- `resources_mongos` [Block]. Resources allocated to `mongos` hosts of the MongoDB cluster.
  - `disk_size` (**Required**)(Number). Volume of the storage available to a MongoDB host, in gigabytes.
  - `disk_type_id` (**Required**)(String). Type of the storage of MongoDB hosts. For more information see [the official documentation](https://yandex.cloud/docs/managed-clickhouse/concepts/storage).
  - `resource_preset_id` (**Required**)(String). The ID of the preset for computational resources available to a MongoDB host (CPU, memory etc.). For more information, see [the official documentation](https://yandex.cloud/docs/managed-mongodb/concepts).
- `restore` [Block]. The cluster will be created from the specified backup.
  - `backup_id` (**Required**)(String). Backup ID. The cluster will be created from the specified backup. [How to get a list of PostgreSQL backups](https://yandex.cloud/docs/managed-mongodb/operations/cluster-backups).
  - `time` (String). Timestamp of the moment to which the MongoDB cluster should be restored. (Format: `2006-01-02T15:04:05` - UTC). When not set, current time is used.
- `user` [Block]. A user of the MongoDB cluster.
  - `name` (**Required**)(String). The name of the user.
  - `password` (**Required**)(String). The password of the user.
  - `permission` [Block]. Set of permissions granted to the user.
    - `database_name` (**Required**)(String). The name of the database that the permission grants access to.
    - `roles` (List Of String). The roles of the user in this database. For more information see [the official documentation](https://yandex.cloud/docs/managed-mongodb/concepts/users-and-roles).

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_mdb_mongodb_cluster.<resource Name> <resource Id>
terraform import yandex_mdb_mongodb_cluster.my_cluster ...
```
