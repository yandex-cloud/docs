# Read and write operations

There are technical restrictions on reads and writes that apply to [disks](disk.md) and [file storages](filesystem.md). Such limitations apply to the entire disk or storage and each allocation unit (a unit of disk space allocation). The allocation unit size depends on the [disk or storage type](../concepts/limits.md#compute-limits-disks).

The maximum read and write operation parameters are the following:
* Maximum IOPS: Maximum number of read and write operations per second.
* Maximum bandwidth: Total number of bytes that can be read or written per second.

The actual IOPS value depends on the disk or storage configuration, total bandwidth, and the size of the request in bytes. The provided IOPS value is calculated using the following formula:

![image](../../_assets/compute/iops.svg)

Where:
* _Max IOPS_: [Maximum IOPS](../concepts/limits.md#limits-disks) value for the disk or storage.
* _Max bandwidth_: [Maximum bandwidth value](../concepts/limits.md#limits-disks) for the disk or storage.

Read and write operations utilize the same disk resource. The more read operations you do, the fewer write operations you can do, and vice versa. The total number of read and write operations per second is determined by this formula:

![image](../../_assets/compute/max-iops.svg)

Where:
* ![image](../../_assets/compute/alpha.svg): Share of write operations in the total number of read and write operations per second. Possible values: &alpha;&isin;[0,1].
* _WriteIOPS_: IOPS write value obtained using the formula for the actual IOPS value.
* _ReadIOPS_: IOPS read value obtained using the formula for the actual IOPS value.

For more information about maximum possible IOPS and bandwidth values, see [Quotas and limits](../concepts/limits.md#limits-disks).

## Disk and file storage performance {#performance}

The maximum IOPS values are achieved when performing reads and writes that are 4 KB in size. Network SSDs and file storage have much higher IOPS for read operations and process requests faster than HDDs.

To achieve the maximum possible bandwidth, we recommend performing 4 MB reads and writes.

Disk or storage performance depends on its size: with more allocation units, you get higher IOPS and bandwidth values.

For small HDDs, there is a feature that boosts their performance to that of 1 TB disks for peak loads. When a small disk operates at the [basic performance level](../concepts/limits.md#compute-limits-disks) for 12 hours, it accumulates _credits for operations_. These are spent automatically when the load increases, e.g., when a VM boots up. Small HDDs can work at increased performance for about 30 minutes a day. Credits for operations can be spent all at once or in small intervals. For HDD storages, this feature is unavailable.

### Throttling {#throttling}

If a VM exceeds [disk limits](limits.md#compute-limits-disks) at any time, this will trigger throttling.

_Throttling_ is a feature that intentionally limits performance. When throttled, disk operations are suspended, and the disk operation wait time (`iowait`) is increased. Since all write and read operations are processed in a single thread (vCPU), overloading system disks may cause network problems. This is true for both VMs and physical servers.

> For example, let's assume there is a write limit of 300 IPOS. The limit is split into 10 parts and applies once every 100 ms. 300 / 10 = 30 IOPS per write request will be allowed every 100 ms. If you send 30 requests once and then 30 more requests within 100 ms (evenly distributed across the 100 ms interval), this will trigger throttling and only the first 30 requests will be sent, while the rest will be queued and processed in the next 100 ms. If write requests are executed sporadically, throttling may cause significant delays. At times, there will be up to N IOPS of requests within 100 ms.

Disk performance depends on its [size](disk.md#maximum-disk-size). To improve the overall performance of the disk subsystem, use VMs with SSD network storage (`network-SSD`). Every increment of 32 GB increases the number of allocation units and, consequently, the performance.

You can select the storage type only when creating a VM. However, you can [make a disk snapshot](../operations/disk-control/create-snapshot.md) and [create a new VM](../operations/vm-create/create-from-snapshots.md) from such a snapshot with a `network-ssd` disk.
