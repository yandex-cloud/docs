# Working with {{ mpg-name }} databases

This section describes the basic information about working with [{{ mpg-name }}](https://yandex.cloud/en/services/managed-postgresql).

Example of reading data from {{ mpg-name }}:

```sql
SELECT * FROM postgresql_mdb_connection.my_table
```

Where:
* `postgresql_mdb_connection`: Name of the created database connection.
* `my_table`: Name of the table in the database.


To work with a {{ mpg-name }} database, follow these steps:
1. Create a [connection](../concepts/glossary.md#connection) containing your database connection credentials.
1. [Run a query](#query) to the database.

## Setting up a connection {#create_connection}

To create a connection to {{ mpg-name }}:
1. In the [management console]({{ link-console-main }}), select the folder where you want to create a connection.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, go to the **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}** tab.
1. Click ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. Specify the connection parameters:

   1. Under **{{ ui-key.yql.yq-connection-form.general-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}**: Name of the connection to {{ mpg-name }}.
      * **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}**: `{{ ui-key.yql.yq-connection.postgersql.select-item }}`.

   1. Under **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.cluster.input-label }}**: Select an existing {{ mpg-name }} cluster or create a new one.
      * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}**: Select an existing {{ mpg-name }} [service account](../../iam/concepts/users/service-accounts.md), or create a new one with the [`{{ roles.mpg.viewer }}`](../../managed-postgresql/security/index.md#mpg-viewer) role, and use it to connect to `{{ mpg-name }}` clusters.
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
SELECT * FROM postgresql_mdb_connection.<table>
```

Where:
* `postgresql_mdb_connection`: Name of the created database connection.
* `<table>`: Name of the table in the database.

## Limitations {#limits}

There are several restrictions when working with {{ PG }} clusters.

Limitations:
1. No query types are supported other than the `SELECT` data read queries.
1. The maximum supported number of rows in a table is 1,000,000. If this value is exceeded, the query will terminate with an error.
1. {% include [!](_includes/datetime_limits.md) %}

## Filter pushdown {#predicate_pushdown}

{% include [!](_includes/predicate_pushdown.md) %}

## Supported data types {#supported_types}

Below is a table of correspondence between {{ PG }} types and {{ yq-full-name }} types.

| Data type {{ PG }} | Data type {{ yq-full-name }} | Notes |
|---|----|------|
| `boolean` | `BOOL` | |
| `smallint` | `INT16` | |
| `int2` | `INT16` | |
| `integer` | `INT32` | |
| `int` | `INT32` | |
| `int4` | `INT32` | |
| `serial` | `INT32` | |
| `serial4` | `INT32` | |
| `bigint` | `INT64` | |
| `int8` | `INT64` | |
| `bigserial` | `INT64` | |
| `serial8` | `INT64` | |
| `real` | `FLOAT` | |
| `float4` | `FLOAT` | |
| `double precision` | `DOUBLE` | |
| `float8` | `DOUBLE` | |
| `date` | `DATE` | The valid date range is between 01/01/1970 and 31/12/2105 |
| `timestamp` | `TIMESTAMP` | The valid date range is between 01/01/1970 00:00 and 31/12/2105 23:59 |
| `bytea` | `STRING` | |
| `character` | `UTF8` | [Default sorting rules](https://www.postgresql.org/docs/current/collation.html) apply; the string is padded with spaces to the required length |
| `character varying` | `UTF8` | [Default sorting rules](https://www.postgresql.org/docs/current/collation.html) apply |
| `text` | `UTF8` | [Default sorting rules](https://www.postgresql.org/docs/current/collation.html) apply |

Other data types are not supported.

