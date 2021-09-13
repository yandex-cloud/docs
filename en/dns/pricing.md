---
editable: false
---
# Pricing for {{ dns-name }}

At the [Preview](../overview/concepts/launch-stages.md) stage, {{ dns-name }} can be used free of charge.

{% note info %}

Until and including October 31st of 2021, Cloud DNS can be used free of charge.

Since November 1st of 2021, service will become paid.

{% endnote %}

## Public DNS requests {#public-dns-requests}

{% if region == "ru" %}

{% include [rub-public-dns-requests.md](../_pricing/dns/rub-public-dns-requests.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-public-dns-requests.md](../_pricing/dns/kzt-public-dns-requests.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-public-dns-requests.md](../_pricing/dns/usd-public-dns-requests.md) %}

{% endif %}

We charge for: 

* Any DNS requests to your public DNS zones coming from the internet or {{ yandex-cloud }} resources.
* We charge for outgoing DNS requests to the internet from your {{ yandex-cloud }} resources. 

Requests to service and private DNS zones are free of charge.

Price is calculated proportionally to service usage.

> E.g., if you make 200 000 requests in a month (0.2 million), the price will be calculated as follows:
> 0.2 * ₽20 = ₽4

## Ownership of DNS-zones {#dns-zones}

{% if region == "ru" %}

{% include [rub-public-dns-zones.md](../_pricing/dns/rub-dns-zones.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-public-dns-zones.md](../_pricing/dns/kzt-dns-zones.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-public-dns-zones.md](../_pricing/dns/usd-dns-zones.md) %}

{% endif %}

Service zones are free of charge.
