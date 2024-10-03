# How to change an internal IP address


## Scenario description {#case-description}

You need to change the internal IP address of the VM instance.

## Solution {#case-resolution}

The internal address of the VM instance can be changed using CLI, Terraform, and API.

{% list tabs %}

- CLI

   - [Installing and setting up the CLI](https://cloud.yandex.ru/docs/cli/quickstart)
   - The `yc compute instance update-network-interface` [command](https://cloud.yandex.ru/docs/cli/cli-ref/managed-services/compute/instance/update-network-interface).
      Command example:
   ```
   yc compute instance update-network-interface <VM ID> --network-interface-index=0 --ipv4-address=<new IP from subnet range>
   ```
   The `--network-interface-index` flag sets the index of the network interface being updated, with numbering starting from zero.

- Terraform

   - [The `ip_address` parameter in the `network_interface` section, `yandex_compute_instance` resource](https://registry.tfpla.net/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance#ip_address)


- API

   - [REST](https://cloud.yandex.ru/docs/compute/api-ref/Instance/updateNetworkInterface);
   - [gRPC](https://cloud.yandex.ru/docs/compute/api-ref/grpc/instance_service#UpdateNetworkInterface).

   Execute the ```yc compute instance update-network-interface <VM_ID> --network-interface-index=0 --ipv4-address=<new_IP_address>``` command

{% endlist %}

{% note info %}

You can only change the IP address on a stopped machine.

{% endnote %}