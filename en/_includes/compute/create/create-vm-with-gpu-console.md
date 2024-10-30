1. In the [management console]({{ link-console-main }}), select the folder to create your VM in.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. In the left-hand panel, select ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
1. Select one of the [GPU-oriented images](/marketplace?search=gpu) and OS version under **{{ ui-key.yacloud.compute.instances.create.section_image }}** in the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab.

    {% include [gpu-os](../gpu-os.md) %}

1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../../overview/concepts/geo-scope.md) to place your VM in.
1. (Optional) Configure the boot [disk](../../../compute/concepts/disk.md) under **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}**:

    * Select the [disk type](../../../compute/concepts/disk.md#disks_types).
    * Specify the required disk size.
    * {% include [encryption-section-secondary](../encryption-section-secondary.md) %}

        If you are creating a VM from an existing boot disk, update the settings of that disk in the **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}** tab under **{{ ui-key.yacloud.compute.instances.create.section_image }}** at the top of the form.

1. {% include [section-storages-secondary-disk](section-storages-secondary-disk.md) %}
1. {% include [section-storages-filesystem](section-storages-filesystem.md) %}
1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:

    * Go to the **{{ ui-key.yacloud.component.compute.resources.label_tab-gpu }}** tab.
    * Choose a [platform](../../../compute/concepts/vm-platforms.md#gpu-platforms):

        * {{ v100-broadwell }}
        * {{ v100-cascade-lake }}
        * {{ a100-epyc }}
        * {{ t4-ice-lake }}

    * Select one of the available configurations with the required GPUs, vCPUs, and amount of RAM.

1. {% include [network-settings](section-network.md) %}
1. {% include [section-access](section-access.md) %}

1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name:

    {% include [name-format](../../name-format.md) %}

    {% include [name-fqdn](../../compute/name-fqdn.md) %}

1. {% include [section-additional](section-additional.md) %}
1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

The virtual machine will appear in the list.