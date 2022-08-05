---
editable: false
---

# GEOCODE



#### Syntax {#syntax}


```
GEOCODE( address )
```

#### Description {#description}
{% if audience == "internal" %} It is a deprecated function. {% endif %}
{% if audience == "internal" %} Starting from 01.07.2022 this function will always return Null. {% endif %}
{% if audience == "internal" %} See also https://clubs.at.yandex-team.ru/datalens/132 {% endif %}
{% if audience != "internal" %} Converts `address` to its geographical coordinates. {% endif %}
{% if audience != "internal" %} {{ datalens-short-name }} caches the function result. When the function is {% endif %}
{% if audience != "internal" %} invoked again, {{ datalens-short-name }} doesn't perform geocoding. {% endif %}
{% if audience != "internal" %} The cache lifetime is 30 days. After 30 days, {{ datalens-short-name }} {% endif %}
{% if audience != "internal" %} automatically invokes `GEOCODE` to convert addresses in the dataset. {% endif %}
{% if audience != "internal" %} The calculated field using this function must be created at the dataset level. {% endif %}
{% if audience != "internal" %} To enable the function, go to the [Service Settings]({{ link-datalens-settings }}) page. {% endif %}

**Argument types:**
- `address` — `String`


**Return type**: `Geopoint`

#### Example {#examples}



| **[value]**                | **GEOCODE([value])**       |
|:---------------------------|:---------------------------|
| `'Paris, France'`          | `'[48.856663,2.351556]'`   |
| `'New York'`               | `'[40.714606,-74.002800]'` |
| `'посёлок Свободный Серп'` | `'[53.650704,37.224461]'`  |




#### Data source support {#data-source-support}

`Materialized Dataset`.
