# Creating a VM from a Windows public image

This section provides guidelines on how to create a VM with Windows OS. To create a Linux-based VM, follow the instructions [[!TITLE]](create-linux-vm.md).

To create a VM:

---

**[!TAB Management console]**

[!INCLUDE [create-instance-via-concole-windows](../../_includes_service/create-instance-via-concole-windows.md)]

**[!TAB CLI]**

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

[!INCLUDE [create-instance-via-cli-windows](../../_includes_service/create-instance-via-cli-windows.md)]

**[!TAB API]**

Use the [Create](../../api-ref/Instance/create.md) method for the `Instance` resource.

---

[!INCLUDE [initialization-windows-vm](../../../_includes/initialization-windows-vm.md)]

When a VM is being created, it is assigned an IP address and FQDN. You can use this data to access the VM via RDP.

You can make a public IP address static. For more information, see the section [[!TITLE]](../vm-control/vm-set-static-ip.md).

#### See also

- [[!TITLE]](../vm-control/vm-connect-rdp.md)

