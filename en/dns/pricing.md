---
editable: false
---

# Pricing for {{ dns-name }}

## Public DNS queries {#public-dns-requests}




{% include [usd-public-dns-requests.md](../_pricing/dns/usd-public-dns-requests.md) %}

You will be billed for:

* Authoritative requests — any DNS queries for VM names in a user's [public zones](concepts/dns-zone.md#public-zones) from the internet or {{ yandex-cloud }}.

* Recursive requests — queries for external domain names in the internet from {{ yandex-cloud }} VM's.

    {% note tip %}

    We recommend to use caching resolvers like `systemd-resolved`, `dnsmasq`, `unbound`. You can reduce amount of external requests and your expenses by using them.

    {% endnote %}

You are not billed for:

* Queries from VMs to [internal](concepts/dns-zone.md#private-zones) and [service](concepts/dns-zone.md#service-zones) zones.

**You will not be billed for starting December 6, 2021:**

* Every month — for the first million (1 000 000) of recursive queries from your VMs.
  
  When you deplete your free amount of queries, you will be billed according to a tariff for other queries.

  If you will not deplete your free amount of queries until the end of calendar month, remaining queries will not be transferred to a next month.
* Queries for domain names of {{ yandex-cloud }} services (e.g. `api.cloud.yandex.net`) and Yandex services (e.g. `mail.yandex.ru`) — both from VM's and from the internet.

The cost is calculated based on consumption.




> E.g. if price of 1 million authoritative requests is $0.256410, and 50000 queries to your were made during this month,
> the monthly cost will be:
> (50 000 / 1 000 000) × $0.256410 = 0.05 × $0.256410 = $0.0128205

> E.g. if price of 1 million recursive requests is $0.256410, and 1.2 million recursive queries were made from your VMs 
> between December 6, 2021 and December 31, 2021, the monthly cost will be:
> (1.2 − 1.0) × $0.256410 = 0.2 × 0.256410 = $0.0513 
> because first million recursive requests are provided free of charge, starting December 6, 2021.

## DNS-zones {#dns-zones}

You will be charged for any user-created [public](concepts/dns-zone.md#public-zones) and [private](concepts/dns-zone.md#private-zones) DNS zones.

[Service zones](concepts/dns-zone.md#service-zones) are provided free of charge.

Billing occurs per second. The monthly usage rate is based on 720 hours a month. Price is calculated proportionally to service usage. 

> E.g. if you own to 2 DNS zones for a 360 hours, the price will be the same as if you would own 1 zone for 720 hours. 





{% include [usd-public-dns-zones.md](../_pricing/dns/usd-dns-zones.md) %}

