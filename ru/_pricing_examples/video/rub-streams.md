Стоимость транскодирования трансляции — `60 минут`:

> 60 × 2,60 ₽ = 156,00 ₽

Стоимость хранения записи трансляции — `3 ГБ` за месяц (720 часов):

> 3 × 720 × 0,003069 ₽ = 6,63 ₽

Стоимость исходящего трафика — `20 ГБ`:

> 20 × {{ sku|RUB|video.cdn.traffic.egress|string }} = {% calc [currency=RUB] 20 × {{ sku|RUB|video.cdn.traffic.egress|number }} %}

Общая стоимость трансляции за месяц составит:

> 156,00 ₽ + 6,63 ₽ + {% calc [currency=RUB] 20 × {{ sku|RUB|video.cdn.traffic.egress|number }} %} = {% calc [currency=RUB] 156,00 + 6,63 + 20 × {{ sku|RUB|video.cdn.traffic.egress|number }} %}