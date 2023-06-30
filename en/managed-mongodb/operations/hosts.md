# Managing {{ MG }} cluster hosts

You can add and remove [cluster hosts](../concepts/index.md), resync the hosts, and [manage {{ MG }} settings](update.md) for individual clusters.

## Getting a list of cluster hosts {#list-hosts}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
   1. Click the name of the {{ mmg-name }} cluster.
   1. Go to the **Hosts** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of {{ mmg-name }} cluster hosts, run this command:

   ```bash
   {{ yc-mdb-mg }} host list \
     --cluster-name <cluster name>
   ```

   Result:

   
   ```text
   +-----------------------+--------------+--------+------------+-----------+----------+-------------------+-----------+
   |         NAME          |  CLUSTER ID  |  TYPE  | SHARD NAME |   ROLE    |  HEALTH  |      ZONE ID      | PUBLIC IP |
   +-----------------------+--------------+--------+------------+-----------+----------+-------------------+-----------+
   | rc1b...{{ dns-zone }} | c9qp71dk1... | MONGOD | rs01       | PRIMARY   | ALIVE    | {{ region-id }}-b | false     |
   | rc1a...{{ dns-zone }} | c9qp71dk1... | MONGOD | rs01       | SECONDARY | ALIVE    | {{ region-id }}-a | false     |
   +-----------------------+--------------+--------+------------+-----------+----------+-------------------+-----------+
   ```


   You can get the {{ mmg-name }} cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To get a list of {{ mmg-name }} cluster hosts, use the [listHosts](../api-ref/Cluster/listHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListHosts](../api-ref/grpc/cluster_service.md#ListHosts) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Adding a host {#add-host}

The number of hosts in {{ mmg-name }} clusters is limited by the CPU and RAM quotas available to DB clusters in your [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud). To check the resources in use, open the [Quotas]({{ link-console-quotas }}) page and find **{{ mmg-name }}**.

You can add different types of hosts to a {{ mmg-name }} cluster. Their number depends on the [sharding type](../concepts/sharding.md#shard-management):

{#hosts-table}

| Sharding type | MONGOD | MONGOINFRA | MONGOS | MONGOCFG |
--- | --- | --- | --- | ---
| No sharding | ⩾ 1 | — | — | — |
| Standard | ⩾ 1 | ⩾ 3 | — | — |
| Advanced | ⩾ 1 | N/A | ⩾ 2 | ⩾ 3 |

{% list tabs %}

- Management console

   To add a host to your {{ mmg-name }} cluster:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
   1. Click the name of the {{ mmg-name }} cluster you need and go to the **Hosts** tab.
   1. Click **Add host**.
   1. Specify the host parameters:
      * [Availability zone](../../overview/concepts/geo-scope.md).
      * [Subnet](../../vpc/concepts/network.md#subnet) (if the required subnet is not on the list, create it).
      * Select **Public access** if the host must be accessible from outside {{ yandex-cloud }}.
      * Host type and shard name, if sharding is enabled for the {{ mmg-name }} cluster.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To add a host to your {{ mmg-name }} cluster:
   1. Request a list of {{ mmg-name }} cluster subnets to select a [subnet](../../vpc/concepts/network.md#subnet) for the new host:

      ```bash
      yc vpc subnet list
      ```

      Result:

      ```text
      +-----------+-----------+------------+-------------------+------------------+
      |     ID    |   NAME    | NETWORK ID |       ZONE        |      RANGE       |
      +-----------+-----------+------------+-------------------+------------------+
      | b0cl69... | default-c | enp6rq7... | {{ region-id }}-c | [172.16.0.0/20]  |
      | e2lkj9... | default-b | enp6rq7... | {{ region-id }}-b | [10.10.0.0/16]   |
      | e9b0ph... | a-2       | enp6rq7... | {{ region-id }}-a | [172.16.32.0/20] |
      | e9b9v2... | default-a | enp6rq7... | {{ region-id }}-a | [172.16.16.0/20] |
      +-----------+-----------+------------+-------------------+------------------+
      ```

      If the required subnet is not on the list, create it.
   1. View a description of the CLI command for adding a host:

      ```bash
      {{ yc-mdb-mg }} host add --help
      ```

   1. Run the add host command:

      ```bash
      {{ yc-mdb-mg }} host add \
        --cluster-name <cluster name> \
        --host zone-id=<availability zone>,subnet-id=<subnet ID>
      ```

      {{ mmg-name }} will run the add host operation.

      The subnet ID should be specified if the [availability zone](../../overview/concepts/geo-scope.md) contains multiple subnets; otherwise, {{ mmg-name }} automatically selects the sole subnet. You can get the {{ mmg-name }} cluster name with [a list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   To add a host to your {{ mmg-name }} cluster:
   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).
   1. Add the following to the {{ mmg-name }} cluster description:
      * Resources corresponding to the sharding type, if you are adding a host to a sharded cluster:
         * `resources_mongoinfra`: For standard sharding.
         * `resources_mongos` and `resources_mongocfg`: For advanced sharding.
      * The `host` section.

      ```hcl
      resource "yandex_mdb_mongodb_cluster" "<cluster name>" {
        ...
        resources_mongod {
          resource_preset_id = "<host class>"
          disk_type_id       = "<disk type>"
          disk_size          = <storage size, GB>
        }

        resources_mongoinfra { # Add this for standard sharding.
          resource_preset_id = "<host class>"
          disk_type_id       = "<disk type>"
          disk_size          = <storage size, GB>
        }

        resources_mongos { # Add this for advanced sharding.
          resource_preset_id = "<host class>"
          disk_type_id       = "<disk type>"
          disk_size          = <storage size, GB>
        }

        resources_mongocfg { # Add this for advanced sharding.
          resource_preset_id = "<host class>"
          disk_type_id       = "<disk type>"
          disk_size          = <storage size, GB>
        }

        host {
          role             = "<replica type: PRIMARY or SECONDARY>"
          zone_id          = "<availability zone>"
          subnet_id        = "<subnet in availability zone>"
          assign_public_ip = true / false
          shard_name       = "<shard name in sharded cluster>"
          type             = "<host type in sharded cluster: MONGOD, MONGOINFRA, MONGOS, or MONGOCFG>"
          ...
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_mongodb_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API

   To add a host to a cluster, use the [addHosts](../api-ref/Cluster/addHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/AddHosts](../api-ref/grpc/cluster_service.md#AddHosts) gRPC API call and provide the following in the request:
   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * New host settings in one or more `hostSpecs` parameters.

{% endlist %}


[Security groups](../../vpc/concepts/security-groups.md) are at the [Preview stage](../../overview/concepts/launch-stages.md). If they are not available on your [network](../../vpc/concepts/network.md#network), all incoming and outgoing traffic for the resources will be allowed. No additional setup is required.

To enable security groups, request access to this feature from the [support team]({{ link-console-support }}/create-ticket).

{% note warning %}

If you cannot [connect](connect/index.md) to the added host, check that the {{ mmg-name }} cluster's [security group](../concepts/network.md#security-groups) is configured correctly for the subnet where you placed the host. The security groups feature is currently in the [Preview](../../overview/concepts/launch-stages.md) stage.

{% endnote %}


## Removing a host {#remove-host}

You can remove a `MONGOD` host from a {{ mmg-name }} cluster if it is not the only host in it. To replace a single host, first create a new host and then remove the old one.

If the host is a primary one at the time of removal, {{ mmg-name }} automatically selects a new primary replica.

From a [sharded {{ mmg-name }} cluster](../operations/shards.md#enable), you may remove the `MONGOS`, `MONGOCFG`, or `MONGOINFRA` hosts that exceed the [minimum number](#hosts-table) needed for sharding.

{% list tabs %}

- Management console

   To remove a host from a {{ mmg-name }} cluster:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
   1. Click the name of the {{ mmg-name }} cluster you need and select the **Hosts** tab.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon in the same row as the desired host and select **Delete**.
   1. In the window that opens, check **Delete host** and click **Confirm**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To remove a host from the {{ mmg-name }} cluster, run:

   ```bash
   {{ yc-mdb-mg }} host delete <hostname>
        --cluster-name <cluster name>
   ```

   You can request the host name with a list of [{{ mmg-name }} cluster hosts](#list-hosts) and the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   To remove a host from a {{ mmg-name }} cluster:
   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).
   1. Delete the corresponding `host` block from the {{ mmg-name }} cluster description.
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Type `yes` and press **Enter**.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_mongodb_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API

   To delete a host, use the [deleteHosts](../api-ref/Cluster/deleteHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/DeleteHosts](../api-ref/grpc/cluster_service.md#DeleteHosts) gRPC API call and provide the following in the request:
   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Name(s) of the host(s) to delete in the `hostNames` parameter.

{% endlist %}

## Starting host resync {#resetup}

To [resync a host](https://docs.mongodb.com/manual/tutorial/resync-replica-set-member/) with other replicas in the {{ mmg-name }} cluster or shard, run forced resync. The operation can be applied to only one `MONGOD` host at a time and only for {{ mmg-name }} clusters with more than two replicas, regardless of the host class and type. Resync also lets you remove the collections and documents that were marked as deleted from the host's storage.

During this operation:
1. The host stops accepting write requests. If the host was a `PRIMARY` replica, {{ mmg-name }} will try to [make it a `SECONDARY` replica](https://docs.mongodb.com/manual/reference/method/rs.stepDown/#rs.stepDown). If the operation fails, it is aborted.
1. The {{ MG }} instance on the host stops, and all data is deleted.
1. The {{ MG }} instance restarts and downloads data from replica hosts again.
1. Once the host has synced with other replicas in the {{ mmg-name }} cluster, it becomes a secondary replica.

   {% note info %}

   * During syncing, the host can't fully respond to any request, because it has only part of the {{ mmg-name }} cluster data.
   * Estimated sync rate: 300 GB per day or more.

   {% endnote %}

{% list tabs %}

- Management console

   To forcibly resync a host:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
   1. Click the name of the {{ mmg-name }} cluster you need and select the **Hosts** tab.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon in the line of the necessary host and select **Resynchronize**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To forcibly resync a host, run the following command:

   ```bash
   {{ yc-mdb-mg }} hosts resetup <host_name>
      --cluster-name <cluster name>
   ```

   You can obtain the host name with a [list of hosts in the folder](hosts.md#list-hosts). You can get the {{ mmg-name }} cluster name with [a list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To resync a host, use the [resetupHosts](../api-ref/Cluster/resetupHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ResetupHosts](../api-ref/grpc/cluster_service.md#ResetupHosts) gRPC API call and provide the following in the request:
   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
   * Host name, in the `hostNames` parameter. To find out the name, [request a list of hosts in the cluster](#list-hosts).

{% endlist %}

## Restarting a host {#restart}

You can manually restart {{ mmg-name }} cluster hosts.

Restarting a host may make a {{ mmg-name }} cluster or [shard](../concepts/sharding.md) temporarily unavailable:
* If there is a single host in the cluster.
* If the host is the [primary replica](../concepts/replication.md).

When the primary replica is restarted, there is no automatic switch-over. To make sure the {{ mmg-name }} cluster remains available, [switch the cluster's primary replica](stepdown.md) before it is restarted.

{% note info %}

You can only restart one host at a time.

{% endnote %}

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To restart a host, run the command:

   ```bash
   {{ yc-mdb-mg }} hosts restart <hostname> \
     --cluster-name <cluster name>
   ```

- API

   To restart a host, use the [restartHosts](../api-ref/Cluster/restartHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/RestartHosts](../api-ref/grpc/cluster_service.md#RestartHosts) gRPC API call and provide the following in the request:
   * {{ mmg-name }} cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
   * Host name, in the `hostNames` parameter. To find out the name, [request a list of hosts in the cluster](#list-hosts).

{% endlist %}
