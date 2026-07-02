# Working with {{ mmy-name }} databases

This section covers the basics of working with [{{ mmy-name }}](https://yandex.cloud/ru/services/managed-mysql).

To start working with a {{ mmy-name }} database, follow these steps:
1. Create a [connection](../concepts/glossary.md#connection) containing your database access credentials.
1. [Run a query](#query) against the database.

Query example for reading data from {{ mmy-name }}:

```sql
SELECT * FROM mysql_mdb_connection.my_table
```

Where:
* `mysql_mdb_connection`: Your database connection name.
* `my_table`: Database table name.


## Setting up a connection {#create_connection}

To create a connection to {{ mmy-name }}:
1. In the [management console]({{ link-console-main }}), select the folder where you want to create a connection.
1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, switch to the **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}** tab.
1. Click ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. Specify the connection settings:

   1. Under **{{ ui-key.yql.yq-connection-form.general-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}**: {{ mmy-name }} connection name.
      * **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}**: `{{ ui-key.yql.yq-connection.action_mysql }}`.

   1. Under **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.cluster.input-label }}**: Select an existing {{ mmy-name }} cluster or create a new one.
      * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}**: Select an existing {{ mmy-name }} [service account](../../iam/concepts/users/service-accounts.md) or create a new one. Assign it the [`{{ roles.mmy.viewer }}`](../../managed-mysql/security/index.md#managed-mysql-viewer) role allowing it to connect to `{{ mmy-name }}` clusters.

        {% include [service accounts role](../../_includes/query/service-accounts-role.md) %}

      * **{{ ui-key.yql.yq-connection-form.database.input-label }}**: Select the database you will use when working with the {{ MY }} cluster.
      * **{{ ui-key.yql.yq-connection-form.login.input-label }}**: Username you will use to connect to {{ MY }} databases.
      * **{{ ui-key.yql.yq-connection-form.password.input-label }}**: Password you will use to connect to {{ MY }} databases.


1. Click **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

A service account is necessary to detect {{ mmy-name }} cluster connection endpoints inside {{ yandex-cloud }}. To access data, you need a separate username and password.

{% note warning %}

First, grant network access from {{ yq-full-name }} to {{ mmy-name }} clusters. To do this, enable **Access from {{ yq-full-name }}** in your target database settings.

{% endnote %}

## Query syntax {#query}
{{ MY }} uses the following SQL syntax:

```sql
SELECT * FROM <connection>.<table_name>
```

Where:
* `<connection>`: Your database connection name.
* `<table_name>`: Database table name.

## Limitations {#limits}

Working with {{ MY }} clusters comes with certain limitations.

* {% include [!](_includes/supported_requests.md) %}
* {{ yq-short-name }} uses the {{ ydb-full-name }} [type system]({{ ydb.docs }}/yql/reference/types/primitive). However, the valid value ranges for {{ ydb-short-name }} date and time types, i.e., `Date`, `Datetime`, and `Timestamp`, are often too narrow to accommodate the values of the corresponding {{ MY }} types, i.e., `date`, `datetime`, and `timestamp`. Therefore, {{ yq-short-name }} returns date and time values read from {{ MY }} as plain strings (`Optional<Utf8>`) in [ISO-8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.

## Filter pushdown {#predicate_pushdown}

{% include [!](_includes/predicate_pushdown_preamble.md) %}

{% include [!](_includes/predicate_pushdown_examples.md) %}

Supported data types for filter pushdown:

|{{ yq-full-name }} data type|
|----|
|`Bool`|
|`Int8`|
|`Uint8`|
|`Int16`|
|`Uint16`|
|`Int32`|
|`Uint32`|
|`Int64`|
|`Uint64`|
|`Float`|
|`Double`|

## Supported data types {#supported_types}

In MySQL databases, the column nullability flag, i.e., whether or not the column can contain `NULL` values, is not part of the type system. The `NOT NULL` constraint for any column of any table is stored as an `IS_NULLABLE` value in the [INFORMATION_SCHEMA.COLUMNS](https://dev.mysql.com/doc/refman/8.4/en/information-schema-columns-table.html) system table, i.e., at the table metadata level. Therefore, all {{ MY }} base types may contain `NULL` values by default, and within the {{ yq-short-name }} type system they must be mapped to [optional]({{ ydb.docs }}/yql/reference/types/optional) types. 

The table below shows the mapping of {{ MY }} types to {{ yq-full-name }} types. Only the listed types are supported.

| {{ MY }} data type | {{ yq-full-name }} data type |
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