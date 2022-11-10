---
editable: false
---

# Квоты и лимиты в {{ interconnect-name }}

## {{ interconnect-full-name }}

В сервисе {{ interconnect-full-name }} действуют следующие ограничения:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

{% include [interconnect-limits.md](../../_includes/interconnect-limits.md) %}

{% note warning "Важно" %}

При превышении лимита количества полученных префиксов BGP-сессия будет разорвана на 30 минут.

Рекомендуем настроить [алертинг](../../monitoring/operations/alert/create-alert.md) на [метрику](user-metrics.md) `ipv4_announces_received_by_cloud_num` и установить пороги срабатывания, чтобы не допустить разрыва BGP-сессии при внезапном превышении числа префиксов.

{% endnote %}