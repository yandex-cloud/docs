---
title: How to create a {{ PG }} cluster
description: Follow this guide to create a {{ PG }} cluster with a single or multiple DB hosts.
---

# Creating a {{ PG }} cluster


A {{ PG }} cluster is one or more [database hosts](../concepts/index.md) between which you can configure [replication](../concepts/replication.md). Replication is enabled by default in any cluster consisting of more than one host: the master host accepts write requests and duplicates changes on replicas. The transaction is confirmed if the data is written to [disk](../concepts/storage.md) both on the master host and on a certain number of replicas, sufficient to establish a quorum.

{% note info %}

* The number of hosts you can create together with a {{ PG }} cluster depends on the selected [disk type](../concepts/storage.md#storage-type-selection) and [host class](../concepts/instance-types.md#available-flavors).
* Available disk types depend on the selected [host class](../concepts/instance-types.md#available-flavors).
* If the DB storage is 95% full, the cluster switches to read-only mode. Plan and increase the required storage size in advance.

{% endnote %}

By default, {{ mpg-name }} sets the maximum number of connections to each {{ PG }} cluster host. This maximum cannot be greater than the value of [Max connections](../concepts/settings-list.md#setting-max-connections).

{% include [note-pg-user-connections.md](../../_includes/mdb/note-pg-user-connections.md) %}

## Creating a cluster {#create-cluster}

To create a {{ mpg-name }} cluster, you need the [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) role and the [{{ roles.mpg.editor }} role or higher](../security/index.md#roles-list). For more information on assigning roles, see the [{{ iam-name }} documentation](../../iam/operations/roles/grant.md).

{% list tabs group=instructions %}

- Management console {#console}


  To create a {{ mpg-name }} cluster:

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a DB cluster.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. Enter a name for the cluster in the **{{ ui-key.yacloud.mdb.forms.base_field_name }}** field. It must be unique within the folder.
  1. Select the environment where you want to create the cluster (you cannot change the environment once the cluster is created):
     * `PRODUCTION`: For stable versions of your apps.
     * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.
  1. Select the DBMS version.

     {% note info %}

     When you select the [host class](../concepts/instance-types.md) for version `12-1c` ({{ PG }} 12 for 1C), consider the number of users in your 1C:Enterprise installation:
     * For 50 or more concurrent users, we recommend using `s2.medium`.
     * For fewer than 50 users, `s2.small` is sufficient.

     {% endnote %}

  1. Select the host class that defines the technical specifications of the [VMs](../../compute/concepts/vm.md) where the DB hosts will be deployed. All available options are listed under [Host classes](../concepts/instance-types.md). When you change the host class for a cluster, the characteristics of all the already created hosts change too.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_disk }}**:


     * Select the disk type.

       {% include [storages-type-no-change](../../_includes/mdb/storages-type-no-change.md) %}


       {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}



     * Select the storage size to be used for data and backups. For more information on how backups take up storage space, see [Backups](../concepts/backup.md).

  1. (Optional) Under **{{ ui-key.yacloud.mdb.cluster.section_disk-scaling }}**, specify the settings you need:

      * In the **{{ ui-key.yacloud.mdb.cluster.field_thresholds }}** field, set the conditions to:

          * Increase the storage size during the [next maintenance window](../concepts/maintenance.md#maintenance-window) if the storage is more than the specified percent (%) full.
          * Increase the storage size right away if the storage is more than the specified percent (%) full.

          You can set both conditions, but the threshold for immediate increase must be higher than that for increase during the maintenance window.

      * In the **{{ ui-key.yacloud.mdb.cluster.field_diskSizeLimit }}** field, specify the maximum storage size that can be set when increasing the storage size automatically.

      {% include [storage-resize-steps](../../_includes/mdb/mpg/storage-resize-steps.md) %}


      {% include [warn-storage-resize](../../_includes/mdb/mpg/warn-storage-resize.md) %}


      {% include [settings-dependence-on-storage](../../_includes/mdb/mpg/settings-dependence-on-storage.md) %}

      If you have set up the storage size to increase within the maintenance window, set up a schedule for the maintenance window.

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


  1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**, select the parameters for the DB hosts created with the cluster. By default, each host is created in a separate subnet. To select a specific [subnet](../../vpc/concepts/network.md#subnet) for the host, click ![image](../../_assets/console-icons/pencil.svg) in the host row.


     When configuring the hosts, note that if you selected `local-ssd` or `network-ssd-nonreplicated` under **{{ ui-key.yacloud.mdb.forms.section_disk }}**, you need to add at least three hosts to the cluster.


     To connect to the host from the internet, enable the **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** setting.

  1. Configure additional cluster settings, if required:

     {% include [Additional cluster settings](../../_includes/mdb/mpg/extra-settings-web-console.md) %}

  1. If required, configure [DBMS cluster-level settings](../concepts/settings-list.md#dbms-cluster-settings).
  
     {% note info %}

     Some {{ PG }} settings [depend on the selected host class or storage size](../concepts/settings-list.md#settings-instance-dependent).

     {% endnote %}

  1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a {{ mpg-name }} cluster:


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
       --name <cluster_name> \
       --environment <environment> \
       --network-name <network_name> \
       --host zone-id=<availability_zone>,`
                `subnet-id=<subnet_ID>,`
                `assign-public-ip=<access_to_host_from_internet> \
       --resource-preset <host_class> \
       --user name=<username>,password=<user_password> \
       --database name=<db_name>,owner=<database_owner_name> \
       --disk-size <storage_size_in_GB> \
       --disk-type <network-hdd|network-ssd|network-ssd-nonreplicated|local-ssd> \
       --security-group-ids <list_of_security_group_IDs> \
       --connection-pooling-mode=<connection_manager_operation_mode> \
       --deletion-protection=<deletion_protection>
     ```



     Where:

     * `environment`: Environment, `prestable` or `production`.
     * `disk-type`: Disk type.

       {% include [storages-type-no-change](../../_includes/mdb/storages-type-no-change.md) %}


     * `assign-public-ip`: Allow access to the host from the internet, `true` or `false`.


     * `deletion-protection`: Protection of the cluster, its databases, and users against deletion, `true` or `false` value.

       By default, the parameter inherits its value from the cluster when creating users and databases. You can also set the value manually; for more information, see the [User management](cluster-users.md) and [Database management](databases.md) sections.


     You need to specify the `subnet-id` if the selected [availability zone](../../overview/concepts/geo-scope.md) has two or more subnets.

     {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}



     The available [connection pooler modes](../concepts/pooling.md) include `SESSION`, `TRANSACTION`, and `STATEMENT`.

     {% include [database-name-limit](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

     {% include [username-limit](../../_includes/mdb/mpg/note-info-password-limits.md) %}

     {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

     You can also set the additional `replication-source` option in the `--host` parameter to [manually manage replication threads](../concepts/replication.md#replication-manual).



     To allow access to the cluster from [{{ sf-full-name }}](../../functions/), provide the `--serverless-access` parameter. For more information about setting up access, see the [{{ sf-name }}](../../functions/operations/database-connection.md) documentation.

     To allow access to the cluster from [{{ yq-full-name }}](../../query/index.yaml), provide the `--yandexquery-access=true` parameter. This feature is at the [Preview](../../overview/concepts/launch-stages.md) stage and available upon request.



     {% note info %}

     When creating a cluster, the `anytime` [maintenance](../concepts/maintenance.md) mode is set by default. You can set a specific maintenance period when [updating the cluster settings](update.md#change-additional-settings).

     {% endnote %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a {{ mpg-name }} cluster:
  1. In the configuration file, describe the parameters of the resources you want to create:
     * DB cluster: Description of the cluster and its hosts
     * Database: Description of the cluster DB
     * User: Description of the cluster user

     * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

     * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

     {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}

     Here is an example of the configuration file structure:



     ```hcl
     resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
       name                = "<cluster_name>"
       environment         = "<environment>"
       network_id          = "<network_ID>"
       security_group_ids  = [ "<list_of_security_group_IDs>" ]
       deletion_protection = <deletion_protection>

       config {
         version = "<{{ PG }}_version>"
         resources {
           resource_preset_id = "<host_class>"
           disk_type_id       = "<disk_type>"
           disk_size          = <storage_size_in_GB>
         }
         pooler_config {
           pool_discard = <Odyssey_parameter>
           pooling_mode = "<operation_mode>"
         }
         ...
       }

       host {
         zone             = "<availability_zone>"
         name             = "<host_name>"
         subnet_id        = "<subnet_ID>"
         assign_public_ip = <access_to_host_from_internet>
       }
     }

     resource "yandex_mdb_postgresql_database" "<db_name>" {
       cluster_id = "<cluster_ID>"
       name       = "<db_name>"
       owner      = "<database_owner_name>"
       depends_on = [
         yandex_mdb_postgresql_user.<username>
       ]
     }

     resource "yandex_mdb_postgresql_user" "<username>" {
       cluster_id = "<cluster_ID>"
       name       = "<username>"
       password   = "<user_password>"
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


     * `assign_public_ip`: Allow access to the host from the internet, `true` or `false`.


     * `deletion_protection`: Protection of the cluster, its databases, and users against deletion., `true` or `false` value.

       By default, the parameter inherits its value from the cluster when creating users and databases. You can also set the value manually; for more information, see the [User management](cluster-users.md) and [Database management](databases.md) sections.

     * `version`: {{ PG }} version, {{ pg.versions.tf.str }}.
     * `pool_discard`: Odyssey `pool_discard` parameter, `true` or `false`.
     * `pooling_mode`: Operation mode, `SESSION`, `TRANSACTION`, or `STATEMENT`.

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

- API {#api}

  To create a {{ mpg-name }} cluster, use the [create](../api-ref/Cluster/create.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Create](../api-ref/grpc/cluster_service.md#Create) gRPC API call and provide the following in the request:
  * ID of the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to host the cluster, in the `folderId` parameter.
  * Cluster name in the `name` parameter.
  * Cluster environment in the `environment` parameter.
  * [Network](../../vpc/concepts/network.md#network) ID in the `networkId` parameter.

    {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}

  * Cluster configuration in the `configSpec` parameter.
  * Protection of the cluster, its databases, and users against deletion in the `deletionProtection` parameter: `true` or `false`.

    By default, the parameter inherits its value from the cluster when creating users and databases. You can also set the value manually; for more information, see the [User management](cluster-users.md) and [Database management](databases.md) sections.
    
  * Configuration of the cluster hosts in one or more `hostSpecs` parameters.


  * [Security group](../concepts/network.md#security-groups) IDs in the `securityGroupIds` parameter.


  * DB configuration in one or more `databaseSpecs` parameters.

    {% include [database-name-limit](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

  * User settings in one or more `userSpecs` parameters.

    {% include [username-limit](../../_includes/mdb/mpg/note-info-password-limits.md) %}

  To allow [connection](connect.md) to cluster hosts from the internet, provide the `true` value in the `hostSpecs.assignPublicIp` parameter.



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


## Creating a cluster copy {#duplicate}

You can create a {{ PG }} cluster with the settings of another one you previously created. To do so, you need to import the configuration of the source {{ PG }} cluster to {{ TF }}. This way, you can either create an identical copy or use the imported configuration as the baseline and modify it as needed. Importing a configuration is a good idea when the source {{ PG }} cluster has a lot of settings and you need to create a similar one.

To create a {{ PG }} cluster copy:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. In the same working directory, place a `.tf` file with the following contents:

        ```hcl
        resource "yandex_mdb_postgresql_cluster" "old" { }
        ```

    1. Write the ID of the initial {{ PG }} cluster to the environment variable:

        ```bash
        export POSTGRESQL_CLUSTER_ID=<cluster_ID>
        ```

        You can request the ID with a [list of clusters in the folder](../../managed-postgresql/operations/cluster-list.md#list-clusters).

    1. Import the settings of the initial {{ PG }} cluster into the {{ TF }} configuration:

        ```bash
        terraform import yandex_mdb_postgresql_cluster.old ${POSTGRESQL_CLUSTER_ID}
        ```

    1. Get the imported configuration:

        ```bash
        terraform show
        ```

    1. Copy it from the terminal and paste it into the `.tf` file.
    1. Place the file in the new `imported-cluster` directory.
    1. Modify the copied configuration so that you can create a new cluster from it:

        * Specify the new cluster name in the `resource` string and the `name` parameter.
        * Delete `created_at`, `health`, `id`, and `status`.
        * In the `host` sections, delete `fqdn` and `role`.
        * If the `disk_size_autoscaling` section has `disk_size_limit = 0`, delete this section.
        * If the `maintenance_window` section has `type = "ANYTIME"`, delete the `hour` parameter.
        * Optionally, make further changes if you need to customize the configuration.

    1. [Get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) in the `imported-cluster` directory.

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

    {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

{% endlist %}

## Examples {#examples}

### Creating a single-host cluster {#creating-a-single-host-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

  To create a cluster with a single host, provide a single `--host` parameter.

  Create a {{ mpg-name }} cluster with the following test specifications:


  * Name: `mypg`
  * Environment: `production`
  * Network: `default`
  * Security group: `{{ security-group }}`
  * With one `{{ host-class }}` host in the `b0rcctk2rvtr********` subnet, in the `{{ region-id }}-a` availability zone.
  * Network SSD storage (`{{ disk-type-example }}`): 20 GB
  * User: `user1`, password: `user1user1`
  * Database: `db1`, owner: `user1`
  * Protection of the cluster, its DBs, and users against accidental deletion: Enabled


  Run the following command:


  ```bash
  {{ yc-mdb-pg }} cluster create \
     --name mypg \
     --environment production \
     --network-name default \
     --resource-preset {{ host-class }} \
     --host zone-id={{ region-id }}-a,subnet-id=b0rcctk2rvtr******** \
     --disk-type {{ disk-type-example }} \
     --disk-size 20 \
     --user name=user1,password=user1user1 \
     --database name=db1,owner=user1 \
     --security-group-ids {{ security-group }} \
     --deletion-protection=true
  ```


- {{ TF }} {#tf}

  Create a {{ mpg-name }} cluster and a network for it with the following test specifications:

  * Name: `mypg`
  * Version: `{{ pg.versions.tf.latest }}`
  * Environment: `PRESTABLE`
  * Cloud ID: `{{ tf-cloud-id }}`
  * Folder ID: `{{ tf-folder-id }}`
  * New network: `mynet`.


  * New security group: `pgsql-sg`, allowing cluster connections from the internet through port `6432`


  * Host class: `{{ host-class }}` (one host), new subnet: `mysubnet`, availability zone: `{{ region-id }}-a`. `mysubnet` range: `10.5.0.0/24`
  * Network SSD storage (`{{ disk-type-example }}`): 20 GB
  * User: `user1`, password: `user1user1`
  * Database: `db1`, owner: `user1`
  * Protection of the cluster, its DBs, and users against accidental deletion: Enabled

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


{% include [connection-manager](../../_includes/mdb/connection-manager.md) %}

