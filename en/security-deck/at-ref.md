---
title: '{{ sd-full-name }} event reference in {{ at-full-name }}'
description: This page provides a reference for {{ sd-name }} events tracked in {{ at-name }}.
---

# {{ at-full-name }} event reference

{{ at-name }} supports tracking [control plane](../audit-trails/concepts/format.md) and [data plane](../audit-trails/concepts/format-data-plane.md) events for {{ sd-full-name }}.

The general format of the `event_type` field value is as follows:

```text
{{ at-event-prefix }}.audit.securitydeck.<module_name><event_name>
```

## Control plane event reference {#control-plane-events}

### {{ k8s }}® Security Posture Management (KSPM) {#sd-kspm}

Module name: `kspm`.

{% include [sd-kspm-events](../_includes/audit-trails/events/sd-kspm-events.md) %}

### Cloud Security Posture Management (CSPM) {#sd-cspm}

Module name: `cspm`.

{% include [sd-cspm-events](../_includes/audit-trails/events/sd-cspm-events.md) %}

### {{ sd-name }} workspaces {#sd-orchestrator}

Module name: `orchestrator`.

{% include [sd-orchestrator-events](../_includes/audit-trails/events/sd-orchestrator-events.md) %}

## Data plane event reference {#data-plane-events}

### {{ atr-name }} module {#sd-access-transparency}

Module name: `accesstransparency`.

{% include [sd-at-events-dp](../_includes/audit-trails/events/sd-at-events-dp.md) %}

### {{ alerts-name }} module {#sd-alerts}

Module name: `alerts`.

{% include [sd-alerts-events-dp](../_includes/audit-trails/events/sd-alerts-events-dp.md) %}

### {{ k8s }}® Security Posture Management (KSPM) {#sd-kspm}

Module name: `kspm`.

{% include [sd-kspm-events-dp](../_includes/audit-trails/events/sd-kspm-events-dp.md) %}
