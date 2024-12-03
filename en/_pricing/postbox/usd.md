|                  Service                          | Price per 1 000, without VAT |
|:--------------------------------------------------|-----------------------------:|
| Outbound email, up to 2 000 per month             | {{ sku|USD|postbox.email.count.v1|string }}                 |
| Outbound email, from 2 001 to 10 000 per month    | {{ sku|USD|postbox.email.count.v1|pricingRate.2|string }}   |
| Outbound email, from 10 001 to 50 000 per month   | {{ sku|USD|postbox.email.count.v1|pricingRate.10|string }}  |
| Outbound email, from 50 001 to 100 000 per month  | {{ sku|USD|postbox.email.count.v1|pricingRate.50|string }}  |
| Outbound email, from 100 001 to 250 000 per month | {{ sku|USD|postbox.email.count.v1|pricingRate.100|string }} |
| Outbound email, from 250 001 to 500 000 per month | {{ sku|USD|postbox.email.count.v1|pricingRate.250|string }} |