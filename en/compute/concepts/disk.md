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
* Non-replicated SSD (`network-ssd-nonreplicated`): Network drive with enhanced performance but no redundancy.
* High-performance SSD (`network-ssd-io-m3`): Network drive with the same characteristics as `network-ssd-nonreplicated`, plus redundancy. High-performance SSDs are currently at the [Preview](../../overview/concepts/launch-stages.md) stage. Using high performance SSDs will be charged starting September 1, 2023.
* [Local disk drives](dedicated-host.md#resource-disks) on dedicated hosts.

Network SSDs, high-performance SSDs, and network HDDs provide sufficient redundancy for reliable data storage and enable continuous read and write operations, even when multiple physical disks fail at the same time. Non-replicated disks do not ensure data security.

If a physical disk hosting a network drive fails, the VM will continue running and will quickly regain full access to its data.

### Non-replicated disks and high-performance SSDs {#nr-disks}

Non-replicated disks and high-performance SSDs outperform network SSDs but have the following limitations:

* Disk size must be a multiple of 93 GB.

  {% include [pricing-gb-size](../../_includes/pricing-gb-size.md) %}

* You cannot create [snapshots](snapshot.md) or [images](image.md) from these disks.
* {% include [nrd-az](../../_includes/compute/nrd-az.md) %}

{% note alert %}

Our recommendation is to avoid using a non-replicated disk as your boot drive. This is because, in case it fails, your virtual machine may become unavailable.

{% endnote %}


If you need enhanced performance and guaranteed fault tolerance, we recommend using high-performance SSDs. Currently, high-performance SSDs have the same limitations on creating images and snapshots as non-replicated disks. We will soon add support for creating snapshots with write freeze and, moving forward, full-featured snapshots with no write freeze.


## Maximum disk size {#maximum-disk-size}

{% include [disk-blocksize](../../_includes/compute/disk-blocksize.md) %}

## Attaching and detaching disks {#attach-detach}

You can only attach each disk to one VM at a time. Additionally, both the disk and the VM must be in the same availability zone.

To successfully boot a VM up, you will need a boot drive. Optionally, you can then attach more disks to your VM.

{% include [attach-empty-disk](../_includes_service/attach-empty-disk.md) %}

When selecting a disk to attach to a VM, you can specify that the disk should be deleted once you delete the VM. This option is available when you create a VM, reconfigure it, or attach a new disk to it.

If a VM had any previously created disks attached, they will be detached when you delete the VM. The data on the disk will be still there, and you will be able to attach the disk to a different VM later.

If you would like to delete a disk with a VM, specify this option when creating the VM, reconfiguring it, or attaching the disk. Such disks will be deleted along with the VM.

## Backups {#backup}

Backups are required to make sure no data is lost if damaged. Different disk types allow using different backup methods:

* [{{ backup-name }}](../../backup/) enables you to create consistent data copies on VMs with any disk types. The service is at the [Preview](../../overview/concepts/launch-stages.md) stage.
* [Disk snapshots](snapshot.md): Use them to manually or automatically create [scheduled](snapshot-schedule.md) snapshots of network SSDs and HDDs. You cannot take snapshots of non-replicated and high-performance SSDs.

Snapshots are replicated across all availability zones, which allows you to migrate disks from one zone to another.

Sometimes, you may want to restore a disk to a specific state on a regular basis, for instance, when you need to attach the same boot drive to every new VM. In this case, you can upload a disk [image](image.md) to {{ compute-name }}, which will allow you to create disks faster than you would do it from snapshots. Images are also automatically replicated to multiple availability zones.

For more information on backing up and restoring VMs, see [{#T}](backups.md).

#### See also {#see-also}

* [Guides on creating disks](../operations/#disk-create)
* [Guides on managing disks](../operations/#disk-control)
* [Guides on disk snapshots and schedules](../operations/#snapshots)
