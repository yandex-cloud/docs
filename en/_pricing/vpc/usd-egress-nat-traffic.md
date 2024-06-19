| Resource category | Cost of 1 GB |
--- | ---
| Outgoing traffic via NAT gateway, first 10 GB per month | {{ sku|USD|network.egress.inet|string }} |
| Outgoing traffic via NAT gateway, over 10 GB per month | {{ sku|USD|network.egress.inet|pricingRate.100|string }} |