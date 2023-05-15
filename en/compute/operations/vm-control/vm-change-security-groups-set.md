# Changing security groups of a VM's network interface

You can assign multiple [security groups](../../../vpc/operations/security-group-create.md) to the network interface of a VM.

{% include [security-groups-note](../../../_includes/vpc/security-groups-note-services.md) %}

For more information about how to change a VM name, description, and tags, see [{#T}](vm-update.md).

{% list tabs %}

- Management console

   To update a list of security groups applied to your VM:
   1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
   1. Select **{{ compute-name }}**.
   1. Click the name of the desired VM.
   1. Click **Stop** in the upper-right corner of the page.
   1. In the window that opens, click **Stop** and wait until the VM status changes to `STOPPED`.
   1. Change the VM's network interface security groups under **Network**:
      * Click ![image](../../../_assets/options.svg) in the top-right corner and select **Edit network interface**.
      * In the **Security groups** field of the window that opens, add new security groups or delete the security groups applied to the VM's network interface.
      * Click **Save**.
   1. Click **Run** in the upper-right corner of the page.
   1. In the window that opens, click **Start**.

{% endlist %}