# Creating a {{ MS }} cluster

{{ MS }} cluster: one or more database hosts. [Replication](../concepts/replication.md) works by default in any cluster with more than 1 host: the primary replica accepts read and write requests and propagates changes to the secondary replicas at the same time.

{% note info %}

If database storage is 95% full, the cluster switches to read-only mode. Plan and increase the required storage size in advance.

{% endnote %}


The number of hosts that can be created together with a {{ MS }} cluster depends on the selected [type of storage](../concepts/storage.md):

* With **local storage**, you can create a cluster with 3 or more hosts (to ensure fault tolerance, a minimum of 3 hosts is necessary).
* When using network storage:
    * If you select **standard** or **fast network storage**, you can add any number of hosts within the [current quota](../concepts/limits.md).
    * If you select **non-replicated network storage**, you can create a cluster with 3 or more hosts (to ensure fault tolerance, a minimum of 3 hosts is necessary).

After creating a cluster, you can add extra hosts to it if there are enough available [folder resources](../concepts/limits.md).

## How to create a {{ MS }} cluster {#create-cluster}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mms-name }}**.

  1. Click **Create cluster**.

  1. Enter a name for the cluster in the **Cluster name** field. The cluster name must be unique within the folder.

  1. Select the environment where you want to create the cluster (you can't change the environment once the cluster is created):
      - `PRODUCTION`: For stable versions of your apps.
      - `PRESTABLE`: For testing, including the {{ mms-short-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.

  1. Select the DBMS version. Currently, we support `2016 ServicePack 2` of the following editions:
     * Standard Edition.
     * Enterprise Edition.

     For more information, see [{#T}](../concepts/index.md).

  1. Select the host class to define the technical specifications of the VMs where the database hosts will be deployed. All available options are listed in [{#T}](../concepts/instance-types.md). When you change the host class for the cluster, the characteristics of all existing hosts change, too.

  1. Under **Storage size**:

      
      - Choose the [type of storage](../concepts/storage.md), either a more flexible network type (`network-hdd`, `network-ssd`, or `network-ssd-nonreplicated`) or faster local SSD storage (`local-ssd`).

        When selecting a storage type, remember that:
        - The size of the local storage can only be changed in 100 GB increments.
        - The size of non-replicated network storage can only be changed in 93 GB increments.
      - Select the size to be used for data and backups. For more information about how backups take up storage space, see [{#T}](../concepts/backup.md).

  1. Under **Database**, specify the database attributes:
      - Database name. This name must be unique within the folder and contain only Latin letters, numbers, and underscores.
      - Username of the database owner. This name may only contain Latin letters, numbers, and underscores. By default, the new user is assigned 50 connections to each host in the cluster.
      - User password (from 8 to 128 characters).

  1. Under **Hosts**, select the parameters for the database hosts created with the cluster. You can add either one, three, or more hosts. By default, each host is created in a separate subnet. To select a specific subnet for the host, click ![image](../../_assets/pencil.svg) in the row of the host and select the desired availability zone and subnet.

     {% note warning %}
     * If you select **Standard Edition**, you can create a cluster from only one host. This cluster does not provide any fault tolerance. For more information, see [{#T}](../concepts/index.md).
     * At the moment, you can create an **Enterprise Edition** cluster with either one or three hosts. Please note that if you selected `local-ssd` or `network-ssd-nonreplicated` under **Storage**, you need to add at least 3 hosts to the cluster.

     {% endnote %}

  1. If necessary, configure additional cluster settings:

      {% include [extra-settings-create](../../_includes/mdb/mms/extra-settings-create.md) %}

  1. If necessary, configure the [DBMS settings](../concepts/settings-list.md).

  1. Click **Create cluster**.

- Terraform

    {% include [terraform-definition](../../_includes/solutions/terraform-definition.md) %}

    If you don't have {{ TF }}, [install it and configure the provider](../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

    To create a cluster:

    1. In the configuration file, describe the parameters of resources that you want to create:
        - Database cluster: Description of the cluster and its hosts. If required, here you can also configure [DBMS settings](../concepts/settings-list.md#dbms-cluster-settings).
        - Network: Description of the [cloud network](../../vpc/concepts/network.md#network) where the cluster will be located. If you already have a suitable network, you don't need to describe it again.
        - Subnets: Description of the [subnets](../../vpc/concepts/network.md#network) to connect the cluster hosts to. If you already have suitable subnets, you don't need to describe them again.

        Example configuration file structure:

        ```hcl
        resource "yandex_mdb_sqlserver_cluster" "<cluster name>" {
          name                = "<cluster name>"
          environment         = "<environment: PRESTABLE or PRODUCTION>"
          network_id          = "<network ID>"
          version             = "<version: 2016sp2std or 2016sp2ent>"
          security_groups_id  = ["<list of security group IDs>"]
          deletion_protection = <protect cluster from deletion: true or false>
        
          resources {
            resource_preset_id = "<host class>"
            disk_type_id       = "<storage type>"
            disk_size          = <storage size in GB>
          }
        
          host {
            zone      = "<availability zone>"
            subnet_id = "<subnet ID>"
          }
        
          database = {
            name = "<database name>"
          }
        
          user {
            name     = "<username>"
            password = "<password>"
        
            permission {
              database_name = "<database name>"
              roles         = ["<list of roles>"]
            }
          }
        
          backup_window_start {
            hours   = <backup starting hour>
            minutes = <backup starting minute>
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

       {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

       For more information about the resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-mms }}).

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Create a cluster.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        After this, all the necessary resources will be created in the specified folder and the IP addresses of the VMs will be displayed in the terminal. You can check resource availability and their settings in the [management console]({{ link-console-main }}).

- API

  Use the API [create](../api-ref/Cluster/create.md) method and pass the following information in the request:

  - In the `folderId` parameter, the ID of the folder where the cluster should be placed.

  - The cluster name, in the `name` parameter.

  - Cluster configuration, in the `configSpec` parameter.

  - Configuration of the cluster hosts, in one or more `hostSpecs` parameters.

  - Cluster database configuration, in one or more `databaseSpecs` parameters.

  - Configuration of the accounts in the cluster database, in one or more `userSpecs` parameters.

  - Network ID, in the `networkId` parameter.
  - The names of the collation settings for the cluster databases in the `sqlcollation` parameter.

  - The names of the sort settings for the cluster databases in the `sqlcollation` parameter.

  - Cluster deletion protection settings in the `deletionProtection` parameter.

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

{% endlist %}

## Examples {#examples}

### Creating a single-host cluster

{% list tabs %}

- Terraform

    Let's say we need to create a {{ MS }} cluster and a network for it with the following characteristics:
    - Using `mssql-1` as the name.
    - In the `PRODUCTION` environment.
    - Using the {{ MS }} `2016 ServicePack 2` version and the `Standard Edition`.
    - In the cloud with the ID `{{ tf-cloud-id }}`.
    - In the folder with the ID `{{ tf-folder-id }}`.
    - Network: `mynet`.
    - In a new security group called `ms-sql-sg` supporting cluster connections from the internet via port `{{ port-mms }}`.
    - With a single host of the `s2.small` class in a new `mysubnet` subnet and the `{{ zone-id }}` availability zone. The `mysubnet` subnet will have a range of `10.5.0.0/24`.
    - With 32 GB of fast network storage.
    - With a database called `db1`.
    - With a user with `user1` as the login and `user1user1` as the password. This user will own the `db1` database ([predefined role `DB_OWNER`](./grant.md#predefined-db-roles)).
    - With protection against accidental cluster deletion.

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
    
    resource "yandex_mdb_sqlserver_cluster" "mssql-1" {
      name                = "mssql-1"
      environment         = "PRODUCTION"
      version             = "2016sp2std"
      network_id          = yandex_vpc_network.mynet.id
      security_group_ids  = [yandex_vpc_security_group.ms-sql-sg.id]
      deletion_protection = true
    
      resources {
        resource_preset_id = "s2.small"
        disk_type_id       = "network-ssd"
        disk_size          = 32
      }
    
      host {
        zone             = "{{ zone-id }}"
        subnet_id        = yandex_vpc_subnet.mysubnet.id
        assign_public_ip = true
      }
    
      database {
        name = "db1"
      }
    
      user {
        name     = "user1"
        password = "user1user1"
        permission {
          database_name = "db1"
          roles         = ["OWNER"]
        }
      }
    }
    
    resource "yandex_vpc_network" "mynet" { name = "mynet" }
    
    resource "yandex_vpc_subnet" "mysubnet" {
      name           = "mysubnet"
      zone           = "{{ zone-id }}"
      network_id     = yandex_vpc_network.mynet.id
      v4_cidr_blocks = ["10.5.0.0/24"]
    }
    
    resource "yandex_vpc_security_group" "ms-sql-sg" {
      name       = "ms-sql-sg"
      network_id = yandex_vpc_network.mynet.id
    
      ingress {
        description    = "Public access to SQL Server"
        port           = {{ port-mms }}
        protocol       = "TCP"
        v4_cidr_blocks = ["0.0.0.0/0"]
      }
    }
    ```

{% endlist %}

