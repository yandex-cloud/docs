# Managing hosts in a cluster

You can add and remove cluster hosts, resync the hosts, and [manage settings {{ MG }}](update.md) for individual clusters.

## Getting a list of cluster hosts {#list-hosts}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
   1. Click on the name of the desired cluster.
   1. Go to the **Hosts** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of cluster hosts, run the command:

   ```
   {{ yc-mdb-mg }} host list
    --cluster-name <cluster name>
   ```

   
   ```text
   +----------------------------+--------------+--------+------------+--------------+----------+---------------+-----------+
   |            NAME            |  CLUSTER ID  |  TYPE  | SHARD NAME |     ROLE     |  HEALTH  |    ZONE ID    | PUBLIC IP |
   +----------------------------+--------------+--------+------------+--------------+----------+---------------+-----------+
   | rc1b...{{ dns-zone }} | c9qp71dk1... | MONGOD | rs01       | PRIMARY      | ALIVE    | {{ region-id }}-b | false     |
   | rc1a...{{ dns-zone }} | c9qp71dk1... | MONGOD | rs01       | SECONDARY    | ALIVE    | {{ region-id }}-a | false     |
   +----------------------------+--------------+--------+------------+--------------+----------+---------------+-----------+
   ```


   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).


- API

   To get a list of cluster hosts, use the [listHosts](../api-ref/Cluster/listHosts.md) method.

{% endlist %}


## Adding a host {#add-host}

The number of hosts in {{ mmg-short-name }} clusters is limited by the CPU and RAM quotas available to DB clusters in your cloud. To check the resources in use, open the [Quotas]({{ link-console-quotas }}) page and find **{{ mmg-full-name }}**.

You can add different types of hosts to a cluster. Their number depends on the [sharding type](../concepts/sharding.md):

{#hosts-table}

| Sharding type | MONGOD | MONGOINFRA | MONGOS | MONGOCFG |
| ---------------- | ---------- | ---------- | ---------- | ---------- |
| No sharding | ⩾ 1 | — | — | — |
| Standard | ⩾ 1 | ⩾ 3 | — | — |
| Advanced | ⩾ 1 | — | ⩾ 2 | ⩾ 3 |

{% list tabs %}

- Management console

   To add a host to the cluster:

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.

   1. Click on the name of the cluster you need and go to the **Hosts** tab.

   1. Click **Add host**.

   1. Specify the host parameters:

      * Availability zone.
      * Subnet (if the required subnet is not on the list, create it).
      * Select the **Public access** option if the host must be accessible from outside {{ yandex-cloud }}.
      * Host type and shard name, if [sharding](../concepts/sharding.md) is enabled for the cluster.

   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To add a host to the cluster:

   1. Request a list of cluster subnets to select one for the new host:

      ```
      yc vpc subnet list

      +-----------+-----------+------------+---------------+------------------+
      |     ID    |   NAME    | NETWORK ID |     ZONE      |      RANGE       |
      +-----------+-----------+------------+---------------+------------------+
      | b0cl69... | default-c | enp6rq7... | {{ region-id }}-c | [172.16.0.0/20]  |
      | e2lkj9... | default-b | enp6rq7... | {{ region-id }}-b | [10.10.0.0/16]   |
      | e9b0ph... | a-2       | enp6rq7... | {{ region-id }}-a | [172.16.32.0/20] |
      | e9b9v2... | default-a | enp6rq7... | {{ region-id }}-a | [172.16.16.0/20] |
      +-----------+-----------+------------+---------------+------------------+
      ```

      If the necessary subnet is not in the list, create it.

   1. View a description of the CLI command for adding a host:

      ```
      {{ yc-mdb-mg }} host add --help
      ```

   1. Run the add host command:

      ```
      {{ yc-mdb-mg }} host add
        --cluster-name <cluster name>
        --host zone-id=<availability zone>,subnet-id=<subnet ID>
      ```

      {{ mmg-short-name }} will run the add host operation.

      The subnet ID should be specified if the availability zone contains multiple subnets, otherwise {{ mmg-short-name }} automatically selects a single subnet. The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   To add a host to the cluster:

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Add a `host` block to the {{ mmg-name }} cluster description.

      ```hcl
      resource "yandex_mdb_mongodb_cluster" "<cluster name>" {
        ...
        host {
          role             = "<replica type: PRIMARY or SECONDARY>"
          zone_id          = "<availability zone>"
          subnet_id        = "<subnet in availability zone>"
          assign_public_ip = true / false
          shard_name       = "<shard name in sharded cluster>"
          type             = "<host type in sharded cluter: MONGOD, MONGOS, or MONGOCFG>"
          ...
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_mongodb_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API

   To add a host to the cluster, use the [addHosts](../api-ref/Cluster/addHosts.md) method.

{% endlist %}

{% note warning %}

If you can't [connect](connect/index.md) to the added host, check that the cluster's [security group](../concepts/network.md#security-groups) is configured correctly for the subnet where you placed the host.

{% endnote %}

## Removing a host {#remove-host}

You can remove a `MONGOD` host from a {{ MG }} cluster if it is not the only host in it. To replace a single host, first create a new host and then remove the old one.

If the host is a primary one at the time of removal, {{ mmg-short-name }} automatically selects a new primary replica.

From a [sharded cluster](../operations/shards.md#enable), you may remove the `MONGOS`, `MONGOCFG`, or `MONGOINFRA` hosts that exceed the [minimum number](#hosts-table) needed for sharding.

{% list tabs %}

- Management console

   To remove a host from a cluster:

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
   1. Click on the name of the cluster you want and select the **Hosts** tab.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon in the same row as the desired host and select **Delete**.
   1. In the window that opens, check **Delete host** and click **Confirm**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To remove a host from the cluster, run:

   ```
   {{ yc-mdb-mg }} host delete <hostname>
     --cluster-name=<cluster name>
   ```

   The host name can be requested with a [list of cluster hosts](#list-hosts), and the cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   To remove a host from a cluster:

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Delete the corresponding `host` block from the {{ mmg-name }} cluster description.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the deletion of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_mongodb_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API

   To remove a host, use the [deleteHosts](../api-ref/Cluster/deleteHosts.md) method.

{% endlist %}

## Starting host resync {#resetup}

To [resync a host](https://docs.mongodb.com/manual/tutorial/resync-replica-set-member/) with other replicas in the {{ mmg-name }} cluster or shard, run forced resync. The operation can be applied to only one `MONGOD` host at a time and only for clusters with more than two replicas, regardless of the host class and type. Resync also lets you remove the collections and documents that were marked as deleted from the host's storage.

During this operation:

1. The host stops accepting write requests. If the host was a `PRIMARY` replica, {{ mmg-short-name }} will try to make it a `SECONDARY` [replica](https://docs.mongodb.com/manual/reference/method/rs.stepDown/#rs.stepDown). If the operation fails, it is aborted.

1. The MongoDB instance on the host stops and all data is deleted.

1. The MongoDB instance restarts and downloads data from replica hosts again.

1. After the host has synced with other replicas in the cluster, it becomes a secondary replica.

   {% note info %}

   * During syncing, the host can't fully respond to any request, because it has only part of the {{ mmg-name }} cluster data.
   * Estimated sync rate: 300 GB per day or more.

   {% endnote %}

{% list tabs %}

- Management console

   To forcibly resync a host:

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.

   1. Click on the name of the cluster you want and select the **Hosts** tab.

   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon in the line of the necessary host and select **Resynchronize**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To forcibly resync a host, run the following command:

   ```
   {{ yc-mdb-mg }} hosts resetup <host_name>
     --cluster-name <cluster name>
   ```

   You can obtain the host name with a [list of hosts in the folder](hosts.md#list-hosts). The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Restarting a host {#restart}

You can manually restart {{ mmg-short-name }} cluster hosts.

Restarting a host may make a cluster or [shard](../concepts/sharding.md) temporarily unavailable:

* If there is a single host in the cluster.
* If the host is the [primary replica](../concepts/replication.md).

When the primary replica is restarted, there is no automatic switch-over. To make sure the cluster remains available, [switch the cluster's primary replica](./stepdown.md) before it is restarted.

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

   Use the [restartHosts](../api-ref/Cluster/restartHosts.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md).
   * Host name, in the `hostNames` parameter. To find out the name, [request a list of hosts in the cluster](#list-hosts).

{% endlist %}
