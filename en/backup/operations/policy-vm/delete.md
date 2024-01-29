---
title: "Deleting a backup policy"
description: "In this tutorial, you will learn how to delete a backup policy in **{{ backup-name }}**."
---

# Deleting a backup policy

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder to delete the policy from.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
   1. Go to the ![policies](../../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.backup.label_policies }}** tab.
   1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the appropriate policy, and select **{{ ui-key.yacloud.common.delete }}**.
   1. Confirm the deletion.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to delete a backup policy:

      ```bash
      yc backup policy delete --help
      ```

   1. Get the ID of the backup policy to delete:

      {% include [get-policy-id](../../../_includes/backup/operations/get-policy-id.md) %}

   1. Delete the policy by specifying its ID:

      ```bash
      yc backup policy delete <policy_ID>
      ```

      For more information about the command, see the [CLI reference](../../../cli/cli-ref/managed-services/backup/policy/delete.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To delete a backup policy created with {{ TF }}:

  1. Open the {{ TF }} configuration file and delete the fragment with the `yandex_backup_policy` resource description:

     
     {% cut "Sample `yandex_backup_policy` resource description in the {{ TF }} configuration" %}

     ```
     resource "yandex_backup_policy" "my_policy" {
         archive_name                      = "[<VM_name>]-[<plan_ID>]-[<unique_ID>]a"
         cbt                               = "USE_IF_ENABLED"
         compression                       = "NORMAL"
         fast_backup_enabled               = true
         format                            = "AUTO"
         multi_volume_snapshotting_enabled = true
         name                              = "<policy_name>"
         performance_window_enabled        = true
         preserve_file_security_settings   = true
         quiesce_snapshotting_enabled      = true
         silent_mode_enabled               = true
         splitting_bytes                   = "9223372036854775807"
         vss_provider                      = "NATIVE"

         reattempts {
             enabled      = true
             interval     = "1m"
             max_attempts = 10
         }

         retention {
             after_backup = false

             rules {
                 max_age       = "365d"
                 repeat_period = []
             }
         }

         scheduling {
             enabled              = false
             max_parallel_backups = 0
             random_max_delay     = "30m"
             scheme               = "ALWAYS_INCREMENTAL"
             weekly_backup_day    = "MONDAY"

             execute_by_time {
                 include_last_day_of_month = true
                 monthdays                 = []
                 months                    = [1,2,3,4,5,6,7,8,9,10,11,12]
                 repeat_at                 = ["04:10"]
                 repeat_every              = "30m"
                 type                      = "MONTHLY"
                 weekdays                  = []
             }
         }

         vm_snapshot_reattempts {
             enabled      = true
             interval     = "1m"
             max_attempts = 10
         }
     }
     ```

     {% endcut %}


     For more information about the `yandex_backup_policy` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/backup_policy).

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

     You can check the update using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

     ```bash
     yc backup policy list
     ```

- API {#api}

   To delete a [backup policy](../../concepts/policy.md), use the [delete](../../backup/api-ref/Policy/delete.md) REST API method for the [Policy](../../backup/api-ref/Policy/index.md) resource or the [PolicyService/Delete](../../backup/api-ref/grpc/policy_service.md#Delete) gRPC API call.

{% endlist %}
