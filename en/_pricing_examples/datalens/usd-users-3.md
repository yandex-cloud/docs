> 5 × {{ sku|USD|datalens.users.v1|string }} = {% calc [currency=USD] 5 × {{ sku|USD|datalens.users.v1|number }} %}
>
> Total: {% calc [currency=USD] 5 × {{ sku|USD|datalens.users.v1|number }} %}, cost of using the service for August.
