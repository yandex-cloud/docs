#### Quotas {#compute-quotas}

| Type of limit | Value |
| ----- | ----- |
| Number of virtual machines per cloud | 12 |
| Total number of vCPUs for all VMs per cloud | 32 |
| Total virtual memory for all VMs per cloud | 128 GB |
| Total number of disks per cloud | 32 |
| Total SSD storage capacity per cloud | 200 GB |
| Total HDD storage capacity per cloud | 500 GB |
| Total number of disk snapshots per cloud | 32 |
| Total storage capacity of all disk snapshots per cloud | 400 GB |
| Number of images per cloud | 8 |
| Number of instance groups per cloud | 10 |
| Total number of GPUs for all VMs per cloud* | 0 |
| Number of concurrent [operations](../api-design-guide/concepts/operation.md) in the cloud | 15 |
| Maximum number of VM instances in a [placement group](../compute/concepts/placement-groups.md) | 5 |
| Maximum number of placement groups per cloud | 2 |
| Number of dedicated hosts per cloud* | 0 |

\* To create a VM with a GPU or a dedicated host, contact [technical support]({{ link-console-support }}).

#### VM limits {#compute-limits-vm}

| Type of limit | Value |
| ----- | ----- |
| Maximum number of vCPUs per VM | 32 and 80 for Intel Broadwell and Intel Cascade Lake [platforms](../compute/concepts/vm-platforms.md), respectively |
| Maximum virtual memory per VM | 256 GB and 640 GB for Intel Broadwell and Intel Cascade Lake [platforms](../compute/concepts/vm-platforms.md), respectively |
| Maximum number of disks connected to a single VM | 7 |
| Maximum number of GPUs connected to a single VM | 4 and 8 GB for Intel Broadwell and Intel Cascade Lake [platforms](../compute/concepts/vm-platforms.md), respectively |
| Maximum number of vGPUs connected to a single VM | 1 |
| Maximum number of vCPUs for VMs with GPUs | 32 |
| Maximum RAM for VMs with GPUs | 384 |
| Maximum number of security groups per interface | 5 |

#### Disk limits {#compute-limits-disks}

{% list tabs %}

- Network SSD

    | Type of limit | Value |
    | ----- | ----- |
    | Maximum disk size | 4 TB |
    | Maximum disk snapshot size | 4 TB |
    | [Allocation unit size](../compute/concepts/disk.md#rw) | 32 GB |
    | Maximum[*](../compute/concepts/limits.md#max_iops) [IOPS](../compute/concepts/disk.md#rw) for writes, per disk | 40,000 |
    | Maximum[*](../compute/concepts/limits.md#max_iops) IOPS for writes, per allocation unit | 1000 |
    | Maximum[**](../compute/concepts/limits.md#max_bandwidth) [bandwidth](../compute/concepts/disk.md#rw) for writes, per disk | 450 MB/s |
    | Maximum[**](../compute/concepts/limits.md#max_bandwidth) bandwidth for writes, per allocation unit | 15 MB/s |
    | Maximum[*](../compute/concepts/limits.md#max_iops) IOPS for reads, per disk | 12,000 |
    | Maximum[*](../compute/concepts/limits.md#max_iops) IOPS for reads, per allocation unit | 400 |
    | Maximum[**](../compute/concepts/limits.md#max_bandwidth) bandwidth for reads, per disk | 450 MB/s |
    | Maximum[**](../compute/concepts/limits.md#max_bandwidth) bandwidth for reads, per allocation unit | 15 MB/s |

- Network HDD

    | Type of limit | Value |
    | ----- | ----- |
    | Maximum disk size | 4 TB |
    | Maximum disk snapshot size | 4 TB |
    | [Allocation unit size](../compute/concepts/disk.md#rw) | 256 GB |
    | Maximum[*](../compute/concepts/limits.md#max_iops) [IOPS](../compute/concepts/disk.md#rw) for writes, per disk | 11,000 |
    | Maximum[*](../compute/concepts/limits.md#max_iops) IOPS for writes, per allocation unit | 300 |
    | Maximum[**](../compute/concepts/limits.md#max_bandwidth) [bandwidth](../compute/concepts/disk.md#rw) for writes, per disk | 240 MB/s |
    | Maximum[**](../compute/concepts/limits.md#max_bandwidth) bandwidth for writes, per allocation unit | 30 MB/s |
    | Maximum[*](../compute/concepts/limits.md#max_iops) IOPS for reads, per disk | 300 |
    | Maximum[*](../compute/concepts/limits.md#max_iops) IOPS for reads, per allocation unit | 100 |
    | Maximum[**](../compute/concepts/limits.md#max_bandwidth) bandwidth for reads, per disk | 240 MB/s |
    | Maximum[**](../compute/concepts/limits.md#max_bandwidth) bandwidth for reads, per allocation unit | 30 MB/s |

{% endlist %}

Read and write operations utilize the same disk resource. The more read operations you do, the fewer write operations you can do, and vice versa. Learn more in [Disks](../compute/concepts/disk.md#rw).

##### * {#max_iops}

To achieve maximum IOPS, we recommend performing read and write operations that are 4 KB and less.

##### ** {#max_bandwidth}

To achieve the maximum possible bandwidth, we recommend performing 4 MB reads and writes.
