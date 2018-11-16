# Creating a VM from a Windows public image

This section provides guidelines on how to create a VM with Windows OS. To create a Linux-based VM, follow the instructions [[!TITLE]](create-linux-vm.md).

---

**[!TAB Management console]**

To create a VM:

[!INCLUDE [create-instance-via-concole-windows](../../_includes_service/create-instance-via-concole-windows.md)]

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

To create a VM:

[!INCLUDE [create-instance-via-cli-windows](../../_includes_service/create-instance-via-cli-windows.md)]

---

[!INCLUDE [initialization-windows-vm](../../../_includes/initialization-windows-vm.md)]

When a VM is being created, it is assigned an IP address and FQDN. You can use this data to access the VM via RDP.

#### See also
- [[!TITLE]](../vm-control/vm-connect-rdp.md)
