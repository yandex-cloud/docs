# Managing hosts in a cluster

You can add and remove cluster hosts and manage {{ CH }} settings for individual clusters.

{% note warning %}

To add new hosts to any of the [shards](../concepts/sharding.md) in a cluster, first [add {{ ZK }} hosts](zk-hosts.md) that will ensure fault tolerance of the cluster.

{% endnote %}


## Getting a list of cluster hosts {#list-hosts}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mch-name }}**.

  1. Click on the name of the cluster you need and select the **Hosts** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of cluster hosts, run the command:

  ```
  $ {{ yc-mdb-ch }} host list
       --cluster-name=<cluster name>
  
  +----------------------------+--------------+---------+--------+---------------+
  |            NAME            |  CLUSTER ID  |  ROLE   | HEALTH |    ZONE ID    |
  +----------------------------+--------------+---------+--------+---------------+
  | rc1b...mdb.yandexcloud.net | c9qp71dk1... | MASTER  | ALIVE  | ru-central1-b |
  | rc1c...mdb.yandexcloud.net | c9qp71dk1... | REPLICA | ALIVE  | ru-central1-c |
  +----------------------------+--------------+---------+--------+---------------+
  ```

  You can query the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).


- API

  To get a list of cluster hosts, use the [listHosts](../api-ref/Cluster/listHosts.md) method.

{% endlist %}


## Adding a host {#add-host}

The number of hosts in {{ mch-short-name }} clusters is limited by the CPU and RAM quotas available to DB clusters in your cloud. To check the resources in use, open the [Quotas]({{ link-console-quotas }}) page and find the **{{ mch-full-name }}** block.

{% list tabs %}

- Management console

  1. Go to the folder page and click **{{ mch-name }}**.
  1. Click on the name of the cluster you need and go to the **Hosts** tab.
  1. Click **Add host**.

  {% if audience != "internal" %}

  1. Specify the host parameters:

      * Availability zone.
      * Subnet (if the necessary subnet is not in the list, [create it](../../vpc/operations/subnet-create.md)).
      * Select the **Public access** option if the host must be accessible from outside {{ yandex-cloud }}.
      * Select the **Copy data schema** option to copy the schema from a random replica to the new host.

  {% endif %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To add a host to the cluster:

  {% if audience != "internal" %}

  1. Request a list of cluster subnets to select one for the new host:

      ```
      $ yc vpc subnet list
      
      +-----------+-----------+------------+---------------+------------------+
      |     ID    |   NAME    | NETWORK ID |     ZONE      |      RANGE       |
      +-----------+-----------+------------+---------------+------------------+
      | b0cl69... | default-c | enp6rq7... | ru-central1-c | [172.16.0.0/20]  |
      | e2lkj9... | default-b | enp6rq7... | ru-central1-b | [10.10.0.0/16]   |
      | e9b0ph... | a-2       | enp6rq7... | ru-central1-a | [172.16.32.0/20] |
      | e9b9v2... | default-a | enp6rq7... | ru-central1-a | [172.16.16.0/20] |
      +-----------+-----------+------------+---------------+------------------+
      ```

      If the necessary subnet is not in the list, [create it](../../vpc/operations/subnet-create.md).

  {% endif %}

  1. View a description of the CLI command for adding a host:

     ```
     $ {{ yc-mdb-ch }} host add --help
     ```

  1. Run the add host command:

     {% if audience != "internal" %}

     ```bash
     {{ yc-mdb-ch }} host add \
        --cluster-name <cluster name> \
        --host zone-id=<availability zone>,subnet-id=<subnet ID>,assign-public-ip=<public IP>,shard-name=<shard name>
     ```

     {% else %}

     ```bash
     {{ yc-mdb-ch }} host add \
        --cluster-name <cluster name> \
        --host zone-id=<availability zone>,subnet-id=<subnet ID>,shard-name=<shard name> \
     ```

     {% endif %}

     To copy the data schema from a random replica to the new host, set the `--copy-schema` optional parameter.

     {{ mch-short-name }} will run the add host operation.

     {% if audience != "internal" %}

     The subnet ID should be specified if the availability zone contains multiple subnets, otherwise {{ mch-short-name }} automatically selects a single subnet. You can retrieve the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

     {% else %}

     You can query the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

     {% endif %}

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. Add a `host` block to the {{ mch-name }} cluster description.

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
          ...
          host {
            type = "CLICKHOUSE"
            zone = "<availability zone>"
            ...
          }
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

- API

  To add a host to the cluster, use the [addHosts](../api-ref/Cluster/addHosts.md) method.

  To copy the data schema from a random replica to the new host, pass the `copySchema` parameter set to `true` in the request.

{% endlist %}

{% note warning %}

If you can't [connect](connect.md) to the added host, check that the cluster's [security group](../concepts/network.md#security-groups) is configured correctly for the subnet where you placed the host.

Use the copy data schema option only if the schema is the same on all replica hosts of the cluster.

{% endnote %}

## Removing a host {#remove-host}

You can remove a host from a {{ CH }} cluster if it contains 3 or more hosts.

{% list tabs %}

- Management console

  1. Go to the folder page and click **{{ mch-name }}**.

  1. Click on the name of the cluster you want and select the **Hosts** tab.

  1. Click ![image](../../_assets/vertical-ellipsis.svg) in the line of the necessary host and select **Delete**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To remove a host from the cluster, run:

  ```
  $ {{ yc-mdb-ch }} host delete <host name>
       --cluster-name=<cluster name>
  ```

  The host name can be requested with a [list of cluster hosts](#list-hosts), and the cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. In the {{ mch-name }} cluster description, remove the `CLICKHOUSE` type `host` block.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the deletion of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

- API

  To remove a host, use the [deleteHosts](../api-ref/Cluster/deleteHosts.md) method.

{% endlist %}
