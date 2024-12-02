---
title: How to link or unlink a VM to/from a backup policy
description: In this article, you will learn how to link a {{ compute-name }} VM to or unlink it from a backup policy.
---

# Linking a VM to a backup policy

You can only link a VM to a policy if it is connected to {{ backup-full-name }}. For more information, see [Managing VMs in {{ backup-name }}](../index.md#connect-vm).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder where you want to link a VM to a backup policy.
  1. In the list of services, select **{{ backup-name }}**.
  1. Go to ![policies](../../../_assets/console-icons/calendar.svg) **Backup policies**.
  1. Select the policy to link the VM to.
  1. Under **Virtual machines**, click ![image](../../../_assets/console-icons/plus.svg) **Link VM**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command to link a VM to a backup policy: 

      ```bash
      yc backup policy apply --help
      ```

  1. Get the ID of the policy to link the VM to:

      {% include [get-policy-id](../../../_includes/backup/operations/get-policy-id.md) %}

  1. Get the ID of the VM to link:

      {% include [get-vm-id](../../../_includes/backup/operations/get-vm-id.md) %}

  1. Link the VM by specifying its ID:

      ```bash
      yc backup policy apply <policy_ID> \
        --instance-ids <VM_IDs>
      ```

      Where `--instance-ids` are the IDs of the VMs you need to link to the backup policy. Multiple IDs should be comma-separated.

  For more information about the command, see the [CLI reference](../../../cli/cli-ref/backup/cli-ref/policy/apply.md).

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
