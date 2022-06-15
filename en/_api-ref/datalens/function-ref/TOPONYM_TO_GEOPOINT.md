---
editable: false
---

# TOPONYM_TO_GEOPOINT



#### Syntax {#syntax}


```
TOPONYM_TO_GEOPOINT( name )
```

#### Description {#description}
{% if audience == "internal" %} It is a deprecated function. {% endif %}
{% if audience == "internal" %} Starting from 01.07.2022 this function will always return Null. {% endif %}
{% if audience == "internal" %} See also https://clubs.at.yandex-team.ru/datalens/132 {% endif %}
{% if audience != "internal" %} Converts the name of a geographical entity (country, region, city) `name` to the `Geopoint` type. {% endif %}
{% if audience != "internal" %} See the full [list of toponyms]({{ geopoints-list-link }}). {% endif %}

**Argument types:**
- `name` — `String`


**Return type**: `Geopoint`

#### Example {#examples}



| **[value]**              | **TOPONYM_TO_GEOPOINT([value])**   |
|:-------------------------|:-----------------------------------|
| `'Комсомольск-на-Амуре'` | `'[50.550055,137.008685]'`         |
| `'Рио-де-Жанейро'`       | `'[-22.905722,-43.189130]'`        |
| `'Пущино'`               | `'[54.832484,37.620986]'`          |




#### Data source support {#data-source-support}

`Materialized Dataset`.
