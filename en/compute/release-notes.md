# {{ compute-full-name }} release notes

This section contains {{ compute-name }} release notes.

## Q1 2024 {#q1-2024}

* Now you can add and delete network interfaces without recreating VMs.
* Added support for the VHD virtual disk format.
* Fixed a bug in the {{ TF }} provider that appeared when creating a VM with several disks using the `Count` meta argument.
* Added the [description of `gpus` resources](https://terraform-provider.yandexcloud.net/Resources/compute_instance) in the provider documentation.