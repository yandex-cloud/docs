---
editable: false
---

{% if audience == "external" %}# TOPONYM_TO_GEOPOINT



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



| **[value]**              | **TOPONYM_TO_GEOPOINT([value])**   |
|:-------------------------|:-----------------------------------|
| `'Комсомольск-на-Амуре'` | `'[50.550055,137.008685]'`         |
| `'Рио-де-Жанейро'`       | `'[-22.905722,-43.189130]'`        |
| `'Пущино'`               | `'[54.832484,37.620986]'`          |




#### Data source support {#data-source-support}

`Materialized Dataset`.{% endif %}
