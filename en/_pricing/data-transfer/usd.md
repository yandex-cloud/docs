| Number of transferred rows          | Cost per month, without VAT |
|----------------------------------------|----------------------------|
| Up to 100,000,000                         | {{ sku|USD|datatransfer.rows.v1|string }} |
| Over 100,000,000, per 1,000,000 | {{ sku|USD|datatransfer.rows.v1|pricingRate.100|string }} |