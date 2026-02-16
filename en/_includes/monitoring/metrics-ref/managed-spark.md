The `name` label contains the metric name.

Labels shared by all {{ msp-name }} metrics:

#|
|| **Label** | **Value** ||
|| service | Service ID: `managed-spark` ||
|| cluster_id | Cluster ID ||
|| node_name | Host ID ||
|| node_role | Host role. The possible values are:
* `spark_cluster.driver` for the driver
* `spark_cluster.executor` for the executor ||
|#

## Cluster resource metrics {#managed-spark-cluster-resources-metrics}

#|
|| **Name**

**Type, units** | **Description** ||
|| `node.allocatable_cpu.gauge`

`DGAUGE`, count | Number of CPUs available to containers. ||
|| `node.capacity_cpu.gauge`

`DGAUGE`, count | Total CPUs per cluster. Some CPUs may be reserved for system needs. ||
|| `node.cpu_usage.gauge`

`DGAUGE`, number | CPU utilization on hosts. ||
|| `node.allocatable_memory.gauge`

`DGAUGE`, bytes | Host RAM available to containers. ||
|| `node.capacity_memory.gauge`

`DGAUGE`, bytes | Total host RAM. Some RAM may be reserved for system needs. ||
|| `node.memory_usage.gauge`

`DGAUGE`, bytes | Host RAM in use. ||
|| `node.fs_available_bytes.gauge`

`DGAUGE`, bytes | Host disk space available to containers. ||
|| `node.fs_capacity_bytes.gauge`

`DGAUGE`, bytes | Host disk capacity. Some disk space may be reserved for system needs. ||
|| `node.fs_used_bytes.gauge`

`DGAUGE`, bytes | Used host disk space. ||
|| `node.network_rx_bytes.gauge`

`DGAUGE`, bytes | Incoming network traffic to the cluster. ||
|| `node.network_rx_errors.gauge`

`DGAUGE`, count | Number of network traffic receive errors in the cluster. ||
|| `node.network_tx_bytes.gauge`

`DGAUGE`, bytes | Outgoing network traffic from the cluster. ||
|| `node.network_tx_errors.gauge`

`DGAUGE`, count | Number of network traffic send errors in the cluster. ||
|| `pod.running.gauge`

`DGAUGE`, count | Number of running containers.

The additional `pod_name` label can take the container ID value. ||
|| `pod.succeeded.gauge`

`DGAUGE`, count | Number of successfully completed containers.

The additional `pod_name` label can take the container ID value. ||
|| `pod.pending.gauge`

`DGAUGE`, count | Number of containers waiting to run.

The additional `pod_name` label can take the container ID value. ||
|| `pod.failed.gauge`

`DGAUGE`, count | Number of containers which failed to start.

The additional `pod_name` label can take the container ID value. ||
|| `pod.unknown.gauge`

`DGAUGE`, count | Number of containers in an unknown state.

The additional `pod_name` label can take the container ID value. ||
|| `pod_container.ready.gauge`

`DGAUGE`, count | Number of containers ready to run.

The additional `pod_name` label can take the container ID value. ||
|| `pod_container.started.gauge`

`DGAUGE`, count | Number of running containers.

The additional `pod_name` label can take the container ID value. ||
|| `pod_container.restart_count.gauge`

`DGAUGE`, count | Number of container restarts.

The additional `pod_name` label can take the container ID value. ||
|| `pod_container.cpu_usage.gauge`

`DGAUGE`, number | CPU utilization by the container.

The additional `pod_name` label can take the container ID value. ||
|| `pod_container.cpu_limit.gauge`

`DGAUGE`, number | Container CPU limit.

The additional `pod_name` label can take the container ID value. ||
|| `pod_container.memory_usage.gauge`

`DGAUGE`, bytes | Memory used by the container.

The additional `pod_name` label can take the container ID value. ||
|| `pod_container.memory_limit.gauge`

`DGAUGE`, bytes | Container memory limit.

The additional `pod_name` label can take the container ID value. ||
|| `pod_container.logsfs_capacity_bytes.gauge`

`DGAUGE`, bytes | LogFS space allocated to the container.

The additional `pod_name` label can take the container ID value. ||
|| `pod_container.logsfs_available_bytes.gauge`

`DGAUGE`, bytes | LogFS space available in the container to run applications.

The additional `pod_name` label can take the container ID value. ||
|| `pod_container.rootfs_capacity_bytes.gauge`

`DGAUGE`, bytes | RootFS space allocated to the container.

The additional `pod_name` label can take the container ID value. ||
|| `pod_container.rootfs_available_bytes.gauge`

`DGAUGE`, bytes | Available container RootFS space.

The additional `pod_name` label can take the container ID value. ||
|| `pod_container.rootfs_used_bytes.gauge`

`DGAUGE`, bytes | Used container RootFS space.

The additional `pod_name` label can take the container ID value. ||
|| `pod_network.rx_bytes.gauge`

`DGAUGE`, bytes | Incoming network traffic to the container.

The additional `pod_name` label can take the container ID value. ||
|| `pod_network.rx_errors.gauge`

`DGAUGE`, count | Number of network receive errors in the container.

The additional `pod_name` label can take the container ID value. ||
|| `pod_network.tx_bytes.gauge`

`DGAUGE`, bytes | Outgoing network traffic from the container.

The additional `pod_name` label can take the container ID value. ||
|| `pod_network.tx_errors.gauge`

`DGAUGE`, count | Number of network send errors in the container.

The additional `pod_name` label can take the container ID value. ||
|| `pod_volume.capacity_bytes.gauge`

`DGAUGE`, bytes | Total size of the disk attached to the container.

The additional `pod_name` label can take the container ID value. ||
|| `pod_volume.available_bytes.gauge`

`DGAUGE`, bytes | Available space on the disk attached to the container.

The additional `pod_name` label can take the container ID value. ||
|| `pod_volume.used_bytes.gauge`

`DGAUGE`, bytes | Used space of the disk attached to the container.

The additional `pod_name` label can take the container ID value. ||
|#

## Service metrics {#managed-spark-metrics}

### Driver metrics {#managed-spark-drivers-metrics}

These are {{ SPRK }} native metrics for [driver monitoring](https://spark.apache.org/docs/latest/monitoring.html#component-instance--driver).

The metrics have the following additional labels:

* `pod_name`, which can take the container ID value.
* `job_id`, which can take the job ID value.

#|
|| **Name**

**Type** ||
|| `driver_appstatus_jobduration_number.value`

`DGAUGE` ||
|| `driver_appstatus_jobduration_value.value`

`DGAUGE` ||
|| `driver_appstatus_jobs_failedjobs_count.value`

`DGAUGE` ||
|| `driver_appstatus_jobs_succeededjobs_count.value`

`DGAUGE` ||
|| `driver_appstatus_stages_completedstages_count.value`

`DGAUGE` ||
|| `driver_appstatus_stages_failedstages_count.value`

`DGAUGE` ||
|| `driver_appstatus_stages_skippedstages_count.value`

`DGAUGE` ||
|| `driver_appstatus_tasks_blacklistedexecutors_count.value`

`DGAUGE` ||
|| `driver_appstatus_tasks_completedtasks_count.value`

`DGAUGE` ||
|| `driver_appstatus_tasks_excludedexecutors_count.value`

`DGAUGE` ||
|| `driver_appstatus_tasks_failedtasks_count.value`

`DGAUGE` ||
|| `driver_appstatus_tasks_killedtasks_count.value`

`DGAUGE` ||
|| `driver_appstatus_tasks_skippedtasks_count.value`

`DGAUGE` ||
|| `driver_appstatus_tasks_unblacklistedexecutors_count.value`

`DGAUGE` ||
|| `driver_appstatus_tasks_unexcludedexecutors_count.value`

`DGAUGE` ||
|| `driver_dagscheduler_job_activejobs_number.value`

`DGAUGE` ||
|| `driver_dagscheduler_job_activejobs_value.value`

`DGAUGE` ||
|| `driver_dagscheduler_job_alljobs_number.value``DGAUGE` ||
|| `driver_dagscheduler_job_alljobs_value.value``DGAUGE` ||
|| `driver_dagscheduler_stage_failedstages_number.value`

`DGAUGE` ||
|| `driver_dagscheduler_stage_failedstages_value.value`

`DGAUGE` ||
|| `driver_dagscheduler_stage_runningstages_number.value`

`DGAUGE` ||
|| `driver_dagscheduler_stage_runningstages_value.value`

`DGAUGE` ||
|| `driver_dagscheduler_stage_waitingstages_number.value`

`DGAUGE` ||
|| `driver_dagscheduler_stage_waitingstages_value.value`

`DGAUGE` ||
|#

### Executor metrics {#managed-spark-executors-metrics}

These are {{ SPRK }} native metrics for [executor monitoring](https://spark.apache.org/docs/latest/monitoring.html#component-instance--executor).

The metrics have the following additional labels:

* `pod_name`, which can take the container ID value.
* `job_id`, which can take the job ID value.
* `executor_id`, which can take the `driver` value.
* `application_id`, which can take the Spark app ID value.
* `application_name`, which can take the Spark app name value.

#|
|| **Name**

**Type** ||
|| `executor_activetasks.value`

`DGAUGE` ||
|| `executor_completedtasks_total.value`

`DGAUGE` ||
|| `executor_failedtasks_total.value`

`DGAUGE` ||
|| `executor_directpoolmemory_bytes.value`

`DGAUGE` ||
|| `executor_diskused_bytes.value`

`DGAUGE` ||
|| `executor_jvmheapmemory_bytes.value`

`DGAUGE` ||
|| `executor_jvmoffheapmemory_bytes.value`

`DGAUGE` ||
|| `executor_majorgccount_total.value`

`DGAUGE` ||
|| `executor_majorgctime_seconds_total.value`

`DGAUGE` ||
|| `executor_mappedpoolmemory_bytes.value`

`DGAUGE` ||
|| `executor_maxmemory_bytes.value`

`DGAUGE` ||
|| `executor_maxtasks.value`

`DGAUGE` ||
|| `executor_memoryused_bytes.value`

`DGAUGE` ||
|| `executor_minorgccount_total.value`

`DGAUGE` ||
|| `executor_minorgctime_seconds_total.value`

`DGAUGE` ||
|| `executor_offheapexecutionmemory_bytes.value`

`DGAUGE` ||
|| `executor_offheapstoragememory_bytes.value`

`DGAUGE` ||
|| `executor_offheapunifiedmemory_bytes.value`

`DGAUGE` ||
|| `executor_onheapexecutionmemory_bytes.value`

`DGAUGE` ||
|| `executor_onheapstoragememory_bytes.value`

`DGAUGE` ||
|| `executor_onheapunifiedmemory_bytes.value`

`DGAUGE` ||
|| `executor_processtreejvmrssmemory_bytes.value`

`DGAUGE` ||
|| `executor_processtreejvmvmemory_bytes.value`

`DGAUGE` ||
|| `executor_processtreeotherrssmemory_bytes.value`

`DGAUGE` ||
|| `executor_processtreeothervmemory_bytes.value`

`DGAUGE` ||
|| `executor_processtreepythonrssmemory_bytes.value`

`DGAUGE` ||
|| `executor_processtreepythonvmemory_bytes.value`

`DGAUGE` ||
|| `executor_rddblocks.value`

`DGAUGE` ||
|| `executor_totalcores.value`

`DGAUGE` ||
|| `executor_totalduration_seconds_total.value`

`DGAUGE` ||
|| `executor_totalgctime_seconds_total.value`

`DGAUGE` ||
|| `executor_totalinputbytes_bytes_total.value`

`DGAUGE` ||
|| `executor_totaloffheapstoragememory_bytes.value`

`DGAUGE` ||
|| `executor_totalonheapstoragememory_bytes.value`

`DGAUGE` ||
|| `executor_totalshuffleread_bytes_total.value`

`DGAUGE` ||
|| `executor_totalshufflewrite_bytes_total.value`

`DGAUGE` ||
|| `executor_totaltasks_total.value`

`DGAUGE` ||
|| `executor_usedoffheapstoragememory_bytes.value`

`DGAUGE` ||
|| `executor_usedonheapstoragememory_bytes.value`

`DGAUGE` ||
|#
