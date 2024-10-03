---
title: How to delete a disk snapshot schedule {{ compute-full-name }}
description: Follow this guide to delete a disk snapshot schedule.
---

# Deleting a disk snapshot schedule

To delete a [disk snapshot](../../concepts/snapshot.md) [schedule](../../concepts/snapshot-schedule.md):

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the schedule is located.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.switch_snapshots }}**.
   1. Go to the **{{ ui-key.yacloud.compute.snapshots-schedules.label_title }}** tab.
   1. Next to the schedule to delete, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
   1. Confirm the schedule deletion.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View the description of the [CLI](../../../cli/) commands for managing schedules:

      ```bash
      yc compute snapshot-schedule --help
      yc compute snapshot-schedule delete --help
      ```

   1. Get a list of schedules in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc compute snapshot-schedule list --format yaml
      ```

      Result:

      ```text
      - id: fc852cvb1ipd5********
        folder_id: e1ea8s8l71li********
        created_at: "2022-09-28T13:25:02Z"
      ...
          expression: 10 19 ? * *
        snapshot_count: "7"
        snapshot_spec: {}
      ```

   1. Delete the selected schedule:

      ```bash
      yc compute snapshot-schedule delete <name_or_ID_of_the_schedule>
      ```

      Result:

      ```text
      done (5s)
      ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   1. Open the {{ TF }} configuration file and delete the fragment with the schedule description:

      {% cut "Sample schedule description in the {{ TF }} configuration" %}

      ```hcl
      resource "yandex_compute_snapshot_schedule" "default" {
        name = "my-name"

        schedule_policy {
          expression = "0 0 * * *"
        }

        snapshot_count = 1

        snapshot_spec {
            description = "snapshot-description"
            labels = {
              snapshot-label = "my-snapshot-label-value"
            }
        }

        disk_ids = ["test_disk_id", "another_test_disk_id"]
      }
      ```

      {% endcut %}

   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

   You can check the schedule deletion using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

   ```bash
   yc compute snapshot-schedule list
   ```

- API {#api}

   1. Get the list of schedules using the [list](../../api-ref/SnapshotSchedule/list.md) REST API method for the [SnapshotSchedule](../../api-ref/SnapshotSchedule/index.md) resource or the [SnapshotScheduleService/List](../../api-ref/grpc/snapshot_schedule_service.md#List) gRPC API call.
   1. Delete a snapshot schedule using the [delete](../../api-ref/SnapshotSchedule/delete.md) REST API method for the `SnapshotSchedule` resource or the [SnapshotScheduleService/Delete](../../api-ref/grpc/snapshot_schedule_service.md#Delete) gRPC API call.

{% endlist %}

All snapshot creation and deletion operations that started prior to deleting the schedule will be completed.