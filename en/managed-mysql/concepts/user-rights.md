---
title: '{{ MY }} DBMS user permissions in {{ mmy-full-name }}'
description: The {{ MY }} DBMS controls user permissions for a cluster host, individual database, and individual database object. The user permissions and settings that apply in a {{ mmy-name }} cluster are common to all cluster hosts.
---

# User permissions

{{ MY }} manages user permissions at three levels:

* Cluster host (administrative privileges).
* Individual database (database privileges).
* Individual DB object, such as a table or index (privileges for database objects).

The user permissions and settings that apply in a {{ mmy-name }} cluster are common to all cluster hosts.

The permissions valid at the entire DB cluster level are set in the [user level {{ MY }} settings](settings-list.md#setting-administrative-privileges).

To differentiate user permissions at the individual database level, each user gets one or more _privileges_. Each privilege allows the user to perform the actions specified in the [privilege description](#db-privileges). Alongside the cluster, a user is created who gets the privilege called `ALL_PRIVILEGES` in the first database of the cluster.

To manage user permissions for the [entire cluster](settings-list.md#dbms-user-settings) or an [individual database](../operations/grant.md), use the {{ yandex-cloud }} interfaces. Changes made by SQL commands at these levels are not saved: the cluster returns to the state set through the {{ yandex-cloud }} interfaces.

To manage user permissions at the individual DB object level, use the `GRANT` and `REVOKE` SQL commands.

## User privileges in {{ mmy-name }} clusters {#db-privileges}

| Privilege | Description |
|:---|:---|
| `ALL_PRIVILEGES` | Allows any action with user data in the database and allows using the `SHOW SLAVE STATUS` operator. |
| `ALL` | Synonym for the `ALL_PRIVILEGES` privilege used for managing privileges via the CLI. |
| `ALTER` | Allows using the `ALTER TABLE` operator to change the structure of any custom tables in the database. Requires the `CREATE` and `INSERT` privileges. For renaming tables |
| `ALTER_ROUTINE` | Allows using the `ALTER ROUTINE` operator to change or delete any custom stored procedures and functions in the database. |
| `CREATE` | Allows using the `CREATE` operator to create user tables in the database. |
| `CREATE_ROUTINE` | Allows using the `CREATE ROUTINE` operator to create custom stored procedures and functions in the database. |
| `CREATE_TEMPORARY_TABLES` | Allows using the `CREATE TEMPORARY TABLE` operator to create temporary custom tables in the database. |
| `CREATE_VIEW` | Allows using the `CREATE VIEW` operator to create custom views in the database. |
| `DELETE` | Allows deleting records from any custom tables in the database. |
| `DROP` | Allows deleting tables and views. |
| `EVENT` | Allows you to create, change, delete, or display events in the [Event Scheduler](https://dev.mysql.com/doc/refman/8.0/en/events-overview.html). |
| `EXECUTE` | Allows executing any custom stored procedures and functions. |
| `INDEX` | Allows you to create and delete indexes from existing tables in the database. |
| `INSERT` | Allows inserting records into custom DB tables. |
| `LOCK_TABLES` | Allows the explicit use of the `LOCK TABLES` operator to create table locks in the database. |
| `REFERENCES` | Allows creating external keys (`FOREIGN KEY`) for DB tables. |
| `SELECT` | Allows you to read data from DB tables. |
| `SHOW_VIEW` | Allows using the `SHOW CREATE VIEW` operator. |
| `TRIGGER` | Allows you to create, delete, execute, or display triggers for existing DB tables. |
| `UPDATE` | Allows updating records in DB tables. |

To learn more about managing user permissions, see the [{{ MY }} documentation](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html).
