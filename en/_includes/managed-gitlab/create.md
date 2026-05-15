1. On the [folder dashboard](../../resource-manager/concepts/resources-hierarchy.md#folder) in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, in the **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** field, enter `Gitlab` and select a public [{{ GL }}](/marketplace/products/yc/gitlab) image.
1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the [availability zone](../../overview/concepts/geo-scope.md) where your VM will reside. If you are not sure which one to choose, leave the default.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the [platform](../../compute/concepts/vm-platforms.md), number of vCPUs, and amount of RAM:

    * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`.
    * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `4`.
    * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`.
    * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `8 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
    
    * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select the network and subnet to connect your VM to. If the relevant [network](../../vpc/concepts/network.md#network) or [subnet](../../vpc/concepts/network.md#subnet) is missing, [create it](../../vpc/operations/subnet-create.md).
    * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, keep `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` to assign the VM a random external IP address from the {{ yandex-cloud }} pool or select a static address from the list if you reserved one in advance.

1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

    * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter the username. Do not use `root` or other OS-reserved usernames. To perform operations requiring root privileges, use the `sudo` command.
    * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `ci-tutorial-gitlab`.
1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

It may take a few minutes to create your VM. When the VM status changes to `RUNNING` and {{ GL }} starts, configure its settings.