# Решение проблем в {{ data-transfer-name }}

В этом разделе описаны типичные проблемы, которые могут возникать при [активации](../operations/transfer.md#activate) или во время работы [трансферов](../concepts/index.md#transfer), и методы их решения.

* [{#T}](#common)
* [{#T}](#api)
* [{#T}](#network)
* [{#T}](#clickhouse)
* [{#T}](#elasticsearch)
* [{#T}](#mongodb)
* [{#T}](#mysql)
* [{#T}](#opensearch)
* [{#T}](#postgresql)
* [{#T}](#ydb)
* [{#T}](#yds)
* [{#T}](#support)

Особенности подготовки источников и приемников к трансферу описаны в [соответствующем разделе](../operations/prepare.md).

Ограничения на работу с источниками и приемниками во время работы трансфера указаны в разделе [{#T}](../operations/db-actions.md).

Вы можете запросить записи о том, что происходило с вашими ресурсами, из логов сервисов {{ yandex-cloud }}. Подробнее читайте в разделе [{#T}](../../support/request.md).

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

**Решение:** обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру с `request_id` запроса. Если вы используете `curl` для вызовов [API](../../glossary/rest-api.md), добавьте флаг `-v` для упрощения диагностики ошибки.

## Сеть {#network}

{% include [common-network](../../_includes/data-transfer/troubles/network/common-network.md) %}

{% include [ip-collision](../../_includes/data-transfer/troubles/network/ip-collision.md) %}

{% include [subnet-without-nat](../../_includes/data-transfer/troubles/network/subnet-without-nat.md) %}

{% include [blocked-ip](../../_includes/data-transfer/troubles/network/blocked-ip.md) %}

{% include [transfer-error](../../_includes/data-transfer/troubles/network/transfer-error.md) %}

## {{ CH }} {#clickhouse}

{% include [no-new-tables](../../_includes/data-transfer/troubles/no-new-tables.md) %}

{% include [no-new-tables](../../_includes/data-transfer/troubles/table-names.md) %}

## {{ ES }} {#elasticsearch}

{% include [ambiguous-object-resolution-es](../../_includes/data-transfer/troubles/elastic-opensearch/ambiguous-object-resolution-es.md) %}

{% include [duplication](../../_includes/data-transfer/troubles/elastic-opensearch/duplication.md) %}

## {{ MG }} {#mongodb}

{% include [string-size](../../_includes/data-transfer/troubles/mongodb/string-size.md) %}

{% include [object-size](../../_includes/data-transfer/troubles/mongodb/object-size.md) %}

{% include [no-tables](../../_includes/data-transfer/troubles/mongodb/no-tables.md) %}

{% include [sharded](../../_includes/data-transfer/troubles/mongodb/sharded.md) %}

{% include [timeseries](../../_includes/data-transfer/troubles/mongodb/timeseries.md) %}

## {{ MY }} {#mysql}

{% include [binlog-size](../../_includes/data-transfer/troubles/mysql/binlog-size.md) %}

{% include [no-new-tables](../../_includes/data-transfer/troubles/no-new-tables.md) %}

{% include [aws-binlog-time](../../_includes/data-transfer/troubles/mysql/aws-binlog-time.md) %}

{% include [primary-keys](../../_includes/data-transfer/troubles/primary-keys.md) %}

{% include [binlog-bytes](../../_includes/data-transfer/troubles/mysql/binlog-bytes.md) %}

{% include [drop-table-error](../../_includes/data-transfer/troubles/drop-table-error.md) %}

{% include [timezone-shift](../../_includes/data-transfer/troubles/mysql/timezone-shift.md) %}

## {{ OS }} {#opensearch}

{% include [ambiguous-object-resolution-os](../../_includes/data-transfer/troubles/elastic-opensearch/ambiguous-object-resolution-os.md) %}

{% include [duplication](../../_includes/data-transfer/troubles/elastic-opensearch/duplication.md) %}

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

{% include [deferrable-tables](../../_includes/data-transfer/troubles/postgresql/deferrable-constraints.md) %}

{% include [lock-replication](../../_includes/data-transfer/troubles/postgresql/lock-replication.md) %}

{% include [excessive-wal](../../_includes/data-transfer/troubles/postgresql/excessive-wal.md) %}

{% include [external-replication](../../_includes/data-transfer/troubles/postgresql/external-replication.md) %}

{% include [primary-keys](../../_includes/data-transfer/troubles/primary-keys.md) %}

{% include [drop-table-error](../../_includes/data-transfer/troubles/drop-table-error.md) %}


## {{ ydb-full-name }} {#ydb}

{% include [overloaded](../../_includes/data-transfer/troubles/overloaded.md) %}

## {{ yds-full-name }} {#yds}

{% include [overloaded](../../_includes/data-transfer/troubles/overloaded.md) %}



## Куда заявить о проблеме {#support}


Если проблему не удалось решить с помощью приведенных советов, обратитесь в [техническую поддержку]({{ link-console-support }}).


В обращении укажите идентификатор [трансфера](../operations/transfer.md#list) или [эндпоинта](../operations/endpoint/index.md#list); приложите информацию о [состоянии трансфера](../operations/monitoring.md).

