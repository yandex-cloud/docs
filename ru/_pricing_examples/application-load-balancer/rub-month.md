> {% calc [currency=RUB] 8 × {{ sku|RUB|alb.balancer.active|number }} %} × 720 = {% calc [currency=RUB] 8 × {{ sku|RUB|alb.balancer.active|number }} × 720 %}
>
> Итого: {% calc [currency=RUB] 8 × {{ sku|RUB|alb.balancer.active|number }} × 720 %} — стоимость использования балансировщика за месяц.

Где:

* {% calc [currency=RUB] 8 × {{ sku|RUB|alb.balancer.active|number }} %} — стоимость часа использования балансировщика.
* 720 — количество часов в месяц.