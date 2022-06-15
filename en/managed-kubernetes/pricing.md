---
editable: false
---

# Pricing for {{ managed-k8s-name }}

{% if product == "cloud-il" %}

At the [Preview](../overview/concepts/launch-stages.md) stage, the use of the {{ managed-k8s-name }} service is not charged.

{% endif %}

{% if product == "yandex-cloud" %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

In {{ managed-k8s-name }}, you're charged for using [masters](concepts/index.md#master) and outgoing traffic.

Nodes are charged according to [pricing for {{ compute-full-name }}](../compute/pricing.md).

## Pricing {#prices}

### Master {#master}

{% if region == "ru" %}

{% include [rub.md](../_pricing/managed-kubernetes/rub.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt.md](../_pricing/managed-kubernetes/kzt.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd.md](../_pricing/managed-kubernetes/usd.md) %}

{% endif %}

### Outgoing traffic {#prices-traffic}

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