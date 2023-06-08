# Set up a secure network configuration

## Reserve two static public IP addresses {#reserve-ips}

For your internet service to run, you need two static public IP addresses: one to be assigned to the VPN gateway and the other to the network load balancer.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), open **{{ vpc-name }}** in the folder where you want to reserve the IP addresses.
   1. Go to the **IP addresses** tab. Click **Reserve address**.
   1. In the window that opens, select the `ru-central1-b` availability zone. Click **Reserve address**.
   1. Click **Reserve address** once again.
   1. In the window that opens, select the `ru-central1-a` availability zone. Click **Reserve address**.

{% endlist %}

## Create VMs for the service in all availability zones {#create-vms}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), open your folder and click **Create resource**. Select **Virtual machine**.
   1. Enter the VM name: `web-node-a`.
   1. Select the `ru-central1-a` availability zone.
   1. Under **Images from {{ marketplace-name }}**, click **Select** and select the [Drupal](https://cloud.yandex.com/en-ru/marketplace/products/f2e90bncf96u25a9cirp) image.
   1. Under **Network settings**, select the `subnet-a subnet`. Under **Public address**, select **No address**.
   1. In the **Access** field, enter the login and SSH key to access the VM.
   1. Click **Create VM**.
   1. Repeat the steps for VMs named `web-node-b` and `web-node-c`. Create them in the `ru-central1-b` and `ru-central1-c` availability zones and connect them to `subnet-b` and `subnet-c`, respectively.

{% endlist %}

## Create an IPSec instance for remote access {#create-ipsec-instance}

To provide secure access to your resources, create an IPSec instance.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), open your folder and click **Create resource**. Select **Virtual machine**.
   1. Enter the VM name: `vpc`.
   1. Select the `ru-central1-a` availability zone.
   1. Under **Images from {{ marketplace-name }}**, click **Select** and select the [IPSec instance](https://cloud.yandex.com/marketplace/products/f2e70ohdvsd0jgp2302j) image.
   1. Under **Network settings**, select the `subnet-a subnet`. Under **Public address**, select from a list of reserved IPs.
   1. In the **Access** field, enter the login and SSH key to access the VM.
   1. Click **Create VM**.

{% endlist %}

## Configure VPN routing {#vpn-routing}

Configure routing between the remote network and your IPSec instance.  In the example, we'll use the subnet `192.168.0.0/24`.

### Create a route table {#create-route-table}

Create a route table and add [static routes](../../vpc/concepts/static-routes.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), open the **{{ vpc-name }}** section in the folder where you want to configure routing.
   1. Select the network to create the route table in.
   1. Open the **Route tables** tab.
   1. Click ![image](../../_assets/plus.svg)**Create a routing table**.
   1. Enter the route table name: `vpn-route`.
   1. Click **Add route**.
   1. In the window that opens, enter the remote site's destination subnet prefix. In this example, this is `192.168.0.0/24`.
   1. In the **Next hop** field, enter the internal IP address of the IPSec gateway. Click **Add**.
   1. Click **Create route table**.

{% endlist %}

### Link the route table to all subnets {#associate-route-table}

To use static routes, link the route table to a subnet. To do this:

{% list tabs %}

- Management console

   1. In [the management console]({{ link-console-main }}), open the **{{ vpc-name }}** in the folder where you want to configure routing.
   1. Select the network with the subnets to assign the route table to.
   1. In the line with the desired subnet, click ![image](../../_assets/options.svg).
   1. In the menu that opens, select **Link route table**.
   1. In the window that opens, select the created table from the list.
   1. Click **Link**.
   1. Link the `vpn-route` route table to all three subnets.

{% endlist %}

## Create and configure security groups {#create-security-group}

To distribute traffic between network segments, create security groups and set up rules for receiving and sending traffic.

### Create a security group for a VPN {#create-vpn-sg}

For a VPN to work properly, allow receiving and transmitting traffic to UDP ports `500` and `4500` from an external network. This is required for using the IPSec tunnel. You also need to allow traffic between the subnets of your virtual network and the network on the remote site.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), open **{{ vpc-name }}** in the folder where you want to create a security group.
   1. Open the **Security groups** tab.
   1. Click **Create group**.
   1. Enter the security group name: `vpn-sg`.
   1. In the **Network** field, select the network that the security group will refer to.
   1. Under **Rules**, create traffic management rules:
      1. Open the **Outgoing traffic** tab.
      1. Click **Add rule**.
      1. In the window that opens, set **Port** to `500`.
      1. In the **Protocol** field, select `UDP`.
      1. In the **Destination** field, specify the public address of a remote VPN hub with mask `32`.
   1. Click **Save**.
   1. Click **Add rule**.
      1. In the window that opens, set **Port** to `4500`.
      1. In the **Protocol** field, select `UDP`.
      1. In the **Destination** field, specify the public address of a remote VPN hub with mask `32`.
   1. Click **Save**.
   1. Set up rules that allow traffic between the web servers and VMs on the remote site. Click **Add rule**.
      1. In the **Port** field of the window that opens, click **Select the full range**.
      1. In the **Protocol** field, select `Any`.
      1. In the **Destination** field, specify the internal network CIDR: `10.0.0.0/8`.
      1. Click **Add CIDR** and specify the remote site CIDR: `192.168.0.0/24`.
   1. Create the same rules for incoming traffic.

{% endlist %}

### Create a security group for the internet service VMs {#create-service-sg}

Create a security group named `web-service-sg` and set up traffic rules.

#### Rules for outgoing traffic {#web-service-egress}

Allow outgoing connections to other VM instances in the security group:

* Protocol: `Any`.
* Type of destination: **Security group**.
* Destination: `Current`.

#### Rules for incoming traffic {#web-service-ingress}

Allow the following incoming connections:

1. HTTP connections from multiple test dummy IP addresses:
   * **Protocol**: `TCP`.
   * **Port**: `80`.
   * **CIDR**: `1.1.1.1/32`, `85.32.45.45/32`.
1. HTTPS connections from multiple test dummy IP addresses:
   * **Protocol**: `TCP`.
   * **Port**: `443`.
   * **CIDR**: `1.1.1.1/32`, `85.32.45.45/32`.
1. TCP connections for SSH access:
   * **Protocol**: `TCP`.
   * **Port**: `22`.
   * **CIDR**: `0.0.0.0/0`.
1. Connections from other VM instances in the security group:
   * **Protocol**: `Any`.
   * Type of destination: **Security group**.
   * Destination: `Current`.
1. Health checks from the network load balancer:
   * **Protocol**: `Any`.
   * **Port**: `80`.
   * **CIDR**: `198.18.235.0/24` and `198.18.248.0/24`.

## Assign the security groups to the VMs {#assign-security-groups-vm}

For the security group rules to take effect, assign the groups to the VM network interfaces.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), open **{{ compute-name }}**.
   1. Select the `vpn` VM.
   1. Under **Network**, click ![options](../../_assets/options.svg) and select **Edit security groups**.
   1. In the window that opens, select the `vpn-sg` security group.
   1. Click **Save**.
   1. Repeat the steps and assign the `web-service-sg` security group to the `web-node-a`, `web-node-b`, and `web-node-c` VMs.

{% endlist %}

## Create a network load balancer {#create-load-balancer}

The network load balancer will distribute the internet service's incoming traffic across the VMs in the target group.

{% list tabs %}

- Management console

   To create a network load balancer:
   1. In the [management console]({{ link-console-main }}), open **{{ network-load-balancer-name }}** in the folder to create the load balancer in.
   1. Click **Create load balancer**.
   1. Enter the load balancer name: `web-service-lb`.
   1. In the **Public address** field, select **List** and specify a static public address.
   1. Click **Add listener** under **Listeners**.
   1. In the window that opens, enter a name for the listener and specify port `80` in the **Port** and **Target port** fields.  Click **Add**.
   1. Under **Target groups,** click **Add target group**.
   1. In the **Target group** field, click on the list and then click **Create target group**.
   1. In the window that opens, enter the target group name: `web-tg`.
   1. Select the `web-node-a`, `web-node-b`, and `web-node-c` VMs.
   1. Click **Create**.
   1. Select the created target group from the list.
   1. Click **Create**.

{% endlist %}

## Test the infrastructure {#test}

Test the infrastructure and make sure that traffic to the internet service VMs only comes from the addresses allowed by the rules:

1. On your computer, run the command: `curl <Network load balancer public IP address>`.  Make sure no response is received.
1. Create a security group named `web-service-test-sg` with no rules and assign it to the  `web-node-a`, `web-node-b` and `web-node-c`. VMs.
1. In the `web-service-test-sg` security group, create the following rule for incoming traffic:
   * Protocol: `TCP`.
   * Port `80`.
   * CIDR: `<IP address of your computer>/32`.
1. Run the command `curl <Network load balancer public IP address>` on your computer once again.  Make sure the Drupal homepage HTML code is returned in response.
1. Delete the test security group.

## Delete the resources you created {#clear-out}

To stop paying for the deployed resources, delete the created [VMs](../../compute/operations/vm-control/vm-delete.md) and the [load balancer](../../network-load-balancer/operations/load-balancer-delete.md):
* `vpn`.
* `web-node-a`.
* `web-node-b`.
* `web-node-c`.
* `web-service-lb`.

Release and [delete](../../vpc/operations/address-delete.md) the static public IP addresses you reserved.
