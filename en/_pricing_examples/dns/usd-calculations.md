> (50,000 / 1,000,000) × {{ sku|USD|dns.requests.public.authoritative.v1|string }} = 0.05 × {{ sku|USD|dns.requests.public.authoritative.v1|string }} = {% calc [currency=USD] (50000 / 1000000) × {{ sku|USD|dns.requests.public.authoritative.v1|number }} %}
> 
> Total: {% calc [currency=USD] (50000 / 1000000) × {{ sku|USD|dns.requests.public.authoritative.v1|number }} %}

Where:

* (50,000 / 1,000,000): Number of millions of executed queries.
* {{ sku|USD|dns.requests.public.authoritative.v1|string }}: Price per 1 million queries per month.

For example, the cost of 1.2 million recursive queries for external names executed from December 6 to December 31 from your VMs per month will be:

> (1.2 − 1.0) × {{ sku|USD|dns.requests.public.recursive.v1|pricingRate.1|string }} = 0.2 × {{ sku|USD|dns.requests.public.recursive.v1|pricingRate.1|string }} = {% calc [currency=USD] (1.2 - 1.0) × {{ sku|USD|dns.requests.public.recursive.v1|pricingRate.1|number }} %}
> 
> Total: {% calc [currency=USD] (1.2 - 1.0) × {{ sku|USD|dns.requests.public.recursive.v1|pricingRate.1|number }} %}

Where:

* (1.2 − 1.0): Number of millions of executed queries. You are not billed for the first million of recursive queries starting December 6, 2021.
* {{ sku|USD|dns.requests.public.recursive.v1|pricingRate.1|string }}: Price per 1 million recursive queries per month.