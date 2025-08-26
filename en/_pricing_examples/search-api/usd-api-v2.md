Cost calculation for synchronous requests:

> 250,000 × ({{ sku|USD|searchapi.requests.sync.v3|string }} / 1 000) = {% calc [currency=USD] 250 000 × ({{ sku|USD|searchapi.requests.sync.v3|number }} / 1 000) %}
>
> Total: {% calc [currency=USD] 250 000 × ({{ sku|USD|searchapi.requests.sync.v3|number }} / 1 000) %}, cost of 250,000 synchronous requests.
  
Where:

* 250,000: Number of synchronous requests.
* {{ sku|USD|searchapi.requests.sync.v3|string }}: Cost of 1,000 synchronous requests.
* {{ sku|USD|searchapi.requests.sync.v3|string }} / 1,000: Cost per synchronous request.

Cost calculation for deferred requests:

> 50,000 × ({{ sku|USD|searchapi.requests.async.v3|string }} / 1 000) = {% calc [currency=USD] 50 000 × ({{ sku|USD|searchapi.requests.async.v3|number }} / 1 000) %}
>
> Total: {% calc [currency=USD] 50 000 × ({{ sku|USD|searchapi.requests.async.v3|number }} / 1 000) %}, cost of 50,000 deferred requests.
  
Where:

* 50,000: Number of deferred requests.
* {{ sku|USD|searchapi.requests.async.v3|string }}: Cost of 1,000 deferred requests.
* {{ sku|USD|searchapi.requests.async.v3|string }} / 1,000: Cost per deferred request.

Cost calculation for synchronous requests with generative response:

> 10,000 × ({% calc [currency=USD] {{ sku|USD|searchapi.generative.requests.v3|number }} × 1000 %} / 1,000) = {% calc [currency=USD] 10 000 × {{ sku|USD|searchapi.generative.requests.v3|number }} %}
>
> Total: {% calc [currency=USD] 10 000 × {{ sku|USD|searchapi.generative.requests.v3|number }} %}, cost of 10,000 synchronous requests with generative response.
  
Where:

* 10,000: Number of synchronous requests with generative response.
* {% calc [currency=USD] {{ sku|USD|searchapi.generative.requests.v3|number }} × 1000 %}: Cost of 1,000 synchronous requests with generative response.
* {% calc [currency=USD] {{ sku|USD|searchapi.generative.requests.v3|number }} × 1000 %} / 1,000: Cost per synchronous request with generative response.

Total cost calculation:

> {% calc [currency=USD] 250 000 × ({{ sku|USD|searchapi.requests.sync.v3|number }} / 1 000) %} + {% calc [currency=USD] 50 000 × ({{ sku|USD|searchapi.requests.async.v3|number }} / 1 000) %} + {% calc [currency=USD] 10 000 × {{ sku|USD|searchapi.generative.requests.v3|number }} %} = {% calc [currency=USD] (250 000 × ({{ sku|USD|searchapi.requests.sync.v3|number }} / 1 000)) + (50 000 × ({{ sku|USD|searchapi.requests.async.v3|number }} / 1 000)) + (10 000 × {{ sku|USD|searchapi.generative.requests.v3|number }}) %}
>
> Total: {% calc [currency=USD] (250 000 × ({{ sku|USD|searchapi.requests.sync.v3|number }} / 1 000)) + (50 000 × ({{ sku|USD|searchapi.requests.async.v3|number }} / 1 000)) + (10 000 × {{ sku|USD|searchapi.generative.requests.v3|number }}) %}, cost of all search requests through API v2.

* {% calc [currency=USD] 250 000 × ({{ sku|USD|searchapi.requests.sync.v3|number }} / 1 000) %}, cost of 250,000 synchronous requests.
* {% calc [currency=USD] 50 000 × ({{ sku|USD|searchapi.requests.async.v3|number }} / 1 000) %}, cost of 50,000 deferred requests.
* {% calc [currency=USD] 10 000 × {{ sku|USD|searchapi.generative.requests.v3|number }} %}, cost of 10,000 synchronous requests with generative response.