---
title: How to unlink a VM or server from a backup policy
description: In this article, you will learn how to unlink a VM or server from a backup policy.
---

# Unlinking a resource from a backup policy


To unlink a [resource](../../concepts/index.md#protected-resources) from a backup policy:

{% note info %}

Currently, you can unlink an [external](../../concepts/vm-connection/external-resources.md) resource from a backup policy using the [{{ yandex-cloud }} CLI](../../../cli/cli-ref/backup/cli-ref/policy/revoke.md), [API](../../backup/api-ref/Policy/revoke.md), or [{{ TF }}]({{ tf-provider-resources-link }}/backup_policy_bindings).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder where you want to unlink a resource from a backup policy.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Navigate to the ![policies](../../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud_billing.backup.label_policies }}** tab.
  1. Select the policy to unlink the resource from.
  1. Depending on the resource you want to unlink from the backup policy, under **{{ ui-key.yacloud.backup.title_linked-recourses }}**, select the **{{ ui-key.yacloud.backup.value_vm-recourses }}** or **{{ ui-key.yacloud.backup.value_bms-recourses }}** tab.
  1. In the row with the VM or server you want to unlink from the backup policy, click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.backup.action_detach-vm-instance }}** or **{{ ui-key.yacloud.backup.action_detach-baremetal-instance }}**, respectively.
  1. In the window that opens, confirm this action.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command to remove a [resource](../../concepts/index.md#protected-resources) from a backup policy: 

      ```bash
      yc backup policy revoke --help
      ```

  1. Get the ID of the policy to unlink the resource from:

      {% include [get-policy-id](../../../_includes/backup/operations/get-policy-id.md) %}

  1. Get the ID of the resource you want to unlink:

      {% include [get-resource-ids](../../../_includes/backup/operations/get-resource-ids.md) %}

  1. Unlink the resource by specifying the policy ID:

      ```bash
      yc backup policy revoke <policy_ID> \
        --instance-ids <IDs_of_resources_to_back_up>
      ```

      Where `--instance-ids` are the IDs of the [{{ compute-name }} VMs](../../concepts/vm-connection/compute.md), [{{ baremetal-name }} servers](../../concepts/vm-connection/baremetal.md), or [external resources](../../concepts/vm-connection/external-resources.md) which you need to unlink from the backup policy. Multiple IDs should be comma-separated.

  For more information about this command, see the [CLI reference](../../../cli/cli-ref/backup/cli-ref/policy/revoke.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To unlink a [resource](../../concepts/index.md#protected-resources) from a backup policy:

  1. Remove the section describing the binding you want to delete from the {{ TF }} configuration file:

      ```hcl
      resource "yandex_backup_policy_bindings" "test_backup_binding" {
        instance_id = "<resource_ID>"
        policy_id   = "<policy_ID>"
      }
      ```

      Where:

      * `instance_id`: ID of the resource you want to unlink from the policy.
      * `policy_id`: [ID](./get-info.md) of the backup policy to unlink the resource from.

     For more information about `yandex_backup_policy_bindings` properties, see [this provider guide]({{ tf-provider-resources-link }}/backup_policy_bindings).
  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all the required resources. You can check the new resources in the [management console]({{ link-console-main }}) or using this [CLI](../../../cli/quickstart.md) command:

     ```bash
      yc backup policy list-applications
     ```

- API {#api}

  Use the [revoke](../../backup/api-ref/Policy/revoke.md) REST API method for the [Policy](../../backup/api-ref/Policy/index.md) resource or the [PolicyService/Revoke](../../backup/api-ref/grpc/Policy/revoke.md) gRPC API call.

{% endlist %}

#### Useful links {#see-also}

* [{#T}](attach-and-detach-vm.md)
