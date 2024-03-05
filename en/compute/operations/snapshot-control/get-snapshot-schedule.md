---
title: "How to get information about a disk snapshot schedule in {{ compute-full-name }}"
---

# Getting information about a disk snapshot schedule

You can view the schedule ID, the schedule creation time, and the snapshot policy.

To get information about a schedule:

{% list tabs %}

- CLI

   {% include [include](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to get information about a schedule:

      ```bash
      yc compute snapshot-schedule get --help
      ```

   1. Get information about your schedule by specifying its name or ID:

      ```bash
      yc compute snapshot-schedule get <schedule_name>
      ```

      Result:

      ```
      id: fd8cc5qd25cp********
      folder_id: b1gmit33ngp3********
      created_at: "2023-10-30T14:53:33Z"
      name: sched-1
      status: ACTIVE
      schedule_policy:
        start_at: "2023-10-30T14:00:51Z"
        expression: 0 10 */1 * *
      snapshot_count: "2"
      snapshot_spec: {}
      ```

{% endlist %}