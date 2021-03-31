---
editable: false
---
# Pricing for {{ managed-k8s-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

In {{ managed-k8s-name }}, you're charged for using [masters](concepts/index.md#master) and outgoing traffic.

Nodes are charged according to [pricing for {{ compute-short-name }}](../compute/pricing.md).

## Pricing {#prices}

### Master {#master}

{% list tabs %}

- Prices in USD

    | Master type | Rate for 1 hour, without VAT |
    | ----- | ----- |
    | Zonal | $0.070512 |
    | Regional | $0.178205 |

- Prices in roubles

    | Master type | Rate for 1 hour, with VAT |
    | ----- | ----- |
    | Zonal | ₽5.5000 |
    | Regional | ₽13.9000 |

{% endlist %}

### Outgoing traffic {#prices-traffic}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "pre-kz" %}

{% include notitle [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}\
