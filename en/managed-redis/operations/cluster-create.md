# Creating {{ RD }} clusters

{{ RD }} clusters are one or more database hosts that replication can be configured between. Replication is enabled by default in any cluster consisting of more than one host: the master host accepts write requests and asynchronously duplicates changes on replicas.

The number of hosts that can be created together with a {{ RD }} cluster depends on the host type selected:

* In a cluster with **high-memory** hosts, you can create an unlimited number of hosts (from 1 to the current maximum [quota](../concepts/limits.md)).

* In a cluster with **burstable** hosts, you can create only one host.

## How to create a {{ RD }} cluster {#create-cluster}

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a DB cluster.

  1. Select **{{ mrd-name }}**.

  1. Click **Create cluster**.

  1. Enter the cluster name in the **Cluster name** field. The cluster name must be unique within the Cloud.

  1. Select the environment where you want to create the cluster (you can't change the environment once the cluster is created):
      - <q>production</q>: For stable versions of your apps.
      - <q>prestable</q>: For testing, including the {{ mrd-short-name }} service itself. The prestable environment is updated more often, which means that known problems are fixed sooner, but this may cause backward incompatible changes.

  1. Select the DBMS version.

  1. If necessary, enable [cluster sharding](../concepts/sharding.md).

     {% note important %}

     You can only enable sharding when you create a new cluster. You can't shard an existing non-sharded cluster or disable sharding for a cluster that it's enabled for.

     {% endnote %}

  1. Under **Host class**:

      - Select the host type: it determines the [performance](../../compute/concepts/performance-levels) level of the processor cores. **High-memory** hosts allow full core usage, whereas **burstable** hosts only a portion.

      - Select the amount of RAM for the host.

      - Select the disk size.

  1. In **Cluster settings** under **Password**, set the user password (from 8 to 128 characters).

  1. Under **Network**, select the network whose subnets the hosts will be connected to.

  1. Under **Hosts**, click **Add host** and select the availability zone and subnet to connect the host to. Create the necessary number of hosts. To change the availability zone and the added host, click the pencil icon in the host line.

     If you enabled sharding, enter names for the shards.

  1. Click **Create cluster**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a cluster:

  {% if audience != "internal" %} 1. Check whether the folder has any subnets for the cluster hosts:

     ```
     $ yc vpc subnet list
     ```

     If there are no subnets in the folder, [create the necessary subnets](../../vpc/operations/subnet-create.md) in {{ vpc-short-name }}. {% endif %}

  1. View a description of the CLI's create cluster command:

      ```
      $ {{ yc-mdb-rd }} cluster create --help
      ```

  1. View available host classes:

     ```
     $ {{ yc-mdb-rd }} resource-preset list
     ```

  1. Specify the cluster parameters in the create command (only some of the supported flags are given in the example):

      ```bash
      $ {{ yc-mdb-rd }} cluster create \
         --name <cluster name> \
         --environment <prestable or production> \
         --network-name <network name> \
         --host zone-id=<availability zone>,subnet-id=<subnet ID> \
         --resource-preset <host class> \
         --disk-size <storage size in GB> \
         --password=<user password> \
         --backup-window-start <backup start time in HH:MM:SS format>
      ```

      The subnet ID `subnet-id` should be specified if the selected availability zone contains two or more subnets.

- Terraform

  {% include [terraform-definition](../../solutions/_solutions_includes/terraform-definition.md) %}

  If you don't have Terraform yet, [install it and configure the provider](../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  To create a cluster:

    1. Prepare an infrastructure plan.

       In the configuration file, describe the parameters of resources that you want to create:
       * Network: Description of the [cloud network](../../vpc/concepts/network.md#network) where the cluster will be located. If you already have a suitable network, you don't need to describe it again.
       * Subnets: Description of the [subnets](../../vpc/concepts/network.md#network) to connect the cluster hosts to. If you already have suitable subnets, you don't need to describe them again.
       * Database cluster: Description of the cluster and its hosts.

       Sample configuration file structure:

       ```
       resource "yandex_mdb_redis_cluster" "<cluster name>" {
         name        = "<cluster name>"
         environment = "<environment>"
         network_id  = "<network ID>"
       
         config {
           password = "<password>"
         }
       
         resources {
           resource_preset_id = "<host class>"
           disk_size          = <disk size>
         }
       
         host {
           zone      = "<availability zone>"
           subnet_id = "<subnet ID>"
         }
       }
       
       resource "yandex_vpc_network" "<network name>" {}
       
       resource "yandex_vpc_subnet" "<subnet name>" {
         zone           = "<availability zone>"
         network_id     = "<network ID>"
         v4_cidr_blocks = ["<range>"]
       }
       ```

       For more information about resources that you can create using Terraform, see the [provider's documentation](https://www.terraform.io/docs/providers/yandex/r/mdb_redis_cluster.html).

    2. Make sure that the configuration files are correct.
       1. In the command line, use the `cd <folder path>` command to go to the folder where you created the configuration file.
       2. Run the check using the command:

          ```
          terraform plan
          ```

       If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If there are errors in the configuration, Terraform will point them out. This is a test step. No resources are created.

    3. Create a cluster.
       1. If there are no errors in the configuration, run the command:

          ```
          terraform apply
          ```
       2. Confirm the creation of resources.

       After this, all the necessary resources will be created in the specified folder and the IP addresses of the VMs will be displayed in the terminal. You can check resource availability and their settings in [консоли управления]({{ link-console-main }}).

{% endlist %}

## Examples {#examples}

{% list tabs %}

- CLI

  **Creating a single-host cluster**

  To create a cluster with a single host, you should pass a single parameter, `--host`.

  Let's say we need to create a {{ RD }} cluster with the following characteristics:
  - Named `myredis`.
  - In the `production` environment.
  - In the `default` network.
  - With a single `b1.nano` class host in the `b0rcctk2rvtr8efcch64` subnet and the `ru-central1-c` availability zone.
  - With 20 GB of storage.
  - With the `user1user1` password.

  Run the command:

  ```
  $ {{ yc-mdb-rd }} cluster create \
       --name myredis \
       --environment production \
       --network-name default \
       --resource-preset b1.nano \
       --host zone-id=ru-central1-c,subnet-id=b0rcctk2rvtr8efcch64 \
       --disk-size 20 \
       --password=user1user1
  ```

- Terraform

  **Creating a single-host cluster**

  Let's say we need to create a {{ RD }} cluster and a network for it with the following characteristics:
    - Named `myredis`.
    - In the `production` environment.
    - In the cloud with the `b1gq90dgh25иuebiu75o` ID.
    - In a folder named `myfolder.`
    - In a new network named `mynet`.
    - With a single `hm1.nano` class host in a new subnet named `mysubnet` and in the `ru-central1-c` availability zone. The `mysubnet` subnet will have the `10.5.0.0/24` range.
    - With 16 GB of storage.
    - With the `user1user1` password.

  The configuration file for the cluster looks like this:

  ```
  provider "yandex" {
    token = "<OAuth or static key of service account>"
    cloud_id  = "b1gq90dgh25иuebiu75o"
    folder_id = "${data.yandex_resourcemanager_folder.myfolder.id}"
    zone      = "ru-central1-c"
  }
  
  resource "yandex_mdb_redis_cluster" "myredis" {
    name        = "myredis"
    environment = "PRODUCTION"
    network_id  = "${yandex_vpc_network.mynet.id}"
  
    config {
      password = "user1user1"
    }
  
    resources {
      resource_preset_id = "hm1.nano"
      disk_size          = 16
    }
  
    host {
      zone      = "ru-central1-c"
      subnet_id = "${yandex_vpc_subnet.mysubnet.id}"
    }
  }
  
  resource "yandex_vpc_network" "mynet" {}
  
  resource "yandex_vpc_subnet" "mysubnet" {
    zone           = "ru-central1-c"
    network_id     = "${yandex_vpc_network.mynet.id}"
    v4_cidr_blocks = ["10.5.0.0/24"]
  }
  ```

{% endlist %}

