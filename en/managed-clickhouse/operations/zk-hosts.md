# Managing {{ ZK }} hosts

[Shards](../concepts/sharding.md) with two or more hosts with [{{ CK }}](../concepts/replication.md#ck) support are fault-tolerant by default. If the cluster was created without {{ CK }} support, its shards with a single host are not fault-tolerant and do not ensure data replication. To make the shards of this cluster fault-tolerant:

1. [Enable fault tolerance using {{ ZK }}](#add-zk).
1. [Add additional {{ CH }}](./hosts.md#add-host) hosts to the shard.

You can [add](#add-zk-host) and [delete](#delete-zk-host) {{ ZK }} hosts in a fault-tolerant cluster. A fault-tolerant cluster can contain a total of 3 to 5 {{ ZK }} hosts.

{% note warning %}

If fault tolerance is already enabled for the cluster and {{ ZK }} hosts are created, you can't delete all these hosts because there are always at least 3 {{ ZK }} hosts in the cluster.

{% endnote %}

For more information, see [{#T}](../concepts/replication.md).

## Enabling fault tolerance for the cluster {#add-zk}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click on the name of the cluster you need and select the **Hosts** tab.
  1. Click **Set up {{ ZK }} hosts**.
  1. Specify the [host class](../concepts/instance-types.md).
  1. Set up the storage settings.
  1. Change the settings of a {{ ZK }} host if necessary. To do this, hover the cursor over the line of the required host and click ![image](../../_assets/pencil.svg).
  1. Click **Save changes**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To enable fault tolerance for a cluster:

  1. View a description of the CLI command for adding {{ ZK }} hosts:

     ```bash
     {{ yc-mdb-ch }} cluster add-zookeeper --help
     ```

  1. Run the operation with the default host characteristics:

     ```bash
     $ yc managed-clickhouse cluster add-zookeeper <cluster name> \
                            --host zone-id=ru-central1-c,subnet-name=default-c \
                            --host zone-id=ru-central1-a,subnet-name=default-a \
                            --host zone-id=ru-central1-b,subnet-name=default-b
     ```

     If the network hosting the cluster contains exactly 3 subnets, each per availability zone, you do not have to explicitly specify subnets for the hosts: {{ mch-name }} automatically distributes hosts over the subnets.

     You can query the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. Make sure that the configuration file describes three subnets: one for each availability zone. If necessary, add the missing ones:

        ```hcl
        resource "yandex_vpc_network" "<network name>" {
          name = "<network name>"
        }
        
        resource "yandex_vpc_subnet" "<subnet name in the ru-central1-a zone>" {
          name           = "<subnet name in the ru-central1-a zone>"
          zone           = "ru-central1-a"
          network_id     = yandex_vpc_network.<network name>.id
          v4_cidr_blocks = [ "<range of subnet addresses in the ru-central1-a zone>" ]
        }
        
        resource "yandex_vpc_subnet" "<subnet name in the ru-central1-b zone>" {
          name           = "<subnet name in the ru-central1-b zone>"
          zone           = "ru-central1-b"
          network_id     = yandex_vpc_network.<network name>.id
          v4_cidr_blocks = [ "<range of subnet addresses in the ru-central1-b zone>" ]
        }
        
        resource "yandex_vpc_subnet" "<subnet name in the ru-central1-c zone>" {
          name           = "<subnet name in the ru-central1-c zone>"
          zone           = "ru-central1-c"
          network_id     = yandex_vpc_network.<network name>.id
          v4_cidr_blocks = [ "<range of subnet addresses in the ru-central1-c zone>" ]
        }
        ```

    1. Add the required number of `CLICKHOUSE` type `host` blocks to the {{ CH }} cluster description.

        {{ CH }} host requirements:

        * Minimum host class: `b1.medium`.
        * If there are several hosts, they must be located in different availability zones.

        If necessary, change the class of existing {{ CH }} hosts and availability zone and add the required number of new hosts.

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
          name = "<cluster name>"
          ...
          clickhouse {
            resources {
              resource_preset_id = "<host class: b1.medium or higher>"
              disk_type_id       = "<storage type>"
              disk_size          = <storage size in GB>
            }
          }
          ...
          host {
            type      = "CLICKHOUSE"
            zone      = "ru-central1-a"
            subnet_id = yandex_vpc_subnet.<name of the subnet in the ru-central1-a availability zone>.id
          }
          ...
        }
        ```

    1. Add at least 3 `ZOOKEEPER` type `host` blocks to the {{ CH }} cluster description.

        {{ ZK }} host requirements:

        * Each availability zone must have at least one host.
        * Minimum host class: `b1.medium`.
        * Storage type: `network-ssd`.
        * The minimum storage size is 10 GB.

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
          ...
          zookeeper {
            resources {
              resource_preset_id = "<host class: b1.medium or higher>"
              disk_type_id       = "network-ssd"
              disk_size          = <storage size in GB>
            }
          }
          ...
          host {
            type      = "ZOOKEEPER"
            zone      = "ru-central1-a"
            subnet_id = yandex_vpc_subnet.<name of the subnet in the ru-central1-a availability zone>.id
          }
          host {
            type      = "ZOOKEEPER"
            zone      = "ru-central1-b"
            subnet_id = yandex_vpc_subnet.<name of the subnet in the ru-central1-b availability zone>.id
          }
          host {
            type      = "ZOOKEEPER"
            zone      = "ru-central1-c"
            subnet_id = yandex_vpc_subnet.<name of the subnet in the ru-central1-c availability zone>.id
          }
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mch }}).

- API

  Use the [addZookeeper](../api-ref/Cluster/addZookeeper.md) method. For the added hosts, specify the settings for the 3 {{ ZK }} hosts by listing them in the `hostSpecs` parameter.

{% endlist %}

{% note info %}

The following characteristics are set for the {{ ZK }} hosts by default:
* The `b2.medium` host class.
* 10 GB disk size.
* [Storage type](../concepts/storage.md): Fast network storage.

{% endnote %}

## Adding a {{ ZK }} host {#add-zk-host}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click on the name of the cluster you need and select the **Hosts** tab.
  1. Click **Add {{ ZK }} hosts**.
  1. If necessary, change the host settings.
  1. Click **Save changes**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To add a host to a cluster:
  1. Collect the necessary information:
     - Request the subnet ID by running the command:
       ```
       $ yc vpc subnet list
       ```
       If the necessary subnet is not in the list, [create it](../../vpc/operations/subnet-create.md).
     - You can get the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View a description of the CLI command for adding a host:

     ```
     $ {{ yc-mdb-ch }} host add --help
     ```

  1. Run the add {{ ZK }} host command:

     ```
     $ {{ yc-mdb-ch }} hosts add \
          --cluster-name <cluster name> \
          --host zone-id=<availability zone>,subnet-id=<subnet ID>,type=zookeeper
     ```

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. Add a `ZOOKEEPER` type `host` block to the {{ mch-name }} cluster description:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
          ...
          host {
            type      = "ZOOKEEPER"
            zone      = "<availability zone>"
            subnet_id = yandex_vpc_subnet.<name of the subnet in the selected availability zone>.id
          }
          ...
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

- API

  Use the [addHosts](../api-ref/Cluster/addHosts.md) method and pass the following in the request:
  - In the `clusterId` parameter, the ID of the cluster where you want to locate the host. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - Settings for the host, in the `hostSpecs` parameter (in addition, specify the `ZOOKEEPER` type in the `hostSpecs.type` parameter). Do not specify settings for multiple hosts in this parameter because {{ ZK }} hosts are added to the cluster one by one unlike [{{ CH }} hosts](hosts.md#add-host), which can be added several at a time.

{% endlist %}

## Deleting a {{ ZK }} host {#delete-zk-host}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click on the name of the cluster you need and select the **Hosts** tab.
  1. Hover the cursor over the line of the required host and click ![image](../../_assets/cross.svg).
  1. Confirm the deletion of the host.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To remove a host from the cluster, run:

  ```
  $ {{ yc-mdb-ch }} hosts delete <host name> \
       --cluster-name=<cluster name>
  ```

  The host name can be requested with a [list of cluster hosts](hosts.md#list-hosts), and the cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. In the {{ mch-name }} cluster description, delete the `ZOOKEEPER` type `host` block.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the deletion of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

- API

  Use the [deleteHosts](../api-ref/Cluster/deleteHosts.md) method and pass the following in the request:
  - The ID of the cluster where the host is located, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - Host name, in the `hostNames` parameter. To find out the name, request a [list of hosts in the cluster](hosts.md#list-hosts).

{% endlist %}
