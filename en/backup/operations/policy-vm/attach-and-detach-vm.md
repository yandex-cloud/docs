---
title: How to link a resource to a backup policy
description: In this article, you will learn how to link a VM or server to a backup policy.
---

# Linking a resource to a backup policy


You can only link [resources](../../concepts/index.md#protected-resources) to a backup policy if they are [connected](../../concepts/vm-connection/index.md) to {{ backup-full-name }}. For more information, see [{#T}](../index.md#connect-vm), [{#T}](../index.md#connect-baremetal), and [{#T}](../index.md#connect-external).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to link a resource to a backup policy.
  1. [Navigate]({{ link-console-main }}/link/backup) to **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Navigate to the ![policies](../../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud_billing.backup.label_policies }}** tab.
  1. Select the policy you want to link the VM or server to.
  1. Under **{{ ui-key.yacloud.backup.title_linked-recourses }}**, click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.backup.button_attach-instance }}**, and in the window that opens:

      1. Depending on the resource you want to link to the backup policy, select the **{{ ui-key.yacloud.backup.value_vm-recourses }}** or **{{ ui-key.yacloud.backup.value_bms-recourses }}** tab and select the VM or server from the list.

          If the VM or server you want to link to the backup policy is not listed, make sure it is connected to {{ backup-name }}.
      1. Click **{{ ui-key.yacloud_billing.backup.button_attach-instance-submit }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for linking a {{ baremetal-name }} resource to a backup policy: 

      ```bash
      yc backup policy apply --help
      ```

  1. Get the ID of the backup policy you want to link a resource to:

      {% include [get-policy-id](../../../_includes/backup/operations/get-policy-id.md) %}

  1. Get the ID of the resource you want to link:

      {% include [get-resource-ids.md](../../../_includes/backup/operations/get-resource-ids.md) %}

  1. Link the resource to the backup policy by specifying its ID:

      ```bash
      yc backup policy apply <policy_ID> \
        --instance-ids <resource_IDs>
      ```

      Where `--instance-ids` are the IDs of the [{{ compute-name }} VMs](../../concepts/vm-connection/compute.md), [{{ baremetal-name }} servers](../../concepts/vm-connection/baremetal.md), or [external resources](../../concepts/vm-connection/external-resources.md) connected to {{ backup-name }} which you need to link to the backup policy. Multiple IDs should be comma-separated.

  For more information about this command, see the [CLI reference](../../../cli/cli-ref/backup/cli-ref/policy/apply.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To link a [resource](../../concepts/index.md#protected-resources) to a backup policy:

  1. Describe the resource's link settings in the {{ TF }} configuration file:

      ```hcl
      resource "yandex_backup_policy_bindings" "test_backup_binding" {
        instance_id = "<resource_ID>"
        policy_id   = "<policy_ID>"
      }
      ```

      Where:

      * `instance_id`: ID of the resource you want to link to a backup policy.

          You can get the list of IDs of resources linked to {{ backup-name }} in the default folder by using the `yc backup vm list` {{ yandex-cloud }} CLI command.
      * `policy_id`: [ID](./get-info.md) of the backup policy you want to link the resource to.

     For more on the properties of the `yandex_backup_policy_bindings` resource, see [this provider guide]({{ tf-provider-resources-link }}/backup_policy_bindings).
  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

     ```bash
      yc backup policy list-applications
     ```

- API {#api}

  Use the [apply](../../backup/api-ref/Policy/apply.md) REST API method for the [Policy](../../backup/api-ref/Policy/index.md) resource or the [PolicyService/Apply](../../backup/api-ref/grpc/Policy/apply.md) gRPC API call.

{% endlist %}

#### Useful links {#see-also}

* [{#T}](../create-vm.md)
* [{#T}](../create-vm-windows.md)
* [{#T}](create.md)
* [{#T}](detach-vm.md)
* [{#T}](../../concepts/vm-connection/index.md)
* [{#T}](../../concepts/policy.md)
