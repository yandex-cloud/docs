# Disabling access to the serial console

Serial console access is not secure, so enabling it might allow hackers to access your VM.

To disable access to the serial console:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}** and click the name of the VM you need.
   1. Click ![image](../../../_assets/pencil.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-edit }}**.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_additional }}**, disable the **{{ ui-key.yacloud.compute.instances.create.field_serial-port-enable }}** option.
   1. Click **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

- CLI {#cli}

   Set the `serial-port-enable` parameter in the virtual machine metadata to `0`.

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. Get a list of VMs in the default folder:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

   1. Select the `ID` or `NAME` of the VM, e.g., `first-instance`.

   1. Set the `serial-port-enable=0` parameter in the VM metadata:

      ```bash
      yc compute instance add-metadata \
        --name first-instance \
        --metadata serial-port-enable=0
      ```

      This command will start the operation to deactivate the serial console on the VM named `first-instance`.

{% endlist %}

