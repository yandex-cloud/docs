1. [Prepare your cloud](#before-you-begin).
1. [Create a security group](#create-security-groups).
1. [Create a test VM](#create-vm).
1. [Create a NAT instance](#create-nat-instance).
1. [Set up static routing in the cloud network](#configure-static-route).
1. [Test the NAT instance](#test).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/nat-instance/paid-resources.md) %}


### Prepare the infrastructure {#deploy-infrastructure}

1. [Create a cloud network](../../vpc/operations/network-create.md), e.g., `my-vpc`.
1. In the cloud [network](../../vpc/concepts/network.md#network), [create subnets](../../vpc/operations/subnet-create.md), e.g.:

    * `public-subnet` to host the NAT instance.
    * `private-subnet` to host your test VM.


## Create a security group {#create-security-groups}

[Security groups](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) include rules that allow your VMs to be accessed via SSH. In this tutorial, you will create a security group named `nat-instance-sg`.

To create a security group:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Open the ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.switch_security-groups }}** tab.
  1. Create a security group:

      1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** field, specify the name: `nat-instance-sg`.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** field, select `my-vpc`.
      1. Under **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}**, create the following rules using the instructions below the table:

          Traffic<br>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} /<br>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
          --- | --- | --- | --- | --- | ---
          Outgoing | `any` | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
          Incoming | `ssh` | `22` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
          Incoming | `ext-http` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
          Incoming | `ext-https` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`

      1. Select the **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** or **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}** tab.
      1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** field of the window that opens, specify a single port or a range of ports that traffic will come to or from. To open all ports, click **{{ ui-key.yacloud.vpc.network.security-groups.forms.button_select-all-port-range }}**.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** field, specify the appropriate protocol or leave **{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}** to allow traffic transmission over any protocol.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** or **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** field, select the `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`, and the rule will apply to a range of IP addresses. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** field, specify `0.0.0.0/0`.
      1. Click **{{ ui-key.yacloud.common.save }}**. Repeat the steps to create all the rules from the table.
      1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}


## Create a test VM {#create-vm}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder where you want to create your test VM.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**:

      * In the **{{ ui-key.yacloud.common.name }}** field, enter the VM name, e.g., `test-vm`.
      * In the **{{ ui-key.yacloud.compute.instances.create.field_zone }}** field, select the availability zone where `private-subnet` is located.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select an image and a Linux-based OS version.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select a subnet for the test VM, e.g., `private-subnet`.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select **{{ ui-key.yacloud.component.compute.network-select.switch_none }}**.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}** field, select **{{ ui-key.yacloud.component.compute.network-select.switch_auto }}**.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** field, select the `nat-instance-sg` security group you created earlier.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**:

      * Enter the username into the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.
      * Paste the contents of the public SSH key file in the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field. You need to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) an SSH key pair yourself.

          {% note info %}

          Save the keys in the default directory and give them standard names, e.g., `id_ed25519` or `id_rsa`.

          {% endnote %}

  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  Save the username, private SSH key, and internal IP address for the test VM.

{% endlist %}


## Create a NAT instance {#create-nat-instance}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to create a NAT instance in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
      * In the **{{ ui-key.yacloud.common.name }}** field, enter a VM name for the NAT instance, e.g., `nat-instance`.
      * In the **{{ ui-key.yacloud.compute.instances.create.field_zone }}** field, select the availability zone where `public-subnet` is located.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab and select the [NAT instance](/marketplace/products/yc/nat-instance-ubuntu-18-04-lts) image.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select a subnet for the NAT instance, e.g., `public-subnet`.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** field, select the `nat-instance-sg` security group you created earlier.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**:

      * Enter the username into the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.
      * Paste the contents of the public SSH key file in the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field. You need to create an SSH key pair yourself.

          {% note info %}

          Save the keys in the default directory and give them standard names, e.g., `id_ed25519` or `id_rsa`.

          {% endnote %}

  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  Save the username, private SSH key, and internal and public IP addresses for the NAT instance.

{% endlist %}


## Set up static routing {#configure-static-route}

{% note info %}

When creating a NAT instance automatically, only one network interface is configured. You can enable other interfaces manually. Assign an IP address to each new interface and specify a route for it in a route table. In each subnet, the first IP address will represent the correct gateway. For example, for the `192.168.0.128/25` subnet, the first subnet address will be `192.168.0.129`.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Create a route table and add a static route to it:

      1. In the [management console]({{ link-console-main }}), select a folder where you want to create a static route.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
      1. In the left-hand panel, select ![route-tables](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.vpc.network.switch_route-table }}**.
      1. Click **{{ ui-key.yacloud.common.create }}**.
      1. In the **{{ ui-key.yacloud.vpc.route-table-form.field_name }}** field, enter a name for the route table, e.g., `nat-instance-route`. The naming requirements are as follows:

          {% include [name-format](../../_includes/name-format.md) %}

      1. In the **{{ ui-key.yacloud.vpc.route-table-form.field_network-id }}** field, select a network, e.g., `my-vpc`.
      1. Under **{{ ui-key.yacloud.vpc.route-table-form.section_static-routes }}**, click **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.
      1. In the window that opens, enter `0.0.0.0/0` in the **{{ ui-key.yacloud.vpc.add-static-route.field_destination-prefix }}** field.
      1. In the **{{ ui-key.yacloud.vpc.add-static-route.field_next-hop-address }}** field, select `{{ ui-key.yacloud.vpc.add-static-route.value_ip-address }}`.
      1. In the **{{ ui-key.yacloud.vpc.add-static-route.value_ip-address }}** field, specify the internal IP address of the NAT instance. Click **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.
      1. Click **{{ ui-key.yacloud.vpc.route-table.create.button_create }}**.

  1. Link the route table to the subnet where the test VM is located, e.g., `private-subnet`:

      1. In the left-hand panel, select ![subnets](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
      1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row of the subnet with the test VM and select **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
      1. In the window that opens, select the `nat-instance-route` table in the **{{ ui-key.yacloud.vpc.subnet.add-route-table.label_title }}** field and click **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.

{% endlist %}

You can also use the created route for other subnets in the same network, except for the subnet where the NAT instance is located.

{% note warning %}

Do not link the route table to the subnet where the NAT instance is located. Otherwise, route loops will occur, where the NAT instance will direct packets to itself rather than to the local network.

{% endnote %}


## Test the NAT instance {#test}

{% include [test](../_tutorials_includes/nat-instance/test.md) %}


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete](../../compute/operations/vm-control/vm-delete.md) the test VM and NAT instance.
1. [Delete](../../vpc/operations/security-group-delete.md) the security group.
1. [Delete](../../vpc/operations/address-delete.md) the static public IP if you reserved one.