---
editable: false
---

# Правила тарификации для {{ managed-k8s-name }}

В рамках сервиса {{ managed-k8s-name }} тарифицируется использование [мастера](concepts/index.md#master) и исходящий трафик.

Узлы тарифицируются по [правилам тарификации {{ compute-short-name }}](../compute/pricing.md).

## Цены {#prices}

### Мастер {#master}

{% list tabs %}

- За месяц работы мастера
    
    Тип мастера | Цена за месяц, вкл. НДС
    ----- | -----
    Зональный | 3 960 ₽
    Региональный | 10 008 ₽
    
- За 1 час работы мастера

    Тип мастера | Цена за 1 час, вкл. НДС
    ----- | -----
    Зональный | 5,5000 ₽
    Региональный | 13,9000 ₽
    
{% endlist %}

### Исходящий трафик {#prices-traffic}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "pre-kz" %}

{% include notitle [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}
