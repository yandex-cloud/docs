# Решение проблем

В этом разделе описаны типичные проблемы, которые могут возникать при [активации](../operations/transfer.md#activate) или во время работы [трансферов](../concepts/index.md#transfer), и методы их решения.

Особенности подготовки источников и приемников к трансферу описаны в [соответствующем разделе](../operations/prepare.md).

Ограничения на работу с источниками и приемниками во время работы трансфера указаны в разделе [{#T}](../operations/db-actions.md).

## Общие {#common}

{% include [long-time](../../_includes/data-transfer/troubles/long-time.md) %}

{% include [duplicates](../../_includes/data-transfer/troubles/duplicates.md) %}

{% include [insufficiency-resources](../../_includes/data-transfer/troubles/insufficiency-resources.md) %}

{% include [permission-denied](../../_includes/data-transfer/troubles/permission-denied.md) %}

## Ошибки в API {#api}

Пример ошибки:

```text
{"code": 13, "message": "internal"}
```

**Решение:** обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру с `request_id` запроса. Если вы используете `curl` для вызовов API, добавьте флаг `-v` для упрощения диагностики ошибки.

## Сеть {#network}

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

{% include [aws-binlog-time](../../_includes/data-transfer/troubles/mysql/aws-binlog-time.md) %}

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

