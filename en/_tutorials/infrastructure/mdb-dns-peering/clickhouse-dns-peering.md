# Configuring {{ dns-full-name }} for {{ mch-name }} cluster access from other cloud networks

In this tutorial, we will use a {{ mch-name }} cluster as an example. The process of configuring availability for other managed database services is similar.

Resource records for {{ mch-name }} clusters are created in [DNS service zones](../../../dns/concepts/dns-zone.md#service-zones) operating within a single [cloud network](../../../vpc/concepts/network.md#network). This prevents clients, such as virtual machines residing in a different cloud network, from connecting to cluster hosts using their [FQDNs](../../../managed-clickhouse/concepts/network.md#hostname), even with configured network connectivity between the cloud networks.

To enable clients from different cloud networks to connect to the cluster using its FQDN, configure a shared DNS zone in {{ dns-full-name }}:

1. [Create a zone in {{ dns-full-name }}](#create-peering-zone).
1. [Check if the the cluster is available from a different cloud network](#check-cluster-availability).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

1. [Prepare an SSH key pair](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) to connect to VMs.
1. Prepare the infrastructure:

   {% list tabs %}

   - Manually

      1. [Create two cloud networks](../../../vpc/operations/network-create.md) named `mch-net` and `another-net`.
      1. [Create a subnet](../../../vpc/operations/subnet-create.md) in each network.
      1. In `mch-net`, [create](../../../managed-clickhouse/operations/cluster-create.md) a {{ mch-name }} cluster of any suitable configuration with hosts that have no public access.
      1. (Optional) In `mch-net`, [create a Linux-based VM](../../../compute/operations/vm-create/create-linux-vm.md) named `mch-net-vm`. When creating it, specify the public SSH key prepared earlier.
      1. In `another-net`, [create a Linux-based VM](../../../compute/operations/vm-create/create-linux-vm.md) named `another-net-vm`. When creating it, specify the public SSH key prepared earlier.
      1. Configure VM and cluster security group rules by following [this guide](../../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).

   - Using {{ TF }}

      1. {% include [terraform-install](../../../_includes/terraform-install.md) %}
      1. Download the [file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
      1. Download the [nets-vm-mch.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/nets-vm-mch.tf) configuration file to the same working directory.

         This file describes:

         * [Networks](../../../vpc/concepts/network.md#network).
         * [Subnets](../../../vpc/concepts/network.md#subnet).
         * [Security groups](../../../vpc/concepts/security-groups.md) required for the {{ mch-name }} cluster and VMs.
         * Virtual machines.
         * {{ mch-name }} cluster.
         * Internal DNS zone.

      1. In the `nets-vm-mch.tf` file, specify:

         * `ch_dbname`: Name of the {{ mch-name }} cluster database.
         * `ch_user`: {{ mch-name }} cluster admin username.
         * `ch_password`: {{ mch-name }} cluster admin user password.
         * `image_id`: ID of the VM public image. For more information about how to get a list of available images, see [this guide](../../../compute/operations/images-with-pre-installed-software/get-list.md).
         * `vm_username`: Virtual machine username.
         * `vm_ssh_key_path`: Absolute path to the VM public key you prepared earlier.
         * `create_optional_vm`: Parameter for creating a virtual machine in the same network as the cluster. Set it to `1` to later check if the cluster is available from the same network (optional).

      1. Run the `terraform init` command in the directory with the configuration files. This command initializes the provider specified in the configuration file and enables you to use the provider resources and data sources.
      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point them out.

      1. Create the required infrastructure:

         {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

         {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

1. (Optional) [Use SSH to connect](../../../compute/operations/vm-connect/ssh.md#vm-connect) to the `mch-net-vm` virtual machine and [configure cluster connection](../../../managed-clickhouse/operations/connect/clients.md) via `clickhouse-client` to make sure security groups are configured correctly and you can connect to the cluster using its FQDN from the same cloud network.
1. Configure network connectivity between the `mch-net` and `another-net` networks, for example, using an [IPSec gateway](../../../tutorials/routing/ipsec/index.md). For other ways to configure network connectivity, see [{#T}](../../../tutorials/routing/index.md).

## Create a zone in {{ dns-name }} {#create-peering-zone}

1. Create a DNS zone:

   {% list tabs %}

   - Manually

      Create a private DNS zone with the `{{ dns-zone }}.` address by following [this guide](../../../dns/operations/zone-create-private.md). In the network list, specify `mch-net` and `another-net`.

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

1. Make sure the cluster record appears automatically in the DNS zone.

   1. In the [management console]({{ link-console-main }}), select the folder containing the DNS zone.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
   1. Select the zone from the list.
   1. Check that the record list includes a record in the following format: `c-<cluster_ID>.rw.mdb.yandexcloud.net.`.

## Check whether the cluster is available from a different cloud network {#check-cluster-availability}

1. [Use SSH to connect](../../../compute/operations/vm-connect/ssh.md#vm-connect) to the `another-net-vm` virtual machine.
1. [Configure cluster connection](../../../managed-clickhouse/operations/connect/clients.md) via `clickhouse-client` and make sure you can connect to the cluster from a different cloud network using the cluster's FQDN.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs %}

- Manually

   1. [DNS zone](../../../dns/operations/zone-delete.md)
   1. [{{ mch-name }} cluster](../../../managed-clickhouse/operations/cluster-delete.md)
   1. [Cloud networks](../../../vpc/operations/network-delete.md)

- Using {{ TF }}

   If you created your resources using {{ TF }}:

   1. In the terminal window, go to the directory containing the infrastructure plan.
   1. Delete the `nets-vm-mch.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Confirm updating the resources.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

      This will delete all the resources described in the `nets-vm-mch.tf` configuration file.

{% endlist %}
