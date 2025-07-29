Cost of video transcoding, `100 minutes` (charged once when you upload a video):

> 100 × $0.009 = $0.9

Cost of storing the original video, `5 GB`, and streaming video, `8 GB`:

> 5 × {{ sku|USD|storage.bucket.used_space.ice|month|string }} = {% calc [currency=USD] 5 × {{ sku|USD|storage.bucket.used_space.ice|month|number }} %}
>
> 8 × {{ sku|USD|storage.bucket.used_space.standard|pricingRate.720|month|string }} = {% calc [currency=USD] 8 × {{ sku|USD|storage.bucket.used_space.standard|pricingRate.720|month|number }} %}

Cost of outgoing traffic, `50 GB`:

> 50 × {{ sku|USD|cdn.api.network.inet.egress|string }} = {% calc [currency=USD] 50 × {{ sku|USD|cdn.api.network.inet.egress|number }} %}

The total monthly cost of the service will be:

> $0.9 + {% calc [currency=USD] 5 × {{ sku|USD|storage.bucket.used_space.ice|month|number }} %} + {% calc [currency=USD] 8 × {{ sku|USD|storage.bucket.used_space.standard|pricingRate.720|month|number }} %} + {% calc [currency=USD] 50 × {{ sku|USD|cdn.api.network.inet.egress|number }} %} = {% calc [currency=USD] 0.9 + 5 × {{ sku|USD|storage.bucket.used_space.ice|month|number }} + 8 × {{ sku|USD|storage.bucket.used_space.standard|pricingRate.720|month|number }} + 50 × {{ sku|USD|cdn.api.network.inet.egress|number }} %}