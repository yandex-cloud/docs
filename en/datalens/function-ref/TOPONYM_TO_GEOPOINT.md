---
editable: false

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# TOPONYM_TO_GEOPOINT



#### Syntax {#syntax}


```
TOPONYM_TO_GEOPOINT( name )
```

#### Description {#description}
Converts the name of a geographical entity (country, region, city) `name` to the `Geopoint` type.

**Argument types:**
- `name` — `String`


**Return type**: `Geopoint`

#### Examples {#examples}

```
TOPONYM_TO_GEOPOINT("Комсомольск-на-Амуре") = [50.549923,137.007948]
```


#### Data source support {#data-source-support}

`Materialized Dataset`.
