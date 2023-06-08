# Routing through a NAT instance

A _NAT instance_ is a special VM with pre-configured routing and IP address translation rules.

{{ yandex-cloud }} allows you to configure internet connections for multiple VMs via a NAT instance using [static routing](../../vpc/concepts/static-routes.md). In this case, only one public IP address is used: the one assigned to the NAT instance.

To set up routing through a NAT instance:

1. [Prepare your cloud](#before-you-begin).
1. [Create a test VM](#create-vm).
1. [Create a NAT instance](#create-nat-instance).
1. [Set up static routing in the cloud network](#configure-static-route).
1. [Test the NAT instance](#test-nat-instance).

If you no longer need the resources you created, [delete them](#clear-out).

You can also deploy the infrastructure for hosting a NAT instance via {{ TF }} using a [ready-made configuration file](#terraform).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of NAT instance support includes:

* Fee for continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using a dynamic or static public IP (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

### Prepare the infrastructure {#deploy-infrastructure}

1. [Create](../../vpc/operations/network-create.md) a cloud network, such as `my-vpc`.
1. In the cloud network, [create](../../vpc/operations/subnet-create.md) subnets, e.g.:
   * `public-subnet` to host the NAT instance.
   * `private-subnet` to host your test VM.

## Create a test VM {#create-vm}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select a folder where you want to create your test VM.
   1. In the list of services, select **{{ compute-name }}**.
   1. Click **Create VM**.
   1. Under **Basic parameters**:
      * In the **Name** field, enter a name for the VM, such as `test-vm`.
      * In the **Availability zone** field, select the availability zone where the `private-subnet` is located.
   1. Under **Image/boot disk selection**, select an image and a Linux-based OS version.
   1. Under **Network settings**:
      * In the **Subnet** field, select a subnet for the test VM, such as `private-subnet`.
      * In the **Public address** field, select **No address**:
      * In the **Internal IPv4 address** field, select **Auto**.
   1. Under **Access**:
      * Enter the username in the **Login** field.
      * Paste the contents of the public SSH key file in the **SSH key** field. You need to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair for SSH connection yourself.
   1. Click **Create VM**.

   Save the username, private SSH key, and internal IP for the test VM.

- {{ TF }}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

## Create a security group {#create-security-groups}

{% include [security-groups-note](../../_includes/vpc/security-groups-note-services.md) %}

[Security groups](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) include rules that allow your VMs to be accessed via SSH. In this tutorial, you will create a security group called `nat-instance-sg`.

To create a security group:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ vpc-name }}**.
   1. Open the **Security groups** tab.
   1. Create a security group:

      1. Click **Create group**.
      1. Enter the **Name** of the group: `nat-instance-sg`.
      1. Select `my-vpc` in the **Network** field.
      1. Under **Rules**, create the following rules using the instructions below the table:

         | Traffic<br/>direction | Description | Port<br/>range | Protocol | Source/<br/>destination type | Source /<br/>destination |
         | --- | --- | --- | --- | --- | --- |
         | Outgoing | any | All | Any | CIDR | 0.0.0.0/0 |
         | Incoming | ssh | 22 | TCP | CIDR | 0.0.0.0/0 |
         | Incoming | ext-http | 80 | TCP | CIDR | 0.0.0.0/0 |
         | Incoming | ext-https | 443 | TCP | CIDR | 0.0.0.0/0 |

         1. Select the **Outgoing traffic** or **Incoming traffic** tab.
         1. Click **Add rule**.
         1. In the **Port range** field of the window that opens, specify a single port or a range of ports that traffic will come to or from.
         1. In the **Protocol** field, specify the desired protocol or leave **Any** to allow traffic transmission over any protocol.
         1. In the **Destination** or **Source** field, select the **CIDR**, and the rule is applied to a range of IP addresses. In the **CIDR blocks** field, enter `0.0.0.0/0`.
         1. Click **Save**. Repeat the steps to create all rules from the table.

      1. Click **Save**.

- {{ TF }}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

## Create a NAT instance {#create-nat-instance}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select a folder where you want to create a NAT instance.
   1. In the list of services, select **{{ compute-name }}**.
   1. Click **Create VM**.
   1. Under **Basic parameters**:
      * In the **Name** field, enter a VM name for the NAT instance, such as `nat-instance`.
      * In the **Availability zone** field, select the availability zone where the `public-subnet` is located.
   1. Under **Image/boot disk selection**, go to the **{{ marketplace-name }}** tab and select the [NAT instance](/marketplace/products/yc/nat-instance-ubuntu-18-04-lts) image.
   1. Under **Network settings**:
      * In the **Subnet** field, select a subnet for the NAT instance, such as `public-subnet`.
      * In the **Public address** field, select **Auto**.
      * In the **Internal IPv4 address** field, select **Auto**.
   1. In the **Access** field:
      * Enter the username in the **Login** field.
      * Paste the contents of the public SSH key file in the **SSH key** field. You need to create a key pair for SSH connection yourself.
   1. Click **Create VM**.

   Save the username, private SSH key, and internal and public IPs for the NAT instance.

- {{ TF }}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

## Set up static routing {#configure-static-route}

{% note info %}

Creating an NAT instance only automatically configures a single network interface. You can enable other interfaces manually. Assign an IP address to each new interface and specify a route for it in a route table. In each subnet, the correct gateway is the first address: `x.x.x.1`.

{% endnote %}

{% list tabs %}

- Management console

   1. Create a route table and add a static route to it:

      1. In the [management console]({{ link-console-main }}), select a folder where you want to create a static route.
      1. In the list of services, select **{{ vpc-name }}**.
      1. Go to ![route-tables](../../_assets/vpc/route-tables.svg) **Route tables**.
      1. Click **Create route table**.
      1. Enter a name for the route table, such as `nat-instance-route`.

   {% include [name-format](../../_includes/name-format.md) %}

      1. Select a network, such as `my-vpc`.
      1. Click **Add route**.
      1. In the window that opens, enter the prefix of the destination subnet: `0.0.0.0/0`.
      1. In the **Next hop** field, select **IP address**.
      1. Specify the internal IP address of the NAT instance. Click **Add**.
      1. Click **Create route table**.
   1. Link the route table to the subnet where the test VM is located, such as `private-subnet`:
      1. Go to ![subnets](../../_assets/vpc/subnets.svg) **Subnets**.
      1. Click ![options](../../_assets/options.svg) next to the subnet with the test VM, such as `private-subnet`.
      1. In the menu that opens, select **Link route table**.
      1. In the window that opens, select the `nat-instance-route` table from the list.
      1. Click **Link**.

- {{ TF }}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

You can also use the created route for other subnets in the same network, except for the subnet where the NAT instance is located.

## Test the NAT instance {#test-nat-instance}

1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the NAT instance over SSH by specifying:
   * Path to the private SSH key file of the NAT instance.
   * NAT instance username.
   * NAT instance public IP.

   Run the following command in the terminal window:

   ```bash
   ssh -i <path_to_NAT_instance_private_SSH_key_file> \
     <NAT_instance_username>@<NAT_instance_public_IP>
   ```

1. On the NAT instance, create a file with the test VM's private SSH key, such as `private-key`:

   ```bash
   sudo nano private-key
   ```

   Paste the contents of the test VM's private SSH key into the file.

1. From the NAT instance, connect to the test VM in the same cloud network via SSH. To do this, specify:
   * Path to the test VM's private SSH key file, such as `private-key`.
   * Test VM username.
   * Test VM's internal IP.

   Run the following command in the terminal window:

   ```bash
   ssh -i <path_to_test_VM_private_SSH_key_file> \
     <test_VM_username>@<test_VM_internal_IP>
   ```

1. Make sure the test VM is connected to the internet via the public IP of the NAT instance. Enter the following command in the terminal:

   ```bash
   curl ifconfig.co
   ```

   If it returns the public IP address of the NAT instance, everything is correct.

## How to delete the resources you created {#clear-out}

To stop paying for the created resources, [delete](../../compute/operations/vm-control/vm-delete.md) the test VM and the NAT instance.

## How to create an infrastructure using {{ TF }} {#terraform}

{% include [terraform-definition](../terraform-definition.md) %}

To set up routing through a NAT instance using {{ TF }}:

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Prepare a file with the infrastructure description:

   {% list tabs %}

   - Ready-made archive

      1. Create a directory for the file with the infrastructure description.
      1. Download the [archive](https://{{ s3-storage-host }}/doc-files/nat-instance-tf.zip) (2 KB).
      1. Unpack the archive to the directory. As a result, it should contain the `nat-instance.tf` configuration file and the `nat-instance.auto.tfvars` file with user data.

   - Creating files manually

      1. Create a directory for the file with the infrastructure description.
      1. Create the `nat-instance.tf` configuration file in the directory:

         {% cut "nat-instance.tf" %}

         {% include [nat-instance-tf-config](../../_includes/routing/nat-instance-tf-config.md) %}

         {% endcut %}

      1. Create the `nat-instance.auto.tfvars` file with user data in the directory:

         {% cut "nat-instance.auto.tfvars" %}

         {% include [nat-instance-tf-variables](../../_includes/routing/nat-instance-tf-variables.md) %}

         {% endcut %}

   {% endlist %}

   {% include [sg-note-tf](../../_includes/vpc/sg-note-tf.md) %}

   For more information about the parameters of resources used in {{ TF }}, see the provider documentation:

   * [yandex_vpc_network]({{ tf-provider-link }}/vpc_network)
   * [yandex_vpc_subnet]({{ tf-provider-link }}/vpc_subnet)
   * [yandex_vpc_security_group]({{ tf-provider-link }}/vpc_security_group)
   * [yandex_compute_image]({{ tf-provider-link }}/compute_image)
   * [yandex_compute_instance]({{ tf-provider-link }}/compute_instance)
   * [yandex_vpc_route_table]({{ tf-provider-link }}/vpc_route_table)

1. In the `nat-instance.auto.tfvars` file, set the user-defined parameters:

   * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md).
   * `vm_user`: VM username.
   * `vm_user_nat`: NAT instance username.
   * `ssh_key_path`: Path to the file with a public SSH key to authenticate the user on the VM. For details, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

1. Create resources:

   {% include [terraform-validate-plan-apply](../terraform-validate-plan-apply.md) %}

1. [Test the NAT instance](#test-nat-instance).
