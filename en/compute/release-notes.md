---
title: '{{ compute-full-name }} release notes'
description: This section contains the {{ compute-name }} release notes.
---

# {{ compute-full-name }} release notes

## Q1 2026 {#q1-2026}

* Added [maintenance management features for VMs with GPUs](./concepts/gpus-maintenance.md).
* Added new types of [dedicated hosts](./concepts/dedicated-host.md#host-types) with larger disks:
  * `intel-6338-c108-m958-n6400x6`
  * `intel-6354-c56-m938-n6400x6`
* [CLI](../cli/quickstart.md):
  * Added the `--os-nvidia-driver` property to the [yc compute image create](./cli-ref/image/create.md) command for the Nvidia driver version in the image.
  * The [yc compute instance create](./cli-ref/instance/create.md) and [yc compute instance create-with-container](./cli-ref/instance/create-with-container.md) commands now have the `kms-key-id` and `kms-key-name` options available for the `--attach-local-disk` property to connect encrypted local disks to a new VM created on a dedicated host.
* [{{ TF }}](../terraform/quickstart.md): Added the `kms_key_id` option for the [yandex_compute_instance](../terraform/resources/compute_instance.md) resource under `local_disks` to connect encrypted local disks to a new VM created on a dedicated host.
* Added the following [{{ at-name }} management events](./at-ref.md#control-plane-events):
  * `CreateDiskPlacementGroup`: Creating a [disk placement group](./concepts/disk-placement-group.md).
  * `CreatePlacementGroup`: Creating a [VM placement group](./concepts/placement-groups.md).
  * `DeleteDiskPlacementGroup`: Deleting a disk placement group.
  * `DeletePlacementGroup`: Deleting a VM placement group.
  * `UpdateDiskPlacementGroup`: Updating a disk placement group.
  * `UpdatePlacementGroup`: Updating a VM placement group.

## Q3–Q4 2025 {#q3-q4-2025}

* New VM [platforms](./concepts/vm-platforms.md) are now available:
  * AMD Zen 4 (`standard-v4a`).
  * AMD Zen 4 Compute-Optimized (`highfreq-v4a`).
  * GPU PLATFORM V4 (`gpu-standard-v4`) with [GPU cluster](./concepts/gpus.md#gpu-clusters) support.
* Introduced the following new VM [hardware generations](./concepts/hardware-generations.md) on `PCI_TOPOLOGY_V2` with increased disk and network interface limits:
  * `Gen 1.2` with a [BIOS](https://en.wikipedia.org/wiki/BIOS) bootloader.
  * `Gen 2` with a [UEFI](https://en.wikipedia.org/wiki/UEFI) bootloader.
* Changed the logic of [instance groups during a zonal incident](./concepts/instance-groups/zonal-inc/overview.md#multi-zone-in) to reduce impact and improve manageability.
* Added support for [zonal shift of instance groups](./concepts/instance-groups/disable-enable-zone.md).
* Updated the logic of [reserved instance pools](./concepts/reserved-pools.md); pool management is now also available in the [management console]({{ link-console-main }}/link/compute).
* Added support for [generating SSH keys](./operations/vm-connect/ssh.md#creating-ssh-keys) in the [management console]({{ link-console-main }}/link/compute).
* Introduced the [yc compute maintenance](./cli-ref/maintenance/index.md) command group to the {{ yandex-cloud }} CLI to manage VM maintenance.
* Added the following [{{ at-name }} management events](./at-ref.md#control-plane-events):
  * `instancegroup.DisableZones`: Zonal shift.
  * `instancegroup.EnableZones`: Enabling availability zones.
* Added support for the following new [{{ monitoring-full-name }} metrics](./metrics.md#fs-metrics):
  * `filestore.index_cumulative_time`: Total time of indexing operations in the file storage.
  * `filestore.index_latency`: Delay when performing indexing operations in the file storage. 
* Updated the instance group deletion behavior: you can no longer pause processes in the group being deleted. Also, you cannot run any operations for paused instance groups.
* Removed the simple VM creation form from the [management console]({{ link-console-main }}/link/compute).

## Q2 2025 {#q2-2025}

* The [reserved instance pool](./concepts/reserved-pools.md) functionality is now on at the [Preview](../overview/concepts/launch-stages.md) stage. You can access it upon request.
* Implemented a simple VM creation form in the [management console]({{ link-console-main }}).
* Added sending the `MigrateInstance` [data event](./at-ref.md#data-plane-events) to {{ at-full-name }} when [dynamically migrating](./concepts/live-migration.md) a VM with a [maintenance policy](./concepts/maintenance-policies.md) configured.

## Q1 2025 {#q1-2025}

* The AMD Zen 3 [platform](./concepts/vm-platforms.md) (`amd-v1`) is launched at the [Preview stage](../overview/concepts/launch-stages.md). You can access it upon request.
* Upgraded monitoring and logging (observability) tools and improved the reliability of the high-speed secure Infiniband network in [GPU clusters](./concepts/gpus.md#gpu-clusters).
* Added [VM configuration](./concepts/gpus.md#config) with one GPU for the `gpu-standard-v3i` platform.

## Q4 2024 {#q4-2024}

* Released the [disk encryption](./concepts/encryption.md) feature for [General Availability](../overview/concepts/launch-stages.md).
* Added [VM configuration](./concepts/gpus.md#config) with two and four GPUs for the `gpu-standard-v3i` platform.
* Added support for grouping `gpu-standard-v3i` VMs into a [GPU cluster](./concepts/gpus.md#gpu-clusters).
* `gpu-standard-v3-t4i` is now available in the Kazakhstan [region](../overview/concepts/region.md).

## Q3 2024 {#q3-2024}

* Implemented a new PCI topology. You can now create a VM with the new topology by running the `yc instance create` command with the `--hardware-generation-id=generation2` and `--hardware-features pci_topology=v2` parameters.
* QEMU updated to version 7.

## Q2 2024 {#q2-2024}

* Increased network connection [limits](concepts/limits.md).

## Q1 2024 {#q1-2024}

* Now you can add and delete network interfaces without recreating VMs.
* Added support for VHD.
* Fixed a {{ TF }} provider bug that occurred when creating a VM with multiple disks using the `Count` meta argument.
* Added the [description of `gpus` resources]({{ tf-provider-resources-link }}/compute_instance) to the provider documentation.
