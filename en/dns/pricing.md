---
editable: false
---

# Pricing for {{ dns-name }}

{% if product == "cloud-il" %}

{% note info %}

The prices listed below will take effect on November 14, 2022, when {{ dns-name }} [becomes public](../overview/concepts/launch-stages.md). Until then, the service can be used free of charge.

{% endnote %}

{% endif %}

## Public DNS queries {% if product == "cloud-il" %}starting November 14, 2022{% endif %} {#public-dns-requests}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include [rub-public-dns-requests.md](../_pricing/dns/rub-public-dns-requests.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-public-dns-requests.md](../_pricing/dns/kzt-public-dns-requests.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-public-dns-requests.md](../_pricing/dns/usd-public-dns-requests.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils-public-dns-requests.md](../_pricing/dns/ils-public-dns-requests.md) %}

{% endif %}

You will be billed for:
* Authoritative queries: Any requests for DNS records in a user's [public zones](concepts/dns-zone.md#public-zones) from the internet or {{ yandex-cloud }}.
* Recursive queries: Queries from a {{ yandex-cloud }} VM for external domain names on the internet.

   {% note tip %}

   We recommend using [caching resolvers](tutorials/local-dns-cache.md), such as `systemd-resolved`, `dnsmasq`, or `unbound`. They can help you reduce the number of queries for external domain names, reducing costs.

   {% endnote %}

You will not be billed for:
* Queries to [private](concepts/dns-zone.md#private-zones) and [service](concepts/dns-zone.md#service-zones) zones.

{% if product == "yandex-cloud" %}**Starting December 6, 2021, the following is provided free of charge**:{% endif %}
* The first one million (1000000) recursive queries from VMs each month.

   Once you have used up this free amount, you will be charged at the published rate.

   The unused balance of free services is reset at the end of the month.
* Queries for domain names of {{ yandex-cloud }} services (such as `{{ api-host }}`){% if product == "yandex-cloud" %}and those offered by Yandex (such as `mail.yandex.com`){% endif %}, both from VMs and the internet.

The cost of public DNS queries is based on usage.

{% if product == "yandex-cloud" %}

For example, the cost of 50 thousand authoritative queries to your public DNS zone per month will be:

{% if region == "ru" %}> (50000 / 1000000) × ₽32 = 0.05 × ₽32 = ₽1.60{% endif %}
{% if region == "kz" %}> (50000 / 1000000) × ₸160 = 0.05 × ₸160 = ₸8{% endif %}
{% if region == "int" %}> (50000 / 1000000) × $0.256410 = 0.05 × $0.256410 = $0.0128205{% endif %}
>
> Total: {% if region == "ru" %}₽1.60{% endif %}{% if region == "kz" %}₸8{% endif %}{% if region == "int" %}$0.0128205{% endif %}

Where:

* (50000 / 1000000) is the number of millions of executed queries.
* {% if region == "ru" %}₽32{% endif %}{% if region == "kz" %}₸160{% endif %}{% if region == "int" %}$0.256410{% endif %} is the cost per 1 million queries per month.

For example, the cost of 1.2 million recursive queries for external names executed from December 1 to December 31, 2021 from your VMs per month will be:

{% if region == "ru" %}> (1.2 − 1.0) × ₽32 = 0.2 × ₽32 = ₽6.4000{% endif %}
{% if region == "kz" %}> (1.2 − 1.0) × ₸160 = 0.2 × ₸160 = ₸32{% endif %}
{% if region == "int" %}> (1.2 − 1.0) × $0.256410 = 0.2 × $0.256410 = $0.051282{% endif %}
>
> Total: {% if region == "ru" %}₽6.4000{% endif %}{% if region == "kz" %}₸32{% endif %}{% if region == "int" %}$0.051282{% endif %}

Where:

* (1.2 − 1.0) is the number of millions of executed queries. You are not billed for the first million of recursive queries starting December 6, 2021.
* {% if region == "ru" %}₽32{% endif %}{% if region == "kz" %}₸160{% endif %}{% if region == "int" %}$0.256410{% endif %} is the cost per 1 million of recursive queries per month.

{% endif %}

## DNS zones {% if product == "cloud-il" %}starting November 14, 2022{% endif %} {#dns-zones}

You are charged for user-created [public](concepts/dns-zone.md#public-zones) or [internal](concepts/dns-zone.md#private-zones) DNS zones.

[Service zones](concepts/dns-zone.md#service-zones) are provided free of charge.

Billing occurs per second. The cost is calculated in proportion to usage.

{% if product == "yandex-cloud" %}

> For example, the cost of owning 2 DNS zones for 360 hours will be the same as the cost of owning 1 DNS zone for 720 hours.

{% endif %}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include [rub-public-dns-zones.md](../_pricing/dns/rub-dns-zones.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-public-dns-zones.md](../_pricing/dns/kzt-dns-zones.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-public-dns-zones.md](../_pricing/dns/usd-dns-zones.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils-public-dns-zones.md](../_pricing/dns/ils-dns-zones.md) %}

{% endif %}
