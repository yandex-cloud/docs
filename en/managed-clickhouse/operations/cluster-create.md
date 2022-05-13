# Creating {{ CH }} clusters

{{ CH }} clusters are one or more database hosts that replication can be configured between.

The number of hosts to add to a cluster when it is created depends on the selected [storage type](../concepts/storage.md):

* When using **local SSD storage** (`local-ssd`), you can create a cluster with two or more hosts (a minimum of two hosts is required for fault tolerance).
* When using network storage:
    * If you select **network HDD** (`network-hdd`) or **network SSD** (`network-ssd`) storage, you can add any number of hosts within the [current quota](../concepts/limits.md).
    * If you select **non-replicated SSD** storage (`network-ssd-nonreplicated`), you can create a cluster with three or more hosts (to ensure fault tolerance, a minimum of three hosts is necessary).

The selected [replication mechanism](../concepts/replication.md) also affects the number of hosts in a multi-host cluster:

* A cluster that uses {{ CK }} to manage replication and fault tolerance should consist of three or more hosts with individual hosts not required to run {{ CK }}. You can only create this kind of cluster using the CLI or API.

    {% include [ClickHouse Keeper preview note](../../_includes/mdb/mch/note-ck-preview.md) %}

* When using {{ ZK }}, a cluster can consist of two or more hosts. Another three {{ ZK }} hosts will be added to the cluster automatically.

    {% note alert %}

    
    These hosts are taken into account when calculating the used up [resource quotas]({{ link-console-quotas }}) in the cloud and in [calculating the cost](../pricing.md#prices-zookeeper) of the cluster.

    {% endnote %}

## How to create a {{ CH }} cluster {#create-cluster}

{% list tabs %}

- Management console

  1. In the management console, select the folder where you want to create a DB cluster.
    1. Select **{{ mch-name }}**.
  1. Click **Create cluster**.
  1. Name the cluster in the **Cluster name** field. The cluster name must be unique within the folder.
  1. From the **Version** drop-down list, select the version of {{ CH }} which the {{ mch-name }} cluster will use:
     * For most clusters, it's recommended to select the latest LTS version.
     * If you plan to use hybrid storage in a cluster, it's recommended to select the latest version.

  1. If you plan to use data from a {{ objstorage-name }} bucket with [restricted access](../../storage/concepts/bucket#bucket-access), select a service account from the drop-down list or create a new one. For more information about setting up a service account to access data in a bucket, see [{#T}](s3-access.md).
  1. Select the environment where you want to create the cluster (you can't change the environment once the cluster is created):
      * `PRODUCTION`: For stable versions of your apps.
      * `PRESTABLE`: For testing, including the {{ mch-short-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.
  1. Select the host class that defines the technical specifications of the VMs where the DB hosts will be deployed. All available options are listed in [{#T}](../concepts/instance-types.md). When you change the host class for the cluster, the characteristics of all existing instances change, too.
  1. Under **Storage size**:

      
      * Select the [type of storage](../concepts/storage.md).

          {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}
      * Select the size to be used for data and backups. For more information about how backups take up storage space, see [{#T}](../concepts/backup.md).

  1. Under **Database**, specify the DB attributes:

      * DB name.
      * User name.
      * User password. At least 8 characters.

  1. To [manage users via SQL](cluster-users.md#sql-user-management), enable the **User management via SQL** setting and specify the password of the `admin` user.

  1. To [manage databases via SQL](databases.md#sql-database-management), enable the **User management via SQL** and **Database management via SQL** settings and specify the password of the `admin` user.

     {% include [sql-db-and-users-alers](../../_includes/mdb/mch-sql-db-and-users-alert.md) %}

  1. Under **Network settings**, select the cloud network to host the cluster in and security groups for cluster network traffic. You may need to additionally [set up security groups](connect.md#configuring-security-groups) to connect to the cluster.

  1. Under **Hosts**, select the parameters of database hosts created together with the cluster. To change the added host, place the cursor on the host line and click  ![image](../../_assets/pencil.svg).

  1. If necessary, configure additional cluster settings:

     {% include [mch-extra-settings](../../_includes/mdb/mch-extra-settings-web-console-new-cluster-wizard.md) %}

  1. If necessary, configure the [DBMS settings](../concepts/settings-list.md#dbms-cluster-settings).

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

  1. View a description of the CLI create cluster command:

      ```bash
      {{ yc-mdb-ch }} cluster create --help
      ```

  1. Specify cluster parameters in the create command (the list of supported parameters in the example is not exhaustive):

     
     ```bash
     {{ yc-mdb-ch }} cluster create \
        --name <cluster name> \
        --environment <prestable or production> \
        --network-name <network name> \
        --host type=<clickhouse or zookeeper>,zone-id=<availability zone>,subnet-id=<subnet ID> \
        --clickhouse-resource-preset <host class> \
        --clickhouse-disk-type <network-hdd | network-ssd | local-ssd | network-ssd-nonreplicated> \
        --clickhouse-disk-size <storage size in GB> \
        --user name=<username>,password=<user password> \
        --database name=<database name> \
        --security-group-ids <list of security group IDs> \
        --deletion-protection=<protect cluster from deletion: true or false>
     ```

     The subnet ID `subnet-id` should be specified if the selected availability zone contains two or more subnets.

     {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

      1. To enable [SQL user management](cluster-users.md#sql-user-management):

          {% include [sql-db-and-users-alers](../../_includes/mdb/mch-sql-db-and-users-alert.md) %}

          * Set `--enable-sql-user-management` to `true`.
          * Set a password for the `admin` user in the `--admin-password` parameter.

          ```bash
          {{ yc-mdb-ch }} cluster create \
             ...
             --enable-sql-user-management=true \
             --admin-password <admin user password>
          ```

      1. To enable [SQL database management](databases.md#sql-database-management):

          * Set `--enable-sql-user-management` and `--enable-sql-database-management` to `true`.
          * Set a password for the `admin` user in the `--admin-password` parameter.

          ```bash
          {{ yc-mdb-ch }} cluster create \
             ...
             --enable-sql-user-management=true \
             --enable-sql-database-management=true \
             --admin-password <admin user password>
          ```

            1. To enable cluster access from [{{ sf-full-name }}](../../functions/concepts/index.md), pass the `--serverless-access` parameter. For more information about setting up access, see the [{{ sf-name }}](../../functions/operations/database-connection.md) documentation.

      1. To enable [{{ CK }}](../concepts/replication.md#ck) in a cluster:

         * Set the {{ CH }} version ({{ mch-ck-version }} or higher) in the `--version` parameter.
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

- Terraform

    {% include [terraform-definition](../../_includes/tutorials/terraform-definition.md) %}

  To create a cluster:

    1. Using the command line, navigate to the folder that will contain the {{ TF }} configuration files with an infrastructure plan. Create the directory if it does not exist.

        1. If you don't have {{ TF }} yet, [install it and create a configuration file with provider settings](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

    1. Create a configuration file with a description of your [cloud network](../../vpc/concepts/network.md#network) and [subnets](../../vpc/concepts/network.md#subnet).

       The cluster is hosted on a cloud network. If you already have a suitable network, you don't need to describe it again.
       Cluster hosts are located on subnets of the selected cloud network. If you already have suitable subnets, you don't need to describe them again.

       Example structure of a configuration file that describes a cloud network with a single subnet:

       ```hcl
       resource "yandex_vpc_network" "<name of network in {{ TF }}>" { name = "<network name>" }
       
       resource "yandex_vpc_subnet" "<name of subnet in {{ TF }}>" {
         name           = "<subnet name>"
         zone           = "<availability zone>"
         network_id     = yandex_vpc_network.<name of network in {{ TF }}>.id
         v4_cidr_blocks = ["<subnet>"]
       }
       ```

    1. Create a configuration file with a description of the cluster and its hosts.

       You can also configure [DBMS settings](../concepts/settings-list.md#dbms-cluster-settings) here if necessary.

       Example structure of a configuration file that describes a cluster with a single host:

       ```hcl
       resource "yandex_mdb_clickhouse_cluster" "<name of cluster in {{ TF }}>" {
         name                = "<cluster name>"
         environment         = "<environment>"
         network_id          = yandex_vpc_network.<name of network in {{ TF }}>.id
         security_group_ids  = ["<security group ID list>"]
         deletion_protection = <protect cluster from deletion: true or false>
       
         clickhouse {
           resources {
             resource_preset_id = "<host class>"
             disk_type_id       = "<storage type>"
             disk_size          = <storage size in GB>
           }
         }
       
         database {
           name = "<DB name>"
         }
       
         user {
           name     = "<DB username>"
           password = "<password>"
           permission {
             database_name = "<name of the DB where the user is created>"
           }
         }
       
         host {
           type      = "CLICKHOUSE"
           zone      = "<availability zone>"
           subnet_id = yandex_vpc_subnet.<name of subnet in {{ TF }}>.id
         }
       }
       ```

       {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

       To enable access from other {{ yandex-cloud }} services and [SQL query execution from the management console](web-sql-query.md), add an `access` block with the necessary settings:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
          ...
          access {
            data_lens  = <access from DataLens: true or false>
            metrika    = <access from Yandex.Metrica and AppMetrica: true or false>
            serverless = <access from Cloud Functions: true or false>
            web_sql    = <execution of SQL queries from management console: true or false>
          }
          ...
        }
        ```

       For more information about resources that you can create using Terraform, see the [provider's documentation](https://www.terraform.io/docs/providers/yandex/r/mdb_clickhouse_cluster.html).

    1. Check the {{ TF }} configuration files for errors:

       {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Create a cluster:

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

- API

  Use the [create](../api-ref/Cluster/create.md) API method and pass the following in the request:
  * The ID of the folder where the cluster should be placed in the `folderId` parameter.
  * The cluster name in the `name` parameter.
  * The environment of the cluster, in the `environment` parameter.
  * Cluster configuration, in the `configSpec` parameter.
  * Configuration of the cluster hosts, in one or more `hostSpecs` parameters.
  * Network ID, in the `networkId` parameter.
  * Security group IDs in the parameter `securityGroupIds`.

  If necessary, enable user and database management via SQL:
  * `configSpec.sqlUserManagement`: Set `true` to enable [managing users via SQL](cluster-users.md#sql-user-management).
  * `configSpec.sqlDatabaseManagement`: Set `true` to enable [database management via SQL](databases.md#sql-database-management). User management via SQL needs to be enabled.
  * `configSpec.adminPassword` : Set the password for the `admin` user whose account is used for management.

    To enable cluster access from [{{ sf-full-name }}](../../functions/concepts/index.md), pass the value `true` for the `configSpec.access.serverless` parameter. For more information about setting up access, see the [{{ sf-name }}](../../functions/operations/database-connection.md) documentation.

  When creating a cluster with multiple hosts:

  * If `embeddedKeeper` is `true`, replication will be managed using [{{ CK }}](../concepts/replication.md#ck).

      {% include [ClickHouse Keeper can't turn off](../../_includes/mdb/mch/note-ck-no-turn-off.md) %}

      To use {{ CK }}, your {{ CH }} version must be {{ mch-ck-version }} or higher. You can get a list of available {{ CH }} versions using the [list](../api-ref/Versions/list.md) API method.

  * If `embeddedKeeper` is undefined or `false`, replication and query distribution will be managed using {{ ZK }}.

        If a cluster's [cloud network](../../vpc/concepts/network.md) has subnets in each [availability zone](../../overview/concepts/geo-scope.md) and the {{ ZK }} host settings are undefined, one such host will be added to each subnet automatically.

    If only certain availability zones in a cluster's network have subnets, specify the {{ ZK }} host settings explicitly.

{% endlist %}

{% note warning %}

If you specified security group IDs when creating a cluster, you may also need to [re-configure security groups](connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}

## Examples {#examples}

### Creating a single-host cluster {#creating-a-single-host-cluster}

{% list tabs %}

- CLI

  To create a cluster with a single host, pass a single `--host` parameter.

  Let's say we need to create a {{ CH }} cluster with the following characteristics:

  
  * Named `mych`.
  * In the `production` environment.
  * In the `default` network.
  * In the security group `{{ security-group }}`.
  * With a single `{{ host-class }}` class ClickHouse host in the `b0rcctk2rvtr8efcch64` subnet and `ru-central1-c` availability zone.
  * With {{ CK }}.
  * With 20 GB of SSD network storage (`{{ disk-type-example }}`).
  * With one user, `user1`, with the password `user1user1`.
  * With one database, `db1`.
  * With accidental cluster deletion protection.

  Run the command:

  
  ```bash
  {{ yc-mdb-ch }} cluster create \
     --name mych \
     --environment=production \
     --network-name default \
     --clickhouse-resource-preset {{ host-class }} \
     --host type=clickhouse,zone-id=ru-central1-c,subnet-id=b0cl69g98qumiqmtg12a \
     --version {{ mch-ck-version }} \
     --embedded-keeper true \
     --clickhouse-disk-size 20 \
     --clickhouse-disk-type {{ disk-type-example }} \
     --user name=user1,password=user1user1 \
     --database name=db1 \
     --security-group-ids {{ security-group }} \
     --deletion-protection=true
  ```

- {{ TF }}

  Let's say we need to create a {{ CH }} cluster and a network for it with the following characteristics:

  * Named `mych`.
  * In the `PRESTABLE` environment.
  * In the cloud with the ID `{{ tf-cloud-id }}`.
  * In the folder with the ID `{{ tf-folder-id }}`.
  * In a new cloud network named `cluster-net`.
  * In a new [default security group](connect.md#configuring-security-groups) named `cluster-sg` (on the `cluster-net` network) that allows connections to any cluster host from any network (including the internet) on ports `8443` and `9440`.
  * With one `{{ host-class }}` class host on a new subnet called `cluster-subnet-ru-central1-c`.

    Subnet parameters:
    * Address range: `172.16.3.0/24`.
    * Network: `cluster-net`.
    * Availability zone: `{{ zone-id }}`.

  * With 32 GB of SSD network storage (`network-ssd`).
  * With a database named `db1`.
  * With the username `user1` and password `user1user1`.

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

  Let's say we need to create a {{ CH }} cluster with the following characteristics:

  * Named `mych`.
  * In the `PRESTABLE` environment.
  * In the cloud with the ID `{{ tf-cloud-id }}`.
  * In the folder with the ID `{{ tf-folder-id }}`.
  * In a new cloud network named `cluster-net`.
  * With three {{ CH }} hosts of the `{{ host-class }}` class and three {{ ZK }} hosts of the `{{ zk-host-class }}` class (to provide [replication](../concepts/replication.md)).

    One host of each type will be added to the new subnets:
    * `cluster-subnet-ru-central1-a`: `172.16.1.0/24`, availability zone `ru-central1-a`.
    * `cluster-subnet-ru-central1-b`: `172.16.2.0/24`, availability zone `ru-central1-b`.
    * `cluster-subnet-ru-central1-c`: `172.16.3.0/24`, availability zone `ru-central1-c`.

    These subnets will belong to the `cluster-net` network.

  * In a new [default security group](connect.md#configuring-security-groups) named `cluster-sg` (on the `cluster-net` network) that allows connections to any cluster host from any network (including the internet) on ports `8443` and `9440`.
  * With 32 GB of SSD network storage (`network-ssd`) for each {{ CH }} host in the cluster.
  * With 10 GB of SSD network storage (`network-ssd`) for each {{ ZK }} host in the cluster.
  * With a database named `db1`.
  * With the username `user1` and password `user1user1`.

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
