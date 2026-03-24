# Setting up {{ dns-full-name }} to access managed database clusters from other cloud networks


In this tutorial, we will use a {{ mch-name }} cluster as an example. You can use the same method to configure availability for other managed database services.

{{ mch-name }} cluster resource records reside in [DNS service zones](../../../dns/concepts/dns-zone.md#service-zones) that are confined to one [cloud network](../../../vpc/concepts/network.md#network). This prevents clients, such as virtual machines residing in a different cloud network, from connecting to cluster hosts via [FQDN](../../../managed-clickhouse/concepts/network.md#hostname), despite established network connectivity.

To enable clients from different cloud networks to connect to the cluster via FQDN, configure a shared DNS zone in {{ dns-full-name }}:

1. [Create a zone in {{ dns-full-name }}](#create-peering-zone).
1. [Check if the cluster is available from a different cloud network](#check-cluster-availability).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost for this solution includes:

* {{ mch-name }} cluster fee: Covers the use of computing resources allocated to hosts (including {{ ZK }} hosts) and disk space (see [{{ mch-name }} pricing](../../../managed-clickhouse/pricing.md)).
* VM fee: Covers the use of computational resources, storage, and, optionally, a public IP address (see [{{ compute-name }} pricing](../../../compute/pricing.md)).
* DNS zone and queries fee (see [{{ dns-name }} pricing](../../../dns/pricing.md)).


## Getting started {#before-you-begin}

1. [Prepare an SSH key pair](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) for connecting to virtual machines.
1. Set up the infrastructure:

    {% list tabs %}

    - Manually

        1. [Create two cloud networks](../../../vpc/operations/network-create.md) named `mch-net` and `another-net`.
        1. [Create a subnet](../../../vpc/operations/subnet-create.md) in each network.
        1. In `mch-net`, [create a {{ mch-name }} cluster](../../../managed-clickhouse/operations/cluster-create.md) with no public access for its hosts, using any suitable configuration.
        1. Optionally, in `mch-net`, [create a Linux-based VM](../../../compute/operations/vm-create/create-linux-vm.md) named `mch-net-vm`. In the process, you will need to specify the public SSH key you created earlier.
        1. In `another-net`, [create a Linux-based VM](../../../compute/operations/vm-create/create-linux-vm.md) named `another-net-vm`. When creating it, specify the public SSH key you prepared earlier.
        1. Configure security group rules for your cluster and VMs according to [this tutorial](../../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).

    - Using {{ TF }}

        1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

        1. Download the [nets-vm-mch.tf](https://github.com/yandex-cloud-examples/yc-dns-for-managed-clickhouse/blob/main/nets-vm-mch.tf) configuration file to your current working directory.

            This file describes:

            * [Networks](../../../vpc/concepts/network.md#network).
            * [Subnets](../../../vpc/concepts/network.md#subnet).
            * [Security groups](../../../vpc/concepts/security-groups.md) required for the {{ mch-name }} cluster and VMs.
            * Virtual machines.
            * {{ mch-name }} cluster.
            * Internal DNS zone.

        1. In the `nets-vm-mch.tf` file, specify the following:

            * `ch_dbname`: {{ mch-name }} cluster database name.
            * `ch_user`: {{ mch-name }} cluster admin username.
            * `ch_password`: {{ mch-name }} cluster admin password.
            * `image_id`: VM public image ID. For details on getting a list of available images, see [this guide](../../../compute/operations/images-with-pre-installed-software/get-list.md).
            * `vm_username`: VM user name.
            * `vm_ssh_key_path`: Absolute path to your previously created VM public key.
            * `create_optional_vm`: Parameter that enables VM creation in the cluster’s network. Optionally, set it to `1` to test cluster accessibility from the same network later.

        1. Run the `terraform init` command in the directory with your configuration files. This command initializes the provider specified in the configuration file, making its resources and data sources available for use.
        1. Validate your {{ TF }} configuration files using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

    {% endlist %}

1. Optionally, connect to the `mch-net-vm` VM over [SSH](../../../compute/operations/vm-connect/ssh.md#vm-connect) and [configure cluster connection](../../../managed-clickhouse/operations/connect/clients.md) using `clickhouse-client` to make sure security groups are configured correctly and you can access the cluster via FQDN from within the cloud network.
1. Configure network connectivity between the `mch-net` and `another-net` cloud networks, e.g., via an [IPSec gateway](../../../tutorials/routing/ipsec/index.md). For alternative methods of configuring network connectivity, see [{#T}](../../../tutorials/routing/index.md) network infrastructure tutorials.

## Create a zone in {{ dns-name }} {#create-peering-zone}

1. Create a DNS zone:

    {% list tabs %}

    - Manually

        Create a private DNS zone for `{{ dns-zone }}.` by following [this tutorial](../../../dns/operations/zone-create-private.md), specifying `mch-net` and `another-net` in the network list.

    - Using {{ TF }}

        1. In the `nets-vm-mch.tf` file, set `create_zone` to `1`.

        1. Validate your {{ TF }} configuration files using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

    {% endlist %}

1. Verify that the cluster record has been automatically created in the DNS zone.

    1. In the [management console]({{ link-console-main }}), select the folder containing your DNS zone.
    1. [Navigate to](../../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}** service.
    1. Select the zone from the list.
    1. Make sure the list contains a record in the following format: `c-<cluster_ID>.rw.{{ dns-zone }}.`.

## Check whether the cluster is available from a different cloud network {#check-cluster-availability}

1. [Use SSH to connect](../../../compute/operations/vm-connect/ssh.md#vm-connect) to `another-net-vm`.
1. [Configure cluster connection](../../../managed-clickhouse/operations/connect/clients.md) using `clickhouse-client` and check whether you can access the cluster via FQDN from a different cloud network.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

{% list tabs %}

- Manually

    1. [DNS zone](../../../dns/operations/zone-delete.md)
    1. [{{ mch-name }} cluster](../../../managed-clickhouse/operations/cluster-delete.md)
    1. [Cloud networks](../../../vpc/operations/network-delete.md)

- Using {{ TF }}

    {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
