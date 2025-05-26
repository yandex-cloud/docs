# Configuring {{ dns-full-name }} to access a {{ mch-name }} cluster from other cloud networks


In this tutorial, we will use a {{ mch-name }} cluster as an example. You can configure availability for other managed database services the same way.

Resource records for {{ mch-name }} clusters are created in [DNS service zones](../../../dns/concepts/dns-zone.md#service-zones) operating within a single [cloud network](../../../vpc/concepts/network.md#network). This prevents clients, such as virtual machines residing in a different cloud network, from connecting to cluster hosts using their [FQDNs](../../../managed-clickhouse/concepts/network.md#hostname), even with network connectivity configured between the cloud networks.

To enable clients from different cloud networks to connect to the cluster using its FQDN, configure a shared DNS zone in {{ dns-full-name }}:

1. [Create a zone in {{ dns-full-name }}](#create-peering-zone).
1. [Check if the cluster is available from a different cloud network](#check-cluster-availability).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* Fee for a {{ mch-name }} cluster: using computing resources allocated to hosts (including {{ ZK }} hosts) and disk space (see [{{ mch-name }} pricing](../../../managed-clickhouse/pricing.md)).
* Fee for a VM: using computing resources, storage, and, optionally, a public IP address (see [{{ compute-name }} pricing](../../../compute/pricing.md)).
* Fee for a DNS zone and DNS requests (see [{{ dns-name }} pricing](../../../dns/pricing.md)).


## Getting started {#before-you-begin}

1. [Prepare an SSH key pair](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) to connect to VMs.
1. Set up the infrastructure:

    {% list tabs %}

    - Manually

        1. [Create two cloud networks](../../../vpc/operations/network-create.md) named `mch-net` and `another-net`.
        1. [Create a subnet](../../../vpc/operations/subnet-create.md) in each network.
        1. In `mch-net`, [create a {{ mch-name }} cluster](../../../managed-clickhouse/operations/cluster-create.md) of any suitable configuration with hosts that have no public access.
        1. Optionally, in `mch-net`, [create a Linux-based VM](../../../compute/operations/vm-create/create-linux-vm.md) named `mch-net-vm`. When creating it, specify the public SSH key you prepared earlier.
        1. In `another-net`, [create a Linux-based VM](../../../compute/operations/vm-create/create-linux-vm.md) named `another-net-vm`. When creating it, specify the public SSH key you prepared earlier.
        1. Configure VM and cluster security group rules by following [this tutorial](../../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).

    - Using {{ TF }}

        1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

        1. Download the [nets-vm-mch.tf](https://github.com/yandex-cloud-examples/yc-dns-for-managed-clickhouse/blob/main/nets-vm-mch.tf) configuration file to the same working directory.

            This file describes:

            * [Networks](../../../vpc/concepts/network.md#network).
            * [Subnets](../../../vpc/concepts/network.md#subnet).
            * [Security groups](../../../vpc/concepts/security-groups.md) required for the {{ mch-name }} cluster and VMs.
            * Virtual machines.
            * {{ mch-name }} cluster.
            * Internal DNS zone.

        1. Specify the following in the `nets-vm-mch.tf` file:

            * `ch_dbname`: Name of the database in the {{ mch-name }} cluster.
            * `ch_user`: {{ mch-name }} cluster admin username.
            * `ch_password`: {{ mch-name }} cluster admin user password.
            * `image_id`: ID of the VM’s public image. For more information about how to get a list of available images, see [this guide](../../../compute/operations/images-with-pre-installed-software/get-list.md).
            * `vm_username`: VM user name.
            * `vm_ssh_key_path`: Absolute path to the VM public key you prepared earlier.
            * `create_optional_vm`: Parameter for creating a VM in the same network as the cluster. Optionally, set it to `1` so you can check later if the cluster is available from the same network.

        1. Run the `terraform init` command in the directory with the configuration files. This command initializes the provider specified in the configuration file and enables you to use the provider’s resources and data sources.
        1. Make sure the {{ TF }} configuration files are correct using this command:

            ```bash
            terraform validate
            ```

            If there are any errors in the configuration files, {{ TF }} will point them out.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

    {% endlist %}

1. Optionally, [use SSH to connect](../../../compute/operations/vm-connect/ssh.md#vm-connect) to the `mch-net-vm` VM and [configure cluster connection](../../../managed-clickhouse/operations/connect/clients.md) via `clickhouse-client` to make sure security groups have correct configurations and you can connect to the cluster using its FQDN from the same cloud network.
1. Configure network connectivity between the `mch-net` and `another-net` cloud networks, e.g., using an [IPSec gateway](../../../tutorials/routing/ipsec/index.md). For other ways to configure network connectivity, see [{#T}](../../../tutorials/routing/index.md).

## Create a zone in {{ dns-name }} {#create-peering-zone}

1. Create a DNS zone:

    {% list tabs %}

    - Manually

        Create a private DNS zone with the `{{ dns-zone }}.` address as per [this tutorial](../../../dns/operations/zone-create-private.md). In the network list, specify `mch-net` and `another-net`.

    - Using {{ TF }}

        1. In the `nets-vm-mch.tf` file, set the `create_zone` parameter to `1`.

        1. Make sure the {{ TF }} configuration files are correct using this command:

            ```bash
            terraform validate
            ```

            If there are any errors in the configuration files, {{ TF }} will point them out.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

    {% endlist %}

1. Make sure the cluster record appeared automatically in the DNS zone.

    1. In the [management console]({{ link-console-main }}), select the folder containing the DNS zone.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
    1. Select the zone from the list.
    1. Make sure the record list contains a record in the following format: `c-<cluster_ID>.rw.{{ dns-zone }}.`.

## Check if the cluster is available from a different cloud network {#check-cluster-availability}

1. [Use SSH to connect](../../../compute/operations/vm-connect/ssh.md#vm-connect) to `another-net-vm`.
1. [Configure cluster connection](../../../managed-clickhouse/operations/connect/clients.md) via `clickhouse-client` and make sure you can connect to the cluster from a different cloud network using the cluster FQDN.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs %}

- Manually

    1. [DNS zone](../../../dns/operations/zone-delete.md)
    1. [{{ mch-name }} cluster](../../../managed-clickhouse/operations/cluster-delete.md)
    1. [Cloud networks](../../../vpc/operations/network-delete.md)

- Using {{ TF }}

    {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
