---
title: Посмотреть логи L7-балансировщика {{ alb-full-name }}
description: Как найти и просмотреть логи L7-балансировщика {{ alb-name }} в {{ monium-name }}.
alternate:
  - href: ru/application-load-balancer/operations/application-load-balancer-get-logs.md
    type: text/markdown
    title: Markdown version
---

# Посмотреть логи L7-балансировщика

{% include [monium-logs-kz-note](../../_includes/application-load-balancer/monium-logs-kz-note.md) %}

[Логи](../concepts/monitoring.md#logging) L7-балансировщика записываются в [{{ monium-logs-name }}](../../monium/logs/quickstart-resources.md). Если запись отключена, [включите ее](application-load-balancer-manage-logs.md#enable-logs).

{% include [view-logs-monium](../../_includes/application-load-balancer/view-logs-monium.md) %}
