Стоимость транскодирования видео — `100 минут` (взимается однократно при загрузке видео):

> 100 × 5,40 ₸ = 540 ₸

Стоимость хранения оригинала видео — `5 ГБ` и потокового видео — `8 ГБ`:

> 5 × {{ sku|KZT|storage.bucket.used_space.ice|month|string }} = {% calc [currency=KZT] 5  × {{ sku|KZT|storage.bucket.used_space.ice|month|number }} %}
>
> 8 × {{ sku|KZT|storage.bucket.used_space.standard|pricingRate.720|month|string }} = {% calc [currency=KZT] 8  × {{ sku|KZT|storage.bucket.used_space.standard|pricingRate.720|month|number }} %}

Стоимость исходящего трафика — `50 ГБ`:

> 50 × {{ sku|KZT|cdn.api.network.inet.egress|string }} = {% calc [currency=KZT] 50  × {{ sku|KZT|cdn.api.network.inet.egress|number }} %}

Общая стоимость услуг сервиса за месяц составит:

> 540 ₸ + {% calc [currency=KZT] 5 × {{ sku|KZT|storage.bucket.used_space.ice|month|number }} %} + {% calc [currency=KZT] 8 × {{ sku|KZT|storage.bucket.used_space.standard|pricingRate.720|month|number }} %} + {% calc [currency=KZT] 50 × {{ sku|KZT|cdn.api.network.inet.egress|number }} %} = {% calc [currency=KZT] 540 + 5 × {{ sku|KZT|storage.bucket.used_space.ice|month|number }} + 8 × {{ sku|KZT|storage.bucket.used_space.standard|pricingRate.720|month|number }} + 50 × {{ sku|KZT|cdn.api.network.inet.egress|number }} %}