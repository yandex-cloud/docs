The `name` label contains the metric name.

Labels shared by all {{ dataproc-name }} metrics:

Label | Value
----|----
service | Service ID: `data-proc`
resource_type | Resource type: `cluster`
resource_id | Cluster ID
zone_id | Placement zone
host | Host FQDN

## HDFS metrics {#data-proc-hdfs-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `dfs.cluster.Free_bytes`<br/>`DGAUGE`, bytes | Space available in HDFS |
| `dfs.cluster.NonDfsUsedSpace_bytes`<br/>`DGAUGE`, bytes | Space used by data storage subclusters (DataNode), unavailable to HDFS |
| `dfs.cluster.PercentRemaining`<br/>`DGAUGE`, % | Space available in HDFS |
| `dfs.cluster.PercentUsed`<br/>`DGAUGE`, % | Space used in HDFS |
| `dfs.cluster.Total_bytes`<br/>`DGAUGE`, bytes | HDFS size |
| `dfs.cluster.Used_bytes`<br/>`DGAUGE`, bytes | Space used in HDFS |

## Disk metrics {#data-proc-disk-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `system.disk.free_bytes`<br/>`DGAUGE`, bytes | Space available in the system storage |
| `system.disk.inodes_free`<br/>`DGAUGE`, count | Number of free inodes |
| `system.disk.inodes_total`<br/>`DGAUGE`, count | Total inodes |
| `system.disk.inodes_used`<br/>`DGAUGE`, count | Number of used inodes |
| `system.disk.inodes_used_percent`<br/>`DGAUGE`, % | Percentage of used inodes |
| `system.disk.total_bytes`<br/>`DGAUGE`, bytes | System storage size |
| `system.disk.used_bytes`<br/>`DGAUGE`, bytes | Used disk space |
| `system.disk.used_percent`<br/>`DGAUGE`, % | Used disk space |

## YARN metrics {#data-proc-yarn-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `yarn.cluster.activeNodes`<br/>`DGAUGE`, count | Number of active nodes |
| `yarn.cluster.allocatedMB`<br/>`DGAUGE`, megabytes | Allocated memory |
| `yarn.cluster.allocatedVirtualCores`<br/>`DGAUGE`, count | Number of allocated virtual cores |
| `yarn.cluster.appsCompleted`<br/>`DGAUGE`, count | Successfully completed applications |
| `yarn.cluster.appsFailed`<br/>`DGAUGE`, count | Failed applications |
| `yarn.cluster.appsKilled`<br/>`DGAUGE`, count | Killed applications |
| `yarn.cluster.appsPending`<br/>`DGAUGE`, count | Enqueued applications |
| `yarn.cluster.appsRunning`<br/>`DGAUGE`, count | Running applications |
| `yarn.cluster.appsSubmitted`<br/>`DGAUGE`, count | Started applications |
| `yarn.cluster.availableMB`<br/>`DGAUGE`, megabytes | Available memory |
| `yarn.cluster.availableVirtualCores`<br/>`DGAUGE`, count | Number of available virtual cores |
| `yarn.cluster.containersAllocated`<br/>`DGAUGE`, count | Number of allocated containers |
| `yarn.cluster.containersPending`<br/>`DGAUGE`, count | Number of enqueued containers |
| `yarn.cluster.containersReserved`<br/>`DGAUGE`, count | Number of reserved containers |
| `yarn.cluster.decommissionedNodes`<br/>`DGAUGE`, count | Number of discontinued nodes |
| `yarn.cluster.decommissioningNodes`<br/>`DGAUGE`, count | Nodes being discontinued |
| `yarn.cluster.lostNodes`<br/>`DGAUGE`, count | Number of lost nodes |
| `yarn.cluster.rebootedNodes`<br/>`DGAUGE`, count | Number of rebooted nodes |
| `yarn.cluster.reservedMB`<br/>`DGAUGE`, megabytes | Reserved memory |
| `yarn.cluster.reservedVirtualCores`<br/>`DGAUGE`, count | Number of reserved virtual cores |
| `yarn.cluster.shutdownNodes`<br/>`DGAUGE`, count | Number of dead nodes |
| `yarn.cluster.totalAllocatedContainersAcrossPartition`<br/>`DGAUGE`, count | Containers allocated across partitions |
| `yarn.cluster.totalMB`<br/>`DGAUGE`, megabytes | Total memory |
| `yarn.cluster.totalNodes`<br/>`DGAUGE`, count | Total nodes |
| `yarn.cluster.totalReservedResourcesAcrossPartition_memory`<br/>`DGAUGE` | Memory reserved across all partitions |
| `yarn.cluster.totalReservedResourcesAcrossPartition_resourceInformations_resourceInformation_0_maximumAllocation`<br/>`DGAUGE` | Maximum amount of type `0` resources reserved across all partitions |
| `yarn.cluster.totalReservedResourcesAcrossPartition_resourceInformations_resourceInformation_0_minimumAllocation`<br/>`DGAUGE` | Minimum amount of type `0` resources reserved across all partitions |
| `yarn.cluster.totalReservedResourcesAcrossPartition_resourceInformations_resourceInformation_0_value`<br/>`DGAUGE` | Current amount of type `0` resources reserved across all partitions |
| `yarn.cluster.totalReservedResourcesAcrossPartition_resourceInformations_resourceInformation_1_maximumAllocation`<br/>`DGAUGE` | Maximum amount of type `1` resources reserved across all partitions |
| `yarn.cluster.totalReservedResourcesAcrossPartition_resourceInformations_resourceInformation_1_minimumAllocation`<br/>`DGAUGE` | Minimum amount of type `1` resources reserved across all partitions |
| `yarn.cluster.totalReservedResourcesAcrossPartition_resourceInformations_resourceInformation_1_value`<br/>`DGAUGE` | Current amount of type `1` resources reserved across all partitions |
| `yarn.cluster.totalReservedResourcesAcrossPartition_vCores`<br/>`DGAUGE`, count | Virtual cores reserved across all partitions |
| `yarn.cluster.totalVirtualCores`<br/>`DGAUGE`, count | Total virtual cores |
| `yarn.cluster.unhealthyNodes`<br/>`DGAUGE`, count | Unhealthy nodes |
| `yarn.cluster.utilizedMBPercent`<br/>`DGAUGE`, % | Memory utilization |
| `yarn.cluster.utilizedVirtualCoresPercent`<br/>`DGAUGE`, % | Virtual core utilization |

## Other metrics {#data-proc-other-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `dataproc.cluster.health_status`<br/>`IGAUGE`, 0/1/2 | Cluster health and technical condition:<br/>`0`: Cluster is out of order (all of its hosts are down).<br/>`1`: Cluster is not running at its full capacity (the state of at least one of the hosts is other than `ALIVE`).<br/>`2`: Cluster is running normally. |
| `dataproc.cluster.neededAutoscalingNodesNumber`<br/>`DGAUGE`, count | {{ dataproc-full-name }} default scaling metric |