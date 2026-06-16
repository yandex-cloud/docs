---
title: Managing users and access permissions in {{ mch-name }}
description: 'In {{ mch-full-name }}, access management features depend on the user management method you select: via {{ yandex-cloud }} interfaces or via SQL.'
---


# Managing users and access permissions in {{ mch-full-name }}

In {{ mch-name }}, user access permissions depend on the privileges granted to the user.

A _privilege_ is a permission to perform certain operations in the cluster. For more information about the hierarchy of privileges and their scope, see [this {{ CH }} guide]({{ ch.docs }}{{ lang }}/sql-reference/statements/grant#privileges).

A _role_ is a set of privileges.

Your access management capabilities depend on the user management method you select:

* [Via {{ yandex-cloud }} interfaces](#yandex-cloud-user-management) ([management console]({{ link-console-main }}), [CLI](../../cli/index.yaml), {{ TF }}, and API): Allows managing user access to databases using {{ mch-name }}.
* [Via SQL](#sql-user-management): Allows managing user access to database objects based on a role model ([RBAC](https://en.wikipedia.org/wiki/Role-based_access_control)).


Concurrent management via {{ yandex-cloud }} interfaces and via SQL is not supported.

Creating a cluster automatically creates [service users](#service-users).


## User management via {{ yandex-cloud }} interfaces {#yandex-cloud-user-management}

{{ yandex-cloud }} interfaces allow you to:

* [Create users](../operations/cluster-users.md#adduser) and grant them access to databases.
* Configure access settings:
  
  * Read-only access ([Readonly](settings-list.md#setting-readonly) option).
  * No DDL queries ([Allow DDL](settings-list.md#setting-allow-ddl) option).

You can enable user management via {{ yandex-cloud }} interfaces only when [creating a cluster](../operations/cluster-create.md).


### User privilege restrictions {#users-privileges-restrictions}

Users created via {{ yandex-cloud }} interfaces do not have the following privileges:

* `SYSTEM SHUTDOWN`
* `FILE`
* `ALTER FREEZE PARTITION`
* `CREATE DATABASE` and `DROP DATABASE`
* `ACCESS MANAGEMENT`
* Privileges for modifying operations for system databases (`system` and `_system`)


## User management via SQL {#sql-user-management}


You can activate user management via SQL when [creating a cluster](../operations/cluster-create.md) or [updating its settings](../operations/update.md#SQL-management). Once you do that, SQL will be your only user management option; you cannot switch back to {{ yandex-cloud }} interfaces. However, users created via {{ yandex-cloud }} interfaces will remain.

Enabling this option creates the `admin` user whom you can use to create other users and manage their roles, privileges, and row policies.

For more information about managing access permissions via SQL, see [this {{ CH }} guide]({{ ch.docs }}{{ lang }}/operations/access-rights).


### Privilege restrictions for the admin user {#admin-privileges-restrictions}

The `admin` user does not have the following privileges:

* `SYSTEM SHUTDOWN`
* `FILE`
* `ALTER FREEZE PARTITION`
* Privileges for modifying operations for system databases (`system` and `_system`)

In addition, the `CREATE DATABASE` and `DROP DATABASE` privileges are granted only on condition that [databases are managed](../operations/databases.md) via SQL.

The `admin` user having limited privileges, the `GRANT ALL` command is unavailable. To grant all available privileges, use the `GRANT CURRENT GRANTS` command.

For more on `GRANT CURRENT GRANTS`, see [this {{ CH }} guide]({{ ch.docs }}{{ lang }}/sql-reference/statements/grant#grant-current-grants-syntax).




## Service users {#service-users}

Service users are users created and managed by {{ mch-name }}. The cluster needs service users to operate. Such users cannot be managed manually.


#### _admin {#admin}

User to administer and manage the {{ CH }} cluster: create databases, users, and auxiliary tables.


#### _backup_admin {#backup-admin}

User to create backups and restore data from them.


#### _monitor, _sli {#monitor-sli}

Users to health check the {{ CH }} cluster and its subsystems.


#### _metrics {#metrics}

User to calculate the metrics delivered to {{ monitoring-full-name }}.


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}