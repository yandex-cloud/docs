# Read and write operations

There are some technical restrictions on reads and writes that apply to [disks](disk.md){% if product == "yandex-cloud" %} and [file storage](filesystem.md){% endif %}. They're imposed on the entire disk{% if product == "yandex-cloud" %} or storage{% endif %} and each allocation unit (a unit of disk space allocation). The allocation unit size depends on the [disk{% if product == "yandex-cloud" %} or storage{% endif %} type](../concepts/limits.md#compute-limits-disks).

The following maximum read and write operation parameters exist:
* Maximum IOPS: The maximum number of read and write operations per second.
* Maximum bandwidth: The total number of bytes that can be read or written per second.

The actual IOPS value depends on the disk{% if product == "yandex-cloud" %} or storage{% endif %} characteristics, total bandwidth, and the size of the request in bytes. The provided IOPS value is calculated using the formula:

![image](../../_assets/compute/iops.svg)

Where:
* _Max. IOPS_: The [maximum IOPS](../concepts/limits.md#limits-disks) value for the disk{% if product == "yandex-cloud" %} or storage{% endif %}.
* _Max. bandwidth_: The [maximum bandwidth value](../concepts/limits.md#limits-disks) for the disk{% if product == "yandex-cloud" %} or storage{% endif %}.

Read and write operations utilize the same disk resource. The more read operations you do, the fewer write operations you can do, and vice versa. The total number of read and write operations per second is determined by the formula:

![image](../../_assets/compute/max-iops.svg)

Where:
* ![image](../../_assets/compute/alpha.svg) is the share of write operations out of the total number of read and write operations per second. Possible values: &alpha;&isin;[0,1].
* _WriteIOPS_: The IOPS write value obtained using the formula for the actual IOPS value.
* _ReadIOPS_: The IOPS read value obtained using the formula for the actual IOPS value.

For more information about maximum possible IOPS and bandwidth values, see [Quotas and limits](../concepts/limits.md#compute-limits-disks).

## Disk{% if product == "yandex-cloud" %} and file storage{% endif %} performance {#performance}

The maximum IOPS values are achieved when performing reads and writes that are 4 KB in size. Network SSDs{% if product == "yandex-cloud" %} and file storage{% endif %} have much higher IOPS for read operations and process requests faster than HDDs.

To achieve the maximum possible bandwidth, we recommend performing 4 MB reads and writes.

Disk{% if product == "yandex-cloud" %} and storage{% endif %} performance depends on their size: the more allocation units, the higher the IOPS and bandwidth values.

For small HDDs, there's a mechanism that raises their performance to that of 1 TB disks for peak loads. When a small disk operates at the [basic performance level](../concepts/limits.md#compute-limits-disks) for 12 hours, it accumulates <q>credits for operations</q>. These are spent automatically when the load increases (for example, when a VM boots up). Small HDDs can work at increased performance for about 30 minutes a day. <q>Credits for operations</q> can be spent all at once or in small intervals. No mechanism is provided for HDD storage.

### Throttling {#throttling}

If a VM exceeds [disk limits](limits.md#compute-limits-disks) in any time period, throttling is triggered.

_Throttling_ is an intentional limitation of performance. During throttling, disk operations are suspended. At this time, the `iowait` disk operation wait time is increased. Because all write and read operations are processed in a single stream (vCPU), overloading system disks may cause network problems, both on a VM or any physical server.

> For example, with the limitation of 300 IOPS per write request, it's split into 10 parts and occurs once every 100 ms. Thus, 300 / 10 = 30 IOPS per write request will be allowed every 100 ms. If you send 30 requests concurrently and then 30 more requests within 100 ms (evenly distributed during 100 ms), throttling is triggered and only the first 30 requests will pass. The rest will be queued and processed in the next 100 ms. If write requests are executed abruptly, throttling may cause quite significant delays. At times, there will be up to N IOPS of requests within 100 ms.

Disk performance depends on [size](disk.md#maximum-disk-size). To improve general performance of the disk subsystem, use VMs with SSD network (`network-SSD`) storage. Every increment of 32 GB increases the number of allocation units and, consequently, performance.

You can select the storage type only when creating a VM. However, you can [make a snapshot](../operations/disk-control/create-snapshot.md) of the disk and [create a new VM](../operations/vm-create/create-from-snapshots.md) with `network-ssd` from the snapshot.
