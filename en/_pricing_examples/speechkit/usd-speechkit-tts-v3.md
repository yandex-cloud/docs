> (1 + 2 + 3) × {{ sku|USD|speechkit.tts.v3_request.v1|string }} = {% calc [currency=USD] (1 + 2 + 3) × {{ sku|USD|speechkit.tts.v3_request.v1|number }} %}
>
> Total: {% calc [currency=USD] (1 + 2 + 3) × {{ sku|USD|speechkit.tts.v3_request.v1|number }} %}

Where:

* 1 is the number of billing units charged for the first request of 150 characters.
* 2 is the number of billing units charged for the second request of 300 characters made using `unsafe_mode`.
* 3 is the number of billing units charged for the third request of 600 characters made using `unsafe_mode`.
* {{ sku|USD|speechkit.tts.v3_request.v1|string }}: Cost per billing unit.