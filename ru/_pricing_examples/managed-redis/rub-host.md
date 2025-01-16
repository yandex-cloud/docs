> 3 × (2&nbsp;×&nbsp;{{ sku|RUB|mdb.cluster.redis.v3.cpu.c100|string }} + 8&nbsp;×&nbsp;{{ sku|RUB|mdb.cluster.redis.v3.ram|string }}) = {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.cluster.redis.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.redis.v3.ram|number }}) %}
>
> Итого: {% calc [currency=RUB] 3 × (2 × {{ sku|RUB|mdb.cluster.redis.v3.cpu.c100|number }} + 8 × {{ sku|RUB|mdb.cluster.redis.v3.ram|number }}) %} — стоимость часа работы хостов {{ VLK }}.

Где:
* 3 — количество хостов {{ VLK }}.
* 2 — количество vCPU.
* {{ sku|RUB|mdb.cluster.redis.v3.cpu.c100|string }} — стоимость часа использования 100% vCPU.
* 8 — объем RAM одного хоста {{ VLK }} (в гигабайтах).
* {{ sku|RUB|mdb.cluster.redis.v3.ram|string }} — стоимость часа использования 1 ГБ RAM на 100% vCPU.