# Enable a software-accelerated network

You can enable a [software-accelerated network](../concepts/software-accelerated-network.md) when creating or updating a VM.

{% note warning %}

This feature is only available upon agreement with your account manager.

{% endnote %}

To enable a software-accelerated network on an existing VM:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the line with the appropriate VM, click ![image](../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.compute.instances.button_action-stop }} **.
   1. In the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_stop }}**.
   1. Wait for the VM status to change to `Stopped`, click ![image](../../_assets/horizontal-ellipsis.svg), and select **{{ ui-key.yacloud.common.edit }}**.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, select **{{ ui-key.yacloud.component.compute.resources.label_sw-accelerated-net }}**.
   1. Click **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.
   1. Click **{{ ui-key.yacloud.compute.instances.button_action-start }}** in the top-right corner.
   1. In the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_start }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command for updating VM parameters:

      ```bash
      yc compute instance update --help
      ```

   1. Get a list of VMs in the default folder:

      {% include [compute-instance-list](../../compute/_includes_service/compute-instance-list.md) %}

   1. Select the `ID` or `NAME` of the relevant VM instance and stop it. For example, to stop a VM named `first-instance`, run the command:

      ```bash
      yc compute instance stop first-instance
      ```

   1. Enable a software-accelerated network:

      1. Run this command:

         ```bash
         yc compute instance update first-instance \
           --network-settings type=software-accelerated
         ```

         Here `--network-settings` is the option that switches over the network type.

         Result:

         ```text
         id: fhm0b28lgfp4********
         folder_id: b1gbnv36zqf5********
         created_at: "2023-05-24T09:28:11Z"
         name: first-instance
         zone_id: {{ region-id }}-a
         platform_id: standard-v3
         resources:
           memory: "2147483648"
           cores: "2"
           core_fraction: "100"
         status: STOPPED
         ...
         network_settings:
           type: SOFTWARE_ACCELERATED
         placement_policy: {}
         ```

      1. Run the VM:

         ```bash
         yc compute instance start first-instance
         ```

   To disable a software accelerated network, stop the VM and run the command:

   ```bash
   yc compute instance update first-instance \
     --network-settings type=standard
   ```

{% endlist %}
