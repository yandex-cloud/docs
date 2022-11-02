#### Quotas {#compute-quotas}



| Type of limit | Value |
--- | ---
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
| The number of [disk snapshot schedules](../compute/concepts/snapshot-schedule.md) in one cloud | 32 |
| Total number of file stores per cloud^1^ | 100 |
| Total HDD file storage capacity per cloud^1^ | 0 B |
| Total SDD file storage capacity per cloud^1^ | 0 B |
| Number of images per cloud | 8 |
| Number of images optimized for deployment per cloud^1^ | 0 |
| Number of instance groups per cloud | 10 |
| The number of GPUs for all VMs per cloud^1^ | 0 |
| Number of concurrent [operations](../api-design-guide/concepts/operation.md) per folder | 15 |
| Maximum number of [placement groups](../compute/concepts/placement-groups.md) per cloud | 2 |
| Number of dedicated hosts per dedicated host group^1^ | 0 |
| Number of dedicated host groups per cloud | 0 |




^1^ To increase [quotas]({{ link-console-quotas }}) for file storage, virtual machines with GPUs, deployment-optimized images, or dedicated hosts, please contact [technical support]({{ link-console-support }}).

#### VM limits {#compute-limits-vm}

Limits per virtual machine depend on the virtual machine [platform](../compute/concepts/vm-platforms.md):

{% list tabs %}



- Intel Broadwell

   | Type of limit | Value |
   --- | ---
   | Maximum number of vCPUs per VM | 32 |
   | Maximum virtual memory per VM | Without [GPU](../compute/concepts/gpus.md#gpu): 256 GB<br>With GPU: 384 GB |
   | Maximum number of disks and file stores attached to a single VM^2^ | Less than 18 vCPUs: 8<br>From 18 vCPUs: 16^3^ |
   | Maximum number of GPUs connected to a single VM | 4 |
   | Maximum number of security groups per interface | 5 |
   | Maximum number of VMs in a single [placement group](../compute/concepts/placement-groups.md) | 5 |

- Intel Cascade Lake

   | Type of limit | Value |
   --- | ---
   | Maximum number of vCPUs per VM | Without [GPU](../compute/concepts/gpus.md#gpu): 80<br>With GPU: 64 |
   | Maximum virtual memory per VM | Without GPU: 640 GB<br>With GPU: 384 GB |
   | Maximum number of disks and file stores attached to a single VM^2^ | Less than 20 vCPUs: 8<br>From 20 vCPUs: 16^3^ |
   | Maximum number of GPUs connected to a single VM | 8 |
   | Maximum number of security groups per interface | 5 |
   | Maximum number of VMs in a single [placement group](../compute/concepts/placement-groups.md) | 5 |


- Intel Ice Lake

   | Type of limit | Value |
   --- | ---
   | Maximum number of vCPUs per VM | 96 |
   | Maximum virtual memory per VM | 640 GB |
   | Maximum number of disks and file stores attached to a single VM^2^ | Less than or equal to 32 vCPUs: 8<br>More than 32 vCPUs: 16^3^ |
   | Maximum number of security groups per interface | 5 |
   | Maximum number of VMs in a single [placement group](../compute/concepts/placement-groups.md) | 5 |

{% endlist %}

^2^ Including the boot disk.

^3^ When starting a VM, a maximum of 14 devices, including the boot disk and a NIC, can be connected to it. Other devices must be connected to a running VM. Please note that, if you restart a VM with more than 14 devices connected, it won't be able to load and run.

#### VM limits on operations with non-replicated disks {#compute-limits-vm-nonrepl}

| Type of limit | Value |
--- | ---
| Total number of non-replicated SSDs per placement group | 8 |
| Maximum^4^ [IOPS](../compute/concepts/storage-read-write.md) per vCPU | 10,000 |
| Maximum^4^ IOPS per VM | 100,000 |
| Maximum^5^ [bandwidth](../compute/concepts/storage-read-write.md) per vCPU | 100 MB/s |
| Maximum^5^ bandwidth per VM | 1 GB/s |

#### Disk and file storage limits {#compute-limits-disks}

{% list tabs %}

- Network SSD

   | Type of limit | Value |
   --- | ---
   | Maximum disk size | 256 TB |
   | [Allocation unit](../compute/concepts/storage-read-write.md) size | 32 GB |
   | Maximum^4^ [IOPS](../compute/concepts/storage-read-write.md) for writes per disk | 40000 |
   | Maximum^4^ IOPS for writes per allocation unit | 1000 |
   | Maximum^5^ [bandwidth](../compute/concepts/storage-read-write.md) for writes per disk | 450 MB/s |
   | Maximum^5^ bandwidth for writes per allocation unit | 15 MB/s |
   | Maximum^4^ IOPS for reads per disk | 20 000 |
   | Maximum^4^ IOPS for reads per allocation unit | 1000 |
   | Maximum^5^ bandwidth for reads per disk | 450 MB/s |
   | Maximum^5^ bandwidth for reads per allocation unit | 15 MB/s |

- Network HDD

   | Type of limit | Value |
   --- | ---
   | Maximum disk size | 256 TB |
   | [Allocation unit](../compute/concepts/storage-read-write.md) size | 256 GB |
   | Maximum^4^ [IOPS](../compute/concepts/storage-read-write.md) for writes per disk | 11000 |
   | Maximum^4^ IOPS for writes per allocation unit | 300 |
   | Maximum^5^ [bandwidth](../compute/concepts/storage-read-write.md) for writes per disk | 240 MB/s |
   | Maximum^5^ bandwidth for writes per allocation unit | 30 MB/s |
   | Maximum^4^ IOPS for reads per disk | 2000 |
   | Maximum^4^ IOPS for reads per allocation unit | 300 |
   | Maximum^5^ bandwidth for reads per disk | 240 MB/s |
   | Maximum^5^ bandwidth for reads per allocation unit | 30 MB/s |

- Non-replicated SSD

   | Type of limit | Value |
   --- | ---
   | Minimum non-replicated disk size | 93 GB |
   | [Allocation unit](../compute/concepts/storage-read-write.md) size | 93 GB |
   | Maximum^4^ [IOPS](../compute/concepts/storage-read-write.md) for writes per disk | 75 000<br>(achievable for<br> connections via vhost,<br> otherwise a maximum of 50000) |
   | Maximum^4^ IOPS for writes per allocation unit | 5600 |
   | Maximum^5^ [bandwidth](../compute/concepts/storage-read-write.md) for writes per disk | 1 GB/s |
   | Maximum^5^ bandwidth for writes per allocation unit | 82 MB/s |
   | Maximum^4^ IOPS for reads per disk | 75 000<br>(achievable for<br> connections via vhost,<br> otherwise a maximum of 50000) |
   | Maximum^4^ IOPS for reads per allocation unit | 28,000 |
   | Maximum^5^ bandwidth for reads per disk | 1 GB/s |
   | Maximum^5^ bandwidth for reads per allocation unit | 110 MB/s |

{% endlist %}



{% list tabs %}

- SSD storage

   | Type of limit | Value |
   --- | ---
   | Maximum storage size | 8 TB |
   | [Allocation unit](../compute/concepts/storage-read-write.md) size | 32 GB |
   | Maximum number of files in storage | 1000000 |
   | Maximum size of one file in storage | 300 GB |

- HDD storage

   | Type of limit | Value |
   --- | ---
   | Maximum storage size | 8 TB |
   | [Allocation unit](../compute/concepts/storage-read-write.md) size | 256 GB |
   | Maximum number of files in storage | 1000000 |
   | Maximum size of one file in storage | 300 GB |

{% endlist %}


Read and write operations utilize the same disk resource. The more read operations you do, the fewer write operations you can do, and vice versa. For more information, see [{#T}](../compute/concepts/storage-read-write.md).

^4^ To achieve maximum IOPS, we recommend performing read and write operations whose size is close to that of the disk block (4 KB by default).

^5^ To achieve the maximum possible bandwidth, we recommend performing 4 MB reads and writes.


#### Limits of disk snapshot schedules {#compute-limits-snapshot-schedule}

| Type of limit | Value |
--- | ---
| Number of disks included in a schedule | 1000 |
| Number of schedules to add a disk to | 1000 |
