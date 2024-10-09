> {% calc [currency=KZT] 8 × {{ sku|KZT|alb.balancer.active|number }} %} × 720 = {% calc [currency=KZT] 8 × {{ sku|KZT|alb.balancer.active|number }} × 720 %}
>
> Итого: {% calc [currency=KZT] 8 × {{ sku|KZT|alb.balancer.active|number }} × 720 %} — стоимость использования балансировщика за месяц.

Где:

* {% calc [currency=KZT] 8 × {{ sku|KZT|alb.balancer.active|number }} %} — стоимость часа использования балансировщика.
* 720 — количество часов в месяц.