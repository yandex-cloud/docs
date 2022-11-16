---
editable: false
---

# Pricing for {{ managed-k8s-name }}

{% if product == "cloud-il" %}

{% note info %}

The prices listed below will take effect when {{ managed-k8s-name }} [becomes public](../overview/concepts/launch-stages.md) (the date will be announced later). Until then, the service can be used free of charge.

{% endnote %}

{% endif %}

{% if product == "yandex-cloud" %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% endif %}

In {{ managed-k8s-name }}, you're charged for using [masters](concepts/index.md#master) and outgoing traffic.

Nodes are charged according to [pricing for {{ compute-full-name }}](../compute/pricing.md).

## Pricing{% if product == "cloud-il" %} (after the service becomes public){% endif %} {#prices}

### Master {#master}

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

### Outgoing traffic {#prices-traffic}

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