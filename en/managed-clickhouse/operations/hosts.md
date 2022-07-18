# Managing hosts in a cluster


You can add and remove cluster hosts and manage {{ CH }} settings for individual clusters.

{% note warning %}

If you have created a cluster without [{{ CK }}](../concepts/replication.md#ck) support, then before adding new hosts to any of the [shards](../concepts/sharding.md), [enable fault tolerance](./zk-hosts.md#add-zk) using hosts {{ ZK }}.

{% endnote %}


## Getting a list of cluster hosts {#list-hosts}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mch-name }}**.
   1. Click on the name of the cluster you need and select the **Hosts** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of cluster hosts, run the command:

   ```bash
   {{ yc-mdb-ch }} host list\
      --cluster-name <cluster name>
   ```

   
   ```text
   +----------------------------+--------------+---------+--------+---------------+
   |            NAME            |  CLUSTER ID  |  ROLE   | HEALTH |    ZONE ID    |
   +----------------------------+--------------+---------+--------+---------------+
   | rc1b...{{ dns-zone }} | c9qp71dk1... | MASTER  | ALIVE  | {{ region-id }}-b |
   | rc1a...{{ dns-zone }} | c9qp71dk1... | REPLICA | ALIVE  | {{ region-id }}-a |
   +----------------------------+--------------+---------+--------+---------------+
   ```


   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   Use the [listHosts](../api-ref/Cluster/listHosts.md) API method and pass the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).

{% endlist %}


## Adding a host {#add-host}

The number of hosts in {{ mch-short-name }} clusters is limited by the CPU and RAM quotas available to DB clusters in your cloud. To check the resources in use, open the [Quotas]({{ link-console-quotas }}) page and find **Managed Databases**.

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mch-name }}**.
   1. Click on the name of the cluster you need and go to the **Hosts** tab.
   1. Click ![image](../../_assets/plus-sign.svg) **Add host**.

   
   1. Specify the host parameters:

      * Availability zone.
      * Subnet (if the required subnet is not on the list, [create it](../../vpc/operations/subnet-create.md)).
      * Select the **Public access** option if the host must be accessible from outside {{ yandex-cloud }}.
      * Name of the shard.
      * Select the **Copy data schema** option to copy the schema from a random replica to the new host.


- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To add a host to a cluster:

   
   1. Request a list of cluster subnets to select one for the new host:

      ```bash
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

      If the necessary subnet is not in the list, [create it](../../vpc/operations/subnet-create.md).


   1. View a description of the CLI command for adding a host:

      ```bash
      {{ yc-mdb-ch }} host add --help
      ```

   1. Run the add host command:

      
      ```bash
      {{ yc-mdb-ch }} host add \
         --cluster-name=<cluster name> \
         --host zone-id=<availability zone>,`
               `subnet-id=<subnet ID>,`
               `assign-public-ip=<public access to host: true or false>,`
               `shard-name=<shard name>,`
               `type=clickhouse
      ```


      To copy the data schema from a random replica to the new host, set the `--copy-schema` optional parameter.

      {{ mch-short-name }} will run the add host operation.

      
      The subnet ID should be specified if the availability zone contains multiple subnets, otherwise {{ mch-short-name }} automatically selects a single subnet. The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).


- Terraform

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Add a `host` block to the {{ mch-name }} cluster description.

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
        ...
        host {
          type             = "CLICKHOUSE"
          zone             = "<availability zone>"
          subnet_id        = "<subnet ID>"
          assign_public_ip = <public access to host: true or false>
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

   Use the [addHosts](../api-ref/Cluster/addHosts.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * New host settings in one or more `hostSpecs` parameters.

   To copy the data schema from a random replica to the new host, pass the `copySchema` parameter set to `true` in the request.

{% endlist %}

{% note warning %}

If you can't [connect](connect.md) to the added host, check that the cluster's [security group](../concepts/network.md#security-groups) is configured correctly for the subnet where you placed the host.

Use the copy data schema option only if the schema is the same on all replica hosts of the cluster.

{% endnote %}

## Changing a host {#update}

You can modify public access settings for every host in a {{ mch-short-name }} cluster.

{% list tabs %}

- Management console

   To change the parameters of the cluster host:

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mch-name }}**.
   1. Click on the name of the cluster you want and select the **Hosts** tab.
   1. Click the ![image](../../_assets/options.svg) icon in the same row as the desired host and select **Edit**.
   1. Enable **Public access** if a host must be accessible from outside {{ yandex-cloud }}.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the parameters of the host, run the command:

   ```bash
   {{ yc-mdb-ch }} host update <host name> \
      --cluster-name=<cluster name> \
      --assign-public-ip=<public access to host: true or false>
   ```

   The host name can be requested with a [list of cluster hosts](#list-hosts), and the cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).


- API

   To change the parameters of thehost, use the [updateHosts](../api-ref/Cluster/updateHosts.md) API method and pass the following in the query:

   1. In the `clusterId` parameter, the ID of the cluster where you want to change the host. To find out the cluster ID, get a [list of clusters in the folder](cluster-list.md#list-clusters).
   1. In the `updateHostSpecs.hostName` parameter, the name of the host you want to change. To find out the name, request a [list of hosts in the cluster](#list-hosts).
   1. Host public access settings as `updateHostSpecs.assignPublicIp`.
   1. A list of cluster configuration fields to modify (`assignPublicIp` in this case) as `updateMask`.

   {% include [Note warning update mask](../../_includes/mdb/note-api-updatemask.md) %}

{% endlist %}

{% note warning %}

If you can't [connect](connect.md) to the changed host, check that the cluster's [security group](../concepts/network.md#security-groups) is configured correctly for the subnet where you placed the host.

{% endnote %}

## Removing a host {#remove-host}

You can remove a host from a {{ CH }} cluster if it contains 3 or more hosts.

{% note info %}

A cluster created with [{{ CK }}](../concepts/replication.md#ck) replication support must include three or more hosts.

{% endnote %}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mch-name }}**.
   1. Click on the name of the cluster you want and select the **Hosts** tab.
   1. Click the ![image](../../_assets/options.svg) icon in the same row as the desired host and select **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To remove a host from the cluster, run:

   ```bash
   {{ yc-mdb-ch }} host delete <hostname>
      --cluster-name <cluster name>
   ```

   The host name can be requested with a [list of cluster hosts](#list-hosts), and the cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- Terraform

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. In the {{ mch-name }} cluster description, remove the `CLICKHOUSE` type `host` block.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the deletion of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

   Use the [deleteHosts](../api-ref/Cluster/deleteHosts.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * The name(s) of the host(s) to delete, in the `hostNames` parameter.

{% endlist %}
