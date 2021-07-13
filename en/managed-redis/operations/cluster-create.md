# Creating {{ RD }} clusters

{{ RD }} clusters are one or more database hosts that replication can be configured between. Replication is enabled by default in any cluster consisting of more than one host: the master host accepts write requests and asynchronously duplicates changes on replicas.

The number of hosts that can be created together with a {{ RD }} cluster depends on the host type selected:

* In a cluster with **high-memory** hosts, you can create an unlimited number of hosts (from 1 to the current maximum [quota](../concepts/limits.md)).

* In a cluster with **burstable** hosts, you can create only one host.

## How to create a {{ RD }} cluster {#create-cluster}

{% list tabs %}

- Management console

  1. In the management console, select the folder where you want to create a DB cluster.

  1. Select **{{ mrd-name }}**.

  1. Click **Create cluster**.

  1. Enter a name for the cluster in the **Cluster name** field. The cluster name must be unique within the folder.

  1. Select the environment where you want to create the cluster (you can't change the environment once the cluster is created):
      - `PRODUCTION`: For stable versions of your apps.
      - `PRESTABLE`: For testing, including the {{ mrd-short-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.

  1. Select the DBMS version.

  1. If necessary, enable [cluster sharding](../concepts/sharding.md).

     {% note warning %}

     You can only enable sharding when you create a new cluster. You can't shard an existing non-sharded cluster or disable sharding for a cluster that it's enabled for.

     {% endnote %}

  1. If necessary, enable support for encrypted TLS/SSL connections to the cluster (for {{ RD }} version 6 or higher).

     {% note warning %}

     You can only enable connection encryption when creating a new cluster. You can't disable encryption for a cluster that it's enabled for.

     {% endnote %}

  1. Set up a [host class](../concepts/instance-types.md) for the cluster:
      - Select the host type: it defines the [guaranteed vCPU performance](../../compute/concepts/performance-levels.md). **High-memory** hosts allow full core usage, whereas **burstable** hosts only a portion.
      - Select the amount of RAM for the host.
      - Select the disk size. The available disk size depends on the amount of RAM and is limited by [quotas and limits](../concepts/limits.md#limits). The minimum disk size is twice the selected amount of RAM, while the maximum disk size is 8 times the selected amount of RAM.
  1. In **Cluster settings** under **Password**, set the user password (from 8 to 128 characters).
  1. Under **Network settings**, select the cloud network to host the cluster in and security groups for cluster network traffic. You may need to additionally [set up the security groups](connect.md#configuring-security-groups) to connect to the cluster.
  1. Under **Hosts**, click **Add host** and select the availability zone and subnet to connect the host to. Create the necessary number of hosts. To change the availability zone and the added host, click the pencil icon in the host line.

     If you enabled sharding, enter names for the shards.

  1. If necessary, configure additional cluster settings:

     {% include [mrd-extra-settings](../../_includes/mdb/mrd-extra-settings-web-console.md) %}

  1. If necessary, configure the [DBMS settings](../concepts/settings-list.md).

  1. Click **Create cluster**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a cluster:

  {% if audience != "internal" %}

  1. Check whether the folder has any subnets for the cluster hosts:

     ```
     $ yc vpc subnet list
     ```

     If there are no subnets in the folder, [create the necessary subnets](../../vpc/operations/subnet-create.md) in {{ vpc-short-name }}.

  {% endif %}

  1. View a description of the CLI create cluster command:

      ```
      $ {{ yc-mdb-rd }} cluster create --help
      ```

  1. When you create a cluster from the CLI, you can't explicitly specify the host type and amount of RAM. Choose the applicable [host class](../concepts/instance-types.md) instead. To see what host classes are available, run the command:

     ```
     $ {{ yc-mdb-rd }} resource-preset list
     ```

  1. Specify the cluster parameters in the create command (only some of the supported flags are given in the example):

      ```bash
      $ {{ yc-mdb-rd }} cluster create \
         --name <cluster name> \
         --environment <prestable or production> \
         --network-name <network name> \
         --host zone-id=<availability zone>,subnet-id=<subnet ID> \
         --security-group-ids <list of security group IDs> \
         --enable-tls \
         --resource-preset <host class> \
         --disk-size <storage size in GB> \
         --password=<user password> \
         --backup-window-start <backup start time in HH:MM:SS format>
      ```

      The subnet ID `subnet-id` should be specified if the selected availability zone contains two or more subnets.

- API

  To create a cluster, use the [create](../api-ref/Cluster/create.md) API method and pass the following in the request:
  * In the `folderId` parameter, the ID of the folder where the cluster should be placed.
  * The cluster name, in the `name` parameter.
  * Security group IDs in the parameter `securityGroupIds`.
  * The `tlsEnabled=true` flag to create a cluster with support for encrypted TLS/SSL connections (for {{ RD }} version 6 or higher).

- Terraform

  {% include [terraform-definition](../../solutions/_solutions_includes/terraform-definition.md) %}

  If you don't have {{ TF }}, [install it and configure the provider](../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  To create a cluster:

    1. In the configuration file, describe the parameters of resources that you want to create:
       * Database cluster: Description of the cluster and its hosts. If necessary, you can also configure the [DBMS settings](../concepts/settings-list.md#dbms-settings) here.
       * Network: Description of the [cloud network](../../vpc/concepts/network.md#network) where the cluster will be located. If you already have a suitable network, you don't need to describe it again.
       * Subnets: Description of the [subnets](../../vpc/concepts/network.md#network) to connect the cluster hosts to. If you already have suitable subnets, you don't need to describe them again.

       Sample configuration file structure for creating clusters with TLS support:

       ```hcl
       terraform {
         required_providers {
           yandex = {
             source = "yandex-cloud/yandex"
           }
         }
       }
       
       provider "yandex" {
         token = "<OAuth or static key of service account>"
         cloud_id  = "<cloud ID>"
         folder_id = "<folder ID>"
         zone      = "<availability zone>"
       }
       
       resource "yandex_mdb_redis_cluster" "<cluster name>" {
         name               = "<cluster name>"
         environment        = "<PRESTABLE or PRODUCTION>"
         network_id         = "<network ID>"
         security_group_ids = [ "<security group IDs>" ]
         tls_enabled        = true
         sharded            = <sharding: true or false>
       
         config {
           password = "<password>"
           version  = "<Redis version: 5.0 or 6.0>"
         }
       
         resources {
           resource_preset_id = "<host class>"
           disk_type_id       = "<storage type>"
           disk_size          = <storage size in GB>
         }
       
         host {
           zone      = "<availability zone>"
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

       For more information about the resources you can create using {{ TF }}, see the [provider's documentation]({{ tf-provider-mrd }}).

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Create a cluster.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       After this, all the necessary resources will be created in the specified folder and the IP addresses of the VMs will be displayed in the terminal. You can check resource availability and their settings in [management console]({{ link-console-main }}).

{% endlist %}

{% note warning %}

If you specified security group IDs when creating a cluster, you may also need to [re-configure security groups](connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}

## Examples {#examples}

### Creating a single-host cluster {#creating-a-single-host-cluster}

{% list tabs %}

- CLI

  To create a cluster with a single host, you should pass a single `--host` parameter.

  Let's say we need to create a {{ RD }} cluster with the following characteristics:
  - Named `myredis`.
  - With version `6.0`.
  - In the `production` environment.
  - In the `default` network.
  - With a single `hm1.nano` host in the `b0rcctk2rvtr8efcch64` subnet, the `{{ zone-id }}` availability zone, and the `{{ security-group }}` security group.
  - With support for TLS connections.
  - With a 16 GB fast network storage (`{{ disk-type-example }}`).
  - With the `user1user1` password.

  Run the command:

  ```
  $ {{ yc-mdb-rd }} cluster create \
       --name myredis \
       --redis-version 6.0 \
       --environment production \
       --network-name default \
       --resource-preset hm1.nano \
       --host zone-id={{ zone-id }},subnet-id=b0rcctk2rvtr8efcch64 \
       --security-group-ids {{ security-group }} \
       --enable-tls \
       --disk-type-id {{ disk-type-example }} \
       --disk-size 16 \
       --password=user1user1
  ```

- Terraform

  Let's say we need to create a {{ RD }} cluster and a network for it with the following characteristics:
    - Named `myredis`.
    - With version `6.0`.
    - In the `PRODUCTION` environment.
    - In the cloud with the ID `{{ tf-cloud-id }}`.
    - In the folder with the ID `{{ tf-folder-id }}`.
    - Network: `mynet`.
    - With 1 `{{ host-class }}` class host in the new `mysubnet` subnet and `{{ zone-id }}` availability zone. The `mysubnet` subnet will have the range `10.5.0.0/24`.
    - In the new `redis-sg` security group allowing connections through port `{{ port-mrd-tls }}` from any address in the `mysubnet` subnet.
    - With support for TLS connections.
    - With a 16 GB fast network storage (`{{ disk-type-example }}`).
    - With the `user1user1` password.

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
    token = "<OAuth or static key of service account>"
    cloud_id  = "{{ tf-cloud-id }}"
    folder_id = "{{ tf-folder-id }}"
    zone      = "{{ zone-id }}"
  }
  
  resource "yandex_mdb_redis_cluster" "myredis" {
    name               = "myredis"
    environment        = "PRODUCTION"
    network_id         = yandex_vpc_network.mynet.id
    security_group_ids = [ yandex_vpc_security_group.redis-sg.id ]
    tls_enabled        = true
  
    config {
      password = "user1user1"
      version  = "6.0"
    }
  
    resources {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 16
    }
  
    host {
      zone      = "{{ zone-id }}"
      subnet_id = yandex_vpc_subnet.mysubnet.id
    }
  }
  
  resource "yandex_vpc_network" "mynet" { name = "mynet" }
  
  resource "yandex_vpc_security_group" "redis-sg" {
    name       = "redis-sg"
    network_id = yandex_vpc_network.mynet.id
  
    ingress {
      description    = "Redis"
      port           = {{ port-mrd-tls }}
      protocol       = "TCP"
      v4_cidr_blocks = ["10.5.0.0/24"]
    }
  
    egress {
      description    = "Redis"
      port           = {{ port-mrd-tls }}
      protocol       = "TCP"
      v4_cidr_blocks = ["10.5.0.0/24"]
    }
  }
  
  resource  "yandex_vpc_subnet" "mysubnet" {
    name           = "mysubnet"
    zone           = "{{ zone-id }}"
    network_id     = yandex_vpc_network.mynet.id
    v4_cidr_blocks = ["10.5.0.0/24"]
  }
  ```

{% endlist %}

### Creating sharded clusters {#creating-a-sharded-cluster}

{% list tabs %}

* Terraform

    Let's say we need to create a [sharded](../concepts/sharding.md) {{RD}} cluster with the following characteristics:
    * Named `myredis`.
    * In the `PRODUCTION` environment.
    * In the cloud with the ID `{{ tf-cloud-id }}`.
    * In the folder with the ID `{{ tf-folder-id }}`.
    * Network: `mynet`.
    * With three subnets in the `mynet` network, one in each availability zone:
        * `subnet-a` with the `10.1.0.0/24` range.
        * `subnet-b` with the `10.2.0.0/24` range.
        * `subnet-c` with the `10.3.0.0/24` range.
    * With three hosts of the `{{ host-class }}` class, one in each subnet.
    * In the new `redis-sg` security group that allows connections through ports `{{ port-mrd }}` and `{{ port-mrd-sentinel }}` ([Redis Sentinel](./connect.md)) from any subnet address.
    * With a 16 GB fast network storage (`{{ disk-type-example }}`).
    * With the `user1user1` password.

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
      token = "<OAuth or static key of service account>"
      cloud_id  = "{{ tf-cloud-id }}"
      folder_id = "{{ tf-folder-id }}"
      zone      = "{{ zone-id }}"
    }
    
    resource "yandex_mdb_redis_cluster" "myredis" {
      name               = "myredis"
      environment        = "PRODUCTION"
      network_id         = yandex_vpc_network.mynet.id
      security_group_ids = [yandex_vpc_security_group.redis-sg.id]
      sharded            = true
    
      config {
        password = "user1user1"
      }
    
      resources {
        resource_preset_id = "{{ host-class }}"
        disk_type_id       = "{{ disk-type-example }}"
        disk_size          = 16
      }
    
      host {
        zone       = "ru-central1-a"
        subnet_id  = yandex_vpc_subnet.subnet-a.id
        shard_name = "shard1"
      }
    
      host {
        zone       = "ru-central1-b"
        subnet_id  = yandex_vpc_subnet.subnet-b.id
        shard_name = "shard2"
      }
    
      host {
        zone       = "ru-central1-c"
        subnet_id  = yandex_vpc.subnet.subnet-c.id
        shard_name = "shard3"
      }
    }
    
    resource "yandex_vpc_network" "mynet" { name = "mynet" }
    
    resource "yandex_vpc_subnet" "subnet-a" {
      name           = "subnet-a"
      zone           = "ru-central1-a"
      network_id     = yandex_vpc_network.mynet.id
      v4_cidr_blocks = ["10.1.0.0/24"]
    }
    
    resource "yandex_vpc_subnet" "subnet-b" {
      name           = "subnet-b"
      zone           = "ru-central1-b"
      network_id     = yandex_vpc_network.mynet.id
      v4_cidr_blocks = ["10.2.0.0/24"]
    }
    
    resource "yandex_vpc_subnet" "subnet-c" {
      name           = "subnet-c"
      zone           = "ru-central1-c"
      network_id     = yandex_vpc_network.mynet.id
      v4_cidr_blocks = ["10.3.0.0/24"]
    }
    
    resource "yandex_vpc_security_group" "redis-sg" {
      name       = "redis-sg"
      network_id = yandex_vpc_network.mynet.id
    
      ingress {
        description    = "Redis"
        port           = {{ port-mrd }}
        protocol       = "TCP"
        v4_cidr_blocks = [
          "10.1.0.0/24",
          "10.2.0.0/24",
          "10.3.0.0/24"
        ]
      }
    
      egress {
        description    = "Redis"
        port           = {{ port-mrd }}
        protocol       = "TCP"
        v4_cidr_blocks = [
          "10.1.0.0/24",
          "10.2.0.0/24",
          "10.3.0.0/24"
        ]
      }
    
      ingress {
        description    = "Redis Sentinel"
        port           = {{ port-mrd-sentinel }}
        protocol       = "TCP"
        v4_cidr_blocks = [
          "10.1.0.0/24",
          "10.2.0.0/24",
          "10.3.0.0/24"
        ]
      }
    
      egress {
        description    = "Redis Sentinel"
        port           = {{ port-mrd-sentinel }}
        protocol       = "TCP"
        v4_cidr_blocks = [
          "10.1.0.0/24",
          "10.2.0.0/24",
          "10.3.0.0/24"
        ]
      }
    }
    ```

{% endlist %}
