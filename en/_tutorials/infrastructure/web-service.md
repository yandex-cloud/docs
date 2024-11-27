# Architecture and protection of a basic internet service


Follow this guide to deploy and configure the infrastructure of a basic internet service with multiple VMs. You will connect to the infrastructure from a remote site. To restrict access to the VMs, you will configure [security groups](../../vpc/concepts/security-groups.md). A [network load balancer](../../network-load-balancer/concepts/index.md) will distribute the load across web app servers. 

This diagram illustrates networking between the remote site and basic internet service:

![image](../../_assets/tutorials/web-service.svg)

Remote site:

* `remote-net` network with `subnet-1` (`10.129.0.0/24`).
* Test VM running Linux Ubuntu named `vm-1` residing in `subnet-1`. This VM is used to health-check the cloud site infrastructure.

{% note info %}

You can also use your PC as the remote site. To do this, you need to know the local machine's subnet CIDR and external IP address it uses to access the internet.

{% endnote %}

Cloud site:

* Network named `network` with the following subnets: `subnet-a` (`192.168.5.0/24`), `subnet-b` (`192.168.15.0/24`), and `subnet-d` (`192.168.25.0/24`).
* IPsec instance (gateway) named `vpn` residing in `subnet-a`. The IPsec gateway serves to provide an IPsec connection to the remote site and allow networking between cloud VMs.
* Route table with `vpn-route` (static route) directing traffic from the remote site `subnet-1` towards the cloud site VMs via the main IPsec gateway.
* Drupal VMs of the basic internet service: `web-node-a`, `web-node-b`, and `web-node-d` residing in `subnet-a`, `subnet-b`, and `subnet-d`, respectively.
* `vpn-sg` security group used by the `vpn` VM to manage traffic in the IPSec tunnel. The `web-service-sg` security group allows traffic between the `web-node-a`, `web-node-b`, and `web-node-d` VMs. 
* `web-service-lb` load balancer distributing incoming traffic across `web-node-a`, `web-node-b`, and `web-node-d`.

To create the infrastructure of an internet service:

1. [Prepare your cloud](#before-begin).
1. [Set up a remote site](#remote-setup).
1. [Set up a cloud site](#cloud-setup).
1. [Test the infrastructure](#test).

If you no longer need the infrastructure, [delete](#clear-out) the created resources.

## Prepare your cloud {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of support for the new infrastructure includes:

* Fee for continuously running virtual machines (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using public static IP addresses (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for using a network load balancer (see [{{ network-load-balancer-full-name }} pricing](../../network-load-balancer/pricing.md)).


## Set up a remote site {#remote-setup}

At this stage, you will create and set up an infrastructure for your remote site. This comprises a network, a subnet, and a VM to access the infrastructure of the basic internet service.

{% note info %}

You can use your PC as the remote site. To do this, find out your PC's subnet CIDR and external IP address it uses to access the internet.

If you are going to use your PC as the remote site, skip this section and go to [Set up a cloud site](#cloud-setup).

{% endnote %}

### Create a network and subnet {#remote-net}

1. [Create a network](../../vpc/operations/network-create.md) named `remote-net`. When creating your network, disable the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** option.
1. [Create a subnet](../../vpc/operations/subnet-create.md) for your remote site test VM with the following parameters:

    * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}**: `subnet-1`.
    * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}**: `{{ region-id }}-b`.
    * **{{ ui-key.yacloud.vpc.subnetworks.create.field_network }}**: `remote-net`.
    * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}**: `10.129.0.0/24`.

### Create a test VM {#remote-test-vm}

Create a VM you will use to connect to the basic internet service infrastructure from the outside.

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create your VM in.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
    1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.    
    1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select the [Ubuntu 22.04 LTS OS Login](/marketplace/products/yc/ubuntu-2204-lts-oslogin) image.
    1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the `{{ region-id }}-b` [availability zone](../../overview/concepts/geo-scope.md).
    1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

        * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select `subnet-1`. 
        * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
    1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.field_os-login-access-method }}** to [connect](../../compute/operations/vm-connect/os-login.md) and manage access to the new VM using [OS Login](../../organization/concepts/os-login.md) in {{ org-full-name }}.

        With OS Login, you can connect to VMs using SSH keys and SSH certificates via a standard SSH client or [YC CLI](../../cli/quickstart.md). OS Login allows you to rotate the SSH keys used to access the VM, providing the most [secure](../../security/domains/iaas-checklist.md#vm-security) access option.

    1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `vm-1`.
    1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
    1. Get the public IP address of the new VM:

        1. Wait until the status of `vm-1` changes to `Running` and click the row with this VM.
        1. In the VM overview page that opens, copy the value in the **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}** field under **{{ ui-key.yacloud.compute.instance.overview.label_network-interface }}**.

            You will need the remote VM's public IP address later when [creating a security group](#create-vpn-sg).

{% endlist %}

## Set up a cloud site {#cloud-setup}

### Create and set up a cloud network {#setup-cloud-net}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder where you want to deploy the infrastructure.
  1. In the list of services, select **{{ vpc-name }}**.
  1. [Create a cloud network](../../vpc/operations/network-create.md) named `network`. When creating your network, disable the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** option.
  1. In `network`, [create subnets](../../vpc/operations/subnet-create.md) with the following parameters:
  
      1. To connect the `web-node-a` VM and the `vpn` IPSec instance:
          * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}**: `subnet-a`.
          * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}**: `{{ region-id }}-a`.
          * **{{ ui-key.yacloud.vpc.subnetworks.create.field_network }}**: `network`.
          * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}**: `192.168.5.0/24`.
  
      1. To connect the `web-node-b` VM:
          * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}**: `subnet-b`.
          * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}**: `{{ region-id }}-b`.
          * **{{ ui-key.yacloud.vpc.subnetworks.create.field_network }}**: `network`.
          * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}**: `192.168.15.0/24`.
  
      1. To connect the `web-node-d` VM:
          * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}**: `subnet-d`.
          * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}**: `{{ region-id }}-d`.
          * **{{ ui-key.yacloud.vpc.subnetworks.create.field_network }}**: `network`.
          * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}**: `192.168.25.0/24`.

{% endlist %}

### Reserve two static public IP addresses {#reserve-ips}

For your internet service to run, you need two static public IP addresses: one to be assigned to the VPN gateway and the other to the network load balancer.

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the folder with the IP addresses to reserve.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}**.
    1. Click **{{ ui-key.yacloud.vpc.addresses.button_create }}**.
    1. In the window that opens, select the `{{ region-id }}-a` availability zone and click **{{ ui-key.yacloud.vpc.addresses.popup-create_button_create }}**.
    1. Repeat steps 4 to 5 and reserve a static public IP address in the `{{ region-id }}-b` availability zone.

{% endlist %}

### Create and configure security groups {#create-security-group}

To distribute traffic between network segments, create security groups and set up rules for receiving and sending traffic.

#### Create a security group for the VPN gateway {#create-vpn-sg}

For your VPN to work properly, allow inbound and outbound traffic to UDP ports `500` and `4500` from an external network. This is required for using the IPsec tunnel. You also need to allow traffic between the subnets of your virtual network and the network at the remote site.

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the folder where you want to create the security group. 
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.switch_security-groups }}**.
    1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
    1. Enter a name for the security group: `vpn-sg`.
    1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** field, select `network`, which you created earlier.
    1. Under **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}**, [create](../../vpc/operations/security-group-add-rule.md) rules based on the table below:

       #|
       || **Traffic<br/>direction** | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}** | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** ||
       || Incoming | `udp500` | `500` | `{{ ui-key.yacloud.common.label_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<remote_VM_public_IP_address>/32` ||
       || Incoming | `udp4500` | `4500` | `{{ ui-key.yacloud.common.label_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<remote_VM_public_IP_address>/32` ||
       || Incoming | `internal` | `0-65535` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | 
         * `192.168.5.0/24`
         * `192.168.15.0/24`
         * `192.168.25.0/24`
         * `10.129.0.0/24` ^1^ ||
       || Outgoing | `udp500` | `500` | `{{ ui-key.yacloud.common.label_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<remote_VM_public_IP_address>/32` ||
       || Outgoing | `udp4500` | `4500` | `{{ ui-key.yacloud.common.label_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<remote_VM_public_IP_address>/32` ||
       || Outgoing | `intersubnet` | `0-65535` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | 
         * `192.168.5.0/24`
         * `192.168.15.0/24`
         * `192.168.25.0/24`
         * `10.129.0.0/24` ^1^ ||
       |#

       ^1^ To use a local PC as your test VM, specify here the CIDR for the subnet this PC resides in.

    1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

#### Create a security group for the internet service's VMs {#create-service-sg}

{% list tabs group=instructions %}

- Management console {#console}
  
    1. In the [management console]({{ link-console-main }}), go to the folder where you want to create the security group. 
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.switch_security-groups }}**.
    1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
    1. Enter a name for the security group: `web-service-sg`.
    1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** field, select `network`, which you created earlier.
    1. Under **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}**, [create](../../vpc/operations/security-group-add-rule.md) rules based on the table below:
   
       #|
       || **Traffic<br/>direction** | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}** | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** /<br/>**{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** ||
       || Incoming | `ssh` | `22` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` ||
       || Incoming | `anyself` | `0-65535` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` ||
       || Incoming | `healthchecks` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}` | — ||
       || Outgoing | `self` | `0-65535` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` ||
       |#

    1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Create and configure VMs on the cloud site {#setup-cloud-vms}

#### Create VMs for the service in all availability zones {#create-vms}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create your VMs.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
    1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.    
    1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab and select the [Drupal 10](/marketplace/products/yc/drupal-8) image.
    1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the `{{ region-id }}-a` availability zone.
    1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

       * Select the `subnet-a` subnet. 
       * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`.
       * Select the `web-service-sg` security group.
    1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**:

        * Select the **SSH key** connection option.
        * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter a name for the user.

            {% note alert %}

            Do not use `root` or other usernames reserved by the OS. To perform operations requiring superuser permissions, use the `sudo` command.

            {% endnote %}

        * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, select the SSH key saved in your [organization user](../../organization/concepts/membership.md) profile.

            If there are no saved SSH keys in your profile, or you want to add a new key:
            * Click **Add key**.
            * Enter a name for the SSH key.
            * Upload or paste the contents of the public key file. You need to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair for the SSH connection to a VM yourself.
            * Select an expiration date for the key.
            * Click **{{ ui-key.yacloud.common.add }}**.

            The SSH key will be added to your organization user profile.

            If users cannot add SSH keys to their profiles in the organization, the added public SSH key will only be saved to the user profile of the VM being created.
       
    1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `web-node-a`.
    1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
    1. Repeat steps 4 to 10 to create the `web-node-b` and `web-node-d` VMs. Create the VMs in the `{{ region-id }}-b` and `{{ region-id }}-d` availability zones and connect them to `subnet-b` and `subnet-d`, respectively.

{% endlist %}

#### Create an IPSec instance for remote access {#create-ipsec-instance}

To provide secure access to your resources, create an IPSec instance.

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the folder where you want to create your VM.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
    1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.    
    1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab and select the [IPSec instance](/marketplace/products/yc/ipsec-instance-ubuntu) image.
    1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the `{{ region-id }}-a` availability zone.
    1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

        * Select the`subnet-a` subnet.
        * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_list }}`. In the list that opens, select the IP address that you reserved.
        * Select the `vpn-sg` security group.

    1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access data:

        * Under **{{ ui-key.yacloud.compute.instances.create.field_user }}**, enter the username. Do not use `root` or other names reserved by the OS. To perform operations requiring superuser permissions, use the `sudo` command.
        * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

    1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `vpn`.
    1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
    1. Wait until the status of the new `vpn` VM changes to `Running` and copy the value from the **{{ ui-key.yacloud.compute.instances.column_internal-ip }}** field in the row with this VM.
    
        You will need the gateway's internal address when configuring the static route.

{% endlist %}

### Configure VPN routing {#vpn-routing}

Configure routing between the remote site's subnet and IPSec instance.

#### Create a route table {#create-route-table}

Create a [route table](../../vpc/concepts/routing.md#rt-vpc) and add [static routes](../../vpc/concepts/routing.md#static):

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the folder where you want to configure routing.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
    1. Select the `network` you created earlier.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.vpc.network.switch_route-table }}**.
    1. Click **{{ ui-key.yacloud.vpc.network.overview.button_create_route-table }}**.
    1. Specify the route table name: `vpn-route`.
    1. Under **{{ ui-key.yacloud.vpc.route-table-form.section_static-routes }}**, click **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.
    1. In the window that opens:
       * In the **{{ ui-key.yacloud.vpc.add-static-route.field_destination-prefix }}** field, enter `10.129.0.0/24`.

           If you want to use a local PC as your test VM, specify its subnet CIDR.
       * In the **{{ ui-key.yacloud.vpc.add-static-route.field_next-hop-address }}** field, enter the internal IP address of the IPSec gateway.
       * Click **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.
    1. Click **{{ ui-key.yacloud.vpc.route-table.create.button_create }}**.

{% endlist %}

#### Link the route table to all subnets {#associate-route-table}

To use static routes, link the route table to all the subnets in the cloud site’s `network`.

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the folder where you need to configure routing.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
    1. In the `subnet-a` row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
    1. In the window that opens, select the created `vpn-route` table in the **{{ ui-key.yacloud.vpc.subnet.add-route-table.field_route-table-id }}** field.
    1. Click **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.
    1. Repeat steps 4 to 6 to link the `vpn-route` route table to `subnet-b` and `subnet-d`.

{% endlist %}

### Create a network load balancer {#create-load-balancer}

The network load balancer will distribute the internet service's incoming traffic across the VMs in the target group.

To create a network load balancer:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder where you need to create the load balancer.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
  1. Click **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_create }}**.
  1. Enter the load balancer name: `web-service-lb`.
  1. In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_address-type }}** field, select `{{ ui-key.yacloud.common.label_list }}` and specify a static public address.
  1. Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_listeners }}**, click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-listener }}**. In the window that opens:

      1. Enter the listener name: `web-service-lb-listener`.
      1. In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-port }}** field, specify `80`.
      1. In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-target-port }}** field, specify `80`.
      1. Click **{{ ui-key.yacloud.common.add }}**.
  1. Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_target-groups }}**, click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-target-group }}**.

      1. In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_target-group-id }}** field, select ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.button_create-target-group }}**. In the window that opens:

          1. Enter the target group name: `web-tg`.
          1. Select the `web-node-a`, `web-node-b`, and `web-node-d` VMs.
          1. Click **{{ ui-key.yacloud.common.create }}**.
      1. Select the new `web-tg` target group.
  1. In this target group section:

      1. Click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_edit-health-check }}**.
      1. In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}** field of the window that opens, select `{{ ui-key.yacloud.common.label_tcp }}` and click **{{ ui-key.yacloud.common.apply }}**.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Test the infrastructure {#test}

Test the infrastructure and make sure that the internet service VMs do not receive any external traffic:

1. Run the following command on the remote computer:

    ```bash
    curl <public_IP_address_of_network_load_balancer>
    ```
    
    Make sure you get no response from the server. This means network traffic to your Drupal servers is denied.
1. [Add](../../vpc/operations/security-group-add-rule.md) two new incoming traffic rules to the `web-service-sg` security group:

   #|
   || **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}** | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** ||
   || http-external-vm | 80 | TCP | CIDR | `<remote_VM_public_IP_address>/32` ||
   || https-external-vm | 443 | TCP | CIDR | `<remote_VM_public_IP_address>/32` ||
   |#

   These rules allow access to the VMs in the network load balancer’s target group from the remote site's VM public address.

1. Once again, run this command on the remote computer:

    ```bash
    curl <public_IP_address_of_network_load_balancer>
    ```

    Make sure the Drupal homepage HTML code is returned in response. This means the rules you added to the security group allowed network access to the Drupal VMs from the remote computer's IP address.

## How to delete the resources you created {#clear-out}

To stop paying for the deployed resources:
1. [Delete](../../compute/operations/vm-control/vm-delete.md) the VM instances.
1. [Delete](../../network-load-balancer/operations/load-balancer-delete.md) the network load balancer.
1. [Delete](../../vpc/operations/address-delete.md) the static public IP addresses you reserved.
1. If required, delete the [route table](../../vpc/operations/delete-route-table.md), [security groups](../../vpc/operations/security-group-delete.md), [subnets](../../vpc/operations/subnet-delete.md), and [networks](../../vpc/operations/network-delete.md).