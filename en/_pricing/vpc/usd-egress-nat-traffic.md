| Resource category | Price of 1 GB,<br>without VAT |
--- | ---
| Outgoing traffic via NAT gateway, first 10 GB per month,<br>without VAT | {{ sku|USD|network.egress.inet|string }} |
| Outgoing traffic via NAT gateway, over 10 GB per month,<br>without VAT | {{ sku|USD|network.egress.inet|pricingRate.100|string }} |