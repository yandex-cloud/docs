| Size of data to scan | Price per GB,<br/>without VAT |
| --- | --- |
| From 1 to 10 GB      | {{ sku|USD|security_deck.dspm.scanned.text.v1|string }} |
| From 10 to 100 GB    | {{ sku|USD|security_deck.dspm.scanned.text.v1|pricingRate.10|string }} |
| From 100 to 1,000 GB | {{ sku|USD|security_deck.dspm.scanned.text.v1|pricingRate.100|string }} |
| From 1 to 10 TB      | {{ sku|USD|security_deck.dspm.scanned.text.v1|pricingRate.1024|string }} |
| From 10 to 100 TB    | {{ sku|USD|security_deck.dspm.scanned.text.v1|pricingRate.10240|string }} |
| From 100 to 1,000 TB | {{ sku|USD|security_deck.dspm.scanned.text.v1|pricingRate.102400|string }} |