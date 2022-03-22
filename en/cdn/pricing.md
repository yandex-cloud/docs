---
editable: false
---
# Pricing for {{ cdn-full-name }}

The cost of using {{ cdn-full-name }} is based on:

* The amount of outgoing traffic from CDN servers, including traffic requested by the user's {{ yandex-cloud }} resources, such as {{ compute-full-name}} [virtual machines](../compute/concepts/vm.md). The incoming traffic received by CDN servers from the {{ yandex-cloud }} services and resources or from the Internet, is not charged.

* Paid features enabled for resources, such as [origin shielding](concepts/origins-shielding.md) and [log export](concepts/logs.md).

  {% note info %}

  You will be billed for using paid functions starting October 1, 2021.

  {% endnote %}

## Pricing {#prices}

{% if region != "int" %}

{% include [disclaimer-new-prices](../_pricing/disclaimer-new-prices.md) %}

{% endif %}

### Outgoing traffic {#traffic}

{% if region == "ru" %}

{% include notitle [rub.md](../_pricing/cdn/rub.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt.md](../_pricing/cdn/kzt.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd.md](../_pricing/cdn/usd.md) %}

{% endif %}

### Paid features {#paid-features}

Billing occurs on a monthly basis. If a function is enabled or disabled on any day of a month, the full monthly price will be charged for the month on the last day.

{% if region == "ru" %}

{% include notitle [rub-paid-features.md](../_pricing/cdn/rub-paid-features.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-paid-features.md](../_pricing/cdn/kzt-paid-features.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-paid-features.md](../_pricing/cdn/usd-paid-features.md) %}

{% endif %}

