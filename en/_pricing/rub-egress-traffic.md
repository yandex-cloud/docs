### Outgoing traffic {#prices-traffic}

When using the service, you pay for the traffic from Yandex.Cloud to the internet. Traffic between Yandex.Cloud services and incoming internet traffic are free.

The minimum charging unit is 1 MB.

| Resource category | Cost of 1 GB, with VAT |
| ----- | -----
| Outgoing traffic, <10 GB | {{ sku|RUB|network.public_fips|int|string }} |
| Outgoing traffic, >10 GB | {{ sku|RUB|network.egress.inet|pricingRate.10|string }} |
