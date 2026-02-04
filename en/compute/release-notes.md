---
title: '{{ compute-full-name }} release notes'
description: This section contains the {{ compute-name }} release notes.
---

# {{ compute-full-name }} release notes

## Q3–Q4 2025 {#q3-q4-2025}

* New VM [platforms](./concepts/vm-platforms.md) are now available:
  * AMD Zen 4 (`standard-v4a`).
  * AMD Zen 4 Compute-Optimized (`highfreq-v4a`).
  * GPU PLATFORM V4 (`gpu-platform-v4`) with [GPU cluster](./concepts/gpus.md#gpu-clusters) support.
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
* Added sending the `MigrateInstance` [data event](./at-ref.md#data-plane-events) to {{ at-full-name }} when [dynamically migrating](./concepts/live-migration.md) a VM with a [maintenance policy](./concepts/vm-policies.md) configured.

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