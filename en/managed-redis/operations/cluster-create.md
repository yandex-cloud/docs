# Creating {{ RD }} clusters

{{ RD }} clusters are one or more database hosts that replication can be configured between. Replication is enabled by default in any cluster consisting of more than one host: the master host accepts write requests and asynchronously duplicates changes on replicas.

For more about {{ mrd-name }} cluster structure, see [{#T}](../concepts/index.md).

{% note info %}

* The number of hosts you can create together with a {{ RD }} cluster depends on the selected {% if audience != "internal" %}[storage type](../concepts/storage.md#storage-type-selection){% else %}[storage type](../concepts/storage.md){% endif %} and [host class](../concepts/instance-types.md#available-flavors), as well as on whether [sharding](../concepts/sharding.md) is enabled.
* Available storage types [depend](../concepts/storage.md) on the selected [host class](../concepts/instance-types.md#available-flavors).

{% endnote %}

## How to create a {{ RD }} cluster {#create-cluster}

{% note info %}

As of June 1, 2022, {{ RD }} versions 5.0 and 6.0 will no longer be supported. For more information, see [{#T}](cluster-version-update.md#version-supported).

{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder to create a DB cluster in.

   1. Select **{{ mrd-name }}**.
   1. Click **Create cluster**.
   1. Under **Basic parameters**:

      * Name the cluster in the **Cluster name** field. The cluster name must be unique within the folder.
      * (Optional) Add a cluster description.
      * Select the environment where you want to create the cluster (you can't change the environment once the cluster is created):
         * `PRODUCTION`: For stable versions of your apps.
         * `PRESTABLE`: For testing, including the {{ mrd-short-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.
      * Select the DBMS version.
      * If necessary, enable [cluster sharding](../concepts/sharding.md).

         {% note warning %}

         You can only enable sharding when you create a new cluster. You can't shard an existing non-sharded cluster or disable sharding for a cluster that it's enabled for.

         {% endnote %}

      * Enable support for encrypted SSL connections to a cluster as required.

         {% note warning %}

         You can only enable connection encryption when creating a new cluster. You can't disable encryption for a cluster that it's enabled for.

         {% endnote %}

   1. Under **Host class**:

      * Choose a **Platform**.
      * Specify the **Type** of the VM to deploy hosts on.
      * Select a [host](../concepts/instance-types.md) configuration that defines the technical specifications of the VMs where the DB hosts will be deployed. Changing the configuration changes the properties of all the previously created hosts.

   1. Under **Storage size**:

      {% if audience != "internal" %}

      * Select the [storage type](../concepts/storage.md).
         * Either more flexible storage on network SSDs (`network-ssd`) or non-replicated SSDs (`network-ssd-nonreplicated`).
         * Or faster local SSD storage (`local-ssd`).

         {% include [storages-step-settings-no-ice-lake](../../_includes/mdb/settings-storages-no-v3.md) %}

      {% endif %}

      * Select the storage size. The available storage size is limited by [quotas and limits](../concepts/limits.md#mrd-limits).

   1. In **Cluster settings** under **Password**, set the user password (from 8 to 128 characters).
   1. Under **Network settings**, select the cloud network to host the cluster in and security groups for cluster network traffic. You may also need to [set up security groups](connect/index.md#configuring-security-groups) to connect to the cluster.
   1. Under **Hosts**:

      * To change host settings, click the ![pencil](../../_assets/pencil.svg) icon in the row next to its name.

         * **Availability zone**: Select an {% if audience != "internal" %}[availability zone](../../overview/concepts/geo-scope.md){% else %}availability zone{% endif %}.
         * **Subnet**: Specify a {% if audience != "internal" %}[subnet](../../vpc/concepts/network.md#subnet){% else %}subnet{% endif %} in the selected availability zone.
         * **Public access**: Enable access to the host from the internet if the cluster is created with **TLS support** activated.
         * **Shard name**: Enables you to change the shard name for the host. The field is only available if the cluster is created with **Cluster sharding** enabled.

      * To add hosts to the cluster, click **Add host**.

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
      yc vpc subnet list
      ```

      If there are no subnets in the folder, [create the necessary subnets](../../vpc/operations/subnet-create.md) in {{ vpc-short-name }}.

   {% endif %}

   1. View a description of the CLI's create cluster command:

      ```
      {{ yc-mdb-rd }} cluster create --help
      ```

   1. When you create a cluster from the CLI, you can't explicitly specify the host type and amount of RAM. Choose the applicable [host class](../concepts/instance-types.md) instead. To see what host classes are available, run the command:

      ```
      {{ yc-mdb-rd }} resource-preset list
      ```

   1. Specify the cluster parameters in the create command (only some of the supported flags are given in the example):

      ```bash
      {{ yc-mdb-rd }} cluster create \
        --name <cluster name> \
        --environment <environment, prestable or production> \
        --network-name <network name> \
        --host zone-id=<availability zone>,subnet-id=<subnet ID> \
        --security-group-ids <list of security group IDs> \
        --enable-tls \
        --resource-preset <host class> \
        --disk-size <storage size in GB> \
        --password=<user password> \
        --backup-window-start <backup start time in HH:MM:SS format>
        --deletion-protection=<protection against deleting a cluster: true or false>
      ```

      The subnet ID `subnet-id` should be specified if the selected availability zone contains two or more subnets.

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}
   {% if audience != "internal" %}

   If you don't have {{ TF }}, [install it and configure the provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% else %}

   If you don't have {{ TF }}, install it and configure the provider.

   {% endif %}

   To create a cluster:

   1. In the configuration file, describe the parameters of resources that you want to create:

      * Database cluster: Description of the cluster and its hosts. You can also configure [DBMS settings](../concepts/settings-list.md) here if necessary.

      {% if audience != "internal" %}

      * Network: A description of the [cloud network](../../vpc/concepts/network.md#network) where the cluster will be hosted. If you already have a suitable network, you don't need to describe it again.
      * Subnets: The [subnets](../../vpc/concepts/network.md#network) to connect the cluster hosts to. If you already have suitable subnets, you don't need to describe them again.

      {% else %}

      * Network: The cloud network where the cluster will reside. If you already have a suitable network, you don't need to describe it again.
      * Subnets: The subnets to connect the cluster hosts to. If you already have suitable subnets, you don't need to describe them again.

      {% endif %}

      Sample configuration file structure for creating clusters with SSL support:

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
        token     = "<service account OAuth or static key>"
        cloud_id  = "<cloud ID>"
        folder_id = "<folder ID>"
        zone      = "<availability zone>"
      }

      resource "yandex_mdb_redis_cluster" "<cluster name>" {
        name                = "<cluster name>"
        environment         = "<environment: PRESTABLE or PRODUCTION>"
        network_id          = "<network ID>"
        security_group_ids  = [ "<IDs of security groups>" ]
        tls_enabled         = true
        sharded             = <sharding: true or false>
        deletion_protection = <protection from cluster deletion: true or false>

        config {
          password = "<password>"
          version  = "<version {{ RD }}:{{ versions.tf.str }}>"
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
        token     = "<service account static key>"
        cloud_id  = "<cloud ID>"
        folder_id = "<folder ID>"
        zone      = "<availability zone>"
      }

      resource "yandex_mdb_redis_cluster" "<cluster name>" {
        name                = "<cluster name>"
        environment         = "<environment: PRESTABLE or PRODUCTION>"
        network_id          = "<network ID>"
        security_group_ids  = [ "<IDs of security groups>" ]
        tls_enabled         = true
        sharded             = <sharding: true or false>
        deletion_protection = <cluster deletion protection: true or false>

        config {
          password = "<password>"
          version  = "<version {{ RD }}: {{ versions.tf.str }}>"
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

      {% endif %}

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

      1. {% include [Maintenance window](../../_includes/mdb/mrd/terraform/maintenance-window.md) %}

      For more details about resources that you can create using {{ TF }}, see [the provider's documentation]({{ tf-provider-mrd }})

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Create a cluster.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      After this, all the necessary resources will be created in the specified folder and the IP addresses of the VMs will be displayed in the terminal. You can check that the resources are there with the correct settings, using the [management console]({{ link-console-main }}).

      {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API

   Use the [create](../api-ref/Cluster/create.md) API method and pass the following information in the request:
   * In the `folderId` parameter, the ID of the folder where the cluster should be placed.
   * The cluster name in the `name` parameter.
   * Security group identifiers, in the `securityGroupIds` parameter.
   * The `tlsEnabled=true` flag for creating clusters with encrypted SSL support.

{% endlist %}

{% note warning %}

If you specified security group IDs when creating a cluster, you may also need to [configure security groups](connect/index.md#configuring-security-groups) to connect to the cluster.

{% endnote %}

## Examples {#examples}

### Creating a single-host cluster {#creating-a-single-host-cluster}

{% list tabs %}

- CLI

   To create a cluster with a single host, pass a single `--host` parameter.

   Let's say we need to create a {{ RD }} cluster with the following characteristics:

   * Named `myredis`.
   * Version `{{ versions.cli.latest }}`.
   * Environment `production`.
   * Network `default`.
   * With a single `hm1.nano` host in the `b0rcctk2rvtr8efcch64` subnet, the `{{ zone-id }}` availability zone, and the `{{ security-group }}` security group.
   * With SSL support.
   * With 16 GB of SSD network storage (`{{ disk-type-example }}`).
   * With the `user1user1` password.
   * With protection against accidental cluster deletion.

   Run the command:

   ```bash
   {{ yc-mdb-rd }} cluster create \
     --name myredis \
     --redis-version {{ versions.cli.latest }} \
     --environment production \
     --network-name default \
     --resource-preset hm1.nano \
     --host zone-id={{ zone-id }},subnet-id=b0rcctk2rvtr8efcch64 \
     --security-group-ids {{ security-group }} \
     --enable-tls \
     --disk-type-id {{ disk-type-example }} \
     --disk-size 16 \
     --password=user1user1 \
     --deletion-protection=true
   ```

- {{ TF }}

   Let's say we need to create a {{ RD }} cluster and a network for it with the following characteristics:

   * Named `myredis`.
   * Version `{{ versions.tf.latest }}`.
   * Environment `PRODUCTION`.
   * Cloud with the `{{ tf-cloud-id }}` ID.
   * Folder with the `{{ tf-folder-id }}` ID.
   * New network `mynet`.
   * With a single `{{ host-class }}` host in the new subnet `mysubnet` and `{{ zone-id }}` availability zone. The `mysubnet` subnet will have a range of `10.5.0.0/24`.
   * In the new `redis-sg` security group allowing connections through port `{{ port-mrd-tls }}` from any addresses in the `mysubnet` subnet.
   * With SSL support.
   * With 16 GB of SSD network storage (`{{ disk-type-example }}`).
   * With the `user1user1` password.
   * With protection against accidental cluster deletion.

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
     token     = "<service account OAuth or static key>"
     cloud_id  = "{{ tf-cloud-id }}"
     folder_id = "{{ tf-folder-id }}"
     zone      = "{{ zone-id }}"
   }

   resource "yandex_mdb_redis_cluster" "myredis" {
     name                = "myredis"
     environment         = "PRODUCTION"
     network_id          = yandex_vpc_network.mynet.id
     security_group_ids  = [ yandex_vpc_security_group.redis-sg.id ]
     tls_enabled         = true
     deletion_protection = true

     config {
       password = "user1user1"
       version  = "{{ versions.tf.latest }}"
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
     token     = "<service account static key>"
     cloud_id  = "{{ tf-cloud-id }}"
     folder_id = "{{ tf-folder-id }}"
     zone      = "{{ zone-id }}"
   }

   resource "yandex_mdb_redis_cluster" "myredis" {
     name                = "myredis"
     environment         = "PRODUCTION"
     network_id          = yandex_vpc_network.mynet.id
     security_group_ids  = [ yandex_vpc_security_group.redis-sg.id ]
     tls_enabled         = true
     deletion_protection = true

     config {
       password = "user1user1"
       version  = "{{ versions.tf.latest }}"
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

   resource "yandex_vpc_subnet" "mysubnet" {
     name           = "mysubnet"
     zone           = "{{ zone-id }}"
     network_id     = yandex_vpc_network.mynet.id
     v4_cidr_blocks = ["10.5.0.0/24"]
   }
   ```

   {% endif %}

{% endlist %}

### Creating sharded clusters {#creating-a-sharded-cluster}

{% list tabs %}

- {{ TF }}

   Let's say we need to create a [sharded](../concepts/sharding.md) {{ RD }} cluster with the following characteristics:

   * Named `myredis`.
   * Environment `PRODUCTION`.
   * Cloud with the `{{ tf-cloud-id }}` ID.
   * Folder with the `{{ tf-folder-id }}` ID.
   * New network `mynet`.
   * With three subnets in the `mynet` network, one in each availability zone:
      * `subnet-a` with the `10.1.0.0/24` range.
      * `subnet-b` with the `10.2.0.0/24` range.
      * `subnet-c` with the `10.3.0.0/24` range.
   * With three hosts of the `{{ host-class }}` class, one in each subnet.
   * In the new `redis-sg` security group allowing connections through ports `{{ port-mrd }}` and `{{ port-mrd-sentinel }}` ([Redis Sentinel](./connect/index.md)) from any subnet address.
   * With 16 GB of SSD network storage (`{{ disk-type-example }}`).
   * With the `user1user1` password.
   * With protection against accidental cluster deletion.

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
     token     = "<service account OAuth or static key>"
     cloud_id  = "{{ tf-cloud-id }}"
     folder_id = "{{ tf-folder-id }}"
     zone      = "{{ zone-id }}"
   }

   resource "yandex_mdb_redis_cluster" "myredis" {
     name                = "myredis"
     environment         = "PRODUCTION"
     network_id          = yandex_vpc_network.mynet.id
     security_group_ids  = [yandex_vpc_security_group.redis-sg.id]
     sharded             = true
     deletion_protection = true

     config {
       password = "user1user1"
     }

     resources {
       resource_preset_id = "{{ host-class }}"
       disk_type_id       = "{{ disk-type-example }}"
       disk_size          = 16
     }

     host {
       zone       = "{{ region-id }}-a"
       subnet_id  = yandex_vpc_subnet.subnet-a.id
       shard_name = "shard1"
     }

     host {
       zone       = "{{ region-id }}-b"
       subnet_id  = yandex_vpc_subnet.subnet-b.id
       shard_name = "shard2"
     }

     host {
       zone       = "{{ region-id }}-c"
       subnet_id  = yandex_vpc.subnet.subnet-c.id
       shard_name = "shard3"
     }
   }

   resource "yandex_vpc_network" "mynet" { name = "mynet" }

   resource "yandex_vpc_subnet" "subnet-a" {
     name           = "subnet-a"
     zone           = "{{ region-id }}-a"
     network_id     = yandex_vpc_network.mynet.id
     v4_cidr_blocks = ["10.1.0.0/24"]
   }

   resource "yandex_vpc_subnet" "subnet-b" {
     name           = "subnet-b"
     zone           = "{{ region-id }}-b"
     network_id     = yandex_vpc_network.mynet.id
     v4_cidr_blocks = ["10.2.0.0/24"]
   }

   resource "yandex_vpc_subnet" "subnet-c" {
     name           = "subnet-c"
     zone           = "{{ region-id }}-c"
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
     token     = "<service account static key>"
     cloud_id  = "{{ tf-cloud-id }}"
     folder_id = "{{ tf-folder-id }}"
     zone      = "{{ zone-id }}"
   }

   resource "yandex_mdb_redis_cluster" "myredis" {
     name                = "myredis"
     environment         = "PRODUCTION"
     network_id          = yandex_vpc_network.mynet.id
     security_group_ids  = [yandex_vpc_security_group.redis-sg.id]
     sharded             = true
     deletion_protection = true

     config {
       password = "user1user1"
     }

     resources {
       resource_preset_id = "{{ host-class }}"
       disk_type_id       = "{{ disk-type-example }}"
       disk_size          = 16
     }

     host {
       zone       = "{{ region-id }}-a"
       subnet_id  = yandex_vpc_subnet.subnet-a.id
       shard_name = "shard1"
     }

     host {
       zone       = "{{ region-id }}-b"
       subnet_id  = yandex_vpc_subnet.subnet-b.id
       shard_name = "shard2"
     }

     host {
       zone       = "{{ region-id }}-c"
       subnet_id  = yandex_vpc.subnet.subnet-c.id
       shard_name = "shard3"
     }
   }

   resource "yandex_vpc_network" "mynet" { name = "mynet" }

   resource "yandex_vpc_subnet" "subnet-a" {
     name           = "subnet-a"
     zone           = "{{ region-id }}-a"
     network_id     = yandex_vpc_network.mynet.id
     v4_cidr_blocks = ["10.1.0.0/24"]
   }

   resource "yandex_vpc_subnet" "subnet-b" {
     name           = "subnet-b"
     zone           = "{{ region-id }}-b"
     network_id     = yandex_vpc_network.mynet.id
     v4_cidr_blocks = ["10.2.0.0/24"]
   }

   resource "yandex_vpc_subnet" "subnet-c" {
     name           = "subnet-c"
     zone           = "{{ region-id }}-c"
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

   {% endif %}

{% endlist %}
