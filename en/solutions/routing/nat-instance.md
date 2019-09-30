# Routing through a NAT instance

Yandex.Cloud allows you to configure internet connections for multiple VMs via a NAT instance using static routing. In this case, only one public IP address will be used: the one that is assigned to the NAT instance.

To set up routing through the NAT instance:

1. [Create and configure a NAT instance VM](#create-nat-instance).
2. [Set up static routing in the cloud network](#configure-static-route).
3. [Test the NAT instance](#test-nat-instance).

## Before you start {#before-begin}

1. Create a [virtual network](../../vpc/operations/network-create.md) with any name, for example `my-vpc`.
1. Create a [subnet](../../vpc/operations/subnet-create.md) for NAT-instance with any name, for example `public-subnet`. Do not associate any route tables with this subnet.
1. Create one more subnet in the new network, for example `private-subnet`.
1. Create a [virtual machine](../../compute/operations/vm-create/create-linux-vm.md) without public IP address and connect it to the `private-subnet` subnet.

## 1. Create a NAT instance {#create-nat-instance}

Create a VM to be used as a NAT instance.

1. Open your folder and click **Create resource**. Select **Virtual machine**.
1. Enter a name for the VM, for example, `nat-instance`.
1. Select the availability zone of the `public-subnet` subnet.
1. Under **Public images**, click **Select** and choose the **NAT instance** image.
1. Under **Network settings**, choose the required network and subnet and assign a public IP to the VM either by selecting it from the list or automatically.
1. In the **Access** field, enter the login and SSH key to access the VM.
1. Click **Create VM**.

## 2. Set up static routing {#configure-static-route}

Set up routing between the NAT instance and previously created VM with no public IP address:

Create a route table and add [static routes](../../vpc/concepts/static-routes.md):

1. Open the **Virtual Private Cloud** section in the folder where you want to create a static route.

1. Select the `my-vpc` network.

1. Click ![image](../../_assets/plus.svg)**Create route table**.

1. Enter a name for the route table, for example, `nat-instance-route`.

   {% include [name-format](../../_includes/name-format.md) %}

1. Click **Add route**.

1. In the window that opens, enter the prefix of the destination subnet: `0.0.0.0/0`.

1. In the **Next hop** field, specify the internal IP address of the NAT instance. Click **Add**.

1. Click **Create route table**.

To use static routes, link the route table to a subnet. In our example it will be `private-subnet`. To do this:

1. In the line with the desired subnet, click ![image](../../_assets/options.svg).
1. In the menu that opens, select **Link route table**.
1. In the window that opens, select the `nat-instance-route` table from the list.
1. Click **Link**.

You can also use the created route for other subnets in the same network.

## 3. Test the NAT instance {#test-nat-instance}

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

