---
title: "How to move a VM to a different availability zone"
description: "Follow this guide to move a VM to a different availability zone."
---

# Moving a VM to a different availability zone

{% include [instance-az](../../_includes_service/instance-az.md) %}

## Create a snapshot of each of the VM's disks {#create-snapshot}

### Prepare the disks {#prepare-disks}

{% include [prepare-snapshots](../../../_includes/compute/prepare-snapshots.md) %}

### Create snapshots {#create}

To [create](../disk-control/create-snapshot.md) a disk snapshot:

{% include [create-snapshot](../../../_includes/compute/create-snapshot.md) %}

Repeat the steps to create a snapshot of each disk.

## Create a VM in a different availability zone with the disks from the snapshots {#create-vm}

To [create](../vm-create/create-from-snapshots.md) a VM in a different availability zone with the disks from the snapshots:

{% include [create-from-snapshot](../../../_includes/compute/create-from-snapshot.md) %}

## Delete the original VM {#delete-vm}

To [delete](vm-delete.md) the original VM:

{% include [delete-vm](../../../_includes/compute/delete-vm.md) %}
