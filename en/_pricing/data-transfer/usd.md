| Number of transferred rows               | Cost per month, without VAT |
|------------------------------------------|-----------------------------|
| less than 100 000 000                    | {{ sku|USD|datatransfer.rows.v1|string }} |
| more than 100 000 000 per each 1 000 000 | {{ sku|USD|datatransfer.rows.v1|pricingRate.100|string }} |