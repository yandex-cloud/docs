---
title: How to get information about a disk snapshot schedule in {{ compute-full-name }}
---

# Getting information about a disk snapshot schedule

{% list tabs %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with your [schedule](../../concepts/snapshot-schedule.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.switch_snapshots }}**.
  1. Go to the **{{ ui-key.yacloud.compute.snapshots-schedules.label_title }}** tab.
  1. Select the required schedule.
  1. The **{{ ui-key.yacloud.common.overview }}** page will display detailed information about the disk snapshot schedule.

- CLI

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to get information about a schedule:

      ```bash
      yc compute snapshot-schedule get --help
      ```

  1. Get information about your schedule by specifying its name or ID:

      ```bash
      yc compute snapshot-schedule get <schedule_name>
      ```

      Result:

      ```text
      id: fd8cc5qd25cp********
      folder_id: b1gmit33ngp3********
      created_at: "2023-10-30T14:53:33Z"
      name: schedule-1
      status: ACTIVE
      schedule_policy:
        start_at: "2023-10-30T14:00:51Z"
        expression: 0 10 */1 * *
      snapshot_count: "2"
      snapshot_spec: {}
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To get information about a [disk snapshot schedule](../../concepts/snapshot-schedule.md) using {{ TF }}:

  1. Add the `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_compute_snapshot_schedule" "snapshot_schedule" {
        snapshot_schedule_id = "<schedule_ID>"
      }

      output "snapshot_schedule" {
        value = data.yandex_compute_snapshot_schedule.snapshot_schedule.status
      }
      ```

      Where:

      * `data "yandex_compute_snapshot_schedule"`: Description of the disk snapshot schedule as a data source:
        * `snapshot_schedule_id`: Disk snapshot schedule ID.
      * `output "snapshot_schedule"`: Output variable that contains information about the disk snapshot schedule:
        * `value`: Returned value.

      You can replace `status` with any other parameter to get the information you need. For more information about the `yandex_compute_snapshot_schedule` data source parameters, see the [relevant provider documentation]({{ tf-provider-datasources-link }}/compute_snapshot_schedule).

  1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create the required resources and display the output variable values in the terminal. To check the results, run:

      ```bash
      terraform output
      ```

      Result:

      ```text
      snapshot_schedule = "inactive"
      ```

- API {#api}

  To get detailed information about a [disk snapshot schedule](../../concepts/snapshot-schedule.md), use the [get](../../api-ref/SnapshotSchedule/get.md) REST API method for the [SnapshotSchedule](../../api-ref/SnapshotSchedule/index.md) resource or the [SnapshotScheduleService/Get](../../api-ref/grpc/SnapshotSchedule/get.md) gRPC API call.

{% endlist %}