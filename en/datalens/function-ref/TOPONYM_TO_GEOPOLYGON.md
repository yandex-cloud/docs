---
editable: false

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# TOPONYM_TO_GEOPOLYGON



#### Syntax {#syntax}


```
TOPONYM_TO_GEOPOLYGON( name )
```

#### Description {#description}
Converts the name of a geographical entity (country, region, city) `name` to the `Geopolygon` type.

**Argument types:**
- `name` — `String`


**Return type**: `Geopolygon`

#### Examples {#examples}

```
TOPONYM_TO_GEOPOLYGON("Алтайский край") = [[[53.290641,77.907506],[53.367469,77.889413], ... ]]
```


#### Data source support {#data-source-support}

`Materialized Dataset`.
