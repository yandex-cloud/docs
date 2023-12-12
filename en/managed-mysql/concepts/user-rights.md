---
title: "{{ MY }} user permissions in {{ mmy-full-name }}"
description: "{{ MY }} manages user permissions for a cluster host, individual database, and an individual database object. The user permissions and settings that apply in a {{ mmy-name }} cluster are common to all cluster hosts."
---

# User permissions

{{ MY }} manages user permissions at three levels:

* Cluster host (administrative privileges).
* Individual database (database privileges).
* Individual DB object, such as a table or index (privileges for database objects).

The user permissions and settings that apply in a {{ mmy-name }} cluster are common to all cluster hosts.

The permissions that apply at the level of the entire DB cluster (`PROCESS`, `REPLICATION CLIENT`, and `REPLICATION SLAVE`) are set in the [user settings](./settings-list.md#setting-administrative-privileges).

To differentiate the user permissions at the level of individual databases, each user is granted one or more _privileges_. Each privilege allows the user to perform the actions specified in the [privilege description](#db-privileges). A user is created along with a cluster and this user is granted `ALL_PRIVILEGES` in the first database of the cluster.

To manage user permissions for the [entire cluster](./settings-list.md#dbms-user-settings) or an [individual database](../operations/grant.md), use the {{ yandex-cloud }} interfaces. Changes made by SQL commands at these levels are not saved: the cluster returns to the state set through the {{ yandex-cloud }} interfaces.

To manage user permissions at the level of an individual DB object, use the `GRANT` and `REVOKE` SQL commands.

## User privileges in {{ mmy-name }} clusters {#db-privileges}

| Privilege | Description |
|:---|:---|
| `ALL_PRIVILEGES` | Allows performing any action with user data in the database and using the `SHOW SLAVE STATUS` statement. |
| `ALL` | Synonym for the `ALL_PRIVILEGES` privilege used for managing privileges via the CLI. |
| `ALTER` | Allows using the `ALTER TABLE` statement that changes the structure of any custom tables in the database. Requires `CREATE` and `INSERT` privileges. For renaming tables |
| `ALTER_ROUTINE` | Allows using the `ALTER ROUTINE` statement to change or delete any custom stored procedures and functions in the database. |
| `CREATE` | Allows using the `CREATE` statement to create use tables in the database. |
| `CREATE_ROUTINE` | Allows using the `CREATE ROUTINE` statement to create custom stored procedures and functions in the database. |
| `CREATE_TEMPORARY_TABLES` | Allows using the `CREATE TEMPORARY TABLE` statement to create temporary custom tables in the database. |
| `CREATE_VIEW` | Allows using the `CREATE VIEW` statement to create custom views in the database. |
| `DELETE` | Allows deleting records from any custom tables in the database. |
| `DROP` | Allows deleting tables and views. |
| `EVENT` | Allows you to create, change, delete, or display events in the [Event Scheduler](https://dev.mysql.com/doc/refman/8.0/en/events-overview.html). |
| `EXECUTE` | Allows executing any custom stored procedures and functions. |
| `INDEX` | Allows you to create and delete indexes from existing tables in the database. |
| `INSERT` | Allows inserting records into custom DB tables. |
| `LOCK_TABLES` | Allows the explicit use of the `LOCK_TABLES` statement to create table locks in the database. |
| `REFERENCES` | Enables you to create `FOREIGN KEYS` for DB tables. |
| `SELECT` | Allows you to read data from DB tables. |
| `SHOW_VIEW` | Allows using the `SHOW CREATE VIEW` statement. |
| `TRIGGER` | Allows you to create, delete, execute, or display triggers for existing DB tables. |
| `UPDATE` | Allows updating records in DB tables. |

To learn more about managing user permissions, see the [{{ MY }} documentation](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html).
