# Disabling access to a serial console

Enabled serial console access poses a security risk as attackers could gain access to your VM.

To disable access to a serial console:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}** and click the name of the VM.
  1. Click ![image](../../../_assets/pencil.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-edit }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_additional }}**, disable **{{ ui-key.yacloud.compute.instances.create.field_serial-port-enable }}**.
  1. Click **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

- CLI {#cli}

  In the VM metadata, set `serial-port-enable` to `0`.

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Get a list of VMs in the default folder:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Select `ID` or `NAME` of the VM, e.g., `first-instance`.

  1. In the VM metadata, specify `serial-port-enable=0`:

     ```bash
     yc compute instance add-metadata \
         --name first-instance \
         --metadata serial-port-enable=0
     ```

     This command will disable the serial console access on the `first-instance` VM.

{% endlist %}

