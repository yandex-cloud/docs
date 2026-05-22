---
title: Справочник аудитных логов {{ baremetal-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ baremetal-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} для {{ baremetal-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.baremetal.<имя_события>
```

{% include [about-events-ref](../_includes/audit-trails/about-events-ref.md) %}

## Справочник событий уровня конфигурации {#control-plane-events}

{% include [baremetal-events](../_includes/audit-trails/events/baremetal-events.md) %}

## Справочник событий уровня сервисов {#data-plane-events}

{% include [compute-events-dp](../_includes/audit-trails/events/baremetal-events-dp.md) %}

### Событие flowlogs.ExternalFlow {#external-flow}

Событие `flowlogs.ExternalFlow` содержит агрегированную информацию о потоках сетевого трафика серверов {{ baremetal-name }} во внешние сети.

{% note warning %}

События `ExternalFlow` собираются на основе каждого тысячного пакета и агрегируются за пятиминутный период.

{% endnote %}

Объект `details` события `flowlogs.ExternalFlow` содержит следующие поля:

#|
|| Поле | Тип | Описание ||
|| `vers` | int64 | Версия IP-протокола: `4` — IPv4, `6` — IPv6 ||
|| `proto` | int64 | Номер транспортного протокола по [IANA](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). Например, `6` — TCP, `17` — UDP ||
|| `srcAddr` | string | IP-адрес источника ||
|| `dstAddr` | string | IP-адрес назначения ||
|| `direction` | string | Направление трафика: `INGRESS` — входящий, `EGRESS` — исходящий ||
|| `srcPort` | int64 | Порт источника ||
|| `dstPort` | int64 | Порт назначения ||
|| `aggStart` | timestamp | Время начала периода агрегации в формате [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) ||
|| `aggEnd` | timestamp | Время окончания периода агрегации в формате [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) ||
|| `packets` | int64 | Количество пакетов за период агрегации ||
|| `bytes` | int64 | Количество байт за период агрегации ||
|| `tcpFlags` | string | TCP-флаги в шестнадцатеричном формате, например `0x02` ||
|| `subnetId` | string | Идентификатор подсети ||
|| `folderId` | string | Идентификатор каталога ||
|#
