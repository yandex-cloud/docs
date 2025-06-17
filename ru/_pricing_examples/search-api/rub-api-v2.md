Расчет стоимости синхронных запросов:

> 250 000 × ({{ sku|RUB|searchapi.requests.sync.v3|string }} / 1 000) = {% calc [currency=RUB] 250 000 × ({{ sku|RUB|searchapi.requests.sync.v3|number }} / 1 000) %}
>
> Итого: {% calc [currency=RUB] 250 000 × ({{ sku|RUB|searchapi.requests.sync.v3|number }} / 1 000) %} — стоимость 250 000 синхронных запросов.
  
Где:

* 250 000 — количество синхронных запросов.
* {{ sku|RUB|searchapi.requests.sync.v3|string }} — стоимость за 1 000 синхронных запросов.
* {{ sku|RUB|searchapi.requests.sync.v3|string }} / 1 000 — стоимость за 1 синхронный запрос.

Расчет стоимости отложенных запросов:

> 50 000 × ({{ sku|RUB|searchapi.requests.async.v3|string }} / 1 000) = {% calc [currency=RUB] 50 000 × ({{ sku|RUB|searchapi.requests.async.v3|number }} / 1 000) %}
>
> Итого: {% calc [currency=RUB] 50 000 × ({{ sku|RUB|searchapi.requests.async.v3|number }} / 1 000) %} — стоимость 50 000 отложенных запросов.
  
Где:

* 50 000 — количество отложенных запросов.
* {{ sku|RUB|searchapi.requests.sync.v3|string }} — стоимость за 1 000 отложенный запросов.
* {{ sku|RUB|searchapi.requests.sync.v3|string }} / 1 000 — стоимость за 1 отложенный запрос.

Расчет стоимости синхронных запросов с генеративным ответом:

> 10 000 × ({% calc [currency=RUB] {{ sku|RUB|searchapi.generative.requests.v3|number }} × 1000 %} / 1 000) = {% calc [currency=RUB] 10 000 × {{ sku|RUB|searchapi.generative.requests.v3|number }} %}
>
> Итого: {% calc [currency=RUB] 10 000 × {{ sku|RUB|searchapi.generative.requests.v3|number }} %} — стоимость 10 000 синхронных запросов с генеративным ответом.
  
Где:

* 10 000 — количество синхронных запросов с генеративным ответом.
* {% calc [currency=RUB] {{ sku|RUB|searchapi.generative.requests.v3|number }} × 1000 %} — стоимость за 1 000 синхронных запросов с генеративным ответом.
* {% calc [currency=RUB] {{ sku|RUB|searchapi.generative.requests.v3|number }} × 1000 %} / 1 000 — стоимость за 1 синхронный запрос с генеративным ответом.

Расчет итоговой стоимости:

> {% calc [currency=RUB] 250 000 × ({{ sku|RUB|searchapi.requests.sync.v3|number }} / 1 000) %} + {% calc [currency=RUB] 50 000 × ({{ sku|RUB|searchapi.requests.async.v3|number }} / 1 000) %} + {% calc [currency=RUB] 10 000 × {{ sku|RUB|searchapi.generative.requests.v3|number }} %} = {% calc [currency=RUB] (250 000 × ({{ sku|RUB|searchapi.requests.sync.v3|number }} / 1 000)) +  (50 000 × ({{ sku|RUB|searchapi.requests.async.v3|number }} / 1 000)) + (10 000 × {{ sku|RUB|searchapi.generative.requests.v3|number }}) %}
>
> Итого: {% calc [currency=RUB] (250 000 × ({{ sku|RUB|searchapi.requests.sync.v3|number }} / 1 000)) +  (50 000 × ({{ sku|RUB|searchapi.requests.async.v3|number }} / 1 000)) + (10 000 × {{ sku|RUB|searchapi.generative.requests.v3|number }}) %} — стоимость всех поисковых запросов через API v2.

* {% calc [currency=RUB] 250 000 × ({{ sku|RUB|searchapi.requests.sync.v3|number }} / 1 000) %} — стоимость 250 000 синхронных запросов.
* {% calc [currency=RUB] 50 000 × ({{ sku|RUB|searchapi.requests.async.v3|number }} / 1 000) %} — стоимость 50 000 отложенных запросов.
* {% calc [currency=RUB] 10 000 × {{ sku|RUB|searchapi.generative.requests.v3|number }} %} — стоимость 10 000 синхронных запросов с генеративным ответом.