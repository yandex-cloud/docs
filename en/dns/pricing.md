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

### Public DNS requests {#public-dns-requests}




{% include [usd-public-dns-requests](../_pricing/dns/usd-public-dns-requests.md) %}


You will be billed for:
* Authoritative requests: Any DNS requests to user [public zones](concepts/dns-zone.md#public-zones) from the internet or {{ yandex-cloud }}.
* Recursive requests: DNS requests for external domain names on the internet from {{ yandex-cloud }} VMs.

  {% note tip %}

  We recommend using [caching resolvers](tutorials/local-dns-cache.md), such as `systemd-resolved`, `dnsmasq`, or `unbound`. These reduce the number of external domain name requests, and thereby, your costs.

  {% endnote %}

You do not pay for:
* Requests from VMs to [private](concepts/dns-zone.md#private-zones) and [service](concepts/dns-zone.md#service-zones) zones.

**Starting December 6, 2021, you get the following free of charge**:
* The first million (1,000,000) recursive requests from VMs each month.

  Once you have used up this free amount, you will be charged according to your service plan.

  Any unused free service balance is reset at the end of each calendar month.
* Requests for domain names of {{ yandex-cloud }} services (e.g., `{{ api-host }}`) and Yandex services (e.g., `mail.yandex.com`), both from VMs and the internet.

The cost of public DNS requests is based on usage.

For example, the cost of 50 thousand authoritative requests to your public DNS zone per month will be:




{% include [usd-calculations](../_pricing_examples/dns/usd-calculations.md) %}


### DNS zones {#dns-zones}

You are charged for [public](concepts/dns-zone.md#public-zones) or [private](concepts/dns-zone.md#private-zones) DNS zones you create.

[Service zones](concepts/dns-zone.md#service-zones) are provided free of charge.

You are charged per second of usage, based on consumption.

> For example, the cost of managing two DNS zones for 360 hours will be the same as the cost of managing one DNS zone for 720 hours.



{% include [usd-public-dns-zones](../_pricing/dns/usd-dns-zones.md) %}

