The `name` label contains the metric name.

All {{ managed-k8s-name }} metrics share the `service=managed-kubernetes` label.

## Container metrics {#managed-kubernetes-container-metrics}

Labels shared by all container metrics:

Label | Value
----|----
cluster_id | Cluster ID
container | Container name
namespace | Namespace name
pod | Pod name

Container metrics:

| Name<br/>Type, units | Description |
| ----- | ----- |
| `container.cpu.core_usage_time`<br/>`COUNTER`, milliseconds | Total CPU usage on all cores used by the container |
| `container.cpu.limit_cores`<br/>`DGAUGE`, % | Limit on the number of CPU cores in the container |
| `container.cpu.limit_utilization`<br/>`DGAUGE`, % | Container CPU limit utilization |
| `container.cpu.request_cores`<br/>`DGAUGE`, % | Number of CPU cores requested by the container |
| `container.cpu.request_utilization`<br/>`DGAUGE`, % | Utilization of CPU cores requested by the container |
| `container.ephemeral_storage.used_bytes`<br/>`IGAUGE`, bytes | Ephemeral storage usage |
| `container.memory.limit_bytes`<br/>`IGAUGE`, bytes | Container memory size limit |
| `container.memory.limit_utilization`<br/>`DGAUGE`, % | Container memory limit utilization |
| `container.memory.page_fault_count`<br/>`COUNTER`, bytes | Memory page faults, broken down by type: major and minor.<br/>Additional labels: `fault_type`. |
| `container.memory.request_bytes`<br/>`IGAUGE`, bytes | Memory requested by the container |
| `container.memory.request_utilization`<br/>`DGAUGE`, % | Utilization of memory requested by the container |
| `container.memory.used_bytes`<br/>`IGAUGE`, bytes | Used container memory |
| `container.memory.working_set_bytes`<br/>`IGAUGE`, bytes | Used container working set memory |
| `container.restart_count`<br/>`COUNTER`, count | Number of container restarts |
| `container.uptime_seconds`<br/>`DGAUGE`, milliseconds | Container uptime since its start |

## Master metrics {#managed-kubernetes-master-metrics}

Labels shared by all master metrics:

Label | Value
----|----
cluster_id | Cluster ID
host | Cluster ID

Master metrics:

| Name<br/>Type, units | Description |
| ----- | ----- |
| `master.cpu.utilization_percent`<br/>`DGAUGE`, % | CPU utilization |
| `master.memory.utilization_percent`<br/>`DGAUGE`, % | Memory utilization |

## Node metrics {#managed-kubernetes-node-metrics}

Labels shared by all node metrics:

Label | Value
----|----
cluster_id | Cluster ID
node | Node name

Node metrics:

| Name<br/>Type, units | Description |
| ----- | ----- |
| `node.cpu.allocatable_cores`<br/>`DGAUGE`, % | CPU resources available on the node |
| `node.cpu.core_usage_time`<br/>`COUNTER`, milliseconds | Total CPU load across all cores utilized by the node |
| `node.cpu.total_cores`<br/>`DGAUGE`, count | Total number of node processor cores |
| `node.ephemeral_storage.allocatable_bytes`<br/>`IGAUGE`, bytes | Ephemeral storage available on the node |
| `node.ephemeral_storage.inodes_free`<br/>`IGAUGE`, count | Number of free inodes |
| `node.ephemeral_storage.inodes_total`<br/>`IGAUGE`, count | Total inodes |
| `node.ephemeral_storage.total_bytes`<br/>`IGAUGE`, bytes | Ephemeral storage size |
| `node.ephemeral_storage.used_bytes`<br/>`IGAUGE`, bytes | Ephemeral storage used by the node |
| `node.memory.allocatable_bytes`<br/>`IGAUGE`, bytes | RAM available on the node |
| `node.memory.total_bytes`<br/>`IGAUGE`, bytes | Total node memory |
| `node.memory.used_bytes`<br/>`IGAUGE`, bytes | Memory used by the node |
| `node.memory.working_set_bytes`<br/>`IGAUGE`, bytes | Used node working set memory |
| `node.network.received_bytes_count`<br/>`COUNTER`, bytes | Inbound traffic (bytes received from the network) |
| `node.network.sent_bytes_count`<br/>`COUNTER`, bytes | Outbound traffic (bytes sent to the network) |
| `node.pid.limit`<br/>`IGAUGE`, count | Node process ID limit |
| `node.pid.used`<br/>`IGAUGE`, count | Process IDs used in the node |

## Pod metrics {#managed-kubernetes-pod-metrics}

Labels shared by all pod metrics:

Label | Value
----|----
cluster_id | Cluster ID
namespace | Namespace name
pod | Pod name

Pod metrics:

| Name<br/>Type, units | Description |
| ----- | ----- |
| `pod.cpu.core_usage_time`<br/>`COUNTER`, milliseconds | Total CPU usage on all cores used by the pod |
| `pod.ephemeral_storage.used_bytes`<br/>`IGAUGE`, bytes | Ephemeral storage used by the pod |
| `pod.memory.used_bytes`<br/>`IGAUGE`, bytes | Memory used by the pod |
| `pod.memory.working_set_bytes`<br/>`IGAUGE`, bytes | Used pod working set memory |
| `pod.network.received_bytes_count`<br/>`COUNTER`, bytes | Inbound traffic (bytes received from the network) |
| `pod.network.sent_bytes_count`<br/>`COUNTER`, bytes | Outbound traffic (bytes sent to the network) |
| `pod.volume.total_bytes`<br/>`IGAUGE`, bytes | Total size of the ephemeral volume.<br/>Additional labels: `volume`. |
| `pod.volume.used_bytes`<br/>`IGAUGE`, bytes | Ephemeral volume usage.<br/>Additional labels: `volume`. |
| `pod.volume.utilization`<br/>`DGAUGE`, % | Ephemeral volume utilization.<br/>Additional labels: `volume`. |

## Persistent volume metrics {#managed-kubernetes-persistent-volume-metrics}

Labels shared by all persistent volume metrics:

Label | Value
----|----
cluster_id | Cluster ID
namespace | Namespace name
persistentvolumeclaim | PVC name

Persistent volume metrics:

| Name<br/>Type, units | Description |
| ----- | ----- |
| `persistent_volume.inodes_free`<br/>`IGAUGE`, count | Number of free inodes |
| `persistent_volume.inodes_total`<br/>`IGAUGEE`, count | Total inodes |
| `persistent_volume.total_bytes`<br/>`IGAUGE`, bytes | Total size of the persistent volume |
| `persistent_volume.used_bytes`<br/>`IGAUGE`, bytes | Persistent volume usage |
| `persistent_volume.utilization`<br/>`DGAUGE`, % | Persistent volume utilization |