1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your VM.
1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select an [image](../concepts/image.md) and a Linux-based OS version.

    {% include [change-custom-disk-settings-image](../../_includes/compute/create/change-custom-disk-settings-image.md) %}

1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../overview/concepts/geo-scope.md) where your VM will reside.
1. Optionally, configure the boot [disk](../concepts/disk.md) under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**:

    * Select the [disk type](../concepts/disk.md#disks_types).
    * Specify the required disk size.
    * {% include [encryption-section-secondary](../../_includes/compute/encryption-section-secondary.md) %}

        {% include [change-custom-disk-settings-storages](../../_includes/compute/create/change-custom-disk-settings-storages.md) %}

1. {% include [section-storages-secondary-disk](../../_includes/compute/create/section-storages-secondary-disk.md) %}
1. {% include [section-storages-filesystem](../../_includes/compute/create/section-storages-filesystem.md) %}
1. {% include [section-platform](../../_includes/compute/create/section-platform.md) %}
1. {% include [network-settings](../../_includes/compute/create/section-network.md) %}
1. {% include [section-access](../../_includes/compute/create/section-access.md) %}
1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, enter a name for your VM:

    {% include [name-format](../../_includes/name-format.md) %}

    {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

1. {% include [section-additional](../../_includes/compute/create/section-additional.md) %}
1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

The VM will appear in the list. Every new VM gets an [IP address](../../vpc/concepts/address.md) and [host name](../../vpc/concepts/address.md#fqdn) (FQDN).

{% include [trademark](../../_includes/monitoring/trademark.md) %}