# Managing {{ GP }} users

#### How do I view user queries? {#pg-stat}

Run the query below as an [administrator with the MDB_ADMIN role](../concepts/cluster-users.md):

```sql
SELECT * from mdb_toolkit.pg_stat_activity();
```

#### How do I cancel other users' sessions? {#cancel-sessions}

Run the query below as an [administrator with the MDB_ADMIN role](../concepts/cluster-users.md):

```sql
SELECT * from mdb_toolkit.gp_cancel_backend(<session PID>);
SELECT * from mdb_toolkit.gp_terminate_backend(<session PID>);
```

You can retrieve a session PID together with a [list of user queries](#pg-stat).

#### How do I manage load? {#load-management}

Run a query that sets the number of concurrent transactions for a [resource group](../concepts/resource-groups.md) using an [administrator account with the MDB_ADMIN role](../concepts/cluster-users.md):

```sql
SELECT * FROM gp_toolkit.gp_resgroup_config;
ALTER RESOURCE GROUP default_group SET concurrency <number of concurrent transactions>;
```

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
