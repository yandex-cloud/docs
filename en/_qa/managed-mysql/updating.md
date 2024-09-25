
#### Can I manage a cluster using SQL commands? {#sql-control}

There are some restrictions for cluster management using SQL commands. For more information, see [{#T}](../../managed-mysql/concepts/sql-limits.md).

#### How do I reduce the size of a disk? {#reduce-size}

It is not possible to reduce cluster storage size.

You can [create](../../managed-mysql/operations/cluster-create.md) a new cluster with less storage and [migrate](../../managed-mysql/tutorials/data-migration.md) the data to it.

#### How do I increase the size of a disk? {#increase-size}

Storage size cannot be increased for non-replicated SSD [storage](../../managed-mysql/concepts/storage.md): follow the instructions at [Updating clusters](../../managed-mysql/operations/update.md#change-disk-size).

To increase the size of non-replicated SSD storage, [restore the cluster from a backup](../../managed-mysql/operations/cluster-backups.md#restore) and set the required size.

You can check the disk type in the [management console]({{ link-console-main }}). To do this, find the **{{ ui-key.yacloud.mdb.cluster.overview.label_hdd }}** parameter under **{{ ui-key.yacloud.mdb.cluster.overview.section_resource }}** on the cluster page.


#### How do I change the disk type? {#modify-type}

To change the disk type, [restore](../../managed-mysql/operations/cluster-backups.md#restore) your cluster from a backup.

#### Why cannot I add or delete a host? {#not-add-delete}

The number of hosts in a cluster is limited by [quotas](../../managed-mysql/concepts/limits.md#mmy-quotas). Before adding a host, check the resources currently in use: open the [Quotas]({{ link-console-quotas }}) page and find the **{{ ui-key.yacloud.iam.folder.dashboard.label_mdb }}** section.

You can delete a host as long as it is not the only one in a cluster. To replace the only host, first create a new host and then delete the old one.

Clusters with local disks have a fault-tolerant 3-host configuration. Fewer hosts are not permitted.

#### How do I perform a manual failover? {#manual-failover}

In a failover cluster with multiple hosts, you can switch the master role from the current master host to the replica host. After this operation, the current master host becomes the replica host of the new master.

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the cluster page and click the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
   1. Click **{{ ui-key.yacloud.mdb.cluster.hosts.button_manual-failover }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To switch the master:

   1. View a description of the CLI switch master command:

      ```bash
      {{ yc-mdb-my }} cluster start-failover --help
      ```

   1. Run the `{{ yc-mdb-my }} cluster start-failover` command.

{% endlist %}

#### How do I restart a host? {#host-reboot}

You cannot restart a separate cluster host. To restart hosts, [stop and restart the cluster](../../managed-mysql/operations/cluster-stop.md).
