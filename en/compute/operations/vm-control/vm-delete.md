---
title: How to delete a VM
description: Follow this guide to delete a VM.
---

# Deleting a VM

{% note warning %}

Deleting a VM is permanent and cannot be undone, so you cannot recover a deleted VM.

{% endnote %}

{% include [disk-auto-delete](../../_includes_service/disk-auto-delete.md) %}

Disks attached to a VM prior to its deletion will automatically be detached. The disk data will be preserved, and you will be able to attach these disks to another VM when needed.

{% include [delete-vm](../../../_includes/compute/delete-vm.md) %}
