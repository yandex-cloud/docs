---
title: "How to link or unlink a VM to/from a backup policy"
description: "In this article, you will learn how to link a {{ compute-name }} VM to or unlink it from a backup policy."
---

# Editing a list of VMs in a backup policy

## Linking a VM to a backup policy {#attach-vm}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select a folder in which to link a VM to a backup policy.
   1. In the list of services, select **{{ backup-name }}**.
   1. Go to the ![policies](../../../_assets/console-icons/calendar.svg) **Backup policies** tab.
   1. Select the policy to link the VM to.
   1. Under **Virtual machines**, click ![image](../../../_assets/console-icons/plus.svg) **Attach VM**.

- CLI

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

      Where `--instance-ids` are the IDs of VMs to be linked to the backup policy. Multiple IDs should be comma-separated.

   For more information about the command, see the [CLI reference](../../../cli/cli-ref/managed-services/backup/policy/apply.md).

- API

   Use the [apply](../../backup/api-ref/Policy/apply.md) REST API method for the [Policy](../../backup/api-ref/Policy/index.md) resource or the [PolicyService/Apply](../../backup/api-ref/grpc/policy_service.md#Apply) gRPC API call.

{% endlist %}

## Unlinking a VM from a backup policy {#detach-vm}

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select a folder in which to unlink a VM from a backup policy.
  1. In the list of services, select **{{ backup-name }}**.
  1. Go to the ![policies](../../../_assets/console-icons/calendar.svg) **Backup policies** tab.
  1. Select the policy to unlink the VM from.
  1. Under **Virtual machines**, click ![options](../../../_assets/console-icons/ellipsis.svg) next to the VM to be unlinked from the policy and select **Detach from policy**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command to remove a VM from a backup policy:

      ```bash
      yc backup policy revoke --help
      ```

  1. Get the ID of the policy to unlink the VM from:

      {% include [get-policy-id](../../../_includes/backup/operations/get-policy-id.md) %}

  1. Get the ID of the VM to unlink:

      {% include [get-vm-id](../../../_includes/backup/operations/get-vm-id.md) %}

  1. Unlink the VM by specifying its ID:

      ```bash
      yc backup policy revoke <policy_ID> \
        --instance-ids <VM_IDs>
      ```

      Where `--instance-ids` are the IDs of VMs to be unlinked from the backup policy. Multiple IDs should be comma-separated.

  For more information about the command, see the [CLI reference](../../../cli/cli-ref/managed-services/backup/policy/revoke.md).

- API

  Use the [revoke](../../backup/api-ref/Policy/revoke.md) REST API method for the [Policy](../../backup/api-ref/Policy/index.md) resource or the [PolicyService/Revoke](../../backup/api-ref/grpc/policy_service.md#Revoke) gRPC API call.

{% endlist %}
