Стоимость транскодирования трансляции — `60 минут`:

> 60 × 13,24 ₸ = 794,40 ₸

Стоимость хранения записи трансляции — `3 ГБ` за месяц (720 часов):

> 3 × 720 × 0,015639 ₸ = 33,78 ₸

Стоимость исходящего трафика — `20 ГБ`:

> 20 × {{ sku|KZT|video.cdn.traffic.egress|string }} = {% calc [currency=KZT] 20 × {{ sku|KZT|video.cdn.traffic.egress|number }} %}

Общая стоимость трансляции за месяц составит:

> 794,40 ₸ + 33,78 ₸ + {% calc [currency=KZT] 20 × {{ sku|KZT|video.cdn.traffic.egress|number }} %} = {% calc [currency=KZT] 794,40 + 33,78 + 20 × {{ sku|KZT|video.cdn.traffic.egress|number }} %}