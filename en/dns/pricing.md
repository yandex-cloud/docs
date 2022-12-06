---
editable: false
---

# Pricing for {{ dns-name }}

## Public DNS queries {#public-dns-requests}





{% include [usd-public-dns-requests.md](../_pricing/dns/usd-public-dns-requests.md) %}




You will be billed for:
* Authoritative queries: Any requests for DNS records in a user's [public zones](concepts/dns-zone.md#public-zones) from the internet or {{ yandex-cloud }}.
* Recursive queries: Queries from a {{ yandex-cloud }} VM for external domain names on the internet.

   {% note tip %}

   We recommend using [caching resolvers](tutorials/local-dns-cache.md), such as `systemd-resolved`, `dnsmasq`, or `unbound`. They can help you reduce the number of queries for external domain names, reducing costs.

   {% endnote %}

You will not be billed for:
* Queries to [private](concepts/dns-zone.md#private-zones) and [service](concepts/dns-zone.md#service-zones) zones.

**Starting December 6, 2021, the following is provided free of charge**:
* The first one million (1000000) recursive queries from VMs each month.

   Once you have used up this free amount, you will be charged at the published rate.

   The unused balance of free services is reset at the end of the month.
* Queries for domain names of {{ yandex-cloud }} services (such as `{{ api-host }}`)and those offered by Yandex (such as `mail.yandex.com`), both from VMs and the internet.

The cost of public DNS queries is based on usage.


For example, the cost of 50 thousand authoritative queries to your public DNS zone per month will be:

> (50000 / 1000000) × $0.256410 = 0.05 × $0.256410 = $0.0128205
>
> Total: $0.0128205

Where:

* (50000 / 1000000) is the number of millions of executed queries.
* $0.256410 is the cost per 1 million queries per month.

For example, the cost of 1.2 million recursive queries for external names executed from December 1 to December 31, 2021 from your VMs per month will be:

> (1.2 − 1.0) × $0.256410 = 0.2 × $0.256410 = $0.051282
>
> Total: $0.051282

Where:

* (1.2 − 1.0) is the number of millions of executed queries. You are not billed for the first million of recursive queries starting December 6, 2021.
* $0.256410 is the cost per 1 million of recursive queries per month.


## DNS zones {#dns-zones}

You are charged for user-created [public](concepts/dns-zone.md#public-zones) or [internal](concepts/dns-zone.md#private-zones) DNS zones.

[Service zones](concepts/dns-zone.md#service-zones) are provided free of charge.

Billing occurs per second. The cost is calculated in proportion to usage.


> For example, the cost of owning 2 DNS zones for 360 hours will be the same as the cost of owning 1 DNS zone for 720 hours.






{% include [usd-public-dns-zones.md](../_pricing/dns/usd-dns-zones.md) %}



