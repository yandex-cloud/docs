> (15 + 30 + 40) × {{ sku|USD|speechkit.stt_long_running_deferred.v1|string }} = {% calc [currency=USD] (15 + 30 + 40) × {{ sku|USD|speechkit.stt_long_running_deferred.v1|number }} %}
>
> Total: {% calc [currency=USD] (15 + 30 + 40) × {{ sku|USD|speechkit.stt_long_running_deferred.v1|number }} %}

Where:

* 15 is the number of billing units charged for the first 2-channel 2-second audio fragment rounded up to 15 seconds.
* 30 is the number of billing units charged for the second 3-channel 14-second audio fragment rounded up to 4 channels and 15 seconds.
* 40 is the number of billing units charged for the third 4-channel 19.5-second audio fragment rounded up to 20 seconds.
* {{ sku|USD|speechkit.stt_long_running_deferred.v1|string }}: Cost per billing unit.