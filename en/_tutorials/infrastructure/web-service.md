# Architecture and protection of a basic internet service


You will deploy and configure the infrastructure of a basic internet service with multiple VMs. Access to VMs will be restricted using security groups. A network load balancer will distribute the load across web app servers.

To create the infrastructure of an internet service:

1. [Prepare your cloud](#before-begin).
1. [Prepare the network infrastructure](#prepare-network).
1. [Reserve two static public IP addresses](#reserve-ips).
1. [Create VMs for the service in all availability zones](#create-vms).
1. [Create an IPSec instance for remote access](#create-ipsec-instance).
1. [Configure VPN routing](#vpn-routing).
1. [Create a route table](#create-route-table).
1. [Link the route table to all subnets](#associate-route-table).
1. [Create and configure security groups](#create-security-group).
1. [Assign the security groups to the VMs](#assign-security-groups-vm).
1. [Create a network load balancer](#create-load-balancer).
1. [Test the infrastructure](#test).

If you no longer need the infrastructure, [delete](#clear-out) the created resources.

## Prepare your cloud {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of internet service support includes:

* Fee for continuously running virtual machines (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using public static IP addresses (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for using a network load balancer (see [{{ network-load-balancer-full-name }} pricing](../../network-load-balancer/pricing.md)).


## Prepare the network infrastructure {#prepare-network}

Before creating a VM:

1. Go to the {{ yandex-cloud }} [management console]({{ link-console-main }}) and open the folder where you want to perform the operations.
1. Select **{{ vpc-name }}** and create a [cloud network](../../vpc/operations/network-create.md) with [subnets](../../vpc/operations/subnet-create.md) named `subnet-a`, `subnet-b`, and `subnet-d` in the `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-d` availability zones, respectively.

## Reserve two static public IP addresses {#reserve-ips}

For your internet service to run, you need two static public IP addresses: one to be assigned to the VPN gateway and the other to the network load balancer.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}** in the folder where you want to reserve the IP addresses.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}**. Click **{{ ui-key.yacloud.vpc.addresses.button_create }}**.
   1. In the window that opens, select the `{{ region-id }}-b` availability zone. Click **{{ ui-key.yacloud.vpc.addresses.popup-create_button_create }}**.
   1. Click **{{ ui-key.yacloud.vpc.addresses.button_create }}** once again.
   1. In the window that opens, select the `{{ region-id }}-a` availability zone. Click **{{ ui-key.yacloud.vpc.addresses.popup-create_button_create }}**.

{% endlist %}

## Create VMs for the service in all availability zones {#create-vms}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), open your folder and click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** in the top-right corner. Select **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
   1. Enter the VM name: `web-node-a`.
   1. Select the `{{ region-id }}-a` availability zone.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab and select the [Drupal](/marketplace/products/yc/drupal-8) image.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, select the `subnet-a` subnet. In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select **{{ ui-key.yacloud.component.compute.network-select.switch_none }}**.
   1. In the **{{ ui-key.yacloud.compute.instances.create.section_access }}** field, enter the login and SSH key to access the VM. You need to [create](../../compute/operations/images-with-pre-installed-software/operate.md#creating-ssh-keys) an SSH key pair yourself.
   1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
   1. Repeat the steps for the VMs named `web-node-b` and `web-node-d`. Create them in the `{{ region-id }}-b` and `{{ region-id }}-d` availability zones and connect them to `subnet-b` and `subnet-d`, respectively.

{% endlist %}

## Create an IPSec instance for remote access {#create-ipsec-instance}

To provide secure access to your resources, create an IPSec instance.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), open your folder and click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** in the top-right corner. Select **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
   1. Enter the VM name: `vpn`.
   1. Select the `{{ region-id }}-a` availability zone.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab and select the [IPSec instance](/marketplace/products/yc/ipsec-instance-ubuntu) image.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, select the `subnet-a` subnet. In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select **{{ ui-key.yacloud.component.compute.network-select.switch_list }}**. In the list that opens, select the IP address that you reserved.
   1. In the **{{ ui-key.yacloud.compute.instances.create.section_access }}** field, enter the login and SSH key to access the VM.
   1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

{% endlist %}

## Configure VPN routing {#vpn-routing}

Configure routing between the remote network and your IPSec instance. In the example, we will use the `192.168.0.0/24` subnet.

### Create a route table {#create-route-table}

Create a route table and add [static routes](../../vpc/concepts/static-routes.md):

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}** in the folder where you want to configure routing.
   1. Select the network to create the route table in.
   1. Open the **{{ ui-key.yacloud.vpc.network.switch_route-table }}** tab.
   1. In the top-right corner, click **{{ ui-key.yacloud.common.create }}**.
   1. Enter the route table name: `vpn-route`.
   1. Under **{{ ui-key.yacloud.vpc.route-table-form.section_static-routes }}**, click **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.
   1. In the window that opens, enter the remote site's destination subnet prefix. In this example, it is `192.168.0.0/24`.
   1. In the **{{ ui-key.yacloud.vpc.add-static-route.field_next-hop-address }}** field, enter the internal IP address of the IPSec gateway. Click **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.
   1. Click **{{ ui-key.yacloud.vpc.route-table.create.button_create }}**.

{% endlist %}

### Link the route table to all subnets {#associate-route-table}

To use static routes, link the route table to a subnet. To do this:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}** in the folder where you want to configure routing.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
   1. In the line of the subnet you need, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
   1. In the window that opens, select the created table in the **Route table** field.
   1. Click **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.
   1. Link the `vpn-route` route table to all three subnets.

{% endlist %}

## Create and configure security groups {#create-security-group}

To distribute traffic between network segments, create security groups and set up rules for receiving and sending traffic.

### Create a security group for a VPN {#create-vpn-sg}

For a VPN to work properly, allow traffic to be received and transmitted to UDP ports `500` and `4500` from an external network. This is required for using the IPSec tunnel. You also need to allow traffic between the subnets of your virtual network and the network on the remote site.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}** in the folder where you want to create a security group.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.switch_security-groups }}**.
   1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
   1. Enter the security group name: `vpn-sg`.
   1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** field, select the network that the security group will refer to.
   1. Under **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}**, create rules for outgoing traffic management: To do this, select the **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** tab.
   1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**. In the window that opens:
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** field, specify port `500`.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** field, select `UDP`.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** field, select **{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}**.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** field, specify the public address of a remote VPN hub with mask `32`.
      1. Click **{{ ui-key.yacloud.common.save }}**.
   1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**. In the window that opens:
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** field, specify port `4500`.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** field, select `UDP`.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** field, select **{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}**.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** field, specify the public address of a remote VPN hub with mask `32`.
      1. Click **{{ ui-key.yacloud.common.save }}**.
   1. Set up rules that allow traffic between the web servers and VMs on the remote site. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**. In the window that opens:
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** field, click **{{ ui-key.yacloud.vpc.network.security-groups.forms.button_select-all-port-range }}**.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** field, select **{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}**.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** field, select **{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}**.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** field, specify the internal network CIDR: `10.0.0.0/8`.
      1. Click **{{ ui-key.yacloud.vpc.network.security-groups.forms.button_add-cidr }}** and specify the remote site CIDR: `192.168.0.0/24`.
      1. Click **{{ ui-key.yacloud.common.save }}**.
   1. Select the **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}** tab and create similar rules for incoming traffic.

{% endlist %}

### Create a security group for the internet service VMs {#create-service-sg}

Create a security group named `web-service-sg` and set up traffic rules.

#### Rules for outgoing traffic {#web-service-egress}

Allow outgoing connections to other VM instances in the security group:

* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}`

#### Rules for incoming traffic {#web-service-ingress}

Allow the following incoming connections:

1. HTTP connections from multiple test dummy IP addresses:
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `80`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `TCP`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `1.1.1.1/32`, `85.32.45.45/32`
1. HTTPS connections from multiple test dummy IP addresses:
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `443`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `TCP`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `1.1.1.1/32`, `85.32.45.45/32`
1. TCP connections for SSH access:
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `22`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `TCP`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`
1. Connections from other VM instances in the security group:
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}`
1. Health checks from the network load balancer:
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `80`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `TCP`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source}}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}`.

### Assign the security groups to the VMs {#assign-security-groups-vm}

For the security group rules to take effect, assign the groups to the VM network interfaces.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. Select the `vpn` VM.
   1. Under **{{ ui-key.yacloud.compute.instance.overview.section_network }}**, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.compute.instance.overview.button_edit-network-interface }}**.
   1. In the window that opens, select the `vpn-sg` security group.
   1. Click **{{ ui-key.yacloud.common.save }}**.
   1. Repeat the steps and assign the `web-service-sg` security group to the `web-node-a`, `web-node-b`, and `web-node-d` VMs.

{% endlist %}

## Create a network load balancer {#create-load-balancer}

The network load balancer will distribute the internet service's incoming traffic across the VMs in the target group.

{% list tabs group=instructions %}

- Management console {#console}

   To create a network load balancer:
   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}** in the folder to create the load balancer in.
   1. Click **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_create }}**.
   1. Enter the load balancer name: `web-service-lb`.
   1. In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_address-type }}** field, select **{{ ui-key.yacloud.common.label_list }}** and specify a static public address.
   1. Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_listeners }}**, click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-listener }}**.
   1. In the window that opens, enter a name for the listener and specify port `80` in the **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-port }}** and **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-target-port }}** fields. Click **{{ ui-key.yacloud.common.add }}**.
   1. Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_target-groups }}**, click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-target-group }}**.
   1. In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_target-group-id }}** field, click ![icon-users](../../_assets/console-icons/chevron-down.svg) → **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.button_create-target-group }}**. In the window that opens:
      1. Enter the target group name: `web-tg`.
      1. Select the `web-node-a`, `web-node-b`, and `web-node-d` VMs.
      1. Click **{{ ui-key.yacloud.common.create }}**.
   1. Select the created target group from the list and change the protocol for the load balancer's health checks to `TCP` in the settings:
      1. Click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_edit-health-check }}**.
      1. In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}** field of the window that opens, select **{{ ui-key.yacloud.common.label_tcp }}** and click **{{ ui-key.yacloud.common.apply }}**.
   1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Test the infrastructure {#test}

Test the infrastructure and make sure that traffic to the internet service VMs only comes from the addresses allowed by the rules:

1. On your computer, run the command: `curl <network_load_balancer_public_IP_address>`. Make sure no response is received.
1. Create a security group named `web-service-test-sg` with no rules and assign it to the `web-node-a`, `web-node-b`, and `web-node-d` VMs.
1. In the `web-service-test-sg` security group, create the following rule for incoming traffic:
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `80`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `TCP`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source}}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `<Your_PC_IP_address>/32`
1. Run the `curl <network_load_balancer_public_IP_address>` command again on your PC. Make sure the Drupal homepage HTML code is returned in response.
1. Delete the test security group.

## How to delete the resources you created {#clear-out}

To shut down the infrastructure and stop paying for the deployed resources, delete the [VMs](../../compute/operations/vm-control/vm-delete.md) and the [load balancer](../../network-load-balancer/operations/load-balancer-delete.md) you created:

* `vpn`
* `web-node-a`
* `web-node-b`
* `web-node-d`
* `web-service-lb`

Release and [delete](../../vpc/operations/address-delete.md) the static public IP addresses you reserved.
