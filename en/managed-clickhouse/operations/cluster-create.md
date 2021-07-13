# Creating {{ CH }} clusters

{{ CH }} clusters are one or more database hosts that replication can be configured between.

{% note warning %}

{% if audience != "internal" %}

When creating a {{ CH }} cluster with 2 or more hosts, {{ mch-short-name }} automatically creates a cluster of 3 ZooKeeper hosts for managing replication and fault tolerance. These hosts are considered when calculating the [resource quotas]({{ link-console-quotas }}) used by the cloud and the cluster cost. Read more about replication for [{{ CH }}](../concepts/replication.md#clickhouse).

{% else %}

When creating a {{ CH }} cluster with 2 or more hosts, {{ mch-short-name }} automatically creates a cluster of 3 ZooKeeper hosts for managing replication and fault tolerance. These hosts are considered when calculating the [resource quotas]({{ link-console-quotas }}) used by the cloud. Read more about replication for [{{ CH }}](../concepts/replication.md#clickhouse).

{% endif %}

{% endnote %}

{% if audience != "internal" %}

The number of hosts that can be created together with a {{ CH }} cluster depends on the selected [type of storage](../concepts/storage.md):

* With **local storage**, you can create a cluster with 2 or more replicas (to ensure fault tolerance, a minimum of 2 replicas is necessary). If the [available folder resources](../concepts/limits.md) are still sufficient, you can add extra replicas.
* With **network storage**, you can request any number of hosts (from one to the maximum for the current [quota](../concepts/limits.md)).
* With **hybrid storage**, you can only create a cluster with a single host. After creating this cluster, you can [add shards](shards.md#add-shard) consisting of only one host. Such a cluster isn't tolerant to host failures, but if this happens, the data in the shard or cluster is saved. Hybrid storage is at the [Preview](../../overview/concepts/launch-stages.md) stage.

{% endif %}

{% list tabs %}

- Management console

  1. In the management console, select the folder where you want to create a DB cluster.
{% if audience != "internal" %}

  1. Select **{{ mch-name }}**.
{% endif %}

  1. Click **Create cluster**.

  1. Enter a name for the cluster in the **Cluster name** field. The cluster name must be unique within the folder.

  1. From the **Version** drop-down list, select the version of {{ CH }} which the {{ mch-name }} cluster will use:
     1. For most clusters, it's recommended to select the latest LTS version.
     1. If you plan to use hybrid storage in a cluster, it's recommended to select the latest version. This type of storage is supported starting from {{ CH }} {{ mch-hs-version }}.

  1. Select the environment where you want to create the cluster (you can't change the environment once the cluster is created):
      - `PRODUCTION`: For stable versions of your apps.
      - `PRESTABLE`: For testing, including the {{ mch-short-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.

  1. Select the host class that defines the technical specifications of the VMs where the DB hosts will be deployed. All available options are listed in [{#T}](../concepts/instance-types.md). When you change the host class for the cluster, the characteristics of all existing instances change, too.

  1. Under **Storage size**:

      {% if audience != "internal" %}

      - Select the type of storage, either a more flexible network type (**network-hdd** or **network-ssd**) or faster local SSD storage (**local-ssd**).

        When selecting a storage type, remember that:
        - The size of the local storage can only be changed in 100 GB increments.
        - If you plan to use hybrid storage at the [Preview](../../overview/concepts/launch-stages.md) stage, you can select only one of the network storages in this section: **network-ssd** or **network-hdd**.

      {% endif %}
	  
      - Select the size to be used for data and backups. For more information about how backups take up storage space, see [{#T}](../concepts/backup.md).

  1. Under **Database**, specify the DB attributes:
  
      - DB name.
      - Username.
      - User password. At least 8 characters.

  1. To [manage users via SQL](cluster-users.md#sql-user-management), enable the **User management via SQL** setting and specify the password of the `admin` user.

  1. To [manage databases via SQL](databases.md#sql-database-management), enable the **User management via SQL** and **Database management via SQL** settings and specify the password of the `admin` user.

     {% include [sql-db-and-users-alers](../../_includes/mdb/mch-sql-db-and-users-alert.md) %}

  1. Under **Network settings**, select the cloud network to host the cluster in and security groups for cluster network traffic. You may need to additionally [set up the security groups](connect.md#configuring-security-groups) to connect to the cluster.

  1. Under **Hosts**, select the parameters of database hosts created together with the cluster. To change the added host, place the cursor on the host line and click  ![image](../../_assets/pencil.svg).

     When configuring host parameters, remember that:
     - If you previously selected `local-ssd` in the **Storage** section, you need to add at least 2 hosts to the cluster.
     - If you plan to use hybrid storage at the [Preview](../../overview/concepts/launch-stages.md) stage, there can be only one host in the cluster.

  1. If necessary, configure additional cluster settings:

     {% include [mch-extra-settings](../../_includes/mdb/mch-extra-settings-web-console-new-cluster-wizard.md) %}

  1. If necessary, configure the [DBMS settings](../concepts/settings-list.md#dbms-cluster-settings).

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
      $ {{ yc-mdb-ch }} cluster create --help
      ```

  1. Specify the cluster parameters in the create command (the example shows only mandatory flags):

     {% if audience != "internal" %}

     ```
     $ {{ yc-mdb-ch }} cluster create \
        --name <cluster name> \
        --environment <prestable or production> \
        --network-name <network name> \
        --host type=<clickhouse or zookeeper>,zone-id=<availability zone>,subnet-id=<subnet ID> \
        --clickhouse-resource-preset <host class> \
        --clickhouse-disk-type <network-hdd | network-ssd | local-ssd> \
        --clickhouse-disk-size <storage size in GB> \
        --user name=<username>,password=<user password> \
        --database name=<database name> \
        --security-group-ids <list of security group IDs>
     ```

     The subnet ID `subnet-id` should be specified if the selected availability zone contains two or more subnets.

     {% else %}

      ```
      $ {{ yc-mdb-ch }} cluster create \
         --name <cluster name> \
         --environment <prestable or production> \
         --network-id ' ' \
         --host type=<clickhouse or zookeeper>,zone-id=<availability zone> \
         --clickhouse-resource-preset <host class> \
         --clickhouse-disk-type local-ssd \
         --clickhouse-disk-size <storage size in GB> \
         --user name=<username>,password=<user password> \
         --database name=<database name> \
         --security-group-ids <list of security group IDs>
      ```

    {% endif %}

      1. To enable [user management via SQL mode](cluster-users.md#sql-user-management):
      
          {% include [sql-db-and-users-alers](../../_includes/mdb/mch-sql-db-and-users-alert.md) %}
      
          * Set the `--enable-sql-user-management` parameter to `true`.
          * Set the `admin` user password in the `--admin-password` parameter.
      
          ```bash
          {{ yc-mdb-ch }} cluster create \
             ...
             --enable-sql-user-management=true \
             --admin-password <admin user password>
          ```
      
      1. To enable [database management via SQL mode](databases.md#sql-database-management):
      
          * Set the `--enable-sql-user-management` and `--enable-sql-database-management` parameters to `true`.
          * Set the `admin` user password in the `--admin-password` parameter.
      
          ```bash
          {{ yc-mdb-ch }} cluster create \
             ...
             --enable-sql-user-management=true \
             --enable-sql-database-management=true \
             --admin-password <admin user password>
          ```

- Terraform

  {% include [terraform-definition](../../solutions/_solutions_includes/terraform-definition.md) %}

  If you don't have Terraform, [install it and configure the provider](../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  To create a cluster:

    1. In the configuration file, describe the parameters of resources that you want to create:
       * Database cluster: Description of the cluster and its hosts. If required, here you can also configure [DBMS settings](../concepts/settings-list.md#dbms-cluster-settings).
       * Network: Description of the [cloud network](../../vpc/concepts/network.md#network) where the cluster will be located. If you already have a suitable network, you don't need to describe it again.
       * Subnets: Description of the [subnets](../../vpc/concepts/network.md#network) to connect the cluster hosts to. If you already have suitable subnets, you don't need to describe them again.

       Example configuration file structure:

       ```hcl
       resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
         name               = "<cluster name>"
         environment        = "<environment>"
         network_id         = "<network ID>"
         security_group_ids = ["<list of security groups>"]
       
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

       For more information about resources that you can create using Terraform, see the [provider's documentation](https://www.terraform.io/docs/providers/yandex/r/mdb_clickhouse_cluster.html).

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Create a cluster.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        After this, all the necessary resources will be created in the specified folder and the IP addresses of the VMs will be displayed in the terminal. You can check resource availability and their settings in the [management console]({{ link-console-main }}).

- API

  To create a cluster, use the [create](../api-ref/Cluster/create.md) API method and pass the following in the request:
  - In the `folderId` parameter, the ID of the folder where the cluster should be placed.
  - The cluster name, in the `name` parameter.
  - The environment of the cluster, in the `environment` parameter.
  - Cluster configuration, in the `configSpec` parameter.
  - Configuration of the cluster hosts, in one or more `hostSpecs` parameters.
  - Network ID, in the `networkId` parameter.
  - Security group IDs in the parameter `securityGroupIds`.

  If necessary, enable user and database management via SQL:
  - `configSpec.sqlUserManagement`: Set `true` to enable [managing users via SQL](cluster-users.md#sql-user-management).
  - `configSpec.sqlDatabaseManagement`: Set `true` to enable [database management via SQL](databases.md#sql-database-management). User management via SQL needs to be enabled.
  - `configSpec.adminPassword` : Set the password for the `admin` user whose account is used for management.

  When creating a cluster with multiple hosts:
    - If a cluster in the[virtual network](../../vpc/concepts/network.md) has subnets in each of the [availability zones](../../overview/concepts/geo-scope.md), one {{ ZK }} host is automatically added to each subnet if you don't explicitly specify the settings for these hosts. If necessary, you can explicitly specify 3 {{ ZK }} hosts and their settings when creating a cluster.
    - If a cluster in the virtual network has subnets only in certain availability zones, you need to explicitly specify 3 {{ ZK }} hosts and their settings when creating a cluster.

{% endlist %}

{% note warning %}

If you specified security group IDs when creating a cluster, you may also need to [re-configure security groups](connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}

## Examples {#examples}

### Creating a single-host cluster {#creating-a-single-host-cluster}

{% list tabs %}

- CLI

  To create a cluster with a single host, you should pass a single `--host` parameter.

  Let's say we need to create a {{ CH }} cluster with the following characteristics:

  {% if audience != "internal" %}
  
  - Named `mych`.
  - In the `production` environment.
  - In the `default` network.
  - In the security group `{{ security-group }}`.
  - With a single `{{ host-class }}` class ClickHouse host in the `b0rcctk2rvtr8efcch64` subnet and `ru-central1-c` availability zone.
  - With 20 GB fast network storage (`{{ disk-type-example }}`).
  - With one user, `user1`, with the password `user1user1`.
  - With one database, `db1`.

  {% else %}

  - Named `mych`.
  - In the `production` environment.
  - In the `default` network.
  - In the security group `{{ security-group }}`.
  - With one `{{host-class}}` class ClickHouse host in the `{{zone-id}}` availability zone.
  - With 20 GB fast local storage (`local-ssd`).
  - With one user, `user1`, with the password `user1user1`.
  - With one database, `db1`.

  {% endif %}

  Run the command:

  {% if audience != "internal" %}

  ```
  $ {{ yc-mdb-ch }} cluster create \
       --name mych \
       --environment=production \
       --network-name default \
       --clickhouse-resource-preset {{ host-class }} \
       --host type=clickhouse,zone-id=ru-central1-c,subnet-id=b0cl69g98qumiqmtg12a \
       --clickhouse-disk-size 20 \
       --clickhouse-disk-type {{ disk-type-example }} \
       --user name=user1,password=user1user1 \
       --database name=db1 \
       --security-group-ids {{ security-group }}
  ```

  {% else %}

  ```
  $ {{ yc-mdb-ch }} cluster create \
       --name mych \
       --environment=production \
       --clickhouse-resource-preset s2.nano \
       --host type=clickhouse,zone-id=man \
       --clickhouse-disk-size 20 \
       --clickhouse-disk-type local-ssd \
       --user name=user1,password=user1user1 \
       --database name=db1 \
       --security-group-ids {{ security-group }}
  ```

{% endif %}

- Terraform

  Let's say we need to create a {{ CH }} cluster and a network for it with the following characteristics:
    - Named `mych`.
    - In the `PRESTABLE` environment.
    - In the cloud with the ID `{{ tf-cloud-id }}`.
    - In the folder with the ID `{{ tf-folder-id }}`.
    - Network: `mynet`.
    - In the new security group `mych-sg` allowing connections to the cluster from the internet via ports `8443` and `9440`.
    - With a single `{{ host-class }}` class host in the new subnet named `mysubnet` and the `ru-central1-c` availability zone. The `mysubnet` subnet will have a range of `10.5.0.0/24`.
    - With 32 GB of fast network storage.
    - With the database name `my_db`.
    - With the username `user1` and password `user1user1`.

  The configuration file for the cluster looks like this:

  ```hcl
  provider "yandex" {
    token = "<OAuth or static key of service account>"
    cloud_id  = "{{ tf-cloud-id }}"
    folder_id = "{{ tf-folder-id }}"
    zone      = "ru-central1-c"
  }
  
  resource "yandex_mdb_clickhouse_cluster" "mych" {
    name               = "mych"
    environment        = "PRESTABLE"
    network_id         = yandex_vpc_network.mynet.id
    security_group_ids = [ yandex_vpc_security_group.mych-sg.id ]
  
    clickhouse {
      resources {
        resource_preset_id = "{{ host-class }}"
        disk_type_id       = "network-ssd"
        disk_size          = 32
      }
    }
  
    database {
      name = "my_db"
    }
  
    user {
      name     = "user1"
      password = "user1user1"
      permission {
        database_name = "my_db"
      }
    }
  
    host {
      type      = "CLICKHOUSE"
      zone      = "ru-central1-c"
      subnet_id = yandex_vpc_subnet.mysubnet.id
    }
  }
  
  resource "yandex_vpc_network" "mynet" { name = "mynet" }
  
  resource "yandex_vpc_subnet" "mysubnet" {
    name           = "mysubnet"
    zone           = "ru-central1-c"
    network_id     = yandex_vpc_network.mynet.id
    v4_cidr_blocks = ["10.5.0.0/24"]
  }
  
  resource "yandex_vpc_security_group" "mych-sg" {
    name       = "mych-sg"
    network_id = yandex_vpc_network.mynet.id
  
    ingress {
      description    = "MCHSSSH"
      port           = 8443
      protocol       = "TCP"
      v4_cidr_blocks = [ "0.0.0.0/0" ]
    }
  
    ingress {
      description    = "MCHSSH2"
      port           = 9440
      protocol       = "TCP"
      v4_cidr_blocks = [ "0.0.0.0/0" ]
    }
  }
  ```

{% endlist %}
