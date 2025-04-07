Overall resource consumption in the organization<br>over the previous month | Monthly price, without VAT
----- | -----
| Less than $8,000 | {{ sku|USD|access_transparency.subscription.v1|string }} |
| From $8,000 to $40,000 | {% calc [currency=USD] {{ sku|USD|access_transparency.subscription.v1|number }} × (12/7) %} |
| From $40,000 to $80,000 | {% calc [currency=USD] ({{ sku|USD|access_transparency.subscription.v1|number }} × (12/7)) × 1,5 %} |
| From $80,000 to $160,000 | {% calc [currency=USD] ({{ sku|USD|access_transparency.subscription.v1|number }} × (12/7)) × 3 %} |
| Over $160,000 | {% calc [currency=USD] ({{ sku|USD|access_transparency.subscription.v1|number }} × (12/7)) × 3,75 %} |