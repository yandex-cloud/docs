> 720 × (24 × {{ sku|KZT|spark.cluster.generic.vcpu.v2|string }} + 96 × {{ sku|KZT|spark.cluster.generic.ram.v2|string }}) = {% calc [currency=KZT] 720 × (24 × {{ sku|KZT|spark.cluster.generic.vcpu.v2|number }} + 96 × {{ sku|KZT|spark.cluster.generic.ram.v2|number }}) %}
>
> Итого: {% calc [currency=KZT] 720 × (24 × {{ sku|KZT|spark.cluster.generic.vcpu.v2|number }} + 96 × {{ sku|KZT|spark.cluster.generic.ram.v2|number }}) %} — стоимость использования кластера в течение 30 дней.

Где:
* 720 — количество часов в 30 днях.
* 24 — общее количество vCPU.
* {{ sku|KZT|spark.cluster.generic.vcpu.v2|string }} — стоимость часа использования 1 vCPU.
* 96 — общий объем RAM (в гигабайтах).
* {{ sku|KZT|spark.cluster.generic.ram.v2|string }} — стоимость часа использования 1 ГБ RAM.
