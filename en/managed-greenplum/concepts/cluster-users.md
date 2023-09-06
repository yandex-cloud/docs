# Users and roles in {{ mgp-name }}

{{ GP }} manages database access rights using roles. Roles can own database objects, such as tables, and have [attributes](#attributes) and [privileges](#privileges). You can assign privileges to other roles on behalf of a particular role.

In {{ GP }}, a user is a role that can log in to the database. To do this, it is granted the `LOGIN` [attribute](#attributes).

You can manage cluster users using SQL commands run on behalf of the admin user with the `mdb_admin` role. The admin username and password are set when [creating](../operations/cluster-create.md#create-cluster) a cluster. For more information, see [{#T}](../operations/roles-and-users.md).

To grant the admin user privileges to another user, assign the `mdb_admin` role to it:

```sql
GRANT mdb_admin TO <username>;
```

## Attributes {#attributes}

The role has attributes that define which jobs it can run in the database.

| Attributes | Description |
| :-------------------------------------- | :-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `SUPERUSER` or `NOSUPERUSER` | Defines whether the role is a superuser. In {{ mgp-name }}, the `SUPERUSER` attribute is assigned to the `gpadmin` and `monitor` service roles and is not available to service users. |
| `CREATEDB` or `NOCREATEDB` | Determines whether a database may be created. The default attribute is `NOCREATEDB`. |
| `CREATEROLE` or `NOCREATEROLE` | Determines whether other roles may be created and managed. The default attribute is `NOCREATEROLE`. |
| `INHERIT` or `NOINHERIT` | Determines whether the role inherits the privileges of the roles it is a [part of](#group-roles). The default attribute is `INHERIT`. |
| `LOGIN` or `NOLOGIN` | Determines whether the role may log in to the system, i.e., whether it is a user. The default attribute is `NOLOGIN`. |
| `CONNECTION LIMIT <value>` | Number of concurrent connections for the role with the `LOGIN` attribute. The default value is `-1` (unlimited). |
| `CREATEEXTTABLE` or `NOCREATEEXTTABLE` | Determines whether external tables may be created. The default attribute is `NOCREATEEXTTABLE`. |
| `PASSWORD '<password>'` | Setting a password for the role. If no authentication is required for the role, you can skip this attribute. |
| `ENCRYPTED` or `UNENCRYPTED` | Save the password as a hash string or plain text. The default attribute is `ENCRYPTED`. For more information about protecting authorization passwords, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/admin_guide-roles_privs.html#protecting-passwords-in-greenplum-database). |

## Group roles {#group-roles}

Some roles can become a part of other roles and inherit their privileges. When privileges of the parent role are changed, privileges of all roles within it are changed as well. For more information about group roles, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/admin_guide-roles_privs.html#role-membership).

## Privileges {#privileges}

Privileges determine what a role can do with database objects.

Do not use the `mdb_admin` role for routine tasks, because an incorrect command sent on its behalf may cause the cluster to fail. For these tasks, create separate roles with the minimum required privileges:

#|
||**Object type**
|**Privileges**||
||Tables, external tables, view
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

For more information about privileges and how to manage them, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/admin_guide-roles_privs.html#managing-object-privileges).

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
