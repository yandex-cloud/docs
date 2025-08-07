## Quotas {#quotas}

#|
|| Type of limit | Value ||
|| Number of clusters per cloud | 5 ||
|| Total number of processor cores for all cluster components per cloud | 300 ||
|| Total HDD storage capacity | 18,432 GB ||
|| Total virtual memory for all cluster components per cloud | 762 GB ||
|| Total non-replicated SSD storage capacity | 5,022 GB ||
|| Total SSD storage capacity | 5,022 GB ||
|#

## Limits {#limits}

### Component configuration limits {#config-limits}

#### Exec nodes

| Type of limit                | Minimum value       | Maximum value      |
|:-------------------------------|:---------------------------|:---------------------------|
| Number of exec nodes per cluster | 1                          | 1,000                         |
| Exec node class                | c8-m32 (8 vCPUs, 32 GB RAM) | c80-m640 (80 vCPUs, 640 GB RAM) |
| HDD storage size | 10 GB | 102,400 GB |
| SSD storage size | 10 GB | 102,400 GB |
| Non-replicated SSD storage size | 93 GB | 102,393 GB |

#### Tablet nodes

| Type of limit                | Minimum value       | Maximum value      |
|:-------------------------------|:---------------------------|:---------------------------|
| Number of tablet nodes per cluster | 0 | 1,000 |
| Tablet node class              | c8-m16 (8 vCPUs, 16 GB RAM) | c32-m64 (32 vCPUs, 64 GB RAM) |
  
#### HTTP proxies

| Type of limit                | Minimum value       | Maximum value      |
|:-------------------------------|:---------------------------|:---------------------------|
| Number of HTTP proxies | 1 | 10 |

#### RPC proxies

| Type of limit                | Minimum value       | Maximum value      |
|:-------------------------------|:---------------------------|:---------------------------|
| Number of RPC proxies | 1 | 10 |

### Storage limits {#storage-limits}

#### HDD storage

| Type of limit                | Minimum value       | Maximum value      |
|:-------------------------------|:---------------------------|:---------------------------|
| Number of disks | 3 | 600 |
| Disk size | 10 GB | 102,400 GB |

#### SSD storage
  
| Type of limit                | Minimum value       | Maximum value      |
|:-------------------------------|:---------------------------|:---------------------------|
| Number of disks | 3 | 600 |
| Disk size | 10 GB | 102,400 GB |

#### Non-replicated SSD storage

| Type of limit                | Minimum value       | Maximum value      |
|:-------------------------------|:---------------------------|:---------------------------|
| Number of disks | 3 | 600 |
| Disk size | 93 GB | 102,393 GB |