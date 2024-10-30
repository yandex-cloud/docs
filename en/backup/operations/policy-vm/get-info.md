---
title: How to get information about a backup policy
description: In this tutorial, you will learn how to get information about a {{ backup-full-name }} backup policy.
---

# Getting information about a backup policy

Information on policies becomes available for viewing after you [activate](../../concepts/index.md#providers){{ backup-name }}.

{% include [default-policies](../../../_includes/backup/default-policies.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) your [backup policy](../../../backup/concepts/policy.md) is in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. In the left-hand panel, select ![policies](../../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.backup.label_policies }}**.
  1. Select the backup policy you want to view.
  1. The **Overview** page shows the backup policy details.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Get a list of [backup policies](../../../backup/concepts/policy.md) in the default folder:

     ```bash
     yc backup policy list
     ```  

     Result:

     ```bash
     +----------------------+----------------------+-----------------+---------+---------------------+---------------------+
     |          ID          |      FOLDER ID       |      NAME       | ENABLED |     CREATED AT      |     UPDATED AT      |
     +----------------------+----------------------+-----------------+---------+---------------------+---------------------+
     | cdgp2n2s73lg******** | b1gsm0k26v1l******** | Default daily   | true    | 2023-07-20 13:55:14 | 2024-08-15 08:27:41 |
     | cdguolnopexf******** | b1gsm0k26v1l******** | Default weekly  | true    | 2023-07-20 13:55:14 | 2023-09-05 16:24:05 |
     | cdgklelzc4pi******** | b1gsm0k26v1l******** | Default monthly | true    | 2023-07-20 13:55:15 | 2024-09-02 08:40:18 |
     +----------------------+----------------------+-----------------+---------+---------------------+---------------------+
     ```
  
     Save `ID` and `NAME` of the policy you want to get information on.

  1. View the description of the [CLI](../../../cli/) command for information about a backup policy:

     ```bash
     yc backup policy get --help
     ```

  1. Get information about the backup policy by specifying its name or ID:

     ```bash
     yc backup policy get <backup_policy_ID>
     ```

     Result:

     ```bash
     id: cdgvykqerzzc********
     name: Default weekly
     created_at: "2023-10-09T20:23:46.980915356Z"
     updated_at: "2023-10-09T20:23:46.978341789Z"
     enabled: true
     settings:
       compression: NORMAL
       format: AUTO
       multi_volume_snapshotting_enabled: true
       preserve_file_security_settings: true
       reattempts:
         enabled: true
         interval:
           type: SECONDS
           count: "30"
         max_attempts: "30"
     ...
     ```

  For more information about the command, see the [CLI reference](../../../cli/cli-ref/managed-services/backup/policy/get.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To get information about a [backup policy](../../concepts/policy.md) using {{ TF }}:

  1. Add the `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_backup_policy" "my_policy" {
        policy_id = "<policy_ID>"
      }

      output "my_policy_schedule" {
        value = data.yandex_backup_policy.my_policy.scheduling
      }
      ```

      Where:

      * `data "yandex_backup_policy"`: Description of the backup policy as a data source:
        * `policy_id`: Backup policy ID. You can also use the `name` parameter representing the name of the backup policy.
      * `output "my_policy_schedule"`: Output variable that contains information about the backup policy schedule:
        * `value`: Returned value.

      You can replace `scheduling` with any other [policy parameter]({{ tf-provider-resources-link }}/backup_policy) to get the information you need.

      For more information about the `yandex_backup_policy` data source parameters, see the [relevant provider documentation]({{ tf-provider-datasources-link }}/datasource_backup_policy).

  1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create the required resources and display the output variable values in the terminal. To check the results, run:

      ```bash
      terraform output
      ```

      Result:

      ```bash
      my_policy_name = toset([
        {
          "backup_sets" = toset([
            {
              "execute_by_interval" = 0
              "execute_by_time" = toset([
                {
                  "include_last_day_of_month" = false
                  "monthdays" = tolist([])
                  "months" = tolist([])
                  "repeat_at" = tolist([
                    "01:45",
      ...
      "enabled" = true
      "max_parallel_backups" = 2
      "random_max_delay" = "30m"
      "scheme" = "ALWAYS_INCREMENTAL"
      "weekly_backup_day" = "MONDAY"
      ...
      ```

- API {#api}

  To get detailed information about a [backup policy](../../concepts/policy.md), use the [get](../../backup/api-ref/Policy/get.md) REST API method for the [Policy](../../backup/api-ref/Policy/index.md) resource or the [PolicyService/Get](../../backup/api-ref/grpc/Policy/get.md) gRPC API call.

{% endlist %}