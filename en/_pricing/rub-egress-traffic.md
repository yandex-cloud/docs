### Egress traffic {#prices-traffic}

When using the service, you pay for traffic from {{ yandex-cloud }} to the internet. Traffic between {{ yandex-cloud }} services and incoming internet traffic are free.

The first 100 GB of outgoing traffic are provided free of charge every month.

The minimum billable unit is 1 MB.

Resource category | Cost of 1 GB
--- | ---
Outgoing traffic, first 100 GB per month | {{ sku|RUB|network.egress.inet|string }} |
Outgoing traffic, over 100 GB per month | {{ sku|RUB|network.egress.inet|pricingRate.100|string }} |