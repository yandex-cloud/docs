---
title: "How to create a {{ PG }} cluster"
description: "Use this tutorial to create a {{ PG }} cluster with a single or multiple DB hosts."
---

# Creating {{ PG }} clusters

A {{ PG }} cluster consists of one or more [database hosts](../concepts/index.md) you can configure [replication](../concepts/replication.md) between. Replication is enabled by default in any cluster consisting of more than one host: the master host accepts write requests and duplicates changes on replicas. The transaction is confirmed if the data is written to [disk](../concepts/storage.md) both on the master host and on a certain number of replicas sufficient to establish a quorum.

{% note info %}

* The number of hosts you can create together with a {{ PG }} cluster depends on the selected [disk type](../concepts/storage.md#storage-type-selection) and [host class](../concepts/instance-types.md#available-flavors).
* Available disk types depend on the selected [host class](../concepts/instance-types.md#available-flavors).
* If the DB storage is 95% full, the cluster switches to read-only mode. Plan and increase the required storage size in advance.

{% endnote %}

By default, {{ mpg-name }} sets the maximum number of connections to each {{ PG }} cluster host. This maximum cannot be greater than the value of [Max connections](../concepts/settings-list.md#setting-max-connections).

{% include [note-pg-user-connections.md](../../_includes/mdb/note-pg-user-connections.md) %}

## How to create a {{ PG }} cluster {#create-cluster}

{% list tabs %}

- Management console


   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a DB cluster.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
   1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
   1. Enter a name for the cluster in the **{{ ui-key.yacloud.mdb.forms.base_field_name }}** field. It must be unique within the folder.
   1. Select the environment where you want to create the cluster (you cannot change the environment once the cluster is created):
      * `PRODUCTION`: For stable versions of your apps.
      * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and is also covered by the SLA. However, it is the first to receive new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.
   1. Select the DBMS version.

      {% note info %}

      When you select the [host class](../concepts/instance-types.md) version `12-1c` ({{ PG }} 12 for 1C), consider the number of users in your 1C:Enterprise installation:
      * For 50 or more users connecting at the same time, we recommend using `s2.medium`.
      * For fewer than 50 users, `s2.small` is sufficient.

      {% endnote %}

   1. Select the host class that defines the technical specifications of the [VMs](../../compute/concepts/vm.md) where the DB hosts will be deployed. All available options are listed in [{#T}](../concepts/instance-types.md). When you change the host class for the cluster, the characteristics of all existing hosts change, too.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_disk }}**:

      
      * Select the disk type.

         
         {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}



      * Select the storage size to be used for data and backups. For more information about how backups take up storage space, see [{#T}](../concepts/backup.md).

   1. (Optional) Under **Automatic increase of storage size**, specify the required settings:

      * In the **Increase size** field, set the appropriate conditions to:

          * Increase the storage size during the next maintenance window when the storage is full by more than the specified percentage value (%).
          * Increase the storage size immediately when the storage is full by more than the specified percentage value (%).

          You can set both conditions, but make sure that the threshold for increasing the size immediately is higher than that for increasing the size during a maintenance window.

      * In the **New storage size** field, specify a new storage size to be set when one of the specified conditions is met.

      
      {% include [warn-storage-resize](../../_includes/mdb/mpg/warn-storage-resize.md) %}


      {% include [settings-dependence-on-storage](../../_includes/mdb/mpg/settings-dependence-on-storage.md) %}

      {% include [storage-resize-maintenance](../../_includes/mdb/mpg/storage-resize-maintenance.md) %}

      {% include [storage-resize-reset](../../_includes/mdb/mpg/storage-resize-reset.md) %}

   1. Under **{{ ui-key.yacloud.mdb.forms.section_database }}**, specify the DB attributes:
      * DB name. The name must be unique within the folder.

         {% include [database-name-limit](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

      * DB owner username and password. By default, the new user is assigned 50 connections to each host in the cluster.

         {% include [username-and-password-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

      * Locale for sorting and character set locale. These settings define the rules for sorting strings (`LC_COLLATE`) and classifying characters (`LC_CTYPE`). In {{ mpg-name }}, locale settings apply at the individual DB level.

         {% include [postgresql-locale](../../_includes/mdb/mpg-locale-settings.md) %}

   
   1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**, select:
      * [Cloud network](../../vpc/concepts/network.md#network) for the cluster.

        {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}

      * [Security groups](../../vpc/concepts/security-groups.md) for the cluster network traffic. You may also need to [set up security groups](connect.md#configuring-security-groups) to connect to the cluster.


   1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**, select the parameters for the DB hosts created with the cluster. By default, each host is created in a separate subnet. To select a specific [subnet](../../vpc/concepts/network.md#subnet) for the host, click ![image](../../_assets/pencil.svg) in the host row.

      
      When configuring the host parameters, note that if you selected `local-ssd` or `network-ssd-nonreplicated` under **{{ ui-key.yacloud.mdb.forms.section_disk }}**, you need to add at least three hosts to the cluster.


   1. Configure additional cluster settings, if required:

      {% include [Additional cluster settings](../../_includes/mdb/mpg/extra-settings-web-console.md) %}

   1. If required, configure [DBMS cluster-level settings](../concepts/settings-list.md#dbms-cluster-settings).

      {% note info %}

      Some {{ PG }} settings [depend on the selected host class or storage size](../concepts/settings-list.md#settings-instance-dependent).

      {% endnote %}

   1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a cluster:

   
   1. Check whether the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) has any [subnets](../../vpc/concepts/network.md#subnet) for the cluster hosts:

      ```bash
      yc vpc subnet list
      ```

      If there are no subnets in the folder, [create the required subnets](../../vpc/operations/subnet-create.md) in [{{ vpc-full-name }}](../../vpc/).


   1. View a description of the create cluster CLI command:

      ```bash
      {{ yc-mdb-pg }} cluster create --help
      ```

   1. Specify cluster parameters in the create command (the list of supported parameters in the example is not exhaustive):

      
      ```bash
      {{ yc-mdb-pg }} cluster create \
        --name <cluster name> \
        --environment <environment, prestable or production> \
        --network-name <network name> \
        --host zone-id=<availability zone>,subnet-id=<subnet ID> \
        --resource-preset <host class> \
        --user name=<username>,password=<user password> \
        --database name=<DB name>,owner=<DB owner name> \
        --disk-size <storage size, GB> \
        --disk-type <disk type> \
        --security-group-ids <list of security group IDs> \
        --connection-pooling-mode=<connection manager mode> \
        --deletion-protection=<cluster deletion protection: true or false>
      ```



      
      You need to specify `subnet-id` if the selected [availability zone](../../overview/concepts/geo-scope.md) has two or more subnets.

      {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}



      Available [connection pooler modes](../concepts/pooling.md) include: `SESSION`, `TRANSACTION`, or `STATEMENT`.

      {% include [database-name-limit](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

      {% include [username-limit](../../_includes/mdb/mpg/note-info-password-limits.md) %}

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

      You can also set the additional `replication-source` option in the `--host` parameter to [manually manage replication threads](../concepts/replication.md#replication-manual).

      
      
      To allow access to the cluster from [{{ sf-full-name }}](../../functions/), provide the `--serverless-access` parameter. For more information about setting up access, see the [{{ sf-name }}](../../functions/operations/database-connection.md) documentation.

      To allow access to the cluster from [{{ yq-full-name }}](../../query/index.yaml), provide the `--yandexquery-access=true` parameter. This feature is at the [Preview](../../overview/concepts/launch-stages.md) stage and available upon request.



      {% note info %}

      When creating a cluster, the `anytime` [maintenance](../concepts/maintenance.md) mode is set by default. You can set a specific maintenance period when [updating the cluster settings](update.md#change-additional-settings).

      {% endnote %}

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To create a cluster:
   1. In the configuration file, describe the parameters of the resources you want to create:
      * DB cluster: Description of the cluster and its hosts.
      * Database: Description of the cluster's DB.
      * User: Description of the cluster user.

      * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

      * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

      {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}

      Example of the configuration file structure:

      
      
      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
        name                = "<cluster name>"
        environment         = "<environment, PRESTABLE or PRODUCTION>"
        network_id          = "<network ID>"
        security_group_ids  = [ "<list of security groups>" ]
        deletion_protection = <cluster deletion protection: true or false>

        config {
          version = "<{{ PG }} version: {{ pg.versions.tf.str }}>"
          resources {
            resource_preset_id = "<host class>"
            disk_type_id       = "<disk type>"
            disk_size          = <storage size, GB>
          }
          pooler_config {
            pool_discard = <Odyssey pool_discard parameter: true or false>
            pooling_mode = "<operating mode: SESSION, TRANSACTION, or STATEMENT>"
          }
          ...
        }

        host {
          zone      = "<availability zone>"
          name      = "<host name>"
          subnet_id = "<subnet ID>"
        }
      }

      resource "yandex_mdb_postgresql_database" "<DB name>" {
        cluster_id = "<cluster ID>"
        name       = "<DB name>"
        owner      = "<DB owner name>"
        depends_on = [
          yandex_mdb_postgresql_user.<username>
        ]
      }

      resource "yandex_mdb_postgresql_user" "<username>" {
        cluster_id = "<cluster ID>"
        name       = "<username>"
        password   = "<user password>"
      }

      resource "yandex_vpc_network" "<network name>" { name = "<network name>" }

      resource "yandex_vpc_subnet" "<subnet name>" {
        name           = "<subnet name>"
        zone           = "<availability zone>"
        network_id     = "<network ID>"
        v4_cidr_blocks = ["<range>"]
      }
      ```




      {% include [database-name-limit](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

      {% include [username-limit](../../_includes/mdb/mpg/note-info-password-limits.md) %}

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

      {% include [Maintenance window](../../_includes/mdb/mpg/terraform/maintenance-window.md) %}

      {% include [Performance diagnostics](../../_includes/mdb/mpg/terraform/performance-diagnostics.md) %}

      For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Create a cluster.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API

   To create a cluster, use the [create](../api-ref/Cluster/create.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Create](../api-ref/grpc/cluster_service.md#Create) gRPC API call and provide the following in the request:
   * ID of the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where the cluster should be placed, in the `folderId` parameter.
   * Cluster name in the `name` parameter.
   * Cluster environment in the `environment` parameter.
   * [Network](../../vpc/concepts/network.md#network) ID in the `networkId` parameter.

      {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}

   * Cluster configuration in the `configSpec` parameter.
   * Configuration of the cluster hosts in one or more `hostSpecs` parameters.

   
   * [Security group](../concepts/network.md#security-groups) identifiers in the `securityGroupIds` parameter.


   * DB configuration in one or more `databaseSpecs` parameters.

      {% include [database-name-limit](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

   * User settings in one or more `userSpecs` parameters.

      {% include [username-limit](../../_includes/mdb/mpg/note-info-password-limits.md) %}

   {% include [datatransfer access](../../_includes/mdb/api/datatransfer-access-create.md) %}

   
   
   To allow cluster access from [{{ sf-full-name }}](../../functions/), set `true` for the `configSpec.access.serverless` parameter. For more information about setting up access, see the [{{ sf-name }}](../../functions/operations/database-connection.md) documentation.

   To allow cluster access from [{{ yq-full-name }}](../../query/index.yaml), set `true` for the `configSpec.access.yandexQuery` parameter. This feature is at the [Preview](../../overview/concepts/launch-stages.md) stage and available upon request.



   To enable [statistics collection](performance-diagnostics.md#activate-stats-collector):

   {% include [Performance diagnostic API](../../_includes/mdb/mpg/performance-diagnostics-api.md) %}

   To enable automatic increase of the storage size, provide the following in your request:

   {% include [api-storage-resize](../../_includes/mdb/mpg/api-storage-resize.md) %}

   
   {% include [warn-storage-resize](../../_includes/mdb/mpg/warn-storage-resize.md) %}


   {% include [settings-dependence-on-storage](../../_includes/mdb/mpg/settings-dependence-on-storage.md) %}

{% endlist %}


{% note warning %}

If you specified security group IDs when creating a cluster, you may also need to [configure security groups](connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}


## Examples {#examples}

### Creating a single-host cluster {#creating-a-single-host-cluster}

{% list tabs %}

- CLI

   To create a cluster with a single host, provide a single `--host` parameter.

   Create a {{ mpg-name }} cluster with test characteristics:

   
   * Named `mypg`.
   * In the `production` environment.
   * In the `default` network.
   * In the security group `{{ security-group }}`.
   * With one `{{ host-class }}` host in the `b0rcctk2rvtr8efcch64` subnet in the `{{ region-id }}-a` availability zone.
   * With 20 GB of network SSD storage (`{{ disk-type-example }}`).
   * With one user, `user1`, with the password `user1user1`.
   * With one `db1` database owned by `user1`.
   * With protection against accidental cluster deletion.


   Run the following command:

   
   ```bash
   {{ yc-mdb-pg }} cluster create \
      --name mypg \
      --environment production \
      --network-name default \
      --resource-preset {{ host-class }} \
      --host zone-id={{ region-id }}-a,subnet-id=b0rcctk2rvtr8efcch64 \
      --disk-type {{ disk-type-example }} \
      --disk-size 20 \
      --user name=user1,password=user1user1 \
      --database name=db1,owner=user1 \
      --security-group-ids {{ security-group }} \
      --deletion-protection=true
   ```


- {{ TF }}

   Create a {{ mpg-name }} cluster and a network for it with test characteristics:

   * Name: `mypg`
   * Version: `{{ pg.versions.tf.latest }}`
   * Environment: `PRESTABLE`
   * Cloud ID: `{{ tf-cloud-id }}`
   * Folder ID: `{{ tf-folder-id }}`
   * New network: `mynet`

   
   * In the new security group `pgsql-sg` allowing connections to the cluster from the internet via port `6432`.


   * Number of `{{ host-class }}` hosts in the new `mysubnet` subnet in the `{{ region-id }}-a` availability zone: 1. The `mysubnet` subnet will have a range of `10.5.0.0/24`.
   * Network SSD storage (`{{ disk-type-example }}`): 20 GB
   * User: `user1`, with the `user1user1` password
   * Database: `db1` owned by `user1`
   * Protection against accidental cluster deletion: Enabled

   The configuration file for this cluster is as follows:

   
   
   ```hcl
   resource "yandex_mdb_postgresql_cluster" "mypg" {
     name                = "mypg"
     environment         = "PRESTABLE"
     network_id          = yandex_vpc_network.mynet.id
     security_group_ids  = [ yandex_vpc_security_group.pgsql-sg.id ]
     deletion_protection = true

     config {
       version = {{ pg.versions.tf.latest }}
       resources {
         resource_preset_id = "{{ host-class }}"
         disk_type_id       = "{{ disk-type-example }}"
         disk_size          = "20"
       }
     }

     host {
       zone      = "{{ region-id }}-a"
       name      = "mypg-host-a"
       subnet_id = yandex_vpc_subnet.mysubnet.id
     }
   }

   resource "yandex_mdb_postgresql_database" "db1" {
     cluster_id = yandex_mdb_postgresql_cluster.mypg.id
     name       = "db1"
     owner      = "user1"
   }

   resource "yandex_mdb_postgresql_user" "user1" {
     cluster_id = yandex_mdb_postgresql_cluster.mypg.id
     name       = "user1"
     password   = "user1user1"
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

   resource "yandex_vpc_security_group" "pgsql-sg" {
     name       = "pgsql-sg"
     network_id = yandex_vpc_network.mynet.id

     ingress {
       description    = "PostgreSQL"
       port           = 6432
       protocol       = "TCP"
       v4_cidr_blocks = [ "0.0.0.0/0" ]
     }
   }
   ```




{% endlist %}
