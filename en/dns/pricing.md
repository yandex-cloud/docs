---
title: '{{ dns-full-name }} pricing policy'
description: This article covers the {{ dns-name }} pricing policy.
editable: false
---

# {{ dns-name }} pricing policy

{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}


## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Public DNS queries {#public-dns-requests}




{% include [usd-public-dns-requests](../_pricing/dns/usd-public-dns-requests.md) %}


You will be billed for:
* Authoritative queries: Any requests for DNS records in a user's [public zones](concepts/dns-zone.md#public-zones) from the internet or {{ yandex-cloud }}.
* Recursive queries: Queries from a {{ yandex-cloud }} VM for external domain names on the internet.

  {% note tip %}

  We recommend using [caching resolvers](tutorials/local-dns-cache.md), such as `systemd-resolved`, `dnsmasq`, or `unbound`. They can help you reduce the number of queries for external domain names, reducing costs.

  {% endnote %}

You do not pay for:
* Queries to [private](concepts/dns-zone.md#private-zones) and [service](concepts/dns-zone.md#service-zones) zones.

**Starting December 6, 2021, the following is provided free of charge**:
* The first one million (1,000,000) recursive queries from VMs each month.

  Once you have used up this free amount, you will be charged according to your service plan.

  The unused balance of free services is reset at the end of the month.
* Queries for domain names of {{ yandex-cloud }} services (e.g., `{{ api-host }}`) and Yandex services (e.g., `mail.yandex.com`), both from VMs and the internet.

The cost of public DNS queries is based on usage.

For example, the cost of 50 thousand authoritative queries to your public DNS zone per month will be:




{% include [usd-calculations](../_pricing_examples/dns/usd-calculations.md) %}


### DNS zones {#dns-zones}

You are charged for user-created [public](concepts/dns-zone.md#public-zones) or [internal](concepts/dns-zone.md#private-zones) DNS zones.

[Service zones](concepts/dns-zone.md#service-zones) are provided free of charge.

You are charged per second of usage. The cost is calculated in proportion to usage.

> For example, the cost of owning 2 DNS zones for 360 hours will be the same as the cost of owning 1 DNS zone for 720 hours.



{% include [usd-public-dns-zones](../_pricing/dns/usd-dns-zones.md) %}

