---
title: Geographical functions
editable: false
---

# Geographical functions


## [GEOCODE](GEOCODE.md)

**Syntax:**`GEOCODE( address )`

Converts `address` to its geographical coordinates.

{{ datalens-short-name }} caches the function result. When the function is invoked again, {{ datalens-short-name }} doesn't perform geocoding. The cache lifetime is 30 days.After 30 days, {{ datalens-short-name }} automatically invokes `GEOCODE` to convert addresses in the dataset.

To enable the function, go to the [Service Settings](https://datalens.yandex.com/settings) page.



## [GEOINFO](GEOINFO.md)

**Syntax:**`GEOINFO( address, scale )`

Converts `address` to geographical name corresponding to the specified `scale`.

Possible values for `scale` parameter:
- `"country"`;
- `"country_code"`;
- `"region"`;
- `"locality"`.

To enable the function, go to the [Service Settings](https://datalens.yandex.com/settings) page.



## [TOPONYM_TO_GEOPOINT](TOPONYM_TO_GEOPOINT.md)

**Syntax:**`TOPONYM_TO_GEOPOINT( name )`

Converts the name of a geographical entity (country, region, city) `name` to the `Geopoint` type.



## [TOPONYM_TO_GEOPOLYGON](TOPONYM_TO_GEOPOLYGON.md)

**Syntax:**`TOPONYM_TO_GEOPOLYGON( name )`

Converts the name of a geographical entity (country, region, city) `name` to the `Geopolygon` type.


