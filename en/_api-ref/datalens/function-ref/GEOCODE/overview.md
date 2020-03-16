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
