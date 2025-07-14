# Establishing network connectivity between {{ baremetal-full-name }} subnets and on-premise with the help of {{ interconnect-name }}

In this tutorial, you will set up network connectivity between a {{ baremetal-name }} [server](../../baremetal/concepts/servers.md) located in a [private {{ baremetal-full-name }} subnet](../../baremetal/concepts/network.md#private-network) and your on-prem resources. Network connectivity will be established using [{{ interconnect-name }}](../../interconnect/index.yaml) and [{{ cr-name }}](../../cloud-router/index.yaml).
The diagram above shows network connectivity between the {{ baremetal-full-name }} segment resources and remote on-prem resources on the customer's site connected to {{ yandex-cloud }} via {{ interconnect-name }}.

To establish network connectivity between these resources and the customer's VPC network, you need to add the relevant VPC subnet IP prefixes to the routing instance. For more on configuring this type of network connectivity, see the [relevant documentation](../../cloud-router/tutorials/bm-vrf-and-vpc-interconnect.md). 

{% note info %}

It is assumed that the connectivity between on-prem and the VPC network via {{ interconnect-name }} has already been established and is operational. 

{% endnote %}

To set up network connectivity between {{ baremetal-name }} private subnets and on-prem using {{ interconnect-name }}, do the following:

1. [Get your cloud ready](#before-you-begin).
1. [Create a cloud infrastructure](#setup-infrastructure).
1. [Create a routing instance](#create-routing-instance).
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
        1. In the **{{ ui-key.yacloud.baremetal.field_name }}** field, enter a name for the subnet: `subnet-m3`.
        1. Enable **{{ ui-key.yacloud.baremetal.title_routing-settings }}**.
        1. In the **{{ ui-key.yacloud.baremetal.field_network-id }}** field, select the previously created segment, `my-vrf`.
        1. In the **{{ ui-key.yacloud.baremetal.field_CIDR }}** field, specify `192.168.1.0/24`.
        1. In the **{{ ui-key.yacloud.baremetal.field_gateway }}** field, keep the default value, `192.168.1.1`.
        1. Enable the **{{ ui-key.yacloud.baremetal.field_dhcp-settings }}** option and in the **{{ ui-key.yacloud.baremetal.field_dhcp-ip-range }}** field that appears, leave the default values, `192.168.1.1`-`192.168.1.254`.
        1. Click **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.

{% endlist %}


### Lease a {{ baremetal-name }} server {#rent-bms}

{% list tabs group=instructions %}

- Management console {#console}


  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. {% include [server-lease-step2](../../_includes/baremetal/instruction-steps/server-lease-step2.md) %}
  1. Under **{{ ui-key.yacloud.baremetal.title_section-server-config }}**, click the `{{ ui-key.yacloud.baremetal.servers.ConfigurationField.poolFilter_frWLA }}` filter and select the `{{ region-id }}-m3` server pool.
  1. {% include [server-lease-step5](../../_includes/baremetal/instruction-steps/server-lease-step5.md) %}
  1. {% include [server-lease-step6](../../_includes/baremetal/instruction-steps/server-lease-step6.md) %}
  1. Under **{{ ui-key.yacloud.baremetal.title_section-server-product }}**, select an image, e.g., `Ubuntu 24.04`.
  1. {% include [server-lease-step6-substep](../../_includes/baremetal/instruction-steps/server-lease-step6-substep.md) %}
  1. Under **Network settings**:

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

## Create a routing instance {#create-routing-instance}

To set up network connectivity between {{ baremetal-name }} subnets and on-prem subnets, you need to create a `Routing Instance` resource. To create a `Routing Instance`, [contact]({{ link-console-support }}/tickets/create) support.

If your folder already has [{{ interconnect-name }}](../../interconnect/index.yaml) network connectivity (VPC-to-On-Prem) configured, you can either use the existing `Routing Instance` or request a new additional `Routing Instance` to be created for standalone network connectivity.

### Make sure you have a routing instance in your folder {#check-for-ri}

1. {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. {% include [check-for-routing-instance](../../_includes/baremetal/check-for-routing-instance.md) %}

1. If you already have a routing instance, you may skip the next step and [proceed](#create-private-connection) to creating a private connection.

    If you do not have a routing instance or you want to build additional dedicated network connectivity, request a new routing instance.

### Request a new routing instance {#request-ri}

{% include [request-routing-instance](../../_includes/baremetal/request-routing-instance.md) %}

## Create a private connection {#create-private-connection}

Once the routing instance has been created in your folder, create a [private {{ interconnect-name }} connection](../../baremetal/concepts/network.md#private-connection-to-vpc) in {{ baremetal-name }}:

{% include [create-private-connection](../../_includes/baremetal/create-private-connection.md) %}

## Test network connectivity {#check-connectivity}

As soon as the status of the new private connection changes to `Ready`, network connectivity between the {{ baremetal-name }} and {{ vpc-short-name }} subnets will be established, and you can start checking it.

A network connectivity check assumes that:
* The process of setting up a private connection to cloud networks has been successfully completed (the connection status is `Ready`).
* The local firewall on the {{ baremetal-name }} server allows [ICMP](https://en.wikipedia.org/wiki/Internet_Control_Message_Protocol) traffic.
* The routing table in the {{ baremetal-name }} server OS contains a route to the CIRD of the subnet the VM resides in.
* The [security group](../../vpc/concepts/security-groups.md) assigned to the VM [network interface](../../compute/concepts/network.md) allows ICMP traffic.

### Test network connectivity from the private {{ baremetal-name }} subnet to the on-prem resources {#check-bms-to-onprem}

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

### Test network connectivity from the on-prem resource to the private {{ baremetal-name }} subnet {#check-onprem-to-bms}

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the virtual machine over SSH.
1. In the terminal, run the `ping` command to make sure you can access `server-m3` by its private IP address:

      ```bash
      ping <server_private_IP_address> -c 5
      ```

      You can find the private IP address of the {{ baremetal-name }} server in the [management console]({{ link-console-main }}) under **Network settings** on the server information page.

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
      1. Under **{{ ui-key.yacloud.baremetal.title_vrf-interconnect-section }}**, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![CircleXmark](../../_assets/console-icons/circle-xmark.svg) **{{ ui-key.yacloud.baremetal.action_delete-external-connection }}**.
      1. In the window that opens, confirm the deletion.

      The connection status will change to `Deleting`. Once all links are deleted, the connection will disappear from the list.

    {% endlist %}
