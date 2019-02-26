# Managing hosts in a cluster

You can add and remove cluster hosts and manage [!KEYREF MY] settings for individual clusters.

## Getting a list of cluster hosts {#list}

---

**[!TAB Management console]**

1. Go to the folder page and click **[!KEYREF mmy-name]**.
1. Click on the name of the cluster you need and select the **Hosts** tab.

---

## Adding a host  {#add}

The number of hosts in [!KEYREF mmy-short-name] clusters is limited by the quotas on CPUs and RAM available to the DB clusters in your cloud. To check the resources in use, open the [Quotas](https://console.cloud.yandex.ru/?section=quotas) page and find the **[!KEYREF mmy-full-name]**.

---

**[!TAB Management console]**

1. Go to the folder page and click **[!KEYREF mmy-name]**.

1. Click on the name of the cluster you need and go to the **Hosts** tab.

1. Click **Add host**.

1. Specify the host parameters:
   - Availability zone.
   - Subnet (if the necessary subnet is not in the list, [create it](../../vpc/operations/subnet-create.md)).
   - Priority of the host as a [!KEYREF MY] replica.
   - Replication source (if you use cascading replication).
   - Select the **Public access** option if the host must be accessible from outside the Cloud.

---

## Removing a host {#remove}

You can remove a host from a [!KEYREF MY] cluster if it is not the only host in it. To replace a single host, first create a new host and then delete the old one.

If the host is a master at the time of deletion, [!KEYREF mmy-short-name] automatically assigns the next highest-priority replica as a master.

---

**[!TAB Management console]**

1. Go to the folder page and click **[!KEYREF mmy-name]**.
1. Click on the name of the cluster you need and select the **Hosts** tab.
1. Click ![image](../../_assets/cross.svg) in the row of the host you need.

---

