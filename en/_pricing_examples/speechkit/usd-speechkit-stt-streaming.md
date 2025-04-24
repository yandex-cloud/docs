> (1 + 3) × {{ sku|USD|speechkit.stt.v1|string }} = {% calc [currency=USD] (1 + 3) × {{ sku|USD|speechkit.stt.v1|number }} %}
>
> Total: {% calc [currency=USD] (1 + 3) × {{ sku|USD|speechkit.stt.v1|number }} %}

Where:

* 1 is the number of billing units charged for the first 5-second audio fragment rounded up to 15 seconds.
* 3 is the number of billing units charged for the second 37-second audio fragment rounded up to 45 seconds.
* {{ sku|USD|speechkit.stt.v1|string }}: Cost per billing unit.