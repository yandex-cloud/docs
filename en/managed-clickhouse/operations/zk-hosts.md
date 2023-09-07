# Managing {{ ZK }} hosts

Single-host [shards](../concepts/sharding.md) are not fault-tolerant and do not offer data replication. To make such shards fault-tolerant, increase the number of hosts in them by one or more. If a cluster already contains a multi-host shard, you can immediately [add {{ CH }} hosts](hosts.md#add-host) to the desired shard. Otherwise, you must first [enable fault tolerance](#add-zk) and only then will you be able to add {{ CH }} hosts.

For more information, see [Sharding](../concepts/sharding.md).

You can [add](#add-zk-host) and [delete](#delete-zk-host) {{ ZK }} hosts in fault-tolerant clusters. A fault-tolerant cluster can contain a total of three to five {{ ZK }} hosts.

{% note warning %}

If fault tolerance is already enabled for the cluster and {{ ZK }} hosts are created, you can't delete all these hosts because there are always at least 3 {{ ZK }} hosts in the cluster.

{% endnote %}

To learn more, see [Replication](../concepts/replication.md).

## Enabling fault tolerance for the cluster {#add-zk}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
   1. Click **{{ ui-key.yacloud.mdb.cluster.hosts.button_create-zookeeper }}** at the top right.
   1. Specify the [host class](../concepts/instance-types.md).
   1. Set up the storage settings.
   1. Change the {{ ZK }} host settings, if required. To do this, hover over the required host row and click ![image](../../_assets/pencil.svg).
   1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

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
      {{ yc-mdb-ch }} cluster add-zookeeper <cluster name> \
         --host zone-id={{ region-id }}-c,subnet-name=default-c \
         --host zone-id={{ region-id }}-a,subnet-name=default-a \
         --host zone-id={{ region-id }}-b,subnet-name=default-b
      ```

      If the network hosting the cluster contains exactly 3 subnets, each per availability zone, you do not have to explicitly specify subnets for the hosts: {{ mch-name }} automatically distributes hosts over the subnets.

      The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).
   1. Make sure the configuration file describes three subnets, one for each availability zone. Add the missing ones, if required:

      ```hcl
      resource "yandex_vpc_network" "<network name>" {
        name = "<network name>"
      }

      resource "yandex_vpc_subnet" "<name of subnet in {{ region-id }}-a zone>" {
        name           = "<name of subnet in {{ region-id }}-a zone>"
        zone           = "{{ region-id }}-a"
        network_id     = yandex_vpc_network.<network name>.id
        v4_cidr_blocks = [ "<subnet address range in {{ region-id }}-a zone>" ]
      }

      resource "yandex_vpc_subnet" "<name of subnet in {{ region-id }}-b zone>" {
        name           = "<name of subnet in {{ region-id }}-b zone>"
        zone           = "{{ region-id }}-b"
        network_id     = yandex_vpc_network.<network name>.id
        v4_cidr_blocks = [ "<subnet address range in {{ region-id }}-b zone>" ]
      }

      resource "yandex_vpc_subnet" "<name of subnet in {{ region-id }}-c zone>" {
        name           = "<name of subnet in {{ region-id }}-c zone>"
        zone           = "{{ region-id }}-c"
        network_id     = yandex_vpc_network.<network name>.id
        v4_cidr_blocks = [ "<subnet address range in {{ region-id }}-c zone>" ]
      }
      ```

   1. Add the required number of `CLICKHOUSE` type `host` blocks to the {{ CH }} cluster description.

      {{ CH }} host requirements:
      * Minimum host class: `b1.medium`.
      * If there are several hosts, they must be located in different availability zones.

      If necessary, change the class of existing {{ CH }} hosts and availability zone and add the required number of new hosts.

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
        name                = "<cluster name>"
        ...
        clickhouse {
          resources {
            resource_preset_id = "<host class: b1.medium or higher>"
            disk_type_id       = "<disk type>"
            disk_size          = <storage size, GB>
          }
        }
        ...
        host {
          type      = "CLICKHOUSE"
          zone      = "{{ region-id }}-a"
          subnet_id = yandex_vpc_subnet.<name of subnet in {{ region-id }}-a availability zone>.id
        }
        ...
      }
      ```

   1. Add at least 3 `ZOOKEEPER` type `host` blocks to the {{ CH }} cluster description.

      {{ ZK }} host requirements:
      * Each availability zone must have at least one host.
      * Minimum host class: `b1.medium`.
      * Disk type: `{{ disk-type-example }}`.
      * The minimum storage size is 10 GB.

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
        ...
        zookeeper {
          resources {
            resource_preset_id = "<host class: b1.medium or higher>"
            disk_type_id       = "{{ disk-type-example }}"
            disk_size          = <storage size, GB>
          }
        }
        ...
        host {
          type      = "ZOOKEEPER"
          zone      = "{{ region-id }}-a"
          subnet_id = yandex_vpc_subnet.<name of subnet in {{ region-id }}-a availability zone>.id
        }
        host {
          type      = "ZOOKEEPER"
          zone      = "{{ region-id }}-b"
          subnet_id = yandex_vpc_subnet.<name of subnet in {{ region-id }}-b availability zone>.id
        }
        host {
          type      = "ZOOKEEPER"
          zone      = "{{ region-id }}-c"
          subnet_id = yandex_vpc_subnet.<name of subnet in {{ region-id }}-c availability zone>.id
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mch }}).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

   To enable fault tolerance for a cluster, use the [addZookeeper](../api-ref/Cluster/addZookeeper.md) method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/AddZookeeper](../api-ref/grpc/cluster_service.md#AddZookeeper) gRPC API call. For the added hosts, specify the settings for three {{ ZK }} hosts by listing them in the `hostSpecs` parameter.

{% endlist %}

{% note info %}

{{ ZK }} hosts get the following specs by default:
* `b2.medium` host class.
* 10 GB of network SSD [storage](../concepts/storage.md) (`{{ disk-type-example }}`).

{% endnote %}

## Adding a {{ ZK }} host {#add-zk-host}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Click the cluster name and select the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
   1. Click **{{ ui-key.yacloud.mdb.cluster.hosts.button_add-zookeeper }}**.
   1. If required, change the host settings.
   1. Click **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To add a host to a cluster:
   1. Collect the necessary information:
      * Request the subnet ID by running the command:

         ```bash
         yc vpc subnet list
         ```

         
         If the necessary subnet is not in the list, [create it](../../vpc/operations/subnet-create.md).


      * You can get the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).
   1. View a description of the CLI command for adding a host:

      ```bash
      {{ yc-mdb-ch }} host add --help
      ```

   1. Run the add {{ ZK }} host command:

      ```bash
      {{ yc-mdb-ch }} hosts add \
        --cluster-name <cluster name \
        --host zone-id=<availability zone>,subnet-id=<subnet ID>,type=zookeeper
      ```

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).
   1. Add a `host` block of the `ZOOKEEPER` type to the {{ mch-name }} cluster description:

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
        ...
        host {
          type      = "ZOOKEEPER"
          zone      = "<availability zone>"
          subnet_id = yandex_vpc_subnet.<subnet in selected availability zone>.id
        }
        ...
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

   To add a {{ ZK }} host, use the [addHosts](../api-ref/Cluster/addHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/AddHosts](../api-ref/grpc/cluster_service.md#AddHosts) gRPC API call and provide the following in the request:
   * In the `clusterId` parameter, the ID of the cluster where you want to locate the host. To find out the cluster ID, get a [list of clusters in the folder](cluster-list.md#list-clusters).
   * Settings for the host, in the `hostSpecs` parameter (in addition, specify the `ZOOKEEPER` type in the `hostSpecs.type` parameter). Do not specify settings for multiple hosts in this parameter because {{ ZK }} hosts are added to the cluster one by one unlike [{{ CH }} hosts](hosts.md#add-host), which can be added several at a time.

{% endlist %}

## Deleting a {{ ZK }} host {#delete-zk-host}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Click the cluster name and select the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
   1. Hover over the required host row and click ![image](../../_assets/cross.svg).
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To remove a host from the cluster, run:

   ```bash
   {{ yc-mdb-ch }} hosts delete <host name> \
     --cluster-name=<cluster name>
   ```

   The host name can be requested with a [list of cluster hosts](hosts.md#list-hosts), and the cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).
   1. In the {{ mch-name }} cluster description, delete the `ZOOKEEPER` type `host` block.
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Type `yes` and press **Enter**.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

   To delete a {{ ZK }} host, use the [deleteHosts](../api-ref/Cluster/deleteHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/DeleteHosts](../api-ref/grpc/cluster_service.md#DeleteHosts) gRPC API call and provide the following in the request:
   * ID of the cluster where the host is located, in the `clusterId` parameter. To find out the cluster ID, get a [list of clusters in the folder](cluster-list.md#list-clusters).
   * Host name, in the `hostNames` parameter. To find out the name, request a [list of hosts in the cluster](hosts.md#list-hosts).

{% endlist %}