---
title: Geographical functions
editable: false
---

# Geographical functions


## [GEOCODE](GEOCODE.md)

**Syntax:**`GEOCODE( address )`

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



## [GEOINFO](GEOINFO.md)

**Syntax:**`GEOINFO( address, scale )`

{% if audience == "internal" %} It is a deprecated function. {% endif %}
{% if audience == "internal" %} Starting from 01.07.2022 this function will always return Null. {% endif %}
{% if audience == "internal" %} See also https://clubs.at.yandex-team.ru/datalens/132 {% endif %}
{% if audience != "internal" %} Converts `address` to geographical name corresponding to the specified `scale`. {% endif %}
{% if audience != "internal" %} Possible values for `scale` parameter: {% endif %}
{% if audience != "internal" %} - `"country"`; {% endif %}
{% if audience != "internal" %} - `"country_code"`; {% endif %}
{% if audience != "internal" %} - `"region"`; {% endif %}
{% if audience != "internal" %} - `"locality"`. {% endif %}
{% if audience != "internal" %} The calculated field using this function must be created at the dataset level. {% endif %}
{% if audience != "internal" %} To enable the function, go to the [Service Settings]({{ link-datalens-settings }}) page. {% endif %}



## [TOPONYM_TO_GEOPOINT](TOPONYM_TO_GEOPOINT.md)

**Syntax:**`TOPONYM_TO_GEOPOINT( name )`

{% if audience == "internal" %} It is a deprecated function. {% endif %}
{% if audience == "internal" %} Starting from 01.07.2022 this function will always return Null. {% endif %}
{% if audience == "internal" %} See also https://clubs.at.yandex-team.ru/datalens/132 {% endif %}
{% if audience != "internal" %} Converts the name of a geographical entity (country, region, city) `name` to the `Geopoint` type. {% endif %}
{% if audience != "internal" %} See the full [list of toponyms]({{ geopoints-list-link }}). {% endif %}



## [TOPONYM_TO_GEOPOLYGON](TOPONYM_TO_GEOPOLYGON.md)

**Syntax:**`TOPONYM_TO_GEOPOLYGON( name )`

{% if audience == "internal" %} It is a deprecated function. {% endif %}
{% if audience == "internal" %} Starting from 01.07.2022 this function will always return Null. {% endif %}
{% if audience == "internal" %} See also https://clubs.at.yandex-team.ru/datalens/132 {% endif %}
{% if audience != "internal" %} Converts the name of a geographical entity (country, region, city)`name` to the `Geopolygon` type. {% endif %}
{% if audience != "internal" %} See the full [list of toponyms]({{ geopolygons-list-link }}). {% endif %}


