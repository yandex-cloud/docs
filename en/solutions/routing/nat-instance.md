# Routing through a NAT instance

Yandex.Cloud lets you configure internet connections for multiple VMs via a NAT instance using static routing. In this case, only one public IP address is used: the one assigned to the VM.

To set up routing through a NAT instance:

1. [Before you start](#before-you-begin).
1. [Create a network, subnet, and test VM](#create-environment).
1. [Create and configure a NAT instance](#create-nat-instance).
1. [Set up static routing in the cloud network](#configure-static-route).
1. [Test the NAT instance](#test-nat-instance).

If you no longer need the NAT instance, [delete it](#clear-out).

## Before you start {#before-you-begin}

Before deploying the server, you need to sign up for Yandex.Cloud and create a billing account:

{% include [prepare-register-billing](../_solutions_includes/prepare-register-billing.md) %}

If you have an active billing account, you can create or select a folder to run your VM in from the [Yandex.Cloud page](https://console.cloud.yandex.com/cloud).

[Learn more about clouds and folders](../../resource-manager/concepts/resources-hierarchy.md).

### Required paid resources {#paid-resources}

The cost of NAT instance support includes:

* A fee for continuously running VMs (see [pricing{{ compute-full-name }}](../../compute/pricing.md)).
* A fee for using a dynamic external IP address (see [pricing {{ vpc-full-name }}](../../vpc/pricing.md)).

## Create a network, subnet, and test VM {#create-environment}

1. Create a [cloud network](../../vpc/operations/network-create.md) with any name, such as `my-vpc`.
1. In the cloud network, create a [subnet](../../vpc/operations/subnet-create.md) for your NAT instance with any name, such as `nat-subnet`. Don't assign any routing tables to it.
1. Create another subnet in the cloud network, such as `private-subnet`.
1. Create a test [VM](../../compute/operations/vm-create/create-linux-vm.md) without a public IP and connect it to the `private-subnet` subnet.

## Create a NAT instance {#create-nat-instance}

Create a VM to use for internet access.

1. Open your folder and click **Create resource**. Select **Virtual machine**.
1. Enter a name for the VM, for example, `nat-instance`.
1. Select the availability zone where the `public-subnet ` subnet is located.
1. Under **Images from {{ marketplace-name }}**, click **Select** and choose the **NAT instance** image.
1. Under **Network settings**, choose the required network and subnet and assign a public IP to the NAT instance either automatically or by selecting it from the list.
1. In the **Access** field, enter the login and SSH key to access the VM.
1. Click **Create VM**.

## Set up static routing {#configure-static-route}

Set up routing between the NAT instance and test VM.

Create a route table and add to it a [static route](../../vpc/concepts/static-routes.md):

1. Open the **Virtual Private Cloud** section in the folder where you want to create a static route.

1. Select the `my-vpc` network.

1. Click ![image](../../_assets/plus.svg)**Create route table**.

1. Enter a name for the route table, such as `nat-instance-route`.

   {% include [name-format](../../_includes/name-format.md) %}

1. Click **Add route**.

1. In the window that opens, enter the prefix of the destination subnet: `0.0.0.0/0`.

1. In the **Next hop** field, specify the internal IP address of the NAT instance. Click **Add**.

1. Click **Create route table**.

To use static routes, link the route table to the subnet where the VMs are located (in the example, it's `private-subnet`). To do this:

1. On the line with the test VM, click ![image](../../_assets/options.svg).
1. In the menu that opens, select **Link route table**.
1. In the window that opens, select the `nat-instance-route` table from the list.
1. Click **Link**.

You can also use the created route for other subnets in the same network, except for the subnet where the NAT instance is located.

## Test the NAT instance {#test-nat-instance}

1. Connect to the NAT instance via `SSH`:

   ```
   $ ssh <NAT instance public IP>
   ```

1. Use the NAT instance to connect to the test VM in the same subnet via SSH:

   ```
   $ ssh <VM internal IP>
   ```

1. Make sure the VM is connected to the internet via the public IP address of the NAT instance. Enter the following command in the terminal:

   ```
   $ curl ifconfig.co
   ```

   If it returns the public IP address of the NAT instance, everything is correct.

## Delete the created resources {#clear-out}

If you no longer need the NAT instance, [delete](../../compute/operations/vm-control/vm-delete.md) the `nat-instance` VM.

