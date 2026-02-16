Cost of video transcoding, `100 minutes` (charged once when you upload a video):

> 100 × {{ sku|USD|video.transcoding.vod.v1|string }} = {% calc [currency=USD] 100 × {{ sku|USD|video.transcoding.vod.v1|number }} %}

Cost of storing the original video, `5 GB`, and streaming video, `8 GB`:

> 5 × 720 × {{ sku|USD|storage.bucket.used_space.ice|string }} = {% calc [currency=USD] 5 × 720 × {{ sku|USD|storage.bucket.used_space.ice|number }} %}
>
> 8 × 720 × {{ sku|USD|storage.bucket.used_space.standard|pricingRate.720|string }} = {% calc [currency=USD] 8 × 720 × {{ sku|USD|storage.bucket.used_space.standard|pricingRate.720|number }} %}

Cost of outgoing traffic, `50 GB`:

> 50 × {{ sku|USD|video.cdn.traffic.egress|string }} = {% calc [currency=USD] 50 × {{ sku|USD|video.cdn.traffic.egress|number }} %}

The total monthly cost of the service will be:

> {% calc [currency=USD] 100 × {{ sku|USD|video.transcoding.vod.v1|number }} %} + {% calc [currency=USD] 5 × 720 × {{ sku|USD|storage.bucket.used_space.ice|number }} %} + {% calc [currency=USD] 8 × 720 × {{ sku|USD|storage.bucket.used_space.standard|pricingRate.720|number }} %} + {% calc [currency=USD] 50 × {{ sku|USD|video.cdn.traffic.egress|number }} %} = {% calc [currency=USD] 100 × {{ sku|USD|video.transcoding.vod.v1|number }} + 5 × 720 × {{ sku|USD|storage.bucket.used_space.ice|number }} + 8 × 720 × {{ sku|USD|storage.bucket.used_space.standard|pricingRate.720|number }} + 50 × {{ sku|USD|video.cdn.traffic.egress|number }} %}