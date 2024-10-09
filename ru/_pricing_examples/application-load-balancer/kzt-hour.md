> 8 × {{ sku|KZT|alb.balancer.active|string }} = {% calc [currency=KZT] 8 × {{ sku|KZT|alb.balancer.active|number }} %}
>
> Итого: {% calc [currency=KZT] 8 × {{ sku|KZT|alb.balancer.active|number }} %} — стоимость часа использования балансировщика.

Где:

* 8 — количество ресурсных единиц.
* {{ sku|KZT|alb.balancer.active|string }} — цена ресурсной единицы.