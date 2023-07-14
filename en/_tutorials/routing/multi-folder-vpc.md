# Setting up networking between resources in different folders

In {{ yandex-cloud }}, network resources, such as cloud network and subnets, are usually created in a single resource cloud folder that is not linked to resources in other cloud folders. When deploying resources in {{ yandex-cloud }}, you may need to regularly ensure networking between resources residing in different folders. One of the ways to do that is to use the `Multi-folder VPC` method that extends the scope of an individual {{ vpc-short-name }} network to multiple rather than one folder. This is achieved by moving its subnets to other cloud folders.

Once you move the subnets to target folders, you can connect to them VMs, {{ managed-k8s-name }} clusters, database hosts, load balancers, load testing agents, and other resources residing in these folders. As a result, your network will ensure connectivity between resources in different folders.

This guide provides an example of how to create an infrastructure consisting of three VM instances, each residing in a different folder. These instances are connected via a shared internal network. Network connectivity between cloud resources hosted in different folders is established by creating a cloud network in one of these folders and then moving individual subnets to other folders. This way, a single-folder network is sort of extended to multiple folders, while a moved subnet allows connecting resources to it in this folder.

{% note warning %}

You can only move subnets between folders within a single cloud.

{% endnote %}

For example, the development environment includes the CI/CD module whose components are hosted in `network-folder`. This module should enable networking between the **DEV**, **STAGE**, and **PROD** components residing in their folders.

This solution pattern is shown below.

![Multi-folder VPC](../../_assets/tutorials/infrastructure-management/multi-folder-vpc/multi-folder-vpc.svg)

The deployment will set up networking between VMs from different environments (folders) connected to different subnets in one network. Moreover, all VMs will be able to communicate with one another both by IPs and their FQDNs (over DNS).


To create a test infrastructure and enable networking between the resources:

1. [Prepare your cloud](#prepare-cloud).
1. [Create folders without a {{ vpc-short-name }} network](#create-folders).
1. [Create a {{ vpc-short-name }} cloud network with subnets](#create-vpc).
1. [Move the subnets](#move-subnets).
1. [Create VM instances](#create-vms).
1. [Check networking](#check-connectivity).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of this infrastructure includes:

* Fee for continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using public IP addresses and outgoing traffic (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


### Set up access rights {#roles}

Set up [access rights for the folder](../../resource-manager/operations/folder/set-access-bindings.md):

* To create networks and manage subnets, assign to the service account or user the `vpc.admin` service role or the `vpc.privateAdmin`, `vpc.publicAdmin`, and `vpc.securityGroups.admin` service roles.
* To create and manage VMs in the folder, assign the `vpc.user` and `compute.admin` service roles.

Network access is differentiated by [security groups](../../vpc/concepts/security-groups.md).

## Create folders without a {{ vpc-short-name }} network {#create-folders}

1. Create a folder named `network-folder`:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and click ![Create icon](../../_assets/create.png) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
      1. Enter the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) name: `network-folder`.
      1. Enter a description of the folder if needed.
      1. Disable **{{ ui-key.yacloud.iam.cloud.folders-create.field_default-net }}** to create your network and subnets manually.
      1. Click **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.


   - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% note info %}

      To create resources using the CLI, [authenticate](../../cli/operations/authentication/service-account.md#auth-as-sa) using the [service account](../../iam/concepts/users/service-accounts.md) having the `admin` [role](../../iam/concepts/access-control/roles.md) for the [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).

      {% endnote %}

      1. See a description of the create folder command:

         ```bash
         yc resource-manager folder create --help
         ```

      1. Create another folder named `network-folder`:

         ```bash
         yc resource-manager folder create \
         --name network-folder
         ```

   {% endlist %}

1. Similarly, create two more folders without the {{ vpc-short-name }} network, naming them as `dev-folder` and `prod-folder`.

## Create a {{ vpc-short-name }} cloud network with subnets {#create-vpc}

In `network-folder`, create a network named `shared-net`, with three subnets in it:

1. Create a network:

   {% list tabs %}

   - Management console

      To create a [cloud network](../../vpc/concepts/network.md):
      1. In the [management console]({{ link-console-main }}), go to `network-folder`.
      1. In the list of services, select **{{ vpc-name }}**.
      1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
      1. Enter the network name: `shared-net`.
      1. Add a network description if needed.
      1. Disable [Create subnets](../../vpc/operations/subnet-create.md) to create subnets manually.
      1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.

   - CLI

      To create a [cloud network](../../vpc/concepts/network.md):
      1. See the description of the CLI command for creating a cloud network:

         ```
         yc vpc network create --help
         ```

      1. Create a cloud network named `shared-net` in `network-folder`:

         ```
         yc vpc network create \
            --folder-name network-folder \
            --name shared-net
         ```

   {% endlist %}

1. Create the `subnet-a` network in the `{{ region-id }}-a` [availability zone](../../overview/concepts/geo-scope.md):

   {% list tabs %}

   - Management console

      To create a [subnet](../../vpc/concepts/network.md#subnet):
      1. In the [management console]({{ link-console-main }}), go to `network-folder`.
      1. In the list of services, select **{{ vpc-name }}**.
      1. Click the name of the `shared-net` cloud network.
      1. Click **{{ ui-key.yacloud.vpc.network.overview.button_create_subnetwork }}**.
      1. Enter the subnet name: `subnet-a`.
      1. Add a network description if needed.
      1. Select the `{{ region-id }}-a` availability zone from the drop-down list.
      1. Enter the subnet CIDR: the IP address `10.1.11.11/24` and mask `24`. For more information about subnet IP address ranges, see [Cloud networks and subnets](../../vpc/concepts/network.md).
      1. Click **Create subnet**.

   - CLI

      To create a [subnet](../../vpc/concepts/network.md#subnet):

      1. See the description of the CLI command for creating a subnet:

         ```
         yc vpc subnet create --help
         ```

      1. Create a subnet in `network-folder`:

         ```
         yc vpc subnet create \
           --folder-id network-folder \
           --name subnet-a \
           --network-name shared-net \
           --zone {{ region-id }}-a \
           --range 10.1.11.11/24
         ```

   {% endlist %}

1. Similarly, create `subnet-b` with the IP address `10.1.12.0` and mask `24`, in the `{{ region-id }}-b` availability zone, and `subnet-c` with the IP address `10.1.13.0` and mask `24`, in the `{{ region-id }}-c` availability zone.

## Move the subnets {#move-subnets}

1. Move `subnet-b` to `dev-folder`.

   {% list tabs %}

   - Management console

      To move a subnet to another folder:

      1. In the [management console]({{ link-console-main }}), go to `network-folder`.
      1. In the list of services, select **{{ vpc-name }}**.
      1. Click the name of the `shared-net` cloud network.
      1. Click ![image](../../_assets/options.svg) in the line of `subnet-b` and select **{{ ui-key.yacloud.vpc.button_move-vpc-object }}**.
      1. Select `dev-folder` in the drop-down list.
      1. Click **Move**.

   - CLI

      To move a subnet to another folder:

      1. View a description of the CLI move subnet command:

         ```bash
         yc vpc subnet move --help
         ```

      1. Move the subnet, specifying `dev-folder` as the destination.

         ```bash
         yc vpc subnet move subnet-b \
           --folder-name network-folder \
           --destination-folder-name dev-folder \
         ```

   {% endlist %}

1. Move `subnet-b` to `prod-folder` similarly.

## Create VMs {#create-vms}

1. Create a Linux VM named `network-vm` in `network-folder`:

   1. In the [management console]({{ link-console-main }}), select `network-folder`.
   1. In the list of services, select **{{ compute-name }}**.
   1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
      * Enter the name: `network-vm`.
      * Select an availability zone `{{ region-id }}-a`.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select Ubuntu 20.04.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, select the `subnet-a` subnet.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the information required to access the instance:
      * Enter the `ycuser` username in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.
      * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the [public key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file. You need to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair for the SSH connection yourself.
   1. Leave all the other settings as they are and click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

1. Similarly, create a VM named `dev-vm` in `dev-folder`, in the `{{ region-id }}-b` availability zone, with the `subnet-b` subnet, and a VM named `prod-vm` in `prod-folder` in the `{{ region-id }}-c` availability zone, with the `subnet-c` subnet.

{% note info %}

A public and private IP addresses are assigned to the VM at creation. Write them down, you will need them to access the VM and check networking with other VMs.

{% endnote %}

## Check networking between the resources {#check-connectivity}

1. Connect to `network-vm` over SSH:

   ```bash
   ssh ycuser@<network-vm_public_IP_address>
   ```

1. Check that `dev-vm` is available on the internal network:

   ```bash
   ping -с3 <dev-vm_internal_IP_address>
   ```

   Result:

   ```
   PING 10.127.20.4 (10.127.20.4) 56(84) bytes of data.
   64 bytes from 10.127.20.4: icmp_seq=1 ttl=61 time=7.45 ms
   64 bytes from 10.127.20.4: icmp_seq=2 ttl=61 time=5.61 ms
   64 bytes from 10.127.20.4: icmp_seq=3 ttl=61 time=5.65 ms
   --- 10.127.20.4 ping statistics ---
   3 packets transmitted, 3 received, 0% packet loss, time 2003ms
   rtt min/avg/max/mdev = 5.613/6.235/7.446/0.855 ms
   ```

1. Similarly, check that the `prod-vm` is available on the internal network.

1. Connect to `dev-vm` over SSH and check the availability of `network-vm` and `prod-vm`.

1. Connect to `prod-vm` over SSH and check the availability of `network-vm` and `dev-vm`.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created, [delete](../../compute/operations/vm-control/vm-delete.md) `network-vm`, `dev-vm`, and `prod-vm`.
