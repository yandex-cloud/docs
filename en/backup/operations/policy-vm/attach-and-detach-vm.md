---
title: Linking a VM or {{ baremetal-name }} server to a backup policy
description: In this article, you will learn how to link a {{ compute-name }} VM or {{ baremetal-full-name }} server to a backup policy.
---

# Linking a VM or {{ baremetal-full-name }} server to a backup policy


You can only link a VM or {{ baremetal-name }} server to a backup policy if they are connected to {{ backup-full-name }}. For more information, see [{#T}](../index.md#connect-vm) and [{#T}](../index.md#connect-baremetal).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder where you want to link a VM or {{ baremetal-name }} server to a backup policy.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Navigate to the ![policies](../../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud_billing.backup.label_policies }}** tab.
  1. Select the policy to link the VM or {{ baremetal-name }} server to.
  1. Under **{{ ui-key.yacloud.backup.title_linked-recourses }}**, click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.backup.button_attach-instance }}**, and in the window that opens:

      1. Depending on the resource you want to link to the backup policy, select the **{{ ui-key.yacloud.backup.value_vm-recourses }}** or **{{ ui-key.yacloud.backup.value_bms-recourses }}** tab and select the VM or server from the list.

          If the VM or {{ baremetal-name }} server you want to link to the backup policy is not listed, make sure it is connected to {{ backup-name }}.
      1. Click **{{ ui-key.yacloud_billing.backup.button_attach-instance-submit }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to link a VM or {{ baremetal-name }} server to a backup policy: 

      ```bash
      yc backup policy apply --help
      ```

  1. Get the ID of the policy to link the VM or {{ baremetal-name }} server to:

      {% include [get-policy-id](../../../_includes/backup/operations/get-policy-id.md) %}

  1. Get the ID of the VM to link:

      {% include [get-vm-id](../../../_includes/backup/operations/get-vm-id.md) %}

      {% include [get-bms-ids](../../../_includes/backup/operations/get-bms-ids.md) %}

  1. Link the VM or {{ baremetal-name }} server by the policy ID:

      ```bash
      yc backup policy apply <policy_ID> \
        --instance-ids <VM_or_{{ baremetal-name }}_server_IDs>
      ```

      Where `--instance-ids` are the IDs of the VMs or {{ baremetal-name }} servers connected to {{ backup-name }} you need to link to the backup policy. Multiple IDs should be comma-separated.

  For more information about this command, see the [CLI reference](../../../cli/cli-ref/backup/cli-ref/policy/apply.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  {% note info %}

  Currently, you can only associate a [{{ compute-name }} VM instance](../../../compute/concepts/vm.md) with a [backup policy](../../../backup/concepts/policy.md) using {{ TF }}. To associate a [{{ baremetal-name }} server](../../../baremetal/concepts/servers.md), use the [management console]({{ link-console-main }}), [{{ yandex-cloud }} CLI](../../../cli/cli-ref/backup/cli-ref/policy/apply.md), or [API](../../backup/api-ref/Policy/apply.md).

  {% endnote %}

  To associate a VM with a backup policy:

  1. In the {{ TF }} configuration file, describe the parameters for associating the VM with the policy:

      ```hcl
      resource "yandex_backup_policy_bindings" "test_backup_binding" {
        instance_id = "<VM_ID>"
        policy_id   = "<policy_ID>"
      }
      ```

      Where:

      * `instance_id`: [ID](../../../compute/operations/vm-info/get-info.md#outside-instance) of the VM you want to associate with the policy.
      * `policy_id`: [ID](./get-info.md) of the policy to associate the VM with.

     For more information about `yandex_backup_policy_bindings` properties, see the [relevant provider documentation]({{ tf-provider-resources-link }}/backup_policy_bindings).
  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

     ```bash
      yc backup policy list-applications
     ```

- API {#api}

  Use the [apply](../../backup/api-ref/Policy/apply.md) REST API method for the [Policy](../../backup/api-ref/Policy/index.md) resource or the [PolicyService/Apply](../../backup/api-ref/grpc/Policy/apply.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](../create-vm.md)
* [{#T}](../create-vm-windows.md)
* [{#T}](create.md)
* [{#T}](detach-vm.md)
* [{#T}](../../concepts/vm-connection.md)
* [{#T}](../../concepts/policy.md)
