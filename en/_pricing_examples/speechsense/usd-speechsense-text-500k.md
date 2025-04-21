> {{ sku|USD|speechsense.analysis.text.v2|string }} × 100,000 + {{ sku|USD|speechsense.analysis.text.v2|pricingRate.100000|string }} × 50,000.03 = {% calc [currency=USD] ({{ sku|USD|speechsense.analysis.text.v2|number }} × 100000 + {{ sku|USD|speechsense.analysis.text.v2|pricingRate.100000|number }} × 50000,03) %}
>
> Total: {% calc [currency=USD] ({{ sku|USD|speechsense.analysis.text.v2|number }} × 100000 + {{ sku|USD|speechsense.analysis.text.v2|pricingRate.100000|number }} × 50000,03) %}: Cost of analyzing 150,000,023 characters in text dialogs.

Where:
* {{ sku|USD|speechsense.analysis.text.v2|string }}: Cost of analyzing one thousand characters of text for the first 100,000 thousand.
* {{ sku|USD|speechsense.analysis.text.v2|pricingRate.100000|string }}: Cost of analyzing one thousand characters of text for the next 50,000.023 thousand.