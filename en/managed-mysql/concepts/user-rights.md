# User permissions

The {{ MY }} DBMS controls user permissions at three levels:

* A cluster host (administrative privileges).
* An individual database (database privileges).
* An individual DB object such as a table or index (privileges for database objects).

The user permissions and settings that apply in a {{ mmy-name }} cluster are common to all cluster hosts.

The permissions that apply at the level of the entire DB cluster are set in the [user settings](./settings-list.md#setting-administrative-priveleges).

To differentiate the user permissions at the level of individual databases, each user is granted one or more _privileges_. Each privilege allows the user to perform the actions specified in the [privilege description](#db-privileges). A user is created along with a cluster and this user is granted `ALL_PRIVILEGES` in the first database of the cluster.

To manage user permissions for the [entire cluster](./settings-list.md#setting-administrative-priveleges) or an [individual database](../operations/grant.md), use the {{ yandex-cloud }} interfaces. Changes made by SQL commands at these levels are not saved: the cluster returns to the state set through the {{ yandex-cloud }} interfaces.

To manage user permissions at the level of an individual DB object, use the `GRANT` and `REVOKE` SQL commands.

## User privileges in {{ mmy-name }} clusters {#db-privileges}

- `ALL_PRIVILEGES`: Allows performing any action with custom data in the database and using the `SHOW SLAVE STATUS` statement.
- `ALL`: A synonym for the `ALL_PRIVILEGES` privilege used for managing privileges via the CLI.
- `ALTER`: Necessary to use the `ALTER TABLE` operator to change the structure of any custom tables in the database. Requires `CREATE` and `INSERT` privileges. `DROP`, `CREATE`, and `INSERT` permissions for renaming tables.
- `ALTER_ROUTINE`: Necessary to use the `ALTER ROUTINE` operator to change or delete any stored custom procedures and functions in the database.
- `CREATE`: Necessary to use the `CREATE` operator to create custom tables in the database.
- `CREATE_ROUTINE`: Necessary to use the `CREATE ROUTINE` operator to create stored custom procedures and functions in the database.
- `CREATE_TEMPORARY_TABLES`: Necessary to use the `CREATE TEMPORARY TABLE` operator to create temporary custom tables in the database.
- `CREATE_VIEW`: Necessary to use the `CREATE VIEW` operator to create custom views in the database.
- `DELETE`: Necessary to delete records from any custom tables in the database.
- `DROP`: Necessary to delete tables and views.
- `EVENT`: Necessary to create, change, delete, or display events in the [Event Scheduler](https://dev.mysql.com/doc/refman/8.0/en/events-overview.html).
- `EXECUTE`: Necessary to execute any stored custom procedures and functions.
- `INDEX`: Necessary to create and delete indexes from existing tables in the database.
- `INSERT`: Necessary to insert records into custom tables in the database.
- `LOCK_TABLES`: Allows the explicit use of the `LOCK_TABLES` operator to create table locks in the database.
- `PROCESS`: Necessary to use the `SHOW PROCESSLIST` operator and view the status of data storage systems (for example, `SHOW ENGINE INNODB STATUS`). In {{ mmy-name }}, this privilege also grants permission to read [mysql](https://dev.mysql.com/doc/refman/8.0/en/system-schema.html), [performance_schema](https://dev.mysql.com/doc/refman/8.0/en/performance-schema.html), and [sys](https://dev.mysql.com/doc/refman/8.0/en/sys-schema.html) system database tables.
- `REFERENCES`: Enables the creation of `FOREIGN KEYS` for DB tables.
- `SELECT`: Necessary to read data from tables in the database.
- `SHOW_VIEW`: Necessary to use the `SHOW CREATE VIEW` operator.
- `TRIGGER`: Necessary to create, delete, execute, or display triggers for existing tables in the database.
- `UPDATE`: Necessary to update records in tables in the database.

To learn more about managing user permissions, see the [documentation for {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html).
