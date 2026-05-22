---
title: User permissions in {{ mmy-name }}
description: In a {{ mmy-full-name }} cluster, user permissions are decided by one or more privileges assigned to the user.
---

# User permissions in {{ mmy-name }}

In a {{ mmy-name }} cluster, user permissions are decided by one or more privileges assigned to the user.

A _privilege_ is a permission to perform certain operations in the cluster. In {{ MY }}, there are three levels of user privileges:

* Administrative privileges, which allow cluster-level operations. These are set in the [user-level {{ MY }} settings](settings-list.md#setting-administrative-privileges) and are valid for all the cluster hosts.
* Database-level privileges, which allow operations with all objects in the database.
* Database object-level privileges, which allow operations with individual database objects, i.e., tables, indexes, views, and stored procedures.

Alongside the cluster, the system creates a database and a user with a privilege designated as `ALL_PRIVILEGES` for this database.

Administrative and database-level privileges are [set](../operations/grant.md) via the {{ yandex-cloud }} interfaces; whereas database object-level privileges, via the `GRANT` and `REVOKE` SQL commands.

{% note warning %}

Privileges set via SQL are not saved in the cluster configuration and get reset after you restart the cluster.

{% endnote %}

## Database-level user privileges in {{ mmy-name }} {#db-privileges}

| Privilege | Description |
|:---|:---|
| `ALL_PRIVILEGES` | Allows all actions with user data in the database and allows using the `SHOW SLAVE STATUS` statement. |
| `ALL` | Synonym for the `ALL_PRIVILEGES` privilege used for managing privileges via the {{ yandex-cloud }} CLI. |
| `ALTER` | Allows using the `ALTER TABLE` statement to change the structure of any custom tables in the database. To modify a table, you need the `CREATE` and `INSERT` privileges. To rename a table, you need the `ALTER` and `DROP` privileges for the original table and `CREATE` and `INSERT` for the new one. |
| `ALTER_ROUTINE` | Allows using the `ALTER ROUTINE` statement to change or delete any custom stored procedures and functions in the database. |
| `CREATE` | Allows using the `CREATE` statement to create custom tables in the database. |
| `CREATE_ROUTINE` | Allows using the `CREATE ROUTINE` statement to create custom stored procedures and functions in the database. |
| `CREATE_TEMPORARY_TABLES` | Allows using the `CREATE TEMPORARY TABLE` statement to create temporary custom tables in the database. |
| `CREATE_VIEW` | Allows using the `CREATE VIEW` statement to create custom views in the database. |
| `DELETE` | Allows deleting records from any custom tables in the database. |
| `DROP` | Allows deleting tables and views. |
| `EVENT` | Allows you to create, change, delete, or display events in the [Event Scheduler](https://dev.mysql.com/doc/refman/8.0/en/events-overview.html). |
| `EXECUTE` | Allows executing any custom stored procedures and functions. |
| `INDEX` | Allows you to create and delete indexes from existing tables in the database. |
| `INSERT` | Allows inserting records into custom DB tables. |
| `LOCK_TABLES` | Allows the explicit use of the `LOCK TABLES` statement to create table locks in the database. |
| `REFERENCES` | Enables you to create `FOREIGN KEY` for DB tables. |
| `SELECT` | Allows you to read data from DB tables. |
| `SHOW_VIEW` | Allows using the `SHOW CREATE VIEW` statement. |
| `TRIGGER` | Allows you to create, delete, execute, or display triggers for existing DB tables. |
| `UPDATE` | Allows updating records in DB tables. |

To learn more about managing user privileges, see [this {{ MY }} guide](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html).
