---
editable: false
---

# Квоты и лимиты в {{ interconnect-name }}

## {{ interconnect-full-name }}

В сервисе {{ interconnect-full-name }} действуют следующие ограничения:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

{% include [increase-quotas.md](../../_includes/increase-quotas.md) %}

{% include [interconnect-limits.md](../../_includes/interconnect-limits.md) %}

{% note warning "Важно" %}

При превышении лимита количества полученных префиксов BGP-сессия будет разорвана на 30 минут.

Для предотвращения разрыва BGP-сессии при внезапном превышении числа префиксов рекомендуется в сервисе мониторинга настроить [уведомление](../../monitoring/operations/alert/create-alert.md) для [метрики](monitoring.md#private-metrics) `ipv4_announces_received_by_cloud_num` и установить для нее порог срабатывания с отправкой уведомления.

{% endnote %}
