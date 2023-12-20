# Managing {{ CH }} cluster hosts

You can add and remove cluster hosts and manage {{ CH }} settings for individual clusters. To learn how to move your cluster hosts to a different availability zone, read this [guide](host-migration.md).

{% note warning %}

If you have created a cluster without [{{ CK }}](../concepts/replication.md#ck) support, then before adding new hosts to any of the [shards](../concepts/sharding.md), [enable fault tolerance](zk-hosts.md#add-zk) using hosts {{ ZK }}.

{% endnote %}

## Getting a list of cluster hosts {#list-hosts}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Click the cluster name and select the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of cluster hosts, run the command:

   ```bash
   {{ yc-mdb-ch }} host list \
     --cluster-name=<cluster_name>
   ```

   ```text
   +----------------------------+--------------+---------+--------+---------------+
   |            NAME            |  CLUSTER ID  |  ROLE   | HEALTH |    ZONE ID    |
   +----------------------------+--------------+---------+--------+---------------+
   | rc1b...{{ dns-zone }} | c9qp71dk1... | MASTER  | ALIVE  | {{ region-id }}-b |
   | rc1a...{{ dns-zone }} | c9qp71dk1... | REPLICA | ALIVE  | {{ region-id }}-a |
   +----------------------------+--------------+---------+--------+---------------+
   ```

   You can request the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To get a list of cluster hosts, use the [listHosts](../api-ref/Cluster/listHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListHosts](../api-ref/grpc/cluster_service.md#ListHosts) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).

{% endlist %}

## Adding a host {#add-host}

The number of hosts in {{ mch-name }} clusters is limited by the CPU and RAM quotas available to DB clusters in your cloud. To check the resources in use, open the [Quotas]({{ link-console-quotas }}) page and find **{{ ui-key.yacloud.iam.folder.dashboard.label_mdb }}**.

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Click the cluster name and go to the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
   1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.button_add-host }}**.

   
   1. Specify the host parameters:
      * Availability zone.
      * Subnet (if the required subnet is not on the list, [create it](../../vpc/operations/subnet-create.md)).
      * Select **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** if the host must be accessible from outside {{ yandex-cloud }}.
      * Name of the shard.
      * Select the **{{ ui-key.yacloud.clickhouse.hosts.dialog.field_copy_schema }}** option to copy the schema from a random replica to the new host.


- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To add a host to a cluster:

   
   1. Request a list of cluster subnets to select one for the new host:

      ```bash
      yc vpc subnet list
      ```

      Result:

      ```text
      +-----------+-----------+------------+---------------+------------------+
      |     ID    |   NAME    | NETWORK ID |     ZONE      |      RANGE       |
      +-----------+-----------+------------+---------------+------------------+
      | b0cl69... | default-c | enp6rq7... | {{ region-id }}-c | [172.16.0.0/20]  |
      | e2lkj9... | default-b | enp6rq7... | {{ region-id }}-b | [10.10.0.0/16]   |
      | e9b0ph... | a-2       | enp6rq7... | {{ region-id }}-a | [172.16.32.0/20] |
      | e9b9v2... | default-a | enp6rq7... | {{ region-id }}-a | [172.16.16.0/20] |
      +-----------+-----------+------------+---------------+------------------+
      ```

      If the required subnet is not in the list, [create it](../../vpc/operations/subnet-create.md).


   1. View a description of the CLI command for adding a host:

      ```bash
      {{ yc-mdb-ch }} host add --help
      ```

   1. Run the add host command:

      
      ```bash
      {{ yc-mdb-ch }} host add \
        --cluster-name=<cluster_name> \
        --host zone-id=<availability_zone>,`
          `subnet-id=<subnet_ID>,`
          `assign-public-ip=<public_access_to_host>,`
          `shard-name=<shard_name>,`
          `type=clickhouse
      ```

      Where `assign-public-ip` indicates whether the host is reachable from the internet over a public IP, `true` or `false`.


      To copy the data schema from a random replica to the new host, set the `--copy-schema` optional parameter.

      {{ mch-name }} will run the add host operation.

      
      The subnet ID should be specified if the availability zone contains multiple subnets; otherwise, {{ mch-name }} will automatically select a single subnet. You can request the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).


- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).
   1. Add a `host` block to the {{ mch-name }} cluster description.

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
        ...
        host {
          type             = "CLICKHOUSE"
          zone             = "<availability_zone>"
          subnet_id        = "<subnet_ID>"
          assign_public_ip = <public_access_to_host>
        }
      }
      ```

      Where `assign_public_ip` indicates whether the host is reachable from the internet over a public IP, `true` or `false`.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

   To add a host, use the [addHosts](../api-ref/Cluster/addHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/AddHosts](../api-ref/grpc/cluster_service.md#AddHosts) gRPC API call and provide the following in the request:
   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * New host settings in one or more `hostSpecs` parameters.

   To copy the data schema from a random replica to the new host, include the `copySchema` parameter set to `true` in the request.

{% endlist %}

{% note warning %}


If you cannot [connect](connect.md) to the added host, check that the cluster [security group](../concepts/network.md#security-groups) is configured correctly for the subnet where you placed the host.


Use the copy data schema option only if the schema is the same on all replica hosts of the cluster.

{% endnote %}

## Changing a host {#update}

You can modify public access settings for every host in a {{ mch-name }} cluster.

{% list tabs %}

- Management console

   To change the parameters of the cluster host:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the required host row and select **{{ ui-key.yacloud.common.edit }}**.
   1. Enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** if the host must be accessible from outside {{ yandex-cloud }}.
   1. Click **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the parameters of the host, run the command:

   ```bash
   {{ yc-mdb-ch }} host update <host_name> \
     --cluster-name=<cluster_name> \
     --assign-public-ip=<public_access_to_host>
   ```

   Where `assign-public-ip` indicates whether the host is reachable from the internet over a public IP, `true` or `false`.

   You can request the host name with a [list of cluster hosts](#list-hosts), and the cluster name, with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).

   1. In the host, use the `host` section to add or edit the `assign_public_ip` parameter.

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
        ...
        host {
          ...
          assign_public_ip = <public_access_to_host>
        }
        ...
      }
      ```

      Where `assign_public_ip` indicates whether the host is reachable from the internet over a public IP, `true` or `false`.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mch }}).

- API

   To update host parameters, use the [updateHosts](../api-ref/Cluster/updateHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/UpdateHosts](../api-ref/grpc/cluster_service.md#UpdateHosts) gRPC API call and provide the following in the request:
   * In the `clusterId` parameter, the ID of the cluster where you want to change the host. To find out the cluster ID, get a [list of clusters in the folder](cluster-list.md#list-clusters).
   * In the `updateHostSpecs.hostName` parameter, the name of the host you want to change. To find out the name, get a [list of hosts in the cluster](#list-hosts).
   * Host public access settings as `updateHostSpecs.assignPublicIp`.
   * A list of cluster configuration fields to modify (`assignPublicIp` in this case) as `updateMask`.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}


{% note warning %}

If you can't [connect](connect.md) to the changed host, check that the cluster's [security group](../concepts/network.md#security-groups) is configured correctly for the subnet where you placed the host.

{% endnote %}


## Removing a host {#remove-host}

You can remove a host from a {{ CH }} cluster if it contains three or more hosts.

{% note info %}

A cluster created with [{{ CK }}](../concepts/replication.md#ck) replication support must include three or more hosts.

{% endnote %}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the required host row and select **{{ ui-key.yacloud.common.delete }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To remove a host from the cluster, run:

   ```bash
   {{ yc-mdb-ch }} host delete <host_name> \
      --cluster-name=<cluster_name>
   ```

   You can request the host name with a [list of cluster hosts](#list-hosts), and the cluster name, with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).
   1. In the {{ mch-name }} cluster description, remove the `CLICKHOUSE` type `host` block.
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Type `yes` and press **Enter**.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

   To delete a host, use the [deleteHosts](../api-ref/Cluster/deleteHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/DeleteHosts](../api-ref/grpc/cluster_service.md#DeleteHosts) gRPC API call and provide the following in the request:
   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Name(s) of the host(s) to delete in the `hostNames` parameter.

{% endlist %}