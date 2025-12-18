# How to change an internal IP address



## Case description {#case-description}

You need to change the internal IP address of the VM instance.

## Solution {#case-resolution}

You can change the internal IP address of a VM using the CLI, {{ TF }}, and API. 

{% list tabs %}

- CLI

    * [Installing and setting up the CLI](../../../cli/quickstart.md)
    * `yc compute instance update-network-interface` [command](../../../cli/cli-ref/compute/cli-ref/instance/update-network-interface)

    Command example:

    ```
    yc compute instance update-network-interface <VM ID> --network-interface-index=0 --ipv4-address=<new IP address from subnet range>
    ```

    The `--network-interface-index` flag sets the index of the network interface to update, with numbering starting from zero.

- {{ TF }}

   * [`ip_address` property, `network_interface` section, `yandex_compute_instance` resource](https://registry.tfpla.net/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance#ip_address)


- API

    * [REST](../../../compute/api-ref/Instance/updateNetworkInterface)
    * [gRPC](../../../compute/api-ref/grpc/Instance/updateNetworkInterface)

    Run this command: ```yc compute instance update-network-interface <VM_ID> --network-interface-index=0 --ipv4-address=<new_IP_address>```.

{% endlist %}

{% note alert %}

You can only change the IP address on a stopped machine.

{% endnote %}