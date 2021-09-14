---
editable: false
---
# Pricing for {{ cdn-full-name }}

The {{ cdn-full-name }} usage cost estimation counts only the outgoing traffic from CDN servers, including the traffic requested from user resources of the {{ yandex-cloud }} services: for example, from  [virtual machines](../compute/concepts/vm.md) of {{ compute-full-name}}. The incoming traffic received by CDN servers from the {{ yandex-cloud }} services and resources or from the Internet, is not charged.

## Pricing {#prices}

{% if region == "ru" %}

{% include notitle [rub.md](../_pricing/cdn/rub.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt.md](../_pricing/cdn/kzt.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd.md](../_pricing/cdn/usd.md) %}

{% endif %}
