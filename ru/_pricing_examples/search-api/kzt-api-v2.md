Расчет стоимости синхронных запросов:

> 250 000 × ({{ sku|KZT|searchapi.requests.sync.v3|string }} / 1 000) = {% calc [currency=KZT] 250 000 × ({{ sku|KZT|searchapi.requests.sync.v3|number }} / 1 000) %}
>
> Итого: {% calc [currency=KZT] 250 000 × ({{ sku|KZT|searchapi.requests.sync.v3|number }} / 1 000) %} — стоимость 250 000 синхронных запросов.
  
Где:

* 250 000 — количество синхронных запросов.
* {{ sku|KZT|searchapi.requests.sync.v3|string }} — стоимость за 1 000 синхронных запросов.
* {{ sku|KZT|searchapi.requests.sync.v3|string }} / 1 000 — стоимость за 1 синхронный запрос.

Расчет стоимости отложенных запросов:

> 50 000 × ({{ sku|KZT|searchapi.requests.async.v3|string }} / 1 000) = {% calc [currency=KZT] 50 000 × ({{ sku|KZT|searchapi.requests.async.v3|number }} / 1 000) %}
>
> Итого: {% calc [currency=KZT] 50 000 × ({{ sku|KZT|searchapi.requests.async.v3|number }} / 1 000) %} — стоимость 50 000 отложенных запросов.
  
Где:

* 50 000 — количество отложенных запросов.
* {{ sku|KZT|searchapi.requests.async.v3|string }} — стоимость за 1 000 отложенных запросов.
* {{ sku|KZT|searchapi.requests.async.v3|string }} / 1 000 — стоимость за 1 отложенный запрос.

Расчет стоимости синхронных запросов с генеративным ответом:

> 10 000 × ({% calc [currency=KZT] {{ sku|KZT|searchapi.generative.requests.v3|number }} × 1000 %} / 1 000) = {% calc [currency=KZT] 10 000 × {{ sku|KZT|searchapi.generative.requests.v3|number }} %}
>
> Итого: {% calc [currency=KZT] 10 000 × {{ sku|KZT|searchapi.generative.requests.v3|number }} %} — стоимость 10 000 синхронных запросов с генеративным ответом.
  
Где:

* 10 000 — количество синхронных запросов с генеративным ответом.
* {% calc [currency=KZT] {{ sku|KZT|searchapi.generative.requests.v3|number }} × 1000 %} — стоимость за 1 000 синхронных запросов с генеративным ответом.
* {% calc [currency=KZT] {{ sku|KZT|searchapi.generative.requests.v3|number }} × 1000 %} / 1 000 — стоимость за 1 синхронный запрос с генеративным ответом.

Расчет итоговой стоимости:

> {% calc [currency=KZT] 250 000 × ({{ sku|KZT|searchapi.requests.sync.v3|number }} / 1 000) %} + {% calc [currency=KZT] 50 000 × ({{ sku|KZT|searchapi.requests.async.v3|number }} / 1 000) %} + {% calc [currency=KZT] 10 000 × {{ sku|KZT|searchapi.generative.requests.v3|number }} %} = {% calc [currency=KZT] (250 000 × ({{ sku|KZT|searchapi.requests.sync.v3|number }} / 1 000)) +  (50 000 × ({{ sku|KZT|searchapi.requests.async.v3|number }} / 1 000)) + (10 000 × {{ sku|KZT|searchapi.generative.requests.v3|number }}) %}
>
> Итого: {% calc [currency=KZT] (250 000 × ({{ sku|KZT|searchapi.requests.sync.v3|number }} / 1 000)) +  (50 000 × ({{ sku|KZT|searchapi.requests.async.v3|number }} / 1 000)) + (10 000 × {{ sku|KZT|searchapi.generative.requests.v3|number }}) %} — стоимость всех поисковых запросов через API v2.

* {% calc [currency=KZT] 250 000 × ({{ sku|KZT|searchapi.requests.sync.v3|number }} / 1 000) %} — стоимость 250 000 синхронных запросов.
* {% calc [currency=KZT] 50 000 × ({{ sku|KZT|searchapi.requests.async.v3|number }} / 1 000) %} — стоимость 50 000 отложенных запросов.
* {% calc [currency=KZT] 10 000 × {{ sku|KZT|searchapi.generative.requests.v3|number }} %} — стоимость 10 000 синхронных запросов с генеративным ответом.