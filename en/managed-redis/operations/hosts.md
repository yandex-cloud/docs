# Managing hosts in a cluster

You can add and remove cluster hosts and request a list of hosts in the selected cluster.

## Getting a list of cluster hosts {#list}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder containing the cluster to get a list of hosts for.
   1. Select **{{ mrd-name }}**.
   1. Click on the name of the cluster you need and select the **Hosts** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of databases in a cluster, run the command:

   ```
   {{ yc-mdb-rd }} host list
   --cluster-name <cluster name>
   ```

   Result:

   ```
   +---------------------------------+--------------+------------+---------+--------+---------------+
   |              NAME               |  CLUSTER ID  | SHARD NAME |  ROLE   | HEALTH |    ZONE ID    |
   +---------------------------------+--------------+------------+---------+--------+---------------+
   | rc1a-...caf.{{ dns-zone }} | c9qb2...0gg  | shard1     | MASTER  | ALIVE  | ru-central1-a |
   | rc1c-...bgc.{{ dns-zone }} | c9qb2...0gg  | shard1     | REPLICA | ALIVE  | ru-central1-c |
   +---------------------------------+--------------+------------+---------+--------+---------------+
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).


- API

   To get a list of cluster hosts, use the [listHosts](../api-ref/Cluster/listHosts.md) method.

{% endlist %}


## Adding a host {#add}

The number of hosts in {{ mrd-short-name }} clusters is limited by the CPU and RAM quotas available to DB clusters in your cloud. To check the resources in use, open the [Quotas]({{ link-console-quotas }}) page and find **{{ mrd-full-name }}**.

{% list tabs %}

- Management console

   To add a host to the cluster:

   1. In the [management console]({{ link-console-main }}), go to the folder with the cluster to add a host to.
   1. Select **{{ mrd-name }}**.
   1. Click on the name of the cluster you need and go to the **Hosts** tab.
   1. Click **Add host**.

   1. Specify the host parameters:

      * Availability zone.
         {% if audience != "internal" %}

      * Subnet (if the necessary subnet is not in the list, [create it](../../vpc/operations/subnet-create.md)).

      {% else %}

      * Subnet (if the required subnet is not on the list, create it).

      {% endif %}

      * If you add a host to a sharded cluster, select a shard.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To add a host to the cluster:

   1. Request a list of cluster subnets to select one for the new host:

      ```
      yc vpc subnet list
      ```

      Result:

      ```
      +-----------+-----------+------------+---------------+------------------+
      |     ID    |   NAME    | NETWORK ID |     ZONE      |      RANGE       |
      +-----------+-----------+------------+---------------+------------------+
      | b0cl69... | default-c | enp6rq7... | ru-central1-c | [172.16.0.0/20]  |
      | e2lkj9... | default-b | enp6rq7... | ru-central1-b | [10.10.0.0/16]   |
      | e9b0ph... | a-2       | enp6rq7... | ru-central1-a | [172.16.32.0/20] |
      | e9b9v2... | default-a | enp6rq7... | ru-central1-a | [172.16.16.0/20] |
      +-----------+-----------+------------+---------------+------------------+
      ```

      {% if audience != "internal" %}

      If the necessary subnet is not in the list, [create it](../../vpc/operations/subnet-create.md).

      {% else %}

      If the required subnet is not on the list, create it.

      {% endif %}


   1. View a description of the CLI command for adding a host:

      ```
      {{ yc-mdb-rd }} host add --help
      ```

   1. Run the add host command:

      ```
      {{ yc-mdb-rd }} host add
        --cluster-name <cluster name>
        --host zone-id=<availability zone>,subnet-id=<subnet ID>
      ```

      {{ mrd-short-name }} will run the add host operation.

      The subnet ID should be specified if the availability zone contains multiple subnets, otherwise {{ mrd-short-name }} automatically selects a single subnet. The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

      If you add a host to a sharded cluster, specify in the `shard-name` parameter the name of the shard to add the host to.

- {{ TF }}

   To add a host to the cluster:

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Add a `host` block to the {{ mrd-name }} cluster description.

      ```hcl
      resource "yandex_mdb_redis_cluster" "<cluster name>" {
        ...
        host {
          zone      = "<availability zone>"
          subnet_id = <subnet ID>
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

   To add a host to the cluster, use the [addHosts](../api-ref/Cluster/addHosts.md) method.

{% endlist %}

{% note warning %}

If you can't [connect](./connect/index.md) to the added host, check that the cluster's [security group](../concepts/network.md#security-groups) is configured correctly for the subnet where you placed the host.

{% endnote %}

## Removing a host {#remove}

You can remove a host from a {{ RD }} cluster if it is not the only host in it. To replace a single host, first create a new host and then remove the old one.

If the host is the master when deleted, {{ mrd-short-name }} automatically assigns another replica as the master.

{% list tabs %}

- Management console

   To remove a host from a cluster:

   1. In the [management console]({{ link-console-main }}), go to the folder with the cluster to remove a host from.
   1. Select **{{ mrd-name }}**.
   1. Click on the name of the cluster you want and select the **Hosts** tab.
   1. In the line of the appropriate cluster, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Delete**.
   1. In the window that opens, check **Delete host** and click **Confirm**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To remove a host from the cluster, run:

   ```
   {{ yc-mdb-rd }} host delete <hostname>
     --cluster-name=<cluster name>
   ```

   The host name can be requested with a [list of cluster hosts](#list), and the cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- Terraform

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

   To remove a host, use the [deleteHosts](../api-ref/Cluster/deleteHosts.md) method.

{% endlist %}
