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

* With **local SSD** or **non-replicated SSD** storage, you can create a cluster with three or more hosts (a minimum of three hosts is required for fault tolerance).
* With **network HDD** or **network SSD** storage, you can add any number of hosts within the [current quota](../concepts/limits.md).

After creating a cluster, you can add extra hosts to it if there are enough available [folder resources](../concepts/limits.md).

## Creating a cluster {#create-cluster}

When creating a cluster, parameters are specified separately for the hosts with the _Master node_ role and for the hosts with the _Data node_ role.

You can use hosts only with the _Data node_ role, without creating dedicated hosts for the _Master node_ role. In this case, hosts with the _Data node_ role combine the two roles.

{% list tabs %}

- Management console

  To create a cluster:

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a cluster.

  1. Select **{{ mes-name }}**.

  1. Click **Create cluster**.

  1. Under **Basic parameters**:
     1. Enter a name for the cluster and, if necessary, a description. The cluster name must be unique within the folder.
     1. Select the environment where you want to create the cluster (you can't change the environment once the cluster is created):
        * `PRODUCTION`: For stable versions of your apps.
        * `PRESTABLE`: For testing, including the {{ mes-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.
     1. Select the {{ ES }} version from the list.
     1. Select the [{{ ES }} edition](../concepts/es-editions.md).

  1. Under **Network settings**, select the cloud network to host the cluster in and security groups for cluster network traffic. You may need to additionally [set up security groups](cluster-connect.md#configuring-security-groups) to connect to the cluster.

  1. Under **User**, specify the `admin` user password.

  1. Configure hosts with the _Data node_ role by opening the **Data node** tab:

     1. Under **Host class**, select the platform, host type, and host class.

        The host class defines the technical characteristics of virtual machines that {{ ES }} nodes are deployed on. All available options are listed in [{#T}](../concepts/instance-types.md). When you change the host class for the cluster, the characteristics of all existing instances change, too.

     1. Under **Storage**:

        * Select a [storage type](../concepts/storage.md).

           {% include [storages-step-settings](../../_includes/mdb/settings-storages-no-broadwell.md) %}

        * Select the size of storage to be used for data.

     1. Under **Hosts**, select the configuration of hosts created together with the cluster.
        1. To add a host, click **Add host**.
        1. To change the added host, hover over the host line and click ![image](../../_assets/pencil.svg) icon.

           When changing the host, you can: {#change-data-node-settings}

           * Select the availability zone and subnet.

           * Enable public access.

              {% note warning %}

              You can't assign a public IP address to a host after creating a cluster.

              {% endnote %}

              If public access is enabled for an {{ ES }} host with the _Data node_ role, you can connect to this host, or Kibana hosted on it, over the internet. For more information, see [{#T}](cluster-connect.md).

              {% include [mes-tip-public-kibana](../../_includes/mdb/mes-tip-connecting-to-public-kibana.md) %}

  1. If necessary, configure the hosts with the _Master node_ role by opening the **Master node** tab:

     1. Under **Host class**, select the platform, host type, and host class.

     1. Under **Storage**, configure storage the same way as for hosts with the _Data node_ role.

     1. Under **Hosts**, click **Add hosts**. Three hosts are added. To change one of the added hosts, hover over the host line and click ![image](../../_assets/pencil.svg).

        When changing the host, you can: {#change-master-node-settings}

        * Select the availability zone and subnet.

        * Enable public access.

           {% note tip %}

           It's not recommended to enable public access for hosts with the _Master node_ role, because this might be unsafe.

           {% endnote %}

     1. If necessary, configure additional cluster settings:

        {% include [extra-settings](../../_includes/mdb/mes/extra-settings.md) %}

  1. If necessary, configure the DBMS settings:

      You can configure the `Fielddata cache size` parameter. It sets the percentage or absolute value of the dynamic memory area allocated for the `fielddata` cache, for example: 10% or 512 MB.

  1. Click **Create**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a cluster:

   1. Check whether the folder has any subnets for the cluster hosts:

      ```bash
      yc vpc subnet list
      ```

      {% if audience != "internal" %}

        If there are no subnets in the folder, [create the necessary subnets](../../vpc/operations/subnet-create.md) in {{ vpc-full-name }}.

      {% else %}

        If there are no subnets in the folder, create the necessary subnets in {{ vpc-full-name }}.

      {% endif %}

   1. View a description of the CLI's create cluster command:

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
          --datanode-resource-preset <Data node host class> \
          --datanode-disk-size <storage size in gigabytes for Data node hosts> \
          --datanode-disk-type <storage type for Data node hosts> \
          --masternode-resource-preset <Master node host class> \
          --masternode-disk-size <storage size in gigabytes for Master node hosts> \
          --masternode-disk-type <storage type for Master node hosts> \
          --security-group-ids <list of security group IDs> \
          --version <{{ ES }} version: {{ versions.cli.str }}> \
          --edition <{{ ES }} edition: basic, gold, or platinum> \
          --admin-password <admin user password> \
          --plugins=<name of plugin 1>,...,<name of plugin N> \
          --deletion-protection=<protect cluster from deletion: true or false>
        ```

        Enter the subnet ID (`subnet-id` if the availability zone includes more than one subnet.

        {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

- Terraform

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   {% if audience != "internal" %}

   If you don't have Terraform, [install it and configure the provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% endif %}

   To create a cluster:

    1. In the configuration file, describe the parameters of resources that you want to create:

        * Database cluster: Description of the cluster and its hosts.

        * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

        * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

        Example configuration file structure:

        {% if product == "yandex-cloud" %}

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
          environment = "<environment: PRESTABLE or PRODUCTION>"
          network_id  = "<network ID>"

        config {
          version = "<(optional) {{ ES }} version: {{ versions.tf.str }}>"
          edition = "<(optional) {{ ES }} edition : basic, gold, or platinum>"

            admin_password = "<user admin password>"

            data_node {
              resources {
                resource_preset_id = "<host class>"
                disk_type_id       = "<storage type>"
                disk_size          = <storage size, GB>
              }
            }

            master_node {
              resources {
                resource_preset_id = "<host class>"
                disk_type_id       = "<storage type>"
                disk_size          = <storage size, GB>
              }
        
              plugins = [ "<list of plugin names>" ]

            security_group_ids = [ "<list of security groups>" ]
        
            host {
              name = "<host name>"
              zone = "<availability zone>"
              type = "<host role: DATA_NODE or MASTER_NODE>"
              assign_public_ip = <public access to the host: true or false>
              subnet_id = "<subnet ID>"
            }
          }

          security_group_ids = [ "<security group list>" ]

          host {
            name = "<host name>"
            zone = "<availability zone>"
            type = "<host role: DATA_NODE or MASTER_NODE>"
            assign_public_ip = <public access to host: true or false>
            subnet_id = "<subnet ID>"
          }
       
        resource "yandex_vpc_network" "<network name>" { name = "<network name>" }

        resource "yandex_vpc_subnet" "<subnet name>" {
          name           = "<subnet name>"
          zone           = "<availability zone>"
          network_id     = "<network ID>"
          v4_cidr_blocks = ["<range>"]
        }
        ```

        {% endif %}

        {% if product == "cloud-il" %}

        ```hcl
        terraform {
          required_providers {
            yandex = {
              source = "yandex-cloud/yandex"
            }
          }
        }

        provider "yandex" {
          endpoint  = "{{ api-host }}:443"
          token     = "<static key of the service account>"
          cloud_id  = "<cloud ID>"
          folder_id = "<folder ID>"
          zone      = "<availability zone>"
        }

        resource "yandex_mdb_elasticsearch_cluster" "<cluster name>" {
          name        = "<cluster name>"
          environment = "<environment: PRESTABLE or PRODUCTION>"
          network_id  = "<network ID>"

          config {
            version = "<(optional) {{ ES }} version>"
            edition = "<(optional) {{ ES }} edition : basic, gold, or platinum>"

            admin_password = "<user admin password>"

            data_node {
              resources {
                resource_preset_id = "<host class>"
                disk_type_id       = "<storage type>"
                disk_size          = <storage size, GB>
              }
            }

            master_node {
              resources {
                resource_preset_id = "<host class>"
                disk_type_id       = "<storage type>"
                disk_size          = <storage size, GB>
              }
        
              plugins = [ "<list of plugin names>" ]

            security_group_ids = [ "<list of security groups>" ]
        
            host {
              name = "<host name>"
              zone = "<availability zone>"
              type = "<host role: DATA_NODE or MASTER_NODE>"
              assign_public_ip = <public access to the host: true or false>
              subnet_id = "<subnet ID>"
            }
          }

          security_group_ids = [ "<security group list>" ]

          host {
            name = "<host name>"
            zone = "<availability zone>"
            type = "<host role: DATA_NODE or MASTER_NODE>"
            assign_public_ip = <public access to host: true or false>
            subnet_id = "<subnet ID>"
          }
       
        resource "yandex_vpc_network" "<network name>" { name = "<network name>" }

        resource "yandex_vpc_subnet" "<subnet name>" {
          name           = "<subnet name>"
          zone           = "<availability zone>"
          network_id     = "<network ID>"
          v4_cidr_blocks = ["<range>"]
        }
        ```

        {% endif %}

        1. {% include [maintenance-window](../../_includes/mdb/mes/terraform/maintenance-window.md) %}

        For more information about the resources you can create using Terraform, see the [{{ TF }} provider documentation]({{ tf-provider-mes }}).

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Create a cluster.

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API

  To create a cluster, use the [create](../api-ref/Cluster/create.md) API method and pass the following in the request:
    * The ID of the folder where the cluster should be placed in the `folderId` parameter.
    * The cluster name in the `name` parameter.
    * The {{ ES }} version in the `configSpec.version` parameter.
    * The {{ ES }} edition in the `configSpec.edition` parameter.
    * Cluster configuration in the `configSpec` parameter, including:
        * Class of hosts with the _Master node_ role, in the `configSpec.elasticsearchSpec.masterNode.resources` parameter. If you don't want to create dedicated hosts with the _Master node_ role, don't set values for the group of `configSpec.elasticsearchSpec.masterNode` parameters.
        * Class of hosts with the _Data node_ role, in the `configSpec.elasticsearchSpec.dataNode.resources` parameter.
    * Configuration of the cluster hosts, in one or more `hostSpecs` parameters.
    * Network ID, in the `networkId` parameter.
    * Security group IDs in the parameter `securityGroupIds`.
    * Plugin list in the `configSpec.elasticsearchSpec.plugins` parameter.
    * {% include [maintenance-window](../../_includes/mdb/api/maintenance-window.md) %}

{% endlist %}

{% note warning %}

If you specified a security group ID when you created the cluster, some additional [security group configuration](cluster-connect.md#configuring-security-groups) may be required before you can connect to it.

{% endnote %}

## Examples {#examples}

### Creating a single-host cluster {#creating-a-single-host-cluster}

{% list tabs %}

- CLI

   To create a cluster with a single host, pass a single `--host` parameter.

    Let's say we need to create a {{ ES }} cluster with the following characteristics:
    * Name `my-es-clstr`.
    * Version `{{ versions.cli.latest }}`.
    * Edition `Platinum`.
    * Environment `PRODUCTION`.
    * Network `default`.
    * The security group with the ID `enpp2s8l3irhk5eromd7`.
    * One publicly available `{{ host-class }}`-class _Data node_ host in the `{{ subnet-id }}` subnet, in the `{{ region-id }}-a` availability zone.
    * With 20 GB of SSD network storage (`{{ disk-type-example }}`).
    * The `esadminpwd` password for the `admin` user.
    * Accidental cluster deletion protection.

   Run the command:

    ```bash
    {{ yc-mdb-es }} cluster create \
      --name my-es-clstr \
      --environment production \
      --network-name default \
      --host zone-id={{ region-id }}-a,assign-public-ip=true,type=datanode \
      --datanode-resource-preset {{ host-class }} \
      --datanode-disk-type={{ disk-type-example }} \
      --datanode-disk-size=20 \
      --admin-password=esadminpwd \
      --security-group-ids enpp2s8l3irhk5eromd7 \
      --version {{ versions.cli.latest }} \
      --edition platinum \
      --deletion-protection=true
    ```

- Terraform

    Let's say we need to create a {{ ES }} cluster with the following characteristics:
    * Name `my-es-clstr`.
    * Version `{{ versions.tf.latest }}`.
    * Edition `Basic`.
    * Environment `PRODUCTION`.
    * The cloud with the `{{ tf-cloud-id }}` ID.
    * The folder with the `{{ tf-folder-id }}` ID.
    * The new network `mynet`.
    * The `es-sg` security group created to enable online connections to the cluster over ports 443 (Kibana) and 9200 ({{ ES }}).
    * One publicly available  `{{ host-class }}`-class _Data node_ host in the new subnet `mysubnet`, in the `{{ region-id }}-a` availability zone. The `mysubnet` subnet will have the range `10.5.0.0/24`.
    * With 20 GB of SSD network storage (`{{ disk-type-example }}`).
    * The `esadminpwd` password for the `admin` user.

   The configuration file for the cluster looks like this:

   {% if product == "yandex-cloud" %}

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
     zone      = "{{ region-id }}-a"
   }

   resource "yandex_mdb_elasticsearch_cluster" "my-es-clstr" {
     name        = "my-es-clstr"
     environment = "PRODUCTION"
     network_id  = yandex_vpc_network.mynet.id

     config {
       edition = "basic"
       version = "{{ versions.tf.latest }}"

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
       zone = "ru-central1-a"
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
     zone           = "{{ region-id }}-a"
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

   {% endif %}

   {% if product == "cloud-il" %}

   ```hcl
   terraform {
     required_providers {
       yandex = {
         source = "yandex-cloud/yandex"
       }
     }
   }

   provider "yandex" {
     endpoint  = "{{ api-host }}:443"
     token     = "<static key of the service account>"
     cloud_id  = "{{ tf-cloud-id }}"
     folder_id = "{{ tf-folder-id }}"
     zone      = "{{ region-id }}-a"
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
       zone = "{{ region-id }}-a"
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
     zone           = "{{ region-id }}-a"
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

  {% endif %}

{% endlist %}

