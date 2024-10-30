Creating an instance from a public [DSVM](/marketplace/products/f2e4v304qn35mhilnsbc) image:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create your VM in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.  
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab and select the [DSVM](/marketplace/products/yc/dsvm) image.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../overview/concepts/geo-scope.md) to place your VM in.
  1. (Optional) Configure the boot [disk](../concepts/disk.md) in the **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** section:

      * Select the [disk type](../concepts/disk.md#disks_types).
      * Specify the required disk size.

  1. {% include [section-storages-filesystem](../../_includes/compute/create/section-storages-filesystem.md) %}
  1. {% include [section-platform](../../_includes/compute/create/section-platform.md) %}
  1. {% include [network-settings](../../_includes/compute/create/section-network.md) %}
  1. {% include [section-access](../../_includes/compute/create/section-access.md) %}
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name:

      {% include [name-format](../../_includes/name-format.md) %}

      {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

  1. {% include [section-additional](../../_includes/compute/create/section-additional.md) %}
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  The virtual machine will appear in the list. When a VM is created, it is assigned an [IP address](../../vpc/concepts/address) and [host name](../../vpc/concepts/address.md#fqdn) (FQDN).

{% endlist %}
