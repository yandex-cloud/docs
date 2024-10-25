> 5 × {{ sku|RUB|datalens.users.v1|string }} = {% calc [currency=RUB] 5 × {{ sku|RUB|datalens.users.v1|number }} %}
>
> Итого: {% calc [currency=RUB] 5 × {{ sku|RUB|datalens.users.v1|number }} %} — стоимость использования сервиса за август.
