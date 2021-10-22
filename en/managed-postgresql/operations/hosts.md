# Managing hosts in a cluster

You can add and remove cluster hosts and manage {{ PG }} settings for individual clusters.

## Getting a list of cluster hosts {#list}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mpg-name }}**.

  1. Click on the name of the cluster you need and select the **Hosts** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of databases in a cluster, run the command:

  ```
  $ {{ yc-mdb-pg }} host list
       --cluster-name <cluster name>
  
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

## Adding a host {#add}

The number of hosts in {{ mpg-short-name }} clusters is limited by the CPU and RAM quotas available to DB clusters in your cloud. To check the resources in use, open the [Quotas]({{ link-console-quotas }}) page and find the **{{ mpg-full-name }}** block.

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mpg-name }}**.
  1. Click on the name of the cluster you need and go to the **Hosts** tab.
  1. Click **Add host**.

    1. Specify the host parameters:
     - Availability zone.

     - Subnet (if the necessary subnet is not in the list, [create it](../../vpc/operations/subnet-create.md).

     - Priority of the host as a {{ PG }} replica.

       Change the priority value to modify the selection of the [synchronous replica](../concepts/replication.md#selecting-the-master-and-a-synchronous-replica) in the cluster:
       - The host with the highest priority in the cluster becomes a synchronous replica.
       - If the cluster has multiple hosts with the highest priority, a synchronous replica is selected among them.
       - The lowest priority is `0` (default), the highest is `100`.

     - Replication source (if you use [cascading replication](../concepts/replication.md#replication-manual)).

     - Select the **Public access** option if the host must be accessible from outside {{ yandex-cloud }}.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To add a host to the cluster:

  
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

  1. View a description of the CLI command for adding a host:

     ```
     $ {{ yc-mdb-pg }} host add --help
     ```

  1. Run the add host command:

     
     ```
     $ {{ yc-mdb-pg }} host add
          --cluster-name <cluster name>
          --host zone-id=<availability zone>,subnet-id=<subnet ID>
     ```

     
     The subnet ID should be specified if the availability zone contains multiple subnets, otherwise {{ mpg-short-name }} automatically selects a single subnet. You can retrieve the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

     You can also specify some additional options in the `--host` parameter to manage replication in the cluster:
      - Replication source for the host in the `replication-source` option to [manually manage replication threads](../concepts/replication.md#replication-manual).
      - Host priority in the `priority` option to [modify the selection of a synchronous replica](../concepts/replication.md#selecting-the-master-and-a-synchronous-replica):
        - The host with the highest priority in the cluster becomes a synchronous replica.
        - If the cluster has multiple hosts with the highest priority, a synchronous replica is selected among them.
        - The lowest priority is `0` (default), the highest is `100`.

   {{ mpg-short-name }} will run the add host operation.

- API

  To add a host to the cluster, use the [addHosts](../api-ref/Cluster/addHosts.md) method.

{% endlist %}

{% note warning %}

If you can't [connect](connect.md) to the added host, check that the cluster's [security group](../concepts/network.md#security-groups) is configured correctly for the subnet where you placed the host.

{% endnote %}

## Changing a host {#update}

For each host in a {{ PG }} cluster, you can change the host priority and specify the replication source. For more information, see [{#T}](../concepts/replication.md).

{% list tabs %}

- Management console

  To change the parameters of the {{ PG }} host:
  1. Go to the folder page and select **{{ mpg-name }}**.
  1. Click on the name of the cluster you want and select the **Hosts** tab.
  1. Click ![image](../../_assets/pencil.svg).
  1. Set new settings for the host:
     1. Set the priority to modify the selection of the [synchronous replica](../concepts/replication.md#selecting-the-master-and-a-synchronous-replica) in the cluster:
       - The host with the highest priority in the cluster becomes a synchronous replica.
       - If the cluster has multiple hosts with the highest priority, a synchronous replica is selected among them.
       - The lowest priority is `0` (default), the highest is `100`.
     1. Select the replication source for the host to [manually manage replication threads](../concepts/replication.md#replication-manual).
  1. Click **Save**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the parameters of the {{ PG }} host, run the command:

  ```
  $ {{ yc-mdb-pg }} host update <host name>
       --cluster-name <cluster name>
       --replication-source <source host's name
       --priority <replica's priority
  ```

  The host name can be requested with a [list of cluster hosts](#list), and the cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

  To manage replication in the cluster, change in the `--host` parameter:
  - Replication source for the host in the `replication-source` option to [manually manage replication threads](../concepts/replication.md#replication-manual).
  - Host priority in the `priority` option to [modify the selection of a synchronous replica](../concepts/replication.md#selecting-the-master-and-a-synchronous-replica):
       - The host with the highest priority in the cluster becomes a synchronous replica.
       - If the cluster has multiple hosts with the highest priority, a synchronous replica is selected among them.
       - The lowest priority is `0` (default), the highest is `100`.

- API

  To change the parameters of the {{ PG }} host, use the [updateHosts](../api-ref/Cluster/updateHosts.md) API method and pass the following in the query:
  1. In the `clusterId` parameter, the ID of the cluster where you want to change the host.
  1. In the `updateHostSpecs.hostName` parameter, the name of the host you want to change.

  The host name can be requested with a [list of cluster hosts](#list), and the cluster ID can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

{% note warning %}

If you can't [connect](connect.md) to the changed host, check that the cluster's [security group](../concepts/network.md#security-groups) is configured correctly for the subnet where you placed the host.

{% endnote %}

## Removing a host {#remove}

You can remove a host from a {{ PG }} cluster if it is not the only host in it. To replace a single host, first create a new host and then remove the old one.

If the host is the master when deleted, {{ mpg-short-name }} automatically assigns the next highest-priority replica as the master.

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mpg-name }}**.

  1. Click on the name of the cluster you want and select the **Hosts** tab.

  1. Click ![image](../../_assets/vertical-ellipsis.svg) in the line of the necessary host and select **Delete**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To remove a host from the cluster, run:

  ```
  $ {{ yc-mdb-pg }} host delete <host name>
       --cluster-name <cluster name>
  ```

  The host name can be requested with a [list of cluster hosts](#list), and the cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

  To remove a host, use the [deleteHosts](../api-ref/Cluster/deleteHosts.md) method.

{% endlist %}

