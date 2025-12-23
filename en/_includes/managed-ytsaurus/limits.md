#### Quotas {#quotas}

#|
|| Type of limit | Value ||
|| Number of clusters per cloud
`managed-ytsaurus.clusters.count` | 5 ||
|| Total number of processor cores for all cluster components per cloud
`managed-ytsaurus.cores.count` | 300 ||
|| Total HDD storage capacity
`managed-ytsaurus.hdd.size` | 18,432 GB ||
|| Total virtual memory for all cluster components per cloud
`managed-ytsaurus.memory.size` | 762 GB ||
|| Total non-replicated SSD storage capacity
`managed-ytsaurus.nrdssd.size` | 5,022 GB ||
|| Total SSD storage capacity
`managed-ytsaurus.ssd.size` | 5,022 GB ||
|| Total number of NVIDIA® Ampere® A100 [GPUs](../../compute/concepts/gpus.md) for all cluster components per cloud 
`managed-ytsaurus.a100-gpus.count` | 0 ||
|| Total number of NVIDIA® Tesla® T4 GPUs for all cluster components per cloud
`managed-ytsaurus.t4i-gpus.count` | 0 ||
|| Total number of NVIDIA® Tesla® V100 GPUs for all cluster components per cloud
`managed-ytsaurus.v100-gpus.count` | 0 ||
|#

#### Limits {#limits}

##### Component configuration limits {#config-limits}

**Exec nodes**

| Type of limit                | Minimum value       | Maximum value      |
|:-------------------------------|:---------------------------|:---------------------------|
| Number of exec nodes per cluster | 1                          | 1,000                         |
| Exec node class                | c8-m32 (8 vCPUs, 32 GB RAM) | c80-m640 (80 vCPUs, 640 GB RAM) |
| HDD storage size | 10 GB | 102,400 GB |
| SSD storage size | 10 GB | 102,400 GB |
| Non-replicated SSD storage size | 93 GB | 102,393 GB |

**Tablet nodes**

| Type of limit                | Minimum value       | Maximum value      |
|:-------------------------------|:---------------------------|:---------------------------|
| Number of tablet nodes per cluster | 0 | 1,000 |
| Tablet node class              | c8-m16 (8 vCPUs, 16 GB RAM) | c32-m64 (32 vCPUs, 64 GB RAM) |
  
**HTTP proxies**

| Type of limit                | Minimum value       | Maximum value      |
|:-------------------------------|:---------------------------|:---------------------------|
| Number of HTTP proxies | 1 | 10 |

**RPC proxies**

| Type of limit                | Minimum value       | Maximum value      |
|:-------------------------------|:---------------------------|:---------------------------|
| Number of RPC proxies | 1 | 10 |

##### Storage limits {#storage-limits}

**HDD storage**

| Type of limit                | Minimum value       | Maximum value      |
|:-------------------------------|:---------------------------|:---------------------------|
| Number of disks | 3 | 600 |
| Disk size | 10 GB | 102,400 GB |

**SSD storage**
  
| Type of limit                | Minimum value       | Maximum value      |
|:-------------------------------|:---------------------------|:---------------------------|
| Number of disks | 3 | 600 |
| Disk size | 10 GB | 102,400 GB |

**Non-replicated SSD storage**

| Type of limit                | Minimum value       | Maximum value      |
|:-------------------------------|:---------------------------|:---------------------------|
| Number of disks | 3 | 600 |
| Disk size | 93 GB | 102,393 GB |