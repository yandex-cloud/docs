> 3 × (2&nbsp;×&nbsp;{{ sku|KZT|mdb.cluster.redis.v3.cpu.c100|string }} + 8&nbsp;×&nbsp;{{ sku|KZT|mdb.cluster.redis.v3.ram|string }}) = {% calc [currency=KZT] 3 × (2 × {{ sku|KZT|mdb.cluster.redis.v3.cpu.c100|number }} + 8 × {{ sku|KZT|mdb.cluster.redis.v3.ram|number }}) %}
>
> Итого: {% calc [currency=KZT] 3 × (2 × {{ sku|KZT|mdb.cluster.redis.v3.cpu.c100|number }} + 8 × {{ sku|KZT|mdb.cluster.redis.v3.ram|number }}) %} — стоимость часа работы хостов {{ RD }}.

Где:
* 3 — количество хостов {{ RD }}.
* 2 — количество vCPU.
* {{ sku|KZT|mdb.cluster.redis.v3.cpu.c100|string }} — стоимость часа использования 100% vCPU.
* 8 — объем RAM одного хоста {{ RD }} (в гигабайтах).
* {{ sku|KZT|mdb.cluster.redis.v3.ram|string }} — стоимость часа использования 1 ГБ RAM на 100% vCPU.