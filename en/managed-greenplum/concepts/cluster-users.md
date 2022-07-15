# Managing users

You can manage cluster users with SQL commands run as an administrator. You specify the administrator name and password when you [create](../operations/cluster-create.md#create-cluster) a cluster. For more information, see the [{{ GP }} documentation](https://greenplum.docs.pivotal.io/6latest/admin_guide/roles_privs.html).

We do not recommend using an administrator account for everyday tasks because a command sent by mistake from this account can result in cluster failure. For these tasks, create separate users with the minimum required [privileges](https://greenplum.docs.pivotal.io/6latest/admin_guide/roles_privs.html#topic4).

The `SUPERUSER` role is unavailable to an administrative user and is replaced with the `MDB_ADMIN` role instead. To grant an administrative user access to system views, use the following SQL command:

```sql
{% set admin_role = 'mdb_admin' %}
{% set schema = 'mdb_toolkit' %}

CREATE OR REPLACE FUNCTION not_var{{ schema }}.pg_stat_activity() RETURNS SETOF pg_stat_activity AS
$$ SELECT * FROM pg_catalog.pg_stat_activity; $$
LANGUAGE sql CONTAINS SQL SECURITY DEFINER;

CREATE OR REPLACE FUNCTION not_var{{ schema }}.pg_locks() RETURNS SETOF pg_locks AS
$$ SELECT * FROM pg_catalog.pg_locks; $$
LANGUAGE sql CONTAINS SQL SECURITY DEFINER;

CREATE OR REPLACE FUNCTION not_var{{ schema }}.session_level_memory_consumption() RETURNS SETOF session_state.session_level_memory_consumption AS
$$ SELECT * FROM session_state.session_level_memory_consumption; $$
LANGUAGE sql CONTAINS SQL SECURITY DEFINER;
```

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
