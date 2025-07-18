Стоимость транскодирования видео — `100 минут` (взимается однократно при загрузке видео):

> 100 × 1,08 ₽ = 108 ₽

Стоимость хранения оригинала видео — `5 ГБ` и потокового видео — `8 ГБ`:

> 5 × {{ sku|RUB|storage.bucket.used_space.ice|month|string }} = {% calc [currency=RUB] 5  × {{ sku|RUB|storage.bucket.used_space.ice|month|number }} %}
>
> 8 × {{ sku|RUB|storage.bucket.used_space.standard|pricingRate.720|month|string }} = {% calc [currency=RUB] 8  × {{ sku|RUB|storage.bucket.used_space.standard|pricingRate.720|month|number }} %}

Стоимость исходящего трафика — `50 ГБ`:

> 50 × {{ sku|RUB|cdn.api.network.inet.egress|string }} = {% calc [currency=RUB] 50  × {{ sku|RUB|cdn.api.network.inet.egress|number }} %}

Общая стоимость услуг сервиса за месяц составит:

> 108 ₽ + {% calc [currency=RUB] 5 × {{ sku|RUB|storage.bucket.used_space.ice|month|number }} %} + {% calc [currency=RUB] 8 × {{ sku|RUB|storage.bucket.used_space.standard|pricingRate.720|month|number }} %} + {% calc [currency=RUB] 50 × {{ sku|RUB|cdn.api.network.inet.egress|number }} %} = {% calc [currency=RUB] 108 + 5 × {{ sku|RUB|storage.bucket.used_space.ice|month|number }} + 8 × {{ sku|RUB|storage.bucket.used_space.standard|pricingRate.720|month|number }} + 50 × {{ sku|RUB|cdn.api.network.inet.egress|number }} %}