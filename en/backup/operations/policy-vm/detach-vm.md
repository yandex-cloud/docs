---
title: How to unlink a VM or {{ baremetal-name }} server from a backup policy
description: In this article, you will learn how to unlink a {{ compute-name }} VM or {{ baremetal-full-name }} server from a backup policy.
---

# Unlinking a VM or {{ baremetal-full-name }} server from a backup policy

To unlink a VM or {{ baremetal-name }} server from a backup policy:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder where you want to unlink a VM or {{ baremetal-name }} server from a backup policy.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Navigate to the ![policies](../../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud_billing.backup.label_policies }}** tab.
  1. Select the backup policy to unlink a VM or {{ baremetal-name }} server from.
  1. Depending on the resource you want to unlink from the backup policy, under **{{ ui-key.yacloud.backup.title_linked-recourses }}**, select the **{{ ui-key.yacloud.backup.value_vm-recourses }}** or **{{ ui-key.yacloud.backup.value_bms-recourses }}** tab.
  1. In the row with the VM or {{ baremetal-name }} server you want to unlink from the backup policy, click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.backup.action_detach-vm-instance }}** or **{{ ui-key.yacloud.backup.action_detach-baremetal-instance }}**, respectively.
  1. In the window that opens, confirm this action.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to remove a VM or {{ baremetal-name }} server from a backup policy: 

      ```bash
      yc backup policy revoke --help
      ```

  1. Get the ID of the backup policy to unlink the VM or {{ baremetal-name }} server from:

      {% include [get-policy-id](../../../_includes/backup/operations/get-policy-id.md) %}

  1. Get the ID of the VM to unlink:

      {% include [get-vm-id](../../../_includes/backup/operations/get-vm-id.md) %}

      {% include [get-bms-ids](../../../_includes/backup/operations/get-bms-ids.md) %}

  1. Unlink the VM or {{ baremetal-name }} server by specifying the backup policy ID:

      ```bash
      yc backup policy revoke <policy_ID> \
        --instance-ids <VM_or_{{ baremetal-name }}_server_IDs>
      ```

      Where `--instance-ids` are the IDs of the VMs or {{ baremetal-name }} servers you need to unlink from the backup policy. Multiple IDs should be comma-separated.

  For more information about the command, see the [CLI reference](../../../cli/cli-ref/backup/cli-ref/policy/revoke.md).

- API {#api}

  Use the [revoke](../../backup/api-ref/Policy/revoke.md) REST API method for the [Policy](../../backup/api-ref/Policy/index.md) resource or the [PolicyService/Revoke](../../backup/api-ref/grpc/Policy/revoke.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](attach-and-detach-vm.md)
