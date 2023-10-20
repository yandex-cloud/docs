---
title: "How to move a VM to a different availability zone"
description: "This guide describes how you can move a VM to a different availability zone."
---

# Moving a VM to a different availability zone

{% include [instance-az](../../_includes_service/instance-az.md) %}

To change the availability zone of a VM:

1. Create a snapshot of each of the VM's disks, see [{#T}](../disk-control/create-snapshot.md).
1. Create a VM in a different availability zone with the disks from the snapshots, see [{#T}](../vm-create/create-from-snapshots.md).
1. Delete the original VM, see [{#T}](vm-delete.md).
