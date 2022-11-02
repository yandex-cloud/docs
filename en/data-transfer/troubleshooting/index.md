# Troubleshooting

This section describes typical problems that may arise during [transfer](../operations/transfer.md#activate) [activation](../concepts/index.md#transfer) or operation, and the relevant resolution methods.

* [{#T}](#common)
* [{#T}](#api)
* [{#T}](#network)
* [{#T}](#clickhouse)
* [{#T}](#mongodb)
* [{#T}](#mysql)
* [{#T}](#postgresql)
* [{#T}](#ydb)
* [{#T}](#yds)

Key features about preparing sources and targets for a transfer are described in the [relevant section](../operations/prepare.md).

Limitations on sources and targets while a transfer is running are described in [{#T}](../operations/db-actions.md).

## General {#common}

{% include [long-time](../../_includes/data-transfer/troubles/long-time.md) %}

{% include [duplicates](../../_includes/data-transfer/troubles/duplicates.md) %}

{% include [insufficiency-resources](../../_includes/data-transfer/troubles/insufficiency-resources.md) %}

{% include [permission-denied](../../_includes/data-transfer/troubles/permission-denied.md) %}

## API errors {#api}

Error example:

```text
{"code": 13, "message": "internal"}
```

**Troubleshooting:** Contact [support]({{ link-console-support }}) or your account manager and specify `request_id`. If you're using `curl` for API calls, add the `-v` flag to facilitate error diagnostics.

## Network {#network}

{% include [ip-collision](../../_includes/data-transfer/troubles/network/ip-collision.md) %}

{% include [subnet-without-nat](../../_includes/data-transfer/troubles/network/subnet-without-nat.md) %}

{% include [blocked-ip](../../_includes/data-transfer/troubles/network/blocked-ip.md) %}

## {{ CH }} {#clickhouse}

{% include [no-new-tables](../../_includes/data-transfer/troubles/no-new-tables.md) %}

## {{ MG }} {#mongodb}

{% include [string-size](../../_includes/data-transfer/troubles/mongodb/string-size.md) %}

{% include [object-size](../../_includes/data-transfer/troubles/mongodb/object-size.md) %}

{% include [no-tables](../../_includes/data-transfer/troubles/mongodb/no-tables.md) %}

{% include [sharded](../../_includes/data-transfer/troubles/mongodb/sharded.md) %}

## {{ MY }} {#mysql}

{% include [binlog-size](../../_includes/data-transfer/troubles/mysql/binlog-size.md) %}

{% include [no-new-tables](../../_includes/data-transfer/troubles/no-new-tables.md) %}

## {{ PG }} {#postgresql}

{% include [master-trans-stop](../../_includes/data-transfer/troubles/postgresql/master-trans-stop.md) %}

{% include [conn-duration-quota](../../_includes/data-transfer/troubles/postgresql/conn-duration-quota.md) %}

{% include [view](../../_includes/data-transfer/troubles/postgresql/view.md) %}

{% include [constraint](../../_includes/data-transfer/troubles/postgresql/constraint.md) %}

{% include [schema](../../_includes/data-transfer/troubles/postgresql/schema.md) %}

{% include [low-speed](../../_includes/data-transfer/troubles/postgresql/low-speed.md) %}

{% include [successor-tables](../../_includes/data-transfer/troubles/postgresql/successor-tables.md) %}

{% include [replication-slots](../../_includes/data-transfer/troubles/postgresql/replication-slots.md) %}

{% include [no-data-transfer](../../_includes/data-transfer/troubles/postgresql/no-data-transfer.md) %}

{% include [master-change](../../_includes/data-transfer/troubles/postgresql/master-change.md) %}

{% include [inner-tables](../../_includes/data-transfer/troubles/postgresql/inner-tables.md) %}


## {{ ydb-full-name }} {#ydb}

{% include [overloaded](../../_includes/data-transfer/troubles/overloaded.md) %}

## {{ yds-full-name }} {#yds}

{% include [overloaded](../../_includes/data-transfer/troubles/overloaded.md) %}

