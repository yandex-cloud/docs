---
editable: false
---

# Географические функции


## [GEOCODE](GEOCODE.md)

**Синтаксис:**`GEOCODE( address )`

Преобразует адрес `address` в координаты.

Результаты выполнения функции кэшируются, поэтому при повторном запросе {{ datalens-short-name }} не выполнит геокодирование. Время хранения кэша — 30 дней.
После 30 дней {{ datalens-short-name }} автоматически вызовет функцию `GEOCODE` для преобразования адреса.



## [GEOINFO](GEOINFO.md)

**Синтаксис:**`GEOINFO( address, scale )`

Преобразует `address` в название географического объекта (топоним), который соответствует указанному масштабу `scale`.

Допустимые значения параметра`scale`:
- `"country"`,
- `"country_code"`,
- `"region"`,
- `"locality"`.



## [TOPONYM_TO_GEOPOINT](TOPONYM_TO_GEOPOINT.md)

**Синтаксис:**`TOPONYM_TO_GEOPOINT( name )`

Преобразует топоним (название города, региона или страны) `name` в формат `Геоточка`.



## [TOPONYM_TO_GEOPOLYGON](TOPONYM_TO_GEOPOLYGON.md)

**Синтаксис:**`TOPONYM_TO_GEOPOLYGON( name )`

Преобразует топоним (название города, региона или страны) `name` в формат `Геополигон`.


