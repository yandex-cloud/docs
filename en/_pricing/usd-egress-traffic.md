| Resource category | Cost of 1 GB |
| --- | --: |
| Outgoing traffic, 100 GB or less per month | {{ sku|USD|network.egress.inet|string }} |
| Outgoing traffic, over 100 GB per month | {{ sku|USD|network.egress.inet|pricingRate.100|string }} |
