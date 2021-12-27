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

  To create a cluster:

  1. In the management console, select the folder where you want to create a cluster.

  1. Select **{{ mes-name }}**.

  1. Click **Create cluster**.

  1. Under **Basic parameters**:
     1. Enter a name for the cluster and, if necessary, a description. The cluster name must be unique within the folder.
     1. Select the environment where you want to create the cluster (you can't change the environment once the cluster is created):
        - `PRODUCTION`: For stable versions of your apps.
        - `PRESTABLE`: For testing, including the {{ mes-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.
     1. Select the {{ ES }} version from the list.
     1. Select the [{{ ES }} edition](../concepts/es-editions.md).

  1. Under **Network settings**, select the cloud network to host the cluster in and security groups for cluster network traffic. You may need to additionally [set up security groups](cluster-connect.md#configuring-security-groups) to connect to the cluster.

  1. Under **User**, specify the `admin` user password.

     {% include [mes-superuser](../../_includes/mdb/mes-superuser.md) %}

  1. Configure hosts with the _Data node_ role by opening the **Data node** tab:

     1. Under **Host class**, select the platform, host type and host class.

        The host class defines the technical characteristics of virtual machines that {{ ES }} nodes are deployed on. All available options are listed in [{#T}](../concepts/instance-types.md). When you change the host class for the cluster, the characteristics of all existing instances change, too.

     1. Under **Storage**:

        * Choose the [type of storage](../concepts/storage.md), either a more flexible network type (`network-hdd`, `network-ssd` or `network-ssd-nonreplicated`) or faster local SSD storage (`local-ssd`).

          When selecting a storage type, remember that:
          * The size of the local storage can only be changed in 100 GB increments.
          * The size of non-replicated network storage can only be changed in 93 GB increments.

        * Select the size of storage to be used for data.

     1. Under **Hosts**, select the configuration of hosts created together with the cluster.

        1. To add a host, click **Add host**.

        1. To change the added host, hover over the host line and click ![image](../../_assets/pencil.svg) icon.

            When changing the host, you can: {#change-data-node-settings}

            - Select the availability zone and subnet.
            - Enable public access.

                {% note warning %}

                You can't assign a public IP address to a host after creating a cluster.

                {% endnote %}

                If public access is enabled for an {{ ES }} host with the _Data node_ role, you can connect to this host, or Kibana hosted on it, over the internet. To learn more, see [{#T}](cluster-connect.md).

                {% include [mes-tip-public-kibana](../../_includes/mdb/mes-tip-connecting-to-public-kibana.md) %}

            When configuring the host parameters, note that if you selected `local-ssd` or `network-ssd-nonreplicated` under **Storage**, you need to add at least 3 hosts to the cluster.

  1. If necessary, configure the hosts with the _Master node_ role by opening the **Master node** tab:

     1. Under **Host class**, select the platform, host type, and host class.

     1. Under **Storage**, configure storage the same way as for hosts with the _Data node_ role.

     1. Under **Hosts**, click **Add hosts**. Three hosts are added. To change one of the added hosts, hover over the host line and click ![image](../../_assets/pencil.svg).

        When changing the host, you can: {#change-master-node-settings}

        - Select the availability zone and subnet.

        - Enable public access.

            {% note tip %}

            It's not recommended to enable public access for hosts with the _Master node_ role, because this might be unsafe.

            {% endnote %}

  1. If necessary, configure additional cluster settings:

      {% include [extra-settings](../../_includes/mdb/mes/extra-settings.md) %}

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
           --edition <{{ ES }} edition: basic, gold, or platinum> \
           --admin-password <admin user password> \
           --deletion-protection=<protect cluster from deletion: true or false>
        ```

        Enter the subnet ID `subnet-id` if the availability zone includes more than one subnet.

        {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-data.md) %}

- Terraform

    {% include [terraform-definition](../../_includes/solutions/terraform-definition.md) %}

    If you don't have Terraform, [install it and configure the provider](../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

    To create a cluster:

    1. In the configuration file, describe the parameters of resources that you want to create:
        * Database cluster: Description of the cluster and its hosts.
        * Network: Description of the [cloud network](../../vpc/concepts/network.md#network) where the cluster will be located. If you already have a suitable network, you don't need to describe it again.
        * Subnets: Description of the [subnets](../../vpc/concepts/network.md#network) to connect the cluster hosts to. If you already have suitable subnets, you don't need to describe them again.

        Example configuration file structure:

        ```hcl
        terraform {
          required_providers {
            yandex = {
              source = "yandex-cloud/yandex"
            }
          }
        }
        
        provider "yandex" {
          token     = "<OAuth or static key of service account>"
          cloud_id  = "<cloud ID>"
          folder_id = "<folder ID>"
          zone      = "<availability zone>"
        }
        
        resource "yandex_mdb_elasticsearch_cluster" "<cluster name>" {
          name        = "<cluster name>"
          environment = "<PRESTABLE or PRODUCTION>"
          network_id  = "<network ID>"
        
          config {
            version = "<(optional) {{ ES }} version>"
            edition = "<(optional) {{ ES }} edition: basic, gold, or platinum>"
        
            admin_password = "<admin user password>"
        
            data_node {
              resources {
                resource_preset_id = "<host class>"
                disk_type_id       = "<storage type>"
                disk_size          = <storage size in GB>
              }
            }
        
            master_node {
              resources {
                resource_preset_id = "<host class>"
                disk_type_id       = "<storage type>"
                disk_size          = <storage size in GB>
              }
            }
        
          }
        
          security_group_ids = [ "<list of security groups>" ]
        
          host {
            name = "<host name>"
            zone = "<availability zone>"
            type = "<host role: DATA_NODE or MASTER_NODE>"
            assign_public_ip = <public access to the host: true or false>
            subnet_id = "<subnet ID>"
          }
        
        }
        
        resource "yandex_vpc_network" "<network name>" { name = "<network name>" }
        
        resource "yandex_vpc_subnet" "<subnet name>" {
          name           = "<subnet name>"
          zone           = "<availability zone>"
          network_id     = "<network ID>"
          v4_cidr_blocks = ["<range>"]
        }
        ```

        For more information about the resources you can create using Terraform, see the [provider documentation {{ TF }}]({{ tf-provider-mes }}).

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Create a cluster.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

  To create a cluster, use the [create](../api-ref/Cluster/create.md) API method and pass the following in the request:
    - In the `folderId` parameter the ID of the folder where the cluster should be placed.
    - The cluster name in the `name` parameter.
    - The {{ ES }} version in the `configSpec.version` parameter.
    - The {{ ES }} edition in the `configSpec.edition` parameter.
    - Cluster configuration, in the `configSpec` parameter, including:
        - Class of hosts with the _Master node_ role, in the `configSpec.elasticsearchSpec.masterNode.resources` parameter. If you don't want to create dedicated hosts with the _Master node_ role, don't set values for the group of `configSpec.elasticsearchSpec.masterNode` parameters.
        - Class of hosts with the _Data node_ role, in the `configSpec.elasticsearchSpec.dataNode.resources` parameter.
    - Configuration of the cluster hosts, in one or more `hostSpecs` parameters.
    - Network ID, in the `networkId` parameter.
    - Security group IDs in the parameter `securityGroupIds`.

{% endlist %}

{% note warning %}

If you specified security group IDs when creating a cluster, you may also need to [re-configure security groups](cluster-connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}

## Examples {#examples}

### Creating a single-host cluster {#creating-a-single-host-cluster}

{% list tabs %}

- CLI

    To create a cluster with a single host, pass a single `--host` parameter.

    Let's say we need to create a {{ ES }} cluster with the following characteristics:
    - Name: `my-es-clstr`.
    - Version: `7.10`.
    - `Platinum` editions.
    - In the `PRODUCTION` environment.
    - In the `default` network.
    - Belonging to the security group with the ID `enpp2s8l3irhk5eromd7`.
    - With a single publicly available host acting as a `{{ host-class }}`-class _Data node_ in subnet `{{ subnet-id }}` in availability zone `{{ zone-id }}`.
    - With 20 GB of fast network storage (`{{ disk-type-example }}`).
    - With password `esadminpwd` and username `admin`.
    - With protection against accidental cluster deletion.

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
       --version 7.10 \
       --edition platinum \
       --deletion-protection=true
    ```

- Terraform

    Let's say we need to create a {{ ES }} cluster with the following characteristics:
    - Name: `my-es-clstr`.
    - Version `7.13`.
    - With the `Basic` edition.
    - In the `PRODUCTION` environment.
    - In the cloud with the ID `{{ tf-cloud-id }}`.
    - In the folder with the ID `{{ tf-folder-id }}`.
    - In the new `mynet` network.
    - In the new `es-sg` security group allowing an internet connection to the cluster over ports 443 (Kibana) and 9200 ({{ ES }}).
    - With one publicly available host with the _Data node_ role and `{{ host-class }}` class in the new `mysubnet` subnet in the `{{ zone-id }}` availability zone. The `mysubnet` subnet will have the range `10.5.0.0/24`.
    - With 20 GB of fast network storage (`{{ disk-type-example }}`).
    - With password `esadminpwd` and username `admin`.

    The configuration file for the cluster looks like this:

    ```hcl
    terraform {
      required_providers {
        yandex = {
          source = "yandex-cloud/yandex"
        }
      }
    }
    
    provider "yandex" {
      token     = "<OAuth or static key of service account>"
      cloud_id  = "{{ tf-cloud-id }}"
      folder_id = "{{ tf-folder-id }}"
      zone      = "{{ zone-id }}"
    }
    
    resource "yandex_mdb_elasticsearch_cluster" "my-es-clstr" {
      name        = "my-es-clstr"
      environment = "PRODUCTION"
      network_id  = yandex_vpc_network.mynet.id
    
      config {
        edition = "basic"
    
        admin_password = "esadminpwd"
    
        data_node {
          resources {
            resource_preset_id = "s2.micro"
            disk_type_id       = "network-ssd"
            disk_size          = 20
          }
        }
    
      }
    
      security_group_ids = [ yandex_vpc_security_group.es-sg.id ]
    
      host {
        name = "node"
        zone = "ru-central1-c"
        type = "DATA_NODE"
        assign_public_ip = true
        subnet_id = yandex_vpc_subnet.mysubnet.id
      }
    
    }
    
    resource "yandex_vpc_network" "mynet" {
      name = "mynet"
    }
    
    resource "yandex_vpc_subnet" "mysubnet" {
      name           = "mysubnet"
      zone           = "{{ zone-id }}"
      network_id     = yandex_vpc_network.mynet.id
      v4_cidr_blocks = ["10.5.0.0/24"]
    }
    
    resource "yandex_vpc_security_group" "es-sg" {
      name       = "es-sg"
      network_id = yandex_vpc_network.mynet.id
    
      ingress {
        description    = "Kibana"
        port           = 443
        protocol       = "TCP"
        v4_cidr_blocks = [ "0.0.0.0/0" ]
      }
    
      ingress {
        description    = "Elasticsearch"
        port           = 9200
        protocol       = "TCP"
        v4_cidr_blocks = [ "0.0.0.0/0" ]
      }
    }
    ```

{% endlist %}

