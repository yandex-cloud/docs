# Creating a {{ MS }} cluster

{{ MS }} cluster: one or more database hosts. [Replication](../concepts/replication.md) works by default in any cluster with more than 1 host: the primary replica accepts read and write requests and propagates changes to the secondary replicas at the same time.

{% note info %}

If database storage is 95% full, the cluster switches to read-only mode. Plan and increase the required storage size in advance.

{% endnote %}

{% if audience != "internal" %}

The number of hosts that can be created together with a {{ MS }} cluster depends on the selected [type of storage](../concepts/storage.md):

* With **local SSD** or **non-replicated SSD** storage, you can create a cluster with three or more hosts (a minimum of three hosts is required for fault tolerance).
* With **network HDD** or **network SSD** storage, you can add any number of hosts within the [current quota](../concepts/limits.md).

After creating a cluster, you can add extra hosts to it if there are enough available [folder resources](../concepts/limits.md).

{% endif %}

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
  1. Select the DBMS version. Currently, we support the following versions: {{ versions.console.str }}.

      For more information, see [{#T}](../concepts/index.md).

   1. Select the host class to define the technical specifications of the VMs where the database hosts will be deployed. All available options are listed in [{#T}](../concepts/instance-types.md). When you change the host class for the cluster, the characteristics of all existing hosts change, too.
   1. Under **Storage size**:

      {% if audience != "internal" %}

      * Select the [storage type](../concepts/storage.md).

         {% include [storages-step-settings](../../_includes/mdb/settings-storages-no-broadwell.md) %}

      {% endif %}

      * Select the size to be used for data and backups. For more information about how backups take up storage space, see [{#T}](../concepts/backup.md).
   1. Under **Database**, specify the database attributes:

      * Database name. This name must be unique within the folder and contain only Latin letters, numbers, and underscores.
      * Username of the database owner. This name may only contain Latin letters, numbers, and underscores. By default, the new user is assigned 50 connections to each host in the cluster.
      * User password (from 8 to 128 characters).

   1. Under **Network settings**, select the cloud network to host the cluster in and security groups for cluster network traffic. You may also need to [set up security groups](connect.md#configuring-security-groups) to connect to the cluster.

   1. Under **Hosts**:

      1. Select the database host parameters for databases being created alongside the cluster. By default, each host is created in a separate subnet. To select a specific subnet for a host, click ![image](../../_assets/pencil.svg) in the host's row and select the desired availability zone and subnet.

         {% note warning %}

         The number of hosts available to be added depends on the SQL Server [edition](../concepts/index.md):

         * In the **Standard Edition**, you can only create a single-host cluster. This cluster does not provide any fault tolerance.
         * In the **Enterprise Edition**, you can create clusters of either one or three of more hosts. If you selected `local-ssd` or `network-ssd-nonreplicated` under **Storage**, you need to add at least 3 hosts to the cluster.

         {% endnote %}

      {% if audience != "internal" %}

      1. (Optional) Select groups of [dedicated hosts](../../compute/concepts/dedicated-host.md) to host the cluster on.

         {% include [Dedicated hosts note](../../_includes/mdb/mms/note-dedicated-hosts.md) %}

      {% endif %}

   1. If necessary, configure additional cluster settings:

      {% include [extra-settings-create](../../_includes/mdb/mms/extra-settings-create.md) %}

   1. If necessary, configure the [DBMS settings](../concepts/settings-list.md).
   1. Click **Create cluster**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a cluster:

   {% if audience != "internal" %}

   1. Check whether the folder has any subnets for the cluster hosts:

      ```bash
      yc vpc subnet list
      ```

      If there are no subnets in the folder, [create the necessary subnets](../../vpc/operations/subnet-create.md) in {{ vpc-short-name }}.

   {% endif %}

   1. View a description of the CLI's create cluster command:

      ```bash
      {{ yc-mdb-ms }} cluster create --help
      ```

   1. Specify cluster parameters in the create command (the list of supported parameters in the example is not exhaustive):

      {% if audience != "internal" %}

      ```bash
      {{ yc-mdb-ms }} cluster create <cluster name> \
         --sqlserver-version=<{{ MS }} version> \
         --environment=<environment: PRESTABLE or PRODUCTION> \
         --host zone-id=<availability zone>,`
               `subnet-id=<subnet ID>,`
               `assign-public-ip=<host access via public IP: true or false> \
         --network-name=<network name> \
         --user name=<user name>,`
               `password=<user password> \
         --database name=<database name> \
         --resource-preset=<host class> \
         --disk-size=<storage capacity, GB> \
         --disk-type=<storage type> \
         --security-group-ids=<security group ID list> \
         --deletion-protection=<protect cluster from deletion: true or false>
      ```

      {% note info %}

      The cluster name must be unique within a folder. May contain letters, numbers, hyphens, and underscores. The maximum name length is 63 characters.

      {% endnote %}

      Where:

      * `--sqlserver-version`: The {{ MS }} version.
      * `--environment`: environment:
         * `PRESTABLE`: For stable versions of your applications.
         * `PRODUCTION`: For testing, including testing {{ MS }} itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.
      * `--host`: Host parameter:
         * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
         * `subnet-id`: [Subnet ID](../../vpc/concepts/network.md#subnet). Must be specified, if the availability zone in question includes 2 or more subnets.
         * `assign-public-ip`: Flag to specify if a host requires a [public IP address](../../vpc/concepts/address.md#public-addresses).
      * `--network-name`: The [name of the network](../../vpc/concepts/network.md#network).
      * `--user`: User parameters:
         * `name`: First name. May contain letters, numbers, hyphens, and underscores but must start with a letter, a number, or an underscore. It can be between 1 and 32 characters long.
         * `password`: Password. From 8 to 128 characters.
      * `--database name`: database name. May contain letters, numbers, hyphens, and underscores. The maximum name length is 63 characters.
      * `--resource-preset`: [host class](../concepts/instance-types.md#available-flavors).
      * `--disk-size`: Storage size in GB.
      * `--disk-type`: [Storage type](../concepts/storage.md):
         * `network-hdd`;
         * `network-ssd`;
         * `local-ssd`;
         * `network-ssd-nonreplicated`.
      * `--security-group-ids`: list of [security group](../../vpc/concepts/security-groups.md) IDs.
      * `--deletion-protection`: Protect cluster from deletion.

      {% else %}

      ```bash
      {{ yc-mdb-ms }} cluster create <cluster name> \
         --sqlserver-version=<{{ MS }} version> \
         --environment=<environment: PRESTABLE or PRODUCTION> \
         --host zone-id=<availability zone> \
         --network-name=<network name> \
         --user name=<user name>,`
               `password=<user password> \
         --database name=<database name> \
         --resource-preset=<host class> \
         --disk-size=<storage capacity, GB> \
         --security-group-ids=<security group ID list> \
         --deletion-protection=<protect cluster from deletion: true or false>
      ```

      {% note info %}

      The database name must be unique within a folder. May contain letters, numbers, hyphens, and underscores. The maximum name length is 63 characters.

      {% endnote %}

      Where:

      * `--sqlserver-version`: The {{ MS }} version.
      * `--environment`: environment:
         * `PRESTABLE`: For stable versions of your applications.
         * `PRODUCTION`: For testing, including testing {{ MM }} itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.
      * `--host zone-id`: [availability zone](../../overview/concepts/geo-scope.md).
      * `--network-name`: The [name of the network](../../vpc/concepts/network.md#network).
      * `--user`: User parameters:
         * `name`: First name. May contain letters, numbers, hyphens, and underscores but must start with a letter, a number, or an underscore. It can be between 1 and 32 characters long.
         * `password`: Password. From 8 to 128 characters.
      * `--database name`: database name. May contain letters, numbers, hyphens, and underscores. The maximum name length is 63 characters.
      * `--resource-preset`: [host class](../concepts/instance-types.md#available-flavors).
      * `--disk-size`: Storage size in GB.
      * `--security-group-ids`: list of [security group](../../vpc/concepts/security-groups.md) IDs.
      * `--deletion-protection`: Protect cluster from deletion.

      {% endif %}

           {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

   1. To set backup start time, pass the desired value in `HH:MM:SS` format in in `--backup-window-start`:

      ```bash
      {{ yc-mdb-ms }} cluster create <cluster name> \
         ...
         --backup-window-start=<backup start time>
      ```

   {% if audience != "internal" %}

   1. To create a cluster deployed on groups of [dedicated hosts](../../compute/concepts/dedicated-host.md), specify the host IDs as a comma-separated list in the `--host-group-ids` parameter when creating the cluster:

      ```bash
      {{ yc-mdb-ms }} cluster create <cluster name> \
         ...
         --host-group-ids=<ID of groups of dedicated hosts>
      ```

      {% include [Dedicated hosts note](../../_includes/mdb/mms/note-dedicated-hosts.md) %}

   {% endif %}

- Terraform

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
          deletion_protection = <protect cluster from deletion: true or false>

        resources {
          resource_preset_id = "<class host>"
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
          name     = "<user name>"
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

      1. To create a cluster deployed on groups of [dedicated hosts](../../compute/concepts/dedicated-host.md), add the `host_group_ids` field to the cluster description and use it to specify the requisite group IDs as a comma-separated list:

         ```hcl
         resource "yandex_mdb_sqlserver_cluster" "<cluster name>" {
           ...
           host_group_ids = [ "<ID 1>", "<ID 2>", ... ]
           ...
         }
         ```

         {% include [Dedicated hosts note](../../_includes/mdb/mms/note-dedicated-hosts.md) %}

      For more information on resource that you can create with {{ TF }}, please review the [provider documentation]({{ tf-provider-mms }}).

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Create a cluster.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      After this, all the necessary resources will be created in the specified folder and the IP addresses of the VMs will be displayed in the terminal. You can check that the resources appear with the correct settings, using the [management console]({{ link-console-main }}).

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

   {% if audience != "internal" %}

   To create a cluster deployed on groups of [dedicated hosts](../../compute/concepts/dedicated-host.md), pass a list of host IDs in the `hostGroupIds` parameter.

   {% endif %}

   {% include [Dedicated hosts note](../../_includes/mdb/mms/note-dedicated-hosts.md) %}

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

   {% if audience != "internal" %}

   * `mssql-1` as the name.
   * Version `2016 SP2 Standard Edition`.
   * In the `PRODUCTION` environment.
   * In the `default` network.
   * In the security group `{{ security-group }}`.
   * With a single class `s2.small` host in a subnet called `b0cd5bv7pfpr7r900tkp` in the `{{ region-id }}-a` availability zone.
   * With 10 GB of SSD network storage (`{{ disk-type-example }}`).
   * With one user, `user1`, with the password `user1user1`.
   * With one database, `db1`.
   * With protection against accidental cluster deletion.

   {% else %}

   * `mssql-1` as the name.
   * Version `2016 SP2 Standard Edition`
   * In the `PRODUCTION` environment.
   * In the security group `{{ security-group }}`.
   * With a single `db1.micro` class host in the `man` availability zone.
   * With 20 GB fast local storage (`local-ssd`).
   * With one user, `user1`, with the password `user1user1`.
   * With one database, `db1`.
   * With protection against accidental cluster deletion.

   {% endif %}

   Run the command:

   {% if audience != "internal" %}

   ```bash
   {{ yc-mdb-ms }} cluster create \
      --name=mssql-1 \
      --sqlserver-version=2016sp2std \
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

   {% else %}

   ```bash
   {{ yc-mdb-ms }} cluster create \
      --name=mssql-1 \
      --sqlserver-version=2016sp2std \
      --environment=PRODUCTION \
      --network-id=' ' \
      --host zone-id=man \
      --resource-preset=db1.micro \
      --disk-type=local-ssd \
      --disk-size=20 \
      --user name=user1,`
            `password=user1user1 \
      --database name=db1 \
      --security-group-ids={{ security-group }}
   ```

   {% endif %}

- Terraform

   Let's say we need to create a {{ MS }} cluster and a network for it with the following characteristics:

    * `mssql-1` as the name.
    * In the `PRODUCTION` environment.
    * Using the {{ MS }} `{{ versions.tf.latest.long-std }}`.
    * In the cloud with the ID `{{ tf-cloud-id }}`.
    * In the folder with the ID `{{ tf-folder-id }}`.
    * In the new `mynet` network.
    * In a new security group called `ms-sql-sg` allowing cluster connections from the Internet via port `{{ port-mms }}`.
    * With a single host of the `s2.small` class on a new `mysubnet` subnet and the `{{ region-id }}-a` availability zone. The `mysubnet` subnet will have a range of `10.5.0.0/24`.
    * With 32 GB of network SSD storage.
    * With a database called `db1`.
    * With a user with `user1` as the login and `user1user1` as the password. This user will own the `db1` database ([predefined role `DB_OWNER`](./grant.md#predefined-db-roles)).
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
      token     = "<OAuth or static key of service account>"
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
       zone             = "{{ region-id }}-a"
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
     zone           = "{{ region-id }}-a"
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
      token     = "<static key of the service account>"
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
        zone             = "{{ region-id }}-a"
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
      zone           = "{{ region-id }}-a"
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

    {% endif %}

{% endlist %}
