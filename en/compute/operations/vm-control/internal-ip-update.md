# Changing the VM internal IP address

After you create a VM, you can change its internal IP address.

{% list tabs group=instructions %}

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. [Stop](vm-stop-and-start.md#stop) the VM.

   1. View a description of the CLI command for updating the VM internal IP address:

      ```bash
      yc compute instance update-network-interface --help
      ```

   1. Get a list of VMs in the default folder:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

   1. Select the `ID` of the VM in question.
   1. Change the VM internal IP address:

      ```bash
      yc compute instance update-network-interface \
        --id <VM_ID> \
        --ipv4-address <internal_IP_address> \
        --network-interface-index 0
      ```

      Where:

      * `--ipv4-address`: Internal IP address. Specify a new address or enter `auto` to assign it automatically.
      * `--network-interface-index`: Network interface index.

- {{ TF }} {#tf}

   {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   1. To change the VM internal IP address, add the `ip_address` parameter to the `yandex_compute_instance` resource configuration:

      ```hcl
      resource "yandex_compute_instance" "vm-1" {
        ...
        network_interface {
          ...
          ip_address = "<internal_IP_address>"
        }
      }
      ```

      For more information about the `yandex_compute_instance` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/compute_instance).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}).

- API {#api}

   To change the VM internal IP address, use the [updateNetworkInterfacet](../../api-ref/Instance/updateNetworkInterface.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/PrimaryAddress](../../api-ref/grpc/instance_service.md#PrimaryAddress) gRPC API call.

{% endlist %}