---
title: Questions and answers about {{ dns-full-name }}
description: This pages provides answers to questions about {{ dns-name }}.
---

# General questions about {{ dns-name }}

#### Why am I being charged for {{ dns-name }} if there are no DNS zones in my cloud? {#dns-fee-without-usage}

[Public DNS requests](../concepts/dns-zone.md#public-zones) from VMs to {{ yandex-cloud }} DNS servers are also [charged](../pricing.md#public-dns-requests).

This is why {{ dns-name }} is used even if your cloud does not contain any DNS zones other than service zones.

We recommend using [caching resolvers](../tutorials/local-dns-cache.md), such as `systemd-resolved`, `dnsmasq`, or `unbound`. You can use these to reduce the number of public DNS requests, and thereby, your costs.

{% include [logs](../../_qa/logs.md) %}


#### How do I create a zone using non-Latin characters? {#dns-create-rf-zone}

Cloud DNS supports any domain names, including those with local characters. To create a domain name with non-Latin characters, use [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode) encoding.

#### How do I delegate reverse zone management to {{ dns-name }}? {#dns-reverse-zone}

To delegate reverse zone management to {{ dns-name }}:

1. Confirm that you own the domain zone (dedicated IP). To do this, just provide a copy of the document confirming ownership right transfer and registration information from the RIPE database that identifies IP ownership.
1. The {{ yandex-cloud }} information security service will check the data you provide and notify you of the results.
1. After passing the verification, [contact support](../../support/overview.md).