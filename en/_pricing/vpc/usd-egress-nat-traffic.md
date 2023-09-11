The first 100 GB of outgoing traffic via NAT gateway are provided free of charge every month.

The minimum charging unit is 1 MB.

Resource category | Cost of 1 GB
--- | ---
Outgoing traffic via NAT gateway, first 100 GB per month | {{ sku|USD|network.egress.inet|string }}
Outgoing traffic via NAT gateway, over 100 GB per month | {{ sku|USD|network.egress.inet|pricingRate.100|string }}