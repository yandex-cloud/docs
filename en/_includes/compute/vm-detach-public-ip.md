{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder this VM belongs to.
  1. [Navigate]({{ link-console-main }}/link/compute) to **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Select your VM.
  1. On the **{{ ui-key.yacloud.common.overview }}** tab, scroll down to the **{{ ui-key.yacloud.compute.instance.overview.section_network }}** section.
  1. In the network interface section, click ![image](../../_assets/console-icons/ellipsis.svg) in the top-right corner and then click ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.compute.instance.overview.button_remove-public-ip }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.compute.instance.overview.popup-confirm_button_remove-one-to-one-nat }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To unassign a public IP address from a VM, run the following CLI command:

  ```bash
  yc compute instance remove-one-to-one-nat
    --id=<VM_ID>
    --network-interface-index=<VM_network_interface_number>
  ```

  Where:

  * `--id`: VM ID. You can get a list of available VM IDs in the folder using the `yc compute instance list` [CLI command](../../cli/cli-ref/compute/cli-ref/instance/list.md).
  * `--network-interface-index`: VM network interface number. The default value is `0`. To get a list of VM network interfaces and their numbers, run `yc compute instance get <VM_ID>`.

  For more information about the `yc compute instance remove-one-to-one-nat` command, see the [CLI reference](../../cli/cli-ref/compute/cli-ref/instance/remove-one-to-one-nat.md).

- API {#api}

  Use the [removeOneToOneNat](../../compute/api-ref/Instance/removeOneToOneNat.md) REST API method for the [Instance](../../compute/api-ref/Instance/) resource or the [InstanceService/RemoveOneToOneNat](../../compute/api-ref/grpc/Instance/removeOneToOneNat.md) gRPC API call.

{% endlist %}