---
editable: false
---

# TOPONYM_TO_GEOPOINT

_Geographical functions_

#### Syntax


```
TOPONYM_TO_GEOPOINT( name )
```

#### Description
Converts the name of a geographical entity (country, region, city) `name` to the `Geopoint` type.

**Argument types:**
- `name` — `String`


**Return type**: `Geopoint`

#### Examples

```
TOPONYM_TO_GEOPOINT("Комсомольск-на-Амуре") = [50.549923,137.007948]
```


#### Data source support

`Materialized Dataset`.
