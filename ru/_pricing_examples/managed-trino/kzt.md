> 720 × (8 × {{ sku|KZT|trino.cluster.generic.vcpu.v1|string }} + 32 × {{ sku|KZT|trino.cluster.generic.ram.v1|string }}) = {% calc [currency=KZT] 720 × (8 × {{ sku|KZT|trino.cluster.generic.vcpu.v1|number }} + 32 × {{ sku|KZT|trino.cluster.generic.ram.v1|number }}) %}
>
> Итого: {% calc [currency=KZT] 720 × (8 × {{ sku|KZT|trino.cluster.generic.vcpu.v1|number }} + 32 × {{ sku|KZT|trino.cluster.generic.ram.v1|number }}) %} — стоимость использования кластера в течение 30 дней.

Где:
* 720 — количество часов в 30 днях.
* 8 — общее количество 100% vCPU.
* {{ sku|KZT|trino.cluster.generic.vcpu.v1|string }} — стоимость часа использования 100% vCPU.
* 32 — общий объем RAM (в гигабайтах).
* {{ sku|KZT|trino.cluster.generic.ram.v1|string }} — стоимость часа использования 1 ГБ RAM.