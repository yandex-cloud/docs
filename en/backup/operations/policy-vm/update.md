---
title: Updating a backup policy in {{ backup-full-name }}
description: In this tutorial, you will learn how to update a backup policy in {{ backup-full-name }}.
---

# Updating a backup policy


{% include [policy-execute-time](../../../_includes/backup/policy-execute-time.md) %}

## Updating basic settings {#update-basic-parameters}

{% list tabs group=instructions %}

- Management console {#console}
  
  {% note warning %}
  
  You cannot update backup policies with some advanced settings in the {{ yandex-cloud }} management console. To update their settings, use the {{ yandex-cloud }} CLI, {{ TF }}, or API.

  If the backup policy updates did not take effect on the [resource](../../concepts/index.md#protected-resources) the policy was associated with earlier, [unlink](detach-vm.md) the policy from the resource and then [link](attach-and-detach-vm.md) it again.

  {% endnote %}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to update a [backup policy](../../../backup/concepts/policy.md).
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. In the left-hand panel, select ![policies](../../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.backup.label_policies }}**.
  1. Click ![options](../../../_assets/console-icons/ellipsis.svg) next to the backup policy you want to update and select **{{ ui-key.yacloud.common.edit }}**.
  1. Edit the backup policy parameters:

      * Enter a name. The naming requirements are as follows:

        {% include [name-format](../../../_includes/name-format.md) %}

      * Under **{{ ui-key.yacloud.backup.policy-form.title_schedule-section }}**, depending on the selected run schedule type configured when creating the policy:

          {% include [policy-options-schedule-type](../../../_includes/backup/policy-options-schedule-type.md) %}

      {% include [policy-options-retention](../../../_includes/backup/policy-options-retention.md) %}

      * Under **{{ ui-key.yacloud.backup.policy-form.title_additional-section }}**:

          {% include [policy-options-additional](../../../_includes/backup/policy-options-additional.md) %}

          {% include [policy-options-extra](../../../_includes/backup/policy-options-extra.md) %}

  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../../cli/) command to update a [backup policy](../../../backup/concepts/policy.md):

      ```bash
      yc backup policy update --help
      ```

  1. Specify backup policy configuration in [JSON](https://en.wikipedia.org/wiki/JSON) format.

      {% cut "Configuration file example" %}

      {% include [json-example](../../../_includes/backup/operations/json-example.md) %}

      {% endcut %}

      The example presents a backup policy configuration that will create [incremental](../../concepts/backup.md#types) [backups](../../concepts/backup.md) of the [resource](../../concepts/index.md#protected-resources) every Monday at 00:05 (UTC+0). Only the last 10 backups will be stored.

      The full specification is described in [{#T}](../../concepts/policy.md#specification).


  1. Get the ID of the backup policy you want to update:

      {% include [get-policy-id](../../../_includes/backup/operations/get-policy-id.md) %}

  1. Update the backup policy by specifying its ID:

      ```bash
      yc backup policy update <backup_policy_ID> \
        --settings-from-file <path_to_configuration_file>
      ```

      Where `--settings-from-file` is the path to the backup policy configuration file in JSON format.

      Result:

      {% include [json-output-cli](../../../_includes/backup/operations/json-output-cli.md) %}

      For more information about the command, see the [CLI reference](../../../cli/cli-ref/backup/cli-ref/policy/update.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To edit the basic parameters of a [backup policy](../../../backup/concepts/policy.md):
  1. Open the {{ TF }} configuration file and edit the required settings in the `yandex_backup_policy` resource description fragment:

     {% cut "Below is an example with the description of the `yandex_backup_policy` resource in the {{ TF }} configuration" %}

     ```hcl
     resource "yandex_backup_policy" "my_policy" {
         archive_name                      = "[<name_of_resource_to_back_up>]-[<plan_ID>]-[<unique_ID>]"
         cbt                               = "USE_IF_ENABLED"
         compression                       = "NORMAL"
         fast_backup_enabled               = true
         format                            = "AUTO"
         multi_volume_snapshotting_enabled = true
         name                              = "<backup_policy_name>"
         performance_window_enabled        = true
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

             backup_sets {
                 execute_by_time {
                     type                      = "MONTHLY"
                     include_last_day_of_month = true
                     monthdays                 = []
                     months                    = [1,2,3,4,5,6,7,8,9,10,11,12]
                     repeat_at                 = ["04:10"]
                     repeat_every              = "30m"
                     weekdays                  = []
                 }
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

     For more on the properties of the `yandex_backup_policy` resource, see [this provider guide]({{ tf-provider-resources-link }}/backup_policy).
  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     You can check the updates using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

     ```bash
     yc backup policy get <backup_policy_ID>
     ```

- API {#api}

  To update the basic parameters of a [backup policy](../../concepts/policy.md), use the [update](../../backup/api-ref/Policy/update.md) REST API method for the [Policy](../../backup/api-ref/Policy/index.md) resource or the [PolicyService/Update](../../backup/api-ref/grpc/Policy/update.md) gRPC API call.

{% endlist %}

## Editing the list of resources to back up {#update-vm-list}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your backup policy.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Navigate to the ![policies](../../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.backup.label_policies }}** tab.
  1. Select the backup policy in which you want to edit the list of [resources to back up](../../concepts/index.md#protected-resources).
  1. Edit the list of linked resources:
     * To link a new VM or server, click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.backup.button_attach-instance }}** and in the window that opens:

        * Depending on the resource you want to link to the backup policy, select the **{{ ui-key.yacloud.backup.value_vm-recourses }}** or **{{ ui-key.yacloud.backup.value_bms-recourses }}** tab and select the VM or server from the list.

           If the VM or server you want to link to the backup policy is not listed, make sure it is connected to {{ backup-name }}.
        * Click **{{ ui-key.yacloud_billing.backup.button_attach-instance-submit }}**.
     * To unlink a VM or server from a policy:

        * Depending on the resource you want to unlink from the backup policy, select the **{{ ui-key.yacloud.backup.value_vm-recourses }}** or **{{ ui-key.yacloud.backup.value_bms-recourses }}** tab.
        * In the row with the VM or server you want to unlink from the backup policy, click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.backup.action_detach-vm-instance }}** or **{{ ui-key.yacloud.backup.action_detach-baremetal-instance }}**, respectively.
        * In the window that opens, confirm this action.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Get the ID of the backup policy in which you want to edit the list of [resources to back up](../../concepts/index.md#protected-resources):

     {% include [get-policy-id](../../../_includes/backup/operations/get-policy-id.md) %}

  1. Get the IDs of resources connected to {{ backup-name }} which you need to add or delete:

     {% include [get-resource-ids](../../../_includes/backup/operations/get-resource-ids.md) %}

  1. Edit the list of resources in the backup policy.
     * To link a resource to a backup policy:

       View the CLI command description:

       ```bash
       yc backup policy apply --help
       ```

       Link resources to the backup policy by specifying its ID:

       ```bash
       yc backup policy apply <backup_policy_ID> \
         --instance-ids <IDs_of_resources_to_back_up>
       ```

       Where `--instance-ids` are the IDs of the [{{ compute-name }} VMs](../../concepts/vm-connection/compute.md), [{{ baremetal-name }} servers](../../concepts/vm-connection/baremetal.md), or [external resources](../../concepts/vm-connection/external-resources.md) connected to {{ backup-name }} which you need to link to the backup policy. Multiple IDs should be comma-separated.

       For more information about this command, see the [CLI reference](../../../cli/cli-ref/backup/cli-ref/policy/apply.md).
     * To unlink resources from a backup policy:

       View the CLI command description:

       ```bash
       yc backup policy revoke --help
       ```

       Unlink resources from the backup policy by specifying its ID:

       ```bash
       yc backup policy revoke <backup_policy_ID> \
         --instance-ids <IDs_of_resources_to_back_up>
       ```

       Where `--instance-ids` are the IDs of the [{{ compute-name }} VMs](../../concepts/vm-connection/compute.md), [{{ baremetal-name }} servers](../../concepts/vm-connection/baremetal.md), or [external resources](../../concepts/vm-connection/external-resources.md) which you need to unlink from the backup policy. Multiple IDs should be comma-separated.

       For more information about this command, see the [CLI reference](../../../cli/cli-ref/backup/cli-ref/policy/revoke.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To edit the list of [resources](../../concepts/index.md#protected-resources) linked to the backup policy:

  1. In the {{ TF }} configuration file, describe the policy linking parameters for each resource that needs to be backed up in separate sections:

      ```hcl
      resource "yandex_backup_policy_bindings" "test_backup_binding_1" {
        instance_id = "<resource_1_ID>"
        policy_id   = "<policy_ID>"
      }

      resource "yandex_backup_policy_bindings" "test_backup_binding_2" {
        instance_id = "<resource_1_ID>"
        policy_id   = "<policy_ID>"
      }
      ```

      Where:

      * `instance_id`: IDs of resources to link to the policy.

          You can get the list of IDs of resources linked to {{ backup-name }} in the default folder by using the `yc backup vm list` {{ yandex-cloud }} CLI command.
      * `policy_id`: ID of the backup policy to link the resources to.

     For more information about `yandex_backup_policy_bindings` properties, see [this provider guide]({{ tf-provider-resources-link }}/backup_policy_bindings).
  1. Create {{ TF }} resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all the required resources. You can check the new resources in the [management console]({{ link-console-main }}) or using this [CLI](../../../cli/quickstart.md) command:

     ```bash
      yc backup policy list-applications
     ```

- API {#api}

  To edit the list of [resources](../../concepts/index.md#protected-resources) covered by a [backup policy](../../concepts/policy.md), use the [update](../../backup/api-ref/Policy/update.md) REST API method for the [Policy](../../backup/api-ref/Policy/index.md) resource or the [PolicyService/Update](../../backup/api-ref/grpc/Policy/update.md) gRPC API call.

{% endlist %}

#### Useful links {#see-also}

* [{#T}](delete.md)
