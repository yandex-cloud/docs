|                  Service                           | Price per 1,000, without VAT |
|:---------------------------------------------------|-----------------------------:|
| Outbound emails, up to 2,000 per month              | {{ sku|USD|postbox.email.count.v1|string }}                 |
| Outbound emails, from 2,001 to 10,000 per month     | {{ sku|USD|postbox.email.count.v1|pricingRate.2|string }}   |
| Outbound emails, from 10,001 to 50,000 per month    | {{ sku|USD|postbox.email.count.v1|pricingRate.10|string }}  |
| Outbound emails, from 50,001 to 100,000 per month   | {{ sku|USD|postbox.email.count.v1|pricingRate.50|string }}  |
| Outbound emails, from 100,001 to 250,000 per month  | {{ sku|USD|postbox.email.count.v1|pricingRate.100|string }} |
| Outbound emails, from 250,001 per month | {{ sku|USD|postbox.email.count.v1|pricingRate.250|string }} |

{% note warning %}

The prices below will additionally apply starting October 1, 2025.

{% endnote %}

|                  Service                              | Price per 1,000, without VAT  |
|:------------------------------------------------------|------------------------------:|
| Outbound emails, from 500,001 to 1,000,000 per month   | $0.116667 |
| Outbound emails, from 1,000,001 to 5,000,000 per month | $0.091667 |
| Outbound emails, from 5,000,001 per month              | $0.075000 |