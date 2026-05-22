Стоимость транскодирования трансляции — `60 минут`:

> 60 × {{ sku|RUB|video.transcoding.live.v1|string }} = {% calc [currency=RUB] 60 × {{ sku|RUB|video.transcoding.live.v1|number }} %}

Стоимость хранения записи трансляции — `3 ГБ` за месяц (720 часов):

> 3 × 720 × {{ sku|RUB|video.used_space.live.v1|string }} = {% calc [currency=RUB] 3 × 720 × {{ sku|RUB|video.used_space.live.v1|number }} %}

Стоимость исходящего трафика — `20 ГБ`:

> 20 × {{ sku|RUB|video.cdn.traffic.egress|string }} = {% calc [currency=RUB] 20 × {{ sku|RUB|video.cdn.traffic.egress|number }} %}

Общая стоимость трансляции за месяц составит:

> {% calc [currency=RUB] 60 × {{ sku|RUB|video.transcoding.live.v1|number }} %} + {% calc [currency=RUB] 3 × 720 × {{ sku|RUB|video.used_space.live.v1|number }} %} + {% calc [currency=RUB] 20 × {{ sku|RUB|video.cdn.traffic.egress|number }} %} = {% calc [currency=RUB] 60 × {{ sku|RUB|video.transcoding.live.v1|number }} + 3 × 720 × {{ sku|RUB|video.used_space.live.v1|number }} + 20 × {{ sku|RUB|video.cdn.traffic.egress|number }} %}