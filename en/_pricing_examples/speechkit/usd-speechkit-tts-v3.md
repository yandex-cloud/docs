> (1 + 2 + 3) × {{ sku|USD|speechkit.tts.v3_request.v1|string }} = {% calc [currency=USD] (1 + 2 + 3) × {{ sku|USD|speechkit.tts.v3_request.v1|number }} %}
>
> Total: {% calc [currency=USD] (1 + 2 + 3) × {{ sku|USD|speechkit.tts.v3_request.v1|number }} %}.

Where:

* 1: Number of billing units charged for the first request of 150 characters.
* 2: Number of billing units charged for the second request of 300 characters in `unsafe_mode`.
* 3: Number of billing units charged for the third request of 600 characters in `unsafe_mode`.
* {{ sku|USD|speechkit.tts.v3_request.v1|string }}: Cost per billing unit.