# Users and roles in {{ mgp-name }}

{{ GP }} manages database access rights using roles. Roles can own database objects (such as tables) and have [attributes](#attributes) and [privileges](#privileges). You can assign privileges to other roles on behalf of a particular role.

User in {{ GP }} is a role that can log in to the database. To do this, it is granted the `LOGIN` [attribute](#attributes).

You can manage cluster users using SQL commands executed on behalf of the admin user with the `mdb_admin` role. The admin username and password are set when the cluster is [created](../operations/cluster-create.md#create-cluster). For more information, see [{#T}](../operations/roles-and-users.md).

To grant admin user privileges to another user, assign it the `mdb_admin` role:

```sql
GRANT mdb_admin TO <username>;
```

## Attributes {#attributes}

The role has attributes that define which jobs it can execute in the database.

| Attributes | Description |
| :-------------------------------------- | :-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `SUPERUSER` or `NOSUPERUSER` | Whether the role is a superuser. In {{ mgp-name }}, the `SUPERUSER` attribute is assigned to the `gpadmin` and `monitor` service roles and is not available to service users. |
| `CREATEDB` or `NOCREATEDB` | Permission or prohibition to create a database. By default: `NOCREATEDB`. |
| `CREATEROLE` or `NOCREATEROLE` | Permission or prohibition to create other roles and manage them. By default: `NOCREATEROLE`. |
| `INHERIT` or `NOINHERIT` | Whether the role inherits the privileges of the roles it is a [part of](#group-roles). By default: `INHERIT`. |
| `LOGIN` or `NOLOGIN` | Whether the role can log in to the system and be a user. By default: `NOLOGIN`. |
| `CONNECTION LIMIT <value>` | Number of concurrent connections for the role with the `LOGIN` attribute. The default value is `-1` (unlimited). |
| `CREATEEXTTABLE` or `NOCREATEEXTTABLE` | Permission or prohibition to create external tables. By default: `NOCREATEEXTTABLE`. |
| `PASSWORD '<password>'` | Setting a password for the role. If authentication is not required for the role, you can skip this attribute. |
| `ENCRYPTED` or `UNENCRYPTED` | Save the password as a hash string or plain text. By default: `ENCRYPTED`. For more information about protecting authorization passwords, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/GUID-admin_guide-roles_privs.html#protecting-passwords-in-greenplum-database). |

## Group roles {#group-roles}

Some roles can become a part of other roles and inherit their privileges. When privileges of the parent role are changed, privileges of all the roles within it are changed as well. For more information about group roles, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/GUID-admin_guide-roles_privs.html#role-membership).

## Privileges {#privileges}

Privileges define the actions with database objects available to the role.

Do not use the `mdb_admin` role for routine tasks, because an error command sent on its behalf may cause the cluster to fail. For these tasks, create separate roles with the minimum required privileges:

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

For more information about privileges and their management, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/GUID-admin_guide-roles_privs.html#managing-object-privileges).

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
