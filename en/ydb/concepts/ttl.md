---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Time to Live (TTL)

This section describes how the TTL mechanism works and what its limits are. It also gives examples of commands and code snippets that can be used to enable, configure, and disable TTL.

## How it works {#how-it-works}

{{ ydb-short-name }} lets you specify a table column (TTL column), whose values set the lifetime of items. TTL automatically deletes the item from your table once the specified number of seconds passes after the time set in the TTL column.

{% note warning %}

An item with the `NULL` value in the TTL column is never deleted.

{% endnote %}

The timestamp for deleting a table item is determined by the formula:

```
expiration_time = valueof(ttl_column) + expire_after_seconds
```

{% note info %}

TTL doesn't guarantee that the item will be deleted exactly at `expiration_time`, it might happen later. If it's important to exclude logically obsolete but not yet physically deleted items from the selection, use request-level filtering.

{% endnote %}

Data is deleted by the *Background Removal Operation* (*BRO*), consisting of two stages:

1. Checking the values in the TTL column.
2. Deleting expired data.

*The BRO* has the following properties:

* The concurrency unit is a [table shard](./datamodel.md#sharding).
* For tables without [secondary indexes](./secondary_indexes.md), blind deletes are performed. This means that if the TTL column value is updated in-between stages 1 and 2 (for example, with an `UPDATE` request), the updated value is not rechecked.
* For tables with secondary indexes, the delete stage is a [distributed transaction](./transactions.md#distributed-tx).

## Guarantees {#guarantees}

* At every point in time, a *BRO* is run in no more than 1 instance per table.
* *BROs* are run no more than once per hour for the same shard.
* For tables with secondary indexes, data consistency is guaranteed.

## Limits {#restrictions}

* The TTL column must be of one of the following types:
  - `Date`
  - `Datetime`
  - `Timestamp`
* You can't specify multiple TTL columns.
* You can't delete the TTL column. However, if this is required, you should first [disable TTL](#disable) for the table.

## Configuration {#setting}

Currently, you can manage TTL settings using:

* [{{ ydb-short-name }} console client](../quickstart/examples-ydb-cli.md).
* [{{ ydb-short-name }} Python SDK](https://github.com/yandex-cloud/ydb-python-sdk).

### Enabling TTL for an existing table {#enable-on-existent-table}

In the example below, the items of the `mytable` table will be deleted an hour after the time set in the `created_at` column:

{% list tabs %}

- CLI

  ```bash
  $ ydb -e <endpoint> -d <database> table ttl set --column created_at --expire-after 3600 mytable
  ```

- Python

  ```python
  session.alter_table('mytable', set_ttl_settings=ydb.TtlSettings().with_date_type_column('created_at', 3600))
  ```

{% endlist %}

### Enabling TTL for a newly created table {#enable-for-new-table}

For a newly created table, you can pass TTL settings along with the table description:

{% list tabs %}

- Python

  ```python
  session.create_table(
      'mytable',
      ydb.TableDescription()
      .with_column(ydb.Column('id', ydb.OptionalType(ydb.DataType.Uint64)))
      .with_column(ydb.Column('expire_at', ydb.OptionalType(ydb.DataType.Timestamp)))
      .with_primary_key('id')
      .with_ttl(ydb.TtlSettings().with_date_type_column('expire_at'))
  )
  ```

{% endlist %}

### Disabling TTL {#disable}

{% list tabs %}

- CLI

  ```bash
  $ ydb -e <endpoint> -d <database> table ttl drop mytable
  ```

- Python

  ```python
  session.alter_table('mytable', drop_ttl_settings=True)
  ```

{% endlist %}

