---
title: "How to create a {{ MY }} cluster"
description: "Use this tutorial to create a {{ MY }} cluster with a single or multiple DB hosts."
---

# Creating {{ MY }} clusters

A {{ MY }} cluster consists of one or more database hosts. In multi-host clusters, [semi-synchronous replication](../concepts/replication.md) is configured automatically.

For more about {{ mmy-name }} cluster structure, see [{#T}](../concepts/index.md).

{% note info %}

* The number of hosts you can create together with a {{ MY }} cluster depends on the selected [disk type](../concepts/storage.md#storage-type-selection) and [host class](../concepts/instance-types.md#available-flavors).
* Available disk types [depend](../concepts/storage.md) on the selected [host class](../concepts/instance-types.md#available-flavors).

{% endnote %}

## How to create a {{ MY }} cluster {#create-cluster}

{% list tabs %}

- Management console


   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a DB cluster.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
   1. Enter a name for the {{ mmy-name }} cluster in the **{{ ui-key.yacloud.mdb.forms.base_field_name }}** field. The cluster name must be unique within the folder.
   1. Select the environment where you want to create the {{ mmy-name }} cluster (you cannot change the environment once the cluster is created):
      * `PRODUCTION`: For stable versions of your apps.
      * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and is also covered by the SLA. However, it is the first to receive new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.
   1. Select the DBMS version.
   1. Select the host class that defines the technical specifications of the [VMs](../../compute/concepts/vm-platforms.md) where the DB hosts will be deployed. All available options are listed in [{#T}](../concepts/instance-types.md). When you change the host class for the {{ mmy-name }} cluster, the characteristics of all existing hosts change, too.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_disk }}**:

      * Select the [disk type](../concepts/storage.md).

         
         {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}


      * Select the storage size to be used for data and backups. For more information about how backups take up storage space, see [{#T}](../concepts/backup.md).

         {% note info %}

         If the DB storage is 95% full, the {{ mmy-name }} cluster will switch to read-only mode. Increase the storage size in advance.

         {% endnote %}

   1. Under **{{ ui-key.yacloud.mdb.forms.section_database }}**, specify the DB attributes:
      * DB name; it must be unique within the folder.

         {% include [db-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

      * DB owner username and password.

         {% include [user-name-and-passwords-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

   
   1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**, select:
      * [Cloud network](../../vpc/concepts/network.md#network) for the {{ mmy-name }} cluster.
      * [Security groups](../../vpc/concepts/security-groups.md) for the {{ mmy-name }} cluster network traffic. You may also need to [set up security groups](connect.md#configuring-security-groups) to connect to the {{ mmy-name }} cluster.


   1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**, click ![image](../../_assets/edit.svg) and select the parameters for the DB hosts created together with the {{ mmy-name }} cluster:
      * Availability zone.
      * Host [subnet](../../vpc/concepts/network.md#subnet): By default, each host is created in a separate subnet.
      * Select **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** if the host must be accessible from outside {{ yandex-cloud }}.
      * [Priority for assigning the host as a master](../concepts/replication.md#master-failover).
      * [Host priority as a {{ MY }} replica](../concepts/backup.md#size) for creating backups.

      
      If you selected `local-ssd` or `network-ssd-nonreplicated` under **{{ ui-key.yacloud.mdb.forms.section_disk }}**, you need to add at least three hosts to the {{ mmy-name }} cluster. After creating a {{ mmy-name }} cluster, you can add extra hosts to it if there are enough [folder resources](../concepts/limits.md) available.


   1. Configure additional {{ mmy-name }} cluster settings, if required:

      {% include [mmy-extra-settings](../../_includes/mdb/mmy-extra-settings-web-console.md) %}

   1. If required, configure [DBMS cluster-level settings](../concepts/settings-list.md#dbms-cluster-settings).

      {% include [mmy-settings-dependence](../../_includes/mdb/mmy/note-info-settings-dependence.md) %}

   1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a {{ mmy-name }} cluster:

   
   1. Check whether the folder has any [subnets](../../vpc/concepts/network.md#subnet) for the {{ mmy-name }} cluster hosts:

      ```bash
      yc vpc subnet list
      ```

      If there are no subnets in the folder, [create the required subnets](../../vpc/operations/subnet-create.md) in [{{ vpc-full-name }}](../../vpc/).


   1. View a description of the create {{ mmy-name }} cluster CLI command:

      ```bash
      {{ yc-mdb-my }} cluster create --help
      ```

   1. Specify the {{ mmy-name }} cluster parameters in the create command:

      
      
      ```bash
      {{ yc-mdb-my }} cluster create \
        --name=<cluster name> \
        --environment <environment: prestable or production> \
        --network-name <network name> \
        --host zone-id=<availability zone>,`
          `subnet-id=<subnet ID>,`
          `assign-public-ip=<public access to the host: true or false>,`
          `priority=<priority when selecting a new master host: from 0 to 100>,`
          `backup-priority=<backup priority: from 0 to 100> \
        --mysql-version <{{ MY }} version: {{ versions.cli.str }}> \
        --resource-preset <host class> \
        --user name=<username>,password=<user password> \
        --database name=<DB name> \
        --disk-size <storage size in GB> \
        --disk-type <disk type> \
        --security-group-ids <list of security group IDs>
      ```

      You need to specify `subnet-id` if the selected [availability zone](../../overview/concepts/geo-scope.md) has two or more subnets.




      Configure additional {{ mmy-name }} cluster settings, if required:

      
      ```bash
      {{ yc-mdb-my }} cluster create \
        ...
        --backup-window-start <backup start time> \
        --backup-retain-period-days=<retention period for automatic backups, days> \
        --datalens-access=<cluster access from {{ datalens-name }}: true or false> \
        --websql-access=<queries from the management console: true or false> \
        --deletion-protection=<cluster deletion protection: true or false>
      ```



      {% include [db-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

      {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}

      Configure the [DBMS settings](../concepts/settings-list.md#dbms-cluster-settings), if required.

      {% note info %}

      When creating a cluster, the `anytime` [maintenance](../concepts/maintenance.md) mode is set by default. You can set a specific maintenance period when [updating the cluster settings](update.md#change-additional-settings).

      {% endnote %}

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To create a {{ mmy-name }} cluster:
   1. In the configuration file, describe the parameters of the resources you want to create:
      * DB cluster: Description of the cluster and its hosts
      * Database: Description of the cluster DB

         {% include [db-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

      * User: Description of the cluster user

      * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

      * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

      Example of the configuration file structure:

      
      
      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster name>" {
        name                = "<cluster name>"
        environment         = "<environment: PRESTABLE or PRODUCTION>"
        network_id          = "<network ID>"
        version             = "<{{ MY }} version: {{ versions.tf.str }}>"
        security_group_ids  = [ "<list of security groups>" ]
        deletion_protection = <cluster deletion protection: true or false>

        resources {
          resource_preset_id = "<host class>"
          disk_type_id       = "<disk type>"
          disk_size          = "<storage size in GB>"
        }

        host {
          zone             = "<availability zone>"
          subnet_id        = "<subnet ID>"
          assign_public_ip = <public access to the host: true or false>
          priority         = <priority when selecting a new master host: from 0 to 100>
          backup_priority  = <backup priority: from 0 to 100>
        }
      }

      resource "yandex_mdb_mysql_database" "<DB name>" {
        cluster_id = "<cluster ID>"
        name       = "<DB name>"
      }

      resource "yandex_mdb_mysql_user" "<username>" {
        cluster_id = "<cluster ID>"
        name       = "<username>"
        password   = "<user password>"
        permission {
          database_name = "<DB name>"
          roles         = ["ALL"]
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




      {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-db.md) %}

      * {% include [Maintenance window](../../_includes/mdb/mmy/terraform/maintenance-window.md) %}

      * {% include [Access settings](../../_includes/mdb/mmy/terraform/access-settings.md) %}

      * To set the [backup](../concepts/backup.md) start time, add the `backup_window_start` section to the {{ mmy-name }} cluster description:

         ```hcl
         resource "yandex_mdb_mysql_cluster" "<cluster name>" {
           ...
           backup_window_start {
             hours   = <backup start hour>
             minutes = <backup start minute>
           }
           ...
         }
         ```

      * To set the retention period for backup files, define the `backup_retain_period_days` parameter in the {{ mmy-name }} cluster description:

         ```hcl
         resource "yandex_mdb_mysql_cluster" "<cluster name>" {
           ...
             backup_retain_period_days = <retention period for automatic backups (in days)>
             ...

         }
         ```

         Acceptable values are from `7` to `60`. The default value is `7`.

      For more information about the resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-mmy }}).
   1. Make sure the configuration files are valid.

      {% include [terraform-create-cluster-step-2](../../_includes/mdb/terraform-create-cluster-step-2.md) %}

   1. Create a {{ mmy-name }} cluster.

      {% include [terraform-create-cluster-step-3](../../_includes/mdb/terraform-create-cluster-step-3.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API

   To create a {{ MY }} cluster, use the [create](../api-ref/Cluster/create.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Create](../api-ref/grpc/cluster_service.md#Create) gRPC API call and provide the following in the request:
   * ID of the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where the {{ mmy-name }} cluster should be placed, in the `folderId` parameter.
   * {{ mmy-name }} cluster name in the `name` parameter. The cluster name must be unique within the folder.
   * {{ mmy-name }} cluster environment in the `environment` parameter.
   * {{ mmy-name }} cluster configuration in the `configSpec` parameter.
   * DB configuration in one or more `databaseSpecs` parameters.

      {% include [db-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

   * User settings in one or more `userSpecs` parameters.
   * Configuration of the {{ mmy-name }} cluster hosts in one or more `hostSpecs` parameters.
   * [Network](../../vpc/concepts/network.md#network) ID in the `networkId` parameter.

   
   * [Security group](../concepts/network.md#security-groups) identifiers in the `securityGroupIds` parameter.


   If required, provide the [backup](../concepts/backup.md) start time in the `configSpec.backupWindowStart` parameter and the retention period for automatic backups (in days) in the `configSpec.backupRetainPeriodDays` parameter. Acceptable values are from `7` to `60`. The default value is `7`.

   {% include [datatransfer access](../../_includes/mdb/api/datatransfer-access-create.md) %}

   {% include [datalens access](../../_includes/mdb/api/datalens-access.md) %}

{% endlist %}


{% note warning %}

If you specified security group IDs when creating a {{ mmy-name }} cluster, you may also need to [configure security groups](connect.md#configure-security-groups) to connect to the cluster.

{% endnote %}


## Examples {#examples}

### Creating a single-host cluster {#creating-a-single-host-cluster}

{% list tabs %}

- CLI

   To create a {{ mmy-name }} cluster with a single host, provide a single `--host` parameter.

   Create a {{ mmy-name }} cluster with test characteristics:

   
   * Named `my-mysql`.
   * Versions `{{ versions.cli.latest }}`.
   * In the `production` environment.
   * In the `default` network.
   * In the security group with the ID `{{ security-group }}`.
   * With a single `{{ host-class }}` class host in the `{{ subnet-id }}` subnet, in the `{{ region-id }}-a` availability zone.
   * Network SSD storage (`{{ disk-type-example }}`): 20 GB
   * User: `user1`, with the `user1user1` password
   * Database: `db1`, in which `user1` has full rights (same as `GRANT ALL PRIVILEGES on db1.*`).
   * Protection against accidental cluster deletion: Enabled


   1. Run this command to create a {{ mmy-name }} cluster:

      
      ```bash
      {{ yc-mdb-my }} cluster create \
        --name="my-mysql" \
        --mysql-version {{ versions.cli.latest }} \
        --environment=production \
        --network-name=default \
        --security-group-ids {{ security-group }} \
        --host {{ host-net-example }} \
        --resource-preset {{ host-class }} \
        --disk-type {{ disk-type-example }} \
        --disk-size 20 \
        --user name=user1,password="user1user1" \
        --database name=db1 \
        --deletion-protection=true
      ```


   1. Run the change permissions command for the `user1` user.

      ```bash
      {{ yc-mdb-my }} user grant-permission user1 \
        --cluster-name="my-mysql" \
        --database=db1 \
        --permissions ALL
      ```

- {{ TF }}

   Create a {{ mmy-name }} cluster and a network for it with test characteristics:

   * Name: `my-mysql`
   * Version: `{{ versions.tf.latest }}`
   * Environment: `PRESTABLE`
   * Cloud ID: `{{ tf-cloud-id }}`
   * Folder ID: `{{ tf-folder-id }}`
   * New network: `mynet`
   * Number of `{{ host-class }}` hosts in the new `mysubnet` subnet, in the `{{ region-id }}-a` availability zone: 1. The `mysubnet` subnet will have a range of `10.5.0.0/24`.

   
   * In a new security group named `mysql-sg` allowing {{ mmy-name }} cluster connections from the internet via port `{{ port-mmy }}`.


   * With a network SSD storage (`{{ disk-type-example }}`) of 20 GB.
   * With one user, `user1`, with the password `user1user1`.
   * Database: `db1`, in which `user1` has full rights (same as `GRANT ALL PRIVILEGES on db1.*`).
   * Protection against accidental {{ mmy-name }} cluster deletion: Enabled.

   The configuration file for the {{ mmy-name }} cluster is as follows:

   
   
   ```hcl
   resource "yandex_mdb_mysql_cluster" "my-mysql" {
     name                = "my-mysql"
     environment         = "PRESTABLE"
     network_id          = yandex_vpc_network.mynet.id
     version             = "{{ versions.tf.latest }}"
     security_group_ids  = [ yandex_vpc_security_group.mysql-sg.id ]
     deletion_protection = true

     resources {
       resource_preset_id = "{{ host-class }}"
       disk_type_id       = "{{ disk-type-example }}"
       disk_size          = 20
     }

     host {
       zone      = "{{ region-id }}-a"
       subnet_id = yandex_vpc_subnet.mysubnet.id
     }
   }

   resource "yandex_mdb_mysql_database" "db1" {
     cluster_id = yandex_mdb_mysql_cluster.my-mysql.id
     name       = "db1"
   }

   resource "yandex_mdb_mysql_user" "<username>" {
     cluster_id = yandex_mdb_mysql_cluster.my-mysql.id
     name       = "user1"
     password   = "user1user1"
     permission {
       database_name = yandex_mdb_mysql_database.db1.name
       roles         = ["ALL"]
     }
   }

   resource "yandex_vpc_network" "mynet" {
     name = "mynet"
   }

   resource "yandex_vpc_security_group" "mysql-sg" {
     name       = "mysql-sg"
     network_id = yandex_vpc_network.mynet.id

     ingress {
       description    = "{{ MY }}"
       port           = {{ port-mmy }}
       protocol       = "TCP"
       v4_cidr_blocks = [ "0.0.0.0/0" ]
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

### Creating a multi-host cluster {#creating-multiple-hosts-cluster}

{% list tabs %}

- CLI

   To create a multi-host {{ mmy-name }} cluster, provide as many `--host` parameters as there should be hosts in your cluster.

   Create a {{ mmy-name }} cluster with the following test configuration:

   
   * Named `my-mysql-3`.
   * `{{ versions.cli.latest }}` version.
   * In the `prestable` environment.
   * In the `default` network.
   * In the security group with the `{{ security-group }}` ID.
   * With three public hosts of the `{{ host-class }}` class.

      One host will be added to each subnet of the `default` network:
      * `subnet-a`: `10.5.0.0/24`, the `{{ region-id }}-a` availability zone.
      * `subnet-b`: `10.6.0.0/24`, the `{{ region-id }}-b` availability zone.
      * `subnet-c`: `10.7.0.0/24`, the `{{ region-id }}-c` availability zone.

      The host residing in `subnet-b` will have the backup priority. Backups will be created from this host's data unless you choose it to be the master host.

   * With a network SSD storage (`{{ disk-type-example }}`) of 32 GB.
   * With one user, `user1`, with the password `user1user1`.
   * With one `db1` database, in which `user1` has full rights (same as `GRANT ALL PRIVILEGES on db1.*`).


   1. Run this command to create a {{ mmy-name }} cluster:

      
      ```bash
      {{ yc-mdb-my }} cluster create \
        --name="my-mysql-3" \
        --mysql-version {{ versions.cli.latest }} \
        --environment=prestable \
        --network-name=default \
        --security-group-ids {{ security-group }} \
        --host zone-id={{ region-id }}-a,`
               `subnet-name=subnet-a,`
               `assign-public-ip=true \
        --host zone-id={{ region-id }}-b,`
               `subnet-name=subnet-b,`
               `backup-priority=10,`
               `assign-public-ip=true \
        --host zone-id={{ region-id }}-c,`
               `subnet-name=subnet-c,`
               `assign-public-ip=true \
        --resource-preset {{ host-class }} \
        --disk-type {{ disk-type-example }} \
        --disk-size 32 \
        --user name=user1,password="user1user1" \
        --database name=db1
      ```


   1. Run the change permissions command for the `user1` user.

      ```bash
      {{ yc-mdb-my }} user grant-permission user1 \
        --cluster-name="my-mysql-3" \
        --database=db1 \
        --permissions ALL
      ```

- {{ TF }}

   Create a {{ mmy-name }} cluster and a network for it with test characteristics:

   * Name: `my-mysql-3`
   * Version: `{{ versions.tf.latest }}`
   * Environment: `PRESTABLE`
   * Cloud ID: `{{ tf-cloud-id }}`
   * Folder ID: `{{ tf-folder-id }}`
   * New network: `mynet`
   * `{{ host-class }}` public hosts: 3.

      One host will be added to the new subnets:
      * `mysubnet-a`: `10.5.0.0/24`, the `{{ region-id }}-a` availability zone.
      * `mysubnet-b`: `10.6.0.0/24`, the `{{ region-id }}-b` availability zone.
      * `mysubnet-c`: `10.7.0.0/24`, the `{{ region-id }}-c` availability zone.

      These subnets will belong to the `mynet` network.

      The host residing in `mysubnet-b` will have the backup priority. Backups will be created from this host's data unless you choose it to be the master host.

   
   * In a new security group named `mysql-sg` allowing {{ mmy-name }} cluster connections from the internet via port `{{ port-mmy }}`.


   * With a network SSD storage (`{{ disk-type-example }}`) of 32 GB.
   * With one user, `user1`, with the password `user1user1`.
   * With one `db1` database, in which `user1` has full rights (same as `GRANT ALL PRIVILEGES on db1.*`).

   The configuration file for the {{ mmy-name }} cluster is as follows:

   
   
   ```hcl
   resource "yandex_mdb_mysql_cluster" "my-mysql-3" {
     name               = "my-mysql-3"
     environment        = "PRESTABLE"
     network_id         = yandex_vpc_network.mynet.id
     version            = "{{ versions.tf.latest }}"
     security_group_ids = [ yandex_vpc_security_group.mysql-sg.id ]

     resources {
       resource_preset_id = "{{ host-class }}"
       disk_type_id       = "{{ disk-type-example }}"
       disk_size          = 32
     }

     host {
       zone             = "{{ region-id }}-a"
       subnet_id        = yandex_vpc_subnet.mysubnet-a.id
       assign_public_ip = true
     }

     host {
       zone             = "{{ region-id }}-b"
       subnet_id        = yandex_vpc_subnet.mysubnet-b.id
       assign_public_ip = true
       backup_priority  = 10
     }

     host {
       zone             = "{{ region-id }}-c"
       subnet_id        = yandex_vpc_subnet.mysubnet-c.id
       assign_public_ip = true
     }
   }

   resource "yandex_mdb_mysql_database" "db1" {
     cluster_id = yandex_mdb_mysql_cluster.my-mysql-3.id
     name       = "db1"
   }

   resource "yandex_mdb_mysql_user" "user1" {
     cluster_id = yandex_mdb_mysql_cluster.my-mysql-3.id
     name       = "user1"
     password   = "user1user1"
     permission {
       database_name = yandex_mdb_mysql_database.db1.name
       roles         = ["ALL"]
     }
   }

   resource "yandex_vpc_network" "mynet" {
     name = "mynet"
   }

   resource "yandex_vpc_security_group" "mysql-sg" {
     name       = "mysql-sg"
     network_id = yandex_vpc_network.mynet.id

     ingress {
       description    = "{{ MY }}"
       port           = {{ port-mmy }}
       protocol       = "TCP"
       v4_cidr_blocks = [ "0.0.0.0/0" ]
     }
   }

   resource "yandex_vpc_subnet" "mysubnet-a" {
     name           = "mysubnet-a"
     zone           = "{{ region-id }}-a"
     network_id     = yandex_vpc_network.mynet.id
     v4_cidr_blocks = ["10.5.0.0/24"]
   }

   resource "yandex_vpc_subnet" "mysubnet-b" {
     name           = "mysubnet-b"
     zone           = "{{ region-id }}-b"
     network_id     = yandex_vpc_network.mynet.id
     v4_cidr_blocks = ["10.6.0.0/24"]
   }

   resource "yandex_vpc_subnet" "mysubnet-c" {
     name           = "mysubnet-c"
     zone           = "{{ region-id }}-c"
     network_id     = yandex_vpc_network.mynet.id
     v4_cidr_blocks = ["10.7.0.0/24"]
   }
   ```




{% endlist %}
