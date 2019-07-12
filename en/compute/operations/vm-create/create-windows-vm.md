# Creating a VM from a Windows public image

This section provides guidelines on how to create a VM with Windows OS. To create a Linux-based VM, follow the instructions [#T](create-linux-vm.md).

To create a VM:

{% list tabs %}

- Management console
  
  {% include [create-instance-via-concole-windows](../../_includes_service/create-instance-via-concole-windows.md) %}
  
- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  {% include [create-instance-via-cli-windows](../../_includes_service/create-instance-via-cli-windows.md) %}
  
- API
  
  Use the [Create](../../../_api-ref/compute/api-ref/Instance/create.md) method for the `Instance` resource.
  
{% endlist %}

{% include [initialization-windows-vm](../../../_includes/initialization-windows-vm.md) %}

When a VM is being created, it is assigned an IP address and FQDN. You can use this data to access the VM via RDP.

You can make a public IP address static. For more information, see the section [#T](../vm-control/vm-set-static-ip.md).

#### See also

- [#T](../vm-connect/rdp.md)

