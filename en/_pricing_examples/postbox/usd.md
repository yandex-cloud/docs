* First 2,000 emails: free of charge.
* From 2,001 to 10,000 emails (8,000 emails total): {{ sku|USD|postbox.email.count.v1|pricingRate.2|string }} per 1,000 emails.
* From 10,001 to 50,000 emails (40,000 emails total): {{ sku|USD|postbox.email.count.v1|pricingRate.10|string }} per 1,000 emails.
* From 50,001 to 65,500 emails (15,500 emails total): {{ sku|USD|postbox.email.count.v1|pricingRate.50|string }} per 1,000 emails.

The amount charged for 65,500 emails per month is:

> (8 × {{ sku|USD|postbox.email.count.v1|pricingRate.2|string }}) + (40 × {{ sku|USD|postbox.email.count.v1|pricingRate.10|string }}) + (15.5 × {{ sku|USD|postbox.email.count.v1|pricingRate.50|string }}) = {% calc [currency=USD] (8 × {{ sku|USD|postbox.email.count.v1|pricingRate.2|number }}) + (40 × {{ sku|USD|postbox.email.count.v1|pricingRate.10|number }}) + (15.5 × {{ sku|USD|postbox.email.count.v1|pricingRate.50|number }}) %}