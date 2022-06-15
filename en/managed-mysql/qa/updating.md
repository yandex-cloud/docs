# Updating clusters

#### Reducing disk size {#reduce-size}

It is not possible to reduce cluster storage size.

You can [create](../operations/cluster-create.md) a new cluster with less storage and [migrate](../tutorials/data-migration.md) the data to it.

#### Increasing disk size {#increase-size}

Storage size can only be increased for standard (`network-hdd`) and fast (`network-ssd`) network storage: follow the instructions under [Updating a cluster](../operations/update.md#change-disk-size).

To increase the size of storage of a different type, [restore the cluster from a backup](../operations/cluster-backups.md#restore) and set the required size.

You can verify the storage type in the [management console]({{ link-console-main }}). To do this, find the **Storage** parameter under **Resources** on the cluster page.

#### Changing storage type {#modify-type}

To change the type of storage, [restore](../operations/cluster-backups.md#restore) the cluster from a backup.

#### Host cannot be added/deleted {#not-add-delete}

The number of hosts in a cluster is limited by [quotas](../concepts/limits.md#mmy-quotas). For instance, you can only use hosts belonging to the `b1.nano`, `b1.micro`, `b2.nano`, and `b2.micro` [classes](../concepts/instance-types.md) in single-host clusters. Therefore, before adding a host, please check the resources being used: open the [Quotas]({{ link-console-quotas }}) page and find the **Managed Databases** section.

You can delete a host as long as it is not the only one in a cluster. To replace the only host, first create a new host and then delete the old one.

Clusters with local storage have a fault-tolerant 3-host configuration. Fewer hosts are not permitted.

#### Performing a manual failover {#manual-failover}

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
