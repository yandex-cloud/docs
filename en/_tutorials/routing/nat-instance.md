# Routing through a NAT instance

A _NAT instance_ is a special VM with pre-configured routing and IP address translation rules.

{{ yandex-cloud }} allows you to configure internet connections for multiple VMs via a NAT instance using [static routing](../../vpc/concepts/routing.md). In this case, only one public IP address is used: the one assigned to the NAT instance.

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
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
      * In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the VM, such as `test-vm`.
      * In the **{{ ui-key.yacloud.compute.instances.create.field_zone }}** field, select the availability zone where the `private-subnet` is located.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select an image and a Linux-based OS version.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select a subnet for the test VM, such as `private-subnet`.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select **{{ ui-key.yacloud.component.compute.network-select.switch_none }}**.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}** field, select **{{ ui-key.yacloud.component.compute.network-select.switch_auto }}**.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**:
      * Enter username in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.
      * Paste the contents of the public SSH key file in the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field. You need to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair for SSH connection yourself.
   1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   Save the username, private SSH key, and internal IP for the test VM.

- {{ TF }}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

## Create a security group {#create-security-groups}

[Security groups](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) include rules that allow your VMs to be accessed via SSH. In this tutorial, you will create a security group called `nat-instance-sg`.

To create a security group:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. Open the **{{ ui-key.yacloud.vpc.switch_security-groups }}** tab.
   1. Create a security group:

      1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** field, enter the group name: `nat-instance-sg`.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** field, select the `my-vpc` network.
      1. Under **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}**, create the following rules using the instructions below the table:

         | Traffic<br/>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
         | --- | --- | --- | --- | --- | --- |
         | Outgoing | `any` | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
         | Incoming | `ssh` | `22` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
         | Incoming | `ext-http` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
         | Incoming | `ext-https` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |

         1. Select the **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** or **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}** tab.
         1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
         1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** field of the window that opens, specify a single port or a range of ports that traffic will come to or from. To open all ports, click **{{ ui-key.yacloud.vpc.network.security-groups.forms.button_select-all-port-range }}**.
         1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** field, specify the desired protocol or leave **{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}** to allow traffic transmission over any protocol.
         1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** or **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** field, select the `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`, and the rule will apply to a range of IP addresses. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** field, enter `0.0.0.0/0`.
         1. Click **{{ ui-key.yacloud.common.save }}**. Repeat the steps to create all the rules from the table.

      1. Click **{{ ui-key.yacloud.common.save }}**.

- {{ TF }}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

## Create a NAT instance {#create-nat-instance}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select a folder where you want to create a NAT instance.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
      * In the **{{ ui-key.yacloud.common.name }}** field, enter a VM name for the NAT instance, such as `nat-instance`.
      * In the **{{ ui-key.yacloud.compute.instances.create.field_zone }}** field, select the availability zone where the `public-subnet` is located.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab and select the [NAT instance](/marketplace/products/yc/nat-instance-ubuntu-18-04-lts) image.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select a subnet for the NAT instance, such as `public-subnet`.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**:
      * Enter username in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.
      * Paste the contents of the public SSH key file in the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field. You need to create a key pair for SSH connection yourself.
   1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

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
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
      1. In the left-hand panel, select ![route-tables](../../_assets/vpc/route-tables.svg) **{{ ui-key.yacloud.vpc.network.switch_route-table }}**.
      1. Click **{{ ui-key.yacloud.common.create }}**.
      1. In the **{{ ui-key.yacloud.vpc.route-table-form.field_name }}** field, enter a name for the route table, such as `nat-instance-route`.

         {% include [name-format](../../_includes/name-format.md) %}

      1. In the **{{ ui-key.yacloud.vpc.route-table-form.field_network-id }}** field, select a network, such as `my-vpc`.
      1. Under **{{ ui-key.yacloud.vpc.route-table-form.section_static-routes }}**, click **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.
      1. In the window that opens, enter `0.0.0.0/0` in the **{{ ui-key.yacloud.vpc.add-static-route.field_destination-prefix }}** field.
      1. In the **{{ ui-key.yacloud.vpc.add-static-route.field_next-hop-address }}** field, select `{{ ui-key.yacloud.vpc.add-static-route.value_ip-address }}`.
      1. In the **{{ ui-key.yacloud.vpc.add-static-route.value_ip-address }}** field, specify the internal IP address of the NAT instance. Click **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.
      1. Click **{{ ui-key.yacloud.vpc.route-table.create.button_create }}**.
   1. Link the route table to the subnet where the test VM is located, such as `private-subnet`:
      1. In the left-hand panel, select ![subnets](../../_assets/vpc/subnets.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
      1. Click ![image](../../_assets/options.svg) in the row of the subnet with the test VM and select **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
      1. In the window that opens, select the `nat-instance-route` table in the **{{ ui-key.yacloud.vpc.subnet.add-route-table.label_title }}** field and click **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.

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

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

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

   For more information about the parameters of resources used in {{ TF }}, see the provider documentation:

   * [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network)
   * [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet)
   * [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group)
   * [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image)
   * [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance)
   * [yandex_vpc_route_table]({{ tf-provider-resources-link }}/vpc_route_table)

1. In the `nat-instance.auto.tfvars` file, set the user-defined parameters:

   * `folder_id`: [folder id](../../resource-manager/operations/folder/get-id.md).
   * `vm_user`: VM username.
   * `vm_user_nat`: NAT instance username.
   * `ssh_key_path`: Path to the file with a public SSH key to authenticate the user on the VM. For details, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

1. Create resources:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

1. [Test the NAT instance](#test-nat-instance).
