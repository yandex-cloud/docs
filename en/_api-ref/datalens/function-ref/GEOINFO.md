---
editable: false
---

# GEOINFO



#### Syntax {#syntax}


```
GEOINFO( address, scale )
```

#### Description {#description}
{% if audience == "internal" %} It is a deprecated function. {% endif %}
{% if audience == "internal" %} Starting from 01.07.2022 this function will always return Null. {% endif %}
{% if audience == "internal" %} See also https://clubs.at.yandex-team.ru/datalens/132 {% endif %}
{% if audience != "internal" %} Converts `address` to geographical name corresponding to the specified `scale`. {% endif %}
{% if audience != "internal" %} {% endif %}
{% if audience != "internal" %} Possible values for `scale` parameter: {% endif %}
{% if audience != "internal" %} - `"country"`; {% endif %}
{% if audience != "internal" %} - `"country_code"`; {% endif %}
{% if audience != "internal" %} - `"region"`; {% endif %}
{% if audience != "internal" %} - `"locality"`. {% endif %}
{% if audience != "internal" %} {% endif %}
{% if audience != "internal" %} The calculated field using this function must be created at the dataset level. {% endif %}
{% if audience != "internal" %} To enable the function, go to the [Service Settings]({{ link-datalens-settings }}) page. {% endif %}

**Argument types:**
- `address` — `String`
- `scale` — `String`


**Return type**: `String`

{% note info %}

Only constant values are accepted for the arguments (`scale`).

{% endnote %}


#### Example {#examples}



| **[value]**                | **GEOINFO([value], 'country')**   |
|:---------------------------|:----------------------------------|
| `'Paris, France'`          | `'Франция'`                       |
| `'New York'`               | `'Соединённые Штаты Америки'`     |
| `'посёлок Свободный Серп'` | `'Россия'`                        |




#### Data source support {#data-source-support}

`Materialized Dataset`.
