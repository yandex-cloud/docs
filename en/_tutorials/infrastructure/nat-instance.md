# Routing through a NAT instance


A _NAT instance_ is a special [VM](../../compute/concepts/vm.md) with pre-configured routing and [IP address](../../vpc/concepts/address.md) translation rules.

{{ yandex-cloud }} allows you to configure internet connections for multiple VMs via a NAT instance using [static routing](../../vpc/concepts/static-routes.md). In this case, only one public IP address is used: the one assigned to the NAT instance.

To set up routing through a NAT instance:
1. [Prepare your cloud](#before-you-begin).
1. [Create a security group](#create-security-groups).
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
* Fee for using a dynamic or static external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

### Prepare the infrastructure {#deploy-infrastructure}

1. [Create](../../vpc/operations/network-create.md) a cloud network, e.g., `my-vpc`.
1. In the cloud [network](../../vpc/concepts/network.md#network), [create subnets](../../vpc/operations/subnet-create.md), e.g.:
   * `public-subnet` to host the NAT instance.
   * `private-subnet` to host your test VM.

## Create a security group {#create-security-groups}

[Security groups](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) include rules that allow your VMs to be accessed via SSH. In this tutorial, you will create a security group called `nat-instance-sg`.

To create a security group:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. Open the ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.switch_security-groups }}** tab.
   1. Create a security group:
      1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** field, enter the group name: `nat-instance-sg`.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** field, select the `my-vpc` network.
      1. Under **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}**, create the following rules using the instructions below the table:

         | Traffic<br>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} /<br>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
         | --- | --- | --- | --- | --- | --- |
         | Outgoing | `any` | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
         | Incoming | `ssh` | `22` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
         | Incoming | `ext-http` | `80` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
         | Incoming | `ext-https` | `443` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |

      1. Select the **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** or **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}** tab.
      1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** field of the window that opens, specify a single port or a range of ports that traffic will come to or from. To open all ports, click **{{ ui-key.yacloud.vpc.network.security-groups.forms.button_select-all-port-range }}**.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** field, specify the appropriate protocol or leave **{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}** to allow traffic transmission over any protocol.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** or **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** field, select the `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`, and the rule will apply to a range of IP addresses. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** field, enter `0.0.0.0/0`.
      1. Click **{{ ui-key.yacloud.common.save }}**. Repeat the steps to create all the rules from the table.
      1. Click **{{ ui-key.yacloud.common.save }}**.

- {{ TF }} {#tf}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

## Create a test VM {#create-vm}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a folder where you want to create your test VM.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
      * In the **{{ ui-key.yacloud.compute.instances.create.field_name }}** field, enter a name for the VM, such as `test-vm`.
      * In the **{{ ui-key.yacloud.compute.instances.create.field_zone }}** field, select the availability zone where `private-subnet` is located.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select an image and a Linux-based OS version.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select a subnet for the test VM, such as `private-subnet`.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select **{{ ui-key.yacloud.component.compute.network-select.switch_none }}**.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}** field, select **{{ ui-key.yacloud.component.compute.network-select.switch_auto }}**.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** field, select the `nat-instance-sg` group you created earlier.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**:
      * Enter the username in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.
      * Paste the contents of the public SSH key file in the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field. You need to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) an SSH key pair yourself.

         {% note info %}

         Save the keys in the default directory and give them standard names, e.g., `id_ed25519` or `id_rsa`.

         {% endnote %}

   1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   Save the username, private SSH key, and internal IP address for the test VM.

- {{ TF }} {#tf}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

## Create a NAT instance {#create-nat-instance}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a folder where you want to create a NAT instance.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
      * In the **{{ ui-key.yacloud.compute.instances.create.field_name }}** field, enter a VM name for the NAT instance, such as `nat-instance`.
      * In the **{{ ui-key.yacloud.compute.instances.create.field_zone }}** field, select the availability zone where `public-subnet` is located.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab and select the [NAT instance](/marketplace/products/yc/nat-instance-ubuntu-18-04-lts) image.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select a subnet for the NAT instance, such as `public-subnet`.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** field, select the `nat-instance-sg` group you created earlier.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**:
      * Enter the username in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.
      * Paste the contents of the public SSH key file in the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field. You need to create an SSH key pair yourself.

         {% note info %}

         Save the keys in the default directory and give them standard names, e.g., `id_ed25519` or `id_rsa`.

         {% endnote %}

   1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   Save the username, private SSH key, and internal and public IP addresses for the NAT instance.

- {{ TF }} {#tf}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

## Set up static routing {#configure-static-route}

{% note info %}

Creating a NAT instance automatically configures only a single network interface. You can enable other interfaces manually. Assign an IP address to each new interface and specify a route for it in a route table. In each subnet, the first IP address will represent the correct gateway. For example, for the `192.168.0.128/25` subnet, the first subnet address will be `192.168.0.129`.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   1. Create a route table and add a static route to it:
      1. In the [management console]({{ link-console-main }}), select a folder where you want to create a static route.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
      1. In the left-hand panel, select ![route-tables](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.vpc.network.switch_route-table }}**.
      1. Click **{{ ui-key.yacloud.common.create }}**.
      1. In the **{{ ui-key.yacloud.vpc.route-table-form.field_name }}** field, enter a name for the route table, such as `nat-instance-route`. The naming requirements are as follows:

         {% include [name-format](../../_includes/name-format.md) %}

      1. In the **{{ ui-key.yacloud.vpc.route-table-form.field_network-id }}** field, select a network, such as `my-vpc`.
      1. Under **{{ ui-key.yacloud.vpc.route-table-form.section_static-routes }}**, click **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.
      1. In the window that opens, enter `0.0.0.0/0` in the **{{ ui-key.yacloud.vpc.add-static-route.field_destination-prefix }}** field.
      1. In the **{{ ui-key.yacloud.vpc.add-static-route.field_next-hop-address }}** field, select `{{ ui-key.yacloud.vpc.add-static-route.value_ip-address }}`.
      1. In the **{{ ui-key.yacloud.vpc.add-static-route.value_ip-address }}** field, specify the internal IP address of the NAT instance. Click **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.
      1. Click **{{ ui-key.yacloud.vpc.route-table.create.button_create }}**.
   1. Link the route table to the subnet where the test VM is located, such as `private-subnet`:
      1. In the left-hand panel, select ![subnets](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
      1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row of the subnet with the test VM and select **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
      1. In the window that opens, select the `nat-instance-route` table in the **{{ ui-key.yacloud.vpc.subnet.add-route-table.popup-route-table_field_route-table-id }}** field and click **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.

- {{ TF }} {#tf}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

You can also use the created route for other subnets in the same network, except for the subnet where the NAT instance is located.

## Test the NAT instance {#test-nat-instance}

1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM via a private IP address, using the NAT instance as a jump host:

   ```bash
   ssh -J <NAT_instance_user_name>@<NAT_instance_public_IP_address> \
     <VM_user_name>@<VM_internal_IP_address>
   ```

   You can also connect to the test VM using the standard input/output redirection (the `-W` flag) to forward the connection through a NAT instance:

   ```bash
   ssh -o ProxyCommand="ssh -i <path/NAT_key_file_name> -W %h:%p <NAT_user_name>@<NAT_public_IP_address>" \
     -i <VM_key_file_path/name> <VM_user_name>@<VM_internal_IP_address>
   ```

   Use this command for connection in the following cases:

   * Your VM is running an OpenSSH version below 7.3.
   * Your SSH keys are stored outside the default directory or have non-standard names.

1. Type **yes** to connect to the NAT instance and re-enter **yes** to connect to the test VM.

   {% note info %}

   When you type **yes**, the command may not be displayed in the terminal, but it will run anyway.

   {% endnote %}

1. Make sure the test VM is connected to the internet via the public IP address of the NAT instance. Run this command:

   ```bash
   curl ifconfig.co
   ```

   If it returns the public IP address of the NAT instance, the configuration is correct.

## How to delete the resources you created {#clear-out}

To stop paying for the created resources, [delete](../../compute/operations/vm-control/vm-delete.md) the test VM and the NAT instance.

## How to create an infrastructure using {{ TF }} {#terraform}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

To set up routing through a NAT instance using {{ TF }}:
1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Prepare a file with the infrastructure description:

   {% list tabs group=infrastructure_description %}

   - Ready-made archive {#ready}

      1. Create a directory for the file with the infrastructure description.
      1. Download the [archive](https://{{ s3-storage-host }}/doc-files/nat-instance-tf.zip) (2 KB).
      1. Unpack the archive to the directory. As a result, it should contain the `nat-instance.tf` configuration file and the `nat-instance.auto.tfvars` file with user data.

   - Manually {#manual}

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
   * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
   * `vm_user`: VM username.
   * `vm_user_nat`: NAT instance username.
   * `ssh_key_path`: Path to the file with a public SSH key to authenticate the user on the VM. For more information, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
1. Create resources:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

1. [Test the NAT instance](#test-nat-instance).