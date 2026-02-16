---
title: How to move a disk to a different availability zone in {{ compute-full-name }}
description: Follow this guide to move a disk to a different availability zone.
---

# Moving a disk to a different availability zone

When creating a disk, you place it within one specific [availability zone](../../../overview/concepts/geo-scope.md). You can move it to a different zone using a [snapshot](../../concepts/snapshot.md) or a special command in the [management console]({{ link-console-main }}) or [CLI](../../../cli/cli-ref/compute/cli-ref/disk/relocate.md).

If a disk is attached to a VM, it will be moved as part of the [VM migration](../vm-control/vm-change-zone.md). You cannot migrate attached disks separately from their VMs.


{% include [relocate-note](../../../_includes/compute/relocate-note.md) %}


## Moving a disk by creating a snapshot {#relocate-via-snapshot}

### Prepare the disks {#prepare-disks}

{% include [prepare-snapshots](../../../_includes/compute/prepare-snapshots.md) %}

### Create snapshots {#create}

To [create](../disk-control/create-snapshot.md) a disk snapshot:

{% include [create-snapshot](../../../_includes/compute/create-snapshot.md) %}

Repeat the steps above to create snapshots of all the disks.

### Create a VM in a different availability zone with the disks from the snapshots {#create-vm}

To [create](../vm-create/create-from-snapshots.md) a VM in a different availability zone with disks from snapshots:

{% include [create-from-snapshot](../../../_includes/compute/create-from-snapshot.md) %}

## Moving a disk using a special command {#relocate-command}

{% note info %}

Active writes to a disk being moved may cause the migration to fail. In this case, stop writing to the disk or shut down the VM and restart the migration.

{% endnote %}

To attach a disk to a VM from a different availability zone, move it first:

{% list tabs group=instructions %}


- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for moving a disk:

     ```bash
     {{ yc-compute }} disk relocate --help
     ```

  1. Request a list of available disks:

     {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

  1. Select `ID` of the disk you need.

  1. Move the disk to a different availability zone:

      ```bash
      {{ yc-compute }} disk relocate --id <disk_ID> \
        --destination-zone-id <availability_zone>
      ```

      Where:

      * `--id`: ID of the disk to move.
      * `--destination-zone-id`: ID of the availability zone to move the disk to, e.g., `{{ region-id }}-a`.

      If moving a [disk in a placement group](../../concepts/disk-placement-group.md), provide the group ID in the `--disk-placement-group-id` parameter.

{% endlist %}

{% note info %}

The time it takes to move a disk to a different availability zone depends on the disk size. As an example, a 100 GB disk typically migrates within 10 minutes.

In some cases, the migration may take longer if you are moving it to the `{{ region-id }}-d` availability zone.

{% endnote %}