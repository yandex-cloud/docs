> 2 × {{ sku|RUB|datalens.users.v1|string }} = {% calc [currency=RUB] 2 × {{ sku|RUB|datalens.users.v1|number }} %}
>
> Итого: {% calc [currency=RUB] 2 × {{ sku|RUB|datalens.users.v1|number }} %} — стоимость использования сервиса за июль.
