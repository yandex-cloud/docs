---
description: "Disks are virtual versions of physical storage devices, such as SSDs and HDDs. Disks are designed for storing data and are attached to VMs. Detaching a disk does not delete its data."
keywords:
  - disk
  - ssh
  - hdd
  - vm disk
  - virtual machine disk
---

# Disks

_Disks_ are virtual versions of physical storage devices, such as SSD and HDD.

Disks are designed for storing data and are attached to VMs. Detaching a disk does not delete its data.

Each disk is located in an availability zone, where it is [replicated](#backup) (unless it is a non-replicated disk) to provide data protection. Disks are not replicated to other zones.

## Disks as a {{ yandex-cloud }} resource {#disk-as-resource}

Disks are created within folders and inherit their access rights.

Disks take up storage space, which incurs additional fees. For more information, see [{#T}](../pricing.md). You specify the disk size when you create it, and this is the storage capacity you will be charged for.

In case you create a disk from a snapshot or image, its information will contain the ID of its source. The license IDs (`product_ids`) used to calculate the disk use cost are also inherited from the source.

## Disk types {#disks-types}

{{ yandex-cloud }} VMs can use the following disk types:
* Network SSD (`network-ssd`): Fast network drive, which is an SSD based network block storage.
* Network HDD (`network-hdd`): Standard network drive, which is an HDD based network block storage.
* Non-replicated SSD (`network-ssd-nonreplicated`): Network drive with enhanced performance that has, however, a few [limitations](#nr-disks).

{% note info %}

Disks are not replicated on the {{ yandex-cloud }} side. You can, however, make your disk replicated using [placement groups](disk-placement-group.md).

{% endnote %}

Standard network SSDs and HDDs provide sufficient redundancy for reliable data storage and enable continuous read and write operations, even when multiple physical disks fail at the same time. Non-replicated disks do not provide such redundancy.

If a physical disk hosting a network SSD or HDD fails, the VM will continue running and will quickly regain full access to its data.

Network drives are slower than local drives in terms of performance and throughput; at the same time, they boost VM reliability and uptime.

### Non-replicated disk limitations {#nr-disks}

Non-replicated disks are better than regular network drives in terms of performance and can be useful when the redundancy is already provided at the application level or you need to provide quick access to temporary data.

Non-replicated disks have a number of limitations:
* Non-replicated disk size must be a multiple of 93 GB.

  {% include [pricing-gb-size](../../_includes/pricing-gb-size.md) %}

* The information they store may be temporarily unavailable or lost in the event of failure since non-replicated disks do not provide redundancy.
* You cannot create [snapshots](snapshot.md) or [images](image.md) from a non-replicated disk.
* {% include [nrd-az](../../_includes/compute/nrd-az.md) %}

{% note alert %}

Our recommendation is to avoid using a non-replicated disk as your boot drive. This is because, in case it fails, your virtual machine may become unavailable.

{% endnote %}

Multiple non-replicated disks can be combined into a [placement group](disk-placement-group.md) to ensure data storage redundancy at the application level. In this case, individual disks are physically placed in different racks in a data center to minimize the risk of simultaneous failure of all disks in the group.

## Maximum disk size {#maximum-disk-size}

{% include [disk-blocksize](../../_includes/compute/disk-blocksize.md) %}

## Attaching and detaching disks {#attach-detach}

You can only attach each disk to one VM at a time. Additionally, both the disk and the VM must be in the same availability zone.

To successfully boot a VM up, you will need a boot drive. Optionally, you can then attach more disks to your VM.

{% include [attach-empty-disk](../_includes_service/attach-empty-disk.md) %}

When selecting a disk to attach to a VM, you can specify that the disk should be deleted once you delete the VM. This option is also available when you create a VM, reconfigure it, or attach a new disk to it.

If a VM had any previously created disks attached, they will be detached when you delete the VM. The data on the disk will be still there, and you will be able to attach the disk to a different VM later.

If you would like to delete a disk with a VM, specify this option when creating the VM, reconfiguring it, or attaching the disk. Such disks will be deleted along with the VM.

## Backups {#backup}

Each disk is accessible and replicated within a specific availability zone.

You can also create disk backups as [snapshots](snapshot.md) manually or automatically, based on [schedules](snapshot-schedule.md). Snapshots are replicated across all availability zones, which allows you to migrate disks from one zone to another.

Sometimes, you may want to restore a disk to a specific state on a regular basis, for instance, when you need to attach the same boot drive to every new VM. In this case, you can upload a disk [image](image.md) to {{ compute-name }}, which will allow you to create disks faster than you would do it from snapshots. Images are also automatically replicated to multiple availability zones.

For more information on backing up and restoring VMs, see [{#T}](backups.md).

#### See also {#see-also}

* [Guides on creating disks](../operations/#disk-create)
* [Guides on managing disks](../operations/#disk-control)
* [Guides on disk snapshots and schedules](../operations/#snapshots)
