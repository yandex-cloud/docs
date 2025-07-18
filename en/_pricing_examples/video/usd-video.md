Video transcoding cost — `100 minutes` (charged once upon video upload):

> 100 × 0.009 $ = 0.9 $

Storage cost for original video — `5 GB`, and for streaming video — `8 GB`:

> 5 × {{ sku|USD|storage.bucket.used_space.ice|month|string }} = {% calc [currency=USD] 5  × {{ sku|USD|storage.bucket.used_space.ice|month|number }} %}
>
> 8 × {{ sku|USD|storage.bucket.used_space.standard|pricingRate.720|month|string }} = {% calc [currency=USD] 8  × {{ sku|USD|storage.bucket.used_space.standard|pricingRate.720|month|number }} %}

Outgoing traffic cost — `50 GB`:

> 50 × {{ sku|USD|cdn.api.network.inet.egress|string }} = {% calc [currency=USD] 50  × {{ sku|USD|cdn.api.network.inet.egress|number }} %}

The total service cost for the month is:

> 0.9 $ + {% calc [currency=USD] 5 × {{ sku|USD|storage.bucket.used_space.ice|month|number }} %} + {% calc [currency=USD] 8 × {{ sku|USD|storage.bucket.used_space.standard|pricingRate.720|month|number }} %} + {% calc [currency=USD] 50 × {{ sku|USD|cdn.api.network.inet.egress|number }} %} = {% calc [currency=USD] 0.9 + 5 × {{ sku|USD|storage.bucket.used_space.ice|month|number }} + 8 × {{ sku|USD|storage.bucket.used_space.standard|pricingRate.720|month|number }} + 50 × {{ sku|USD|cdn.api.network.inet.egress|number }} %}