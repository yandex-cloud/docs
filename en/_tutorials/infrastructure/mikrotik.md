# Installing a Mikrotik CHR virtual router

In {{ yandex-cloud }}, you can deploy a virtual Mikrotik Cloud Hosted Router from a ready-made VM image. To install Mikrotik Cloud Hosted Router and check its operability:

1. [Prepare your cloud](#before-you-begin).
1. [Create a VM with Mikrotik Cloud Hosted Router](#create-router).
1. [Log in to your VM and change your password](#change-password).
1. [Create a test VM](#create-test-vm).
1. [Check the connection between the router and test VM](#test-connection).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% note alert %}

When you use a Mikrotik Cloud Hosted Router image without a license, the router throughput is limited to 1 Mbps. To remove this limit, [install a license](https://wiki.mikrotik.com/wiki/Manual:CHR#CHR_Licensing).

{% endnote %}

The cost of using a virtual router and test VM includes:

* Fee for the disks and continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using a public IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Create a VM with Mikrotik Cloud Hosted Router {#create-router}

1. In the [management console]({{ link-console-main }}), select the folder.
1. In the top-right corner, click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and choose **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
   1. In the **{{ ui-key.yacloud.compute.instances.create.field_name }}** field, enter a name for the VM, e.g., `mikrotik-router`.
   1. In the **{{ ui-key.yacloud.compute.instances.create.field_zone }}** field, select an [availability zone](../../overview/concepts/geo-scope.md) with a subnet. If you do not know which availability zone you need, leave the default one.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab and select the [Cloud Hosted Router](/marketplace/products/yc/cloud-hosted-router) image.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, specify the parameters:
   * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
   * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
   * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`
   * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `1 GB`.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, select the required network and subnet and assign a public IP address to the VM either by selecting it from the list or automatically. If you don't have a network or subnet, create them on the VM creation screen.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**:
   1. Enter the username in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.
   1. Paste the contents of the public SSH key file in the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field. You need to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair for SSH connection yourself.

      Note that you only need this data for VM creation. You cannot use the data for router access.

1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

It may take a few minutes to create a VM. When the VM status changes to `RUNNING`, you can log in.

{% note alert %}

Set a complex administrator password immediately after VM creation.

{% endnote %}

## Change the administrator password on the router {#change-password}

The router is created with a public IP address, so you need to change the default administrator password for security reasons.

1. In the [management console]({{ link-console-main }}), select the folder.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. Copy the `mikrotik-router` VM public IP and open it in your browser.
1. Enter the VM internal **IP address** in the IP Address field.
1. On the page that opens, enter the new administrator password, confirm it, and click **Apply Configuration**. You can make other setting later.

## Create a test VM {#create-test-vm}

Create a test VM in the subnet that hosts the router, to test connectivity between the router and VM.

1. In the [management console]({{ link-console-main }}), select the folder.
1. In the top-right corner, click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and choose **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
   1. In the **{{ ui-key.yacloud.compute.instances.create.field_name }}** field, enter a name for the VM, such as `test-vm`.
   1. In the **{{ ui-key.yacloud.compute.instances.create.field_zone }}** field, choose the same [availability zone](../../overview/concepts/geo-scope.md) that the `mikrotik-router` VM is in.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab and select the [Ubuntu](/marketplace?tab=software&search=Ubuntu&categories=os) image.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, specify the parameters:
   * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
   * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
   * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `20%`
   * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `1 GB`
1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
   1. In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select the network and subnet hosting the `mikrotik-router` VM.
   1. In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**:
   1. Enter the username in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.
   1. Paste the contents of the public SSH key file in the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field.
1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

### Check the connection between the router and test VM {#test-connection}

{% note alert %}

If you use WinBox to access the router, connect to the router using the VM IP address. MAC access is not supported in {{ yandex-cloud }}.

{% endnote %}

Make sure that a network connection has been established between the router and test VM:

1. Open the router's administrative interface in the browser.
1. Click **Terminal**.
1. In the terminal that opens, run the `ping <internal_IP_address_of_the_test_VM>` command.

If the packets reach the test VM, you can start configuring the router. To learn how to work with the router, see the [Mikrotik documentation](https://wiki.mikrotik.com/wiki/Main_Page).

## Delete the resources you created {#clear-out}

To stop paying for your deployed resources, [delete](../../compute/operations/vm-control/vm-delete.md) the `mikrotik-router` and `test-vm` VMs.

If you reserved a public static IP address, [delete it](../../vpc/operations/address-delete.md).
