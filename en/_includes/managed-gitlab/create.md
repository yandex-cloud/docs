1. On the folder page in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
1. In the **{{ ui-key.yacloud.common.name }}** field, enter the [VM](../../compute/concepts/vm.md) name as follows: `ci-tutorial-gitlab`.
1. Select an [availability zone](../../overview/concepts/geo-scope.md) to place your VM in.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab and click **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**. In the window that opens, select [{{ GL }}](/marketplace/products/yc/gitlab) as your image and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, specify the following configuration:
   * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `4`
   * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`
   * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `8 {{ ui-key.yacloud.common.units.label_gigabyte }}`
1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
   * Select a [subnet](../../vpc/concepts/network.md#subnet) to connect your VM to. If the required [network](../../vpc/concepts/network.md#network) or subnet is not listed, create it using the **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** and **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}** buttons.

     {% include [GL CIDR Warning](../../_includes/managed-gitlab/cidr-note.md) %}

   * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the information required to access the instance:
   * Enter the username in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.

      {% note alert %}

      Do not use the `root` username or other names reserved by the operating system. To perform operations that require superuser permissions, use the `sudo` command.

      {% endnote %}

   * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the [public key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file. You need to create a key pair for the SSH connection yourself. To learn how, see [Connecting to a VM via SSH](../../compute/operations/vm-connect/ssh.md).
1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

It may take a few minutes to create a VM. When the VM changes its status to `RUNNING` and {{ GL }} starts, you can proceed with setup.