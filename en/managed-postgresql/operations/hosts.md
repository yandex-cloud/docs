# Managing hosts in a cluster

You can add and remove cluster hosts and manage [!KEYREF PG] settings for individual clusters.

## Getting a list of cluster hosts {#list}

---

**[!TAB Management console]**

1. Go to the folder page and click **[!KEYREF mpg-name]**.
1. Click on the name of the cluster you need and select the **Hosts** tab.

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

To get a list of cluster databases, run the command:

```
$ [!KEYREF yc-mdb-pg] host list
     --cluster-name=<cluster name>
     
+----------------------------+--------------+---------+--------+---------------+
|            NAME            |  CLUSTER ID  |  ROLE   | HEALTH |    ZONE ID    |
+----------------------------+--------------+---------+--------+---------------+
| rc1b...mdb.yandexcloud.net | c9qp71dk1... | MASTER  | ALIVE  | ru-central1-b |
| rc1c...mdb.yandexcloud.net | c9qp71dk1... | REPLICA | ALIVE  | ru-central1-c |
+----------------------------+--------------+---------+--------+---------------+
```

The cluster name can be requested with a [list of folder clusters](cluster-list.md#list-clusters).

**[!TAB API]**

To get a list of cluster hosts, use the [listHosts](../api-ref/Cluster/listHosts.md) method.

---

## Adding a host  {#add}

The number of hosts in [!KEYREF mpg-short-name] clusters is limited by the quotas on the number of CPUs and the amount of RAM available to the DB clusters in your cloud. To check the resources in use, open the [Quotas](https://console.cloud.yandex.ru/?section=quotas) page and find the **[!KEYREF mpg-full-name]**.

---

**[!TAB Management console]**

1. Go to the folder page and click **[!KEYREF mpg-name]**.

1. Click on the name of the cluster you need and go to the **Hosts** tab.

1. Click **Add host**.

1. Specify the host parameters:
   - Availability zone.
   - Subnet (if the necessary subnet is not in the list, [create it](../../vpc/operations/subnet-create.md)).
   - Priority of the host as a [!KEYREF PG] replica.
   - Replication source (if you use cascading replication).
   - Select the **Public access** option if the host must be accessible from outside the Cloud.

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

To add a host to the cluster:

1. See the description of the CLI command for adding a host:

   ```
   $ [!KEYREF yc-mdb-pg] host add --help
   ```

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

1. Run the add host command:

   ```
   $ [!KEYREF yc-mdb-pg] host add
        --cluster-name <cluster name>
        --host zone-id=<availability zone>,subnet-id=<subnet ID>
   ```

   [!KEYREF mpg-short-name] will run the add host operation.

   The subnet ID should be specified if the availability zone contains multiple subnets, otherwise [!KEYREF mpg-short-name] automatically selects a single subnet. The cluster name can be requested with a [list of folder clusters](cluster-list.md#list-clusters).

**[!TAB API]**

To add a host to the cluster, use the [addHosts](../api-ref/Cluster/addHosts.md) method.

---

## Changing a host {#update}

For each host in a [!KEYREF PG] cluster, you can change:

- The host's priority in the cluster, according to which a new master is selected when the old one is unavailable.
- The host that should be the replication source for the current host (if you use [cascading replication](https://www.postgresql.org/docs/10/warm-standby.html#CASCADING-REPLICATION)).

---

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

To change the parameters of the [!KEYREF PG] host, run the command:

```
$ [!KEYREF yc-mdb-pg] host update <hostname>
     --cluster-name <cluster name>
     --replication-source <source host's name>
     --priority <replica's priority>
```

The host names can be requested with a [list of cluster hosts](#list-hosts) and the cluster name can be requested with a [list of folder clusters](cluster-list.md#list-clusters).

**[!TAB API]**

To remove a host, use the [deleteHosts](../api-ref/Cluster/deleteHosts.md) method.

---

## Removing a host {#remove}

You can remove a host from a [!KEYREF PG] cluster if it is not the only host in it. To replace a single host, first create a new host and then delete the old one.

If the host is a master at the time of deletion, [!KEYREF mpg-short-name] automatically assigns the next highest-priority replica as a master.

---

**[!TAB Management console]**

1. Go to the folder page and click **[!KEYREF mpg-name]**.
1. Click on the name of the cluster you need and select the **Hosts** tab.
1. Click ![](../../_assets/vertical-ellipsis.svg) in the line of the necessary host and select **Delete**.

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

To remove a host from the cluster, run:

```
$ [!KEYREF yc-mdb-pg] host delete <hostname>
     --cluster-name=<cluster name>
```

The name of the host can be requested with a [list of cluster hosts](#list-hosts), and the cluster name can be requested with a [list of folder clusters](cluster-list.md#list-clusters).

**[!TAB API]**

To remove a host, use the [deleteHosts](../api-ref/Cluster/deleteHosts.md) method.

---

