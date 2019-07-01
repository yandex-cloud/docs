# Managing hosts in a cluster

You can add and remove cluster hosts and request a list of hosts in the selected cluster.

## Getting a list of cluster hosts {#list}

{% list tabs %}

- Management console

  1. Go to the folder page and click **{{ mrd-name }}**.

  2. Click on the name of the cluster you need and select the **Hosts** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of cluster databases, run the command:

  ```
  $ {{ yc-mdb-rd }} host list
       --cluster-name=<cluster name>

  +---------------------------------+----------------------+--------+---------------+
  |               NAME              |      CLUSTER ID      | HEALTH |    ZONE ID    |
  +---------------------------------+----------------------+--------+---------------+
  | rc1a-...caf.mdb.yandexcloud.net | c9qb2qj7nnt3b26fr0gg | ALIVE  | ru-central1-a |
  | rc1c-...bgc.mdb.yandexcloud.net | c9qb2qj7nnt3b26fr0gg | ALIVE  | ru-central1-c |
  +---------------------------------+----------------------+--------+---------------+
  ```

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

  To get a list of cluster hosts, use the [listHosts](../api-ref/Cluster/listHosts.md) method.

{% endlist %}

## Adding a host  {#add}

The number of hosts in {{ mrd-short-name }} clusters is limited by the quotas on the number of CPUs and the amount of RAM available to the DB clusters in your cloud. To check the resources in use, open the [Quotas]({{ link-console-quotas }}) page and find the **{{ mrd-full-name }}** service.

{% list tabs %}

- Management console

  1. Go to the folder page and click **{{ mrd-name }}**.

  1. Click on the name of the cluster you need and go to the **Hosts** tab.

  1. Click **Add host**.

  1. Specify the host parameters:

      * Availability zone.

      * Subnet (if the necessary subnet is not in the list, [create it](../../vpc/operations/subnet-create.md).

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

  1. See the description of the CLI command for adding a host:

     ```
     $ {{ yc-mdb-rd }} host add --help
     ```

  1. Run the add host command:

     ```
     $ {{ yc-mdb-rd }} host add
          --cluster-name <cluster name>
          --host zone-id=<availability zone>,subnet-id=<subnet ID>
     ```

     {{ mrd-short-name }} will run the add host operation.

     The subnet ID should be specified if the availability zone contains multiple subnets, otherwise {{ mrd-short-name }} automatically selects a single subnet. The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

  To add a host to the cluster, use the [addHosts](../api-ref/Cluster/addHosts.md) method.

{% endlist %}

## Removing a host {#remove}

You can remove a host from a {{ RD }} cluster if it is not the only host in it. To replace a single host, first create a new host and then delete the old one.

If the host is the master at the time of deletion, {{ mrd-short-name }} automatically assigns another replica as the master.

{% list tabs %}

- Management console

  1. Go to the folder page and click **{{ mrd-name }}**.

  2. Click on the name of the cluster you need and select the **Hosts** tab.

  3. Click ![image](../../_assets/cross.svg) in the row of the host you need.

  4. In the window that opens, check **Delete host** and click **Confirm**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To remove a host from the cluster, run:

  ```
  $ {{ yc-mdb-rd }} host delete <host name>
       --cluster-name=<cluster name>
  ```

  The name of the host can be requested with a [list of cluster hosts](#list-hosts), and the cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

  To remove a host, use the [deleteHosts](../api-ref/Cluster/deleteHosts.md) method.

{% endlist %}

