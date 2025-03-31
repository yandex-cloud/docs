| Threshold value, thousands of characters per month | Text dialog analytics,<br>without VAT | 
|---|---|
| 0 to 100,000           | {{ sku|USD|speechsense.analysis.text.v2|string }}                     |
| 100,001 to 500,000     | {{ sku|USD|speechsense.analysis.text.v2|pricingRate.100000|string }}  |
| 500,001 to 1,000,000   | {{ sku|USD|speechsense.analysis.text.v2|pricingRate.500000|string }}  |
| 1,000,001 to 2,500,000 | {{ sku|USD|speechsense.analysis.text.v2|pricingRate.1000000|string }} |
| from 2,500,000         | {{ sku|USD|speechsense.analysis.text.v2|pricingRate.2500000|string }} |