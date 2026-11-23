The left-hand panel displays information about the connection and its objects. The list of objects depends on the connection type.

## Viewing database and objects info {#view-resource-info}

### Viewing database info {#view-db-settings}

1. Select the required connection from the list in the SQL Editor.
1. Click ![image](../../../_assets/console-icons/ellipsis.svg) to the right of the database name and select ![image](../../../_assets/console-icons/sliders-vertical.svg) **Database information**.

This will bring up a panel with DB settings.

### Viewing database objects info {#view-objects}

#### Viewing schema info {#view-schema}

1. Select the required connection from the list in the SQL Editor.
1. Select the schema.
1. To the right of the schema name, click ![image](../../../_assets/console-icons/sliders-vertical.svg) **Schema information**.

This will open a panel with information about the schema name and its sequences, if any.

#### Viewing table info {#view-table}

1. Select the required connection from the list in the SQL Editor.
1. Select a table.
1. To the right of the table name, click ![image](../../../_assets/console-icons/sliders-vertical.svg) **Table information**.


This will open a panel with information about the table name, size, and approximate number of table rows. You can also get the following information about table columns:

* Column name.
* Data type.
* Whether or not the column is a primary key.
* Whether or not the column is a foreign key.
* Whether or not the column is `Nullable`.

If the table contains indexes or triggers, the same panel will display information about columns and indexing types, as well as trigger events.


## Updating connection structure {#update-connection}

1. Select the required connection from the list in the SQL Editor.
1. Click ![image](../../../_assets/console-icons/arrows-rotate-right.svg) **Update connection** to the right of the connection name.

This will update the entire hierarchy for this connection, including tables and views.

