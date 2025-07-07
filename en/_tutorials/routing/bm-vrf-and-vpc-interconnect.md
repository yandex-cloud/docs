# Setting up network connectivity between {{ baremetal-full-name }} and {{ vpc-full-name }} subnets using {{ interconnect-full-name }}

[{{ interconnect-full-name }}](../../interconnect/index.yaml)-based network connectivity in {{ baremetal-full-name }} enables access to [CIDRs](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) of {{ vpc-name }} private subnets in a cloud infrastructure and/or CIDRs of private subnets in an on-prem infrastructure.

In this tutorial, you will set up network connectivity between a {{ baremetal-name }} [server](../../baremetal/concepts/servers.md) located in a private {{ baremetal-full-name }} [subnet](../../baremetal/concepts/network.md#private-network) and a {{ compute-full-name }} [VM](../../compute/concepts/vm.md) located in a subnet of a {{ vpc-full-name }} [cloud network](../../vpc/concepts/network.md#network).

Similarly, you can set up network connectivity with your on-prem resources located in private subnets within your own network infrastructure.

You can use {{ interconnect-full-name }} free of charge as part of integration with {{ baremetal-full-name }}.

You can see the solution architecture in the diagram below:

![bm-vrf-and-vpc-interconnect](../../_assets/tutorials/bm-vrf-and-vpc-interconnect.svg)

To set up network connectivity between {{ baremetal-name }} and {{ vpc-name }} subnets using {{ interconnect-name }}:

1. [Get your cloud ready](#before-you-begin).
1. [Create a cloud infrastructure](#setup-infrastructure).
1. [Request a routing instance](#request-routing-instance).
1. [Create a private connection](#create-private-connection).
1. [Check network connectivity](#check-connectivity).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of supporting an infrastructure for network connectivity between {{ baremetal-name }} and {{ vpc-short-name }} subnets includes:

* Fee for using the VM [public IP address](../../vpc/concepts/address.md#public-addresses) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for [VM](../../compute/concepts/vm.md) computing resources and disks (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* {{ baremetal-name }} server lease fee (see [{{ baremetal-full-name }} pricing](../../baremetal/pricing.md)).

{% include [bms-vpc-private-over-cic-free-traffic](../../_includes/baremetal/bms-vpc-private-over-cic-free-traffic.md) %}


## Create a cloud infrastructure {#setup-infrastructure}

Create the {{ yandex-cloud }} infrastructure you will use to set up network connectivity.

To configure {{ interconnect-name }} in {{ baremetal-name }}, you will need a private routable [subnet](../../baremetal/concepts/network.md#private-subnet) and a [VRF segment](../../baremetal/concepts/network.md#vrf-segment) in {{ baremetal-name }}, a [cloud network](../../vpc/concepts/network.md#network) with one or more {{ vpc-name }} [subnets](../../vpc/concepts/network.md#subnet), as well as a routing instance with one or more [announced](../../interconnect/concepts/priv-con.md#prc-announce) prefixes of {{ vpc-short-name }} private subnets.

To check network connectivity, you will need a {{ baremetal-name }} server and a {{ compute-name }} VM.

### Create a VRF segment and a {{ baremetal-name }} private subnet {#setup-vrf}

Create a virtual network segment (VRF) and a private subnet in the `{{ region-id }}-m3` [server pool](../../baremetal/concepts/servers.md#server-pools):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are going to create your infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Create a virtual routing and forwarding segment:
        1. In the left-hand panel, select ![icon](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud.baremetal.label_networks }}** and click **{{ ui-key.yacloud.baremetal.label_create-network }}**.
        1. In the **{{ ui-key.yacloud.baremetal.field_name }}** field, name your VRF segment: `my-vrf`.
        1. Click **{{ ui-key.yacloud.baremetal.label_create-network }}**.
  1. Create a private subnet:
        1. In the left-hand panel, select ![icon](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.baremetal.label_subnetworks }}** and click **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.
        1. In the **{{ ui-key.yacloud.baremetal.field_server-pool }}** field, select the `{{ region-id }}-m3` server pool.
        1. In the **{{ ui-key.yacloud.baremetal.field_name }}** field, enter the subnet name: `subnet-m3`.
        1. Enable **{{ ui-key.yacloud.baremetal.title_routing-settings }}**.
        1. In the **{{ ui-key.yacloud.baremetal.field_network-id }}** field, select the previously created segment, `my-vrf`.
        1. In the **{{ ui-key.yacloud.baremetal.field_CIDR }}** field, specify `192.168.1.0/24`.
        1. In the **{{ ui-key.yacloud.baremetal.field_gateway }}** field, keep the default value, `192.168.1.1`.
        1. Enable the **{{ ui-key.yacloud.baremetal.field_dhcp-settings }}** option and in the **{{ ui-key.yacloud.baremetal.field_dhcp-ip-range }}** field that appears, leave the default values, `192.168.1.1`—`192.168.1.254`.
        1. Click **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.

{% endlist %}


### Lease a {{ baremetal-name }} server {#rent-bms}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. {% include [server-lease-step2](../../_includes/baremetal/instruction-steps/server-lease-step2.md) %}
  1. In the **{{ ui-key.yacloud.baremetal.field_server-pool }}** field, select the `{{ region-id }}-m3` server pool.
  1. {% include [server-lease-step5](../../_includes/baremetal/instruction-steps/server-lease-step5.md) %}
  1. {% include [server-lease-step6](../../_includes/baremetal/instruction-steps/server-lease-step6.md) %}
  1. Under **{{ ui-key.yacloud.baremetal.title_section-server-product }}**, select an image, e.g., `Ubuntu 24.04`.
  1. {% include [server-lease-step6-substep](../../_includes/baremetal/instruction-steps/server-lease-step6-substep.md) %}
  1. Under **{{ ui-key.yacloud.baremetal.title_section-server-network-settings }}**:

     1. In the **{{ ui-key.yacloud.baremetal.field_subnet-id }}** field, select `subnet-m3` you created earlier.
     1. In the **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** field, select `{{ ui-key.yacloud.baremetal.label_public-ip-no }}`.

  1. Under **{{ ui-key.yacloud.baremetal.title_server-access }}**:

      {% include [server-lease-access](../../_includes/baremetal/server-lease-access.md) %}

  1. Under **{{ ui-key.yacloud.baremetal.title_section-server-info }}**, in the **{{ ui-key.yacloud.baremetal.field_name }}** field, enter the server name: `server-m3`.
  1. {% include [server-lease-step12](../../_includes/baremetal/instruction-steps/server-lease-step12.md) %}

{% endlist %}

{% note info %}

Server setup and OS installation may take up to 45 minutes. The server will have the `Provisioning` status during this time. After OS installation is complete, the server status will change to `Ready`.

{% endnote %}


### Create a cloud network and subnet {#setup-vpc}

Create a cloud network and subnet to connect the {{ compute-name }} VM to.

{% list tabs group=instructions %}

- Management console {#console} 

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Create a cloud network:

      1. At the top right, click **{{ ui-key.yacloud.vpc.networks.button_create }}**.

      1. In the **{{ ui-key.yacloud.vpc.networks.create.field_name }}** field, specify `sample-network`.

      1. In the **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** field, disable **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.

      1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. Create a subnet:

      1. In the left-hand panel, select ![subnets](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
      1. At the top right, click **{{ ui-key.yacloud.vpc.subnetworks.button_action-create }}**.
      1. In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** field, specify `subnet-{{ region-id }}-b`.
      1. In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** field, select `{{ region-id }}-b`.
      1. In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_network }}** field, select `sample-network`.
      1. In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** field, specify `192.168.11.0/24`.
      
          {% include [no-subnet-overlapping-warn](../_tutorials_includes/bm-vrf-and-vpc-interconnect/no-subnet-overlapping-warn.md) %}

      1. Click **{{ ui-key.yacloud.vpc.subnetworks.create.button_create }}**.

{% endlist %}


### Create a VM {#create-vm}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}** and click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select an appropriate VM image, e.g., [Ubuntu 24.04](/marketplace/products/yc/ubuntu-2404-lts-oslogin).
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the `{{ region-id }}-b` [availability zone](../../overview/concepts/geo-scope.md).
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select `subnet-{{ region-id }}-b`.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

      * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter the username: `yc-user`.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `sample-vm`.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

{% endlist %}


## Request a routing instance {#request-routing-instance}

To set up network connectivity between {{ baremetal-name }} subnets, {{ vpc-name }} subnets, and/or on-prem subnets, you will need a routing instance. To create a routing instance, [contact]({{ link-console-support }}/tickets/create) support.

If [{{ interconnect-name }}](../../interconnect/index.yaml) (VPC-to-On-Prem) network connectivity is already set up in your folder, you can either use the existing routing instance or request an additional routing instance for dedicated network connectivity.

### Make sure you have a routing instance in your folder {#check-for-ri}

1. {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. Make sure you have a routing instance in your default folder:

    {% list tabs group=instructions %}

    - CLI {#cli}

        Run this command:

        ```bash
        yc cloudrouter routing-instance list
        ```

        If your folder already includes a routing instance, the command will output the following:

        ```text
        +----------------------+------------------+--------+-----------------------+
        |          ID          |       NAME       | STATUS | PRIVATE CONNECTION ID |
        +----------------------+------------------+--------+-----------------------+
        | cf35oot8f0eu******** | routing-instance | ACTIVE | cf395uf8dg7h********  |
        +----------------------+------------------+--------+-----------------------+
        ```

    {% endlist %}

1. If you already have a routing instance, you may skip the next step and [proceed](#create-private-connection) to creating a private connection.

    If you do not have a routing instance or you want to build additional dedicated network connectivity, request a new routing instance.

### Request a new routing instance {#request-ri}

[Contact]({{ link-console-support }}/tickets/create) support to create a routing instance in your folder.

Fill out your request as follows:

```text
Subject: [CIC for BareMetal] Creating a routing instance.

Request text:
Please create a routing instance in the specified cloud folder with the following parameters:

folder_id: <folder_ID>

vpc:
  vpc_net_id: <network_ID>
    vpc_subnets: 
      {{ region-id }}-a: [CIDR_a1, CIDR_a2, ..., CIDR_an]
      {{ region-id }}-b: [CIDR_b1, CIDR_b2, ..., CIDR_bn]
      {{ region-id }}-d: [CIDR_d1, CIDR_d2, ..., CIDR_dn]
```

Where:
* `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
* `vpc_net_id`: Cloud network [ID](../../vpc/operations/network-get-info.md).
* `vpc_subnets`: List of [announced](../../interconnect/concepts/priv-con.md#prc-announce) address prefixes for each [availability zone](../../overview/concepts/geo-scope.md). For example, for the {{ vpc-short-name }} subnet you created earlier, you will specify `{{ region-id }}-b: [192.168.11.0/24]`.

    You may announce [aggregated](../../interconnect/concepts/priv-con.md#agg-subnets) address prefixes.

{% note info %}

It may take up to 24 hours for the support to create a routing instance. After that, you will be able to get the ID of the new routing instance by running the `yc cloudrouter routing-instance list` [{{ yandex-cloud }} CLI](../../cli/index.yaml) command.

{% endnote %}

## Create a private connection {#create-private-connection}

Once the routing instance has been created in your folder, create a [private {{ interconnect-name }} connection](../../baremetal/concepts/network.md#private-connection-to-vpc) in {{ baremetal-name }}:

{% include [create-private-connection](../../_includes/baremetal/create-private-connection.md) %}

## Check network connectivity {#check-connectivity}

As soon as the status of the new private connection changes to `Ready`, network connectivity between the {{ baremetal-name }} and {{ vpc-short-name }} subnets will be established, and you can start checking it.

A network connectivity check assumes that:
* The process of setting up a private connection to cloud networks has been successfully completed (the connection status is `Ready`).
* The local firewall on the {{ baremetal-name }} server allows [ICMP](https://en.wikipedia.org/wiki/Internet_Control_Message_Protocol) traffic.
* The routing table in the {{ baremetal-name }} server OS contains a route to the CIRD of the subnet the VM resides in.
* The [security group](../../vpc/concepts/security-groups.md) assigned to the VM [network interface](../../compute/concepts/network.md) allows ICMP traffic.

### Check network connectivity from the {{ baremetal-name }} private subnet to the {{ vpc-short-name }} private subnet {#check-bms-to-vm}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you created the infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Next to `server-m3`, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.baremetal.label_kvm-console }}**.
  
      The KVM console terminal window will open, showing a login prompt:
      
      ```
      server-m3 login:
      ```

      If you do not see this prompt, try [restarting](../../baremetal/operations/servers/server-stop-and-start.md#restart) the server.

  1. In the KVM console terminal, specify `root` for the username and press **ENTER**.
  1. Paste the password generated when leasing the server in the password input line and press **ENTER**. Note that when typing or pasting a password in Linux, the characters you enter will not appear on the screen.

      {% include [kvm-paste-tip](../../_includes/baremetal/kvm-paste-tip.md) %}

      Result:

      ```text
      Welcome to Ubuntu 24.04.2 LTS (GNU/Linux 6.8.0-53-generic x86_64)
      ...
      root@server-m3:~# _
      ```

      If you did not save the server administrator password, you can create a new password following [this guide](../../baremetal/operations/servers/reset-password.md) or [reinstall](../../baremetal/operations/servers/reinstall-os-from-marketplace.md) the server OS.
  1. In the KVM console terminal, run the `ping` command to make sure you can access `sample-vm` by its [internal](../../compute/concepts/network.md#internal-ip) IP address:

      ```bash
      ping <VM_internal_IP_address> -c 5
      ```

      You can find the VM internal IP address in the [management console]({{ link-console-main }}) under **{{ ui-key.yacloud.compute.instance.overview.label_network-interface }}** on the VM information page.

      Result:

      ```text
      PING 192.168.11.2 (192.168.11.2) 56(84) bytes of data.
      64 bytes from 192.168.11.2: icmp_seq=1 ttl=64 time=3.90 ms
      64 bytes from 192.168.11.2: icmp_seq=2 ttl=64 time=0.235 ms
      64 bytes from 192.168.11.2: icmp_seq=3 ttl=64 time=0.222 ms
      64 bytes from 192.168.11.2: icmp_seq=4 ttl=64 time=0.231 ms
      64 bytes from 192.168.11.2: icmp_seq=5 ttl=64 time=0.235 ms

      --- 192.168.11.2 ping statistics ---
      5 packets transmitted, 5 received, 0% packet loss, time 4086ms
      rtt min/avg/max/mdev = 0.222/0.964/3.899/1.467 ms
      ```

      Network connectivity between the {{ baremetal-name }} server and the VM has been established with zero packet loss.

{% endlist %}

### Check network connectivity from the {{ vpc-short-name }} private subnet to the {{ baremetal-name }} private subnet {#check-vm-to-bms}

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the virtual machine over SSH.
1. In the terminal, run the `ping` command to make sure you can access `server-m3` by its private IP address:

      ```bash
      ping <server_private_IP_address> -c 5
      ```

      You can find the private IP address of the {{ baremetal-name }} server in the [management console]({{ link-console-main }}) under **{{ ui-key.yacloud.baremetal.title_section-server-network-settings }}** on the server information page.

      Result:

      ```text
      PING 192.168.1.3 (192.168.1.3) 56(84) bytes of data.
      64 bytes from 192.168.1.3: icmp_seq=1 ttl=64 time=0.271 ms
      64 bytes from 192.168.1.3: icmp_seq=2 ttl=64 time=0.215 ms
      64 bytes from 192.168.1.3: icmp_seq=3 ttl=64 time=0.262 ms
      64 bytes from 192.168.1.3: icmp_seq=4 ttl=64 time=0.223 ms
      64 bytes from 192.168.1.3: icmp_seq=5 ttl=64 time=0.208 ms

      --- 192.168.1.3 ping statistics ---
      5 packets transmitted, 5 received, 0% packet loss, time 4106ms
      rtt min/avg/max/mdev = 0.208/0.235/0.271/0.025 ms
      ```

      Network connectivity between the VM and the {{ baremetal-name }} server has been established with zero packet loss.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete](../../compute/operations/vm-control/vm-delete.md) the VM.
1. You cannot delete a {{ baremetal-name }} server. Instead, [cancel](../../baremetal/operations/servers/server-lease-cancel.md) the server lease renewal.
1. Delete the private connection if you no longer need it:

    {% list tabs group=instructions %}

    - Management console {#console} 
    
      1. In the [management console]({{ link-console-main }}), select the folder where you created the infrastructure.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
      1. In the left-hand panel, click ![icon](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud.baremetal.label_networks }}** and select `my-vrf`.
      1. Under **Private connection to cloud networks**, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![CircleXmark](../../_assets/console-icons/circle-xmark.svg) **Disable connection**.
      1. In the window that opens, confirm the deletion.

      The connection status will change to `Deleting`. Once all links are deleted, the connection will disappear from the list.

    {% endlist %}