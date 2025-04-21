> {{ sku|USD|speechsense.analysis.text.v2|string }} × 100,000 + {{ sku|USD|speechsense.analysis.text.v2|pricingRate.100000|string }} × 400,000 + {{ sku|USD|speechsense.analysis.text.v2|pricingRate.500000|string }} × 185,000 = {% calc [currency=USD] ({{ sku|USD|speechsense.analysis.text.v2|number }} × 100000 + {{ sku|USD|speechsense.analysis.text.v2|pricingRate.100000|number }} × 400000 + {{ sku|USD|speechsense.analysis.text.v2|pricingRate.500000|number }} × 185000) %}
>
> Total: {% calc [currency=USD] ({{ sku|USD|speechsense.analysis.text.v2|number }} × 100000 + {{ sku|USD|speechsense.analysis.text.v2|pricingRate.100000|number }} × 400000 + {{ sku|USD|speechsense.analysis.text.v2|pricingRate.500000|number }} × 185000) %}: Cost of analyzing 685,000,000 characters in text dialogs.

Where:
* {{ sku|USD|speechsense.analysis.text.v2|string }}: Cost of analyzing one thousand characters of text for the first 100,000 thousand.
* {{ sku|USD|speechsense.analysis.text.v2|pricingRate.100000|string }}: Cost of analyzing one thousand characters of text for the next 400,000 thousand.
* {{ sku|USD|speechsense.analysis.text.v2|pricingRate.500000|string }}: Cost of analyzing one thousand characters of text for the next 185,000 thousand.