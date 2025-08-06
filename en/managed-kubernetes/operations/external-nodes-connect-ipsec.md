---
title: How to configure IPSec gateways to connect external nodes to a {{ managed-k8s-name }} cluster
description: Follow this guide to configure IPSec gateways to connect external nodes to a {{ managed-k8s-name }} cluster.
---

# Configuring IPSec gateways to connect external nodes to a cluster

With {{ managed-k8s-full-name }}, you can connect servers from outside {{ yandex-cloud }} as [{{ k8s }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) nodes. To connect one, first, set up network connectivity between the remote network hosting the external server and the [cloud network](../../vpc/concepts/network.md#network) hosting your {{ managed-k8s-name }} cluster. You can do this using a VPN.

Below is an example of establishing network connectivity over the IPSec protocol. Here, the external server is a VM residing in another {{ yandex-cloud }} cloud network.

## Getting started {#before-you-begin}

1. [Create](../../vpc/operations/network-create.md) your main cloud network with three [subnets](../../vpc/concepts/network.md#subnet) in different availability zones.

1. In the main network, [create](kubernetes-cluster/kubernetes-cluster-create.md) a {{ managed-k8s-name }} cluster with a [highly available](../../managed-kubernetes/concepts/index.md#master) master.

    To create an external node group, the {{ managed-k8s-name }} cluster must operate in [tunnel mode](../concepts/network-policy.md#cilium). This mode can be enabled only when creating the cluster.

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. In the main network, [create](../../compute/operations/vm-create/create-linux-vm.md) a {{ compute-name }} VM with a [public IP address](../../vpc/concepts/address.md#public-addresses); name it `VM-1`. On this VM, you will set up the main IPSec gateway.

1. [Create](../../vpc/operations/network-create.md) an additional cloud network with one subnet.

1. In the additional network, [create](../../compute/operations/vm-create/create-linux-vm.md) a {{ compute-name }} VM with a public IP address; name it `VM-2`. You will use this VM to set up the additional IPSec gateway.

## Configuring security groups {#sg}

1. In the main network, [create](../../vpc/operations/security-group-create.md) a security group and assign it to `VM-1`. [Add](../../vpc/operations/security-group-add-rule.md) the following rules to the group:

    {% list tabs group=traffic %}

    - Outgoing traffic {#outgoing}

      {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
      --- | --- | --- | --- | ---
      `any` | `{{ port-any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`

    - Incoming traffic {#incoming}
      
      {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
      --- | --- | --- | --- | ---    
      `icmp` | `{{ port-any }}` | `ICMP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
      `ssh` | `22` | `TCP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
      `ipsec-udp-500` | `500` | `UDP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<VM_2_public_address>/32`
      `ipsec-udp-4500` | `4500` | `UDP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<VM_2_public_address>/32`
      `VM-2-subnet` | `{{ port-any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<VM_2_subnet_CIDR>`

    {% endlist %}

1. In the additional network, [create](../../vpc/operations/security-group-create.md) a security group and assign it to `VM-2`. [Add](../../vpc/operations/security-group-add-rule.md) the following rules to the group:

    {% list tabs group=traffic %}

    - Outgoing traffic {#outgoing}

      {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
      --- | --- | --- | --- | ---
      `any` | `{{ port-any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`

    - Incoming traffic {#incoming}

      {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
      --- | --- | --- | --- | --- 
      `icmp` | `{{ port-any }}` | `ICMP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
      `ssh` | `22`   | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
      `ipsec-udp-500` | `500` | `UDP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<VM_1_public_address>/32`
      `ipsec-udp-4500` | `4500` | `UDP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<VM_1_public_address>/32`
      `k8s-VM-1-subnets` | `{{ port-any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<main_subnet1_CIDR>`, `<main_subnet2_CIDR>`, `<<main_subnet3_CIDR>`
      `cluster&services` | `{{ port-any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<cluster_CIDR>`, `<CIDRs_of_services>`

    {% endlist %}

1. [Add](../../vpc/operations/security-group-add-rule.md) the following rule to the security group of the {{ managed-k8s-name }} cluster and node groups:

    {% list tabs group=traffic %}

    - Incoming traffic {#incoming}

      {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
      --- | --- | --- | --- | ---
      `VM-2-subnet` | `{{ port-any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<VM_2_subnet_CIDR>` 

    {% endlist %}

## Configuring routing {#rt}

1. Configure routing for the main IPSec gateway:

   1. In the main network, [create a route table and add a static route to it](../../vpc/operations/static-route-create.md):

      * **{{ ui-key.yacloud.vpc.add-static-route.field_destination-prefix }}**: Specify the CIDR of the `VM-2`'s subnet.
      * **{{ ui-key.yacloud.vpc.add-static-route.value_ip-address }}**: Specify the `VM-1`'s internal IP address.

   1. Associate the route table with all subnets in your main network.

1. Configure routing for the additional IPSec gateway:

   1. In the additional network, create a route table.

   1. Add a static route for the route table:

      * **{{ ui-key.yacloud.vpc.add-static-route.field_destination-prefix }}**: Specify the CIDR of the `VM-1`'s subnet.
      * **{{ ui-key.yacloud.vpc.add-static-route.value_ip-address }}**: Specify the `VM-2`'s internal IP address.

      Repeat this step for each subnet in your main network.

   1. Associate the route table to the `VM-2`'s subnet.

## Setting up IPSec gateways {#gw}

1. Set up the main IPsec gateway:

    1. [Connect](../../compute/operations/vm-connect/ssh.md) to `VM-1` over SSH.

    1. Install strongSwan:

        ```bash
        sudo apt update && sudo apt install strongswan
        ```

    1. Open the `ipsec.conf` configuration file:

        ```bash
        sudo nano /etc/ipsec.conf
        ```

    1. Replace the file contents with this text:

        ```text
        # basic configuration

        config setup
          charondebug="all"
          uniqueids=yes

        conn VM-1
          type=tunnel
          auto=route
          keyexchange=ikev2
          ike=aes256-sha2_256-modp2048!
          esp=aes256-sha2_256!
          authby=secret
          left=<VM_1_internal_address>
          leftsubnet=<main_subnet1_CIDR>,<main_subnet2_CIDR>,<main_subnet3_CIDR>
          leftsourceip=<VM_1_internal_address>
          leftid=<VM_1_public_address>
          right=<VM_2_public_address>
          rightsubnet=<VM_2_subnet_CIDR>
          aggressive=no
          keyingtries=%forever
          ikelifetime=86400s
        ```  

        For more information about parameters, see the [strongSwan documentation](https://wiki.strongswan.org/projects/strongswan/wiki/connsection).

    1. Open the `ipsec.secrets` file that is used for authentication:

       ```bash
       sudo nano /etc/ipsec.secrets
       ```

    1. Replace the file contents with this text:

       ```text
       <VM_1_public_address> <VM_2_public_address> : PSK "<password>"
       ```

       To learn more about the `ipsec.secrets` file format, see the [strongSwan documentation](https://wiki.strongswan.org/projects/strongswan/wiki/Ipsecsecrets).

1. Set up the additional IPSec gateway:

    1. [Connect](../../compute/operations/vm-connect/ssh.md) to `VM-2` over SSH.

    1. Install [strongSwan](https://docs.strongswan.org/docs/latest/howtos/introduction.html):

        ```bash
        sudo apt update && sudo apt install strongswan
        ```

    1. Open the `ipsec.conf` configuration file:

        ```bash
        sudo nano /etc/ipsec.conf
        ```

    1. Replace the file contents with this text:

        ```text
        # basic configuration

        config setup
          charondebug="all"

        conn VM-2
          type=tunnel
          auto=route
          keyexchange=ikev2
          ike=aes256-sha2_256-modp2048!
          esp=aes256-sha2_256!
          authby=secret
          left=<VM_2_internal_address>
          leftid=<VM_2_public_address>
          leftsubnet=<VM_2_subnet_CIDR>
          right=<VM_1_public_address>
          rightsubnet=<main_subnet1_CIDR>,<main_subnet2_CIDR>,<main_subnet3_CIDR>
          rightsourceip=<VM_1_internal_address>
          aggressive=no
          keyingtries=%forever
          ikelifetime=86400s
          lifetime=43200s
          lifebytes=576000000
          dpddelay=30s
        ```

        For more information about parameters, see the [strongSwan documentation](https://wiki.strongswan.org/projects/strongswan/wiki/connsection).

    1. Open the `ipsec.secrets` file required for authentication:

       ```bash
       sudo nano /etc/ipsec.secrets
       ```

    1. Replace the file contents with this text:

       ```text
       <VM_2_public_address> <VM_1_public_address> : PSK "<password>"
       ```

       Passwords must be the same for both VMs.

       To learn more about the `ipsec.secrets` file format, see the [strongSwan documentation](https://wiki.strongswan.org/projects/strongswan/wiki/Ipsecsecrets). 

1. Restart strongSwan on both VMs:

   ```bash
   sudo ipsec restart
   ```

1. Check the connection status on both VMs:

   ```bash
   sudo ipsec statusall
   ```

   You should see `ESTABLISHED` in the command output, indicating a successfully established connection:

   ```text
   ...
   Security Associations (1 up, 0 connecting):
        VM-1[1]: ESTABLISHED 5 seconds ago, 10.128.*.**[46.21.***.***]...84.201.***.***[84.201.***.***]
   ...
   ```

   If the connection was not established, try establishing it manually. On the `VM-1` VM, run the following command:

    ```bash
    sudo ipsec up VM-1
    ```

   You may run this command on just one of the VMs.

1. {% include [mtu](../../_includes/managed-kubernetes/ext-nodes-vpn-mtu.md) %}

1. [Connect](../../managed-kubernetes/operations/external-nodes-connect.md) `VM-2` to the {{ managed-k8s-name }} cluster as its external node.

## Troubleshooting {#troubleshooting}

{% include [docker-containerd-error](../../_includes/managed-kubernetes/ext-nodes-vpn-error.md) %}