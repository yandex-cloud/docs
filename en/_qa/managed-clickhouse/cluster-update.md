# Updating {{ CH }} clusters

#### How do I add a host to a cluster? {#add-host}

To add a host, follow the [instructions](../../managed-clickhouse/operations/hosts.md#add-host). You can also add new hosts to a cluster when [creating a shard](../../managed-clickhouse/operations/shards.md#add-shard).

#### Can I set join_use_nulls to 1 using the CLI? {#join-use-nulls}

Yes. To do this, when creating a user or updating user settings, pass the desired `join_use_nulls` setting value in the `--settings` parameter. For example:

```bash
yc managed-clickhouse user update <username> \
  --cluster-name=<cluster name> \
  --settings="join_use_nulls=1"
```

For more information, see the [documentation](../../managed-clickhouse/operations/cluster-users.md#update-settings).

#### Is a cluster available when being updated? {#update-availability}

If it's a multi-host cluster, there is no downtime while updating it, since the hosts are updated one by one. Only individual hosts are unavailable when the cluster is being restarted.

#### How do I change the time zone? {#timezone}

Follow the instructions in [{#T}](../../managed-clickhouse/operations/update.md#change-clickhouse-config).

#### Is a cluster unavailable when adding replicas? {#add-replica-availability}

Yes, there is a short downtime when restarting a cluster.

#### How do I grant a user read-only permissions? {#readonly}

To do this, when creating or editing a user via the CLI, pass `readonly=1` in the `--settings` parameter. For example:

```bash
yc managed-clickhouse user update <username> \
  --cluster-name=<cluster name> \
  --settings="readonly=1"
```

For more information, see the [documentation](../../managed-clickhouse/operations/cluster-users.md#update-settings).

#### How do I increase the memory limit? {#memory-limit}

[Update the user settings](../../managed-clickhouse/operations/cluster-users.md#update-settings) and set the desired `Max memory usage` parameter value.

#### How do I change the disk type? {#disk-type}

To change the disk type, [restore the cluster](../../managed-clickhouse/operations/cluster-backups.md#restore) from a backup and specify the desired disk type when configuring the new cluster.
