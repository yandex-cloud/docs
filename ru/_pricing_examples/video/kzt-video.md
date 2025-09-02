Стоимость транскодирования видео — `100 минут` (взимается однократно при загрузке видео):

> 100 × {{ sku|KZT|video.transcoding.vod.v1|string }} = {% calc [currency=KZT] 100  × {{ sku|KZT|video.transcoding.vod.v1|number }} %}

Стоимость хранения оригинала видео — `5 ГБ` и потокового видео — `8 ГБ`:

> 5 × {{ sku|KZT|storage.bucket.used_space.ice|month|string }} = {% calc [currency=KZT] 5  × {{ sku|KZT|storage.bucket.used_space.ice|month|number }} %}
>
> 8 × {{ sku|KZT|storage.bucket.used_space.standard|pricingRate.720|month|string }} = {% calc [currency=KZT] 8  × {{ sku|KZT|storage.bucket.used_space.standard|pricingRate.720|month|number }} %}

Стоимость исходящего трафика — `50 ГБ`:

> 50 × {{ sku|KZT|video.cdn.traffic.egress|string }} = {% calc [currency=KZT] 50  × {{ sku|KZT|video.cdn.traffic.egress|number }} %}

Общая стоимость услуг сервиса за месяц составит:

> {% calc [currency=KZT] 100  × {{ sku|KZT|video.transcoding.vod.v1|number }} %} + {% calc [currency=KZT] 5 × {{ sku|KZT|storage.bucket.used_space.ice|month|number }} %} + {% calc [currency=KZT] 8 × {{ sku|KZT|storage.bucket.used_space.standard|pricingRate.720|month|number }} %} + {% calc [currency=KZT] 50 × {{ sku|KZT|video.cdn.traffic.egress|number }} %} = {% calc [currency=KZT] 100  × {{ sku|KZT|video.transcoding.vod.v1|number }} + 5 × {{ sku|KZT|storage.bucket.used_space.ice|month|number }} + 8 × {{ sku|KZT|storage.bucket.used_space.standard|pricingRate.720|month|number }} + 50 × {{ sku|KZT|video.cdn.traffic.egress|number }} %}