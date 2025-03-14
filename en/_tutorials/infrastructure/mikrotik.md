# Installing the Mikrotik CHR virtual router

In {{ yandex-cloud }}, you can deploy a virtual Mikrotik Cloud Hosted Router on a ready-made VM image. To install the Mikrotik Cloud Hosted Router and check how it runs:

1. [Get your cloud ready](#before-you-begin).
1. [Create a VM with the Mikrotik Cloud Hosted Router](#create-router).
1. [Log in to your VM and change your password](#change-password).
1. [Create a test VM](#create-test-vm).
1. [Check the connection between the router and test VM](#test-connection).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% note alert %}

When using a Mikrotik Cloud Hosted Router image without a license, the router throughput is limited to 1 Mbps. To remove this limitation, [install a license](https://wiki.mikrotik.com/wiki/Manual:CHR#CHR_Licensing).

{% endnote %}

The cost of using a virtual router and a test VM includes:

* Fee for the disks and continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using a public IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

## Create a VM with the Mikrotik Cloud Hosted Router {#create-router}

1. On the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) page in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, in the **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** field, enter `Cloud Hosted Router` and select a public [Cloud Hosted Router](/marketplace/products/yc/cloud-hosted-router) image.
1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../overview/concepts/geo-scope.md) to create your VM in. If you do not know which availability zone you need, leave the default one.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the required [platform](../../compute/concepts/vm-platforms.md), number of vCPUs, and the amount of RAM:

    * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
    * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
    * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`
    * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `2 {{ ui-key.yacloud.common.units.label_gigabyte }}`

1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

    * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select the network and subnet to connect your VM to. If the required [network](../../vpc/concepts/network.md#network) or [subnet](../../vpc/concepts/network.md#subnet) is not listed, [create it](../../vpc/operations/subnet-create.md).
    * Under **{{ ui-key.yacloud.component.compute.network-select.field_external }}**, keep `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` to assign your VM a random external IP address from the {{ yandex-cloud }} pool, or select a static address from the list if you reserved one in advance.

1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

    * Under **{{ ui-key.yacloud.compute.instances.create.field_user }}**, enter a username. Do not use `root` or other names reserved by the OS.
    * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

    Note that you only need this data for VM creation. You cannot use the data for router access.

1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `mikrotik-router`.
1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

It may take a few minutes to create a VM. When the VM status changes to `RUNNING`, you can log in.

{% note alert %}

Set a complex administrator password immediately after VM creation.

{% endnote %}

## Change the administrator password on the router {#change-password}

The router is created with a public IP address, so you need to change the default administrator password for security reasons.

1. In the [management console]({{ link-console-main }}), select the folder.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. Copy the `mikrotik-router` VM public IP address and open it in your browser.
1. Enter the VM internal IP address in the **IP Address** field. 
1. On the page that opens, enter the new administrator password, confirm it, and click **Apply Configuration**. You can apply other settings later.

## Create a test VM {#create-test-vm}

Create a test VM in the subnet that hosts the router, to test connectivity between the router and VM.

1. On the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) page in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, in the **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** field, enter `Ubuntu` and select a public [Ubuntu](/marketplace?tab=software&search=Ubuntu&categories=os) image.
1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the [availability zone](../../overview/concepts/geo-scope.md) where the `mikrotik-router` VM resides.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the required [platform](../../compute/concepts/vm-platforms.md), number of vCPUs, and the amount of RAM:

    * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
    * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
    * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `20%`
    * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `1 {{ ui-key.yacloud.common.units.label_gigabyte }}`

1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

    * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select the network and subnet hosting the `mikrotik-router` VM.
    * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`.

1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

    * Under **{{ ui-key.yacloud.compute.instances.create.field_user }}**, enter a username. Do not use `root` or other names reserved by the OS. To perform operations requiring superuser privileges, use the `sudo` command.
    * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `test-vm`.
1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

### Check the connection between the router and test VM {#test-connection}

{% note alert %}

If you use WinBox to access the router, connect to the router using the VM IP address. MAC access is not supported in {{ yandex-cloud }}.

{% endnote %}

Make sure that a network connection is established between the router and test VM:

1. Open the router's administrator interface in the browser.
1. Click **Terminal**.
1. In the terminal that opens, run the `ping <test_VM_internal_IP_address>` command.

If the packets reach the test VM, you can start configuring the router. You can find the router manual in the [Mikrotik documentation](https://wiki.mikrotik.com/wiki/Main_Page).

## Delete the resources you created {#clear-out}

To stop paying for the deployed resources, [delete](../../compute/operations/vm-control/vm-delete.md) the `mikrotik-router` and `test-vm` VMs. 

If you reserved a public static IP address, [delete it](../../vpc/operations/address-delete.md).
