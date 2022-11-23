---
editable: false
---

# Правила тарификации для {{ managed-k8s-name }}

{% if product == "cloud-il" %}

{% note info %}

Цены, указанные ниже, начнут действовать 6 декабря 2022 года. До этого использование сервиса {{ managed-k8s-name }} не тарифицируется

{% endnote %}

{% endif %}

В рамках сервиса {{ managed-k8s-name }} тарифицируется использование [мастера](concepts/index.md#master) и исходящий трафик.

Узлы тарифицируются по [правилам тарификации {{ compute-full-name }}](../compute/pricing.md).

## Цены{% if product == "cloud-il" %} c 6 декабря 2022 года{% endif %} {#prices}

### Мастер {#master}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include [rub.md](../_pricing/managed-kubernetes/rub.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt.md](../_pricing/managed-kubernetes/kzt.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd.md](../_pricing/managed-kubernetes/usd.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils.md](../_pricing/managed-kubernetes/ils.md) %}

{% endif %}

### Исходящий трафик {#prices-traffic}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include notitle [ils-egress-traffic.md](../_pricing/ils-egress-traffic.md) %}

{% endif %}