---
editable: false
---

{% if audience == "external" %}# TOPONYM_TO_GEOPOLYGON



#### Syntax {#syntax}


```
TOPONYM_TO_GEOPOLYGON( name )
```

#### Description {#description}
Converts the name of a geographical entity (country, region, city) `name` to the `Geopolygon` type.
See the full [list of toponyms]({{ geopolygons-list-link }}).

**Argument types:**
- `name` — `String`


**Return type**: `Geopolygon`

#### Example {#examples}

```
TOPONYM_TO_GEOPOLYGON("Алтайский край") = [[[53.290641,77.907506],[53.367469,77.889413], ... ]]
```


#### Data source support {#data-source-support}

`Materialized Dataset`.{% endif %}
