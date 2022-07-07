### Outgoing traffic {#prices-traffic}

When using the service, you pay for traffic from {{ yandex-cloud }} to the internet. Traffic between {{ yandex-cloud }} services and incoming internet traffic are free.

The first 10 GB of outgoing traffic are provided free of charge every month.

The minimum billable unit is 1 MB.

| Resource category | Cost of 1 GB, with VAT |
--- | ---
| Outgoing traffic, first 10 GB per month | {{ sku|RUB|network.egress.inet|string }} |
| Outgoing traffic, over 10 GB per month | {{ sku|RUB|network.egress.inet|pricingRate.10|string }} |