# Editing clusters

#### How do I add a host to a cluster? {#add-host}

To add a host, follow the [instructions](../operations/hosts.md#add-host). You can also add new hosts to your cluster when [creating a shard](../operations/shards.md#add-shard).

#### Can I set join_use_nulls to 1 via the CLI? {#join-use-nulls}

Yes, you can. When creating or changing user settings, pass the desired value of the `join_use_nulls` setting in the `--settings` parameter. For example:

```bash
yc managed-clickhouse user update <username> \
  --cluster-name=<cluster name> \
  --settings="join_use_nulls=1"
```

For more information, see the [documentation](../operations/cluster-users.md#update-settings).

#### Is a cluster available during an update? {#update-availability}

If it's a multi-host cluster, the hosts are updated one by one so there is no downtime. Only the individual hosts are unavailable as they restart.

#### How do I change the time zone? {#timezone}

Follow the instructions in [{#T}](../operations/update.md#change-clickhouse-config).

#### Is a cluster unavailable when adding replicas? {#add-replica-availability}

Yes, there will be a little downtime as the cluster restarts.

#### How do I grant a user read-only rights? {#readonly}

To do this, when creating or changing a user via the CLI, pass `readonly=1` in the `--settings` parameter. For example:

```bash
yc managed-clickhouse user update <username> \
  --cluster-name=<cluster name> \
  --settings="readonly=1"
```

For more information, see the [documentation](../operations/cluster-users.md#update-settings).

#### How do I increase the memory limit? {#memory-limit}

[Update user settings](../operations/cluster-users.md#update-settings) and set `Max memory usage` to the desired value.
