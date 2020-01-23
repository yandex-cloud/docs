# Installing a Mikrotik CHR virtual router

In Yandex.Cloud, you can deploy a virtual Mikrotik Cloud Hosted Router from a VM image. To install Mikrotik Cloud Hosted Router and check its operability:

1. [Before you start](#before-begin).
1. [Create a VM with Mikrotik Cloud Hosted Router](#create-router).
1. [Log in to your VM and change your password](#change-password).
1. [Create a test VM](#create-test-vm).
1. [Check the connection between the router and test VM](#test-connection).

If you no longer need the created resources, [delete them](#clear-out).

## Before you start {#before-begin}

{% include [before-begin](../_solutions_includes/before-begin.md) %}

### Required paid resources {#paid-resources}

{% note alert %}

When you use a Mikrotik Cloud Hosted Router image without a license, the router throughput is limited to 1 Mbps. To remove this limit, [install a license](https://wiki.mikrotik.com/wiki/Manual:CHR#CHR_Licensing).

{% endnote %}

The cost of using a virtual router and test VM includes:

* A fee for the disks and continuously running VMs (see [{{ compute-full-name }}pricing](../../compute/pricing.md)).
* A fee for using a public IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

## Create a VM with Mikrotik Cloud Hosted Router {#create-router}

1. Open your folder and click **Create resource**. Select **Virtual machine**.
1. Enter a name for the VM, like `mikrotik-router`.
1. Select an [availability zone](../../overview/concepts/geo-scope.md) with a subnet. If you don't know which availability zone you need, leave the default.
1. Under **Public images**, click **Select** and choose the **Cloud Hosted Router** image.
1. Under **Computing resources**:
    - Choose a [platform](../../compute/concepts/vm-platforms.md) for the VM.
    - Specify the number of vCPUs and amount of RAM:
      * **Platform**: Intel Cascade Lake.
      * **Guaranteed vCPU share**: 100%.
      * **vCPU**: 2.
      * **RAM**: 2 GB.
1. In the **Network settings** section, choose the required network and subnet and assign a public IP to the VM either by selecting it from the list or automatically. If you don't have a network or subnet, create them on the VM creation screen.
1. In the **Access** field, enter the login and SSH key to access the VM. Note that you only need this data for VM creation. You can't use the data for router access.
1. Click **Create VM**.

Creating the VM may take several minutes. When the VM's status changes to `RUNNING`, you can log in.

{% note alert %}

Set a complex administrator password immediately after VM creation.

{% endnote %}

## Change the administrator password on the router {#change-password}

The router is created with a public IP address, so you need to change the default administrator password for security reasons.

1. Open the `mikrotik-router` VM page in the [management console]({{ link-console-main }}).
1. Copy the VM's public address and open it in your browser. The initial router setup screen opens.
1. Enter the VM's internal IP address in the **IP Address** field.
1. On the page that opens, enter the new administrator password, confirm it, and click **Apply Configuration**. You can make other settings later.

## Create a test VM {#create-test-vm}

Create a test VM in the subnet that hosts the router, to test connectivity between the router and VM.

1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select **Virtual machine**.

1. In the **Name** field, enter the VM name: `test-vm`.

1. Select the same [availability zone](../../overview/concepts/geo-scope.md) where the `mikrotik-router` VM is located.

1. Under **Public images**, select **Ubuntu**.

1. Under **Computing resources**:
    - Choose a [platform](../../compute/concepts/vm-platforms.md) for the VM.
    - Specify the necessary number of vCPUs and amount of RAM.
     * **Platform**: Intel Cascade Lake.
     * **Guaranteed vCPU share**: 5%.
     * **vCPU**: 2.
     * **RAM**: 0.5 GB.

1. Under **Network settings**, select the network and subnet hosting the  `mikrotik-router` VM.

1. In the **Public address** field, select **No address**.

1. In the **Access** field, enter the login and SSH key to access the VM.

1. Click **Create VM**.

### Check the connection between the router and test VM {#test-connection}

{% note alert %}

If you use WinBox to access the router, connect to the router using the VM's IP address. MAC access is not supported in Yandex.Cloud.

{% endnote %}

Make sure that a network connection has been established between the router and test VM:

1. Open the router's administrative interface in the browser.
1. Click **Terminal**.
1. In the terminal that opens, run `ping <internal IP address of the test VM>`.

If the packets reach the test VM, you can start configuring the router. Read about the router in the [Mikrotik documentation](https://wiki.mikrotik.com/wiki/Main_Page).

## Delete the created resources {#clear-out}

To stop paying for the deployed resources, [delete](../../compute/operations/vm-control/vm-delete.md) the `mikrotik-router` and `test-vm` virtual machines.

If you reserved a public static IP address, [delete it](../../vpc/operations/address-delete.md).

