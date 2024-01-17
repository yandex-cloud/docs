All {{ managed-k8s-name }} metrics share the `service=managed-kubernetes` label.

### Container metrics {#managed-kubernetes-container-metrics}

Common labels for all container metrics:

| Label | Value |
----|----
| cluster-id | Cluster name |
| container | Container name |
| namespace | Namespace name |
| pod | Pod name |

Container metrics:

| Name<br/>Type, units | Description |
| ----- | ----- |
| `container.cpu.core_usage_time`<br/>`COUNTER`, milliseconds | Total CPU usage on all cores used by the container |
| `container.cpu.limit_cores`<br/>`DGAUGE`, % | Limit on the number of CPU cores per container |
| `container.cpu.limit_utilization`<br/>`DGAUGE`, % | CPU core utilization |
| `container.cpu.request_cores`<br/>`DGAUGE`, % | Number of CPU cores requested by the container |
| `container.cpu.request_utilization`<br/>`DGAUGE`, % | Utilization of CPU cores requested by the container |
| `container.ephemeral_storage.used_bytes`<br/>`IGAUGE`, bytes | Ephemeral storage usage |
| `container.memory.limit_bytes`<br/>`IGAUGE`, bytes | Limit on the amount of container memory |
| `container.memory.limit_utilization`<br/>`DGAUGE`, % | Utilized container memory |
| `container.memory.page_fault_count`<br/>`COUNTER`, bytes | Memory page errors by type: major and minor.<br/>Additional labels: `fault_type`. |
| `container.memory.request_bytes`<br/>`IGAUGE`, bytes | Amount of memory requested by the container |
| `container.memory.request_utilization`<br/>`DGAUGE`, % | Utilization of memory requested by the container |
| `container.memory.used_bytes`<br/>`IGAUGE`, bytes | Memory usage by the container |
| `container.memory.working_set_bytes`<br/>`IGAUGE`, bytes | Container working set memory used |
| `container.restart_count`<br/>`COUNTER`, pcs | Number of container restarts |
| `container.uptime_seconds`<br/>`DGAUGE`, milliseconds | Container uptime since its start |

### Master metrics {#managed-kubernetes-master-metrics}

Common labels for all master metrics:

| Label | Value |
----|----
| cluster-id | Cluster name |
| host | Cluster ID |

Master metrics:

| Name<br/>Type, units | Description |
| ----- | ----- |
| `master.cpu.utilization_percent`<br/>`DGAUGE`, % | CPU utilization |
| `master.memory.utilization_percent`<br/>`DGAUGE`, % | Utilized memory |

### Node metrics {#managed-kubernetes-node-metrics}

Common labels for all node metrics:

| Label | Value |
----|----
| cluster-id | Cluster name |
| node | Node name |

Node metrics:

| Name<br/>Type, units | Description |
| ----- | ----- |
| `node.cpu.allocatable_cores`<br/>`DGAUGE`, % | Amount of CPU resources available on the node |
| `node.cpu.core_usage_time`<br/>`COUNTER`, milliseconds | Total CPU usage on all cores used by the node |
| `node.cpu.total_cores`<br/>`DGAUGE`, pcs | Total number of node processor cores |
| `node.ephemeral_storage.allocatable_bytes`<br/>`IGAUGE`, bytes | Amount of ephemeral storage resources available on the node |
| `node.ephemeral_storage.inodes_free`<br/>`IGAUGE`, pcs | Number of free index descriptors |
| `node.ephemeral_storage.inodes_total`<br/>`IGAUGE`, pcs | Total number of index descriptors |
| `node.ephemeral_storage.total_bytes`<br/>`IGAUGE`, bytes | Ephemeral storage size |
| `node.ephemeral_storage.used_bytes`<br/>`IGAUGE`, bytes | Ephemeral storage used by the node |
| `node.memory.allocatable_bytes`<br/>`IGAUGE`, bytes | Amount of RAM resources available on the node |
| `node.memory.total_bytes`<br/>`IGAUGE`, bytes | Total amount of node memory |
| `node.memory.used_bytes`<br/>`IGAUGE`, bytes | Memory used by the node |
| `node.memory.working_set_bytes`<br/>`IGAUGE`, bytes | Node working set memory used |
| `node.network.received_bytes_count`<br/>`COUNTER`, bytes | Incoming traffic (bytes received from the network) |
| `node.network.sent_bytes_count`<br/>`COUNTER`, bytes | Outgoing traffic (bytes sent to the network) |
| `node.pid.limit`<br/>`IGAUGE`, pcs | Limit on the number of process IDs per node |
| `node.pid.used`<br/>`IGAUGE`, pcs | Process IDs used in the node |

### Pod metrics {#managed-kubernetes-pod-metrics}

Common labels for all pod metrics:

| Label | Value |
----|----
| cluster-id | Cluster name |
| namespace | Namespace name |
| pod | Pod name |

Pod metrics:

| Name<br/>Type, units | Description |
| ----- | ----- |
| `pod.cpu.core_usage_time`<br/>`COUNTER`, milliseconds | Total CPU usage on all cores used by the pod |
| `pod.ephemeral_storage.used_bytes`<br/>`IGAUGE`, bytes | Ephemeral storage used by the pod |
| `pod.memory.used_bytes`<br/>`IGAUGE`, bytes | Memory used by the pod |
| `pod.memory.working_set_bytes`<br/>`IGAUGE`, bytes | Pod working set memory used |
| `pod.network.received_bytes_count`<br/>`COUNTER`, bytes | Incoming traffic (bytes received from the network) |
| `pod.network.sent_bytes_count`<br/>`COUNTER`, bytes | Outgoing traffic (bytes sent to the network) |
| `pod.volume.total_bytes`<br/>`IGAUGE`, bytes | Total size of temporary volume.<br/>Additional labels: `volume`. |
| `pod.volume.used_bytes`<br/>`IGAUGE`, bytes | Temporary volume usage.<br/>Additional labels: `volume`. |
| `pod.volume.utilization`<br/>`DGAUGE`, % | Temporary volume utilization.<br/>Additional labels: `volume`. |

### Persistent volume metrics {#managed-kubernetes-persistent-volume-metrics}

Common labels for all persistent volume metrics:

| Label | Value |
----|----
| cluster-id | Cluster name |
| namespace | Namespace name |
| persistentvolumeclaim | Persistent volume claim name |

Persistent volume metrics:

| Name<br/>Type, units | Description |
| ----- | ----- |
| `persistent_volume.inodes_free`<br/>`IGAUGE`, pcs | Number of free index descriptors |
| `persistent_volume.inodes_total`<br/>`IGAUGEE`, pcs | Total number of index descriptors |
| `persistent_volume.total_bytes`<br/>`IGAUGE`, bytes | Total size of the persistent volume |
| `persistent_volume.used_bytes`<br/>`IGAUGE`, bytes | Persistent volume usage |
| `persistent_volume.utilization`<br/>`DGAUGE`, % | Persistent volume utilization |
