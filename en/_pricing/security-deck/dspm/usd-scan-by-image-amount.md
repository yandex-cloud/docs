| Number of images | Price per image,<br/>without VAT |
| --- | --- |
| From 1 to 1000               | {{ sku|USD|security_deck.dspm.scanned.image.v1|string }} |
| From 1001 to 10,000          | {{ sku|USD|security_deck.dspm.scanned.image.v1|pricingRate.1000|string }} |
| From 10,001 to 100,000       | {{ sku|USD|security_deck.dspm.scanned.image.v1|pricingRate.10000|string }} |
| From 100,001 to 1,000,000    | {{ sku|USD|security_deck.dspm.scanned.image.v1|pricingRate.100000|string }} |
| From 1,000,001 to 10,000,000 | {{ sku|USD|security_deck.dspm.scanned.image.v1|pricingRate.1000000|string }} |
| More than 10,000,000         | {{ sku|USD|security_deck.dspm.scanned.image.v1|pricingRate.10000000|string }} |