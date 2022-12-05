# User permissions

The {{ MY }} DBMS controls user permissions at three levels:

* A cluster host (administrative privileges).
* An individual database (database privileges).
* An individual DB object such as a table or index (privileges for database objects).

The user permissions and settings that apply in a {{ mmy-name }} cluster are common to all cluster hosts.

The permissions that apply at the level of the entire DB cluster (`PROCESS`, `REPLICATION CLIENT`, and `REPLICATION SLAVE`) are set in the [user settings](./settings-list.md#setting-administrative-privileges).

To differentiate the user permissions at the level of individual databases, each user is granted one or more _privileges_. Each privilege allows the user to perform the actions specified in the [privilege description](#db-privileges). A user is created along with a cluster and this user is granted `ALL_PRIVILEGES` in the first database of the cluster.

To manage user permissions for the [entire cluster](./settings-list.md#dbms-user-settings) or an [individual database](../operations/grant.md), use the {{ yandex-cloud }} interfaces. Changes made by SQL commands at these levels are not saved: the cluster returns to the state set through the {{ yandex-cloud }} interfaces.

To manage user permissions at the level of an individual DB object, use the `GRANT` and `REVOKE` SQL commands.

## User privileges in {{ mmy-name }} clusters {#db-privileges}

| Privilege | Description |
|:---|:---|
| `ALL_PRIVILEGES` | Allows performing any action with custom data in the database and using the `SHOW SLAVE STATUS` statement. |
| `ALL` | A synonym for the `ALL_PRIVILEGES` privilege used for managing privileges via the CLI. |
| `ALTER` | Allows using the `ALTER TABLE` statement that changes the structure of any custom tables in the database. Requires `CREATE` and `INSERT` privileges. For renaming tables |
| `ALTER_ROUTINE` | Allows using the `ALTER ROUTINE` statement to change or delete any stored custom procedures and functions in the database. |
| `CREATE` | Allows using the `CREATE` statement to create custom tables in the database. |
| `CREATE_ROUTINE` | Allows using the `CREATE ROUTINE` statement to create stored custom procedures and functions in the database. |
| `CREATE_TEMPORARY_TABLES` | Allows using the `CREATE TEMPORARY TABLE` statement to create temporary custom tables in the database. |
| `CREATE_VIEW` | Allows using the `CREATE VIEW` statement to create custom views in the database. |
| `DELETE` | Allows deleting records from any custom tables in the database. |
| `DROP` | Allows deleting tables and views. |
| `EVENT` | Lets you create, change, delete, or display events in the [Event Scheduler](https://dev.mysql.com/doc/refman/8.0/en/events-overview.html). |
| `EXECUTE` | Allows executing any stored custom procedures and functions. |
| `INDEX` | Lets you create and delete indexes from existing tables in the database. |
| `INSERT` | Allows inserting records into custom DB tables. |
| `LOCK_TABLES` | Allows the explicit use of the `LOCK_TABLES` statement to create table locks in the database. |
| `REFERENCES` | Enables the creation of `FOREIGN KEYS` for DB tables. |
| `SELECT` | Lets you read data from DB tables. |
| `SHOW_VIEW` | Allows using the `SHOW CREATE VIEW` statement. |
| `TRIGGER` | Lets you create, delete, execute, or display triggers for existing DB tables. |
| `UPDATE` | Allows updating records in DB tables. |

To learn more about managing user permissions, see the [documentation for {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html).
