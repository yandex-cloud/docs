#### Quotas {#managed-k8s-quotas}

Limit type | Value
--- | ---
Total number of vCPUs across all masters per cloud | 60
Total amount of RAM across all masters per cloud | 240 GB
Total number of vCPUs across all nodes per cloud | 192
Total amount of RAM across all nodes per cloud | 384 GB
Total disk storage capacity across all nodes per cloud | 32 TB
Maximum number of {{ k8s }} clusters per cloud | 8
Maximum number of node groups per cloud | 32
Maximum number of nodes per cloud | 160
Maximum number of node groups per {{ k8s }} cluster | 16
Maximum number of nodes per {{ k8s }} cluster | 32

#### Limits {#managed-k8s-limits}

Limit type | Value
--- | ---
Maximum number of [volumes](../managed-kubernetes/concepts/volume.md) connected to a single node | 56