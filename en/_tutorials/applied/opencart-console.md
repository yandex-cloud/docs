1. [Get your cloud ready](#before-you-begin).
1. [Create a VM with OpenCart](#create-vm).
1. [Optionally, create a {{ MY }} DB cluster](#create-mysql).
1. [Set up OpenCart](#configure-opencart).

If you no longer need the resources you created, [delete them](#clear-out).


## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [opencart-paid-resources](../_tutorials_includes/opencart-paid-resources.md) %}

## Create a VM with OpenCart {#create-vm}

The VM boot disk will have OpenCart and the required components, including PHP and {{ MY }}, pre-installed on it.

To create a VM:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create your VM in.
  1. In the list of services, select **{{ compute-short-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **VMs**.
  1. Click **Create VM**.
  1. Select **{{ ui-key.yacloud.compute.instances.create.option_create-form-extended-title }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, in the **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** field, enter `OpenCart` and select a public [OpenCart](/marketplace/products/yc/opencart-3) image.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the [availability zone](../../overview/concepts/geo-scope.md) where your VM will reside.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, configure the boot [disk](../../compute/concepts/disk.md):

      * Select the [disk type](../../compute/concepts/disk.md#disks_types): `{{ ui-key.yacloud.compute.value_disk-type-network-ssd_4Mmub }}`.
      * Specify the disk size: `13 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the [platform](../../compute/concepts/vm-platforms.md), number of vCPUs, and the amount of RAM:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `20%`
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `4 {{ ui-key.yacloud.common.units.label_gigabyte }}`

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, enter the ID of a subnet in the new VM’s availability zone. Alternatively, select a [cloud network](../../vpc/concepts/network.md#network) from the list.

          * Each network must have at least one [subnet](../../vpc/concepts/network.md#subnet). If there is no subnet, create one by selecting **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
          * If you do not have a network, click **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** to create one:

              * In the window that opens, specify the network name and select the folder to host the network.
              * Optionally, enable the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** setting to automatically create subnets in all availability zones.
              * Click **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` to assign a random IP address from the {{ yandex-cloud }} pool. Alternatively, select a static address from the list if you reserved one.

    1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

        * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter the preferred login for the user you will create on the VM, e.g., `ubuntu`.
        * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, enter the VM name, e.g., `opencart`. The naming requirements are as follows:

      {% include [name-format](../../_includes/name-format.md) %}

  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
  1. Get the VM [public IP address](../../vpc/concepts/address.md#public-addresses): you will use it later to [configure OpenCart](#configure-opencart). You can get the public IP address in the management console. On the VM page, navigate to the **{{ ui-key.yacloud.compute.instance.overview.section_network }}** section and find the **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}** field.

{% endlist %}

If you expect a significant load on the DB or want to use a managed DBMS service, [create a DB cluster](#create-mysql) using {{ mmy-name }}. Otherwise, [configure OpenCart](#configure-opencart).

## Create a {{ MY }} DB cluster {#create-mysql}

{{ mmy-name }} supports and maintains your {{ my }} database, including status and current activity monitoring, automatic backup, and easily configurable fault tolerance.

If you do not need a cluster, skip this step and [configure OpenCart](#configure-opencart).

To create a DB cluster:

{% list tabs %}

- Management console

  1. On the folder dashboard in the [management console]({{ link-console-main }}), click **Create resource** and select **{{ MY }} cluster**.
  1. Specify a name for the cluster, e.g., `opencart`.
  1. Under **Host class**, select `s2.micro`. This configuration is sufficient for the system to run under a normal workload.
  1. Under **Database**, enter:
     * **DB name**: Leave the default value, `db1`.
     * **Username** to connect to the DB: Keep the default value, `user1`.
     * **Password** for OpenCart to access the {{ MY }} DB.
  1. Under **Hosts**, change the DB **Availability zone**, if required. To do this, click ![pencil](../../_assets/console-icons/pencil.svg) to the right of the currently selected availability zone and select the one you need from the drop-down list.

     {% note tip %}

     We recommend selecting the same availability zone as for the VM you created. This reduces latency between the VM and the DB.

     {% endnote %}

  1. Optionally, if you want to ensure DB fault tolerance, add more hosts to the cluster by clicking **Add host** and specifying the availability zone for it.
  1. Leave the other fields unchanged.
  1. Click **Create cluster**.

{% endlist %}

Creating a DB cluster may take a few minutes. Upon completion, [configure OpenCart](#configure-opencart).

## Configure OpenCart {#configure-opencart}

{% include [opencart-configure](../_tutorials_includes/opencart-configure.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete](../../compute/operations/vm-control/vm-delete.md) `opencart`.
1. If you used a {{ MY }} database, [delete the {{ mmy-name }} cluster](../../managed-mysql/operations/cluster-delete.md). In this example, we created a DB cluster named `opencart`.

If you reserved a static public IP address specifically for this VM:
1. In your folder, select **{{ vpc-short-name }}**.
1. Navigate to the **IP addresses** tab.
1. Find the required IP address, click ![ellipsis](../../_assets/console-icons/ellipsis.svg), and select **Delete**.
