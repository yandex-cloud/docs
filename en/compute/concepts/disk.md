---
title: Disks
description: Disks are virtual counterparts of physical storage devices, such as SSDs and HDDs. Disk enable data storage and operate connected to virtual machines. Detaching a disk does not delete its data.
keywords:
  - disk
  - ssh
  - hdd
  - vm disk
  - virtual machine disk
---

# Disks


_Disks_ are virtual counterparts of physical storage devices, such as SSDs and HDDs.

Disk enable data storage and operate connected to virtual machines. Detaching a disk does not delete its data.

Each disk is located in one of the [availability zones](../../overview/concepts/geo-scope.md) and [replicated](#backup) within it (unless it is a non-replicated disk) for data protection. Disks are not replicated to other zones.

After creating a disk, you can [change](../operations/disk-control/update.md#change-disk-name) its name and description and [increase](../operations/disk-control/update.md#change-disk-size) the disk size.

## Disks as a {{ yandex-cloud }} resource {#disk-as-resource}

Disks are created within folders and inherit their access rights.

Disks take up storage space, which incurs additional fees. For more information, see [{#T}](../pricing.md). You specify the disk size when you create it, and this is the storage capacity you will be charged for.

In case you create a disk from a snapshot or image, its information will contain the ID of its source. The license IDs (`product_ids`) used to calculate the disk usage cost are also inherited from the source.

## Disk types {#disks-types}

{{ yandex-cloud }} VMs can use the following disk types:
* Network SSD (`network-ssd`): Fast network drive; SSD network block storage.
* Network HDD (`network-hdd`): Standard network drive; HDD network block storage.
* Non-replicated SSD (`network-ssd-nonreplicated`): Enhanced performance network drive without redundancy.
* Ultra high-speed network storage with three replicas (SSD) (`network-ssd-io-m3`): High-performance SSD offering the same speed as `network-ssd-nonreplicated`, plus redundancy.
* [Local disk](dedicated-host.md#resource-disks) drives on dedicated hosts.

Network SSDs, high-performance SSDs, and network HDDs provide sufficient redundancy for reliable data storage and enable continuous read and write operations, even when multiple physical disks fail at the same time. Non-replicated disks do not ensure data durability.

If a physical disk hosting a network drive fails, the VM will continue running and will quickly regain full access to its data.

### Non-replicated disks and ultra high-speed network storages with three replicas (SSD) {#nr-disks}

Non-replicated disks and high-performance SSDs (ultra high-speed network storages with three replicas) outperform network SSDs but their size must be a multiple of 93 GB.

{% include [pricing-gb-size](../../_includes/pricing-gb-size.md) %}

{% note alert %}

Our recommendation is to avoid using a non-replicated disk as your boot drive. This is because, in case it fails, your virtual machine may become unavailable.

{% endnote %}

Non-replicated disks are physically located in the server racks of the data center in one of the availability zones. Every so often the existing racks and equipment get replaced with new ones, with their data migrated from one physical medium to another.

During a migration like that, the **{{ ui-key.yacloud.compute.disk.overview.label_status }}** line on the disk information page in the [management console]({{ link-console-main }}) will display the following message: `data migration in progress, slight performance decrease may be experienced`. The disk may temporarily become unavailable for write operations, and its performance may deteriorate.

If you need enhanced performance and guaranteed fault tolerance, we recommend using high-performance SSDs.

## Maximum disk size {#maximum-disk-size}

{% include [disk-blocksize](../../_includes/compute/disk-blocksize.md) %}

## Attaching and detaching disks {#attach-detach}

You can only attach each disk to one VM at a time. Additionally, both the disk and the VM must be in the same availability zone.

A VM must have a boot disk attached. You can also attach extra disks to your VM.

{% include [second-disk-without-restart](../../_includes/compute/second-disk-without-restart.md) %}

{% include [attach-empty-disk](../_includes_service/attach-empty-disk.md) %}

When selecting a disk to attach to a VM, you can specify that the disk should be deleted once you delete the VM. This option is available when you create a VM, reconfigure it, or attach a new disk to it.

If a VM had any previously created disks attached, they will be detached when you delete the VM. The data on the disk will be still there, and you will be able to attach the disk to a different VM later.

If you would like to delete a disk with a VM, specify this option when creating the VM, reconfiguring it, or attaching the disk. Such disks will be deleted along with the VM.

## Backups {#backup}

Backups are required to make sure no data is lost if damaged. Different disk types allow using different backup methods:

* [{{ backup-name }}](../../backup/) enables you to create consistent data copies on VMs with any disk types.
* [Disk snapshots](snapshot.md): Use them to manually or automatically create [scheduled](snapshot-schedule.md) snapshots of network SSDs and HDDs, as well as high-performance and non-replicated SSDs. You can also use snapshots to migrate disks from one availability zone to another.

Snapshots are replicated across all availability zones, which allows you to migrate disks from one zone to another.

Sometimes, you may want to restore a disk to a specific state on a regular basis, for instance, when you need to attach the same boot drive to every new VM. In this case, you can upload a disk [image](image.md) to {{ compute-name }}, which will allow you to create disks faster than you would do it from snapshots. Images are also automatically replicated to multiple availability zones.

{% include [boot-disk-recover](../../_includes/compute/boot-disk-recover.md) %}

For general recommendations on backing up and restoring VMs, see [{#T}](backups.md).


## Disk encryption {#encryption}

To protect critical data in {{ compute-name }}, we recommend encrypting disks with [{{ kms-full-name }}](../../kms/) keys.

For more information, see [{#T}](encryption.md).


#### See also {#see-also}

* [Guides on creating disks](../operations/#disk-create)
* [Guides on managing disks](../operations/#disk-control)
* [Guides on disk snapshots and schedules](../operations/#snapshots)
