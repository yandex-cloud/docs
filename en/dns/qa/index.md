# General questions about {{ dns-name }}

#### Why am I being charged for {{ dns-name }} if there are no DNS zones in my cloud? {#dns-fee-without-usage}

[Public DNS requests](../concepts/dns-zone.md#public-zones) from virtual machines to Yandex DNS servers are also [charged](../pricing.md#public-dns-requests).

That is why {{ dns-name }} is used even if your cloud doesn't contain any DNS zones other than service zones.

We recommend using [caching resolvers](../tutorials/local-dns-cache.md), such as `systemd-resolved`, `dnsmasq`, or `unbound`. You can use these to reduce the number of public DNS requests, and thereby, your costs.

{% include [logs](../../_qa/logs.md) %}