# Creating {{ CH }} clusters

{{ CH }}clusters are one or more database hosts that replication can be configured between.

{% note warning %}

When creating a {{ CH }} cluster with 2 or more hosts, {{ mch-short-name }} automatically creates a cluster of 3 ZooKeeper hosts for managing replication and fault tolerance. These hosts are considered when calculating the cost of the [resource quotas]({{ link-console-quotas }}) used by the cloud and the. Read more about replication for [{{ CH }}](../concepts/replication.md#clickhouse).

{% endnote %}


The number of hosts that can be created with a {{ CH }} cluster depends on the storage option selected:

* When using network drives, you can request any number of hosts (from one to the current [quota](../concepts/limits.md) limit).

* When using SSDs, you can create at least two replicas along with the cluster (a minimum of two replicas is required to ensure fault tolerance). If the [available folder resources](../concepts/limits.md) are still sufficient after creating a cluster, you can add extra replicas.

{% list tabs %}

- Management console

  1. In the management console, select the folder where you want to create a DB cluster.

  1. Select **{{ mch-name }}**.

  1. Click **Create cluster**.

  1. Enter the cluster name in the **Cluster name** field. The cluster name must be unique within the folder.

  1. Select the environment where you want to create the cluster (you can't change the environment once the cluster is created):
      - `PRODUCTION`: For stable versions of your apps.
      - `PRESTABLE`: For testing, including the {{ mch-short-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.

  1. Select the host class that defines the technical specifications of the VMs where the DB hosts will be deployed. All available options are listed in [{#T}](../concepts/instance-types.md). When you change the host class for the cluster, the characteristics of all existing instances change, too.

  1. Under **Storage size**:

            - Select the type of storage, either a more flexible network type (**network-hdd** or **network-ssd**) or faster local SSD storage (**local-ssd**). The size of the local storage can only be changed in 100 GB increments.
      - Select the size to be used for data and backups. For more information about how backups take up storage space, see [{#T}](../concepts/backup.md).

  1. Under **Database**, specify the DB attributes:
      - DB name.
      - Username.
      - User password. At least 8 characters.

  1. Under **Hosts**, specify the parameters for the database hosts created with the cluster (keep in mind that if you use SSDs when creating the {{ CH }} cluster, you can set at least two hosts). To change the added host, place the cursor on the host line and click  ![image](../../_assets/pencil.svg).

  1. If necessary, configure additional cluster settings:

     {% include [mch-extra-settings](../../_includes/mdb/mch-extra-settings-web-console.md) %}

  1. If necessary, configure the DBMS settings:

     {% include [mch-additional-properties](../../_includes/mdb/mch-additional-properties.md) %}

  1. Click **Create cluster**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a cluster:

  
  1. Check whether the folder has any subnets for the cluster hosts:

     ```
     $ yc vpc subnet list
     ```

     If there are no subnets in the folder, [create the necessary subnets](../../vpc/operations/subnet-create.md) in {{ vpc-short-name }}.

  1. View a description of the CLI's create cluster command:

      ```
      $ {{ yc-mdb-ch }} cluster create --help
      ```

  1. Specify the cluster parameters in the create command (the example shows only mandatory flags):

     
     ```
     $ {{ yc-mdb-ch }} cluster create \
        --name <cluster name> \
        --environment <prestable or production> \
        --network-name <network name> \
        --host type=<clickhouse or zookeeper>,zone-id=<availability zone>,subnet-id=<subnet ID> \
        --resource-preset <host class> \
        --clickhouse-disk-type <network-hdd | network-ssd | local-ssd> \
        --clickhouse-disk-size <storage size in GB> \
        --user name=<username>,password=<user password> \
        --database name=<DB name>
     ```

     The subnet ID `subnet-id` should be specified if the selected availability zone contains two or more subnets.

- Terraform

  {% include [terraform-definition](../../solutions/_solutions_includes/terraform-definition.md) %}

  If you don't have Terraform yet, [install it and configure the provider](../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  To create a cluster:

    1. In the configuration file, describe the parameters of resources that you want to create:
       * Database cluster: Description of the cluster and its hosts.
       * Network: Description of the [cloud network](../../vpc/concepts/network.md#network) where the cluster will be located. If you already have a suitable network, you don't need to describe it again.
       * Subnets: Description of the [subnets](../../vpc/concepts/network.md#network) to connect the cluster hosts to. If you already have suitable subnets, you don't need to describe them again.

       Example configuration file structure:

       ```
       resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
         name        = "<cluster name>"
         environment = "<environment>"
         network_id  = "<network ID>"
       
         clickhouse {
           resources {
             resource_preset_id = "<host class>"
             disk_type_id       = "<storage type>"
             disk_size          = "<storage size, GB>"
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

    1. Make sure that the configuration files are correct.
       1. In the command line, go to the folder where you created the configuration file.
       1. Run the check using the command:

          ```
          terraform plan
          ```

       If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, Terraform points them out. This is a test step. No resources are created.

    1. Create a cluster.
       1. If the configuration doesn't contain any errors, run the command:

          ```
          terraform apply
          ```
       2. Confirm that you want to create the resources.

       After this, all the necessary resources will be created in the specified folder and the IP addresses of the VMs will be displayed in the terminal. You can check resource availability and their settings in [management console]({{ link-console-main }}).

{% endlist %}

## Examples {#examples}

{% list tabs %}

- CLI

  **Creating a single-host cluster**

  To create a cluster with a single host, you should pass a single parameter, `--host`.

  Let's say we need to create a {{ CH }} cluster with the following characteristics:

    - Named `mych`.
  - In the `production` environment.
  - In the `default` network.
  - With a single `{{ host-class }}` class ClickHouse host in the `b0rcctk2rvtr8efcch64` subnet and `ru-central1-c` availability zone.
  - With 20 GB fast network storage (`{{ disk-type-example }}`).
  - With one user, `user1`, with the password `user1user1`.
  - With one database, `db1`.

  Run the command:

  
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
       --database name=db1
  ```

- Terraform

  **Creating a single-host cluster**

  Let's say we need to create a {{ CH }} cluster and a network for it with the following characteristics:
    - Named `mych`.
    - In the `PRESTABLE` environment.
    - In the cloud with ID `{{ tf-cloud-id }}`.
    - In a folder named `myfolder`.
    - In a new network named `mynet`.
    - With a single `{{ host-class }}` class host in the new subnet named `mysubnet` and the `ru-central1-c` availability zone. The `mysubnet` subnet will have a range of `10.5.0.0/24`.
    - With 32 GB of fast network storage.
    - With the database name `my_db`.
    - With the username `user1` and password `user1user1`.

  The configuration file for the cluster looks like this:

  ```
  provider "yandex" {
    token = "<OAuth or static key of service account>"
    cloud_id  = "{{ tf-cloud-id }}"
    folder_id = "${data.yandex_resourcemanager_folder.myfolder.id}"
    zone      = "ru-central1-c"
  }
  
  resource "yandex_mdb_clickhouse_cluster" "mych" {
    name        = "mych"
    environment = "PRESTABLE"
    network_id  = "${yandex_vpc_network.mynet.id}"
  
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
      subnet_id = "${yandex_vpc_subnet.mysubnet.id}"
    }
  }
  
  resource "yandex_vpc_network" "mynet" { name = "mynet" }
  
  resource "yandex_vpc_subnet" "mysubnet" {
    name           = "mysubnet"
    zone           = "ru-central1-c"
    network_id     = "${yandex_vpc_network.mynet.id}"
    v4_cidr_blocks = ["10.5.0.0/24"]
  }
  ```

{% endlist %}

