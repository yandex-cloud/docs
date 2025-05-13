> (15 + 30 + 16 + 32) × {{ sku|USD|speechkit.stt_long_running.v1|string }} = {% calc [currency=USD] (15 + 30 + 16 + 32) × {{ sku|USD|speechkit.stt_long_running.v1|number }} %}
>
> Total: {% calc [currency=USD] (15 + 30 + 16 + 32) × {{ sku|USD|speechkit.stt_long_running.v1|number }} %}.

Where:

* 15: Number of billing units charged for the first single-channel 5-second audio fragment rounded up to 2 channels and 15 seconds.
* 30: Number of billing units charged for the second 3-channel 5-second audio fragment rounded up to 4 channels and 15 seconds.
* 16: Number of billing units charged for the third 2-channel 15.5-second audio fragment rounded up to 16 seconds.
* 32: Number of billing units charged for the fourth 4-channel 15.5-second audio fragment rounded up to 16 seconds.
* {{ sku|USD|speechkit.stt_long_running.v1|string }}: Cost per billing unit.