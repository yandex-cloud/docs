### Outgoing traffic {#prices-traffic}

When using the service, you pay for traffic from {{ yandex-cloud }} to the internet. Traffic between {{ yandex-cloud }} services and incoming internet traffic are free of charge.

The first 10 GB of outgoing traffic are provided free of charge every month.

The minimum billing unit is 1 MB.

Resource category | Cost of 1 GB
--- | ---
**Until 01.12.2022** | 
Outgoing traffic, first 10 GB per month | {{ sku|ILS|network.egress.inet|string }} |
Outgoing traffic, over 10 GB per month | {{ sku|ILS|network.egress.inet|pricingRate.10|string }} |
**Since 01.12.2022** |
Outgoing traffic, first 10 GB per month | {{ sku|ILS|network.egress.inet|string }} |
Outgoing traffic, over 10 GB per month | {{ sku|ILS|network.egress.inet|pricingRate.10|string }} |