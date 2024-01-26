# Detaching a public IP address from a VM

If you previously attached a public IP address to a VM, you can detach it.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. Select the VM.
   1. Under **{{ ui-key.yacloud.compute.instance.overview.label_network-interface }}**, in the top-right corner, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.compute.instance.overview.button_remove-public-ip }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.compute.instance.overview.popup-confirm_button_remove-one-to-one-nat }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To detach a public IP address from a VM, run the following CLI command:

   ```bash
   yc compute instance remove-one-to-one-nat
     --id=<instance_ID>
     --network-interface-index=<instance_network_interface_index>
   ```

   Where:

   * `id`: VM ID. You can get a list of instance IDs in a folder using the [CLI command](../../../cli/cli-ref/managed-services/compute/instance/list.md) `yc compute instance list`.
   * `network-interface-index`: VM's network interface index. By default: `0`.

   For more information about the `yc compute instance remove-one-to-one-nat` command, see the [CLI reference](../../../cli/cli-ref/managed-services/compute/instance/remove-one-to-one-nat.md).

- API {#api}

   Use the [removeOneToOneNat](../../api-ref/Instance/removeOneToOneNat.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/RemoveOneToOneNat](../../api-ref/grpc/instance_service.md#RemoveOneToOneNat) gRPC API call.

{% endlist %}