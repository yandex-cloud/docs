---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Creating {{ MG }} clusters

{{ MG }} clusters are one or more database hosts that replication can be configured between. Replication is enabled by default in any cluster consisting of more than one host (the primary host accepts write requests and asynchronously duplicates changes in the secondary hosts).


The number of hosts that can be created with a {{ MG }} cluster depends on the storage option selected:

  - When using network drives, you can request any number of hosts (from one to the current [quota](../concepts/limits.md) limit).
  - When using SSDs, you can create at least three replicas along with the cluster (a minimum of three replicas is required to ensure fault tolerance). If the [available folder resources](../concepts/limits.md) are still sufficient after creating a cluster, you can add extra replicas.

{% note info %}

Creation of {{ MG }} 3.6 clusters will be disabled in March 2021 due to the version 3.6 [End of Life](https://www.mongodb.com/support-policy).

In April 2021, all existing clusters with this {{ MG }} version will be [forcibly upgraded](../qa/general.md#dbms-deprecated) to version 4.0. We recommend that you [upgrade](../operations/cluster-version-update.md) to the latest {{ MG }} versions in advance.

{% endnote %}

{% list tabs %}

- Management console

  1. In the management console, select the folder where you want to create a DB cluster.

  1. Select **{{ mmg-name }}**.

  1. Click **Create cluster**.

  1. Enter a name for the cluster in the **Cluster name** field. The cluster name must be unique within the folder.

  1. Select the environment where you want to create the cluster (you can't change the environment once the cluster is created):
     - `PRODUCTION`: For stable versions of your apps.
     - `PRESTABLE`: For testing, including the {{ mmg-short-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.

  1. Select the DBMS version.

  1. Select the host class that defines the technical specifications of the VMs where the DB hosts will be deployed. When you change the host class for the cluster, the characteristics of all existing hosts change, too.

  1. Under **Storage size**:
      - Choose the [type of storage](../concepts/storage.md), either a more flexible network type (**network-hdd** or **network-ssd**) or faster local SSD storage (**local-ssd**). The size of the local storage can only be changed in 100 GB increments.
      - Select the size to be used for data and backups. For more information about how backups take up storage space, see [{#T}](../concepts/backup.md).

  1. Under **Database**, specify the DB attributes:
      - DB name.
      - Username.
      - User password. At least 8 characters.

  1. Under **Network settings**, select the cloud network to host the cluster in and security groups for cluster network traffic. You may need to additionally [set up security groups](connect.md#configuring-security-groups) to connect to the cluster.

  1. Under **Hosts**, select parameters for the database hosts created with the cluster (keep in mind that if you use SSDs when creating a {{ MG }} cluster, you can set at least three hosts). If you open **Advanced settings**, you can choose specific subnets for each host. By default, each host is created in a separate subnet.

  1. If necessary, configure additional cluster settings:

     {% include [mmg-extra-settings](../../_includes/mdb/mmg-extra-settings.md) %}

  1. If necessary, configure the [DBMS settings](../concepts/settings-list.md#dbms-cluster-settings).

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

  1. View a description of the CLI create cluster command:

      ```
      $ {{ yc-mdb-mg }} cluster create --help
      ```

  1. Specify the cluster parameters in the create command (the example shows only mandatory flags):

      
      ```
      $ {{ yc-mdb-mg }} cluster create \
         --name <cluster name> \
         --environment=<prestable or production> \
         --network-name <network name> \
         --host zone-id=<availability zone>,subnet-id=<subnet ID> \
         --mongod-resource-preset <host class> \
         --user name=<username>,password=<user password> \
         --database name=<database name> \
         --mongod-disk-type <network-hdd | network-ssd | local-ssd> \
         --mongod-disk-size <storage size in GB>
      ```

      The subnet ID `subnet-id` should be specified if the selected availability zone contains two or more subnets.

- Terraform

  {% include [terraform-definition](../../solutions/_solutions_includes/terraform-definition.md) %}

  If you don't have Terraform yet, [install it and configure the provider](../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  To create a cluster:

  1. In the configuration file, describe the parameters of resources that you want to create:

     {% include [terraform-create-cluster-step-1](../../_includes/mdb/terraform-create-cluster-step-1.md) %}

     Example configuration file structure:

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
       cloud_id  = "<cloud ID>"
       folder_id = "<folder ID>"
       zone      = "<availability zone>"
     }
     
     resource "yandex_mdb_mongodb_cluster" "<cluster name>" {
       name               = "<cluster name>"
       environment        = "<PRESTABLE or PRODUCTION>"
       network_id         = "<network ID>"
       security_group_ids = [ "<list of security groups>" ]
     
       cluster_config {
         version = "<MongoDB version: 4.0, 4.2, or 4.4>"
       }
     
       database {
         name = "<DB name>"
       }
     
       user {
         name     = "<username>"
         password = "<user password>"
         permission {
           database_name = "<database name>"
         }
       }
     
       resources {
         resource_preset_id = "<host class>"
         disk_type_id       = "<storage type>"
         disk_size          = "<storage size in GB>"
       }
     
       host {
         zone_id   = "<availability zone>"
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

     For more information about resources that you can create using Terraform, see the [provider's documentation](https://www.terraform.io/docs/providers/yandex/r/mdb_mongodb_cluster.html).

  1. Make sure that the configuration files are correct.

     {% include [terraform-create-cluster-step-2](../../_includes/mdb/terraform-create-cluster-step-2.md) %}

  1. Create a cluster.

     {% include [terraform-create-cluster-step-3](../../_includes/mdb/terraform-create-cluster-step-3.md) %}

{% endlist %}

{% note warning %}

If you specified security group IDs when creating a cluster, you may also need to [re-configure security groups](connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}

## Examples {#examples}

### Creating a single-host cluster {#creating-a-single-host-cluster}

{% list tabs %}

- CLI

  To create a cluster with a single host, you should pass a single `--host` parameter.

  Let's say we need to create a {{ MG }} cluster with the following characteristics:

    - Named `mymg`.
  - In the `production` environment.
  - In the `{{ network-name }}` network.
  - In the security group with the ID `{{ security-group }}`.
  - With one `{{ host-class }}` class host in the `b0rcctk2rvtr8efcch64` subnet in the `{{ zone-id }}` availability zone.
  - With 20 GB fast network storage (`{{ disk-type-example }}`).
  - With one user, `user1`, with the password `user1user1`.
  - With one database, `db1`.

  Run the command:

  
  ```
  $ {{ yc-mdb-mg }} cluster create \
       --name mymg \
       --environment production \
       --network-name {{ network-name }} \
       --security-group-ids {{ security-group }} \
       --mongod-resource-preset {{ host-class }} \
       --host zone-id={{ zone-id }},subnet-id=b0rcctk2rvtr8efcch64 \
       --mongod-disk-size 20 \
       --mongod-disk-type {{ disk-type-example }} \
       --user name=user1,password=user1user1 \
       --database name=db1
  ```

- Terraform

  Let's say we need to create a {{ MG }} cluster and a network for it with the following characteristics:
    - Named `mymg`.
    - Version `4.4`.
    - In the `PRODUCTION` environment.
    - In the cloud with the ID `{{ tf-cloud-id }}`.
    - In the folder with the ID `{{ tf-folder-id }}`.
    - Network: `mynet`.
    - With 1 `{{ host-class }}` class host in the new `mysubnet` subnet and `{{ zone-id }}` availability zone. The `mysubnet` subnet will have the range `10.5.0.0/24`.
    - In the new security group `mymg-sg` allowing TCP connections to the cluster from the internet via port `{{ port-mmg }}`.
    - With 20 GB fast network storage (`{{ disk-type-example }}`).
    - With one user, `user1`, with the password `user1user1`.
    - With one database, `db1`.

  The configuration file for the cluster looks like this:

  ```go
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
  
  resource "yandex_mdb_mongodb_cluster" "mymg" {
    name               = "mymg"
    environment        = "PRODUCTION"
    network_id         = yandex_vpc_network.mynet.id
    security_group_ids = [ yandex_vpc_security_group.mymg-sg.id ]
  
    cluster_config {
      version = "4.4"
    }
  
    database {
      name = "db1"
    }
  
    user {
      name     = "user1"
      password = "user1user1"
      permission {
        database_name = "db1"
      }
    }
  
    resources {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 20
    }
  
    host {
      zone_id   = "{{ zone-id }}"
      subnet_id = yandex_vpc_subnet.mysubnet.id
    }
  }
  
  resource "yandex_vpc_network" "mynet" {
    name = "mynet"
  }
  
  resource "yandex_vpc_security_group" "mymg-sg" {
    name       = "mymg-sg"
    network_id = yandex_vpc_network.mynet.id
  
    ingress {
      description    = "MongoDB"
      port           = {{ port-mmg }}
      protocol       = "TCP"
      v4_cidr_blocks = [ "0.0.0.0/0" ]
    }
  }
  
  resource "yandex_vpc_subnet" "mysubnet" {
    name           = "mysubnet"
    zone           = "{{ zone-id }}"
    network_id     = yandex_vpc_network.mynet.id
    v4_cidr_blocks = ["10.5.0.0/24"]
  }
  ```

{% endlist %}

