> 720 × (3 × {{ sku|RUB|airflow.cluster.generic.vcpu.v1|string }} + 12 × {{ sku|RUB|airflow.cluster.generic.ram.v1|string }}) = {% calc [currency=RUB] 720 × (3 × {{ sku|RUB|airflow.cluster.generic.vcpu.v1|number }} + 12 × {{ sku|RUB|airflow.cluster.generic.ram.v1|number }}) %}
>
> Итого: {% calc [currency=RUB] 720 × (3 × {{ sku|RUB|airflow.cluster.generic.vcpu.v1|number }} + 12 × {{ sku|RUB|airflow.cluster.generic.ram.v1|number }}) %} — стоимость использования кластера в течение 30 дней.

Где:
* 720 — количество часов в 30 днях.
* 3 — общее количество 100% vCPU.
* {{ sku|RUB|airflow.cluster.generic.vcpu.v1|string }} — стоимость часа использования 100% vCPU.
* 12 — общий объем RAM (в гигабайтах).
* {{ sku|RUB|airflow.cluster.generic.ram.v1|string }} — стоимость часа использования 1 ГБ RAM.