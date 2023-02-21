# Creating {{ CH }} clusters

{{ CH }} clusters are one or more database hosts that replication can be configured between.

{% note info %}

* The number of hosts you can create together with a {{ CH }} cluster depends on the selected [disk type](../concepts/storage.md#storage-type-selection) and [host class](../concepts/instance-types.md#available-flavors).
* Available disk types [depend](../concepts/storage.md) on the selected [host class](../concepts/instance-types.md).

{% endnote %}

The selected [replication mechanism](../concepts/replication.md) also affects the number of hosts in a multi-host cluster:

* A cluster that uses {{ CK }} to manage replication and fault tolerance should consist of three or more hosts with individual hosts not required to run {{ CK }}. You can only create this kind of cluster using the CLI or API.

   
   This feature is in the [Preview stage](../../overview/concepts/launch-stages.md). Access to {{ CK }} is available on request. Contact [support]({{ link-console-support }}) or your account manager.


* When using {{ ZK }}, a cluster can consist of two or more hosts. Another three {{ ZK }} hosts will be added to the cluster automatically.

   The minimum number of cores per {{ ZK }} host depends on the total number of cores on {{ CH }} hosts. For more information, see [{#T}](../concepts/replication.md#zk).

   {% note alert %}

   
   These hosts are taken into account when calculating the consumed cloud [resource quota]({{ link-console-quotas }}) and cluster [cost](../pricing.md#prices-zookeeper).


   {% endnote %}

## How to create a {{ CH }} cluster {#create-cluster}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a DB cluster.
      1. Select a **{{ mch-name }}** service.
   1. Click **Create cluster**.
   1. Name the cluster in the **Cluster name** field. The cluster name must be unique within the folder.
   1. Select the environment where you want to create the cluster (you can't change the environment once the cluster is created):
      * `PRODUCTION`: For stable versions of your apps.
      * `PRESTABLE`: For testing, including the {{ mch-short-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.
   1. Select the {{ CH }} version from the **Version** drop-down list to use for the {{ mch-name }} cluster:
      * For most clusters, it's recommended to select the latest LTS version.
      * If you plan to use hybrid storage in a cluster, it's recommended to select {{ mch-ck-version }} version or higher.
   1. If you are expecting to use data from a {{ objstorage-name }} bucket with [restricted access](../../storage/concepts/bucket#bucket-access), select a service account from the drop-down list or create a new one. For more information about setting up a service account to access data in a bucket, see [{#T}](s3-access.md).
   1. Under **Resources**:

      * Select the platform, VM type, and host class that defines the technical specifications of the VMs where the DB hosts will be deployed. All available options are listed in [{#T}](../concepts/instance-types.md). When you change the host class for the cluster, the characteristics of all existing instances change, too.

      
      * Select the [disk type](../concepts/storage.md).

         {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}


      * Select the size of disk to be used for data and backups. For more information about how backups take up storage space, see [{#T}](../concepts/backup.md).

   1. Under **Hosts**:

      * To create additional DB hosts, click **Add host**. Once the second host is added, the **Configure {{ ZK }}** button appears. If necessary, change the {{ ZK }} settings in **{{ ZK }} resources** and **{{ ZK }} hosts**.
      * Set the parameters of DB hosts being created alongside the cluster. To change the added host, hover over the host line and click ![image](../../_assets/pencil.svg).

   1. Under **DBMS settings**:

      * If you want to manage cluster users via SQL, select **Enabled** in the drop-down list of the **User management via SQL** field and enter the `admin` user password. This disables user management through other interfaces.

         Otherwise, select **Disabled**.

      * If you want to manage databases via SQL, select **Enabled** in the drop-down list of the **Database management via SQL** field. This disables database management through other interfaces. The field is inactive if user management via SQL is disabled.

         Otherwise, select **Disabled**.

         {% include [SQL-management-can't-be-switched-off](../../_includes/mdb/mch/note-sql-db-and-users-create-cluster.md) %}

      * Username and password.

         {% include [user-name-and-password-limits](../../_includes/mdb/mch/note-info-user-name-and-pass-limits.md) %}

      * DB name. The database name may contain Latin letters, numbers, and underscores. The maximum name length is 63 characters. You can't create a database named `default`.

      * If necessary, enable [hybrid storage](../concepts/storage.md#hybrid-storage-features) for the cluster.

         {% note alert %}

         You can't disable this option.

         {% endnote %}

      * If necessary, configure the [DBMS settings](../concepts/settings-list.md#dbms-cluster-settings).

   
   1. Under **Network settings**, select the cloud network to host the cluster in and security groups for cluster network traffic. You may also need to [set up security groups](connect.md#configuring-security-groups) to connect to the cluster.


   1. Under **Hosts**, select the parameters of database hosts created together with the cluster. To change the settings of a host, click the ![pencil](../../_assets/pencil.svg) icon in the line with its number:

      * **Availability zone**: Select an [availability zone](../../overview/concepts/geo-scope.md).
      * **Subnet**: Specify a [subnet](../../vpc/concepts/network.md#subnet) in the selected availability zone.
      * **Public access**: Allow [access](connect.md) to the host from the internet.

      To add hosts to the cluster, click **Add host**.

   1. If necessary, configure cluster service settings:

      {% include [mch-extra-settings](../../_includes/mdb/mch/extra-settings-web-console.md) %}

   1. Click **Create cluster**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a cluster:

   
   1. Check whether the folder has any subnets for the cluster hosts:

      ```bash
      yc vpc subnet list
      ```

      If there are no subnets in the folder, [create the necessary subnets](../../vpc/operations/subnet-create.md) in {{ vpc-short-name }}.


   1. View a description of the CLI's create cluster command:

      ```bash
      {{ yc-mdb-ch }} cluster create --help
      ```

   1. Specify cluster parameters in the create command (the list of supported parameters in the example is not exhaustive):

      
      ```bash
      {{ yc-mdb-ch }} cluster create \
        --name <cluster name> \
        --environment <environment: prestable or production> \
        --network-name <network name> \
        --host type=<clickhouse or zookeeper>,`
             `zone-id=<availability zone>,`
             `subnet-id=<subnet ID>,`
             `assign-public-ip=<public access to host: true or false> \
        --clickhouse-resource-preset <host class> \
        --clickhouse-disk-type <network-hdd | network-ssd | local-ssd | network-ssd-nonreplicated> \
        --clickhouse-disk-size <storage size in GB> \
        --user name=<username>,password=<user password> \
        --database name=<database name> \
        --security-group-ids <list of security group IDs> \
        --yandexquery-access=<access via {{ yq-full-name }}: true or false> \
        --deletion-protection=<protection from cluster deletion: true or false>
      ```

      The subnet ID `subnet-id` should be specified if the selected availability zone contains two or more subnets.


      {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-db.md) %}

      You can manager cluster users and databases via SQL.

      {% include [SQL-management-can't-be-switched-off](../../_includes/mdb/mch/note-sql-db-and-users-create-cluster.md) %}

      1. To enable [SQL user management](./cluster-users.md#sql-user-management):

         * set `--enable-sql-user-management` to `true`.
         * Set a password for the `admin` user in the `--admin-password` parameter.

         ```bash
         {{ yc-mdb-ch }} cluster create \
            ...
            --enable-sql-user-management true \
            --admin-password "<admin password>"
         ```

      1. To enable [SQL database management](./databases.md#sql-database-management):

         * Set `--enable-sql-user-management` and `--enable-sql-database-management` to `true`;
         * Set a password for the `admin` user in the `--admin-password` parameter.

         ```bash
         {{ yc-mdb-ch }} cluster create \
            ...
            --enable-sql-user-management true \
            --enable-sql-database-management true \
            --admin-password "<admin password>"
         ```

      
      1. To allow access to the cluster from [{{ sf-full-name }}](../../functions/concepts/index.md), pass the `--serverless-access` parameter. For more detail on setting up access, see the [{{ sf-name }}](../../functions/operations/database-connection.md).


      1. {% include [datatransfer access](../../_includes/mdb/cli/datatransfer-access-create.md) %}

      1. To enable [{{ CK }}](../concepts/replication.md#ck) in a cluster:

         * Specify a {{ CH }} version ({{ mch-ck-version }} or higher) in the `--version` option.
         * Set `--embedded-keeper` to `true`.

         ```bash
         {{ yc-mdb-ch }} cluster create \
            ...
            --version "<{{ CH }} version: {{ mch-ck-version }} or higher>" \
            --embedded-keeper true
         ```

         {% include [ClickHouse Keeper can't turn off](../../_includes/mdb/mch/note-ck-no-turn-off.md) %}

         To get a list of available {{ CH }} versions, run the command:

         ```bash
         {{ yc-mdb-ch }} version list
         ```

   1. To configure [hybrid storage settings](../concepts/storage.md#hybrid-storage-settings):

      * Set the `--cloud-storage` parameter to `true` to enable hybrid storage.

         {% include [Hybrid Storage cannot be switched off](../../_includes/mdb/mch/hybrid-storage-cannot-be-switched-off.md) %}

      * Pass the hybrid storage settings in the respective parameters:

         {% include [Hybrid Storage settings CLI](../../_includes/mdb/mch/hybrid-storage-settings-cli.md) %}

      ```bash
      {{ yc-mdb-ch }} cluster create \
          ...
          --cloud-storage=true \
          --cloud-storage-data-cache=<true or false> \
          --cloud-storage-data-cache-max-size=<memory size (in bytes)> \
          --cloud-storage-move-factor=<free space ratio>
          ...
      ```

- {{ TF }}

      {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   To create a cluster:

   1. Using the command line, navigate to the folder that will contain the {{ TF }} configuration files with an infrastructure plan. Create the directory if it does not exist.

      1. If you don't have {{ TF }} yet, [install it and create a configuration file with provider settings](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Create a configuration file describing the [cloud network](../../vpc/concepts/network.md#network) and [subnets](../../vpc/concepts/network.md#subnet).
      * Network: A description of the [cloud network](../../vpc/concepts/network.md#network) where the cluster will be hosted. If you already have a suitable network, you don't need to describe it again.
      * Subnets: The [subnets](../../vpc/concepts/network.md#network) to connect the cluster hosts to. If you already have suitable subnets, you don't need to describe them again.

      Example structure of a configuration file that describes a cloud network with a single subnet:

      ```hcl
      resource "yandex_vpc_network" "<network name in {{ TF }}>" { name = "<network name>" }

      resource "yandex_vpc_subnet" "<name of subnet in {{ TF }}>" {
        name           = "<subnet name>"
        zone           = "<availability zone>"
        network_id     = yandex_vpc_network.<network name in {{ TF }}>.id
        v4_cidr_blocks = ["<subnet>"]
      }
      ```

   1. Create a configuration file with a description of the cluster and its hosts.

      * Database cluster: Description of the cluster and its hosts. Also as required here:
         * Specify [DBMS settings](../concepts/settings-list.md).
         * Enable deletion protection.

            {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-db.md) %}

      Example structure of a configuration file that describes a cluster with a single host:

      
      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
        name                = "<cluster name>"
        environment         = "<environment>"
        network_id          = yandex_vpc_network.<network name in {{ TF }}>.id
        security_group_ids  = ["<list of security group IDs>"]
        deletion_protection = <cluster deletion protection: true or false>

        clickhouse {
          resources {
            resource_preset_id = "<host class>"
            disk_type_id       = "<disk type>"
            disk_size          = <storage size, GB>
          }
        }

        database {
          name = "<database name>"
        }

        user {
          name     = "<database username>"
          password = "<password>"
          permission {
            database_name = "<name of the DB in which the user is being created>"
          }
        }

        host {
          type             = "CLICKHOUSE"
          zone             = "<availability zone>"
          subnet_id        = yandex_vpc_subnet.<subnet name in {{ TF }}>.id
          assign_public_ip = <public access to host: true or false>
        }
      }
      ```


      {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-db.md) %}

      1. {% include [Maintenance window](../../_includes/mdb/mch/terraform/maintenance-window.md) %}

      1. To enable access from other services and [SQL query execution from the management console](web-sql-query.md), add an `access` block with the necessary settings:

         
         ```hcl
         resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
           ...
           access {
             datalens   = <Access from DataLens: true or false>
             metrika    = <Access from Metrica and AppMetrika: true or false>
             serverless = <Access from Cloud Functions: true or false>
             web_sql    = <Executing SQL queries from the management console: true or false>
           }
           ...
         }
         ```



      You can manager cluster users and databases via SQL.

      {% include notitle [SQL Management can't be switched off](../../_includes/mdb/mch/note-sql-db-and-users-create-cluster.md) %}

      * {% include notitle [Enable SQL user management with Terraform](../../_includes/mdb/mch/terraform/sql-management-users.md) %}

      * {% include notitle [Enable SQL database management with Terraform](../../_includes/mdb/mch/terraform/sql-management-databases.md) %}

      For more information on resources that you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-mch }}).

   1. Check the {{ TF }} configuration files for errors:

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Create a cluster:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

   Use the [create](../api-ref/Cluster/create) API method and pass the following information in the request:
   * In the `folderId` parameter, the ID of the folder where the cluster should be placed.
   * The cluster name in the `name` parameter.
   * The environment of the cluster, in the `environment` parameter.
   * Cluster configuration, in the `configSpec` parameter.
   * Configuration of the cluster hosts, in one or more `hostSpecs` parameters.
   * Network ID, in the `networkId` parameter.
      * Security group identifiers, in the `securityGroupIds` parameter.

   To allow [connection](connect.md) to cluster hosts from the internet, pass the `true` value in the `hostSpecs.assignPublicIp` parameter.

   If necessary, enable user and database management via SQL:
   * `configSpec.sqlUserManagement`: Set `true` to enable [managing users via SQL](cluster-users.md#sql-user-management).
   * `configSpec.sqlDatabaseManagement`: Set `true` to enable [database management via SQL](databases.md#sql-database-management). User management via SQL needs to be enabled.
   * `configSpec.adminPassword` : Set the password for the `admin` user whose account is used for management.

   {% include [SQL-management-can't-be-switched-off](../../_includes/mdb/mch/note-sql-db-and-users-create-cluster.md) %}

      To allow cluster access from [{{ sf-full-name }}](../../functions/concepts/index.md), pass `true` for the `configSpec.access.serverless` parameter. For more detail on setting up access, see the [{{ sf-name }}](../../functions/operations/database-connection.md).

   {% include [datatransfer access](../../_includes/mdb/api/datatransfer-access-create.md) %}

   To allow cluster access from {{ yq-full-name }}, pass `true` for the `configSpec.access.yandexQuery` parameter.

   To configure [hybrid storage settings](../concepts/storage.md##hybrid-storage-settings):

   * Pass `true` in the `configSpec.cloudStorage.enabled` parameter to enable hybrid storage.
   * Pass the hybrid storage settings in the `configSpec.cloudStorage` parameters:

      {% include [Hybrid Storage settings API](../../_includes/mdb/mch/hybrid-storage-settings-api.md) %}

   When creating a cluster with multiple hosts:

   * If `embeddedKeeper` is `true`, replication will be managed using [{{ CK }}](../concepts/replication.md#ck).

      {% include [ClickHouse Keeper can't turn off](../../_includes/mdb/mch/note-ck-no-turn-off.md) %}

      To use {{ CK }}, your {{ CH }} version must be {{ mch-ck-version }} or higher. You can get a list of available {{ CH }} versions using the [list](../api-ref/Versions/list.md) API method.

   * If `embeddedKeeper` is undefined or `false`, replication and query distribution will be managed using {{ ZK }}.

      
      If the cluster [cloud network](../../vpc/concepts/network.md) has subnets in each [availability zone](../../overview/concepts/geo-scope.md), and {{ ZK }} host settings are not specified, one such host will automatically be added to each subnet.

      If only some availability zones in the cluster's network have subnets, explicitly specify the {{ ZK }} host settings.


{% endlist %}


{% note warning %}

If you specified security group IDs when creating a cluster, you may also need to [configure security groups](connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}


## Examples {#examples}

### Creating a single-host cluster {#creating-a-single-host-cluster}

{% list tabs %}

- CLI

   To create a cluster with a single host, pass a single `--host` parameter.

   Create a {{ mch-name }} cluster with test characteristics:

   
   * Named `mych`.
   * Environment `production`.
   * Network `default`.
   * Security group `{{ security-group }}`.
   * With a single {{ CH }} host of the `{{ host-class }}` class in the `b0rcctk2rvtr8efcch64` subnet and the `{{ region-id }}-a` availability zone.
   * {{ CK }}.
   * With 20 GB of SSD network storage (`{{ disk-type-example }}`).
   * With one user, `user1`, with the password `user1user1`.
   * With one database, `db1`.
   * Protection against accidental cluster deletion.


   Run the following command:

   
   ```bash
   {{ yc-mdb-ch }} cluster create \
     --name mych \
     --environment=production \
     --network-name default \
     --clickhouse-resource-preset {{ host-class }} \
     --host type=clickhouse,zone-id={{ region-id }}-a,subnet-id=b0cl69g98qumiqmtg12a \
     --version {{ versions.keeper }} \
     --embedded-keeper true \
     --clickhouse-disk-size 20 \
     --clickhouse-disk-type {{ disk-type-example }} \
     --user name=user1,password=user1user1 \
     --database name=db1 \
     --security-group-ids {{ security-group }} \
     --deletion-protection=true
   ```


- {{ TF }}

   Create a {{ mch-name }} cluster and a network for it with test characteristics:

   * Named `mych`.
   * In the `PRESTABLE` environment.
   * Cloud with the `{{ tf-cloud-id }}` ID.
   * Folder with the `{{ tf-folder-id }}` ID.
   * A new cloud network named `cluster-net`.
      * A new [default security group](connect.md#configuring-security-groups) named `cluster-sg` (in the `cluster-net` network) that allows connections to any cluster host from any network (including the internet) on ports `8443` and `9440`.
   * With a single `{{ host-class }}` class host on a new subnet named `cluster-subnet-{{ region-id }}-a`.

      Subnet parameters:
      * Address range: `172.16.1.0/24`.
      * Network: `cluster-net`.
      * Availability zone: `{{ region-id }}-a`.

   * With 20 GB of local SSD storage (`{{ disk-type-example }}`).
   * Database name `db1`.
   * With a user named `user1` with the password `user1user1`.

   The configuration files for this cluster look like this:

   1. Configuration file with a description of provider settings:

      {% include [terraform-provider](../../_includes/mdb/terraform-provider.md) %}

   1. Configuration file with a description of the cloud network and subnet:

      {% include [terraform-mdb-single-network](../../_includes/mdb/terraform-single-network.md) %}

   
   1. Configuration file with a description of the security group:

      {% include [terraform-mch-sg](../../_includes/mdb/mch/terraform/security-groups.md) %}


   1. Configuration file with a description of the cluster and cluster host:

      {% include [terraform-mch-single-host-single-shard](../../_includes/mdb/mch/terraform/single-host-single-shard.md) %}

{% endlist %}

### Creating a multi-host cluster {#creating-a-multi-host-cluster}

{% list tabs %}

- {{ TF }}

   Create a {{ mch-name }} cluster with test characteristics:

   * Named `mych`.
   * In the `PRESTABLE` environment.
   * Cloud with the `{{ tf-cloud-id }}` ID.
   * Folder with the `{{ tf-folder-id }}` ID.
   * In a new cloud network named `cluster-net`.

   * With three {{ CH }} hosts of the `{{ host-class }}` class and three {{ ZK }} hosts of the `{{ zk-host-class }}` class (to ensure [replication](../concepts/replication.md)).

      One host of each class will be added to the new subnets:
      * `cluster-subnet-{{ region-id }}-a`: `172.16.1.0/24`, availability zone `{{ region-id }}-a`.
      * `cluster-subnet-{{ region-id }}-b`: `172.16.2.0/24`, availability zone `{{ region-id }}-b`.
      * `cluster-subnet-{{ region-id }}-c`: `172.16.3.0/24`, availability zone `{{ region-id }}-c`.

      These subnets will belong to the `cluster-net` network.

      * A new [default security group](connect.md#configuring-security-groups) named `cluster-sg` (in the `cluster-net` network) that allows connections to any cluster host from any network (including the internet) on ports `8443` and `9440`.
   * With 32 GB of network SSD storage (`{{ disk-type-example }}`) per each {{ CH }} cluster host.
   * With 10 GB of network SSD storage (`{{ disk-type-example }}`) per each {{ ZK }} cluster host.
   * Database name `db1`.
   * With a user named `user1` with the password `user1user1`.

   The configuration files for this cluster look like this:

   1. Configuration file with a description of provider settings:

      {% include [terraform-provider](../../_includes/mdb/terraform-provider.md) %}

   1. Configuration file with a description of the cloud network and subnets:

      {% include [terraform-mdb-multiple-networks](../../_includes/mdb/terraform-multiple-networks.md) %}

   
   1. Configuration file with a description of the security group:

      {% include [terraform-mch-sg](../../_includes/mdb/mch/terraform/security-groups.md) %}


   1. Configuration file with a description of the cluster and cluster hosts:

      {% include [terraform-mch-multiple-hosts-single-shard](../../_includes/mdb/mch/terraform/multiple-hosts-single-shard.md) %}

{% endlist %}
