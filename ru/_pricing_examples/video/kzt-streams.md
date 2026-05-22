Стоимость транскодирования трансляции — `60 минут`:

> 60 × {{ sku|KZT|video.transcoding.live.v1|string }} = {% calc [currency=KZT] 60 × {{ sku|KZT|video.transcoding.live.v1|number }} %}

Стоимость хранения записи трансляции — `3 ГБ` за месяц (720 часов):

> 3 × 720 × {{ sku|KZT|video.used_space.live.v1|string }} = {% calc [currency=KZT] 3 × 720 × {{ sku|KZT|video.used_space.live.v1|number }} %}

Стоимость исходящего трафика — `20 ГБ`:

> 20 × {{ sku|KZT|video.cdn.traffic.egress|string }} = {% calc [currency=KZT] 20 × {{ sku|KZT|video.cdn.traffic.egress|number }} %}

Общая стоимость трансляции за месяц составит:

> {% calc [currency=KZT] 60 × {{ sku|KZT|video.transcoding.live.v1|number }} %} + {% calc [currency=KZT] 3 × 720 × {{ sku|KZT|video.used_space.live.v1|number }} %} + {% calc [currency=KZT] 20 × {{ sku|KZT|video.cdn.traffic.egress|number }} %} = {% calc [currency=KZT] 60 × {{ sku|KZT|video.transcoding.live.v1|number }} + 3 × 720 × {{ sku|KZT|video.used_space.live.v1|number }} + 20 × {{ sku|KZT|video.cdn.traffic.egress|number }} %}