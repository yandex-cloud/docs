---
title: "How to update a backup policy in {{ backup-full-name }}"
description: "In this tutorial, you will learn how to update a backup policy in {{ backup-name }}."
---

# Updating a backup policy

## Changing basic settings {#update-basic-parameters}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to change the policy.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
   1. Go to the ![policies](../../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.backup.label_policies }}** tab.
   1. Next to the appropriate policy, click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
   1. Edit the policy parameters:

      {% include [policy-options](../../../_includes/backup/policy-options.md) %}

   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the update backup policy CLI command:

      ```bash
      yc backup policy update --help
      ```

   1. Specify a backup policy configuration in JSON format.

      {% cut "Sample configuration file" %}

      {% include [json-example](../../../_includes/backup/operations/json-example.md) %}

      {% endcut %}

      The example describes a configuration for a backup policy that will create [incremental](../../concepts/backup.md#types) VM backups every Monday at 00:05 (UTC+0). Only the last 10 backups will be stored.

      For more information, refer to [Full backup policy specification](../../concepts/policy.md#specification).

   1. Get the ID of the backup policy to update:

      {% include [get-policy-id](../../../_includes/backup/operations/get-policy-id.md) %}

   1. Update the backup policy by specifying its ID:

      ```bash
      yc backup policy update <policy_ID> \
        --settings-from-file <configuration_file_path>
      ```

      Where `--settings-from-file` is the path to the backup policy configuration file in JSON format.

      Result:

      ```bash
      id: cbq5rwepukxn********
      name: test2
      created_at: "2023-07-03T08:24:16.735555276Z"
      updated_at: "2023-07-03T08:24:16.746377738Z"
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
        silent_mode_enabled: true
        splitting:
          size: "1099511627776"
        vm_snapshot_reattempts:
          enabled: true
          interval:
            type: MINUTES
            count: "5"
          max_attempts: "3"
        vss:
          enabled: true
          provider: TARGET_SYSTEM_DEFINED
        archive:
          name: '''[Machine Name]-[Plan ID]-[Unique ID]A'''
        performance_window: {}
        retention:
          rules:
            - max_count: "10"
          after_backup: true
        scheduling:
          backup_sets:
            - time:
                weekdays:
                  - MONDAY
                repeat_at:
                  - minute: "5"
                type: WEEKLY
          enabled: true
          max_parallel_backups: "2"
          rand_max_delay:
            type: MINUTES
            count: "30"
          scheme: ALWAYS_INCREMENTAL
          weekly_backup_day: MONDAY
        cbt: ENABLE_AND_USE
        fast_backup_enabled: true
        quiesce_snapshotting_enabled: true
      folder_id: d2q792qpemb4********
      ```

      For more information about the command, see the [CLI reference](../../../cli/cli-ref/managed-services/backup/policy/update.md).

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To change the basic settings of a backup policy:

  1. Open the {{ TF }} configuration file and edit the required settings in the `yandex_backup_policy` resource description:

     
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
     yc backup policy get <policy_ID>
     ```

- API

   To update the basic parameters of a [backup policy](../../concepts/policy.md), use the [update](../../backup/api-ref/Policy/update.md) REST API method for the [Policy](../../backup/api-ref/Policy/index.md) resource or the [PolicyService/Update](../../backup/api-ref/grpc/policy_service.md#Update) gRPC API call.

{% endlist %}

## Updating a VM list {#update-vm-list}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the policy is located.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
   1. Go to the ![policies](../../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.backup.label_policies }}** tab.
   1. Select the policy for which to update the list of VMs.
   1. Update the list of VMs:

      * To add a new VM, click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.backup.button_attach-instance }}** under **{{ ui-key.yacloud.backup.label_linked-instances }}**. In the window that opens, select the VM to link to the policy and click **{{ ui-key.yacloud.backup.button_attach-instance-submit }}**.
      * To remove a VM, under **{{ ui-key.yacloud.backup.label_linked-instances }}**, click ![options](../../../_assets/console-icons/ellipsis.svg) next to the VM to be unlinked from the policy and select **{{ ui-key.yacloud.backup.action_detach-instance }}**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. Get the ID of the policy for which to update the list of VMs:

      {% include [get-policy-id](../../../_includes/backup/operations/get-policy-id.md) %}

   1. Get the IDs of VMs to add or delete:

      {% include [get-vm-id](../../../_includes/backup/operations/get-vm-id.md) %}

   1. Edit the list of VMs included in the backup policy:

      * To link a VM to a backup policy:

         View a description of the CLI command:

         ```bash
         yc backup policy apply --help
         ```

         Link your VMs to the backup policy by specifying their IDs:

         ```bash
         yc backup policy apply <policy_ID> \
           --instance-ids <VM_IDs>
         ```

         Where `--instance-ids` are the IDs of VMs to be linked to the backup policy. Multiple IDs should be comma-separated.

         For more information about the command, see the [CLI reference](../../../cli/cli-ref/managed-services/backup/policy/apply.md).

      * To unlink a VM from a backup policy:

         View a description of the CLI command:

         ```bash
         yc backup policy revoke --help
         ```

         Unlink your VMs from the backup policy by specifying their IDs:

         ```bash
         yc backup policy revoke <policy_ID> \
           --instance-ids <VM_IDs>
         ```

         Where `--instance-ids` are the IDs of VMs to be unlinked from the backup policy. Multiple IDs should be comma-separated.

         For more information about the command, see the [CLI reference](../../../cli/cli-ref/managed-services/backup/policy/revoke.md).

- API

   To update the list of VMs whose backups are created based on a [backup policy](../../concepts/policy.md), use the [update](../../backup/api-ref/Policy/update.md) REST API method for the [Policy](../../backup/api-ref/Policy/index.md) resource or the [PolicyService/Update](../../backup/api-ref/grpc/policy_service.md#Update) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](delete.md)
