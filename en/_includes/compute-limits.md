#### Quotas {#compute-quotas}


| Type of limit | Value |
--- | ---
| Number of [virtual machines](../compute/concepts/vm.md) per [cloud](../resource-manager/concepts/resources-hierarchy.md#cloud) | 12 |
| Total number of [vCPUs](../compute/concepts/performance-levels.md) across all VMs per cloud | 32 |
| Total number of vCPUs across all VMs per cloud in a {{ zone-id }} zone | 0 |
| Total number of vCPUs across all VMs per cloud on {{ highfreq-ice-lake }} | 0 |
| Total virtual memory across all VMs per cloud | 128 GB |
| Total number of [disks](../compute/concepts/disk.md) per cloud | 32 |
| Total number of disks per cloud per {{ zone-id }} zone | 0 |
| Total [HDD storage](../compute/concepts/disk.md#disks-types) capacity per cloud | 500 GB |
| Total SSD storage capacity per cloud | 200 GB |
| Total non-replicated SSD storage capacity per cloud | 558 GB |
| Total high-performance SSD storage capacity per cloud | 186 GB |
| Number of [non-replicated disk placement groups](../compute/concepts/disk-placement-group.md) per cloud | 5 |
| Total number of [disk snapshots](../compute/concepts/snapshot.md) per cloud | 32 |
| Total storage capacity of all disk snapshots per cloud | 400 GB |
| Number of [disk snapshot schedules](../compute/concepts/snapshot-schedule.md) per cloud | 32 |
| Total number of [file stores](../compute/concepts/filesystem.md) per cloud^1^ | 100 |
| Total number of file stores per cloud per {{ zone-id }} zone | 0 |
| Total [HDD](../compute/concepts/filesystem.md#types) file storage capacity per cloud^1^ | 0 B |
| Total SDD file storage capacity per cloud^1^ | 0 B |
| Number of [images](../compute/concepts/image.md) per cloud | 8 |
| Number of [images optimized for deployment](../compute/concepts/image.md#images-optimized-for-deployment) per cloud^1^ | 0 |
| Number of [instance groups](../compute/concepts/instance-groups/index.md) per cloud | 10 |
| Total number of NVIDIA® Tesla® V100 [GPUs](../compute/concepts/gpus.md) across all VMs per cloud | 0 |
| Total number of GPUs across all VMs per cloud on {{ a100-epyc }} | 0 |
| Total number of GPUs across all VMs per cloud on {{ t4-ice-lake }} | 0 |
| Number of concurrent [operations](../api-design-guide/concepts/operation.md) per [folder](../resource-manager/concepts/resources-hierarchy.md#folder) | 15 |
| Maximum number of [VM placement groups](../compute/concepts/placement-groups.md) per cloud | 2 |
| Maximum number of VMs per partition in a VM placement group with the [partition placement](../compute/concepts/placement-groups.md#partition) strategy | 100 |
| Number of [dedicated hosts](../compute/concepts/dedicated-host.md) per dedicated host group^1^ | 0 |
| Number of dedicated host groups per cloud | 6 |



^1^ To increase [quotas]({{ link-console-quotas }}) for file storage, deployment-optimized images, or dedicated hosts, contact [technical support]({{ link-console-support }}).

#### VM limits {#compute-limits-vm}

Limits per VM depend on the VM [platform](../compute/concepts/vm-platforms.md):

{% list tabs %}


- Intel Broadwell

   | Type of limit | Value |
   --- | ---
   | Maximum number of vCPUs per VM | 32 |
   | Maximum virtual memory per VM | Without GPU: 256 GB<br>With GPU: 384 GB |
   | Maximum number of disks and file stores attached to a single VM^2^ | 18 vCPUs or fewer: 8<br>More than 18 vCPUs: 16^3^ |
   | Maximum number of GPUs connected to a single VM | 4 |
   | Maximum number of [security groups](../vpc/concepts/security-groups.md) per interface | 5 |
   | Maximum number of VMs per VM placement group with the [spread placement](../compute/concepts/placement-groups.md#spread) strategy | 5 |

- Intel Cascade Lake

   | Type of limit | Value |
   --- | ---
   | Maximum number of vCPUs per VM | Without GPU: 80<br>With GPU: 64 |
   | Maximum virtual memory per VM | Without GPU: 1280 GB<br>With GPU: 384 GB |
   | Maximum number of disks and file stores attached to a single VM^2^ | 20 vCPUs or fewer: 8<br>More than 20 vCPUs: 16^3^ |
   | Maximum number of GPUs connected to a single VM | 8 |
   | Maximum number of [security groups](../vpc/concepts/security-groups.md) per interface | 5 |
   | Maximum number of VMs per VM placement group with the [spread placement](../compute/concepts/placement-groups.md#spread) strategy | 5 |


- Intel Ice Lake

   | Type of limit | Value |
   --- | ---
   | Maximum number of vCPUs per VM | 96 |
   | Maximum virtual memory per VM | 640 GB |
   | Maximum number of disks and file stores attached to a single VM^2^ | 32 vCPUs or fewer: 8<br>More than 32 vCPUs: 16^3^ |
   | Maximum number of [security groups](../vpc/concepts/security-groups.md) per interface | 5 |
   | Maximum number of VMs per VM placement group with the [spread placement](../compute/concepts/placement-groups.md#spread) strategy | 5 |


- Intel Ice Lake (Compute Optimized)

   | Type of limit | Value |
   --- | ---
   | Maximum number of vCPUs per VM | 56 |
   | Maximum virtual memory per VM | 448 GB |
   | Maximum number of disks and file stores attached to a single VM^2^ | 32 vCPUs or fewer: 8<br>More than 32 vCPUs: 16^3^ |
   | Maximum number of security groups per interface | 5 |
   | Maximum number of VMs per VM placement group with the [spread placement](../compute/concepts/placement-groups.md#spread) strategy | 5 |


{% endlist %}

^2^ Including the boot disk.

^3^ When a VM starts, a maximum of 14 devices, including the boot disk and a NIC, can be connected to it. You should connect other devices when your VM is already running. Please note that if you restart a VM with more than 14 devices connected, it will not be able to boot.

#### VM limits on disk operations {#compute-limits-vm-disks}

{% list tabs %}

- Network SSD

   | Type of limit | Value |
   --- | ---
   | Maximum^4^ [IOPS](../compute/concepts/storage-read-write.md) per vCPU | 3,500 |
   | Maximum^5^ [bandwidth](../compute/concepts/storage-read-write.md) per vCPU | 45 MB/s |

- Network HDD

   | Type of limit | Value |
   --- | ---
   | Maximum^4^ [IOPS](../compute/concepts/storage-read-write.md) per vCPU | 3,500 |
   | Maximum^5^ [bandwidth](../compute/concepts/storage-read-write.md) per vCPU | 45 MB/s |

- Non-replicated SSD

   | Type of limit | Value |
   --- | ---
   | Total number of non-replicated SSDs per placement group | 8 |
   | Maximum^4^ [IOPS](../compute/concepts/storage-read-write.md) per vCPU | 10,000 |
   | Maximum^4^ IOPS per VM | 100,000 |
   | Maximum^5^ [bandwidth](../compute/concepts/storage-read-write.md) per vCPU | 100 MB/s |
   | Maximum^5^ bandwidth per VM | 1 GB/s |

- High-performance SSD

   | Type of limit | Value |
   --- | ---
   | Total number of high-performance SSDs per placement group | 8 |
   | Maximum^4^ [IOPS](../compute/concepts/storage-read-write.md) per vCPU | 10,000 |
   | Maximum^4^ IOPS per VM | 100,000 |
   | Maximum^5^ [bandwidth](../compute/concepts/storage-read-write.md) per vCPU | 100 MB/s |
   | Maximum^5^ bandwidth per VM | 1 GB/s |

{% endlist %}

#### Disk and file storage limits {#compute-limits-disks}

{% list tabs %}

- Network SSD

   | Type of limit | Value |
   --- | ---
   | Maximum disk size | 256 TB |
   | [Allocation unit](../compute/concepts/storage-read-write.md) size | 32 GB |
   | Maximum^4^ IOPS for writes per disk | 40,000 |
   | Maximum^4^ IOPS for writes per allocation unit | 1,000 |
   | Maximum^5^ bandwidth for writes per disk | 450 MB/s |
   | Maximum^5^ bandwidth for writes per allocation unit | 15 MB/s |
   | Maximum^4^ IOPS for reads per disk | 20,000 |
   | Maximum^4^ IOPS for reads per allocation unit | 1,000 |
   | Maximum^5^ bandwidth for reads per disk | 450 MB/s |
   | Maximum^5^ bandwidth for reads per allocation unit | 15 MB/s |

- Network HDD

   | Type of limit | Value |
   --- | ---
   | Maximum disk size | 256 TB |
   | [Allocation unit](../compute/concepts/storage-read-write.md) size | 256 GB |
   | Maximum^4^ IOPS for writes per disk | 11,000 |
   | Maximum^4^ IOPS for writes per allocation unit | 300 |
   | Maximum^5^ bandwidth for writes per disk | 240 MB/s |
   | Maximum^5^ bandwidth for writes per allocation unit | 30 MB/s |
   | Maximum^4^ IOPS for reads per disk | 2,000 |
   | Maximum^4^ IOPS for reads per allocation unit | 300 |
   | Maximum^5^ bandwidth for reads per disk | 240 MB/s |
   | Maximum^5^ bandwidth for reads per allocation unit | 30 MB/s |

- Non-replicated SSD

   | Type of limit | Value |
   --- | ---
   | Minimum non-replicated disk size | 93 GB |
   | [Allocation unit](../compute/concepts/storage-read-write.md) size | 93 GB |
   | Maximum^4^ IOPS for writes per disk | 75,000 |
   | Maximum^4^ IOPS for writes per allocation unit | 5,600 |
   | Maximum^5^ bandwidth for writes per disk | 1 GB/s |
   | Maximum^5^ bandwidth for writes per allocation unit | 82 MB/s |
   | Maximum^4^ IOPS for reads per disk | 75,000 |
   | Maximum^4^ IOPS for reads per allocation unit | 28,000 |
   | Maximum^5^ bandwidth for reads per disk | 1 GB/s |
   | Maximum^5^ bandwidth for reads per allocation unit | 110 MB/s |

- High-performance SSD

   | Type of limit | Value |
   --- | ---
   | Minimum size of high-performance disk | 93 GB |
   | [Allocation unit](../compute/concepts/storage-read-write.md) size | 93 GB |
   | Maximum^4^ IOPS for writes per disk | 40,000 |
   | Maximum^4^ IOPS for writes per allocation unit | 5,600 |
   | Maximum^5^ bandwidth for writes per disk | 1 GB/s |
   | Maximum^5^ bandwidth for writes per allocation unit | 82 MB/s |
   | Maximum^4^ IOPS for reads per disk | 75,000 |
   | Maximum^4^ IOPS for reads per allocation unit | 28,000 |
   | Maximum^5^ bandwidth for reads per disk | 1 GB/s |
   | Maximum^5^ bandwidth for reads per allocation unit | 110 MB/s |

{% endlist %}


{% list tabs %}

- SSD storage

   | Type of limit | Value |
   --- | ---
   | Maximum storage size | 8 TB |
   | Allocation unit size | 32 GB |
   | Maximum number of files in storage | 1,000,000 |
   | Maximum size of file in storage | 300 GB |

- HDD storage

   | Type of limit | Value |
   --- | ---
   | Maximum storage size | 8 TB |
   | Allocation unit size | 256 GB |
   | Maximum number of files in storage | 1,000,000 |
   | Maximum size of file in storage | 300 GB |

{% endlist %}


Read and write operations utilize the same disk resource. The more read operations you do, the fewer write operations you can do, and vice versa. For more information, see [{#T}](../compute/concepts/storage-read-write.md).

^4^ To achieve maximum IOPS, we recommend performing read and write operations whose size is close to that of the disk block (4 KB by default).

^5^ To achieve the maximum possible bandwidth, we recommend performing 4 MB reads and writes.

#### Limits of disk snapshot schedules {#compute-limits-snapshot-schedule}

| Type of limit | Value |
--- | ---
| Number of disks included in a schedule | 1,000 |
| Number of schedules to add a disk to | 1,000 |