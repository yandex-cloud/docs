# Detaching a public IP address from a virtual machine

If you previously attached a public IP address to a VM's [network interface](../../concepts/network.md), you can detach it.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. Select the VM.
   1. In the window that opens, under **{{ ui-key.yacloud.compute.instance.overview.section_network }}**, click ![image](../../../_assets/console-icons/ellipsis.svg) in the top-right corner of the relevant network interface section and select **{{ ui-key.yacloud.compute.instance.overview.button_remove-public-ip }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.compute.instance.overview.popup-confirm_button_remove-one-to-one-nat }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To detach a public IP address from a VM, run the following CLI command:

   ```bash
   yc compute instance remove-one-to-one-nat
     --id=<VM_ID>
     --network-interface-index=<VM's_network_interface_number>
   ```

   Where:

   * `--id`: VM ID. You can get a list of instance IDs in a folder using the `yc compute instance list` [CLI command](../../../cli/cli-ref/managed-services/compute/instance/list.md).
   * `--network-interface-index`: VM's network interface number. The default value is `0`. To get a list of VM's network interfaces and their numbers, run the `yc compute instance get <VM_ID>` command.

   For more information about the `yc compute instance remove-one-to-one-nat` command, see the [CLI reference](../../../cli/cli-ref/managed-services/compute/instance/remove-one-to-one-nat.md).

- API {#api}

   Use the [removeOneToOneNat](../../api-ref/Instance/removeOneToOneNat.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/RemoveOneToOneNat](../../api-ref/grpc/instance_service.md#RemoveOneToOneNat) gRPC API call.

{% endlist %}