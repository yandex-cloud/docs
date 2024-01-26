# Changing security groups of a VM's network interface

You can assign multiple [security groups](../../../vpc/operations/security-group-create.md) to the network interface of a VM.

For more information about how to change a VM name, description, and tags, see [{#T}](vm-update.md).

{% list tabs group=instructions %}

- Management console {#console}

   To update a list of security groups applied to your VM:
   1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. Click the VM name.
   1. Change the VM network interface security groups under **{{ ui-key.yacloud.compute.instance.overview.label_network-interface }}**:
      * In the top-right corner of the section, click ![image](../../../_assets/options.svg) and select **{{ ui-key.yacloud.compute.instance.overview.button_edit-network-interface }}**.
      * In the **{{ ui-key.yacloud.compute.instance.edit-network-interface.field_security-groups-ids }}** field of the window that opens, add new security groups or delete the security groups applied to the VM network interface.
      * Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}