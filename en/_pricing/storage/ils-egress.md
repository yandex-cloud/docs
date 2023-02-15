| Resource category | Cost of 1 GB, including VAT |
| --- | --- |
| Outgoing traffic up to 100 GB per month | {{ sku|ILS|storage.api.network.inet.egress|string }} |
| Outgoing traffic over 100 GB and up to 1 TB | {{ sku|ILS|storage.api.network.inet.egress|pricingRate.100|string }} |
| Outgoing traffic over 1 TB and up to 50 TB | {{ sku|ILS|storage.api.network.inet.egress|pricingRate.1024|string }} |
| Outgoing traffic over 50 TB and up to 100 TB | {{ sku|ILS|storage.api.network.inet.egress|pricingRate.51200|string }} |
| Outgoing traffic over 100 TB | {{ sku|ILS|storage.api.network.inet.egress|pricingRate.102400|string }} |