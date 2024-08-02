# Unlinking a VM from a backup policy

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder in which to unlink a VM from a backup policy.
  1. In the list of services, select **{{ backup-name }}**.
  1. Go to the ![policies](../../../_assets/console-icons/calendar.svg) **Backup policies** tab.
  1. Select the policy to unlink the VM from.
  1. Under **Virtual machines**, click ![options](../../../_assets/console-icons/ellipsis.svg) next to the VM to be unlinked from the policy and select **Detach from policy**.

- CLI {#cli}

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

      Where `--instance-ids` are the IDs of VMs to unlink from the backup policy. Multiple IDs should be comma-separated.

  For more information about the command, see the [CLI reference](../../../cli/cli-ref/managed-services/backup/policy/revoke.md).

- API {#api}

  Use the [revoke](../../backup/api-ref/Policy/revoke.md) REST API method for the [Policy](../../backup/api-ref/Policy/index.md) resource or the [PolicyService/Revoke](../../backup/api-ref/grpc/policy_service.md#Revoke) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](attach-and-detach-vm.md)
