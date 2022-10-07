# Creating {{ PG }} clusters

{{ PG }} clusters are one or more database hosts that replication can be configured between. Replication is enabled by default in any cluster consisting of more than one host: the master host accepts write requests and duplicates changes on replicas. The transaction is confirmed if the data is written to disk both on the master host and on a certain number of replicas sufficient to [establish a quorum](../concepts/replication.md).

{% note info %}

* The number of hosts you can create together with a {{ PG }} cluster depends on the selected {% if audience != "internal" %}[storage type](../concepts/storage.md#storage-type-selection){% else %}[storage type](../concepts/storage.md){% endif %} and [host class](../concepts/instance-types.md#available-flavors).
* Available storage types [depend](../concepts/storage.md) on the selected [host class](../concepts/instance-types.md#available-flavors).
* If database storage is 95% full, the cluster switches to read-only mode. Plan and increase the required storage size in advance.

{% endnote %}

By default, {{ mpg-short-name }} sets the maximum number of connections to each {{ PG }} cluster host. This maximum cannot be greater than the value of [Max connections](../concepts/settings-list.md#setting-max-connections).

{% include [note-pg-user-connections.md](../../_includes/mdb/note-pg-user-connections.md) %}

## How to create a {{ PG }} cluster {#create-cluster}

{% list tabs %}

- Management console

   1. In the management console, select the folder where you want to create a database cluster.
   1. Select **{{ mpg-name }}**.
   1. Click **Create cluster**.
   1. Name the cluster in the **Cluster name** field. The cluster name must be unique within the folder.
   1. Select the environment where you want to create the cluster (you can't change the environment once the cluster is created):
      * `PRODUCTION`: For stable versions of your apps.
      * `PRESTABLE`: For testing, including the {{ mpg-short-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.
   1. Select the DBMS version.

      {% note info %}

      When you select the host class version `12-1c` ({{ PG }} 12 for 1C), consider the number of users in your 1C:Enterprise installation:
      * For 50 or more users connecting at the same time, we recommend using `s2.medium`.
      * For fewer than 50 users, `s2.small` is sufficient.

      {% endnote %}

   1. Select the host class to define the technical specifications of the VMs where the database hosts will be deployed. All available options are listed in [{#T}](../concepts/instance-types.md). When you change the host class for the cluster, the characteristics of all existing hosts change, too.
   1. Under **Storage size**:

      {% if audience != "internal" %}

      * Select the [storage type](../concepts/storage.md).

         {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}

      {% endif %}

      * Select the size to be used for data and backups. For more information about how backups take up storage space, see [{#T}](../concepts/backup.md).

   1. Under **Database**, specify the database attributes:

      * Database name. This name must be unique within the folder and contain only Latin letters, numbers, and underscores.
      * Username of the database owner. This name may only contain Latin letters, numbers, and underscores. By default, the new user is assigned 50 connections to each host in the cluster.
      * User password (from 8 to 128 characters).
      * Locale for sorting and character set locale. These settings define the rules for sorting strings (`LC_COLLATE`) and classifying characters (`LC_CTYPE`). In {{ mpg-name }}, locale settings apply at the individual database level.

         {% include [postgresql-locale](../../_includes/mdb/mpg-locale-settings.md) %}

   1. Under **Network settings**, select the cloud network to host the cluster in and security groups for cluster network traffic. You may also need to [set up security groups](connect.md#configuring-security-groups) to connect to the cluster.

   1. Under **Hosts**, select the parameters for the database hosts created with the cluster. If you open **Advanced settings**, you can choose specific subnets for each host. By default, each host is created in a separate subnet.

      When configuring the host parameters, note that if you selected `local-ssd`{% if audience != "internal" %} or `network-ssd-nonreplicated`{% endif %} under **Storage**, you need to add at least 3 hosts to the cluster.

   1. If necessary, configure additional cluster settings:

      {% include [Additional cluster settings](../../_includes/mdb/mpg/extra-settings-web-console.md) %}

   1. If required, configure [DBMS cluster-level settings](../concepts/settings-list.md#dbms-cluster-settings).

      {% note info %}

      Some {{ PG }} settings [depend on the selected host class or storage size](../concepts/settings-list.md#settings-instance-dependent).

      {% endnote %}

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
      {{ yc-mdb-pg }} cluster create --help
      ```

   1. Specify cluster parameters in the create command (the list of supported parameters in the example is not exhaustive):

   {% if audience != "internal" %}

       ```bash
       {{ yc-mdb-pg }} cluster create \
          --name <cluster name> \
          --environment <environment, prestable or production> \
          --network-name <network name> \
          --host zone-id=<availability zone>,subnet-id=<subnet ID> \
          --resource-preset <host class> \
          --user name=<username>,password=<user password> \
          --database name=<database name>,owner=<database owner name> \
          --disk-size <storage size, GB> \
          --disk-type <network-hdd | network-ssd | local-ssd | network-ssd-nonreplicated> \
          --security-group-ids <list of IDs for security groups> \
          --connection-pooling-mode=<connection manager operating mode> \
          --deletion-protection=<cluster deletion protection: true or false> \
          --serverless-access
       ```

       Specify the `subnet-id` if there are 2 or more subnets in the selected availability zone.

   {% else %}

       ```bash
       {{ yc-mdb-pg }} cluster create \
          --name <cluster name> \
          --environment <environment, prestable or production> \
          --network-id {{ network-name }} \
          --host zone-id=<availability zone> \
          --resource-preset <host class> \
          --user name=<username>,password=<user password> \
          --database name=<database name>,owner=<database owner name> \
          --disk-size <storage size, GB> \
          --security-group-ids <list of IDs for security groups> \
          --serverless-access=<true or false>
       ```

   {% endif %}

       Available [connection pooler modes](../concepts/pooling.md): `SESSION`, `TRANSACTION`, or `STATEMENT`.

       {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

       You also can specify several more options in the `--host` parameter to manage replication in the cluster:
       * The source of replication for the host in the `replication-source` option to [manage replication streams manually](../concepts/replication.md#replication-manual).
       * The priority of the host in the `priority` option to [affect the master selection process](../concepts/replication.md#selecting-the-master):
         * A host with the highest priority in the cluster becomes a synchronous replica.
         * If the cluster has multiple hosts with the highest priority, the master host is elected from among them.
         * The lowest priority value is `0` (default) and the highest is `100`.

       {% if product == "yandex-cloud" %}
       {% if audience != "internal" %}

       To allow access to the cluster from [{{ sf-full-name }}](../../functions/concepts/index.md), pass the `--serverless-access` parameter. For more information about access setup, see the documentation for [{{ sf-name }}](../../functions/operations/database-connection.md).

       {% else %}

       To allow access to the cluster from {{ sf-full-name }}, pass the --serverless-access parameter.

       {% endif %}
       {% endif %}

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}
   {% if audience != "internal" %}

   If you don't have {{ TF }}, [install it and configure the provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% else %}

   If you don't have {{ TF }}, install it and configure the provider.

   {% endif %}

   To create a cluster:

   1. In the configuration file, describe the parameters of resources that you want to create:

      * Database cluster: Description of the cluster and its hosts.

      * Database: Description of the cluster's database.

      * User: Description of the cluster user.

      * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

      * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

      Example configuration file structure:

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
        token     = "<An OAuth or static key of the service account>"
        cloud_id  = "<cloud ID>"
        folder_id = "<folder ID>"
        zone      = "<availability zone>"
      }

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
            disk_type_id       = "<storage type>"
            disk_size          = <storage type, GB>
          }
          pooler_config {
            pool_discard = <Odyssey pool_discard parameter: true or false>
            pooling_mode = "<operating mode: SESSION, TRANSACTION, or STATEMENT>"
          }
          ...
        }

        host {
          zone      = "<availability zone>"
          subnet_id = "<subnet ID>"
        }
      }

      resource "yandex_mdb_postgresql_database" "<database name>" {
        cluster_id = "<cluster ID>"
        name       = "<database name>"
        owner      = "<database owner name>"
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
        cloud_id  = "<cloud ID>"
        folder_id = "<folder ID>"
        zone      = "<availability zone>"
      }

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
            disk_type_id       = "<storage type>"
            disk_size          = <storage type, GB>
          }
          pooler_config {
            pool_discard = <Odyssey pool_discard parameter: true or false>
            pooling_mode = "<operating mode: SESSION, TRANSACTION, or STATEMENT>"
          }
          ...
        }

        host {
          zone      = "<availability zone>"
          subnet_id = "<subnet ID>"
        }
      }

      resource "yandex_mdb_postgresql_database" "<database name>" {
        cluster_id = "<cluster ID>"
        name       = "<database name>"
        owner      = "<database owner name>"
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

      {% endif %}

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

   Use the [create](../api-ref/Cluster/create.md) API method and pass the following information in the request:

   * In the `folderId` parameter, the ID of the folder where the cluster should be placed.
   * The cluster name in the `name` parameter.
   * The environment of the cluster, in the `environment` parameter.
   * Network ID, in the `networkId` parameter.
   * Cluster configuration, in the `configSpec` parameter.
   * Configuration of the cluster hosts, in one or more `hostSpecs` parameters.
   * Security [group identifiers](../concepts/network.md#security-groups), in the `securityGroupIds` parameter.
   * Database configuration, in one or more `databaseSpecs` parameters.
   * User settings, in one or more `userSpecs` parameters.

   {% include [datatransfer access](../../_includes/mdb/api/datatransfer-access-create.md) %}

   {% if product == "yandex-cloud" %}
   {% if audience != "internal" %}

   To allow cluster access from [{{ sf-full-name }}](../../functions/concepts/index.md), pass `true` for the `configSpec.access.serverless` parameter. For more detail on setting up access, see the [{{ sf-name }}](../../functions/operations/database-connection.md).

   {% else %}

   To allow cluster access from {{ sf-full-name }}, pass `true` for the `configSpec.access.serverless` parameter.

   {% endif %}
   {% endif %}

   To enable [statistics collection](./performance-diagnostics.md#activate-stats-collector):

   {% include [Performance diagnostic API](../../_includes/mdb/mpg/performance-diagnostics-api.md) %}

{% endlist %}

{% note warning %}

If you specified security group IDs when creating a cluster, you may also need to [configure security groups](connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}

## Examples {#examples}

### Creating a single-host cluster {#creating-a-single-host-cluster}

{% list tabs %}

- CLI

   To create a cluster with a single host, pass a single `--host` parameter.

   Create a {{ mpg-name }} cluster with test characteristics:

   {% if audience != "internal" %}

   * Named `mypg`.
   * In the `production` environment.
   * In the `default` network.
   * In the security group `{{ security-group }}`.
   * With one `{{ host-class }}` host in the `b0rcctk2rvtr8efcch64` subnet in the `{{ region-id }}-a` availability zone.
   * With a network SSD storage (`{{ disk-type-example }}`) of 20 GB.
   * With one user, `user1`, with the password `user1user1`.
   * With one `db1` database owned by the user `user1`.
   * With protection against accidental cluster deletion.

   {% else %}

   * Named `mypg`.
   * In the `production` environment.
   * In the security group `{{ security-group }}`.
   * With a single `db1.micro` class host in the `man` availability zone.
   * With 20 GB of local SSD storage (`local-ssd`).
   * With one user, `user1`, with the password `user1user1`.
   * With one `db1` database owned by the user `user1`.
   * With protection against accidental cluster deletion.

   {% endif %}

   Run the following command:

   {% if audience != "internal" %}

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

   {% else %}

   ```bash
   {{ yc-mdb-pg }} cluster create \
      --name mypg \
      --environment production \
      --network-id ' ' \
      --host zone-id=man \
      --resource-preset db1.micro \
      --disk-type local-ssd \
      --disk-size 20 \
      --user name=user1,password=user1user1 \
      --database name=db1,owner=user1 \
      --security-group-ids {{ security-group }}
   ```

   {% endif %}

- {{ TF }}

   Create a {{ mpg-name }} cluster and a network for it with test characteristics:

   * Named `mypg`.
   * Versions `{{ pg.versions.tf.latest }}`.
   * In the `PRESTABLE` environment.
   * In the cloud with the ID `{{ tf-cloud-id }}`.
   * In the folder with the ID `{{ tf-folder-id }}`.
   * In the new `mynet` network.
   * In the new security group `pgsql-sg` allowing connections to the cluster from the internet via port `6432`.
   * With one `{{ host-class }}` host in the new `mysubnet` subnet and `{{ region-id }}-a` availability zone. The `mysubnet` subnet will have a range of `10.5.0.0/24`.
   * With a network SSD storage (`{{ disk-type-example }}`) of 20 GB.
   * With one user, `user1`, with the password `user1user1`.
   * With one `db1` database owned by the user `user1`.
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
     token     = "<OAuth or static key of the service account>"
     cloud_id  = "{{ tf-cloud-id }}"
     folder_id = "{{ tf-folder-id }}"
     zone      = "{{ region-id }}-a"
   }

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

   {% endif %}

{% endlist %}
