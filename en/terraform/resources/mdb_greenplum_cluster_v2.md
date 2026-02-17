---
subcategory: Managed Service for Greenplum®
---

# yandex_mdb_greenplum_cluster_v2 (Resource)

A Greenplum® cluster resource.

## Example usage

```terraform
//
// Create a new MDB Greenplum Cluster.
//
resource "yandex_mdb_greenplum_cluster_v2" "my_cluster" {
  depends_on = [yandex_vpc_subnet.foo]

  name        = "test"
  description = "test greenplum cluster"
  environment = "PRESTABLE"

  segment_host_count = 2
  segment_in_host   = 1

  user_name = "test-user"
  user_password = "test-user-password"
  network_id = yandex_vpc_network.foo.id

  cluster_config = {
    assign_public_ip = true
    backup_window_start = {
      hours   = 1
      minutes = 30
    }
  }

  config = {
    zone_id = "ru-central1-a"
  }

  master_config = {
    resources = {
      resource_preset_id = "s2.small"
      disk_type_id       = "network-ssd"
      disk_size          = 10
    }
  }

  segment_config = {
    resources = {
      resource_preset_id = "s2.small"
      disk_type_id       = "network-ssd"
      disk_size          = 10
    }
  }

  cloud_storage = {
    enable = true
  }
}

resource "yandex_vpc_network" "foo" {}

resource "yandex_vpc_subnet" "foo" {
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.5.0.0/24"]
}

resource "yandex_vpc_security_group" "test-sg-x" {
  network_id = yandex_vpc_network.foo.id
  ingress {
    protocol       = "ANY"
    description    = "Allow incoming traffic from members of the same security group"
    from_port      = 0
    to_port        = 65535
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol       = "ANY"
    description    = "Allow outgoing traffic to members of the same security group"
    from_port      = 0
    to_port        = 65535
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
```

## Arguments & Attributes Reference

- `cloud_storage` [Block]. Cloud storage settings
  - `enable` (Bool). enable Cloud Storage for cluster
- `cluster_config` [Block]. Greenplum® and Odyssey® configuration.
  - `background_activities` [Block]. Managed Greenplum® background tasks configuration.
    - `analyze_and_vacuum` [Block]. Configuration for `ANALYZE` and `VACUUM` operations.
      - `analyze_timeout` (Number). Maximum duration of the `ANALYZE` operation, in seconds. The default value is `36000`. As soon as this period expires, the `ANALYZE` operation will be forced to terminate.
      - `start` [Block]. Time when analyze will start
        - `hours` (Number). hours
        - `minutes` (Number). minutes
      - `vacuum_timeout` (Number). Maximum duration of the `VACUUM` operation, in seconds. The default value is `36000`. As soon as this period expires, the `VACUUM` operation will be forced to terminate.
    - `query_killer_scripts` [Block]. Configuration for long running queries killer.
      - `idle` [Block]. Configuration of script that kills long running queries that are in `idle` state.
        - `enable` (Bool). Use query killer or not
        - `ignore_users` (Set Of String). Ignore these users when considering queries to terminate
        - `max_age` (Number). Maximum duration for this type of queries (in seconds).
      - `idle_in_transaction` [Block]. Configuration of script that kills long running queries that are in `idle in transaction` state.
        - `enable` (Bool). Use query killer or not
        - `ignore_users` (Set Of String). Ignore these users when considering queries to terminate
        - `max_age` (Number). Maximum duration for this type of queries (in seconds).
      - `long_running` [Block]. Configuration of script that kills long running queries (in any state).
        - `enable` (Bool). Use query killer or not
        - `ignore_users` (Set Of String). Ignore these users when considering queries to terminate
        - `max_age` (Number). Maximum duration for this type of queries (in seconds).
    - `table_sizes` [Block]. Enables scripts that collects tables sizes to `*_sizes` tables in `mdb_toolkit` schema.
      - `starts` [Block]. Time when start "table_sizes" script
        - `hours` (Number). hours
        - `minutes` (Number). minutes
  - `greenplum_config` [Block]. package: yandex.cloud.mdb.greenplum.v1
filename: yandex/cloud/mdb/greenplum/v1/cluster_service.proto

    - `gp_add_column_inherits_table_setting` (Bool). https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting
    - `gp_autostats_mode` (String). Specifies the mode for triggering automatic statistics collection after DML.
 https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_autostats_mode
    - `gp_autostats_on_change_threshold` (Number). Specifies the threshold for automatic statistics collection when gp_autostats_mode is set to on_change.
 https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_autostats_on_change_threshold
    - `gp_cached_segworkers_threshold` (Number). Define amount of working processes in segment, that keeping in warm cash after end of query for usage again in next queries.
 https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_cached_segworkers_threshold
    - `gp_enable_global_deadlock_detector` (Bool). Controls whether the Greenplum Database Global Deadlock Detector is enabled to manage concurrent UPDATE and DELETE operations on heap tables to improve performance. See Inserting, Updating, and Deleting Datain the Greenplum Database Administrator Guide. The default is off, the Global Deadlock Detector is deactivated.
 If the Global Deadlock Detector is deactivated (the default), Greenplum Database runs concurrent update and delete operations on a heap table serially.
 If the Global Deadlock Detector is enabled, concurrent updates are permitted and the Global Deadlock Detector determines when a deadlock exists, and breaks the deadlock by cancelling one or more backend processes associated with the youngest transaction(s) involved.
 https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_enable_global_deadlock_detector
    - `gp_enable_zstd_memory_accounting` (Bool). Forces ZSTD lib use Greenplum memory allocation system.
    - `gp_global_deadlock_detector_period` (Number). Specifies the executing interval (in seconds) of the global deadlock detector background worker process.
 https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_global_deadlock_detector_period
    - `gp_max_plan_size` (Number). Specifies the total maximum uncompressed size of a query execution plan multiplied by the number of Motion operators (slices) in the plan.
 https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_max_plan_size
    - `gp_max_slices` (Number). Max amount of slice-processes for one query in one segment.
 https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_max_slices
    - `gp_resource_group_memory_limit` (Number). Identifies the maximum percentage of system memory resources to allocate to resource groups on each Greenplum Database segment node.
 https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_resource_group_memory_limit
    - `gp_vmem_protect_segworker_cache_limit` (Number). Set memory limit (in MB) for working process. If a query executor process consumes more than this configured amount, then the process will not be cached for use in subsequent queries after the process completes.
 https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_vmem_protect_segworker_cache_limit
    - `gp_workfile_compression` (Bool). Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed.
 https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression
    - `gp_workfile_limit_files_per_query` (Number). Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment.
 Spill files are created when executing a query that requires more memory than it is allocated.
 The current query is terminated when the limit is exceeded.
 Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload
 https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query
 Default value is 10000
    - `gp_workfile_limit_per_query` (Number). Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment.
 The default value is 0, which means a limit is not enforced.
 https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query
    - `gp_workfile_limit_per_segment` (Number). Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.
 The default value is 0, which means a limit is not enforced.
 https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment
    - `idle_in_transaction_session_timeout` (Number). Max time (in ms) which session can idle in open transaction
 https://postgrespro.ru/docs/postgrespro/current/runtime-config-client#GUC-IDLE-IN-TRANSACTION-SESSION-TIMEOUT
    - `lock_timeout` (Number). Max time (in ms) which query will wait lock free on object
 https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#lock_timeout
    - `log_statement` (String). Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands.
 MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM.
 PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type.
 https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement
 Default value is ddl
    - `max_connections` (Number). Maximum number of inbound connections on master segment
    - `max_prepared_transactions` (Number). Sets the maximum number of transactions that can be in the "prepared" state simultaneously
 https://www.postgresql.org/docs/9.6/runtime-config-resource.html
    - `max_slot_wal_keep_size` (Number). Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time.
 https://www.postgresql.org/docs/current/runtime-config-replication.html
    - `max_statement_mem` (Number). Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high.
 Taking into account the configuration of a single segment host, calculate max_statement_mem as follows:
 (seghost_physical_memory) / (average_number_concurrent_queries)
 When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file.
 https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem
 Default value is 2097152000 (2000MB)
    - `runaway_detector_activation_percent` (Number). Percent of utilized Greenplum Database vmem that triggers the termination of queries.
 https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#runaway_detector_activation_percent
  - `pool` [Block]. Odyssey® pool settings.
    - `client_idle_timeout` (Number). Client pool idle timeout, in seconds.

 Drop stale client connection after this much seconds of idleness, which is not in transaction.

 Set to zero to disable.
    - `idle_in_transaction_timeout` (Number). Client pool idle in transaction timeout, in seconds.

 Drop client connection in transaction after this much seconds of idleness.

 Set to zero to disable.
    - `mode` (String). Route server pool mode.
    - `size` (Number). The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy.

 Set to zero to disable the limit.
  - `pxf_config` [Block]. package: yandex.cloud.mdb.greenplum.v1
filename: yandex/cloud/mdb/greenplum/v1/cluster.proto

    - `connection_timeout` (Number). Timeout for connection to the Apache Tomcat® server when making read requests.

 Specify values in seconds.
    - `max_threads` (Number). Maximum number of the Apache Tomcat® threads.

 To prevent situations when requests get stuck or fail due to running out of memory or malfunctioning of the Java garbage collector, specify the number of the Apache Tomcat® threads. Learn more about adjusting the number of threads in the [VMware Greenplum® Platform Extension Framework](https://docs.vmware.com/en/VMware-Greenplum-Platform-Extension-Framework/6.9/greenplum-platform-extension-framework/cfg_mem.html) documentation.
    - `pool_allow_core_thread_timeout` (Bool). Determines whether the timeout for core streaming threads is permitted.
    - `pool_core_size` (Number). Number of core streaming threads per pool.
    - `pool_max_size` (Number). Maximum allowed number of core streaming threads.
    - `pool_queue_capacity` (Number). Maximum number of requests you can add to a pool queue for core streaming threads.

 If `0`, no pool queue is generated.
    - `upload_timeout` (Number). Timeout for connection to the Apache Tomcat® server when making write requests.

 Specify the values in seconds.
    - `xms` (Number). Maximum size, in megabytes, of the JVM heap for the PXF daemon.
    - `xmx` (Number). Initial size, in megabytes, of the JVM heap for the PXF daemon.
- `config` [Block]. Greenplum® cluster configuration.
  - `access` [Block]. Access policy for external services.
    - `data_lens` (Bool). Allows data export from the cluster to DataLens.
    - `data_transfer` (Bool). Allows access for DataTransfer.
    - `web_sql` (Bool). Allows SQL queries to the cluster databases from the management console.
    - `yandex_query` (Bool). Allow access for YandexQuery.
  - `assign_public_ip` (Bool). Determines whether the cluster has a public IP address.

 After the cluster has been created, this setting cannot be changed.
  - `backup_retain_period_days` (Number). Retention policy of automated backups.
  - `backup_window_start` (String). Time to start the daily backup, in the UTC timezone.
  - `subnet_id` (String). ID of the subnet the cluster belongs to. This subnet should be a part of the cloud network the cluster belongs to (see [Cluster.network_id]).
  - `version` (String). Version of the Greenplum® server software.
  - `zone_id` (**Required**)(String). ID of the availability zone the cluster belongs to.
 To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List] request.
- `created_at` (*Read-Only*) (String). Time when the cluster was created.
- `deletion_protection` (Bool). Determines whether the cluster is protected from being deleted.
- `description` (String). Description of the Greenplum® cluster.
- `environment` (**Required**)(String). Deployment environment of the Greenplum® cluster.
- `folder_id` (String). ID of the folder that the Greenplum® cluster belongs to.
- `host_group_ids` (Set Of String). Host groups hosting VMs of the cluster.
- `id` (String). ID of the Greenplum® cluster resource to return.

 To get the cluster ID, use a [ClusterService.List] request.
- `labels` (Map Of String). Custom labels for the Greenplum® cluster as `key:value` pairs. Maximum 64 labels per resource.
- `logging` [Block]. Cloud logging configuration
  - `command_center_enabled` (Bool). send Yandex Command Center logs
  - `enabled` (Bool). package: yandex.cloud.mdb.greenplum.v1
filename: yandex/cloud/mdb/greenplum/v1/cluster.proto

  - `folder_id` (String). package: yandex.cloud.mdb.greenplum.v1
filename: yandex/cloud/mdb/greenplum/v1/cluster.proto

  - `greenplum_enabled` (Bool). send Greenplum logs
  - `log_group_id` (String). package: yandex.cloud.mdb.greenplum.v1
filename: yandex/cloud/mdb/greenplum/v1/cluster.proto

  - `pooler_enabled` (Bool). send Pooler logs
- `maintenance_window` [Block]. A Greenplum® cluster maintenance window. Should be defined by either one of the two options.
  - `anytime` [Block]. An any-time maintenance window.
  - `weekly_maintenance_window` [Block]. A weekly maintenance window.
    - `day` (String). Day of the week.
    - `hour` (Number). Hour of the day in the UTC timezone.
- `master_config` [Block]. Configuration of the Greenplum® master subcluster.
  - `resources` [Block]. Computational resources allocated to Greenplum® master subcluster hosts.
    - `disk_size` (Number). Volume of the storage used by the host, in bytes.
    - `disk_type_id` (String). Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`.
    - `resource_preset_id` (String). ID of the preset for computational resources allocated to a host.

 Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types).
- `master_host_count` (Number). Number of hosts in the master subcluster.
- `master_host_group_ids` (Set Of String). Host groups hosting VMs of the master subcluster.
- `monitoring` [Block]. Description of monitoring systems relevant to the Greenplum® cluster.
  - `description` (*Read-Only*) (String). Description of the monitoring system.
  - `link` (*Read-Only*) (String). Link to the monitoring system charts for the Greenplum® cluster.
  - `name` (*Read-Only*) (String). Name of the monitoring system.
- `name` (**Required**)(String). Name of the Greenplum® cluster.
 The name is unique within the folder.
- `network_id` (**Required**)(String). ID of the cloud network that the cluster belongs to.
- `planned_operation` [Block]. Maintenance operation planned at nearest [maintenance_window].
  - `delayed_until` (*Read-Only*) (String). Delay time for the maintenance operation.
  - `info` (*Read-Only*) (String). The description of the operation.
- `restore` [Block]. The cluster will be created from the specified backup.
  - `backup_id` (**Required**)(String). ID of the backup to create a cluster from.
  - `restore_only` (Set Of String). List of databases and tables to restore
  - `time` (String). Timestamp of the moment to which the Greenplum cluster should be restored. (Format: `2006-01-02T15:04:05` - UTC). When not set, current time is used.
- `security_group_ids` (Set Of String). User security groups.
- `segment_config` [Block]. Configuration of the Greenplum® segment subcluster.
  - `resources` [Block]. Computational resources allocated to Greenplum® segment subcluster hosts.
    - `disk_size` (Number). Volume of the storage used by the host, in bytes.
    - `disk_type_id` (String). Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`.
    - `resource_preset_id` (String). ID of the preset for computational resources allocated to a host.

 Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types).
- `segment_host_count` (Number). Number of hosts in the segment subcluster.
- `segment_host_group_ids` (Set Of String). Host groups hosting VMs of the segment subcluster.
- `segment_in_host` (Number). Number of segments per host.
- `service_account_id` (String). Service account that will be used to access a Yandex Cloud resources
- `user_name` (**Required**)(String). Owner user name.
- `user_password` (**Required**)(String). Owner user password.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_mdb_greenplum_cluster_v2.<resource Name> <resource Id>
terraform import yandex_mdb_greenplum_cluster_v2.my_cluster ...
```
