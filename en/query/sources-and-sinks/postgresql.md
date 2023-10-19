# Working with {{ mpg-name }} databases

This section describes the basic information about working with [{{ mpg-name }}](https://cloud.yandex.ru/services/managed-postgresql).

{% include [preview](../_includes/preview.md) %}


Example of reading data from {{ mpg-name }}:

```sql
SELECT * FROM postgresql_mdb_connection.`my_db.my_table`
```

Where:
* `postgresql_mdb_connection`: Name of the created database connection.
* `my_db`: Name of the {{ PG }} database in the cluster.
* `my_table`: Name of the table in the database.


To work with a {{ mpg-name }} database, follow these steps:
1. Create a [connection](../concepts/glossary.md#connection) containing your database connection credentials.
1. [Run a query](#query) to the database.

## Setting up a connection {#create_connection}

To create a connection to {{ mpg-name }}:
1. In the [management console]({{ link-console-main }}), select the folder where you want to create a connection.
1. In the list of services, select **{{ yq-full-name }}**.
1. In the panel on the left, go to the **Connections** tab.
1. Click ![info](../../_assets/plus.svg) **Create**.
1. Specify the connection parameters:

   1. Under **General parameters**:

      * **Name**: {{ mpg-name }} connection name.
      * **Type**: `{{ mpg-name }}`.

   1. Under **Connection type parameters**:

      * **Cluster**: Select an existing {{ mpg-name }} cluster or create a new one.
      * **Service account**: Select an existing [service account](../../iam/concepts/users/service-accounts.md) in {{ mpg-name }}, or create a new service account with the [`{{ roles.mpg.viewer }}`](../../managed-postgresql/security/index.md#mpg-viewer) role, and use it to connect to `{{ mpg-name }}` clusters.
      * **Login**: Username to be used to connect to {{ PG }} databases.
      * **Password**: User password that will be used to connect to {{ PG }} databases.


1. Click **Create**.

You need a service account to detect {{ mpg-name }} cluster connection points inside {{ yandex-cloud }}. You need a separate login/password pair to access data.

{% note warning %}

You should first allow network access from {{ yq-full-name }} to {{ mpg-name }} clusters. To do this, enable "Access from Yandex Query" in the settings of the database you are connecting to.

{% endnote %}

## Query syntax {#query}
Here is the SQL query format used to access {{ PG }}:

```sql
SELECT * FROM postgresql_mdb_connection.`<db>.<table>`
```

Where:
* `postgresql_mdb_connection`: Name of the created database connection.
* `<db>`: Name of the {{ PG }} database in the cluster.
* `<table>`: Name of the table in the database.

## Restrictions {#limits}

There are several restrictions when working with {{ PG }} clusters.

{% note warning %}

Currently, regardless of the choice of filters for reading the {{ PG }} tables specified in the SQL query, all data from the table will be read into {{ yq-full-name }} and filters will be applied there.

{% endnote %}

Limitations:
1. No query types are supported other than the `SELECT` data read queries.
1. The maximum supported number of rows in a table is 1,000,000. If this value is exceeded, the query will terminate with an error.
1. {% include [!](_includes/datetime_limits.md) %}
1. When reading, the `public` [namespace](https://www.postgresql.org/docs/current/catalog-pg-namespace.html) is always used; other namespaces are not supported.


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

