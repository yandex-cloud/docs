---
editable: false
---

# Правила тарификации для {{ managed-k8s-name }}

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

В рамках сервиса {{ managed-k8s-name }} тарифицируется использование [мастера](concepts/index.md#master) и исходящий трафик.

Узлы тарифицируются по [правилам тарификации {{ compute-full-name }}](../compute/pricing.md).


## Цены для региона Россия {#prices}




{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}



### Мастер {#master}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/managed-kubernetes/rub-master.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/managed-kubernetes/kzt-master.md) %}

{% endlist %}




{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}