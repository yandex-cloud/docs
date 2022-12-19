# Managing {{ RD }} cluster hosts

You can add and remove cluster hosts and manage their settings.

## Getting a list of cluster hosts {#list}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mrd-name }}**.
   1. Click on the name of the cluster you need and select the **Hosts** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of cluster hosts, run the command:

   ```bash
   {{ yc-mdb-rd }} host list\
      --cluster-name <cluster name>
   ```

   
   ```text
   +---------------------------------+--------------+------------+---------+--------+---------------+
   |              NAME               |  CLUSTER ID  | SHARD NAME |  ROLE   | HEALTH |    ZONE ID    |
   +---------------------------------+--------------+------------+---------+--------+---------------+
   | rc1a-...caf.{{ dns-zone }} | c9qb2...0gg  | shard1     | MASTER  | ALIVE  | {{ region-id }}-a |
   | rc1b-...bgc.{{ dns-zone }} | c9qb2...0gg  | shard1     | REPLICA | ALIVE  | {{ region-id }}-b |
   +---------------------------------+--------------+------------+---------+--------+---------------+
   ```


   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   Use the [listHosts](../api-ref/Cluster/listHosts.md) API method and pass the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).

{% endlist %}

## Adding a host {#add}

The number of hosts in {{ mrd-short-name }} clusters is limited by the CPU and RAM quotas available to DB clusters in your cloud. To check the resources in use, open the [Quotas]({{ link-console-quotas }}) page and find **Managed Databases**.

{% note info %}

Public access to hosts can only be configured for clusters created with enabled TLS support.

{% endnote %}

{% list tabs %}

- Management console

   To add a host to the cluster:

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mrd-name }}**.
   1. Click on the name of the cluster you need and go to the **Hosts** tab.
   1. Click ![image](../../_assets/plus-sign.svg) **Add host**.

   1. Specify the host parameters:

      * Availability zone.
         
      * Subnet (if the required subnet is not on the list, [create it](../../vpc/operations/subnet-create.md)).


      * If necessary, configure public access to hosts.
      * If you add a host to a sharded cluster, select a shard.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To add a host to the cluster:

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

      
      If the necessary subnet is not in the list, [create it](../../vpc/operations/subnet-create.md).


   1. View a description of the CLI command for adding a host:

      ```bash
      {{ yc-mdb-rd }} host add --help
      ```

   1. Run the add host command:

      ```bash
      {{ yc-mdb-rd }} host add \
         --cluster-name=<cluster name> \
         --host zone-id=<availability zone>,`
               `subnet-id=<subnet ID>,`
               `assign-public-ip=<public host access: true or false>,`
               `replica-priority=<host priority>,`
               `shard-name=<shard name>
      ```

      Where:

      * `--cluster-name` is the name of a {{ mrd-name }} cluster. You can retrieve it with a [list of clusters in a folder](cluster-list.md#list-clusters).
      * `--host`: Host parameters:
         * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
         * `subnet-id`: [Subnet ID](../../vpc/concepts/network.md#subnet). It must be specified if the selected availability zone includes two or more subnets.
         * `assign-public-ip` indicates whether the host is reachable from the internet over a public IP address.
         * `replica-priority`: Priority for selecting the host as a master if the [primary master fails](../concepts/replication.md#master-failover). Only available for unsharded clusters.
         * `shard-name`: Name of the shard to which the host must be added if the cluster is sharded.

- {{ TF }}

   To add a host to the cluster:

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Add a `host` block to the {{ mrd-name }} cluster description.

      ```hcl
      resource "yandex_mdb_redis_cluster" "<cluster name>" {
        ...
        host {
          zone             = "<availability zone>"
          subnet_id        = "<subnet ID>"
          assign_public_ip = <public host access: true or false>
          replica_priority = <host priority>
          shard_name       = "<shard name>"
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mrd }}).

   {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API

   Use the [addHosts](../api-ref/Cluster/addHosts.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * New host settings in one or more `hostSpecs` parameters.

{% endlist %}


{% note warning %}

If you can't [connect](connect/index.md) to the added host, check that the cluster's [security group](../concepts/network.md#security-groups) is configured correctly for the subnet where you placed the host.

{% endnote %}


## Changing a host {#update}

{% include [mrd-public-access](../../_includes/mdb/mrd/note-public-access.md) %}

{% list tabs %}

- Management console

   To change the parameters of the cluster host:

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mrd-name }}**.
   1. Click on the name of the cluster you want and select the **Hosts** tab.
   1. Click the ![image](../../_assets/options.svg) icon in the same row as the desired host and select **Edit**.
   1. Enable **Public access** if a host must be accessible from outside {{ yandex-cloud }}.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the parameters of the host, run the command:

   ```bash
   {{ yc-mdb-rd }} host update <host name> \
      --cluster-name=<cluster name> \
      --assign-public-ip=<public host access: true or false> \
      --replica-priority=<host priority>
   ```

   The host name can be requested with a [list of cluster hosts](#list), and the cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   To change the parameters of the cluster host:

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. In the {{ mrd-name }} cluster description, change the attributes of the `host` block corresponding to the host to update.

      ```hcl
      resource "yandex_mdb_redis_cluster" "<cluster name>" {
        ...
        host {
          zone             = "<availability zone>"
          subnet_id        = "<subnet ID>"
          assign_public_ip = <public host access: true or false>
          replica_priority = <host priority>
          shard_name       = "<shard name>"
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mrd }}).

- API

   To change the parameters of the host, use the [updateHosts](../api-ref/Cluster/updateHosts.md) API method and pass the following in the query:

   - In the `clusterId` parameter, the ID of the cluster where you want to change the host. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   - In the `updateHostSpecs.hostName` parameter, the name of the host you want to change. To find out the name, [request a list of hosts in the cluster](#list).
   - Host public access settings as `updateHostSpecs.assignPublicIp`.
   - [Host priority](../concepts/replication.md#master-failover) in the `updateHostSpecs.replicaPriority` parameter.
   - List of cluster configuration fields to update in the `UpdateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}


{% note warning %}

If you can't [connect](connect/index.md) to the added host, check that the cluster's [security group](../concepts/network.md#security-groups) is configured correctly for the subnet where you placed the host.

{% endnote %}


## Removing a host {#remove}

You can remove a host from a {{ RD }} cluster if it is not the only host in it. To replace a single host, first create a new host and then remove the old one.

If the host is the master when deleted, {{ mrd-short-name }} automatically assigns another replica as the master.

{% list tabs %}

- Management console

   To remove a host from a cluster:

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mrd-name }}**.
   1. Click on the name of the cluster you want and select the **Hosts** tab.
   1. In the row next to the appropriate cluster, click ![image](../../_assets/options.svg) and select **Delete**.
   1. In the window that opens, check **Delete host** and click **Confirm**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To remove a host from the cluster, run:

   ```bash
   {{ yc-mdb-rd }} host delete <hostname> \
      --cluster-name=<cluster name>
   ```

   The host name can be requested with a [list of cluster hosts](#list), and the cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   To remove a host from a cluster:

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Delete the `host` block from the {{ mrd-name }} cluster description.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the deletion of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mrd }}).

   {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API

   Use the [deleteHosts](../api-ref/Cluster/deleteHosts.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * The name(s) of the host(s) to delete, in the `hostNames` parameter.

{% endlist %}
