---
editable: false
---

# TOPONYM_TO_GEOPOLYGON



#### Syntax {#syntax}


```
TOPONYM_TO_GEOPOLYGON( name )
```

#### Description {#description}
{% if audience == "internal" %} It is a deprecated function. {% endif %}
{% if audience == "internal" %} Starting from 01.07.2022 this function will always return Null. {% endif %}
{% if audience == "internal" %} See also https://clubs.at.yandex-team.ru/datalens/132 {% endif %}
{% if audience != "internal" %} Converts the name of a geographical entity (country, region, city)`name` to the `Geopolygon` type. {% endif %}
{% if audience != "internal" %} See the full [list of toponyms]({{ geopolygons-list-link }}). {% endif %}

**Argument types:**
- `name` — `String`


**Return type**: `Geopolygon`

#### Example {#examples}

```
TOPONYM_TO_GEOPOLYGON("Алтайский край") = [[[53.290641,77.907506],[53.367469,77.889413], ... ]]
```


#### Data source support {#data-source-support}

`Materialized Dataset`.
