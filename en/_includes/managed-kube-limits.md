#### Quotas {#managed-k8s-quotas}

#|
|| Type of limit | Value ||
|| Total number of vCPUs across all masters per cloud
`managed-kubernetes.masterCores.count` | 60 ||
|| Total amount of RAM across all masters per cloud
`managed-kubernetes.masterMemory.size` | 240 GB ||
|| Total number of vCPUs across all nodes per cloud 
`managed-kubernetes.cores.count` | 240 ||
|| Total amount of RAM across all nodes per cloud 
`managed-kubernetes.memory.size` | 960 GB ||
|| Total disk storage capacity across all nodes per cloud 
`managed-kubernetes.disk.size` | 30,000 GB ||
|| Maximum number of {{ k8s }} clusters per cloud 
`managed-kubernetes.clusters.count` | 10 ||
|| Maximum number of node groups per cloud 
`managed-kubernetes.nodeGroups.count` | 160 ||
|| Maximum number of nodes per cloud 
`managed-kubernetes.nodes.count` | 160 ||
|| Maximum number of node groups per {{ k8s }} cluster | 16 ||
|| Maximum number of nodes per {{ k8s }} cluster | 32 ||
|#


#### Limits {#managed-k8s-limits}

Type of limit | Value
--- | ---
Maximum number of [volumes](../managed-kubernetes/concepts/volume.md) connected to a single node | 56