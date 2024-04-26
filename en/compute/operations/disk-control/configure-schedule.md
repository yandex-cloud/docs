---
title: "How to configure disk snapshot schedules in {{ compute-full-name }}"
description: "Follow this guide to to configure disk snapshot schedules."
---

# Configuring disk snapshot schedules


For a disk, you can create [schedules](../../concepts/snapshot-schedule.md) of [snapshot](../../concepts/snapshot.md) creation:

* [{#T}](#add-schedule).
* [{#T}](#remove-schedule).

## Adding a schedule to a disk {#add-schedule}

{% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where the disk is located.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. Open the ![image](../../../_assets/console-icons/hard-drive.svg) tab **{{ ui-key.yacloud.compute.switch_disks }}** and choose the disk.
   1. Under **{{ ui-key.yacloud.compute.snapshots-schedules.label_title }}**, click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.compute.snapshots-schedules.action_edit-disk-schedules }}**.
   1. Choose a schedule or create a new one. For more information about setting up schedules, see [this guide](../snapshot-control/create-schedule.md).
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View the description of the CLI commands for managing disks and schedules:

      ```bash
      yc compute disk --help
      yc compute snapshot-schedule --help
      ```

   1. Get IDs of disks that are in the default folder:

      ```bash
      yc compute disk list --format yaml
      ```
      Result:
      ```text
      - id: epdcq9g3co9s********
        folder_id: e1ea8s8l71li********
        created_at: "2022-10-13T14:37:44Z"
        name: disk-2
        type_id: network-hdd
        zone_id: {{ region-id }}-a
        size: "21474836480"
        block_size: "4096"
        product_ids:
          - f2euv1kekdgv********
        status: READY
        source_image_id: fd88d14a6790********
        instance_ids:
          - ephothb6lppn********
        disk_placement_policy: {}
      - id: fhm7mip40dqh********
        folder_id: e1ea8s8l71li********
        created_at: "2022-10-10T05:00:04Z"
        name: disk-1
        type_id: network-hdd
        zone_id: {{ region-id }}-a
        size: "21474836480"
        block_size: "4096"
        product_ids:
          - f2euv1kekdgv********
        status: READY
        source_image_id: fd88d14a6790********
        instance_ids:
          - fhm1c7u23aiq********
        disk_placement_policy: {}
      ```
      For more information about the `yc compute disk list` command, see the [CLI reference](../../../cli/cli-ref/managed-services/compute/disk/list.md).

      To get a list of disks added to a given schedule, you can also use the command:

      ```bash
      yc compute snapshot-schedule list-disks <name_or_ID_of_the_schedule>
      ```
      See [more info](../../../cli/cli-ref/managed-services/compute/snapshot-schedule/list-disks.md).

   1. Get the name or ID of the schedule:

      ```bash
      yc compute snapshot-schedule list --format yaml
      ```
      Result:
      ```text
      - id: fc852cvb1ipd5********
        folder_id: e1ea8s8l71li********
        created_at: "2022-09-28T13:25:02Z"
        name: sched-1
        status: ACTIVE
        schedule_policy:
          start_at: "2022-10-01T00:00:00Z"
          expression: 59 14 */1 * *
        snapshot_spec: {}
      - id: fc89n1j15l7f********
        folder_id: e1ea8s8l71li********
        created_at: "2022-09-27T16:04:13Z"
        name: sched-2
        status: ACTIVE
        schedule_policy:
          start_at: "1970-01-01T00:00:00Z"
          expression: 0 */1 * * *
        retention_period: 3600s
        snapshot_spec: {}
      - id: fc8bplhqmh2b********
        folder_id: b8gauskl78li********
        created_at: "2022-10-03T13:28:01Z"
        name: sched-3
        description: Daily
        labels:
          machine: file-server
        status: ACTIVE
        schedule_policy:
          start_at: "2022-12-31T19:04:05Z"
          expression: 10 19 ? * *
        snapshot_count: "7"
        snapshot_spec: {}
      ```

      If you do not have a schedule, [create](../snapshot-control/create-schedule.md) one.

   1. Add one or several disks to the schedule:

      ```bash
      yc compute snapshot-schedule add-disks <name_or_ID_of_the_schedule> \
        --disk-id <ID_of_disk_1>,<ID_of_disk_2>
      ```
      Result:
      ```text
      done (3s)
      id: fc8e52mvchb2********
      folder_id: e1iaui8l7kli********
      created_at: "2022-09-28T09:15:28Z"
      name: sched-1
      status: ACTIVE
      ```

{% endlist %}

## Detaching a schedule from a disk {#remove-schedule}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where the disk is located.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. Open the ![image](../../../_assets/console-icons/hard-drive.svg) tab **{{ ui-key.yacloud.compute.switch_disks }}** and choose the disk.
   1. Under **{{ ui-key.yacloud.compute.snapshots-schedules.label_title }}**, in the line with the schedule, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.compute.snapshots-schedules.action_detach-schedule }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View the description of the CLI commands for managing disks and schedules:

      ```bash
      yc compute disk --help
      yc compute snapshot-schedule --help
      ```

   1. Get the name or ID of the schedule:

      ```bash
      yc compute snapshot-schedule list --format yaml
      ```
      Result:
      ```text
      - id: fc852cvb1ipd5********
        folder_id: e1ea8s8l71li********
        created_at: "2022-09-28T13:25:02Z"
        name: sched-1
        status: ACTIVE
        schedule_policy:
          start_at: "2022-10-01T00:00:00Z"
          expression: 59 14 */1 * *
        snapshot_spec: {}
      - id: fc89n1j15l7f********
        folder_id: e1ea8s8l71li********
        created_at: "2022-09-27T16:04:13Z"
        name: sched-2
        status: ACTIVE
        schedule_policy:
          start_at: "1970-01-01T00:00:00Z"
          expression: 0 */1 * * *
        retention_period: 3600s
        snapshot_spec: {}
      - id: fc8bplhqmh2b********
        folder_id: e1ea8s8l71li********
        created_at: "2022-10-03T13:28:01Z"
        name: sched-3
        description: Daily
        labels:
          machine: file-server
        status: ACTIVE
        schedule_policy:
          start_at: "2022-12-31T19:04:05Z"
          expression: 10 19 ? * *
        snapshot_count: "7"
        snapshot_spec: {}
      ```

   1. Get a list of disks used in the current schedule:

      ```bash
      yc compute snapshot-schedule list-disks <name_or_ID_of_the_schedule> \
        --format yaml
      ```
      Result:
      ```text
      - id: epdcq9g3co9s********
        folder_id: e1ea8s8l71li********
        created_at: "2022-10-13T14:37:44Z"
        name: disk-2
        type_id: network-hdd
        zone_id: {{ region-id }}-a
        size: "21474836480"
        block_size: "4096"
        product_ids:
          - f2euv1kekdgv********
        status: READY
        source_image_id: fd88d14a6790********
        instance_ids:
          - epdothb6lppn********
        disk_placement_policy: {}
      - id: fhm7mip40dqh********
        folder_id: e1ea8s8l71li********
        created_at: "2022-10-10T05:00:04Z"
        name: disk-1
        type_id: network-hdd
        zone_id: {{ region-id }}-a
        size: "21474836480"
        block_size: "4096"
        product_ids:
          - f2euv1kekdgv********
        status: READY
        source_image_id: fd88d14a6790********
        instance_ids:
          - fhm1c7u23aiq********
        disk_placement_policy: {}
      ```

   1. Delete one or more disks from the schedule:

      ```bash
      yc compute snapshot-schedule remove-disks <name_or_ID_of_the_schedule> \
        --disk-id <ID_of_disk_1>,<ID_of_disk_2>
      ```
      Result:
      ```text
      done (3s)
      id: fc8e52mvchb2********
      folder_id: e1ea8s8l71li********
      created_at: "2022-09-28T09:15:28Z"
      name: sched-1
      status: ACTIVE
      ```


{% endlist %}


#### See also {#see-also}

* [{#T}](../snapshot-control/create-schedule.md)
* [Changing a disk list in a snapshot schedule](../snapshot-control/update-schedule.md#update-disk-list)
* [Creating a disk snapshot manually](../disk-control/create-snapshot.md)
