#### Quotas {#compute-quotas}

| Limits | Value |
| ----- | ----- |
| Number of virtual machines per cloud | 12 |
| Total number of vCPUs for all VMs per cloud | 32 |
| Total virtual memory for all VMs per cloud | 128 GB |
| Total number of disks per cloud | 32 |
| Total HDD storage capacity per cloud | 500 GB |
| Total SSD storage capacity per cloud | 200 GB |
| Total SSD storage capacity per cloud | 558 GB |
| Number of non-replicated disk placement groups per cloud | 5 |
| Total number of disk snapshots per cloud | 32 |
| Total storage capacity of all disk snapshots per cloud | 400 GB |
| Total number of file stores per cloud^1^  | 100 |
| Total file storage capacity per cloud^1^  | 0 B |
| Number of images per cloud | 8 |
| Number of images optimized for deployment per cloud^1^ | 0 |
| Number of instance groups per cloud | 10 |
| Total number of GPUs and vGPUs for all VMs per cloud^1^ | 0 |
| Number of concurrent [operations](../api-design-guide/concepts/operation.md) per folder | 15 |
| Maximum number of [placement groups](../compute/concepts/placement-groups.md) per cloud | 2 |
| Number of dedicated hosts per dedicated host group^1^ | 0 |
| Number of dedicated host groups per cloud | 0 |

^1^ To increase quotas for file storages, VMs with GPUs, images optimized for deployment, or dedicated hosts, contact [technical support]({{ link-console-support }}).

#### VM limits {#compute-limits-vm}

The limits per VM depend on its [platform](../compute/concepts/vm-platforms.md):

{% list tabs %}

- Intel Broadwell

  | Limits | Value |
  | ----- | ----- |
  | Maximum number of vCPUs per VM | Without [vGPU](../compute/concepts/gpus.md#vgpu): 32<br>With vGPU: 4 |
  | Maximum virtual memory per VM | Without [GPU](../compute/concepts/gpus.md#gpu) and vGPU: 256 GB<br>With GPU: 384 GB<br>With vGPU: 12 GB |
  | Maximum number of disks and file stores attached to a single VM^2^ | Less than 18 vCPUs: 8<br>From 18 vCPUs: 16 |
  | Maximum number of GPUs connected to a single VM | 4 |
  | Maximum number of vGPUs connected to a VM | 1 |
  | Maximum number of security groups per interface | 5 |
  | Maximum number of VM instances in a [placement group](../compute/concepts/placement-groups.md) | 5 |

- Intel Cascade Lake

  | Limits | Value |
  | ----- | ----- |
  | Maximum number of vCPUs per VM | Without [GPU](../compute/concepts/gpus.md#gpu): 80<br>With GPU: 64 |
  | Maximum virtual memory per VM | Without GPU: 640 GB<br>With GPU: 384 GB |
  | Maximum number of disks and file stores attached to a single VM^2^ | Less than 20 vCPUs: 8<br>From 20 vCPUs: 16 |
  | Maximum number of GPUs connected to a single VM | 8 |
  | Maximum number of security groups per interface | 5 |
  | Maximum number of VM instances in a [placement group](../compute/concepts/placement-groups.md) | 5 |

- Intel Ice Lake

  | Limits | Value |
  | ----- | ----- |
  | Maximum number of vCPUs per VM | 96 |
  | Maximum virtual memory per VM | 640 GB |
  | Maximum number of disks and file stores attached to a single VM^2^ | Less than 32 vCPUs: 8<br>From 32 vCPUs: 16 |
  | Maximum number of security groups per interface | 5 |
  | Maximum number of VM instances in a [placement group](../compute/concepts/placement-groups.md) | 5 |

{% endlist %}

^2^ Including the boot disk.

#### VM limits on operations with non-replicated disks {#compute-limits-vm-nonrepl}

| Limits | Value |
| ----- | ----- |
| Total number of non-replicated SSDs per placement group | 5 |
| Maximum^3^ [IOPS](../compute/concepts/storage-read-write.md) per vCPU | 10,000 |
| Maximum^3^ IOPS per VM | 100,000 |
| Maximum^4^ [bandwidth](../compute/concepts/storage-read-write.md) per vCPU | 100 MB/s |
| Maximum^4^ bandwidth per VM | 1 GB/s |

#### Disk and file storage limits {#compute-limits-disks}

{% list tabs %}

- Network SSD

    | Limits | Value |
    | ----- | ----- |
    | Maximum disk size | 4 TB |
    | Maximum disk snapshot size | 4 TB |
    | [Allocation unit size](../compute/concepts/storage-read-write.md) | 32 GB |
    | Maximum^3^ [IOPS](../compute/concepts/storage-read-write.md) for writes per disk | 40,000 |
    | Maximum^3^ IOPS for writes per allocation unit | 1000 |
    | Maximum^4^ [bandwidth](../compute/concepts/storage-read-write.md) for writes per disk | 450 MB/s |
    | Maximum^4^ bandwidth for writes per allocation unit | 15 MB/s |
    | Maximum^3^ IOPS for reads per disk | 12,000 |
    | Maximum^3^ IOPS for reads per allocation unit | 400 |
    | Maximum^4^ bandwidth for reads per disk | 450 MB/s |
    | Maximum^4^ bandwidth for reads per allocation unit | 15 MB/s |

- Network HDD

    | Limits | Value |
    | ----- | ----- |
    | Maximum disk snapshot size | 4 TB |
    | [Allocation unit size](../compute/concepts/storage-read-write.md) | 256 GB |
    | Maximum^3^ [IOPS](../compute/concepts/storage-read-write.md) for writes per disk | 11,000 |
    | Maximum^3^ IOPS for writes per allocation unit | 300 |
    | Maximum^4^ [bandwidth](../compute/concepts/storage-read-write.md) for writes per disk | 240 MB/s |
    | Maximum^4^ bandwidth for writes per allocation unit | 30 MB/s |
    | Maximum^3^ IOPS for reads per disk | 300 |
    | Maximum^3^ IOPS for reads per allocation unit | 100 |
    | Maximum^4^ bandwidth for reads per disk | 240 MB/s |
    | Maximum^4^ bandwidth for reads per allocation unit | 30 MB/s |

- Non-replicated SSD

    | Limits | Value |
    | ----- | ----- |
    | Minimum non-replicated disk size | 93 GB |
    | [Allocation unit size](../compute/concepts/storage-read-write.md) | 93 GB |
    | Maximum^3^ [IOPS](../compute/concepts/storage-read-write.md) for writes per disk | 50,000 |
    | Maximum^3^ IOPS for writes per allocation unit | 5600 |
    | Maximum^4^ [bandwidth](../compute/concepts/storage-read-write.md) for writes per disk | 1 GB/s |
    | Maximum^4^ bandwidth for writes per allocation unit | 82 MB/s |
    | Maximum^3^ IOPS for reads per disk | 50,000 |
    | Maximum^3^ IOPS for reads per allocation unit | 28,000 |
    | Maximum^4^ bandwidth for reads per disk | 1 GB/s |
    | Maximum^4^ bandwidth for reads per allocation unit | 110 MB/s |

{% endlist %}

{% list tabs %}

- SSD storage

    | Limits | Value |
    | ----- | ----- |
    | Maximum storage size | 8 TB |
    | [Allocation unit size](../compute/concepts/storage-read-write.md) | 32 GB |
    | Maximum number of files in storage | 1,000,000 |
    | Maximum size of one file in storage | 8 TB |

- HDD storage

    | Limits | Value |
    | ----- | ----- |
    | Maximum storage size | 8 TB |
    | [Allocation unit size](../compute/concepts/storage-read-write.md) | 256 GB |
    | Maximum number of files in storage | 1,000,000 |
    | Maximum size of one file in storage | 8 TB |

{% endlist %}

Read and write operations utilize the same disk resource. The more read operations you do, the fewer write operations you can do, and vice versa. For more information, see [{#T}](../compute/concepts/storage-read-write.md).

^3^ To achieve maximum IOPS, we recommend performing read and write operations whose size is close to that of the disk block (4 KB by default).

^4^ To achieve the maximum possible bandwidth, we recommend performing 4 MB reads and writes.

