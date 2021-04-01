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


{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}


