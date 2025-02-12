# Updating the VM internal IP address

After you create a [VM](../../concepts/vm.md), you can update [internal IP addresses](../../../vpc/concepts/address.md#internal-addresses) of its [network interfaces](../../concepts/network.md).

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../../cli/) command for updating the internal IP address of a VM network interface:

     ```bash
     yc compute instance update-network-interface --help
     ```

  1. Get a list of VMs in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Select `ID` of the VM in question.

  1. [Stop](vm-stop-and-start.md#stop) the selected VM.

  1. Get a list of network interfaces for the VM by specifying its ID:

     ```bash
     yc compute instance get <VM_ID>
     ```

     Result:

     ```yml
     ...
     network_interfaces:
       - index: "0"
         mac_address: d0:0d:24:**:**:**
         subnet_id: e2lpp96bvvgp********
         primary_v4_address:
           address: 192.168.2.23
           one_to_one_nat:
             address: 158.160.**.***
             ip_version: IPV4
       - index: "1"
         mac_address: d0:1d:24:**:**:**
         subnet_id: e2lrucutusnd********
         primary_v4_address:
           address: 192.168.1.32
       - index: "2"
         mac_address: d0:2d:24:**:**:**
         subnet_id: e2lv9c6aek1d********
         primary_v4_address:
           address: 192.168.4.26
     ...
     ```

     Save the `index` field value, which is the number of the network interface you want to update the internal IP address for.

  1. Update the internal IP address of the selected VM network interface:

     ```bash
     yc compute instance update-network-interface \
       --id <VM_ID> \
       --ipv4-address <internal_IP_address> \
       --network-interface-index <network_interface_number>
     ```

     Where:
     * `--id`: VM ID.
     * `--ipv4-address`: Internal IP address. Specify a new IP address or enter `auto` to assign it automatically.
     * `--network-interface-index`: VM network interface number you saved earlier.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. To update the internal IP address of a VM network interface, add the `ip_address` parameter to the `network_interface` section of the network interface you need in the `yandex_compute_instance` resource configuration:

     ```hcl
     resource "yandex_compute_instance" "vm-1" {
       ...
       network_interface {
         ...
         ip_address = "<internal_IP_address>"
       }
     }
     ```

     For more information about the `yandex_compute_instance` resource parameters, see the [relevant provider documentation]({{ tf-provider-resources-link }}/compute_instance).
  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}).

- API {#api}

  To update the internal IP address of a VM network interface, use the [updateNetworkInterface](../../api-ref/Instance/updateNetworkInterface.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/PrimaryAddress](../../api-ref/grpc/Instance/get.md#yandex.cloud.compute.v1.PrimaryAddress) gRPC API call.

{% endlist %}