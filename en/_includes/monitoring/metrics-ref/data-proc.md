## {{ dataproc-full-name }} {#data-proc}

Common labels for all {{ dataproc-name }} metrics:

| Label | Value |
----|----
| service | Service ID: `data-proc` |
| resource_type | Resource type: `cluster` |
| resource_id | Cluster ID |
| zone_id | Placement zone |
| host | Host FQDN |

### HDFS metrics {#data-proc-hdfs-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `dfs.cluster.Free_bytes`<br/>`DGAUGE`, bytes | Space available in HDFS. |
| `dfs.cluster.NonDfsUsedSpace_bytes`<br/>`DGAUGE`, bytes | Space used by data storage subclusters (DataNode), not available for HDFS. |
| `dfs.cluster.PercentRemaining`<br/>`DGAUGE`, % | Space available in HDFS. |
| `dfs.cluster.PercentUsed`<br/>`DGAUGE`, % | Space used in HDFS. |
| `dfs.cluster.Total_bytes`<br/>`DGAUGE`, bytes | HDFS size. |
| `dfs.cluster.Used_bytes`<br/>`DGAUGE`, bytes | Space used in HDFS. |

### Disk metrics {#data-proc-disk-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `system.disk.free_bytes`<br/>`DGAUGE`, bytes | Space available in system storage. |
| `system.disk.inodes_free`<br/>`DGAUGE`, pcs | Number of free index descriptors |
| `system.disk.inodes_total`<br/>`DGAUGE`, pcs | Total number of index descriptors |
| `system.disk.inodes_used`<br/>`DGAUGE`, pcs | Number of used index descriptors |
| `system.disk.total_bytes`<br/>`DGAUGE`, bytes | System storage size. |
| `system.disk.used_bytes`<br/>`DGAUGE`, bytes | Used disk space. |
| `system.disk.used_percent`<br/>`DGAUGE`, % | Used disk space. |

### YARN metrics {#data-proc-yarn-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `yarn.cluster.activeNodes`<br/>`DGAUGE`, pcs | Number of active nodes |
| `yarn.cluster.allocatedMB`<br/>`DGAUGE`, MB | Allocated memory. |
| `yarn.cluster.allocatedVirtualCores`<br/>`DGAUGE`, pcs | Number of allocated virtual cores. |
| `yarn.cluster.appsCompleted`<br/>`DGAUGE`, pcs | Apps that completed successfully. |
| `yarn.cluster.appsFailed`<br/>`DGAUGE`, pcs | Apps that failed. |
| `yarn.cluster.appsKilled`<br/>`DGAUGE`, pcs | Apps killed. |
| `yarn.cluster.appsPending`<br/>`DGAUGE`, pcs | Apps enqueued. |
| `yarn.cluster.appsRunning`<br/>`DGAUGE`, pcs | Apps running. |
| `yarn.cluster.appsSubmitted`<br/>`DGAUGE`, pcs | Apps started. |
| `yarn.cluster.availableMB`<br/>`DGAUGE`, MB | Available memory. |
| `yarn.cluster.availableVirtualCores`<br/>`DGAUGE`, pcs | Number of available virtual cores. |
| `yarn.cluster.containersAllocated`<br/>`DGAUGE`, pcs | Number of allocated containers. |
| `yarn.cluster.containersPending`<br/>`DGAUGE`, pcs | Containers enqueued. |
| `yarn.cluster.containersReserved`<br/>`DGAUGE`, pcs | Containers reserved. |
| `yarn.cluster.decommissionedNodes`<br/>`DGAUGE`, pcs | Nodes decommissioned. |
| `yarn.cluster.decommissioningNodes`<br/>`DGAUGE`, pcs | Nodes under decommissioning. |
| `yarn.cluster.lostNodes`<br/>`DGAUGE`, pcs | Nodes lost. |
| `yarn.cluster.rebootedNodes`<br/>`DGAUGE`, pcs | Nodes rebooted. |
| `yarn.cluster.reservedMB`<br/>`DGAUGE`, MB | Reserved memory. |
| `yarn.cluster.reservedVirtualCores`<br/>`DGAUGE`, pcs | Number of reserved virtual cores. |
| `yarn.cluster.shutdownNodes`<br/>`DGAUGE`, pcs | Nodes shut down. |
| `yarn.cluster.totalAllocatedContainersAcrossPartition`<br/>`DGAUGE`, pcs | Containers allocated across partitions. |
| `yarn.cluster.totalMB`<br/>`DGAUGE`, MB | Total memory. |
| `yarn.cluster.totalNodes`<br/>`DGAUGE`, pcs | Total number of nodes. |
| `yarn.cluster.totalReservedResourcesAcrossPartition_memory`<br/>`DGAUGE` | Memory reserved across partitions. |
| `yarn.cluster.totalReservedResourcesAcrossPartition_vCores`<br/>`DGAUGE`, pcs | Virtual cores reserved across partitions. |
| `yarn.cluster.totalVirtualCores`<br/>`DGAUGE`, pcs | Total number of virtual cores. |
| `yarn.cluster.unhealthyNodes`<br/>`DGAUGE`, pcs | Unhealthy nodes. |
| `yarn.cluster.utilizedMBPercent`<br/>`DGAUGE`, % | Utilized memory. |
| `yarn.cluster.utilizedVirtualCoresPercent`<br/>`DGAUGE`, % | Utilized virtual cores. |

### Other metrics {#data-proc-other-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `dataproc.cluster.neededAutoscalingNodesNumber`<br/>`DGAUGE`, pcs | {{ dataproc-full-name }} service metric for scaling by default. |

Read more about the service in the [{{ dataproc-name }}](../../../data-proc/) documentation.
