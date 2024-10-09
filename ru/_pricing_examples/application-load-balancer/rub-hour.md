> 8 × {{ sku|RUB|alb.balancer.active|string }} = {% calc [currency=RUB] 8 × {{ sku|RUB|alb.balancer.active|number }} %}
>
> Итого: {% calc [currency=RUB] 8 × {{ sku|RUB|alb.balancer.active|number }} %} — стоимость часа использования балансировщика.

Где:

* 8 — количество ресурсных единиц.
* {{ sku|RUB|alb.balancer.active|string }} — цена ресурсной единицы.