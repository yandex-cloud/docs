---
title: Working with {{ mch-full-name }} databases
description: In this tutorial, you will learn how to connect to a {{ mch-name }} database and run queries against it from {{ yq-full-name }}.
---

# Working with {{ mch-name }} databases

This section covers the basics of working with [{{ mch-name }}](https://yandex.cloud/en/services/managed-clickhouse).

To start working with a {{ mch-name }} database, follow these steps:

1. Create a [connection](../concepts/glossary.md#connection) containing your database access credentials.
1. [Run a query](#query) to the database.

Query example for reading data from {{ mch-name }}:

```sql
SELECT * FROM clickhouse_mdb_connection.my_table
```

Where:

* `clickhouse_mdb_connection`: Your database connection name.
* `my_table`: Database table name.

## Setting up a connection {#create-connection}

To create a connection to {{ mch-name }}:

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a connection.
1. [Navigate]({{ link-console-yq }}) to **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
1. Click ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. Specify the connection settings:

   1. Under **{{ ui-key.yql.yq-connection-form.general-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}**: {{ mch-name }} connection name.
      * **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}**: `{{ ui-key.yql.yq-connection.action_clickhouse }}`.
   1. Under **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.cluster.input-label }}**: Select an existing {{ mch-name }} cluster or create a new one.
      * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}**: Select an existing {{ mch-name }} [service account](../../iam/concepts/users/service-accounts.md) or create a new one. Assign it the [`{{ roles.mch.viewer }}`](../../managed-clickhouse/security.md#managed-clickhouse-viewer) role allowing it to connect to {{ mch-name }} clusters.

        {% include [service accounts role](../../_includes/query/service-accounts-role.md) %}

      * **{{ ui-key.yql.yq-connection-info.database.label }}**: Select the database you will use to work with the {{ CH }} cluster.
      * **{{ ui-key.yql.yq-connection-form.login.input-label }}**: Username you will use to connect to {{ CH }} databases.
      * **{{ ui-key.yql.yq-connection-form.password.input-label }}**: Password you will use to connect to {{ CH }} databases.

1. Click **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

You need a service account to detect {{ mch-name }} cluster connection endpoints inside {{ yandex-cloud }}. To work with data, set a username and password separately.

{% note warning %}

Allow network access from {{ yq-full-name }} to {{ mch-name }} clusters. Do it by enabling **{{ ui-key.yacloud.mdb.forms.additional-field-yandex-query_ru }}** in the target database settings.

{% endnote %}

## Query syntax {#query}

{{ CH }} uses the following SQL syntax:

```sql
SELECT * FROM <connection>.<table_name>
```

Where:

* `<connection>`: Your database connection name.
* `<table_name>`: Database table name.

## Limits {#limits}

{{ CH }} clusters are subject to the following restrictions:

1. {% include [!](_includes/supported_requests.md) %}
1. {{ yq-short-name }} uses the {{ ydb-full-name }} [type system]({{ ydb.docs }}/yql/reference/types/primitive). The available value ranges of {{ ydb-short-name }} date and time types (`Date`, `Datetime`, `Timestamp`) do not allow storing all values of relevant {{ CH }} types (`Date`, `Date32`, `DateTime`, `DateTime64`).

   Therefore, {{ yq-short-name }} returns the date and time values read from {{ CH }} as strings in [ISO-8601](https://www.iso.org/iso-8601-date-and-time-format.html) format. Regular columns use type `Utf8`; [nullable]({{ ch.docs }}{{ lang }}/sql-reference/data-types/nullable) columns use `Optional<Utf8>`.

## Filter pushdown {#predicate-pushdown}

{% include [!](_includes/predicate_pushdown_preamble.md) %}

{% include [!](_includes/predicate_pushdown_examples.md) %}

Supported data types for filter pushdown:

#|
|| **{{ yq-full-name }} data type** ||
|| `Bool` ||
|| `Int8` ||
|| `Uint8` ||
|| `Int16` ||
|| `Uint16` ||
|| `Int32` ||
|| `Uint32` ||
|| `Int64` ||
|| `Uint64` ||
|| `Float` ||
|| `Double` ||
|| `String` ||
|#

## Supported data types {#supported-types}

By default, {{ CH }} columns cannot contain `NULL`. However, you can create a table with columns of [optional (nullable)]({{ ch.docs }}{{ lang }}/sql-reference/data-types/nullable) types. The column types displayed by {{ yq-full-name }} when extracting data from an external {{ CH }} source depend on whether the {{ CH }} table uses primitive or optional types.

The tables below show type mapping between {{ CH }} and {{ yq-full-name }}. Only the listed types are supported.

### Primitive data types {#supported-types-default}

#|
|| **{{ CH }} data type** | **{{ yq-full-name }} data type** | **Notes** ||
|| `Bool` | `Bool` | ||
|| `Int8` | `Int8` | ||
|| `UInt8` | `Uint8` | ||
|| `Int16` | `Int16` | ||
|| `UInt16` | `Uint16` | ||
|| `Int32` | `Int32` | ||
|| `UInt32` | `Uint32` | ||
|| `Int64` | `Int64` | ||
|| `UInt64` | `Uint64` | ||
|| `Float32` | `Float` | ||
|| `Float64` | `Double` | ||
|| `Date` | `Utf8` | ||
|| `Date32` | `Utf8` | ||
|| `DateTime` | `Utf8` | ||
|| `DateTime64` | `Utf8` | ||
|| `String` | `String` | ||
|| `FixedString` | `String` | Null `FixedString` bytes are transferred to `String` unchanged. ||
|#

### Optional data types {#supported-types-nullable}

#|
|| **{{ CH }} data type** | **{{ yq-full-name }} data type** | **Notes** ||
|| `Nullable(Bool)` | `Optional<Bool>` | ||
|| `Nullable(Int8)` | `Optional<Int8>` | ||
|| `Nullable(UInt8)` | `Optional<Uint8>` | ||
|| `Nullable(Int16)` | `Optional<Int16>` | ||
|| `Nullable(UInt16)` | `Optional<Uint16>` | ||
|| `Nullable(Int32)` | `Optional<Int32>` | ||
|| `Nullable(UInt32)` | `Optional<Uint32>` | ||
|| `Nullable(Int64)` | `Optional<Int64>` | ||
|| `Nullable(UInt64)` | `Optional<Uint64>` | ||
|| `Nullable(Float32)` | `Optional<Float>` | ||
|| `Nullable(Float64)` | `Optional<Double>` | ||
|| `Nullable(Date)` | `Optional<Utf8>` | ||
|| `Nullable(Date32)` | `Optional<Utf8>` | ||
|| `Nullable(DateTime)` | `Optional<Utf8>` | ||
|| `Nullable(DateTime64)` | `Optional<Utf8>` | ||
|| `Nullable(String)` | `Optional<String>` | ||
|| `Nullable(FixedString)` | `Optional<String>` | Null `FixedString` bytes are transferred to `String` unchanged. ||
|#

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
