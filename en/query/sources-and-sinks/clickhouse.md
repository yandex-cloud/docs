# Working with {{ mch-name }} databases

This section provides the basic information about working with [{{ mch-name }}](https://yandex.cloud/en/services/managed-clickhouse).

To work with a {{ mch-name }} database, follow these steps:
1. Create a [connection](../concepts/glossary.md#connection) containing your database connection credentials.
1. [Run a query](#query) to the database.

Example of a query for reading data from {{ mch-name }}:

```sql
SELECT * FROM clickhouse_mdb_connection.my_table
```

Where:
* `clickhouse_mdb_connection`: Name of the DB connection you created.
* `my_table`: Name of the table in the database.


## Setting up a connection {#create_connection}

To create a connection to {{ mch-name }}:

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a connection.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, go to the **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}** tab.
1. Click ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. Specify the connection parameters:

   1. Under **{{ ui-key.yql.yq-connection-form.general-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}**: Name of the connection to {{ mch-name }}.
      * **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}**: `{{ ui-key.yql.yq-connection.action_clickhouse }}`.
   1. Under **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:
      * **{{ ui-key.yql.yq-connection-form.cluster.input-label }}**: Select an existing {{ mch-name }} cluster or create a new one.
      * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}**: Select an existing {{ mch-name }} [service account](../../iam/concepts/users/service-accounts.md), or create a new one with the [`{{ roles.mch.viewer }}` role](../../managed-clickhouse/security.md#managed-clickhouse-viewer), and use it to connect to `{{ mch-name }}` clusters.

        {% include [service accounts role](../../_includes/query/service-accounts-role.md) %}

      * **{{ ui-key.yql.yq-connection-info.database.label }}**: Select the database you will use when working with the {{ CH }} cluster.
      * **{{ ui-key.yql.yq-connection-form.login.input-label }}**: Username to use when connecting to {{ CH }} databases.
      * **{{ ui-key.yql.yq-connection-form.password.input-label }}**: User password to use when connecting to {{ CH }} databases.


1. Click **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

You need a service account to detect {{ mch-name }} cluster connection points inside {{ yandex-cloud }}. You need a separate login/password pair to access data.

{% note warning %}

First, allow network access from {{ yq-full-name }} to {{ mch-name }} clusters. To do this, enable **{{ ui-key.yacloud.mdb.forms.additional-field-yandex-query_ru }}** in the settings of the database to which you are connecting.

{% endnote %}


## Query syntax {#query}
Here is the SQL query format used to access {{ CH }}:

```sql
SELECT * FROM <connection>.<table_name>
```

Where:
* `<connection>`: Name of the DB connection you created.
* `<table_name>`: Name of the table in the database.

## Limitations {#limits}

Some limitations apply when working with {{ CH }} clusters.

Limitations:
1. {% include [!](_includes/supported_requests.md) %}
1. {{ yq-short-name }} uses the {{ ydb-full-name }} [type system]({{ ydb.docs }}/yql/reference/types/primitive). However, the ranges of acceptable values for types used in {{ ydb-short-name }} for date and time operations (`Date`, `Datetime`, and `Timestamp`) often turn out to be insufficiently wide to cover the values of the relevant {{ CH }} types (`Date`, `Date32`, `Datetime`, and `Datetime64`).
Therefore, {{ yq-short-name }} returns date and time values read from {{ CH }} as plain strings (the `Utf8` type for regular columns or the `Optional<Utf8>` type for [nullable](https://clickhouse.com/docs/en/sql-reference/data-types/nullable) columns) in [ISO-8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.

## Filter pushdown {#predicate_pushdown}

{% include [!](_includes/predicate_pushdown.md) %}

|Data type {{ yq-full-name }}|
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

In {{ CH }}, columns cannot physically contain the `NULL` value by default; however, the user can create a table with columns of optional or [nullable](https://clickhouse.com/docs/en/sql-reference/data-types/nullable) types. The column types {{ yq-full-name }} displays when extracting data from the external {{ CH }} source will depend on whether the {{ CH }} table uses primitive or optional types.

The tables below show how {{ CH }} and {{ yq-full-name }} types map. All other data types except those listed are not supported.

### Primitive data types {#supported_types_default}

| Data type {{ CH }} | Data type {{ yq-full-name }} | Notes |
| :---: | :----: | :--- |
| `Bool` | `Bool` | |
| `Int8` | `Int8` | |
| `UInt8` | `Uint8` | |
| `Int16` | `Int16` | |
| `UInt16` | `Uint16` | |
| `Int32` | `Int32` | |
| `UInt32` | `Uint32` | |
| `Int64` | `Int64` | |
| `UInt64` | `Uint64` | |
| `Float32` | `Float` | |
| `Float64` | `Double` | |
| `Date` | `Utf8` | |
| `Date32` | `Utf8` | |
| `DateTime` | `Utf8` | |
| `DateTime64` | `Utf8` | |
| `String` | `String` | |
| `FixedString` | `String` | Null `FixedString` bytes are transferred to `String` without changes. |

### Optional data types {#supported_types_nullable}

| Data type {{ CH }} | Data type {{ yq-full-name }} | Notes |
| :---: | :----: | :--- |
| `Nullable(Bool)` | `Optional<Bool>` | |
| `Nullable(Int8)` | `Optional<Int8>` | |
| `Nullable(UInt8)` | `Optional<Uint8>` | |
| `Nullable(Int16)` | `Optional<Int16>` | |
| `Nullable(UInt16)` | `Optional<Uint16>` | |
| `Nullable(Int32)` | `Optional<Int32>` | |
| `Nullable(UInt32)` | `Optional<Uint32>` | |
| `Nullable(Int64)` | `Optional<Int64>` | |
| `Nullable(UInt64)` | `Optional<Uint64>` | |
| `Nullable(Float32)` | `Optional<Float>` | |
| `Nullable(Float64)` | `Optional<Double>` | |
| `Nullable(Date)` | `Optional<Utf8>` | |
| `Nullable(Date32)` | `Optional<Utf8>` | |
| `Nullable(DateTime)` | `Optional<Utf8>` | |
| `Nullable(DateTime64)` | `Optional<Utf8>` | |
| `Nullable(String)` | `Optional<String>` | |
| `Nullable(FixedString)` | `Optional<String>` | Null `FixedString` bytes are transferred to `String` without changes. |

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
