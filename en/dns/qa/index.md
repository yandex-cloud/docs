# General questions about {{ dns-name }}

#### Why am I being charged for {{ dns-name }} if there are no DNS zones in my cloud? {#dns-fee-without-usage}

[Public DNS requests](../concepts/dns-zone.md#public-zones) from virtual machines to {{ yandex-cloud }} DNS servers are also [charged](../pricing.md#public-dns-requests).

This is why {{ dns-name }} is used even if your cloud does not contain any DNS zones other than service zones.

We recommend using [caching resolvers](../tutorials/local-dns-cache.md), such as `systemd-resolved`, `dnsmasq`, or `unbound`. You can use these to reduce the number of public DNS requests, and thereby, your costs.

{% include [logs](../../_qa/logs.md) %}


#### How do I create a zone using non-Latin characters?

Cloud DNS supports any domain names, including those with local characters. To create a domain name with non-Latin characters, use [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode) encoding.