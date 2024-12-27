The name of the metric is written to the `name` label.

Common labels for all {{ dataproc-name }} metrics:

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
| `dfs.cluster.NonDfsUsedSpace_bytes`<br/>`DGAUGE`, bytes | Space used by data storage subclusters (DataNode), not available for HDFS |
| `dfs.cluster.PercentRemaining`<br/>`DGAUGE`, % | Space available in HDFS |
| `dfs.cluster.PercentUsed`<br/>`DGAUGE`, % | Space used in HDFS |
| `dfs.cluster.Total_bytes`<br/>`DGAUGE`, bytes | HDFS size |
| `dfs.cluster.Used_bytes`<br/>`DGAUGE`, bytes | Space used in HDFS |

## Disk metrics {#data-proc-disk-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `system.disk.free_bytes`<br/>`DGAUGE`, bytes | Space available in system storage |
| `system.disk.inodes_free`<br/>`DGAUGE`, number | Number of free index descriptors |
| `system.disk.inodes_total`<br/>`DGAUGE`, number | Total number of index descriptors |
| `system.disk.inodes_used`<br/>`DGAUGE`, number | Number of used index descriptors |
| `system.disk.inodes_used_percent`<br/>`DGAUGE`, % | Percentage of used index descriptors |
| `system.disk.total_bytes`<br/>`DGAUGE`, bytes | System storage size |
| `system.disk.used_bytes`<br/>`DGAUGE`, bytes | Used disk space |
| `system.disk.used_percent`<br/>`DGAUGE`, % | Used disk space |

## YARN metrics {#data-proc-yarn-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `yarn.cluster.activeNodes`<br/>`DGAUGE`, number | Number of active nodes |
| `yarn.cluster.allocatedMB`<br/>`DGAUGE`, megabytes | Allocated memory |
| `yarn.cluster.allocatedVirtualCores`<br/>`DGAUGE`, number | Number of allocated virtual cores |
| `yarn.cluster.appsCompleted`<br/>`DGAUGE`, number | Apps completed successfully |
| `yarn.cluster.appsFailed`<br/>`DGAUGE`, number | Apps failed |
| `yarn.cluster.appsKilled`<br/>`DGAUGE`, number | Apps killed |
| `yarn.cluster.appsPending`<br/>`DGAUGE`, number | Apps enqueued |
| `yarn.cluster.appsRunning`<br/>`DGAUGE`, number | Apps running |
| `yarn.cluster.appsSubmitted`<br/>`DGAUGE`, number | Apps started |
| `yarn.cluster.availableMB`<br/>`DGAUGE`, megabytes | Available memory |
| `yarn.cluster.availableVirtualCores`<br/>`DGAUGE`, number | Number of available virtual cores |
| `yarn.cluster.containersAllocated`<br/>`DGAUGE`, number | Number of allocated containers |
| `yarn.cluster.containersPending`<br/>`DGAUGE`, number | Containers enqueued |
| `yarn.cluster.containersReserved`<br/>`DGAUGE`, number | Containers reserved |
| `yarn.cluster.decommissionedNodes`<br/>`DGAUGE`, number | Nodes decommissioned |
| `yarn.cluster.decommissioningNodes`<br/>`DGAUGE`, number | Nodes under decommissioning |
| `yarn.cluster.lostNodes`<br/>`DGAUGE`, number | Nodes lost |
| `yarn.cluster.rebootedNodes`<br/>`DGAUGE`, number | Nodes rebooted |
| `yarn.cluster.reservedMB`<br/>`DGAUGE`, megabytes | Reserved memory |
| `yarn.cluster.reservedVirtualCores`<br/>`DGAUGE`, number | Number of reserved virtual cores |
| `yarn.cluster.shutdownNodes`<br/>`DGAUGE`, number | Nodes shut down |
| `yarn.cluster.totalAllocatedContainersAcrossPartition`<br/>`DGAUGE`, number | Containers allocated across partitions |
| `yarn.cluster.totalMB`<br/>`DGAUGE`, megabytes | Total memory |
| `yarn.cluster.totalNodes`<br/>`DGAUGE`, number | Total number of nodes |
| `yarn.cluster.totalReservedResourcesAcrossPartition_memory`<br/>`DGAUGE` | Memory reserved across partitions |
| `yarn.cluster.totalReservedResourcesAcrossPartition_resourceInformations_resourceInformation_0_maximumAllocation`<br/>`DGAUGE` | Maximum amount of type `0` resources reserved in all partitions |
| `yarn.cluster.totalReservedResourcesAcrossPartition_resourceInformations_resourceInformation_0_minimumAllocation`<br/>`DGAUGE` | Minimum amount of type `0` resources reserved in all partitions |
| `yarn.cluster.totalReservedResourcesAcrossPartition_resourceInformations_resourceInformation_0_value`<br/>`DGAUGE` | Current amount of type `0` resources reserved in all partitions |
| `yarn.cluster.totalReservedResourcesAcrossPartition_resourceInformations_resourceInformation_1_maximumAllocation`<br/>`DGAUGE` | Maximum amount of type `1` resources reserved in all partitions |
| `yarn.cluster.totalReservedResourcesAcrossPartition_resourceInformations_resourceInformation_1_minimumAllocation`<br/>`DGAUGE` | Minimum amount of type `1` resources reserved in all partitions |
| `yarn.cluster.totalReservedResourcesAcrossPartition_resourceInformations_resourceInformation_1_value`<br/>`DGAUGE` | Current amount of type `1` resources reserved in all partitions |
| `yarn.cluster.totalReservedResourcesAcrossPartition_vCores`<br/>`DGAUGE`, number | Virtual cores reserved across partitions |
| `yarn.cluster.totalVirtualCores`<br/>`DGAUGE`, number | Total number of virtual cores |
| `yarn.cluster.unhealthyNodes`<br/>`DGAUGE`, number | Unhealthy nodes |
| `yarn.cluster.utilizedMBPercent`<br/>`DGAUGE`, % | Utilized memory |
| `yarn.cluster.utilizedVirtualCoresPercent`<br/>`DGAUGE`, % | Utilized virtual cores |

## Other metrics {#data-proc-other-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `dataproc.cluster.health_status`<br/>`IGAUGE`, 0/1/2 | Cluster health and technical condition:<br/>`0`: Cluster is out of order (all of its hosts are down).<br/>`1`: Cluster is not running at its full capacity (the state of at least one of the hosts is other than `ALIVE`).<br/>`2`: Cluster is operating normally. |
| `dataproc.cluster.neededAutoscalingNodesNumber`<br/>`DGAUGE`, number | {{ dataproc-full-name }} service metric for scaling by default |