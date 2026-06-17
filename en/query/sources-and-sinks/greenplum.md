# Working with {{ mgp-name }} databases

This section covers the basics of working with [{{ mgp-name }}](https://yandex.cloud/ru/services/managed-greenplum).

To start working with a {{ mgp-name }} database, follow these steps:
1. Create a [connection](../concepts/glossary.md#connection) containing your database access credentials.
1. [Run a query](#query) against the database.

Query example for reading data from {{ mgp-name }}:

```sql
SELECT * FROM greenplum_mdb_connection.my_table
```

Where:
* `greenplum_mdb_connection`: Your database connection name.
* `my_table`: Database table name.


## Setting up a connection {#create_connection}

To create a connection to {{ mgp-name }}:
1. In the [management console]({{ link-console-main }}), select the folder where you want to create a connection.
1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, switch to the **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}** tab.
1. Click ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. Specify the connection parameters:

   1. Under **{{ ui-key.yql.yq-connection-form.general-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}**: {{ mgp-name }} connection name.
      * **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}**: `{{ ui-key.yql.yq-connection.action_greenplum }}`.

   1. Under **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.cluster.input-label }}**: Select an existing {{ mgp-name }} cluster or create a new one.
      * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}**: Select an existing {{ mgp-name }} [service account](../../iam/concepts/users/service-accounts.md) or create a new one. Assign it the [`{{ roles.mgp.viewer }}`](../../managed-greenplum/security/index.md#mgp-viewer) role allowing it to connect to `{{ mgp-name }}` clusters.

        {% include [service accounts role](../../_includes/query/service-accounts-role.md) %}

      * **{{ ui-key.yql.yq-connection-form.database.input-label }}**: Select the database you will use when working with the {{ GP }} cluster.
      * **{{ ui-key.yql.yq-connection-form.schema.input-label }}**: Specify the [namespace](https://docs.vmware.com/en/VMware-Greenplum/7/greenplum-database/admin_guide-ddl-ddl-schema.html) you will use when working with the {{ GP }} database.
      * **{{ ui-key.yql.yq-connection-form.login.input-label }}**: Username you will use to connect to {{ GP }} databases.
      * **{{ ui-key.yql.yq-connection-form.password.input-label }}**: Password you will use to connect to {{ GP }} databases.


1. Click **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

A service account is necessary to detect {{ mgp-name }} cluster connection endpoints inside {{ yandex-cloud }}. To access data, you need a separate username and password.

{% note warning %}

First, grant network access from {{ yq-full-name }} to {{ mgp-name }} clusters. To do this, enable **Access from {{ yq-full-name }}** in your target database settings.

{% endnote %}

## Query syntax {#query}
{{ GP }} uses the following SQL syntax:

```sql
SELECT * FROM <connection>.<table_name>
```

Where:
* `<connection>`: Your database connection name.
* `<table_name>`: Database table name.

## Limits {#limits}

Working with {{ GP }} clusters comes with certain limitations.

The following limitations apply:
1. {% include [!](_includes/supported_requests.md) %}
1. Data reads are performed in a single thread via the master host ([coordinator host](https://docs.vmware.com/en/VMware-Greenplum/7/greenplum-database/admin_guide-intro-arch_overview.html)) of the {{ GP }} cluster. Massively parallel reads are not currently supported.
1. {{ yq-short-name }} uses the {{ ydb-full-name }} [type system]({{ ydb.docs }}/yql/reference/types/primitive). However, the valid value ranges for {{ ydb-short-name }} date and time types, i.e., `Date`, `Datetime`, and `Timestamp`, are often too narrow to accommodate the values of the corresponding {{ GP }} types, i.e., `date` and `timestamp`. 
Therefore, {{ yq-short-name }} returns date and time values read from {{ GP }} as plain strings (`Optional<Utf8>`) in [ISO-8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.

## Filter pushdown {#predicate_pushdown}

{% include [!](_includes/predicate_pushdown_preamble.md) %}

{% include [!](_includes/predicate_pushdown_examples.md) %}

Supported data types for filter pushdown:

|{{ yq-full-name }} data type|
|----|
|`Bool`|
|`Int8`|
|`Int16`|
|`Int32`|
|`Int64`|
|`Float`|
|`Double`|

## Supported data types {#supported_types}

In {{ GP }} databases, the column nullability flag, i.e., whether or not the column can contain `NULL` values, is not part of the type system. The `NOT NULL` constraint for each column is implemented via an `attnotnull` attribute in the [pg_attribute](https://docs.vmware.com/en/VMware-Greenplum/7/greenplum-database/ref_guide-system_catalogs-pg_attribute.html) system catalog, i.e., at the table metadata level. Therefore, all {{ GP }} base types may contain `NULL` values by default, and within the {{ yq-short-name }} type system they must be mapped to [optional]({{ ydb.docs }}/yql/reference/types/optional) types. 

The table below shows the mapping of {{ GP }} types to {{ yq-full-name }} types. Only the listed types are supported.

| {{ GP }} data type | {{ yq-full-name }} data type | Notes |
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
| `character` | `Optional<Utf8>` | Default collation rules apply. The string is padded with spaces to the required length. |
| `character varying` | `Optional<Utf8>` | Default collation rules apply. |
| `text` | `Optional<Utf8>` | Default collation rules apply. |
| `json` | `Optional<Json>` | |