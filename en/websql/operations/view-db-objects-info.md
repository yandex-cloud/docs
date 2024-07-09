# Viewing information about database objects

The ![image](../../_assets/console-icons/folder-tree.svg) [**Connections**]({{ websql-link }}) section in [{{ websql-full-name }}]({{ websql-link }}) provides information about database objects. You can view information about the following:

* [Schema](#view-schema)
* [Table](#view-table)
* [View](#view-view)

## Viewing information about a schema {#view-schema}

1. Under ![image](../../_assets/console-icons/folder-tree.svg) [**Connections**]({{ websql-link }}), select the connection and DB.
1. Select the schema.
1. To the right of the schema name, click ![image](../../_assets/console-icons/sliders-vertical.svg).

This will open a panel with information about the schema name and its sequences, if any.

## Viewing information about a table {#view-table}

1. Under ![image](../../_assets/console-icons/folder-tree.svg) [**Connections**]({{ websql-link }}), select the connection and DB.
1. In the **Tables** group, select a table.
1. To the right of the table name, click ![image](../../_assets/console-icons/sliders-vertical.svg).

This will open a panel with information about the table name, size, and approximate number of table rows. You can also get the following information about table columns:

* Column name.
* Data type.
* Whether or not the column is a primary key.
* Whether or not the column is a foreign key.
* Whether or not the column is nullable.

If the table contains indexes or triggers, the same panel will display information about columns and indexing types, as well as trigger events.

## Viewing information about a view {#view-view}

1. Under ![image](../../_assets/console-icons/folder-tree.svg) [**Connections**]({{ websql-link }}), select the connection and DB.
1. In the **Views** group, select the view.
1. To the right of the view name, click ![image](../../_assets/console-icons/sliders-vertical.svg).

This will open a panel with information about the view name and columns:

* Column name.
* Data type.
* Whether or not the column is nullable.
