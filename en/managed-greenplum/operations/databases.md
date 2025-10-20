# Managing databases in {{ mgp-name }}

{{ mgp-name }} allows you to manage cluster databases using only SQL queries.

A database can be modified or deleted only by its owner.

## Getting a list of cluster databases {#list-db}

The list of databases is available to all [users](../concepts/cluster-users.md).

{% list tabs group=instructions %}

- SQL {#sql}

  To get the list of databases in a cluster, run this command:

  ```sql
  SELECT * FROM pg_database ORDER BY datname;
  ```

{% endlist %}

## Creating a database {#add-db}

To create a database, a role with the `CREATEDB` attribute is required.

{% list tabs group=instructions %}

- SQL {#sql}

  To create a database, run this command:

  ```sql
  CREATE DATABASE <DB_name> <parameter_name> <parameter_value>;
  ```

  There can be several `parameter name: parameter value` pairs.

  Available parameters:

  * `TEMPLATE`: Database template. All the DB contents specified in the `TEMPLATE` parameter will be copied to the new database, including the data tables. The default value is `template1`.
  * `CONNECTION LIMIT`: Maximum number of connections.

  [For more information about the available parameters, see the official {{ GP }} documentation](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-sql_commands-CREATE_DATABASE.html).

  >For example, to create a database named `db1` that can process a maximum of 55 active connections, run this command:
  >```sql
  >CREATE DATABASE db1 CONNECTION LIMIT 55;
  >```

{% endlist %}

## Creating a database copy {#copy-db}

Creating a database copy requires a role with the `CREATEDB` attribute.

{% list tabs group=instructions %}

- SQL {#sql}

  To create a copy of a database in the same cluster, run this command:

  ```sql
  CREATE DATABASE <copy_name> TEMPLATE <name_of_DB_to_copy>;
  ```

{% endlist %}

## Learning the size of a database {#db-size}

Database size info is available to all users.

{% list tabs group=instructions %}

- SQL {#sql}

  To learn the size of a database, run this command:

  ```sql
  SELECT pg_size_pretty(pg_database_size('<DB_name>'));
  ```

{% endlist %}

## Renaming a database {#rename-db}

{% list tabs group=instructions %}

- SQL {#sql}

  To rename a database, run this command:

  ```sql
  ALTER DATABASE <DB_name> RENAME TO <new_DB_name>;
  ```

{% endlist %}

## Changing the maximum number of database connections {#max-conn}

{% list tabs group=instructions %}

- SQL {#sql}

  To change the maximum number of connections, run this command:

  ```sql
  ALTER DATABASE <DB_name> CONNECTION LIMIT <new_number_of_connections>;
  ```

{% endlist %}  
  
## Changing {{ GP }} settings at the database level {#greenplum-settings}

Settings set at the database level via SQL queries override the [cluster-level](../concepts/settings-list.md) settings.

{% list tabs group=instructions %}

- SQL {#sql}

  Changing a database-level setting:

  ```sql
  ALTER DATABASE <DB_name> SET <setting_name> TO <new_setting_value>;
  ```

  Removing a database-level setting value:

  ```sql
  ALTER DATABASE <DB_name> RESET <setting_name>;
  ```

  Removing all database-level setting values:

  ```sql
  ALTER DATABASE <DB_name> RESET ALL;
  ```

  {% note info %}

  If a setting's value is removed, it will use the cluster-level value.

  {% endnote %}

{% endlist %}  

## Deleting a database {#remove-db}

Before deleting, make sure the following conditions are met:

* You are the owner of the database.
* There are no active connections to the database.
* You are connected to another database.

{% list tabs group=instructions %}

- SQL {#sql}

  To delete a database, run this command:

  ```sql
  DROP DATABASE <DB_name>;
  ```

  {% note warning %}

  Deleting a database is irreversible.

  {% endnote %}

{% endlist %}