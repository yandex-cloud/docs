---
title: How to delete a VM
description: Follow this guide to delete a VM.
---

# Deleting a VM

{% note warning %}

Deleting a VM is an operation that cannot be canceled or reversed. You cannot restore a deleted VM.

{% endnote %}

{% include [disk-auto-delete](../../_includes_service/disk-auto-delete.md) %}

If you have disks attached to your VM, the disks will be detached when you delete the VM. The disk data will be preserved, and you will be able to attach these disks to another VM when needed.

{% include [delete-vm](../../../_includes/compute/delete-vm.md) %}
