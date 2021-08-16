---
title: Creating an Elasticsearch cluster
description: 'Managed Service for Elasticsearch cluster is a group of several related Elasticsearch hosts. When creating an Elasticsearch cluster, parameters are specified separately for hosts acting as a Master node, and separately for hosts acting as a Data node.'
keywords:
  - creating an Elasticsearch cluster
  - Elasticsearch cluster
  - Elasticsearch
---

# Creating clusters

A {{ mes-name }} cluster is a group of multiple linked {{ ES }} hosts. A cluster provides high search performance by distributing search and indexing tasks across all cluster hosts with the _Data node_ role. To learn more about roles in the cluster, see [{#T}](../concepts/hosts-roles.md).

The number of hosts with the _Data node_ role that can be created together with a {{ ES }} cluster depends on the selected [type of storage](../concepts/storage.md):

* With **local storage**, you can create a cluster with 3 or more hosts (to ensure fault tolerance, a minimum of 3 hosts is necessary).
* When using network storage:
    * If you select **standard** or **fast network storage**, you can add any number of hosts within the [current quota](../concepts/limits.md).
    * If you select **non-replicated network storage**, you can create a cluster with 3 or more hosts (to ensure fault tolerance, a minimum of 3 hosts is necessary).

After creating a cluster, you can add extra hosts to it if there are enough available [folder resources](../concepts/limits.md).

## Creating a cluster {#create-cluster}

When creating a cluster, parameters are specified separately for the hosts with the _Master node_ role and for the hosts with the _Data node_ role.

You can use hosts only with the _Data node_ role, without creating dedicated hosts for the _Master node_ role. In this case, hosts with the _Data node_ role combine the two roles.

{% list tabs %}

- Management console

  1. In the management console, select the folder where you want to create a cluster.
  1. Select **{{ mes-name }}**.
  1. Click **Create cluster**.
  1. Under **Basic parameters**:
     1. Enter a name for the cluster and, if necessary, a description. The cluster name must be unique within the folder.
     1. Select the environment where you want to create the cluster (you can't change the environment once the cluster is created):
        - `PRODUCTION`: For stable versions of your apps.
        - `PRESTABLE`: For testing, including the {{ mes-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.
     1. Select the {{ ES }} version. The current supported version is `7.6`.

  1. Under **Network settings**, select [network](../../vpc/concepts/network.md).
  1. Under **User**, specify the `admin` user password.

     {% include [mes-superuser](../../_includes/mdb/mes-superuser.md)%}

  1. Configure hosts with the _Data node_ role by opening the **Data node** tab:

     1. Under **Host class**, select the platform, host type, and host class.

        The host class defines the technical characteristics of virtual machines that {{ ES }} nodes are deployed on. All available options are listed in [{#T}](../concepts/instance-types.md). When you change the host class for the cluster, the characteristics of all existing instances change, too.

     1. Under **Storage**:

        * Choose the [type of storage](../concepts/storage.md), either a more flexible network type (`network-hdd`, `network-ssd`, or `network-ssd-nonreplicated`) or faster local SSD storage (`local-ssd`).

          When selecting a storage type, remember that:
          * The size of the local storage can only be changed in 100 GB increments.
          * The size of non-replicated network storage can only be changed in 93 GB increments.

        * Select the size of storage to be used for data.

     1. Under **Hosts**, select the configuration of hosts created together with the cluster.
        1. To add a host, click **Add host**.
        1. To change the added host, hover over the host line and click ![image](../../_assets/pencil.svg) icon.

          When changing the host, you can: {#change-data-node-settings}

          1. Select the availability zone and subnet.

          1. Enable public access. If public access is enabled for the {{ ES }} host with the _Data node_ role, you can connect to this {{ ES }} host or Kibana on the host over the internet. To learn more, see [{#T}](cluster-connect.md).

            {% include [mes-tip-public-kibana](../../_includes/mdb/mes-tip-connecting-to-public-kibana.md) %}

        When configuring the host parameters, note that if you selected `local-ssd` or `network-ssd-nonreplicated` under **Storage**, you need to add at least 3 hosts to the cluster.

  1. If necessary, configure the hosts with the _Master node_ role by opening the **Master node** tab:

     1. Under **Host class**, select the platform, host type, and host class.
     1. Under **Storage**, configure storage the same way as for hosts with the _Data node_ role.
     1. Under **Hosts**, click **Add hosts**. Three hosts are added. To change one of the added hosts, hover over the host line and click ![image](../../_assets/pencil.svg).

        When changing the host, you can: {#change-master-node-settings}

          1. Select the availability zone and subnet.

          1. Enable public access.

             {% note tip %}

             It's not recommended to enable public access for hosts with the _Master node_ role. Change this setting only if you know exactly what you want to do.

             {% endnote %}

  1. Click **Create**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To create a cluster:

    1. Check whether the folder has any subnets for the cluster hosts:

        ```bash
        yc vpc subnet list
        ```

        If there are no subnets in the folder, [create the necessary subnets](../../vpc/operations/subnet-create.md) in {{ vpc-short-name }}.

    1. View a description of the CLI create cluster command:

        ```bash
        {{ yc-mdb-es }} cluster create --help
        ```

    1. Specify the cluster parameters in the create command (only some of the supported parameters are given in the example):

        ```bash
        {{ yc-mdb-es }} cluster create \
           --name <cluster name> \
           --environment <prestable or production> \
           --network-name <network name> \
           --host zone-id=<availability zone>,subnet-id=<subnet ID>,assign-public-ip=<public access>,type=<host type: datanode or masternode> \
           --datanode-resource-preset <host class with DataNode role> \
           --datanode-disk-size <storage size in gigabytes for hosts with the DataNode role> \
           --datanode-disk-type <storage type for hosts with the DataNode role> \
           --masternode-resource-preset <host class with the MasterNode role> \
           --masternode-disk-size <storage size in gigabytes for hosts with the MasterNode role> \
           --masternode-disk-type <storage type for hosts with the MasterNode role> \
           --security-group-ids <list of security group IDs> \
           --version <version {{ ES }}> \
           --admin-password <admin user password>
        ```

        The subnet ID `subnet-id` should be specified if the selected availability zone contains two or more subnets.

- API

  To create a cluster, use the API `create` method and pass the following in the request:
    - In the `folderId` parameter, the ID of the folder where the cluster should be placed.
    - The cluster name, in the `name` parameter.
    - Cluster configuration, in the `configSpec` parameter, including:
        - Class of hosts with the _Master node_ role, in the `configSpec.elasticsearchSpec.masterNode.resources` parameter. If you don't want to create dedicated hosts with the _Master node_ role, don't set values for the group of `configSpec.elasticsearchSpec.masterNode` parameters.
        - Class of hosts with the _Data node_ role, in the `configSpec.elasticsearchSpec.dataNode.resources` parameter.
    - Configuration of the cluster hosts, in one or more `hostSpecs` parameters.
    - Network ID, in the `networkId` parameter.

{% endlist %}

## Examples {#examples}

### Creating a single-host cluster {#creating-a-single-host-cluster}

{% list tabs %}

- CLI

    To create a cluster with a single host, pass a single `--host` parameter.

    Let's say we need to create a {{ ES }} cluster with the following characteristics:
    - Name: `my-es-clstr`.
    - Version: `7.10`.
    - In the `PRODUCTION` environment.
    - In the `default` network.
    - Belonging to the security group with the ID `enpp2s8l3irhk5eromd7`.
    - With a single publicly available host acting as a `{{ host-class }}`-class _Data node_ in subnet `{{ subnet-id }}` in availability zone `{{ zone-id }}`.
    - With 20 GB of fast network storage (`{{ disk-type-example }}`).
    - With password `esadminpwd` and username `admin`.

    Run the command:

    ```bash
    {{ yc-mdb-es }} cluster create \
       --name my-es-clstr \
       --environment production \
       --network-name default \
       --host zone-id={{ zone-id }},assign-public-ip=true,type=datanode \
       --datanode-resource-preset {{ host-class }} \
       --datanode-disk-type={{ disk-type-example }} \
       --datanode-disk-size=20 \
       --admin-password=esadminpwd \
       --security-group-ids enpp2s8l3irhk5eromd7 \
       --version 7.10
    ```

{% endlist %}
