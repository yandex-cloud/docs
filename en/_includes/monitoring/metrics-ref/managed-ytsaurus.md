The `name` label contains the metric name.

Labels shared by all {{ myt-name }} metrics: 

#|
|| **Label** | **Value** ||
|| service | Service ID: `managed-ytsaurus` ||
|| cluster_id | Cluster ID ||
|#


## Cluster resource metrics {#managed-ytsaurus-cluster-resources-metrics}

### Computing resource metrics {#managed-ytsaurus-cluster-compute-resources-metrics}

#|
|| **Name**<br/>**Type, units** | **Description** ||
|| `yt_scheduler_pools_resource_limits_cpu`<br/>``DGAUGE``, count | Maximum number of CPUs available within the scheduler pool. Additional labels:
* `service_name`: Cluster component name. Possible values: `yt-scheduler` \| `*`
* `pool`: Pool name. Possible values: `<Root>` \| `research` \| `robot-odin` \| `*` \| `-`
* `tree`: Pool tree ID. Possible values: `default` \| `*`
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|| `yt_scheduler_distributed_resources_cpu`<br/>``DGAUGE``, count | Number of CPUs allocated by the scheduler for current tasks. Additional labels:
* `service_name`: Cluster component name. Possible values: `yt-scheduler` \| `yt-controller-agent` \| `*`
* `tree`: Pool tree ID. Possible values: `default` \| `undefined_tree` \| `*` \| `-`
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|| `yt_scheduler_pools_resource_limits_gpu`<br/>``DGAUGE``, count | Maximum number of GPUs available within the scheduler pool. Additional labels:
* `service_name`: Cluster component name. Possible values: `yt-scheduler` \| `*`
* `pool`: Pool name. Possible values: `<Root>` \| `research` \| `robot-odin` \| `*` \| `-`
* `tree`: Pool tree ID. Possible values: `default` \| `*`
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|| `yt_scheduler_distributed_resources_gpu`<br/>``DGAUGE``, count | Number of GPUs allocated by the scheduler for current tasks. Additional labels:
* `service_name`: Cluster component name. Possible values: `yt-scheduler` \| `yt-controller-agent` \| `*`
* `tree`: Pool tree ID. Possible values: `default` \| `undefined_tree` \| `*` \| `-`
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|| `yt_scheduler_pools_resource_limits_user_memory`<br/>``DGAUGE``, bytes | Memory allocation limit for user tasks within the scheduler pool. Additional labels:
* `service_name`: Cluster component name. Possible values: `yt-scheduler` \| `*`
* `pool`: Pool name. Possible values: `<Root>` \| `research` \| `robot-odin` \| `*` \| `-`
* `tree`: Pool tree ID. Possible values: `default` \| `*`
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|| `yt_scheduler_distributed_resources_user_memory`<br/>``DGAUGE``, bytes | Amount of memory allocated for user tasks by the scheduler. Additional labels:
* `service_name`: Cluster component name. Possible values: `yt-scheduler` \| `yt-controller-agent` \| `*`
* `tree`: Pool tree ID. Possible values: `default` \| `undefined_tree` \| `*` \| `-`
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|| `yt_scheduler_undistributed_resources_cpu`<br/>``DGAUGE``, count | Number of unallocated CPUs available to the scheduler. Additional labels:
* `service_name`: Cluster component name. Possible values: `yt-scheduler` \| `yt-controller-agent` \| `*`
* `tree`: Pool tree ID. Possible values: `default` \| `undefined_tree` \| `*` \| `-`
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|| `yt_scheduler_undistributed_resources_user_memory`<br/>``DGAUGE``, bytes | Amount of unallocated memory for user tasks available to the scheduler. Additional labels:
* `service_name`: Cluster component name. Possible values: `yt-scheduler` \| `yt-controller-agent` \| `*`
* `tree`: Pool tree ID. Possible values: `default` \| `undefined_tree` \| `*` \| `-`
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|#

### Pool scheduler metrics {#managed-ytsaurus-cluster-scheduler-pools-metrics}

#|
|| **Name**<br/>**Type, units** | **Description** ||
|| `yt_scheduler_pools_running_operation_count`<br/>`DGAUGE`, count | Number of `running` operations within the scheduler pool. Additional labels:
* `service_name`: Cluster component name. Possible values: `yt-scheduler` \| `*`
* `pool`: Pool name. Possible values: `<Root>` \| `research` \| `robot-odin` \| `*` \| `-`
* `tree`: Pool tree ID. Possible values: `default` \| `*`
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|| `yt_scheduler_pools_lightweight_running_operation_count`<br/>`DGAUGE`, count | Number of lightweight `running` operations within the scheduler pool. Additional labels:
* `service_name`: Cluster component name. Possible values: `yt-scheduler` \| `*`
* `pool`: Pool name. Possible values: `<Root>` \| `research` \| `robot-odin` \| `*` \| `-`
* `tree`: Pool tree ID. Possible values: `default` \| `*`
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|| `yt_scheduler_pools_max_running_operation_count`<br/>`DGAUGE`, count | Maximum allowed number of simultaneously `running` operations within the scheduler pool.
Additional labels:
* `service_name`: Cluster component name. Possible values: `yt-scheduler` \| `*`
* `pool`: Pool name. Possible values: `<Root>` \| `research` \| `robot-odin` \| `*` \| `-`
* `tree`: Pool tree ID. Possible values: `default` \| `*`
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|| `yt_scheduler_pools_total_operation_count`<br/>`DGAUGE`, count | Total number of all operations within the scheduler pool. Additional labels:
* `service_name`: Cluster component name. Possible values: `yt-scheduler` \| `*`
* `pool`: Pool name. Possible values: `<Root>` \| `research` \| `robot-odin` \| `*` \| `-`
* `tree`: Pool tree ID. Possible values: `default` \| `*`
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|| `yt_scheduler_pools_max_operation_count`<br/>`DGAUGE`, count | Maximum allowed number of operations within the scheduler pool. Additional labels:
* `service_name`: Cluster component name. Possible values: `yt-scheduler` \| `*`
* `pool`: Pool name. Possible values: `<Root>` \| `research` \| `robot-odin` \| `*` \| `-`
* `tree`: Pool tree ID. Possible values: `default` \| `*`
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|| **CPU** | > ||
|| `yt_scheduler_pools_resource_usage_cpu`<br/>`DGAUGE`, count | Number of CPUs currently used for tasks within the scheduler pool. Additional labels:
* `service_name`: Cluster component name. Possible values: `yt-scheduler` \| `*`
* `pool`: Pool name. Possible values: `<Root>` \| `research` \| `robot-odin` \| `*` \| `-`
* `tree`: Pool tree ID. Possible values: `default` \| `*`
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|| `yt_scheduler_pools_resource_demand_cpu`<br/>`DGAUGE`, count | Number of CPUs required to start all pending tasks within the scheduler pool. Additional labels:
* `service_name`: Cluster component name. Possible values: `yt-scheduler` \| `*`
* `pool`: Pool name. Possible values: `<Root>` \| `research` \| `robot-odin` \| `*` \| `-`
* `tree`: Pool tree ID. Possible values: `default` \| `*`
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|| `yt_scheduler_pools_effective_strong_guarantee_resources_cpu`<br/>`DGAUGE`, count | Number of CPUs guaranteed to be available within the scheduler pool. Additional labels:
* `service_name`: Cluster component name. Possible values: `yt-scheduler` \| `*`
* `pool`: Pool name. Possible values: `<Root>` \| `research` \| `robot-odin` \| `*` \| `-`
* `tree`: Pool tree ID. Possible values: `default` \| `*`
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|| `yt_scheduler_pools_specified_resource_limits_cpu`<br/>`DGAUGE`, count | Maximum number of CPUs set in the scheduler pool configuration. Additional labels:
* `service_name`: Cluster component name. Possible values: `yt-scheduler` \| `*`
* `pool`: Pool name. Possible values: `<Root>` \| `research` \| `robot-odin` \| `*` \| `-`
* `tree`: Pool tree ID. Possible values: `default` \| `*`
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|| **RAM** | > ||
|| `yt_scheduler_pools_resource_usage_user_memory`<br/>`DGAUGE`, bytes | Current user-task memory utilization within the scheduler pool. Additional labels:
* `service_name`: Cluster component name. Possible values: `yt-scheduler` \| `*`
* `pool`: Pool name. Possible values: `<Root>` \| `research` \| `robot-odin` \| `*` \| `-`
* `tree`: Pool tree ID. Possible values: `default` \| `*`
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|| `yt_scheduler_pools_resource_demand_user_memory`<br/>`DGAUGE`, bytes | Amount of memory for user tasks required to start all pending tasks within the scheduler pool. Additional labels:
* `service_name`: Cluster component name. Possible values: `yt-scheduler` \| `*`
* `pool`: Pool name. Possible values: `<Root>` \| `research` \| `robot-odin` \| `*` \| `-`
* `tree`: Pool tree ID. Possible values: `default` \| `*`
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|| `yt_scheduler_pools_effective_strong_guarantee_resources_user_memory`<br/>`DGAUGE`, bytes | Guaranteed user-task memory within the scheduler pool. Additional labels:
* `service_name`: Cluster component name. Possible values: `yt-scheduler` \| `*`
* `pool`: Pool name. Possible values: `<Root>` \| `research` \| `robot-odin` \| `*` \| `-`
* `tree`: Pool tree ID. Possible values: `default` \| `*`
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|| `yt_scheduler_pools_specified_resource_limits_user_memory`<br/>`DGAUGE`, bytes | Amount of memory for user tasks set in the scheduler pool configuration. Additional labels:
* `service_name`: Cluster component name. Possible values: `yt-scheduler` \| `*`
* `pool`: Pool name. Possible values: `<Root>` \| `research` \| `robot-odin` \| `*` \| `-`
* `tree`: Pool tree ID. Possible values: `default` \| `*`
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|| **GPU** | > ||
|| `yt_scheduler_pools_resource_usage_gpu`<br/>`DGAUGE`, count | Number of GPUs currently used for tasks within the scheduler pool. Additional labels:
* `service_name`: Cluster component name. Possible values: `yt-scheduler` \| `*`
* `pool`: Pool name. Possible values: `<Root>` \| `research` \| `robot-odin` \| `*` \| `-`
* `tree`: Pool tree ID. Possible values: `default` \| `*`
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|| `yt_scheduler_pools_resource_demand_gpu`<br/>`DGAUGE`, count | Number of GPUs required to start all pending tasks within the scheduler pool. Additional labels:
* `service_name`: Cluster component name. Possible values: `yt-scheduler` \| `*`
* `pool`: Pool name. Possible values: `<Root>` \| `research` \| `robot-odin` \| `*` \| `-`
* `tree`: Pool tree ID. Possible values: `default` \| `*`
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|| `yt_scheduler_pools_effective_strong_guarantee_resources_gpu`<br/>`DGAUGE`, count | Number of GPUs guaranteed to be available within the scheduler pool. Additional labels:
* `service_name`: Cluster component name. Possible values: `yt-scheduler` \| `*`
* `pool`: Pool name. Possible values: `<Root>` \| `research` \| `robot-odin` \| `*` \| `-`
* `tree`: Pool tree ID. Possible values: `default` \| `*`
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|| `yt_scheduler_pools_specified_resource_limits_gpu`<br/>`DGAUGE`, count | Number of GPUs set in the scheduler pool configuration. Additional labels:
* `service_name`: Cluster component name. Possible values: `yt-scheduler` \| `*`
* `pool`: Pool name. Possible values: `<Root>` \| `research` \| `robot-odin` \| `*` \| `-`
* `tree`: Pool tree ID. Possible values: `default` \| `*`
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|#

### Metrics for fault diagnostics {#managed-ytsaurus-cluster-problems-metrics}

#|
|| **Name**<br/>**Type, units** | **Description** ||
|| `yt_node_tracker_offline_node_count`<br/>`DGAUGE`, count | Number of nodes in `offline` status. ||
|| `yt_node_tracker_banned_node_count`<br/>`DGAUGE`, count | Number of nodes in `banned` status. ||
|| `yt_node_tracker_decommissioned_node_count`<br/>`DGAUGE`, count | Number of nodes in `banned` state. ||
|| `yt_cluster_node_alerts`<br/>`DGAUGE`, count | Number of active alerts about issues with {{ ytsaurus-name }} cluster nodes. The additional `error_code` label may take the following values:
* `*`
* `-`
* `NYT::NBus::EErrorCode::SslError`
* `NYT::NRpc::EErrorCode::Unavailable`
* `NYT::NSecurityClient::EErrorCode::AccountLimitExceeded`
* `NYT::NTabletClient::EErrorCode::NoSuchCell`
* `cell_did_not_appear_within_timeout`
||
|#

## CPU and memory metrics {#managed-ytsaurus-cluster-cpu-memory-metrics}

#|
|| **Name**<br/>**Type, units** | **Description** ||
|| `yt_resource_tracker_total_cpu`<br/>`DGAUGE`, count | Total CPUs in the cluster. Additional labels:
* `service_name`: Cluster component name. 
* `thread`: Stream name.
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|| `yt_security_user_write_time`<br/>`DGAUGE`, ms | Total time spent on permission checks by the security system during user-initiated write operations. Additional labels:
* `user`: Username.
* `service_name`: Cluster component name.
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|| `yt_security_user_read_time`<br/>`DGAUGE`, ms | Total time spent on permission checks by the security system during user-initiated read operations. Additional labels:
* `user`: Username.
* `service_name`: Cluster component name.
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
||` yt_resource_tracker_memory_usage_rss`<br/>`DGAUGE`, bytes | Total actual RSS (Resident Set Size) memory usage in the cluster. Additional labels:
* `service_name`: Cluster component name.
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|| `yt_security_user_write_request_count`<br/>`DGAUGE`, units per second | Number of user-initiated write requests processed by the security system. Additional labels:
* `user`: Username.
* `service_name`: Cluster component name.
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|| `yt_security_user_read_request_count`<br/>`DGAUGE`, units per second | Number of user-initiated read requests processed by the security system. Additional labels:
* `user`: Username.
* `service_name`: Cluster component name.
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|| `yt_chunk_service_weight_throttler_value`<br/>`DGAUGE`, number | Current weight throttler value. Additional labels:
* `user`: Username.
* `service_name`: Cluster component name.
* `host`: Host name. Possible values: `<host_name>`, `*` \| `-`. ||
|#
