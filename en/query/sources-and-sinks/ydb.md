# Working with {{ ydb-name }} databases

This section provides the basic information about working with [{{ ydb-name }}](https://yandex.cloud/ru/services/ydb).

To work with a {{ ydb-name }} database from {{ yq-full-name }}, follow these steps:
1. Create a [connection](../concepts/glossary.md#connection) containing your database connection credentials.
1. [Run a query](#query) to the database.

Example of a query for reading data from {{ ydb-name }}:

```sql
SELECT * FROM ydb_connection.my_table
```

Where:
* `ydb_connection`: Name of the DB connection you created.
* `my_table`: Name of the table in the database.


## Setting up a connection {#create_connection}

To create a connection to {{ ydb-name }}:

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a connection.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, go to the **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}** tab.
1. Click ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. Specify the connection parameters:

   1. Under **{{ ui-key.yql.yq-connection-form.general-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}**: Name of the connection to {{ ydb-name }}.
      * **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}**: `{{ ui-key.yql.yq-connection.action_ydb }}`.
   1. Under **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:
      * **{{ ui-key.yql.yq-connection-form.cluster.input-label }}**: Select an existing {{ ydb-name }} database or create a new one.
      * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}**: Select the {{ ydb-name }} [service account](../../iam/concepts/users/service-accounts.md) to use for connecting to `{{ ydb-name }}` clusters and database authentication. If you do not have a service account, create one and assign the `ydb.viewer` [role](../../ydb/security/index.md#ydb-viewer) to it.

        {% include [service accounts role](../../_includes/query/service-accounts-role.md) %}


1. Click **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

## Query syntax {#query}

Here is the SQL query format used to access {{ ydb-name }}:

```sql
SELECT * FROM <connection>.<table_name>
```

Where:
* `<connection>`: Name of the DB connection you created.
* `<table_name>`: Name of the table in the database.

## Limitations {#limits}

{% include [!](_includes/supported_requests.md) %}

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
|`String`|
|`Utf8`|

## Supported data types {#supported_types}

The tables below show how {{ ydb-name }} and {{ yq-full-name }} data types map. Data types not listed in the tables are not supported.

### Primitive data types {#supported_types_default}

| Data type {{ ydb-name }} | Data type {{ yq-full-name }} |
| :---: | :----: |
| `Bool` | `Bool` |
| `Int8` | `Int8` |
| `Uint8` | `Uint8` |
| `Int16` | `Int16` |
| `Uint16` | `Uint16` |
| `Int32` | `Int32` |
| `Uint32` | `Uint32` |
| `Int64` | `Int64` |
| `Uint64` | `Uint64` |
| `Float` | `Float` |
| `Double` | `Double` |
| `Date` | `Date` |
| `Datetime` | `Datetime` |
| `Timestamp` | `Timestamp` |
| `String` | `String` |
| `Utf8` | `Utf8` |
| `Json` | `Json` |
| `JsonDocument` | `Json` |

### Optional data types {#supported_types_nullable}

| Data type {{ ydb-name }} | Data type {{ yq-full-name }} |
| :---: | :----: |
| `Optional<Bool>` | `Optional<Bool>` |
| `Optional<Int8>` | `Optional<Int8>` |
| `Optional<Uint8>` | `Optional<Uint8>` |
| `Optional<Int16>` | `Optional<Int16>` |
| `Optional<Uint16>` | `Optional<Uint16>` |
| `Optional<Int32>` | `Optional<Int32>` |
| `Optional<Uint32>` | `Optional<Uint32>` |
| `Optional<Int64>` | `Optional<Int64>` |
| `Optional<Uint64>` | `Optional<Uint64>` |
| `Optional<Float>` | `Optional<Float>` |
| `Optional<Double>` | `Optional<Double>` |
| `Optional<Date>` | `Optional<Date>` |
| `Optional<Datetime>` | `Optional<Datetime>` |
| `Optional<Timestamp>` | `Optional<Timestamp>` |
| `Optional<String>` | `Optional<String>` |
| `Optional<Utf8>` | `Optional<Utf8>` |
| `Optional<Json>` | `Optional<Json>` |
| `Optional<JsonDocument>` | `Optional<Json>` |