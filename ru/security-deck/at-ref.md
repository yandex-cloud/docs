---
title: Справочник аудитных логов {{ sd-full-name }} в {{ at-full-name }}
description: На этой странице приведен справочник событий сервиса {{ sd-name }}, отслеживаемых в {{ at-name }}.
---

# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} для {{ sd-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.securitydeck.<имя_модуля><имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

### Модуль Контроль {{ k8s }}® (KSPM) {#sd-kspm}

Имя модуля — `kspm`.

{% include [sd-kspm-events](../_includes/audit-trails/events/sd-kspm-events.md) %}

### Модуль Контроль конфигурации (CSPM) {#sd-cspm}

Имя модуля — `cspm`.

{% include [sd-cspm-events](../_includes/audit-trails/events/sd-cspm-events.md) %}

### Окружения {{ sd-name }} {#sd-orchestrator}

Имя модуля — `orchestrator`.

{% include [sd-orchestrator-events](../_includes/audit-trails/events/sd-orchestrator-events.md) %}

## Справочник событий уровня сервисов {#data-plane-events}

### Модуль {{ atr-name }} {#sd-access-transparency}

Имя модуля — `accesstransparency`.

{% include [sd-at-events-dp](../_includes/audit-trails/events/sd-at-events-dp.md) %}

### Модуль {{ alerts-name }} {#sd-alerts}

Имя модуля — `alerts`.

{% include [sd-alerts-events-dp](../_includes/audit-trails/events/sd-alerts-events-dp.md) %}

### Модуль Контроль {{ k8s }}® (KSPM) {#sd-kspm}

Имя модуля — `kspm`.

{% include [sd-kspm-events-dp](../_includes/audit-trails/events/sd-kspm-events-dp.md) %}
