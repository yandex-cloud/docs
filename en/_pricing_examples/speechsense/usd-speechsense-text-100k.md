> {{ sku|USD|speechsense.analysis.text.v2|string }} × 90,000.02 = {% calc [currency=USD] {{ sku|USD|speechsense.analysis.text.v2|number }} × 90000,02 %}
>
> Total: {% calc [currency=USD] {{ sku|USD|speechsense.analysis.text.v2|number }} × 90000,02 %}: Cost of analyzing 90,000.015 characters in chat transcripts.

Where:
* {{ sku|USD|speechsense.analysis.text.v2|string }}: Cost of analyzing 1,000 characters of text for the first 100,000 thousand.