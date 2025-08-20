#### How do I transfer data to a cluster? {#to-cluster}

Follow the steps described in [this tutorial](../../managed-mysql/tutorials/data-migration.md).

#### How do I move a cluster to a different folder or cloud? {#to-folder-cloud}

To move a cluster:
* To a different folder: [Restore the cluster from a backup](../../managed-mysql/operations/cluster-backups.md#restore). Specify the desired folder when configuring the new cluster.
* To a different cloud: Follow the steps in [this tutorial](../../managed-mysql/tutorials/data-migration.md).

#### External replication error {#external-replication-error}

Error message:

```text
Last\_IO\_Error: 
Got fatal error 1236 from source when reading data from binary log: 
'Could not find first log file name in binary log index file'
```

This error may occur during external replication using the [master host's specific FQDN](../../managed-mysql/operations/connect.md#fqdn-master) if the master host in the source cluster has changed.

**Solution:**

1. Restart replication.
1. Run this command only once:

   ```sql
   STOP SLAVE;
   CHANGE MASTER TO MASTER_AUTO_POSITION = 1;
   START SLAVE;
   ```

If the master host in the source cluster changes, the replication will be reconfigured to use the new master host. For more information about configuration, see [this {{ MY }} article](https://dev.mysql.com/doc/refman/8.0/en/change-master-to.html).
