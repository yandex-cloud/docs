---
title: '{{ compute-full-name }} release notes'
description: This section contains {{ compute-name }} release notes.
---

# {{ compute-full-name }} release notes

## Q2 2025 {#q2-2025}

* The [reserved VM pool](./concepts/reserved-pools.md) functionality is now on at the [Preview](../overview/concepts/launch-stages.md) stage. You can access it upon request.
* Implemented a [simple VM creation form](./quickstart/simple-form-vm.md) in the [management console]({{ link-console-main }}).
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
* Added the [description of `gpus` resources](https://terraform-provider.yandexcloud.net/Resources/compute_instance) to the provider documentation.