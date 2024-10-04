# Working with {{ mmy-name }} databases

This section provides the basic information about working with [{{ mmy-name }}](https://yandex.cloud/ru/services/managed-mysql).

To work with a {{ mmy-name }} database, follow these steps:
1. Create a [connection](../concepts/glossary.md#connection) containing your database connection credentials.
1. [Run a query](#query) to the database.

Example of a query for reading data from {{ mmy-name }}:

```sql
SELECT * FROM mysql_mdb_connection.my_table
```

Where:
* `mysql_mdb_connection`: Name of the DB connection you created.
* `my_table`: Name of the table in the database.


## Setting up a connection {#create_connection}

To create a connection to {{ mmy-name }}:
1. In the [management console]({{ link-console-main }}), select the folder where you want to create a connection.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, go to the **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}** tab.
1. Click ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. Specify the connection parameters:

   1. Under **{{ ui-key.yql.yq-connection-form.general-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}**: Name of the connection to {{ mmy-name }}.
      * **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}**: `{{ ui-key.yql.yq-connection.action_mysql }}`.

   1. Under **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.cluster.input-label }}**: Select an existing {{ mmy-name }} cluster or create a new one.
      * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}**: Select an existing {{ mmy-name }} [service account](../../iam/concepts/users/service-accounts.md), or create a new one with the [`{{ roles.mmy.viewer }}`](../../managed-mysql/security/index.md#managed-mysql-viewer) role, and use it to connect to `{{ mmy-name }}` clusters.

        {% include [service accounts role](../../_includes/query/service-accounts-role.md) %}

      * **{{ ui-key.yql.yq-connection-form.database.input-label }}**: Select the database you will use when working with the {{ MY }} cluster.
      * **{{ ui-key.yql.yq-connection-form.login.input-label }}**: Username to use when connecting to {{ MY }} databases.
      * **{{ ui-key.yql.yq-connection-form.password.input-label }}**: User password to use when connecting to {{ MY }} databases.


1. Click **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

You need a service account to detect {{ mmy-name }} cluster connection points inside {{ yandex-cloud }}. You need a separate login/password pair to access data.

{% note warning %}

But first allow network access from {{ yq-full-name }} to {{ mmy-name }} clusters. To do this, enable **Access from {{ yq-full-name }}** in the settings of the database to which you are connecting.

{% endnote %}

## Query syntax {#query}
Here is the SQL query format used to access {{ MY }}:

```sql
SELECT * FROM <connection>.<table_name>
```

Where:
* `<connection>`: Name of the DB connection you created.
* `<table_name>`: Name of the table in the database.

## Limitations {#limits}

There are several limitations when working with {{ MY }} clusters.

* {% include [!](_includes/supported_requests.md) %}
* {{ yq-short-name }} uses the {{ ydb-full-name }} [type system](https://ydb.tech/docs/ru/yql/reference/types/primitive). However, the ranges of acceptable values for types used in {{ ydb-short-name }} for date and time operations (`Date`, `Datetime`, and `Timestamp`) often turn out to be insufficiently wide to cover the values of the relevant {{ MY }} types (`date`, `datetime`, and `timestamp`). Therefore, {{ yq-short-name }} returns date and time values read from {{ MY }} as plain strings (the `Optional<Utf8>` type) in [ISO-8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.

## Filter pushdown {#predicate_pushdown}

{% include [!](_includes/predicate_pushdown.md) %}

## Supported data types {#supported_types}

In a MySQL DB, the optionality of column values (whether or not the column can contain `NULL` values) does not depend on the type system. The `NOT NULL` constraint for any column of any table is stored as a value of the `IS_NULLABLE` column in the [INFORMATION_SCHEMA.COLUMNS](https://dev.mysql.com/doc/refman/8.4/en/information-schema-columns-table.html) system table, i.e., at the table metadata level. Thus, by default, all {{ MY }} base types can contain `NULL` values and the {{ yq-short-name }} type system will represent them as [optional](https://ydb.tech/docs/ru/yql/reference/types/optional) types. 

The table below shows how {{ MY }} and {{ yq-full-name }} types map. All other data types except those listed are not supported.

| Data type {{ MY }} | Data type {{ yq-full-name }} |
| :---: | :---: |
|`bool`|`Optional<Bool>`|
|`tinyint`|`Optional<Int8>`|
|`tinyint unsigned`|`Optional<Uint8>`|
|`smallint`|`Optional<Int16>`|
|`smallint unsigned`|`Optional<Uint16>`|
|`mediumint`|`Optional<Int32>`|
|`mediumint unsigned`|`Optional<Uint32>`|
|`int`|`Optional<Int32>`|
|`int unsigned`|`Optional<Uint32>`|
|`bigint`|`Optional<Int64>`|
|`bigint unsigned`|`Optional<Uint64>`|
|`float`|`Optional<Float>`|
|`real`|`Optional<Float>`|
|`double`|`Optional<Double>`|
|`date`|`Optional<Utf8>`|
|`datetime`|`Optional<Utf8>`|
|`timestamp`|`Optional<Utf8>`|
|`tinyblob`|`Optional<String>`|
|`blob`|`Optional<String>`|
|`mediumblob`|`Optional<String>`|
|`longblob`|`Optional<String>`|
|`tinytext`|`Optional<String>`|
|`text`|`Optional<String>`|
|`mediumtext`|`Optional<String>`|
|`longtext`|`Optional<String>`|
|`char`|`Optional<Utf8>`|
|`varchar`|`Optional<Utf8>`|
|`binary`|`Optional<String>`|
|`varbinary`|`Optional<String>`|
|`json`|`Optional<Json>`|