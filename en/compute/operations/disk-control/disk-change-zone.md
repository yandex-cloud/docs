---
title: How to move a disk to a different availability zone in {{ compute-full-name }}
description: Follow this guide to move a disk to a different availability zone.
---

# Moving a disk to a different availability zone

A disk is created in a single [availability zone](../../../overview/concepts/geo-scope.md). You can move it to a different zone using a [snapshot](../../concepts/snapshot.md) or a special command in the [management console]({{ link-console-main }}) or the [CLI](../../../cli/cli-ref/compute/cli-ref/disk/relocate.md).

If a disk is attached to a VM, it will be moved during [VM migration](../vm-control/vm-change-zone.md). You cannot migrate attached disks separately from their VMs.


{% include [relocate-note](../../../_includes/compute/relocate-note.md) %}


## Moving a disk by creating a snapshot {#relocate-via-snapshot}

### Prepare the disks {#prepare-disks}

{% include [prepare-snapshots](../../../_includes/compute/prepare-snapshots.md) %}

### Create snapshots {#create}

To [create](../disk-control/create-snapshot.md) a disk snapshot:

{% include [create-snapshot](../../../_includes/compute/create-snapshot.md) %}

Repeat the steps to create a snapshot of each disk.

### Create a VM in a different availability zone with the disks from the snapshots {#create-vm}

To [create](../vm-create/create-from-snapshots.md) a VM in a different availability zone with the disks from the snapshots:

{% include [create-from-snapshot](../../../_includes/compute/create-from-snapshot.md) %}

## Moving a disk using a special command {#relocate-command}

{% note info %}

If data is being written to the disk, its move may fail. In this case, stop the disk write operation or shut down the VM and restart the move.

{% endnote %}

To attach the disk to a VM from a different availability zone, move it:

{% list tabs group=instructions %}

- Management console {#console}

   {% note warning %}

   Currently, the management console allows moving disks only from the `{{ region-id }}-c` availability zone. To move disks from other availability zones, use the CLI or snapshots.

   {% endnote %}

   1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.switch_disks }}**.
   1. In the appropriate disk row, click ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.compute.button_relocate-to-another-zone }}**. In the window that opens:
      1. In the **{{ ui-key.yacloud.compute.field_new-availability-zone }}** field, choose the availability zone to move the disk to, e.g., `{{ region-id }}-d`.
      1. Click **{{ ui-key.yacloud.compute.instances.button_start-instance-relocation }}** to start moving the disk to a different availability zone.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View the description of the CLI disk move command:

      ```bash
      {{ yc-compute }} disk relocate --help
      ```

   1. Request a list of available disks:

      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

   1. Select the `ID` of the disk.

   1. Move the disk to a different availability zone:

      ```bash
      {{ yc-compute }} disk relocate --id <disk_ID> \
        --destination-zone-id <availability_zone>
      ```

      Where:

      * `--id`: ID of the disk you need to move.
      * `--destination-zone-id`: ID of the availability zone to move the disk to, e.g., `{{ region-id }}-a`.

      If you are moving a [disk in a placement group](../../concepts/disk-placement-group.md), provide the group ID in the `--disk-placement-group-id` parameter.

{% endlist %}

{% note info %}

The time it takes to move a disk to a different availability zone depends on the disk size. It takes about 10 minutes to move a 100 GB disk.

In some cases, the process may take longer if moving to the `{{ region-id }}-d` availability zone.

{% endnote %}
