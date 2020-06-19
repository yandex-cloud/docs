---
editable: false
---

# TOPONYM_TO_GEOPOLYGON

_Geographical functions_

#### Syntax


```
TOPONYM_TO_GEOPOLYGON( name )
```

#### Description
Converts the name of a geographical entity (country, region, city) `name` to the `Geopolygon` type.

**Argument types:**
- `name` — `String`


**Return type**: `Geopolygon`

#### Examples

```
TOPONYM_TO_GEOPOLYGON("Алтайский край") = [[[53.290641,77.907506],[53.367469,77.889413], ... ]]
```


#### Data source support

`Materialized Dataset`.
