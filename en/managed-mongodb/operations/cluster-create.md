# Creating {{ MG }} clusters

{{ MG }} clusters are one or more database hosts that replication can be configured between. Replication is enabled by default in any cluster consisting of more than one host (the primary host accepts write requests and asynchronously duplicates changes in the secondary hosts).

{% if audience != "internal" %}

{% note info %}

* The number of hosts that can be created together with a {{ MG }} cluster depends on the selected [storage type](../concepts/storage.md#storage-type-selection) and [host class](../concepts/instance-types.md#available-flavors).
* Available storage types [depend on](../concepts/storage.md) the selected [host class](../concepts/instance-types.md#available-flavors).

{% endnote %}

{% if policy != "keep" %}

{% note info %}

The creation of {{ MG }} 4.0 clusters will be disabled in December 2021 due to the version 4.0 [End of Life](https://www.mongodb.com/support-policy).

In January 2022, all existing clusters with this {{ MG }} version will be [forcibly upgraded](../qa/general.md#dbms-deprecated) to version 4.2. We recommend that you [upgrade](../operations/cluster-version-update.md) to the latest {{ MG }} versions in advance.

{% endnote %}

{% endif %}

{% endif %}

{% list tabs %}

- Management console

  To create a cluster:

  1. In the management console, select the folder where you want to create a DB cluster.
  1. Select **{{ mmg-name }}**.
  1. Click **Create cluster**.
  1. Name the cluster in the **Cluster name** field. The cluster name must be unique within the folder.
  1. Enter a name for the cluster in the **Cluster name** field. The cluster name must be unique within the folder.
     * `PRODUCTION`: For stable versions of your apps.
     * `PRESTABLE`: For testing, including the {{ mmg-short-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.
  1. Select the DBMS version.
  1. Select the host class that defines the technical specifications of the VMs where the DB hosts will be deployed. When you change the host class for the cluster, the characteristics of all existing hosts change, too.
  1. Under **Storage size**:

      * Select the [type of storage](../concepts/storage.md).

          {% include [storages-step-settings-no-ice-lake](../../_includes/mdb/settings-storages-no-v3.md) %}

      * Select the size to be used for data and backups. For more information about how backups take up storage space, see [{#T}](../concepts/backup.md).

  1. Under **Database**, specify the DB attributes:
      * DB name.
      * Username.
      * User password. At least 8 characters.
  1. Under **Network settings**, select the cloud network to host the cluster in and security groups for cluster network traffic. You may need to additionally [set up security groups](connect.md#configuring-security-groups) to connect to the cluster.
  1. Under **Hosts**, select parameters for the database hosts created with the cluster. If you open the **Advanced settings** section, you can choose specific subnets for each host. By default, each host is created in a separate subnet.
  1. If necessary, configure additional cluster settings:

      {% include [mmg-extra-settings](../../_includes/mdb/mmg-extra-settings.md) %}

  1. If necessary, configure the [DBMS settings](../concepts/settings-list.md#dbms-cluster-settings).

      {% include [mmg-settings-dependence](../../_includes/mdb/mmg/note-info-settings-dependence.md) %}

  1. Click **Create cluster**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a cluster:

  {% if audience != "internal" %}

  1. Check whether the folder has any subnets for the cluster hosts:

     ```
     $ yc vpc subnet list
     ```

     If there are no subnets in the folder, [create the necessary subnets](../../vpc/operations/subnet-create.md) in {{ vpc-short-name }}.

  {% endif %}

  1. View a description of the CLI's create cluster command:

      ```
      $ {{ yc-mdb-mg }} cluster create --help
      ```

  1. Specify the cluster parameters in the create command (only some of the supported parameters are given in the example):

      {% if audience != "internal" %}

      ```bash
      {{ yc-mdb-mg }} cluster create \
         --name <cluster name> \
         --environment=<prestable or production> \
         --network-name <network name> \
         --host zone-id=<availability zone>,subnet-id=<subnet ID> \
         --mongod-resource-preset <host class> \
         --user name=<username>,password=<user password> \
         --database name=<database name> \
         --mongod-disk-type <network-hdd | network-ssd | local-ssd | network-ssd-nonreplicated> \
         --mongod-disk-size <storage size in GB> \
         --deletion-protection=<protect cluster from deletion: true or false>
      ```

      The subnet ID `subnet-id` should be specified if the selected availability zone contains two or more subnets.

      {% else %}

      ```bash
      {{ yc-mdb-mg }} cluster create \
         --name <cluster name> \
         --environment=<prestable or production> \
         --network-id {{ network-name }} \
         --host zone-id=<availability zone> \
         --mongod-resource-preset <host class> \
         --user name=<username>,password=<user password> \
         --database name=<database name> \
         --mongod-disk-type local-ssd \
         --mongod-disk-size <storage size in GB> \
         --deletion-protection=<protect cluster from deletion: true or false>
      ```

      {% endif %}

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

- Terraform

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}
{% if audience != "internal" %}

  If you don't have Terraform, [install it and configure the provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  {% else %}

  If you don't have Terraform, install it and configure the provider.

  {% endif %}
  To create a cluster:

  1. In the configuration file, describe the parameters of resources that you want to create:

     * Database cluster: Description of the cluster and its hosts.

     * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

     * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

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
       token     = "<OAuth or static key of service account>"
       cloud_id  = "<cloud ID>"
       folder_id = "<folder ID>"
       zone      = "<availability zone>"
     }

     resource "yandex_mdb_mongodb_cluster" "<cluster name>" {
       name                = "<cluster name>"
       environment         = "<environment: PRESTABLE or PRODUCTION>"
       network_id          = "<network ID>"
       security_group_ids  = [ "<list of security groups>" ]
       deletion_protection = <protect cluster from deletion: true or false>

       cluster_config {
         version = "<MongoDB version: 4.0, 4.2, 4.4, or 5.0>"
       }

       database {
         name = "<DB name>"
       }

       user {
         name     = "<username>"
         password = "<user password>"
         permission {
           database_name = "<database name>"
           roles         = [ "<list of user roles>" ]
         }
       }

       resources {
         resource_preset_id = "<host class>"
         disk_type_id       = "<storage type>"
         disk_size          = <storage size in GB>
       }

       host {
         zone_id           = "<availability zone>"
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

     {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

     For more information about the resources you can create using Terraform, see the [provider documentation]({{ tf-provider-mmg }}).

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Create a cluster.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      After this, all the necessary resources will be created in the specified folder and the IP addresses of the VMs will be displayed in the terminal. You can check resource availability and their settings in the [management console]({{ link-console-main }}).

{% endlist %}

{% note warning %}

If you specified security group IDs when creating a cluster, you may also need to [re-configure security groups](connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}

## Examples {#examples}

### Creating a single-host cluster {#creating-a-single-host-cluster}

{% list tabs %}

- CLI

  To create a cluster with a single host, pass a single `--host` parameter.

  Let's say we need to create a {{ MG }} cluster with the following characteristics:

  {% if audience != "internal" %}
  * Named `mymg`.
  * In the `production` environment.
  * In the `{{ network-name }}` network.
  * In the security group with the ID `{{ security-group }}`.
  * With one `{{ host-class }}` class host in the `b0rcctk2rvtr8efcch64` subnet in the `{{ zone-id }}` availability zone.
  * With 20 GB of SSD network storage (`{{ disk-type-example }}`).
  * With one user, `user1`, with the password `user1user1`.
  * With one database, `db1`.
  * With protection against accidental cluster deletion.

  {% else %}
  * Named `mymg`.
  * In the `production` environment.
  * In the security group with the ID `{{ security-group }}`.
  * With one `{{ host-class }}` class host in the `{{ zone-id }}` availability zone.
  * With 20 GB of local SSD storage (`local-ssd`).
  * With one user, `user1`, with the password `user1user1`.
  * With one database, `db1`.
  * With protection against accidental cluster deletion.

  {% endif %}

  Run the command:

  {% if audience != "internal" %}

  ```bash
  {{ yc-mdb-mg }} cluster create \
       --name mymg \
       --environment production \
       --network-name {{ network-name }} \
       --security-group-ids {{ security-group }} \
       --mongod-resource-preset {{ host-class }} \
       --host zone-id={{ zone-id }},subnet-id=b0rcctk2rvtr8efcch64 \
       --mongod-disk-size 20 \
       --mongod-disk-type {{ disk-type-example }} \
       --user name=user1,password=user1user1 \
       --database name=db1 \
       --deletion-protection=true
  ```

  {% else %}

  ```bash
  {{ yc-mdb-mg }} cluster create \
       --name mymg \
       --environment production \
       --network-id {{ network-name }} \
       --security-group-ids {{ security-group }} \
       --mongod-resource-preset {{ host-class }} \
       --host zone-id={{ zone-id }} \
       --mongod-disk-size 20 \
       --mongod-disk-type local-ssd \
       --user name=user1,password=user1user1 \
       --database name=db1 \
       --deletion-protection=true
  ```

  {% endif %}

- Terraform

  Let's say we need to create a {{ MG }} cluster and a network for it with the following characteristics:
    * Named `mymg`.
    * Version `4.4`.
    * In the `PRODUCTION` environment.
    * In the cloud with the ID `{{ tf-cloud-id }}`.
    * In the folder with the ID `{{ tf-folder-id }}`.
    * In the new `mynet` network.
    * With 1 `{{ host-class }}` class host in the new `mysubnet` subnet and `{{ zone-id }}` availability zone. The `mysubnet` subnet will have the range `10.5.0.0/24`.
    * In the new security group `mymg-sg` allowing TCP connections to the cluster from the internet via port `{{ port-mmg }}`.
    * With 20 GB of SSD network storage (`{{ disk-type-example }}`).
    * With one user, `user1`, with the password `user1user1`.
    * With one database, `db1`.
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
    token     = "<OAuth or static key of service account>"
    cloud_id  = "{{ tf-cloud-id }}"
    folder_id = "{{ tf-folder-id }}"
    zone      = "{{ zone-id }}"
  }

  resource "yandex_mdb_mongodb_cluster" "mymg" {
    name                = "mymg"
    environment         = "PRODUCTION"
    network_id          = yandex_vpc_network.mynet.id
    security_group_ids  = [ yandex_vpc_security_group.mymg-sg.id ]
    deletion_protection = true

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
