---
editable: false
---
# Pricing for {{ dns-name }}

After general availability of the service, you'll start seeing service resources consumption in your billing. However, until and including **October 31st of 2021**, Cloud DNS can be used free of charge.

Since **November 1st of 2021**, service will become paid.

## Public DNS requests {#public-dns-requests}




{% include [usd-public-dns-requests.md](../_pricing/dns/usd-public-dns-requests.md) %}

We charge for: 

* Any DNS requests to your public DNS zones coming from the internet or {{ yandex-cloud }} resources.
* We charge for outgoing DNS requests to the internet from your {{ yandex-cloud }} resources. 

Requests to service and private DNS zones are free of charge.

Price is calculated proportionally to service usage.

> E.g., if you make 200 000 requests in a month (0.2 million), the price will be calculated as follows:
> 0.2 * ₽20 = ₽4

## Ownership of DNS-zones {#dns-zones}

You will be charged for any user-created public and private DNS zones. Price is calculated proportionally to service usage.

Price is shown for 1 month of use. The monthly usage rate is based on 720 hours a month. Billing occurs per second.

Service zones are free of charge.




{% include [usd-public-dns-zones.md](../_pricing/dns/usd-dns-zones.md) %}
