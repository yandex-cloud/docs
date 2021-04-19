### Outgoing traffic {#prices-traffic}

When using the service, you pay for the traffic from {{ yandex-cloud }} to the internet. Traffic between {{ yandex-cloud }} services and incoming internet traffic are free.

The minimum charging unit is 1 MB.

Resource category | Cost of 1 GB, without VAT
--- | ---
Outgoing traffic, <10 GB | {{ sku|USD|network.public_fips|int|string }}
Outgoing traffic, >10 GB | {{ sku|USD|network.egress.inet|pricingRate.10|string }}