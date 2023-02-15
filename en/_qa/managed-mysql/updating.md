# Updating a {{ MY }} cluster

{% if audience != "internal" %}

#### Can I manage a cluster using SQL commands? {#sql-control}

There are some restrictions for cluster management using SQL commands. For more information, see [{#T}](../../managed-mysql/concepts/sql-limits.md).

#### How do I reduce the size of a disk? {#reduce-size}

It is not possible to reduce cluster storage size.

You can [create](../../managed-mysql/operations/cluster-create.md) a new cluster with less storage and [migrate](../../managed-mysql/tutorials/data-migration.md) the data to it.

#### How do I increase the size of a disk? {#increase-size}

Storage size cannot be increased for non-replicated SSD [storage](../../managed-mysql/concepts/storage.md): follow the instructions at [Updating clusters](../../managed-mysql/operations/update.md#change-disk-size).

To increase the size of non-replicated SSD storage, [restore the cluster from a backup](../../managed-mysql/operations/cluster-backups.md#restore) and set the required size.

You can verify the disk type in the [management console]({{ link-console-main }}). To do this, find the **Storage** parameter under **Resources** on the cluster page.

{% else %}

#### How do I change the size of a disk? {#change-size}

To change the disk size, follow the instruction at [Updating clusters](../../managed-mysql/operations/update.md#change-disk-size).

{% endif %}

#### How do I change the disk type? {#modify-type}

To change the disk type, [restore](../../managed-mysql/operations/cluster-backups.md#restore) your cluster from a backup.

#### Why can't I add/delete a host? {#not-add-delete}

The number of hosts in a cluster is limited by [quotas](../../managed-mysql/concepts/limits.md#mmy-quotas). For instance, you can only use hosts belonging to the `b1.nano`, `b1.micro`, `b2.nano`, and `b2.micro` [classes](../../managed-mysql/concepts/instance-types.md) in single-host clusters. Therefore, before adding a host, please check the resources being used: open the [Quotas]({{ link-console-quotas }}) page and find the **Managed Databases** section.

You can delete a host as long as it is not the only one in a cluster. To replace the only host, first create a new host and then delete the old one.

Clusters with local disks have a fault-tolerant 3-host configuration. Fewer hosts are not permitted.

#### How do I perform a manual failover? {#manual-failover}

In a failover  cluster with multiple hosts, you can switch the master role from the current master host to the replica host. After this operation, the current master host becomes the replica host of the new master.

{% list tabs %}

- Management console

   1. Go to the cluster page and select the **Hosts** tab.
   1. Click **Switch master**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To switch the master:

   1. View a description of the CLI switch master command:

      ```
      {{ yc-mdb-my }} cluster start-failover --help
      ```

   1. Run the command: `{{ yc-mdb-my }} cluster start-failover`.

{% endlist %}
