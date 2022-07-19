# Creating a {{ MS }} cluster

{{ MS }} cluster: one or more database hosts. [Replication](../concepts/replication.md) works by default in any cluster with more than 1 host: the primary replica accepts read and write requests and propagates changes to the secondary replicas at the same time.

{% note info %}

* The number of hosts you can create together with a {{ MS }} cluster depends on the selected [storage type](../concepts/storage.md#storage-type-selection) and [host class](../concepts/instance-types.md#available-flavors).
* Available storage types [depend](../concepts/storage.md) on the selected [host class](../concepts/instance-types.md#available-flavors).

{% endnote %}

If database storage is 95% full, the cluster switches to read-only mode. Plan and increase the required storage size in advance.

{% include [ms-licensing-personal-data](../../_includes/ms-licensing-personal-data.md) %}

## How to create a {{ MS }} cluster {#create-cluster}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mms-name }}**.
   1. Click **Create cluster**.
   1. Name the cluster in the **Cluster name** field. The cluster name must be unique within the folder.
   1. Select the environment where you want to create the cluster (you can't change the environment once the cluster is created):
      * `PRODUCTION`: For stable versions of your apps.
      * `PRESTABLE`: For testing, including the {{ mms-short-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.
   1. Select the DBMS version. The following editions are available for all supported versions:
      * Standard Edition.
      * Enterprise Edition.

      For more information, see [{#T}](../concepts/index.md).

   1. Select the host class to define the technical specifications of the VMs where the database hosts will be deployed. All available options are listed in [{#T}](../concepts/instance-types.md). When you change the host class for the cluster, the characteristics of all existing hosts change, too.
   1. Under **Storage size**:

      
      * Select the [storage type](../concepts/storage.md).

         {% include [storages-step-settings](../../_includes/mdb/settings-storages-no-broadwell.md) %}


      * Select the size to be used for data and backups. For more information about how backups take up storage space, see [{#T}](../concepts/backup.md).
   1. Under **Database**, specify the database attributes:

      * Database name. This name must be unique within the folder and contain only Latin letters, numbers, and underscores.
      * Username of the database owner. This name may only contain Latin letters, numbers, and underscores. By default, the new user is assigned 50 connections to each host in the cluster.
      * User password (from 8 to 128 characters).

   1. Under **Network settings**, select the cloud network to host the cluster in and security groups for cluster network traffic. You may also need to [set up security groups](connect.md#configuring-security-groups) to connect to the cluster.

   1. Under **Hosts**:

      1. Select database host parameters for the databases being created alongside the cluster. By default, each host is created in a separate subnet. To select a specific subnet for a host, click ![image](../../_assets/pencil.svg) in the host's row and select the required availability zone and subnet.

         {% note warning %}

         The number of hosts available to be added depends on the SQL Server [edition](../concepts/index.md):

         * In the **Standard Edition**, you can only create a single-host cluster. This cluster does not provide any fault tolerance.
         * In the **Enterprise Edition**, you can create clusters of either one or three or more hosts. If you selected `local-ssd` or `network-ssd-nonreplicated` under **Storage**, you need to add at least 3 hosts to the cluster.

         {% endnote %}

      
      1. (Optional) Select groups of [dedicated hosts](../../compute/concepts/dedicated-host.md) to host the cluster on.

         {% include [Dedicated hosts note](../../_includes/mdb/mms/note-dedicated-hosts.md) %}


   1. If necessary, configure additional cluster settings:

      {% include [extra-settings-create](../../_includes/mdb/mms/extra-settings-create.md) %}

   1. If necessary, configure the [DBMS settings](../concepts/settings-list.md).
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
      {{ yc-mdb-ms }} cluster create --help
      ```

   1. Specify cluster parameters in the create command (the list of supported parameters in the example is not exhaustive):

      
      ```bash
      {{ yc-mdb-ms }} cluster create <cluster name> \
         --sqlserver-version=<{{ MS }} version:{{ versions.cli.str }}> \
         --environment=<environment: PRESTABLE or PRODUCTION> \
         --host zone-id=<availability zone>,`
               `subnet-id=<subnet ID>,`
               `assign-public-ip=<host access via public IP: true or false> \
         --network-name=<network name> \
         --user name=<username>,`
               `password=<user password> \
         --database name=<database name> \
         --resource-preset=<host class> \
         --disk-size=<storage capacity, GB> \
         --disk-type=<storage type> \
         --security-group-ids=<security group ID list> \
         --deletion-protection=<cluster deletion protection: true or false>
      ```

      {% note info %}

      The cluster name must be unique within a folder. It may contain Latin letters, numbers, hyphens, and underscores. The maximum name length is 63 characters.

      {% endnote %}

      Where:

      * `--sqlserver-version`: The {{ MS }} version.
      * `--environment`: Environment:
         * `PRODUCTION`: For stable versions of your apps.
         * `PRESTABLE`: For testing, including the {{ MS }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.
      * `--host`: Host parameters:
         * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
         * `subnet-id`: [Subnet ID](../../vpc/concepts/network.md#subnet). It is required if the selected availability zone includes 2 or more subnets.
         * `assign-public-ip`: Flag to specify if a host requires a [public IP address](../../vpc/concepts/address.md#public-addresses).
      * `--network-name`: The [name of the network](../../vpc/concepts/network.md#network).
      * `--user`: User parameters:
         * `name`: First name. It may contain Latin letters, numbers, hyphens, and underscores, but must start with a letter, a number, or an underscore. It can be between 1 and 32 characters long.
         * `password`: Password. From 8 to 128 characters.
      * `--database name`: Database name. It may contain Latin letters, numbers, hyphens, and underscores. The maximum name length is 63 characters.
      * `--resource-preset`: [host class](../concepts/instance-types.md#available-flavors).
      * `--disk-size`: Storage size in GB.
      * `--disk-type`: [Storage type](../concepts/storage.md):
         * `network-hdd`
         * `network-ssd`
         * `local-ssd`
         * `network-ssd-nonreplicated`
      * `--security-group-ids`: list of [security group](../../vpc/concepts/security-groups.md) IDs.
      * `--deletion-protection`: Cluster deletion protection.


           {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

   1. To set a backup start time, pass the desired value in `HH:MM:SS` format in `--backup-window-start`:

      ```bash
      {{ yc-mdb-ms }} cluster create <cluster name> \
         ...
         --backup-window-start=<backup start time>
      ```

   
   1. To create a cluster deployed on groups of [dedicated hosts](../../compute/concepts/dedicated-host.md), specify host IDs as a comma-separated list in the `--host-group-ids` parameter:

      ```bash
      {{ yc-mdb-ms }} cluster create <cluster name> \
         ...
         --host-group-ids=<IDs of groups of dedicated hosts>
      ```

      {% include [Dedicated hosts note](../../_includes/mdb/mms/note-dedicated-hosts.md) %}

   1. To link a [service account](../../iam/concepts/users/service-accounts.md) to a cluster to configure communication with other {{ yandex-cloud }} resources, pass its [ID](../../iam/operations/sa/get-id.md) in the `--service-account-id` parameter:

      ```bash
      {{ yc-mdb-ms }} cluster create <cluster name> \
         ...
         --service-account-id: The ID of your service account.
      ```


- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To create a cluster:

   1. In the configuration file, describe the parameters of resources that you want to create:

      * Database cluster: Description of the cluster and its hosts.

      * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

      * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

      Example configuration file structure:

      ```hcl
      resource "yandex_mdb_sqlserver_cluster" "<cluster name>" {
        name                = "<cluster name>"
        environment         = "<environment: PRESTABLE or PRODUCTION>"
        network_id          = "<network ID>"
        version             = "<{{ MS }} version: {{ versions.tf.str }}>"
        security_groups_id  = ["<security group ID list>"]
        deletion_protection = <cluster deletion protection: true or false>

        resources {
          resource_preset_id = "<host class>"
          disk_type_id       = "<storage type>"
          disk_size          = <storage capacity, GB>
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
            roles         = ["<role list>"]
          }
        }

        backup_window_start {
          hours   = <backup start hour>
          minutes = <backup start minute>
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

      1. To create a cluster deployed on groups of [dedicated hosts](../../compute/concepts/dedicated-host.md), add the `host_group_ids` field to the cluster description and specify the required group IDs as a comma-separated list in it:

         ```hcl
         resource "yandex_mdb_sqlserver_cluster" "<cluster name>" {
           ...
           host_group_ids = [ "<ID 1>", "<ID 2>", ... ]
           ...
         }
         ```

         {% include [Dedicated hosts note](../../_includes/mdb/mms/note-dedicated-hosts.md) %}

      For more information on resources that you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-mms }}).

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Create a cluster.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      After this, all the necessary resources will be created in the specified folder and the IP addresses of the VMs will be displayed in the terminal. You can check that the resources are there with the correct settings, using the [management console]({{ link-console-main }}).

      {% include [Terraform timeouts](../../_includes/mdb/mms/terraform/timeouts.md) %}

- API

   Use the [create](../api-ref/Cluster/create.md) API method and pass the following information in the request:
   * In the `folderId` parameter, the ID of the folder where the cluster should be placed.
   * The cluster name in the `name` parameter.
   * Cluster configuration, in the `configSpec` parameter.
   * Configuration of the cluster hosts, in one or more `hostSpecs` parameters.
   * Cluster database configuration in one or more `databaseSpecs` parameters.
   * Configuration of cluster database accounts in one or more `userSpecs` parameters.
   * Network ID, in the `networkId` parameter.
   * The name of the cluster database collation settings in the `sqlcollation` parameter.
   * Cluster deletion protection settings in the `deletionProtection` parameter.

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

   
   To create a cluster deployed on groups of [dedicated hosts](../../compute/concepts/dedicated-host.md), pass a list of host IDs in the `hostGroupIds` parameter.

   {% include [Dedicated hosts note](../../_includes/mdb/mms/note-dedicated-hosts.md) %}

   To link a [service account](../../iam/concepts/users/service-accounts.md) to a cluster, pass its [ID](../../iam/operations/sa/get-id.md) in the `serviceAccountId` parameter.


{% endlist %}

{% note warning %}

If you specified security group IDs when creating a cluster, you may also need to [configure security groups](./connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}

## Examples {#examples}

### Creating a single-host cluster

{% list tabs %}

- CLI

   To create a cluster with a single host, pass a single `--host` parameter.

   Let's say we need to create a {{ MS }} cluster with the following characteristics:

   
   * Named `mssql-1`.
   * Versions `{{ versions.cli.latest.long-std }}`.
   * In the `PRODUCTION` environment.
   * In the `default` network.
   * In the security group `{{ security-group }}`.
   * With a single class `s2.small` host in a subnet called `b0cd5bv7pfpr7r900tkp` in the `{{ zone-id }}` availability zone.
   * With a network SSD storage (`{{ disk-type-example }}`) of 20 GB.
   * With one user, `user1`, with the password `user1user1`.
   * With one database, `db1`.
   * With protection against accidental cluster deletion.


   Run the command:

   
   ```bash
   {{ yc-mdb-ms }} cluster create \
      --name=mssql-1 \
      --sqlserver-version={{ versions.cli.latest.std }} \
      --environment=PRODUCTION \
      --network-name=default \
      --resource-preset=s2.small \
      --host zone-id={{ region-id }}-a,`
            `subnet-id=b0cd5bv7pfpr7r900tkp \
      --disk-type={{ disk-type-example }} \
      --disk-size=20 \
      --user name=user1,`
            `password=user1user1 \
      --database name=db1 \
      --security-group-ids={{ security-group }} \
      --deletion-protection=true
   ```


- {{ TF }}

   Let's say we need to create a {{ MS }} cluster and a network for it with the following characteristics:

   * Named `mssql-1`.
   * In the `PRODUCTION` environment.
   * With {{ MS }} version `{{ versions.tf.latest.long-std }}`.
   * In the cloud with the ID `{{ tf-cloud-id }}`.
   * In the folder with the ID `{{ tf-folder-id }}`.
   * In the new `mynet` network.
   * In a new security group called `ms-sql-sg` allowing cluster connections from the internet via port `{{ port-mms }}`.
   * With a single `s2.small` class host on a new `mysubnet` subnet and in the `{{ zone-id }}` availability zone. The `mysubnet` subnet will have a range of `10.5.0.0/24`.
   * With 32 GB of network SSD storage.
   * With a database called `db1`.
   * With the user `user1` and `user1user1` as the password. This user will be the owner of the `db1` database ([predefined role `DB_OWNER`](./grant.md#predefined-db-roles)).
   * With protection against accidental cluster deletion.

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
      token     = "<OAuth or service account static key>"
      cloud_id  = "{{ tf-cloud-id }}"
      folder_id = "{{ tf-folder-id }}"
      zone      = "{{ region-id }}-a"
    }

    resource "yandex_mdb_sqlserver_cluster" "mssql-1" {
      name                = "mssql-1"
      environment         = "PRODUCTION"
      version             = "{{ versions.tf.latest.std }}"
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
