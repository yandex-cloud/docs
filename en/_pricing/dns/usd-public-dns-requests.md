| Resource category | Price per 1,000,000 requests<br>per month, without VAT |
|-------------------|---------------------------|
| Public DNS requests, authoritative | {{ sku|USD|dns.requests.public.authoritative.v1|string }} |
| Public DNS requests, recursive, 1,000,000 or less per month | {{ sku|USD|dns.requests.public.recursive.v1|string }} |
| Public DNS requests, recursive, over 1,000,000 per month | {{ sku|USD|dns.requests.public.recursive.v1|pricingRate.1|string }} |