# Detaching a public IP address from a VM

If you previously linked a public IP address to a VM, you can disassociate it.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
   1. Select **{{ compute-name }}**.
   1. Select the VM.
   1. Under **Network interface**, in the top right-hand corner, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **Disassociate public IP address**.
   1. In the window that opens, click **Delete**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To detach a public IP address from a VM instance, run the CLI command below:

   ```bash
   yc compute instance remove-one-to-one-nat
     --id=<instance_ID>
     --network-interface-index=<instance_network_interface_index>
   ```

   Where:

   * `id`: VM instance ID. You can get a list of IDs of instances in a folder using the [CLI command](../../../cli/cli-ref/managed-services/compute/instance/list.md) `yc compute instance list`.
   * `network-interface-index`: VM instance's network interface index. By default: `0`.

   For more information about the `yc compute instance remove-one-to-one-nat` command, see the [CLI reference](../../../cli/cli-ref/managed-services/compute/instance/remove-one-to-one-nat.md).

{% endlist %}