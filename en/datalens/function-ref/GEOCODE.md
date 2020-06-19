---
editable: false
---

# GEOCODE

_Geographical functions_

#### Syntax


```
GEOCODE( address )
```

#### Description
Converts `address` to its geographical coordinates.

{{ datalens-short-name }} caches the function result. When the function is invoked again, {{ datalens-short-name }} doesn't perform geocoding. The cache lifetime is 30 days.After 30 days, {{ datalens-short-name }} automatically invokes `GEOCODE` to convert addresses in the dataset.

**Argument types:**
- `address` — `String`


**Return type**: `Geopoint`

{% note warning %}

Function is available only with the Standard billing plan.

{% endnote %}


#### Examples

```
GEOCODE("посёлок Свободный Серп") = [53.650704, 37.224461]
```


#### Data source support

`Materialized Dataset`.
