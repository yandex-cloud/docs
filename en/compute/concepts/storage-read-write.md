# Read and write operations

There are some technical restrictions on reads and writes that apply to [disks](disk.md) and [file storage](filesystem.md). They're imposed on the entire disk or storage and each allocation unit (a unit of disk space allocation). The allocation unit size depends on the [disk or storage type](../concepts/limits.md#compute-limits-disks).

The following maximum read and write operation parameters exist:
* Maximum IOPS: The maximum number of read and write operations per second.
* Maximum bandwidth: The total number of bytes that can be read or written per second.

The actual IOPS value depends on the disk or storage characteristics, total bandwidth, and the size of the request in bytes. The provided IOPS value is calculated using the formula:

![image](../../_assets/compute/iops.svg)

Where:
* _Max. IOPS_: The [maximum IOPS](../concepts/limits.md#limits-disks) value for the disk or storage.
* _Max. bandwidth_: The [maximum bandwidth value](../concepts/limits.md#limits-disks) for the disk or storage.

Read and write operations utilize the same disk resource. The more read operations you do, the fewer write operations you can do, and vice versa. The total number of read and write operations per second is determined by the formula:

![image](../../_assets/compute/max-iops.svg)

Where:
* ![image](../../_assets/compute/alpha.svg): The share of write operations out of the total number of read and write operations per second. Possible values: &alpha;&isin;[0,1].
* _WriteIOPS_: The IOPS write value obtained using the formula for the actual IOPS value.
* _ReadIOPS_: The IOPS read value obtained using the formula for the actual IOPS value.

For more information about maximum possible IOPS and bandwidth values, see [Quotas and limits](../concepts/limits.md#limits-disks).

## Disk and file storage performance {#performance}

The maximum IOPS values are achieved when performing reads and writes that are 4 KB in size. Network SSDs and file storage have much higher IOPS for read operations and process requests faster than HDDs.

To achieve the maximum possible bandwidth, we recommend performing 4 MB reads and writes.

Disk and storage performance depends on their size: the more allocation units, the higher the IOPS and bandwidth values.

For small HDDs, there's a mechanism that raises their performance to that of 1 TB disks for peak loads. When a small disk operates at the [basic performance level](../concepts/limits.md#compute-limits-disks) for 12 hours, it accumulates <q>credits for operations</q>. These are spent automatically when the load increases (for example, when a VM boots up). Small HDDs can work at increased performance for about 30 minutes a day. <q>Credits for operations</q> can be spent all at once or in small intervals. No mechanism is provided for HDD storage.

### Throttling {#throttling}

If a VM exceeds [disk limits](limits.md#compute-limits-disks) at any time, throttling is triggered.

_Throttling_ is the act of intentionally limiting performance. When throttled, disk operations are suspended. At this time, the `iowait` disk operation wait time is increased. Because all write and read operations are processed in a single thread (vCPU), overloading system disks may cause network problems. This is true for both VMs and physical servers.

> For example, there is a write limit of 300 IPOS. The limit is split into 10 parts and applies once every 100 ms. 300 / 10 = 30 IOPS per write request will be allowed every 100 ms. If you send 30 requests once and then 30 more requests within 100 ms (evenly distributed over the 100 ms), throttling is triggered and only the first 30 requests are sent. The rest will be queued and processed in the next 100 ms. If write requests are executed sporadically, throttling may cause significant delays. At times, there will be up to N IOPS of requests within 100 ms.

Disk performance depends on [size](disk.md#maximum-disk-size). To improve general performance of the disk subsystem, use VMs with SSD network (`network-SSD`) storage. Every increment of 32 GB increases the number of allocation units and, consequently, performance.

You can select the storage type only when creating a VM. However, you can [make a snapshot](../operations/disk-control/create-snapshot.md) of a disk and [create a new VM](../operations/vm-create/create-from-snapshots.md) from the snapshot with `network-ssd`.
