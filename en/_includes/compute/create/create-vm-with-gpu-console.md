1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your VM.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. In the left-hand panel, select ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
1. Select a [GPU-optimized image](/marketplace?search=gpu) and OS version under **{{ ui-key.yacloud.compute.instances.create.section_image }}** in the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab.

    {% include [gpu-os](../gpu-os.md) %}

1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../../overview/concepts/geo-scope.md) for your VM.
1. Optionally, configure the boot [disk](../../../compute/concepts/disk.md) under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**:

    * Select the [disk type](../../../compute/concepts/disk.md#disks_types).
    * Specify the required disk size.
    * {% include [encryption-section-secondary](../encryption-section-secondary.md) %}

        If you are creating a VM from an existing boot disk, update the settings of that disk in the **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}** tab under **{{ ui-key.yacloud.compute.instances.create.section_image }}** at the top of the form.

1. {% include [section-storages-secondary-disk](section-storages-secondary-disk.md) %}
1. {% include [section-storages-filesystem](section-storages-filesystem.md) %}
1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:

    * Go to the **{{ ui-key.yacloud.component.compute.resources.label_tab-gpu }}** tab.
    * Select one of these [platforms](../../../compute/concepts/vm-platforms.md#gpu-platforms):

        * {{ v100-broadwell }}
        * {{ v100-cascade-lake }}
        * {{ a100-epyc }}
        * {{ t4-ice-lake }}
        * {{ t4i-ice-lake }}

    * Select one of the available configurations with the required number of GPUs, vCPUs, and amount of RAM.

1. {% include [network-settings](section-network.md) %}
1. {% include [section-access](section-access.md) %}

1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name:

    {% include [name-format](../../name-format.md) %}

    {% include [name-fqdn](../../compute/name-fqdn.md) %}

1. {% include [section-additional](section-additional.md) %}
1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

The VM will appear in the list.