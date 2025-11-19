---
title: Getting started with {{ backup-full-name }}
description: This guide describes how you can get started with {{ backup-name }}.
---

# Getting started with {{ backup-full-name }}


{{ backup-name }} is a service for creating backups and restoring {{ yandex-cloud }} resources and their data.

You can connect to {{ backup-name }} either a new {{ compute-full-name }} [VM](../../compute/concepts/vm.md) as soon as its is created or an existing VM with active and configured apps, resources, data, etc.

For {{ backup-name }} to be able to back up and restore a VM, the VM must be associated with a [backup policy](../concepts/policy.md).

For more information on the minimum required VM characteristics and supported operating systems, see [{#T}](../concepts/vm-connection.md).

Depending on what you need, you can:

* [Start using {{ backup-name }} on a newly created VM](./new-vm.md)
* [Start using {{ backup-name }} on an existing VM](./existing-vm.md)