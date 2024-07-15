# Working with {{ mpg-name }} databases

This section provides the basic information about working with [{{ mpg-name }}](https://yandex.cloud/en/services/managed-postgresql).

To work with a {{ mpg-name }} database, follow these steps:
1. Create a [connection](../concepts/glossary.md#connection) containing your database connection credentials.
1. [Run a query](#query) to the database.

Example of a query for reading data from {{ mpg-name }}:

```sql
SELECT * FROM postgresql_mdb_connection.my_table
```

Where:
* `postgresql_mdb_connection`: Name of the DB connection you created.
* `my_table`: Name of the table in the database.


## Setting up a connection {#create_connection}

To create a connection to {{ mpg-name }}:
1. In the [management console]({{ link-console-main }}), select the folder where you want to create a connection.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, go to the **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}** tab.
1. Click ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. Specify the connection parameters:

   1. Under **{{ ui-key.yql.yq-connection-form.general-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}**: Name of the connection to {{ mpg-name }}.
      * **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}**: `{{ ui-key.yql.yq-connection.action_postgersql }}`.

   1. Under **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.cluster.input-label }}**: Select an existing {{ mpg-name }} cluster or create a new one.
      * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}**: Select an existing {{ mpg-name }} [service account](../../iam/concepts/users/service-accounts.md), or create a new one with the [`{{ roles.mpg.viewer }}`](../../managed-postgresql/security/index.md#mpg-viewer) role, and use it to connect to `{{ mpg-name }}` clusters.

         {% include [service accounts role](../../_includes/query/service-accounts-role.md) %}

      * **{{ ui-key.yql.yq-connection-form.database.input-label }}**: Select the database you will use when working with the {{ PG }} cluster.
      * **{{ ui-key.yql.yq-connection-form.schema.input-label }}**: Specify the [namespace](https://www.postgresql.org/docs/current/catalog-pg-namespace.html) to use when working with the {{ PG }} database.
      * **{{ ui-key.yql.yq-connection-form.login.input-label }}**: Username to use when connecting to {{ PG }} databases.
      * **{{ ui-key.yql.yq-connection-form.password.input-label }}**: User password to use when connecting to {{ PG }} databases.


1. Click **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

You need a service account to detect {{ mpg-name }} cluster connection points inside {{ yandex-cloud }}. You need a separate login/password pair to access data.

{% note warning %}

But first allow network access from {{ yq-full-name }} to {{ mpg-name }} clusters. To do this, enable **Access from {{ yq-full-name }}** in the settings of the database to which you are connecting.

{% endnote %}

## Query syntax {#query}
Here is the SQL query format used to access {{ PG }}:

```sql
SELECT * FROM <connection>.<table_name>
```

Where:
* `<connection>`: Name of the DB connection you created.
* `<table_name>`: Name of the table in the database.

## Limitations {#limits}

There are several restrictions when working with {{ PG }} clusters.

Limitations:
1. {% include [!](_includes/supported_requests.md) %}
1. {{ yq-short-name }} uses the {{ ydb-full-name }} [type system](https://ydb.tech/docs/en/yql/reference/types/primitive). However, the ranges of acceptable values for types used in {{ ydb-short-name }} for date and time operations (`Date`, `Datetime`, and `Timestamp`) often turn out to be insufficiently wide to cover the values of the relevant {{ PG }} types (`date` and `timestamp`).
Therefore, {{ yq-short-name }} returns date and time values read from {{ PG }} as plain strings (the `Optional<Utf8>` type) in [ISO-8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.

## Filter pushdown {#predicate_pushdown}

{% include [!](_includes/predicate_pushdown.md) %}

## Supported data types {#supported_types}

In a {{ PG }} DB, the optionality of column values (whether or not the column can contain `NULL` values) does not depend on the type system. The `NOT NULL` constraint for each column is implemented as the `attnotnull` attribute in the [pg_attribute](https://www.postgresql.org/docs/current/catalog-pg-attribute.html) system folder, i.e., at the table metadata level. Thus, by default, all {{ PG }} base types can contain `NULL` values and the {{ yq-short-name }} type system will represent them as [optional](https://ydb.tech/docs/en/yql/reference/types/optional) types.

The table below shows how {{ PG }} and {{ yq-full-name }} types map. All other data types except those listed are not supported.

| Data type {{ PG }} | Data type {{ yq-full-name }} | Notes |
| :---: | :---: | :--- |
| `boolean` | `Optional<Bool>` | |
| `smallint` | `Optional<Int16>` | |
| `int2` | `Optional<Int16>` | |
| `integer` | `Optional<Int32>` | |
| `int` | `Optional<Int32>` | |
| `int4` | `Optional<Int32>` | |
| `serial` | `Optional<Int32>` | |
| `serial4` | `Optional<Int32>` | |
| `bigint` | `Optional<Int64>` | |
| `int8` | `Optional<Int64>` | |
| `bigserial` | `Optional<Int64>` | |
| `serial8` | `Optional<Int64>` | |
| `real` | `Optional<Float>` | |
| `float4` | `Optional<Float>` | |
| `double precision` | `Optional<Double>` | |
| `float8` | `Optional<Double>` | |
| `date` | `Optional<Utf8>` | |
| `timestamp` | `Optional<Utf8>` | |
| `bytea` | `Optional<String>` | |
| `character` | `Optional<Utf8>` | Default [sorting rules](https://www.postgresql.org/docs/current/collation.html) apply; the string is padded with spaces to the required length. |
| `character varying` | `Utf8` | Default [sorting rules](https://www.postgresql.org/docs/current/collation.html) apply. |
| `text` | `Utf8` | Default [sorting rules](https://www.postgresql.org/docs/current/collation.html) apply. |
| `json` | `Json` | |

