
#### Can I manage a cluster using SQL commands? {#sql-control}

There are some restrictions on cluster management using SQL commands. For more information, see [{#T}](../../managed-mysql/concepts/sql-limits.md).

#### How do I reduce the size of a disk? {#reduce-size}

You cannot reduce the size of a cluster storage.

You can [create](../../managed-mysql/operations/cluster-create.md) a new cluster with smaller storage and [migrate](../../managed-mysql/tutorials/data-migration/index.md) your data to it.

#### How do I increase the size of a disk? {#increase-size}

You cannot directly increase the size of non-replicated SSD [storage](../../managed-mysql/concepts/storage.md): follow the steps outlined in [this guide](../../managed-mysql/operations/update.md#change-disk-size).

If you need it increased, [restore the cluster from a backup](../../managed-mysql/operations/cluster-backups.md#restore) and set the appropriate size.

You can check the disk type in the [management console]({{ link-console-main }}). To do this, find the **{{ ui-key.yacloud.mdb.cluster.overview.label_hdd }}** setting under **{{ ui-key.yacloud.mdb.cluster.overview.section_resource }}** on the cluster page.


#### How do I change the disk type? {#modify-type}

To change the disk type, [restore](../../managed-mysql/operations/cluster-backups.md#restore) your cluster from a backup.

#### Why cannot I add or delete a host? {#not-add-delete}

The number of hosts in clusters is limited by [quotas](../../managed-mysql/concepts/limits.md#mmy-quotas). Before adding a host, check the resources currently in use: open the [Quotas]({{ link-console-quotas }}) page and find the **{{ ui-key.yacloud.iam.folder.dashboard.label_mdb }}** section.

You can delete a host as long as it is not the only host in the cluster. To replace the only host, first create a new host and then delete the old one.

Clusters with local disks have a fault-tolerant three-host configuration. Using fewer hosts is not allowed.

#### How do I perform a manual failover? {#manual-failover}

In a fault-tolerant multi-host cluster, you can switch the master role from the current master host to a replica host. After the failover, the current master host becomes a replica for the new master.

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the cluster page and select the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
   1. Click **{{ ui-key.yacloud.mdb.cluster.hosts.button_manual-failover }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To switch the master:

   1. See the description of the CLI command for initiating a failover:

      ```bash
      {{ yc-mdb-my }} cluster start-failover --help
      ```

   1. Run the `{{ yc-mdb-my }} cluster start-failover` command.

{% endlist %}

#### How do I restart a host? {#host-reboot}

You cannot restart a separate cluster host. To restart hosts, [stop and restart the cluster](../../managed-mysql/operations/cluster-stop.md).
