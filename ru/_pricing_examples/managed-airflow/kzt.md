> 720 × (3 × {{ sku|KZT|airflow.cluster.generic.vcpu.v1|string }} + 12 × {{ sku|KZT|airflow.cluster.generic.ram.v1|string }}) = {% calc [currency=KZT] 720 × (3 × {{ sku|KZT|airflow.cluster.generic.vcpu.v1|number }} + 12 × {{ sku|KZT|airflow.cluster.generic.ram.v1|number }}) %}
>
> Итого: {% calc [currency=KZT] 720 × (3 × {{ sku|KZT|airflow.cluster.generic.vcpu.v1|number }} + 12 × {{ sku|KZT|airflow.cluster.generic.ram.v1|number }}) %} — стоимость использования кластера в течение 30 дней.

Где:
* 720 — количество часов в 30 днях.
* 3 — общее количество 100% vCPU.
* {{ sku|KZT|airflow.cluster.generic.vcpu.v1|string }} — стоимость часа использования 100% vCPU.
* 12 — общий объем RAM (в гигабайтах).
* {{ sku|KZT|airflow.cluster.generic.ram.v1|string }} — стоимость часа использования 1 ГБ RAM.