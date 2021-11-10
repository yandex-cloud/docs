# Read and write operations

There are some technical restrictions on reads and writes that apply to [disks](disk.md) and [file storage](filesystem.md). They're imposed on the entire disk or storage and each allocation unit (a unit of disk space allocation). The allocation unit size depends on the [disk or storage type](../concepts/limits.md#compute-limits-disks).

The following maximum read and write operation parameters exist:

* Maximum IOPS: The maximum number of read and write operations per second.
* Maximum bandwidth: The total number of bytes that can be read or written per second.

The actual IOPS value depends on the disk or storage characteristics, total bandwidth, and the size of the request in bytes. The provided IOPS value is calculated using the formula:

![image](../../_assets/compute/iops.svg)

Where:

* _Max IOPS_: The [maximum IOPS value](../concepts/limits.md#limits-disks) for the disk or storage.
* _Max. bandwidth_: The [maximum bandwidth value](../concepts/limits.md#limits-disks) for the disk or storage.

Read and write operations utilize the same disk resource. The more read operations you do, the fewer write operations you can do, and vice versa. The total number of read and write operations per second is determined by the formula:

![image](../../_assets/compute/max-iops.svg)

Where:

* ![image](../../_assets/compute/alpha.svg) is the share of write operations out of the total number of read and write operations per second. Possible values: &alpha;&isin;[0,1].
* _WriteIOPS_: The IOPS write value obtained using the formula for the actual IOPS value.
* _ReadIOPS_: The IOPS read value obtained using the formula for the actual IOPS value.

For more information about maximum possible IOPS and bandwidth values, see [Quotas and limits](../concepts/limits.md#limits-disks).

## Disk and file storage performance {#performance}

The maximum IOPS values are achieved when performing reads and writes that are 4 KB in size. Network SSDs and file storage have much higher IOPS for read operations and process requests faster than HDDs.

To achieve the maximum possible bandwidth, we recommend performing 4 MB reads and writes.

Disk and storage performance depends on their size: the more allocation units, the higher the IOPS and bandwidth values.

For small HDDs, there's a mechanism that raises their performance to that of 1 TB disks for peak loads. When a small disk operates at the [basic performance level](../concepts/limits.md#limits-disks) for 12 hours, it accumulates <q>credits for operations</q>. These are spent automatically when the load increases (for example, when a VM boots up). Small HDDs can work at increased performance for about 30 minutes a day. You can spend your <q>credits for operations</q> all at once or in small batches. No mechanism is provided for HDD storage.

