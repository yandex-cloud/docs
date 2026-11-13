---
title: Справочник метрик сервиса {{ at-full-name }} в {{ metrics-name }}
description: На этой странице приведен справочник метрик сервиса {{ at-name }}, поставляемых в {{ metrics-name }}.
---

# Справочник метрик {{ at-name }}

В этом разделе описаны метрики сервиса {{ at-name }}, поставляемые в [{{ metrics-name }}](../../monium/metrics/quickstart.md).

Для поиска метрик в {{ monium-name }} выберите проект каталога, в котором находится трейл: `project = folder__<идентификатор_каталога>`. Задайте метки `cluster = default` и `service = __audit-trails__`.

{% include [audit-trails](../../_includes/monitoring/metrics-ref/audit-trails.md) %}

## Что дальше {#whats-next}

* Ознакомьтесь со сценариями [настройки алертов](../tutorials/alerts-monitoring.md) {{ at-name }} в {{ monium-name }}.
