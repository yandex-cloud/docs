---
editable: false
---

# TOPONYM_TO_GEOPOINT



#### Syntax {#syntax}


```
TOPONYM_TO_GEOPOINT( name )
```

#### Description {#description}
Converts the name of a geographical entity (country, region, city) `name` to the `Geopoint` type.
See the full [list of toponyms]({{ geopoints-list-link }}).

**Argument types:**
- `name` — `String`


**Return type**: `Geopoint`

#### Example {#examples}

```
TOPONYM_TO_GEOPOINT("Комсомольск-на-Амуре") = [50.549923,137.007948]
```


#### Data source support {#data-source-support}

`Materialized Dataset`.
