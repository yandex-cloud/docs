---
title: '{{ compute-full-name }} release notes'
description: This section contains {{ compute-name }} release notes.
---

# {{ compute-full-name }} release notes

## Q2 2024 {#q2-2024}

* Increased network connection [limits](concepts/limits.md).

## Q1 2024 {#q1-2024}

* Now you can add and delete network interfaces without recreating VMs.
* Added support for the VHD virtual disk format.
* Fixed a {{ TF }} provider bug that appeared when creating a VM with several disks using the `Count` meta argument.
* Added the [description of `gpus` resources](https://terraform-provider.yandexcloud.net/Resources/compute_instance) in the provider documentation.