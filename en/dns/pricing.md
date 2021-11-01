---
editable: false
---

# Pricing for {{ dns-name }}

After general availability of the service, you'll start seeing service resources consumption in your billing. However, until and including **October 31st of 2021**, Cloud DNS can be used free of charge.

Since **November 1st of 2021**, service will become paid.

## Public DNS queries {#public-dns-requests}

{% if region == "ru" %}

{% include [rub-public-dns-requests.md](../_pricing/dns/rub-public-dns-requests.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-public-dns-requests.md](../_pricing/dns/kzt-public-dns-requests.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-public-dns-requests.md](../_pricing/dns/usd-public-dns-requests.md) %}

{% endif %}

You will be billed for:

* Any queries for VM names in a user's [public zones](concepts/dns-zone.md#public-zones) from the internet or {{ yandex-cloud }}.
* Queries for external names on the internet from a {{ yandex-cloud }} VM.

You are not billed for queries to [internal](concepts/dns-zone.md#private-zones) and [service](concepts/dns-zone.md#service-zones) zones.

The cost is calculated based on consumption.

{% if region == "ru" %}

> For example, if cost of 1 million requests is ₽20 and 200000 (0.2 million) queries were made during a month, the cost will be:
> 0.2 * ₽20 = ₽4

{% endif %}

{% if region == "kz" %}

> For example, if cost of 1 million requests is ₸120.0000 and 200000 (0.2 million) queries were made during a month, the cost will be:
> 0.2 * ₸120.0000 = ₸24

{% endif %}

{% if region == "int" %}

> For example, if cost of 1 million requests is $0.256410 and 200000 (0.2 million) queries were made during a month, the cost will be:
> 0.2 * $0.256410 = $0.0513 

{% endif %}

## DNS-zones {#dns-zones}

You will be charged for any user-created public and private DNS zones. Price is calculated proportionally to service usage.

Price is shown for 1 month of use. The monthly usage rate is based on 720 hours a month. Billing occurs per second.

You are charged for any user-created public or internal DNS zones.

[Service zones](concepts/dns-zone.md#service-zones) are provided free of charge.

{% if region == "ru" %}

{% include [rub-public-dns-zones.md](../_pricing/dns/rub-dns-zones.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-public-dns-zones.md](../_pricing/dns/kzt-dns-zones.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-public-dns-zones.md](../_pricing/dns/usd-dns-zones.md) %}

{% endif %}

