# Creating {{ MY }} clusters

A {{ MY }} cluster is one or more database hosts. In multi-host clusters, [semi-synchronous replication](../concepts/replication.md) is configured automatically.

For more about {{ mmy-name }} cluster structure, see [{#T}](../concepts/index.md).

{% note info %}

* The number of hosts you can create together with a {{ MY }} cluster depends on the selected [disk type](../concepts/storage.md#storage-type-selection) and [host class](../concepts/instance-types.md#available-flavors).
* Available disk types [depend](../concepts/storage.md) on the selected [host class](../concepts/instance-types.md#available-flavors).

{% endnote %}

## How to create a {{ MY }} cluster {#create-cluster}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a DB cluster.
   1. Select **{{ mmy-name }}**.
   1. Click **Create cluster**.
   1. Name the {{ mmy-name }} cluster in the **Cluster name** field. It must be unique within the folder.
   1. Select the environment where you want to create the {{ mmy-name }} cluster (you cannot change the environment once the cluster is created):
      * `PRODUCTION`: For stable versions of your apps.
      * `PRESTABLE`: For testing, including the {{ mmy-name }} service itself. The prestable environment is updated first with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.
   1. Select the DBMS version.
   1. Select the host class that defines the technical specifications of the [VMs](../../compute/concepts/vm-platforms.md) where the DB hosts will be deployed. All available options are listed in [{#T}](../concepts/instance-types.md). When you change the host class for the {{ mmy-name }} cluster, the characteristics of all existing hosts change, too.
   1. Under **Storage size**:

      * Select the [disk type](../concepts/storage.md).

         {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}

      * Select the size to be used for data and backups. For more information about how backups take up storage space, see [{#T}](../concepts/backup.md).

         {% note info %}

         If DB storage is 95% full, the {{ mmy-name }} cluster switches to read-only mode. Increase the storage size in advance.

         {% endnote %}

   1. Under **Database**, specify the DB attributes:
      * DB name. The DB name must be unique within the folder and contain only Latin letters, numbers, and underscores.
      * DB owner username and password.

         {% include [user-name-and-passwords-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

   
   1. Under **Network settings**, select:
      * [Cloud network](../../vpc/concepts/network.md#network) for the {{ mmy-name }} cluster.
      * [Security groups](../../vpc/concepts/security-groups.md) for the {{ mmy-name }} cluster's network traffic. You may also need to [set up security groups](connect.md#configuring-security-groups) to connect to the {{ mmy-name }} cluster.

         {% note info %}

         {% include [security-groups-note](../../_includes/vpc/security-groups-note-services.md) %}

         {% endnote %}


   1. Under **Hosts**, select the parameters for the DB hosts created with the {{ mmy-name }} cluster. If you open **Advanced settings**, you can choose specific [subnets](../../vpc/concepts/network.md#subnet) for each host. By default, each host is created in a separate subnet.

      If you selected `local-ssd` or `network-ssd-nonreplicated` under **Storage size**, you need to add at least three hosts to the {{ mmy-name }} cluster. After creating a {{ mmy-name }} cluster, you can add extra hosts to it if there are enough [folder resources](../concepts/limits.md) available.
   1. Configure additional {{ mmy-name }} cluster settings, if required:

      {% include [mmy-extra-settings](../../_includes/mdb/mmy-extra-settings-web-console.md) %}

   1. If required, configure [DBMS cluster-level settings](../concepts/settings-list.md#dbms-cluster-settings).

      {% include [mmy-settings-dependence](../../_includes/mdb/mmy/note-info-settings-dependence.md) %}

   1. Click **Create cluster**.

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
        --environment <environment, prestable or production> \
        --network-name <network name> \
        --host zone-id=<availability zone>,subnet-id=<subnet ID> \
        --mysql-version <{{ MY }} version: {{ versions.cli.str }}> \
        --resource-preset <host class> \
        --user name=<username>,password=<user password> \
        --database name=<DB name> \
        --disk-size <storage size in GB> \
        --disk-type <network-hdd | network-ssd | local-ssd | network-ssd-nonreplicated> \
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
        --maintenance-window type=<maintenance type: anytime or weekly>,`
                            `day=<day of week for weekly>,`
                            `hour=<hour for weekly> \
        --websql-access=<queries from the management console: true or false> \
        --deletion-protection=<cluster deletion protection: true or false>
      ```



      {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}

      Configure the [DBMS settings](../concepts/settings-list.md#dbms-cluster-settings), if required.

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   
   If you do not have {{ TF }} yet, [install it and configure the provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


   To create a {{ mmy-name }} cluster:
   1. In the configuration file, describe the parameters of the resources you want to create:
      * DB cluster: Description of the cluster and its hosts.
      * Database: Description of the cluster's DB.
      * User: Description of the cluster user.

      * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

      * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

      Example of the configuration file structure:

      
      
      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster name>" {
        name                = "<cluster name>"
        environment         = "<environment, PRESTABLE or PRODUCTION>"
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
          zone      = "<availability zone>"
          subnet_id = "<subnet ID>"
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

      For more information on resources that you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-mmy }}).
   1. Make sure the configuration files are valid.

      {% include [terraform-create-cluster-step-2](../../_includes/mdb/terraform-create-cluster-step-2.md) %}

   1. Create a {{ mmy-name }} cluster.

      {% include [terraform-create-cluster-step-3](../../_includes/mdb/terraform-create-cluster-step-3.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API

   To create a {{ MY }} cluster, use the [create](../api-ref/Cluster/create.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Create](../api-ref/grpc/cluster_service.md#Create) gRPC API call and provide the following in the request:
   * ID of the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where the {{ mmy-name }} cluster should be placed, in the `folderId` parameter.
   * {{ mmy-name }} cluster name in the `name` parameter. It must be unique within the folder.
   * {{ mmy-name }} cluster environment in the `environment` parameter.
   * {{ mmy-name }} cluster configuration in the `configSpec` parameter.
   * DB configuration in one or more `databaseSpecs` parameters.
   * User settings in one or more `userSpecs` parameters.
   * Configuration of the {{ mmy-name }} cluster's hosts in one or more `hostSpecs` parameters.
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
   * With a network SSD storage (`{{ disk-type-example }}`) of 20 GB.
   * With one user, `user1`, with the password `user1user1`.
   * With one `db1` database, in which `user1` has full rights (same as `GRANT ALL PRIVILEGES on db1.*`).
   * With protection against accidental cluster deletion.


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

   * Named `my-mysql`.
   * Versions `{{ versions.tf.latest }}`.
   * In the `PRESTABLE` environment.
   * In the cloud with the `{{ tf-cloud-id }}` ID.
   * In the folder with the `{{ tf-folder-id }}` ID.
   * In the new `mynet` network.
   * With one `{{ host-class }}` host in the new `mysubnet` subnet and `{{ region-id }}-a` availability zone. The `mysubnet` subnet will have the `10.5.0.0/24` range.
      * In a new security group called `mysql-sg` allowing {{ mmy-name }} cluster connections from the internet via port `{{ port-mmy }}`.
   * With a network SSD storage (`{{ disk-type-example }}`) of 20 GB.
   * With one user, `user1`, with the password `user1user1`.
   * With one `db1` database, in which `user1` has full rights (same as `GRANT ALL PRIVILEGES on db1.*`).
   * With protection against accidental {{ mmy-name }} cluster deletion.

   The configuration file for the {{ mmy-name }} cluster looks like this:

   
   
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