# Решение проблем в {{ data-transfer-name }}

В этом разделе описаны типичные проблемы, которые могут возникать при [активации](../operations/transfer.md#activate) или во время работы [трансферов](../concepts/index.md#transfer), и методы их решения.

* [Проблемы, возникающие при работе с сервисом {{ data-transfer-name }}](#overview)
* [Общие](#common)
* [Ошибки, отображаемые на временной шкале](#timeline)
* [Трансформация данных](#data-transform)
* [Ошибки в API](#api)
* [Сеть](#network)
* [{{ CH }}](#clickhouse)
* [{{ ES }}](#elasticsearch)
* [{{ MG }}](#mongodb)
* [{{ MY }}](#mysql)
* [{{ objstorage-name }}](#object-storage)
* [{{ OS }}](#opensearch)
* [{{ PG }}](#postgresql)
* [{{ ydb-full-name }}](#ydb)
* [{{ yds-full-name }}](#yds)
* [Куда заявить о проблеме](#support)

## Проблемы, возникающие при работе с сервисом {{ data-transfer-name }} {#overview}
Чтобы вовремя обнаружить проблему:

1. Следите за состоянием трансфера на вкладке **{{ ui-key.yacloud.data-transfer.label_monitoring }}** страницы управления трансфером или в сервисе [{{ monitoring-full-name }}](../../monitoring/concepts/index.md).
1. [Настройте алерты](../operations/monitoring.md#monitoring-integration) в сервисе {{ monitoring-full-name }} для получения уведомлений о сбоях в работе трансфера.
1. [Запрашивайте](../../support/request.md) записи о том, что происходило с вашими ресурсами, из логов сервисов {{ yandex-cloud }}.
1. Используйте [мобильное приложение](/mobile-app) {{ yandex-cloud }} для отслеживания состояния трансферов.

Если при переносе данных работа сервиса {{ data-transfer-name }} была нарушена, попробуйте локализовать и проанализировать проблему. Часть решений приводится в этой статье или других разделах документации.

| Источник проблемы | Проблема | Решение |
|-------------------|----------|---------|
| Эндпоинт | Отсутствие сетевой доступности или прав доступа к эндпоинту | Проверьте чтение из источника с помощью графиков: [Maximum data transfer delay](../operations/monitoring.md#sinker.pusher.time.row_max_lag_sec), [Number of source events](../operations/monitoring.md#publisher.data.changeitems) и [Reads](../operations/monitoring.md#publisher.data.bytes).</br>Проверьте запись в приемник с помощью графиков: [Maximum data transfer delay](../operations/monitoring.md#sinker.pusher.time.row_max_lag_sec), [Number of source events](../operations/monitoring.md#publisher.data.changeitems), [Number of target events](../operations/monitoring.md#sinker.pusher.data.changeitems) и [Reads](../operations/monitoring.md#publisher.data.bytes).</br>Если данные читаются и записываются, проверьте [ограничения на работу с СУБД](../operations/transfer.md).</br>Уточните требования для [подготовки](../operations/prepare.md) и [настройки](../operations/index.md) эндпоинта.</br>Поищите уже готовое [решение проблемы](#common). |
| Эндпоинт или трансфер | Недостаток физических ресурсов трансфера или эндпоинтов | Если данные читаются и записываются, проверьте, достаточно ли физических ресурсов на графиках: [CPU](../operations/monitoring.md#proc.cpu%7Cproc.guarantee.cpu) и [RAM](../operations/monitoring.md#proc.ram%7Cproc.guarantee.mem).</br>Ознакомьтесь с рекомендациями по диагностике СУБД. Например, [{{ MY }}](../../managed-mysql/operations/performance-diagnostics.md), [{{ MG }}](../../storedoc/operations/performance-diagnostics.md) или [{{ PG }}](../../managed-postgresql/operations/performance-diagnostics.md). |
| Данные | Неактуальные данные из-за изменений в схеме данных | Ознакомьтесь с различными сценариями передачи данных в разделе [Практические руководства {{ data-transfer-name }}](../tutorials/index.md). |
| Данные | Неактуальные данные из-за большого объема данных | Увеличьте количество воркеров для [параллельного копирования](../concepts/sharded.md) или [репликации](../operations/transfer.md#create).</br>Разделите таблицы на несколько трансферов. |

После устранения проблемы, в зависимости от статуса трансфера, активируйте его или измените ограничения передачи данных работающего трансфера.

![image](../../_assets/data-transfer/restore-transfer.svg)

## Общие {#common}

{% include [long-time](../../_includes/data-transfer/troubles/long-time.md) %}

{% include [increment-copy](../../_includes/data-transfer/troubles/increment-copy.md) %}

{% include [duplicates](../../_includes/data-transfer/troubles/duplicates.md) %}

{% include [insufficiency-resources](../../_includes/data-transfer/troubles/insufficiency-resources.md) %}

{% include [permission-denied](../../_includes/data-transfer/troubles/permission-denied.md) %}

{% include [unable-to-parse-obj](../../_includes/data-transfer/troubles/unable-to-parse-obj.md) %}

{% include [failed-to-connect](../../_includes/data-transfer/troubles/failed-to-connect.md) %}

{% include [no-alive-hosts](../../_includes/data-transfer/troubles/no-alive-hosts.md) %}

{% include [operation-canceled](../../_includes/data-transfer/troubles/operation-canceled.md) %}

{% include [unknown-user](../../_includes/data-transfer/troubles/unknown-user.md) %}


{% include [no-such-host](../../_includes/data-transfer/troubles/no-such-host.md) %}

### Снижение скорости трансфера {#speed-degrade}

**Проблема**:

{% include [speed-degrade](../../_includes/data-transfer/speed-degrade.md) %}

**Решение**:

Используйте политику очистки `Drop` или `Truncate`.


{% include [required-role](../../_includes/data-transfer/troubles/required-roles.md) %}


## Ошибки, отображаемые на временной шкале трансфера {#timeline}

{% include [no-items-in-memory](../../_includes/data-transfer/troubles/timeline/no-items-in-memory.md) %}

{% include [transfer-time-sound](../../_includes/data-transfer/troubles/timeline/transfer-time-sound.md) %}

{% include [row-max-lag-constant](../../_includes/data-transfer/troubles/timeline/row-max-lag-constant.md) %}

{% include [replication-restarts](../../_includes/data-transfer/troubles/timeline/replication-restarts.md) %}

## Трансформация данных {#data-transform}

{% include [required-role](../../_includes/data-transfer/troubles/data-transformation/filtr-append-only-sources.md) %}

## Ошибки в API {#api}

### "code": 13 {#code13}

Пример ошибки:

```text
{"code": 13, "message": "internal"}
```

**Решение**: обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру с `request_id` запроса. Если вы используете `curl` для вызовов [API](../../glossary/rest-api.md), добавьте флаг `-v` для упрощения диагностики ошибки.


## Сеть {#network}

{% include [connection-refused](../../_includes/data-transfer/troubles/network/connection-refused.md) %}

{% include [failed-to-connect-to](../../_includes/data-transfer/troubles/network/failed-to-connect-to.md) %}

{% include [common-network](../../_includes/data-transfer/troubles/network/common-network.md) %}

{% include [ip-collision](../../_includes/data-transfer/troubles/network/ip-collision.md) %}

{% include [subnet-without-nat](../../_includes/data-transfer/troubles/network/subnet-without-nat.md) %}

{% include [blocked-ip](../../_includes/data-transfer/troubles/network/blocked-ip.md) %}

{% include [transfer-error](../../_includes/data-transfer/troubles/network/transfer-error.md) %}


{% include [vpc-user](../../_includes/data-transfer/troubles/network/vpc-user.md) %}


{% include [connection-timed-out](../../_includes/data-transfer/troubles/network/connection-timed-out.md) %}

## {{ CH }} {#clickhouse}

{% include [no-new-tables](../../_includes/data-transfer/troubles/clickhouse/no-new-tables.md) %}

{% include [ssl-is-required](../../_includes/data-transfer/troubles/clickhouse/ssl-is-required.md) %}

{% include [table-names](../../_includes/data-transfer/troubles/clickhouse/table-names.md) %}

{% include [date-range](../../_includes/data-transfer/troubles/clickhouse/date-range.md) %}

{% include [pod-restarted](../../_includes/data-transfer/troubles/clickhouse/pod-restarted.md) %}

{% include [max-partitions](../../_includes/data-transfer/troubles/clickhouse/max-partitions.md) %}

{% include [no-tables-found](../../_includes/data-transfer/troubles/clickhouse/no-tables.md) %}

{% include [ch-ch-no-sharding](../../_includes/data-transfer/troubles/clickhouse/ch-ch-no-sharding.md) %}

## {{ ES }} {#elasticsearch}


{% include [ambiguous-object-resolution-es](../../_includes/data-transfer/troubles/elastic-opensearch/ambiguous-object-resolution-es.md) %}

{% include [duplication](../../_includes/data-transfer/troubles/elastic-opensearch/duplication.md) %}

{% include [elastic-version](../../_includes/data-transfer/troubles/elastic-opensearch/elastic-version.md) %}


## {{ MG }} {#mongodb}


{% include [string-size](../../_includes/data-transfer/troubles/mongodb/string-size.md) %}

{% include [object-size](../../_includes/data-transfer/troubles/mongodb/object-size.md) %}

{% include [no-tables](../../_includes/data-transfer/troubles/mongodb/no-tables.md) %}

{% include [sharded](../../_includes/data-transfer/troubles/mongodb/sharded.md) %}

{% include [timeseries](../../_includes/data-transfer/troubles/mongodb/timeseries.md) %}

{% include [cluster configuration](../../_includes/data-transfer/troubles/mongodb/cluster-configuration.md) %}

{% include [history lost](../../_includes/data-transfer/troubles/mongodb/history-lost.md) %}

{% include [cannot-get-delimiters](../../_includes/data-transfer/troubles/mongodb/cannot-get-delimiters.md) %}

{% include [invalid-length](../../_includes/data-transfer/troubles/mongodb/invalid-length.md) %}

## {{ MY }} {#mysql}

{% include [binlog-size](../../_includes/data-transfer/troubles/mysql/binlog-size.md) %}

{% include [no-new-tables](../../_includes/data-transfer/troubles/no-new-tables.md) %}

{% include [aws-binlog-time](../../_includes/data-transfer/troubles/mysql/aws-binlog-time.md) %}

{% include [primary-keys](../../_includes/data-transfer/troubles/primary-keys.md) %}

{% include [binlog-bytes](../../_includes/data-transfer/troubles/mysql/binlog-bytes.md) %}

{% include [binlog-position](../../_includes/data-transfer/troubles/mysql/binlog-position.md) %}

{% include [drop-table-error](../../_includes/data-transfer/troubles/drop-table-error.md) %}

{% include [timezone-shift](../../_includes/data-transfer/troubles/mysql/timezone-shift.md) %}

{% include [no-tables-found](../../_includes/data-transfer/troubles/mysql/no-tables.md) %}

## {{ objstorage-name }} {#object-storage}

{% include [update-not-supported](../../_includes/data-transfer/troubles/object-storage/update-not-supported.md) %}

## {{ OS }} {#opensearch}

{% include [ambiguous-object-resolution-os](../../_includes/data-transfer/troubles/elastic-opensearch/ambiguous-object-resolution-os.md) %}

{% include [exceeding-fields-limit](../../_includes/data-transfer/troubles/elastic-opensearch/exceeding-fields-limit.md) %}

{% include [duplication](../../_includes/data-transfer/troubles/elastic-opensearch/duplication.md) %}

{% include [mapper-parsing-exception](../../_includes/data-transfer/troubles/elastic-opensearch/mapper-parsing-exception.md) %}

{% include [ssl-is-required](../../_includes/data-transfer/troubles/elastic-opensearch/ssl-is-required.md) %}

{% include [no-tables](../../_includes/data-transfer/troubles/elastic-opensearch/no-tables.md) %}

## {{ PG }} {#postgresql}

{% include [no-tables](../../_includes/data-transfer/troubles/postgresql/no-tables.md) %}

{% include [master-trans-stop](../../_includes/data-transfer/troubles/postgresql/master-trans-stop.md) %}

{% include [conn-duration-quota](../../_includes/data-transfer/troubles/postgresql/conn-duration-quota.md) %}

{% include [conn-limit](../../_includes/data-transfer/troubles/postgresql/conn-limit.md) %}

{% include [view](../../_includes/data-transfer/troubles/postgresql/view.md) %}

{% include [constraint](../../_includes/data-transfer/troubles/postgresql/constraint.md) %}

{% include [schema](../../_includes/data-transfer/troubles/postgresql/schema.md) %}

{% include [extension functions](../../_includes/data-transfer/troubles/postgresql/extension-functions.md) %}

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

{% include [duplicate-key](../../_includes/data-transfer/troubles/duplicate-key.md) %}

{% include [drop-table-error](../../_includes/data-transfer/troubles/drop-table-error.md) %}

{% include [generated-columns](../../_includes/data-transfer/troubles/generated-columns.md) %}

## {{ ydb-full-name }} {#ydb}

{% include [overloaded](../../_includes/data-transfer/troubles/overloaded.md) %}

## {{ yds-full-name }} {#yds}

{% include [overloaded](../../_includes/data-transfer/troubles/overloaded.md) %}

{% include [redirects](../../_includes/data-transfer/troubles/data-streams/data-streams-redirects.md) %}


## Куда заявить о проблеме {#support}

Если проблему не удалось решить с помощью приведенных советов, обратитесь в [техническую поддержку]({{ link-console-support }}).

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
