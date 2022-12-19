---
description: "Disks are virtual versions of physical storage devices, such as SSDs and HDDs. Disks are designed for storing data and attach to VMs. Detaching a disk doesn't delete its data."
keywords:
  - disk
  - ssh
  - hdd
  - vm disk
  - virtual machine disk
---

# Disks

_Disks_ are virtual versions of physical storage devices, such as SSD and HDD.

Disks are designed for storing data and attach to VMs. Detaching a disk doesn't delete its data.

Each disk is located in an availability zone, where it's [replicated](#backup) (excluding non-replicated disks) to provide data protection. Disks are not replicated to other zones.

## Disks as a resource {{ yandex-cloud }} {#disk-as-resource}

Disks are created in folders and inherit their access rights.

Disks take up storage space, which incurs additional fees. For more information, see [{#T}](../pricing.md). The size of a disk is specified during creation. This is the storage capacity that you're charged for.

If a disk is created from a snapshot or image, the disk information contains the ID of the source resource. In addition, the license IDs (`product_ids`) are inherited from the source resource, which are used to calculate the disk use cost.

## Disk types {#disks_types}

VMs in {{ yandex-cloud }} can use the following types of disks:
* Network SSD (`network-ssd`): A fast network drive. Network block storage on an SSD.
* Network HDD (`network-hdd`): A standard network drive. Network block storage on an HDD.
* Non-replicated SSD (`network-ssd-nonreplicated`): A network drive with enhanced performance that is implemented by imposing several [limitations](#nr-disks).

{% note info %}

Disks are not replicated{% if product == "yandex-cloud" %} on the {{ yandex-cloud }}{% endif %} side, but a user can make a disk replicated using [placement groups](disk-placement-group.md).

{% endnote %}

Standard network SSDs and HDDs provide sufficient redundancy for reliable data storage and allow for continuous read and write operations even when multiple physical disks fail at the same time. Non-replicated disks do not provide redundancy.

If a physical disk hosting a network SSD or HDD fails, a VM will continue to run and quickly regain full access to data.

Network drives are slower than local drives in terms of performance and throughput, but they assure greater VM reliability and uptime.

### Non-replicated disk limitations {#nr-disks}

Non-replicated disks outperform regular network drives and can be useful when redundancy is already provided at the application level or you need to provide quick access to temporary data.

Non-replicated disks have a number of limitations:
* A non-replicated disk's size must be a multiple of 93 GB.

  {% include [pricing-gb-size](../../_includes/pricing-gb-size.md) %}

* The information they store may be temporarily unavailable or lost in the event of failure since non-replicated disks don't provide redundancy.
* You can't create [snapshots](snapshot.md) or [images](image.md) from a non-replicated disk.
{% if product == "yandex-cloud" %}* {% include [nrd-az](../../_includes/compute/nrd-az.md) %}{% endif %}

{% note alert %}

We do not recommend making a non-replicated disk the boot drive. If it fails, a virtual machine may become unavailable.

{% endnote %}

Multiple non-replicated disks can be combined into a [placement group](disk-placement-group.md) to ensure data storage redundancy at the application level. In this case, individual disks are physically placed in different racks in a data center to reduce the probability of simultaneous failure of all disks in the group.

## Maximum disk size {#maximum-disk-size}

{% include [disk-blocksize](../../_includes/compute/disk-blocksize.md) %}

## Attaching and detaching disks {#attach-detach}

You can only attach each disk to a single VM. A disk and a VM must be in the same availability zone.

A VM requires a boot drive. Additional disks can also be attached.

{% include [attach-empty-disk](../_includes_service/attach-empty-disk.md) %}

When selecting a disk to attach to a VM, you can specify whether the disk should be deleted along with the VM. You can choose this option when creating a VM, reconfiguring it, or attaching a new disk.

If a VM had previously created disks attached, they will be detached when you delete the VM. Data on the disk is saved, and you can attach the disk to a different VM later.

If you would like to delete a disk with a VM, specify this option when creating the VM, reconfiguring it, or attaching the disk. Such disks will be deleted along with the VM.

## Backups {#backup}

Each disk is accessible and replicated within a specific availability zone.

You can create disk backups as [snapshots](snapshot.md) manually or automatically, according to the [schedule](snapshot-schedule.md). Snapshots are replicated across every availability zone, which lets you transfer disks between zones.

Restoring a disk to a specific state can become a routine operation: for instance, if you wish to attach the same boot drive to every new VM. You can upload an [image](image.md) of the disk to {{ compute-name }}. Disk are created faster from images than from snapshots. Images are also automatically replicated to multiple availability zones.

For general recommendations on backing up and restoring VMs, see [{#T}](backups.md).

#### See also {#see-also}

* [Instructions for creating disks](../operations/#disk-create)
* [Instructions for managing disks](../operations/#disk-control)
* [Instructions for disk snapshots and schedules](../operations/#snapshots)
