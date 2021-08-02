# Creating {{ MY }} clusters

{{ MY }} clusters are one or more database hosts that replication can be configured between. Replication is enabled by default in any cluster consisting of more than one host: the master host accepts write requests, then duplicates changes synchronously in the primary replica and asynchronously in all the others.

{% if audience != "internal" %}

The number of hosts that can be created with a {{ MY }} cluster depends on the storage option selected:

- If you use network drives, the available number of hosts is limited to the current [quota](../concepts/limits.md).
- If you use SSD disks, at least 3 replicas are created with a cluster to ensure fault tolerance.

{% note info %}

If database storage is 95% full, the cluster switches to read-only mode. Increase the storage size in advance.

{% endnote %}

{% endif %}

## How to create a {{ MY }} cluster {#create-cluster}

{% list tabs %}

- Management console

  1. In the management console, select the folder where you want to create a DB cluster.

  1. Select **{{ mmy-name }}**.

  1. Click **Create cluster**.

  1. Enter a name for the cluster in the **Cluster name** field. The cluster name must be unique within the folder.

  1. Select the environment where you want to create the cluster (you can't change the environment once the cluster is created):
      - `PRODUCTION`: For stable versions of your apps.
      - `PRESTABLE`: For testing, including the {{ mmy-short-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.

  1. Select the DBMS version.

  1. Select the host class that defines the technical specifications of the VMs where the DB hosts will be deployed. All available options are listed in [{#T}](../concepts/instance-types.md). When you change the host class for the cluster, the characteristics of all existing hosts change, too.

  1. Under **Storage size**:
      - Select the type of storage, either a more flexible network type (`network-hdd` or `network-ssd`) or faster local SSD storage (`local-ssd`). The size of the local storage can only be changed in 100 GB increments.
      - Select the size to be used for data and backups. For more information about how backups take up storage space, see [{#T}](../concepts/backup.md).

  1. Under **Database**, specify the DB attributes:
      - Database name. The DB name must be unique within the folder and contain only Latin letters, numbers, and underscores.
      - The name of the user who is the DB owner. The username may only contain Latin letters, numbers, and underscores.
      - User password (from 8 to 128 characters).

  1. Under **Network settings**, select the cloud network to host the cluster in and security groups for cluster network traffic. You may need to additionally [set up the security groups](connect.md#configuring-security-group) to connect to the cluster.

  1. Under **Hosts**, select parameters for the database hosts created with the cluster (keep in mind that if you use SSDs when creating a {{ MY }} cluster, you can set at least three hosts). If you open **Advanced settings**, you can choose specific subnets for each host. By default, each host is created in a separate subnet.
  
  1. If necessary, configure additional cluster settings:

     {% include [mmy-extra-settings](../../_includes/mdb/mmy-extra-settings-web-console.md) %}

  1. If necessary, configure the DBMS settings:

     {% include [mmy-dbms-settings](../../_includes/mdb/mmy-dbms-settings.md) %}

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
      $ {{ yc-mdb-my }} cluster create --help
      ```

  1. Specify the cluster parameters in the create command:

     ```
     $ {{ yc-mdb-my }} cluster create \
        --name=<cluster name> \
        --environment <prestable or production> \
        --network-name <network name> \
        --host zone-id=<availability zone>,subnet-id=<subnet ID> \
        --mysql-version <MySQL version> \
        --resource-preset <host class> \
        --user name=<username>,password=<user password> \
        --database name=<database name> \
        --security-group-ids <list of security group IDs>
     ```

      The subnet ID `subnet-id` should be specified if the selected availability zone contains two or more subnets.

- Terraform

  {% include [terraform-definition](../../_includes/solutions/terraform-definition.md) %}

  If you don't have Terraform, [install it and configure the provider](../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  To create a cluster:

  1. In the configuration file, describe the parameters of resources that you want to create:

     {% include [terraform-create-cluster-step-1](../../_includes/mdb/terraform-create-cluster-step-1.md) %}

     Example configuration file structure:

     ```hcl
     resource "yandex_mdb_mysql_cluster" "<cluster name>" {
       name               = "<cluster name>"
       environment        = "<PRESTABLE or PRODUCTION>"
       network_id         = "<network ID>"
       version            = "<MySQL version: 5.7 or 8.0>"
       security_group_ids = [ "<list of security groups>" ]
     
       resources {
         resource_preset_id = "<host class>"
         disk_type_id       = "<storage type>"
         disk_size          = "<storage size in GB>"
       }
     
       database {
         name = "<DB name>"
       }
     
       user {
         name     = "<username>"
         password = "<user password>"
         permission {
           database_name = "<database name>"
           roles         = ["ALL"]
         }
       }
     
       host {
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

     For more information about resources that you can create using Terraform, see the [provider's documentation](https://www.terraform.io/docs/providers/yandex/r/mdb_mysql_cluster.html).

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

  Let's say we need to create a {{ MY }} cluster with the following characteristics:

    {% if audience != "internal" %}
    - Named `my-mysql`.
    - Version `8.0`.
    - In the `production` environment.
    - In the `default` network.
    - In the security group with the ID `{{ security-group }}`.
    - With one `{{ host-class }}` host in the `{{ subnet-id }}` subnet, in the `{{ zone-id }}` availability zone.
    - With 20 GB fast network storage (`{{ disk-type-example }}`).
    - With one user (`user1`) with the password `user1user1`.
    - With 1 `db1` database, in which `user1` has full rights (the same as `GRANT ALL PRIVILEGES on db1.*`).

    {% else %}
    - Named `my-mysql`.
    - Version `8.0`.
    - In the `production` environment.
    - With one `{{ host-class }}` host in the `man` availability zone.
    - With 20 GB fast local storage (`local-ssd`).
    - With one user (`user1`) with the password `user1user1`.
    - With 1 `db1` database, in which `user1` has full rights (the same as `GRANT ALL PRIVILEGES on db1.*`).

    {% endif %}

  1. Run the command to create a cluster:

      {% if audience != "internal" %}

      ```bash
      {{ yc-mdb-my }} cluster create \
         --name="my-mysql" \
         --mysql-version 8.0 \
         --environment=production \
         --network-name=default \
         --security-group-ids {{ security-group }} \
         --host zone-id={{ host-net-example }} \
         --resource-preset {{ host-class }} \
         --disk-type {{ disk-type-example }} \
         --disk-size 20 \
         --user name=user1,password="user1user1" \
         --database name=db1
      ```

      {% else %}

      ```bash
      {{ yc-mdb-my }} cluster create \
         --name="my-mysql" \
         --mysql-version 8.0 \
         --environment=production \
         --network-id=' ' \
         --host zone-id=man \
         --resource-preset {{ host-class }} \
         --disk-type local-ssd \
         --disk-size 20 \
         --user name=user1,password="user1user1" \
         --database name=db1
      ```

      {% endif %}

  1. Run the command to change the `user1` user's permissions.

      ```bash
      {{ yc-mdb-my }} user grant-permission user1 \
         --cluster-name="my-mysql" \
         --database=db1 \
         --permissions ALL
      ```

- Terraform

  Let's say we need to create a {{ MY }} cluster and a network for it with the following characteristics:
  - Named `my-mysql`.
  - Version `8.0`.
  - In the `PRESTABLE` environment.
  - In the cloud with the ID `{{ tf-cloud-id }}`.
  - In the folder with the ID `{{ tf-folder-id }}`.
  - Network: `mynet`.
  - In the new security group `mysql-sg` allowing connections to the cluster from the internet via port `{{ port-mmy }}`.
  - With 1 `{{ host-class }}` class host in the new `mysubnet` subnet and `{{ zone-id }}` availability zone. The `mysubnet` subnet will have the range `10.5.0.0/24`.
  - With 20 GB fast network storage (`{{ disk-type-example }}`).
  - With one user (`user1`) with the password `user1user1`.
  - With 1 `db1` database, in which `user1` has full rights (the same as `GRANT ALL PRIVILEGES on db1.*`).

  The configuration file for the cluster looks like this:

  ```hcl
  provider "yandex" {
    token = "<OAuth or static key of service account>"
    cloud_id  = "{{ tf-cloud-id }}"
    folder_id = "{{ tf-folder-id }}"
    zone      = "{{ zone-id }}"
  }
  
  resource "yandex_mdb_mysql_cluster" "my-mysql" {
    name               = "my-mysql"
    environment        = "PRESTABLE"
    network_id         = yandex_vpc_network.mynet.id
    version            = "8.0"
    security_group_ids = [ yandex_vpc_security_group.mysql-sg.id ]
  
    resources {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 20
    }
  
    database {
      name = "db1"
    }
  
    user {
      name     = "user1"
      password = "user1user1"
      permission {
        database_name = "db1"
        roles         = ["ALL"]
      }
    }
  
    host {
      zone      = "{{ zone-id }}"
      subnet_id = yandex_vpc_subnet.mysubnet.id
    }
  }
  
  resource "yandex_vpc_network" "mynet" { name = "mynet" }
  
  resource "yandex_vpc_security_group" "mysql-sg" {
    name       = "mysql-sg"
    network_id = yandex_vpc_network.mynet.id
  
    ingress {
      description    = "MySQL"
      port           = {{ port-mmy }}
      protocol       = "TCP"
      v4_cidr_blocks = [ "0.0.0.0/0" ]
    }
  }
  
  resource "yandex_vpc_subnet" "mysubnet" {
    name           = "mysubnet"
    zone           = "{{ zone-id }}"
    network_id     = yandex_vpc_network.mynet.id
    v4_cidr_blocks = [ "10.5.0.0/24" ]
  }
  ```

