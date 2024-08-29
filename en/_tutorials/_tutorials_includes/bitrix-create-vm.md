{% list tabs group=instructions %}

- Management console {#console}

   1. On the folder page in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
      * In the **{{ ui-key.yacloud.common.name }}** field, enter a name for your VM, e.g., `bitrixwebsite`.
      * In the **{{ ui-key.yacloud.compute.instances.create.field_zone }}** field, select `{{ region-id }}-a`.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab and click **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**. Select [Ubuntu 20.04 lts](/marketplace/products/yc/ubuntu-22-04-lts) as the operating system image.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}**, select `{{ ui-key.yacloud.compute.value_disk-type-network-ssd }}` and set the size to `24 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}** tab and configure as follows:
      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `20%`
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `4 {{ ui-key.yacloud.common.units.label_gigabyte }}`
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select the `subnet-a` subnet you created earlier.
      * Under **{{ ui-key.yacloud.component.compute.network-select.field_external }}**, keep `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` to assign your VM a random public IP address from the {{ yandex-cloud }} pool, or select a static address from the list if you reserved one in advance.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** field, select the `bitrix-sg-vm` security group.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the information required to access the VM:
      * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter a username for the user to be created on the virtual machine, e.g., `ubuntu`.
      * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste your public SSH key. You need to create an SSH key pair [yourself](../../compute/operations/vm-connect/ssh.md).
   1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   You may need to save [disk snapshots](../../compute/operations/disk-control/create-snapshot.md) of your VM. They contain a copy of the VM file system from when the snapshot was created.

   You can use disk snapshots for various purposes, e.g.:
   * Migrating data from one disk to another, for example, to a disk in a different availability zone.
   * Creating a disk [backup](../../compute/concepts/backups.md) before performing operations that can damage your data.
   * Performing disk versioning by [creating snapshots on a regular basis](../../compute/operations/disk-control/configure-schedule.md).

{% endlist %}