---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# Правила тарификации для {{ managed-k8s-name }}

В рамках сервиса {{ managed-k8s-name }} тарифицируется использование [мастера](concepts/index.md#master) и исходящий трафик.

Узлы тарифицируются по [правилам тарификации {{ compute-short-name }}](../compute/pricing.md).

## Цены {#prices}

### Мастер {#master}


{% include [rub.md](../_pricing/managed-kubernetes/rub.md) %}



### Исходящий трафик {#prices-traffic}


{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}


