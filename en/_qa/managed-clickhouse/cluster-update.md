#### How do I add a host to a cluster? {#add-host}

To add a host, follow [this guide](../../managed-clickhouse/operations/hosts.md#add-host). You can also add new hosts to a cluster when [creating a shard](../../managed-clickhouse/operations/shards.md#add-shard).

#### Can I set join_use_nulls to 1 using the CLI? {#join-use-nulls}

Yes. To do this, when creating a user or updating user settings, provide the required `join_use_nulls` value in `--settings`. Here is an example:

```bash
yc managed-clickhouse user update <username> \
  --cluster-name=<cluster_name> \
  --settings="join_use_nulls=1"
```

For more information, see [this guide](../../managed-clickhouse/operations/cluster-users.md#update-settings).

#### Will my cluster be unavailable during an update? {#update-availability}

If your cluster has more than one host, there is no downtime while updating it, since the hosts are updated one by one. Only individual hosts are unavailable when the cluster is being restarted.

#### How do I change the time zone? {#timezone}

Change the {{ CH }} [timezone]({{ ch.docs }}/operations/server-configuration-parameters/settings#server_configuration_parameters-timezone) or [session_timezone]({{ ch.docs }}/operations/settings/settings#session_timezone) setting by following [this guide](../../managed-clickhouse/operations/change-server-level-settings.md#yandex-cloud-interfaces).

#### Will my cluster be unavailable when adding replicas? {#add-replica-availability}

Yes, the cluster will experience a short downtime during restart.

#### How do I grant read-only permissions to a user? {#readonly}

To do this, when creating or editing a user via the CLI, specify `readonly=1` in `--settings`. Here is an example:

```bash
yc managed-clickhouse user update <username> \
  --cluster-name=<cluster_name> \
  --settings="readonly=1"
```

For more information, see [this guide](../../managed-clickhouse/operations/cluster-users.md#update-settings).

#### How do I increase the memory limit? {#memory-limit}

[Update the user settings](../../managed-clickhouse/operations/cluster-users.md#update-settings) and set the required `Max memory usage` value.

#### Can I change a network and subnets? {#network}

No, you can only select a network and subnets for hosts when creating a cluster or [restoring it](../../managed-clickhouse/operations/cluster-backups.md#restore) from a backup.

#### How do I change the distribution of data across shards in a cluster? {#resharding}

In an existing cluster, you cannot change the location of data in shards.
