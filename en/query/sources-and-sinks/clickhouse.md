# Working with {{ mch-name }} databases

This section describes the basic information about working with [{{ mch-name }}](https://cloud.yandex.ru/services/managed-clickhouse).

Example of reading data from {{ mch-name }}:

```sql
SELECT * FROM clickhouse_mdb_connection.my_table
```

Where:
* `clickhouse_mdb_connection`: Name of the established database connection.
* `my_table`: Name of the table in the database.


To work with a {{ mch-name }} database, follow these steps:
1. Create a [connection](../concepts/glossary.md#connection) containing your database connection credentials.
1. [Run a query](#query) to the database.

## Setting up a connection {#create_connection}

To create a connection to {{ mch-name }}:

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a connection.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, go to the **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}** tab.
1. Click ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. Specify the connection parameters:

   1. Under **{{ ui-key.yql.yq-connection-form.general-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}**: Name of the connection to {{ mch-name }}.
      * **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}**: `{{ ui-key.yql.yq-connection.click-house.select-item }}`.
   1. Under **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:
      * **{{ ui-key.yql.yq-connection-form.cluster.input-label }}**: Select an existing {{ mch-name }} cluster or create a new one.
      * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}**: Select an existing [service account](../../iam/concepts/users/service-accounts.md) {{ mch-name }}, or create a new one with the [`{{ roles.mch.viewer }}`](../../managed-clickhouse/security.md#managed-clickhouse-viewer) role, and use it to connect to `{{ mch-name }}` clusters.
      * **{{ ui-key.yql.yq-connection-info.database.label }}**: Select the database you will use when working with the {{ CH }} cluster.
      * **{{ ui-key.yql.yq-connection-form.login.input-label }}**: Username to use when connecting to {{ CH }} databases.
      * **{{ ui-key.yql.yq-connection-form.password.input-label }}**: User password to use when connecting to {{ CH }} databases.


1. Click **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

You need a service account to detect {{ mch-name }} cluster connection points inside {{ yandex-cloud }}. You need a separate login/password pair to access data.

{% note warning %}

But first allow network access from {{ yq-full-name }} to {{ mch-name }} clusters. To do this, enable **{{ ui-key.yacloud.mdb.forms.additional-field-yandex-query_ru }}** in the settings of the database to which you are connecting.

{% endnote %}


## Query syntax {#query}
Here is the SQL query format used to access {{ CH }}:

```sql
SELECT * FROM clickhouse_mdb_connection.<table>
```

Where:
* `clickhouse_mdb_connection`: Name of the established database connection.
* `<table>`: Name of the table in the database.

## Limitations {#limits}

There are several restrictions when working with {{ CH }} clusters.

{% note warning %}

Currently, regardless of the choice of filters for reading the {{ CH }} tables specified in the SQL query, all data from the table will be read into {{ yq-full-name }} and filters will be applied there.

{% endnote %}

Limitations:
1. No query types are supported other than the `SELECT` data read queries.
1. The maximum supported number of rows in a table is 1,000,000. If this value is exceeded, the query will terminate with an error.
1. {% include [!](_includes/datetime_limits.md) %}

## Filter pushdown {#predicate_pushdown}

{% include [!](_includes/predicate_pushdown.md) %}

## Supported data types {#supported_types}

Below is a table of correspondence between {{ CH }} types and {{ yq-full-name }} types.

| Data type {{ CH }} | Data type {{ yq-full-name }} | Notes |
|---|----|------|
| `Bool` | `BOOL` | |
| `Int8` | `INT8` | |
| `UInt8` | `UINT8` | |
| `Int16` | `INT16` | |
| `UInt16` | `UINT16` | |
| `Int32` | `INT32` | |
| `UInt32` | `UINT32` | |
| `Int64` | `INT64` | |
| `UInt64` | `UINT64` | |
| `Float32` | `FLOAT` | |
| `Float64` | `DOUBLE` | |
| `Date` | `DATE` | |
| `Datetime` | `DATETIME` | The valid date range is between 01/01/1970 00:00 and 31/12/2105 23:59 |
| `String` | `STRING` | |
| `FixedString` | `STRING` | Null `FixedString` bytes are transferred to `STRING` without changes. |

Other data types are not supported.

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
