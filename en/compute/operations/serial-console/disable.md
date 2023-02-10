# Disabling access to the serial console

Serial console access is not secure, so enabling it might allow hackers to access your VM.

To disable access to the serial console, set the `serial-port-enable` parameter in the virtual machine metadata to `0`.

{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. Get a list of VMs in the default folder:

   {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

1. Select the VM `ID` or `NAME` (for example, `first-instance`).

1. Set the `serial-port-enable=0` parameter in the VM metadata:

   ```bash
   yc compute instance add-metadata \
       --name first-instance \
       --metadata serial-port-enable=0
   ```

   This command will start the operation to deactivate the serial console on the VM named `first-instance`.
