---
title: "How to create a {{ RD }} cluster"
description: "Use this tutorial to create a {{ RD }} cluster with a single or multiple DB hosts."
---

# Creating a {{ RD }} cluster


A {{ RD }} cluster is one or more database hosts between which you can configure replication. Replication is enabled by default in any cluster consisting of more than one host: the master host accepts write requests and asynchronously duplicates changes on replicas.

For more about {{ mrd-name }} cluster structure, see [{#T}](../concepts/index.md).

{% note info %}

* The number of hosts you can create together with a {{ RD }} cluster depends on the selected [disk type](../concepts/storage.md#storage-type-selection) and [host class](../concepts/instance-types.md#available-flavors) as well as on whether [sharding](../concepts/sharding.md) is enabled.
* Available disk types [depend](../concepts/storage.md) on the selected [host class](../concepts/instance-types.md).

{% endnote %}

## Creating a cluster {#create-cluster}

{% list tabs group=instructions %}

- Management console {#console}


   1. In the [management console]({{ link-console-main }}), go to the folder to create a DB cluster in.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
   1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:

      * Enter a name for the cluster in the **{{ ui-key.yacloud.mdb.forms.base_field_name }}** field. It must be unique within the folder.
      * (Optional) Add a cluster description.
      * Select the environment where you want to create the cluster (you cannot change the environment once the cluster is created):
         * `PRODUCTION`: For stable versions of your apps.
         * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.
      * Select the DBMS version.
      * If necessary, enable [cluster sharding](../concepts/sharding.md).

         {% note warning %}

         You can only enable sharding when you create a new cluster. You cannot shard an existing non-sharded cluster or disable sharding for a cluster that it is enabled for.

         {% endnote %}

      * If required, enable support for encrypted SSL connections to the cluster.

         {% note warning %}

         You can only enable connection encryption when creating a new cluster. You cannot disable encryption for a cluster that it is enabled for.

         {% endnote %}

   1. Under **{{ ui-key.yacloud.mdb.forms.section_resource }}**:

      * Select a platform in the **{{ ui-key.yacloud.mdb.forms.resource_presets_field-generation }}** field.
      * Specify the **{{ ui-key.yacloud.mdb.forms.resource_presets_field-type }}** of the VM to deploy hosts on.
      * Select a [host](../concepts/instance-types.md) configuration that defines the technical specifications of the VMs where the DB hosts will be deployed. Changing the configuration changes the properties of all the previously created hosts.

   1. Under **{{ ui-key.yacloud.mdb.forms.section_disk }}**:

      
      * Select the [disk type](../concepts/storage.md):
         * Either more flexible storage on network SSDs (`network-ssd`) or non-replicated SSDs (`network-ssd-nonreplicated`).
         * Or faster local SSD storage (`local-ssd`).

         {% include [storages-step-settings-no-hdd](../../_includes/mdb/settings-storages-no-hdd.md) %}




      * Select the storage size. The available storage size is limited by [quotas and limits](../concepts/limits.md#mrd-limits).

   1. Under **{{ ui-key.yacloud.mdb.forms.section_config }}**, in the **{{ ui-key.yacloud.mdb.forms.config_field_password }}** field, set the user password.

      {% include [requirements-to-password](../../_includes/mdb/mrd/requirements-to-password.md) %}

   
   1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**, select:
      * Cloud network for the cluster.
      * Security groups for the cluster network traffic. You may also need to [set up security groups](connect/index.md#configuring-security-groups) to connect to the cluster.


   1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**:

      * To change the settings of a host, click the ![pencil](../../_assets/console-icons/pencil.svg) icon in the line with its name.

         * **{{ ui-key.yacloud.mdb.forms.host_column_zone }}**: Select an [availability zone](../../overview/concepts/geo-scope.md).
         * **{{ ui-key.yacloud.mdb.forms.host_column_subnetwork }}**: Specify a [subnet](../../vpc/concepts/network.md#subnet) in the selected availability zone.
         * **{{ ui-key.yacloud.mdb.forms.host_column_assign_public_ip }}**: Enable access to the host from the internet if the cluster is created with **{{ ui-key.yacloud.redis.field_tls-support }}** activated.
         * **{{ ui-key.yacloud.mdb.forms.host_column_shard-name }}**: Enables you to change the shard name for the host. The field is only available if the cluster is created with the enabled **{{ ui-key.yacloud.mdb.forms.field_cluster-mode }}** setting.

      * To add hosts to the cluster, click **{{ ui-key.yacloud.mdb.forms.button_add-host }}**.

   1. Configure additional cluster settings, if required:

      {% include [mrd-extra-settings](../../_includes/mdb/mrd-extra-settings-web-console.md) %}

   1. Configure the [DBMS settings](../concepts/settings-list.md), if required.

   1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a cluster:

   
   1. Check whether the folder has any subnets for the cluster hosts:

      ```bash
      yc vpc subnet list
      ```

      If there are no subnets in the folder, [create the required subnets](../../vpc/operations/subnet-create.md) in {{ vpc-short-name }}.


   1. View a description of the create cluster CLI command:

      ```bash
      {{ yc-mdb-rd }} cluster create --help
      ```

   1. When you create a cluster from the CLI, you cannot explicitly specify the host type and amount of RAM. Choose the applicable [host class](../concepts/instance-types.md) instead. To see what host classes are available, run the command:

      ```bash
      {{ yc-mdb-rd }} resource-preset list
      ```

   1. Specify the cluster parameters in the create command (only some of the supported flags are given in the example):

      
      ```bash
      {{ yc-mdb-rd }} cluster create \
        --name <cluster_name> \
        --environment <environment> \
        --network-name <network_name> \
        --host zone-id=<availability_zone>,`
              `subnet-id=<subnet_ID>,`
              `assign-public-ip=<public_access>,`
              `replica-priority=<host_priority> \
        --security-group-ids <list_of_security_group_IDs> \
        --enable-tls \
        --resource-preset <host_class> \
        --disk-size <storage_size_in_GB> \
        --password=<user_password> \
        --backup-window-start <time> \
        --deletion-protection=<deletion_protection>
      ```


      Where:
      * `--environment`: `prestable` or `production`.

      
      * `--host`: Host parameters:
         * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
         * `subnet-id`: [Subnet ID](../../vpc/concepts/network.md#subnet). Specify if two or more subnets are created in the selected availability zone.
         * `assign-public-ip`: Internet access to the host via a public IP address, `true` or `false`.
         * `replica-priority`: Priority for selecting the host as a master if the [primary master fails](../concepts/replication.md#master-failover).


      * `--backup-window-start`: Backup start time in `HH:MM:SS` format.
      * `--deletion-protection`: Cluster deletion protection, `true` or `false`.

      You need to specify the `subnet-id` if the selected availability zone has two or more subnets.

      {% include [requirements-to-password](../../_includes/mdb/mrd/requirements-to-password.md) %}

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

      {% note info %}

      When creating a cluster, the `anytime` [maintenance](../concepts/maintenance.md) mode is set by default. You can set a specific maintenance period when [updating the cluster settings](update.md#change-additional-settings).

      {% endnote %}

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To create a cluster:

   1. In the configuration file, describe the parameters of the resources you want to create:

      * Database cluster: Description of the cluster and its hosts. You can also configure [DBMS settings](../concepts/settings-list.md) here if necessary.

      
      * Network: Description of the [cloud network](../../vpc/concepts/network.md#network) where the cluster will be hosted. If you already have a suitable network, you do not need to describe it again.
      * Subnets: [Subnets](../../vpc/concepts/network.md#network) to connect the cluster hosts to. If you already have suitable subnets, you do not need to describe them again.


      Sample configuration file structure for creating sharded clusters with SSL support:

      
      
      ```hcl
      resource "yandex_mdb_redis_cluster" "<cluster_name>" {
        name                = "<cluster_name>"
        environment         = "<environment>"
        network_id          = "<network_ID>"
        security_group_ids  = [ "<list_of_security_group_IDs>" ]
        tls_enabled         = true
        deletion_protection = <deletion_protection>

        config {
          password = "<password>"
          version  = "<{{ RD }}_version>"
        }

        resources {
          resource_preset_id = "<host_class>"
          disk_type_id       = "<disk_type>"
          disk_size          = <storage_size_in_GB>
        }

        host {
          zone             = "<availability_zone>"
          subnet_id        = "<subnet_ID>"
          assign_public_ip = <public_access>
          replica_priority = <host_priority>
        }
      }

      resource "yandex_vpc_network" "<network_name>" { name = "<network_name>" }

      resource "yandex_vpc_subnet" "<subnet_name>" {
        name           = "<subnet_name>"
        zone           = "<availability_zone>"
        network_id     = "<network_ID>"
        v4_cidr_blocks = ["<range>"]
      }
      ```




      Where:
      * `environment`: Environment, `PRESTABLE` or `PRODUCTION`.
      * `deletion_protection`: Cluster deletion protection, `true` or `false`.
      * `version`: {{ RD }} version, {{ versions.tf.str }}.
      * `host`: Host parameters:
         * `zone_id`: Availability zone.
         * `subnet_id`: ID of a subnet in the selected availability zone.
         * `assign_public_ip`: Public access to the host, `true` or `false`.
         * `replica_priority`: Host priority.

      {% include [requirements-to-password](../../_includes/mdb/mrd/requirements-to-password.md) %}

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

      {% include [Maintenance window](../../_includes/mdb/mrd/terraform/maintenance-window.md) %}

      For more information on resources that you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-mrd }}).

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Create a cluster.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      After this, all required resources will be created in the specified folder, and the [FQDNs of the cluster hosts](../concepts/network.md#hostname) will be displayed in the terminal. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

      {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API {#api}

   To create a {{ RD }} cluster, use the [create](../api-ref/Cluster/create.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Create](../api-ref/grpc/cluster_service.md#Create) gRPC API call and provide the following in the request:
   * ID of the folder where the cluster should be placed, in the `folderId` parameter.
   * Cluster name in the `name` parameter.
   * Security group IDs in the `securityGroupIds` parameter.
   * `tlsEnabled=true` flag for creating clusters with encrypted SSL support.
   * Settings of public access to hosts in the `hostSpecs[].assignPublicIp` parameter.

{% endlist %}


{% note warning %}

If you specified security group IDs when creating a cluster, you may also need to [configure security groups](connect/index.md#configuring-security-groups) to connect to the cluster.

{% endnote %}


## Creating a cluster copy {#duplicate}

You can create a {{ RD }} cluster with the settings of another cluster created earlier. To do so, you need to import the configuration of the source {{ RD }} cluster to {{ TF }}. Thus you can either create an identical copy or use the imported configuration as the baseline and modify it as needed. Importing is a convenient option when the source {{ RD }} cluster has lots of settings and you need to create a similar one.

To create a {{ RD }} cluster copy:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

   1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
   1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
   1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

   1. In the same working directory, place a `.tf` file with the following contents:

      ```hcl
      resource "yandex_mdb_redis_cluster" "old" { }
      ```

   1. Write the ID of the initial {{ RD }} cluster to the environment variable:

      ```bash
      export REDIS_CLUSTER_ID=<cluster_ID>
      ```

      You can request the ID with a [list of clusters in the folder](../../managed-redis/operations/cluster-list.md#list-clusters).

   1. Import the settings of the initial {{ RD }} cluster into the {{ TF }} configuration:

      ```bash
      terraform import yandex_mdb_redis_cluster.old ${REDIS_CLUSTER_ID}
      ```

   1. Get the imported configuration:

      ```bash
      terraform show
      ```

   1. Copy it from the terminal and paste it into the `.tf` file.
   1. Place the file in the new `imported-cluster` directory.
   1. Modify the copied configuration so that you can create a new cluster from it:

      * Specify a new cluster name in the `resource` string and the `name` parameter.
      * Delete the `created_at`, `health`, `id`, and `status` parameters.
      * In the `config` section, add the `password` parameter.
      * If the `config` section specifies the `notify_keyspace_events = "\"\""` parameter value, delete this parameter.
      * If `sharded = false`, delete the `shard_name` parameters in the `host` sections.
      * If the `maintenance_window` section specifies the `type = "ANYTIME"` parameter value, delete the `hour` parameter.
      * (Optional) Make further modifications if you are looking for more customization.

   1. In the `imported-cluster` directory, [get the authentication data](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials).

   1. In the same directory, [configure and initialize a provider](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). There is no need to create a provider configuration file manually, you can [download it](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).

   1. Place the configuration file in the `imported-cluster` directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). If you did not add the authentication credentials to environment variables, specify them in the configuration file.

   1. Check that the {{ TF }} configuration files are correct:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

   {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

{% endlist %}

## Examples {#examples}

### Creating a single-host cluster {#creating-a-single-host-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

   To create a cluster with a single host, provide a single `--host` parameter.

   Create a {{ mrd-name }} cluster with the following test characteristics:

   * Name: `myredis`
   * Version: `{{ versions.cli.latest }}`
   * Environment: `production`
   * Network: `default`
   * Single `hm1.nano` host in the `b0rcctk2rvtr********` subnet in the `{{ region-id }}-a` availability zone and security group with the `{{ security-group }}` ID with public access and a [host priority](../concepts/replication.md#master-failover) of `50`.
   * SSL support: Enabled
   * Network SSD storage (`{{ disk-type-example }}`): 16 GB
   * Password: `user1user1`
   * Protection against accidental cluster deletion: Enabled

   Run the following command:

   
   ```bash
   {{ yc-mdb-rd }} cluster create \
     --name myredis \
     --redis-version {{ versions.cli.latest }} \
     --environment production \
     --network-name default \
     --resource-preset hm1.nano \
     --host zone-id={{ region-id }}-a,subnet-id=b0rcctk2rvtr********,assign-public-ip=true,replica-priority=50 \
     --security-group-ids {{ security-group }} \
     --enable-tls \
     --disk-type-id {{ disk-type-example }} \
     --disk-size 16 \
     --password=user1user1 \
     --deletion-protection=true
   ```


- {{ TF }} {#tf}

   Create a {{ mrd-name }} cluster and a network for it with the following test characteristics:

   * Name: `myredis`
   * Version: `{{ versions.tf.latest }}`
   * Environment: `PRODUCTION`
   * Cloud ID: `{{ tf-cloud-id }}`
   * Folder ID: `{{ tf-folder-id }}`
   * New network: `mynet`
   * Single `{{ host-class }}` host in a new subnet named `mysubnet` in the `{{ region-id }}-a` availability zone with public access and a [host priority](../concepts/replication.md#master-failover) of `50`. The `mysubnet` subnet will have the `10.5.0.0/24` range.
   * In the new `redis-sg` security group allowing connections through port `{{ port-mrd-tls }}` from any addresses in the `mysubnet` subnet.
   * SSL support: Enabled
   * Network SSD storage (`{{ disk-type-example }}`): 16 GB
   * Password: `user1user1`
   * Protection against accidental cluster deletion: Enabled

   The configuration file for this cluster is as follows:

   
   
   ```hcl
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
       zone             = "{{ region-id }}-a"
       subnet_id        = yandex_vpc_subnet.mysubnet.id
       assign_public_ip = true
       replica_priority = 50
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
     zone           = "{{ region-id }}-a"
     network_id     = yandex_vpc_network.mynet.id
     v4_cidr_blocks = ["10.5.0.0/24"]
   }
   ```




{% endlist %}

### Creating sharded clusters {#creating-a-sharded-cluster}


{% list tabs group=instructions %}

- {{ TF }} {#tf}

   Create a [sharded](../concepts/sharding.md) {{ mrd-name }} cluster with the following test characteristics:

   * Name: `myredis`
   * Version: `{{ versions.tf.latest }}`
   * Environment: `PRODUCTION`
   * Cloud ID: `{{ tf-cloud-id }}`
   * Folder ID: `{{ tf-folder-id }}`
   * New network: `mynet`
   * Three subnets in the `mynet` network, one in each availability zone:
      * `subnet-a` with the `10.1.0.0/24` range.
      * `subnet-b` with the `10.2.0.0/24` range.
      * `subnet-d` with the `10.3.0.0/24` range.
   * Three `{{ host-class }}` hosts, one in each subnet.
   * In the new `redis-sg` security group allowing connections through ports `{{ port-mrd }}` and `{{ port-mrd-sentinel }}` ([Redis Sentinel](./connect/index.md)) from any subnet address.
   * Network SSD storage (`{{ disk-type-example }}`): 16 GB
   * Password: `user1user1`
   * Protection against accidental cluster deletion: Enabled

   The configuration file for this cluster is as follows:

   
   
   ```hcl
   resource "yandex_mdb_redis_cluster" "myredis" {
     name                = "myredis"
     environment         = "PRODUCTION"
     network_id          = yandex_vpc_network.mynet.id
     security_group_ids  = [yandex_vpc_security_group.redis-sg.id]
     sharded             = true
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
       zone       = "{{ region-id }}-d"
       subnet_id  = yandex_vpc.subnet.subnet-d.id
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

   resource "yandex_vpc_subnet" "subnet-d" {
     name           = "subnet-d"
     zone           = "{{ region-id }}-d"
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
