# Creating a Linux VM with a connection to {{ backup-name }}

{{ backup-name }} supports backing up [{{ compute-name }} VMs](../../compute/concepts/vm.md) running such Linux OS's as Ubuntu 20.04 or lower and CentOS 7. For more information, see [{#T}](../concepts/vm-connection.md#os).

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a VM.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../_assets/compute/vm-pic.svg) **{{ ui-key.yacloud.compute.switch_instances }}** and click **{{ ui-key.yacloud.compute.instances.button_create }}**.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, choose [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts) or lower or [CentOS 7](/marketplace/products/yc/centos-7).
   1. Specify the VM parameters. For more information, see [Creating a VM from a public Linux image](../../compute/operations/vm-create/create-linux-vm).

      {% include [vm-prereqs-note](../../_includes/backup/vm-prereqs-note.md) %}

   1. Under **{{ ui-key.yacloud.compute.instances.create.label_backup }}**, select the {{ backup-name }} connection option for your VM.
   1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

{% endlist %}

{% include [agent-installation-timespan](../../_includes/backup/agent-installation-timespan.md) %}

{% include [vm-list](../../_includes/backup/vm-list.md) %}

{% include [agent-installation-failure](../../_includes/backup/agent-installation-failure.md) %}

#### See also {#see-also}

* [{#T}](connect-vm-windows.md)
* [{#T}](connect-vm-linux.md)
* [Attaching a VM to a backup policy](./policy-vm/update.md#update-vm-list)
* [{#T}](./backup-vm/recover.md)
* [{#T}](./backup-vm/delete.md)
* [{#T}](./policy-vm/create.md)
