#### How do I add a host to a cluster? {#add-host}

To add a host, follow [this guide](../../managed-clickhouse/operations/hosts.md#add-host). You can also add new hosts to a cluster when [creating a shard](../../managed-clickhouse/operations/shards.md#add-shard).

#### Can I set join_use_nulls to 1 using the CLI? {#join-use-nulls}

Yes. To do this, when creating a user or updating user settings, pass the desired `join_use_nulls` setting value in the `--settings` parameter. For example:

```bash
yc managed-clickhouse user update <username> \
  --cluster-name=<cluster_name> \
  --settings="join_use_nulls=1"
```

For more information, see the [documentation](../../managed-clickhouse/operations/cluster-users.md#update-settings).

#### Is a cluster available when being updated? {#update-availability}

If it is a multi-host cluster, there is no downtime while updating it, since the hosts are updated one by one. Only individual hosts are unavailable when the cluster is being restarted.

#### How do I change the time zone? {#timezone}

Change the [timezone]({{ ch.docs }}/operations/server-configuration-parameters/settings#server_configuration_parameters-timezone) or [session_timezone]({{ ch.docs }}/operations/settings/settings#session_timezone) setting for {{ CH }} by following [this guide](../../managed-clickhouse/operations/update.md#change-clickhouse-config).

#### Is a cluster unavailable when adding replicas? {#add-replica-availability}

Yes, there is a short downtime when restarting a cluster.

#### How do I grant a user read-only permissions? {#readonly}

To do this, when creating or editing a user via the CLI, pass `readonly=1` in the `--settings` parameter. For example:

```bash
yc managed-clickhouse user update <username> \
  --cluster-name=<cluster_name> \
  --settings="readonly=1"
```

For more information, see the [documentation](../../managed-clickhouse/operations/cluster-users.md#update-settings).

#### How do I increase the memory limit? {#memory-limit}

[Update the user settings](../../managed-clickhouse/operations/cluster-users.md#update-settings) and set the desired `Max memory usage` parameter value.

#### Can I change the disk type? {#disk-type}

No, you can only select the disk type when creating a cluster or [restoring it](../../managed-clickhouse/operations/cluster-backups.md#restore) from a backup.

#### Can I change a network and subnets? {#network}

No, you can only select a network and subnets for hosts when creating a cluster or [restoring it](../../managed-clickhouse/operations/cluster-backups.md#restore) from a backup.

#### How to change the distribution of data across shards in a cluster? {#resharding}

In an existing cluster, you cannot change the location of data in shards. To make the change, [transfer data to a new cluster with shard redistribution](../../managed-clickhouse/tutorials/mch-mch-resharding.md) using {{ data-transfer-full-name }}.
