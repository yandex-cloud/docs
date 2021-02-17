# Disks

_Disks_ are virtual versions of physical storage devices, such as SSDs and HDDs.

Disks are designed for storing data and attach to VMs. Detaching a disk doesn't delete its data.

Each disk is located in an availability zone, where it's [replicated](#backup) (excluding non-replicated disks) to provide data protection. Disks are not replicated to other zones.

## Disks as a {{ yandex-cloud }} resource {#disk-as-resource}

Disks are created in folders and inherit their access rights.

Disks take up storage space, which incurs additional fees. For more information, see [{#T}](../pricing.md). The size of a disk is specified during creation. This is the storage capacity that you're charged for.

If a disk is created from a snapshot or image, the disk information contains the ID of the source resource. In addition, the license IDs (`product_ids`) are inherited from the source resource and used to calculate the disk use cost.

## Disk types {#disks_types}

VMs in {{ yandex-cloud }} can use the following types of disks:

* Network SSD (`network-ssd`): A fast network drive. Network block storage on an SSD.
* Network HDD (`network-hdd`): A standard network drive. Network block storage on an HDD.
* Non-replicated SSD (`nonrepl`): A network drive with enhanced performance that is implemented by imposing several [limitations](#nr-disks).

Standard network SSDs and HDDs provide sufficient redundancy for reliable data storage and allow for continuous read and write operations even when multiple physical disks fail at the same time. Non-replicated disks do not duplicate the information they store.

If a physical disk with a network SSD or HDD fails, the VM continues to run and quickly regains full access to the data.

Network drives are slower than local drives in terms of execution speed and throughput, but they provide greater reliability and uptime for VMs.

### Non-replicated disk limitations {#nr-disks}

{% note info %}

Non-replicated disks are at the [Preview](https://cloud.yandex.com/docs/overview/concepts/launch-stages) stage.

{% endnote %}

Non-replicated disks outperform regular network drives and can be useful when redundancy is already provided at the application level or you need to provide quick access to temporary data.

Non-replicated disks have a number of limitations:

* A non-replicated disk's size must be a multiple of 93 GB.

  {% include [pricing-gb-size](../../_includes/pricing-gb-size.md) %}

* Non-replicated disks can't be used as boot disks.

* The information they store may be temporarily unavailable or lost in the event of failure since non-replicated disks don't provide redundancy.

Multiple non-replicated disks can be grouped into `placement groups` to provide data storage redundancy at the application level. In this case, individual disks are physically placed in different racks in a data center to reduce the probability of simultaneous failure of all disks in the group.

## Attaching and detaching disks {#attach-detach}

Disks can only be attached to one VM at a time. The disk and VM must be located in the same availability zone.

VMs require one boot disk. Additional disks can also be attached.

{% include [attach-empty-disk](../_includes_service/attach-empty-disk.md) %}

When attaching a disk to VMs, you can specify whether the disk should be deleted along with the VM. You can also configure this when creating and updating VMs.

If previously created disks were connected to the VM, they will be disabled when the VM is deleted. Disk data is preserved and the disk can be attached to other VMs in the future.

If you want the disk to be deleted together with the VM, specify this during one of the operations: when creating the VM, changing it, or connecting the disk to it. Such disks will be deleted when the VM is deleted.

**See also**

- Learn about [{#T}](../operations/vm-control/vm-attach-disk.md).
- Learn about [{#T}](../operations/vm-control/vm-detach-disk.md).

## Backups {#backup}

Each disk is accessible and replicated within a specific availability zone.

You can back up disks as [snapshots](snapshot.md). Snapshots are replicated across every availability zone, which lets you transfer disks between availability zones.

Restoring a particular disk state can become a routine operation, for example, if you want to attach the same boot disk to every new VM. You can upload an [image](image.md) of the disk to {{ compute-name }}. Disk are created faster from images than from snapshots. Images are also automatically replicated to multiple availability zones.

For general advice on backing up and restoring virtual machines, see [{#T}](backups.md).

## Read and write operations {#rw}

Disks and allocation units are subject to read and write operation limits. An allocation unit is a unit of disk space allocation, in GB. The allocation unit size depends on the [disk type](../concepts/limits.md#limits-disks).

The following maximum read and write operation parameters exist:

* Maximum IOPS: The maximum number of read and write operations performed by a disk per second.
* Maximum bandwidth: The total number of bytes that can be read from or written to a disk per second.

The actual IOPS value depends on the characteristics of the disk, total bandwidth, and the size of the request in bytes. Disk IOPS is determined by the following formula:

![image](../../_assets/compute/iops.svg)

Where:

* _Max IOPS_: The [maximum IOPS value](../concepts/limits.md#limits-disks) for the disk.
* _Max bandwidth_: The [maximum bandwidth value](../concepts/limits.md#limits-disks) for the disk.

Read and write operations utilize the same disk resource. The more read operations you do, the fewer write operations you can do, and vice versa. The total number of read and write operations per second is determined by the formula:

![image](../../_assets/compute/max-iops.svg)

Where:

* ![image](../../_assets/compute/alpha.svg) is the share of write operations out of the total number of read and write operations per second. Possible values: &alpha;&isin;[0,1].
* _WriteIOPS_: The IOPS write value obtained using the formula for the actual IOPS value.
* _ReadIOPS_: The IOPS read value obtained using the formula for the actual IOPS value.

For more information about maximum possible IOPS and bandwidth values, see [Quotas and limits](../concepts/limits.md#limits-disks).

### Disk performance {#performance}

To achieve maximum IOPS, we recommend performing read and write operations whose size is close to that of the disk block (4 KB by default). Network SSDs have much higher IOPS for read operations and process requests faster than HDDs.

To achieve the maximum possible bandwidth, we recommend performing 4 MB reads and writes.

Disk performance depends on size: the more allocation units, the higher the IOPS and bandwidth values.

For small HDDs, there's a mechanism that raises their performance to that of 1 TB disks for peak loads. When a small disk works at the [basic performance level](../concepts/limits.md#limits-disks) for 12 hours, it accumulates "credits for operations". These are spent automatically when the load increases (for example, when a VM starts up). Small HDDs can work at increased performance for about 30 minutes a day. "Credits for operations" can be spent all at once or in small intervals.