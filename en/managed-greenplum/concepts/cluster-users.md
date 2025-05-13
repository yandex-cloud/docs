# Users and roles in {{ mgp-name }}

{{ GP }} manages database access rights using roles. Roles can own database objects, such as tables, and have [attributes](#attributes) and [privileges](#privileges). You can assign privileges to other roles on behalf of a particular role.

In {{ GP }}, a user is a role that can log in to the database. To this end, it is granted the `LOGIN` [attribute](#attributes).

An admin user with the [mdb_admin](#mdb_admin) role has the maximum privileges among all users.

## Attributes {#attributes}

The role has attributes that define which jobs it can run in the database.

| Attributes                                | Description                                                                                                                                                                                                                                                                                                                    |
| :-------------------------------------- |:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `SUPERUSER` or `NOSUPERUSER`           | Defines whether the role is a superuser. In {{ mgp-name }}, the `SUPERUSER` attribute is assigned to the `gpadmin` and `monitor` service roles and is not available to service users.                                                                                                                                                                |
| `CREATEDB` or `NOCREATEDB`             | Determines whether a database may be created. The default value is `NOCREATEDB`.                                                                                                                                                                                                                                                 |
| `CREATEROLE` or `NOCREATEROLE`         | Determines whether other roles may be created and managed. The default value is `NOCREATEROLE`.                                                                                                                                                                                                                             |
| `INHERIT` or `NOINHERIT`               | Determines whether the role inherits the privileges of the roles it is a [part of](#group-roles). The default value is `INHERIT`.                                                                                                                                                                                                              |
| `LOGIN` or `NOLOGIN`                   | Determines whether the role may log in to the system, i.e., whether it is a user. The default value is `NOLOGIN`.                                                                                                                                                                                                                     |
| `CONNECTION LIMIT <value>`           | Number of concurrent connections for the role with the `LOGIN` attribute. The default value is `-1` (unlimited).                                                                                                                                                                                                 |
| `CREATEEXTTABLE` or `NOCREATEEXTTABLE` | Determines whether external tables may be created. The default value is `NOCREATEEXTTABLE`.                                                                                                                                                                                                                                        |
| `PASSWORD '<password>'`                   | Setting a password for the role. If no authentication is required for the role, you can skip this attribute.                                                                                                                                                                                                                        |
| `ENCRYPTED` or `UNENCRYPTED`           | Save the password as a hash string or plain text. The default value is `ENCRYPTED`. For more information about protecting authorization passwords, see the [{{ GP }}]({{ gp.docs.vmware }}/7/greenplum-database/admin_guide-roles_privs.html#protecting-passwords-in-greenplum-database) documentation.                                       |

## Group roles {#group-roles}

Some roles can become a part of other roles and inherit their privileges. When privileges of the parent role are changed, privileges of all roles within it are changed as well. For more information about group roles, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/7/greenplum-database/admin_guide-roles_privs.html#role-membership).

## Privileges {#privileges}

Privileges determine what a role can do with database objects.

Do not use the `mdb_admin` role for routine tasks because an incorrect command sent on its behalf may cause the cluster to fail. For these tasks, create separate roles with the minimum required privileges:

#|
||**Object type**
|**Privileges**||
||Tables, external tables, views
|`SELECT`
`INSERT`
`UPDATE`
`DELETE`
`REFERENCES`
`TRIGGER`
`TRUNCATE`
`ALL`||
||Columns
|`SELECT`
`INSERT`
`UPDATE`
`REFERENCES`
`ALL`||
||Sequences
|`USAGE`
`SELECT`
`UPDATE`
`ALL`||
||Databases
|`CREATE`
`CONNECT`
`TEMPORARY`
`TEMP`
`ALL`||
||Domains
|`USAGE`
`ALL`||
||External data shells
|`USAGE`
`ALL`||
||External servers
|`USAGE`
`ALL`||
||Functions
|`EXECUTE`
`ALL`||
||Procedural languages
|`USAGE`
`ALL`||
||Schemas
|`CREATE`
`USAGE`
`ALL`||
||Tablespaces
|`CREATE`
`ALL`||
||Types
|
`USAGE`
`ALL`||
||Protocols
|`SELECT`
`INSERT`
`ALL`||
|#

For more information about privileges and their management, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/7/greenplum-database/admin_guide-roles_privs.html#managing-object-privileges).

## The mdb_admin role instead of a superuser {#mdb_admin}

In a {{ mgp-name }} cluster, superuser permissions are not granted. Instead, you can work with databases as an admin user with the `mdb_admin` role. Such user is created along with the cluster and allows you the following operations:

* [Managing roles and users](../operations/roles-and-users.md).
* [Managing resource groups](../operations/resource-groups.md).
* [Managing client processes and user sessions](../operations/cluster-process.md) (a user with the `mdb_admin` role can access `mdb_toolkit` objects).
* Accessing the [pg_stat_activity]({{ pg-docs }}/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW) view and getting information from it.
* Managing database objects of other users, such as tables. A user with the `mdb_admin` role owns objects of all users.
* Using the connection slot reserved for `mdb_admin`.

   If too many connections to a database are established, one more connection may cause an error. A user with the `mdb_admin` role helps to avoid that as it has a reserved connection slot.

* Creating a database.
* [Working with the PXF protocol](../operations/external-tables.md):

   * Creating external data sources.
   * Creating external tables.
   * Accessing user credentials. This data is transmitted over PXF in an open format.

* [Expanding the cluster](../operations/cluster-expand.md): adding segment hosts to it and redistributing data between them using `gp_expand`.
* Connecting to the `gpperfmon` database and [diagnosing cluster performance](../operations/performance-diagnostics.md).

The admin username and password are created [together with the cluster](../operations/cluster-create.md#create-cluster).

If you want to grant the admin user privileges to another user, assign the `mdb_admin` role to that user:

```sql
GRANT mdb_admin TO <username>;
```

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
