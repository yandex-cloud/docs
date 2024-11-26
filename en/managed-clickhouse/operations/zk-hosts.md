# Managing {{ ZK }} hosts


Single-host [shards](../concepts/sharding.md) are not fault-tolerant and do not offer [data replication](../concepts/replication.md). To make such shards fault-tolerant, add more hosts to them. If a cluster already contains a multi-host shard, you can immediately [add {{ CH }} hosts](hosts.md#add-host) to the appropriate shard. Otherwise, you must first enable fault tolerance and only then will you be able to add {{ CH }} hosts.

{% note warning %}

If fault tolerance is already enabled for the cluster and {{ ZK }} hosts are created, you cannot delete all these hosts because there are always at least three {{ ZK }} hosts in the cluster.

{% endnote %}

You can perform the following actions on {{ ZK }} hosts in fault-tolerant clusters:

* [Get a list of cluster hosts](#list-hosts).
* Use {{ ZK }} hosts to [enable fault tolerance](#add-zk).
* [Add a host](#add-zk-host).
* [Restart a host](#restart).
* [Remove a host](#delete-zk-host).

A fault-tolerant cluster can contain a total of three to five {{ ZK }} hosts.

For information about moving {{ ZK }} hosts to a different availability zone, see [this guide](host-migration.md#zookeeper-hosts).

## Getting a list of cluster hosts {#list-hosts}

{% include notitle [get-hosts](../../_includes/mdb/mch/get-hosts.md) %}


## Enabling fault tolerance for the cluster {#add-zk}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
  1. At the top right, click **{{ ui-key.yacloud.mdb.cluster.hosts.button_create-zookeeper }}**.
  1. Specify the [host class](../concepts/instance-types.md).
  1. Set up the storage settings.
  1. Change the {{ ZK }} host settings, if required. To do this, hover over the host's row and click ![image](../../_assets/console-icons/pencil.svg).
  1. To convert non-replicated tables to [replicated](../concepts/replication.md#replicated-tables), enable **{{ ui-key.yacloud.clickhouse.field_convert_tables_to_replicated }}**.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To enable fault tolerance for a cluster:
  1. View a description of the CLI command for adding {{ ZK }} hosts:

     ```bash
     {{ yc-mdb-ch }} cluster add-zookeeper --help
     ```

  1. Run the operation with the default host characteristics:

     ```bash
     {{ yc-mdb-ch }} cluster add-zookeeper <cluster_name> \
        --host zone-id={{ region-id }}-d,subnet-name=default-d \
        --host zone-id={{ region-id }}-a,subnet-name=default-a \
        --host zone-id={{ region-id }}-b,subnet-name=default-b
     ```

     If the network hosting the cluster contains exactly 3 subnets, each per availability zone, you do not have to explicitly specify subnets for the hosts: {{ mch-name }} automatically distributes hosts over the subnets.

     To convert non-replicated tables to [replicated](../concepts/replication.md#replicated-tables), add the `--convert-tables-to-replicated` parameter to the command.

     You can request the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

     For more information about creating this file, see [Creating clusters](cluster-create.md).
  1. Make sure the configuration file describes three subnets, one for each availability zone. Add the missing ones, if required:

     ```hcl
     resource "yandex_vpc_network" "<network_name>" {
       name = "<network_name>"
     }

     resource "yandex_vpc_subnet" "<subnet_name_in_{{ region-id }}-a_zone>" {
       name           = "<subnet_name_in_{{ region-id }}-a_zone>"
       zone           = "{{ region-id }}-a"
       network_id     = yandex_vpc_network.<network_name>.id
       v4_cidr_blocks = [ "<{{ region-id }}-a_zone_subnet_IP_address_range>" ]
     }

     resource "yandex_vpc_subnet" "<subnet_name_in_{{ region-id }}-b_zone>" {
       name           = "<subnet_name_in_{{ region-id }}-b_zone>"
       zone           = "{{ region-id }}-b"
       network_id     = yandex_vpc_network.<network_name>.id
       v4_cidr_blocks = [ "<{{ region-id }}-b_zone_subnet_IP_address_range>" ]
     }

     resource "yandex_vpc_subnet" "<subnet_name_in_{{ region-id }}-d_zone>" {
       name           = "<subnet_name_in_{{ region-id }}-d_zone>"
       zone           = "{{ region-id }}-d"
       network_id     = yandex_vpc_network.<network_name>.id
       v4_cidr_blocks = [ "<{{ region-id }}-d_zone_subnet_IP_address_range>" ]
     }
     ```

  1. Add the required number of `CLICKHOUSE` type `host` blocks to the {{ CH }} cluster description.

     {{ CH }} host requirements:
     * Minimum host class: `b1.medium`.
     * If there are several hosts, they must be located in different availability zones.

     If necessary, change the class of existing {{ CH }} hosts and availability zone and add the required number of new hosts.

     ```hcl
     resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
       name = "<cluster_name>"
       ...
       clickhouse {
         resources {
           resource_preset_id = "<host_class>"
           disk_type_id       = "<disk_type>"
           disk_size          = <storage_size_in_GB>
         }
       }
       ...
       host {
         type      = "CLICKHOUSE"
         zone      = "{{ region-id }}-a"
         subnet_id = yandex_vpc_subnet.<subnet_name_in_{{ region-id }}-a_zone>.id
       }
       ...
     }
     ```

     Where `resource_preset_id` is the host class: `b1.medium` or higher.

  1. Add at least three `ZOOKEEPER` type `host` blocks to the {{ CH }} cluster description.

     {{ ZK }} host requirements:
     * Each availability zone must have at least one host.
     * Minimum host class: `b1.medium`.
     * Disk type: `{{ disk-type-example }}`.
     * The minimum storage size is 10 GB.

     ```hcl
     resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
       ...
       zookeeper {
         resources {
           resource_preset_id = "<host_class>"
           disk_type_id       = "{{ disk-type-example }}"
           disk_size          = <storage_size_in_GB>
         }
       }
       ...
       host {
         type      = "ZOOKEEPER"
         zone      = "{{ region-id }}-a"
         subnet_id = yandex_vpc_subnet.<subnet_name_in_{{ region-id }}-a_zone>.id
       }
       host {
         type      = "ZOOKEEPER"
         zone      = "{{ region-id }}-b"
         subnet_id = yandex_vpc_subnet.<subnet_name_in_{{ region-id }}-b_zone>.id
       }
       host {
         type      = "ZOOKEEPER"
         zone      = "{{ region-id }}-d"
         subnet_id = yandex_vpc_subnet.<subnet_name_in_{{ region-id }}-d_zone>.id
       }
     }
     ```

     Where `resource_preset_id` is the host class: `b1.medium` or higher.

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mch }}).

  {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API {#api}

  To enable fault tolerance for a cluster, use the [addZookeeper](../api-ref/Cluster/addZookeeper.md) method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/AddZookeeper](../api-ref/grpc/Cluster/addZookeeper.md) gRPC API call and provide the following in the request:

  * Cluster ID, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
  * Settings for three {{ ZK }} hosts in the `hostSpecs` parameter.
  * Whether or not to convert non-replicated tables to [replicated](../concepts/replication.md#replicated-tables) in the `convertTablesToReplicated` parameter.

{% endlist %}

{% note info %}

{{ ZK }} hosts get the following specs by default:
* Host class: `b2.medium`.
* Network SSD [storage](../concepts/storage.md) (`{{ disk-type-example }}`): 10 GB.

{% endnote %}

## Adding a {{ ZK }} host {#add-zk-host}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the name of the cluster you need and select the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.hosts.button_add-zookeeper }}**.
  1. If required, change the host settings.
  1. Click **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To add a host to a cluster:
  1. Collect the necessary information:
     * Request the subnet ID by running the command:

       ```bash
       yc vpc subnet list
       ```


       If the required subnet is not in the list, [create it](../../vpc/operations/subnet-create.md).


     * You can get the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).
  1. View a description of the CLI command for adding a host:

     ```bash
     {{ yc-mdb-ch }} host add --help
     ```

  1. Run the add {{ ZK }} host command:

     ```bash
     {{ yc-mdb-ch }} hosts add \
       --cluster-name <cluster_name> \
       --host zone-id=<availability_zone>,subnet-id=<subnet_ID>,type=zookeeper
     ```

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

     For more information about creating this file, see [Creating clusters](cluster-create.md).
  1. Add a `ZOOKEEPER` type `host` block to the {{ mch-name }} cluster description.

    ```hcl
     resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
       ...
       host {
         type      = "ZOOKEEPER"
         zone      = "<availability_zone>"
         subnet_id = yandex_vpc_subnet.<subnet_name_in_selected_availability_zone>.id
       }
       ...
     }
     ```

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API {#api}

  To add a {{ ZK }} host, use the [addHosts](../api-ref/Cluster/addHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/AddHosts](../api-ref/grpc/Cluster/addHosts.md) gRPC API call and provide the following in the request:
  * ID of the cluster you want the host to reside in, in the `clusterId` parameter. To find out the cluster ID, get [a list of clusters in the folder](cluster-list.md#list-clusters).
  * Host settings in the `hostSpecs` parameter (in addition, specify the `ZOOKEEPER` type in the `hostSpecs.type` parameter). Do not specify settings for multiple hosts in this parameter because {{ ZK }} hosts are added to the cluster one by one unlike [{{ CH }} hosts](hosts.md#add-host), which can be added several at a time.

{% endlist %}

## Restarting a {{ ZK }} host {#restart}

{% include notitle [restart-host](../../_includes/mdb/mch/restart-host.md) %}

## Removing a {{ ZK }} host {#delete-zk-host}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the name of the cluster you need and select the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
  1. Hover over the host's row and click ![image](../../_assets/console-icons/xmark.svg).
  1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To remove a host from the cluster, run:

  ```bash
  {{ yc-mdb-ch }} hosts delete <host_name> \
    --cluster-name=<cluster_name>
  ```

  You can request the host name with a [list of cluster hosts](hosts.md#list-hosts), and the cluster name, with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [Creating clusters](cluster-create.md).
   1. Delete the `ZOOKEEPER` type `host` block from the {{ mch-name }} cluster description.
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Type `yes` and press **Enter**.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API {#api}

  To delete a {{ ZK }} host, use the [deleteHosts](../api-ref/Cluster/deleteHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/DeleteHosts](../api-ref/grpc/Cluster/deleteHosts.md) gRPC API call and provide the following in the request:
  * ID of the cluster the host resides in, in the `clusterId` parameter. To find out the cluster ID, get [a list of clusters in the folder](cluster-list.md#list-clusters).
  * Host name in the `hostNames` parameter. To find out the name, get a [list of hosts in the cluster](hosts.md#list-hosts).

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}