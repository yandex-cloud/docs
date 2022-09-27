---
title: Географические функции
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/geographical-functions.md
---

# Географические функции

## [GEOCODE](GEOCODE.md)

**Синтаксис:**`GEOCODE( address )`

Преобразует адрес `address` в координаты.

Результаты выполнения функции кешируются, поэтому при повторном запросе {{ datalens-short-name }} не выполнит геокодирование. Время хранения кеша — 30 дней.
После 30 дней {{ datalens-short-name }} автоматически вызовет функцию `GEOCODE` для преобразования адреса.

Вычисляемое поле с этой функцией создается на уровне датасета.
Чтобы подключить функцию, перейдите на страницу [Настройки сервиса]({{ link-datalens-settings }}).

## [GEOINFO](GEOINFO.md)

**Синтаксис:**`GEOINFO( address, scale )`

Преобразует `address` в название географического объекта (топоним), который соответствует указанному масштабу `scale`.

Допустимые значения параметра`scale`:
- `"country"`;
- `"country_code"`;
- `"region"`;
- `"locality"`.

Вычисляемое поле с этой функцией создается на уровне датасета.
Чтобы подключить функцию, перейдите на страницу [Настройки сервиса]({{ link-datalens-settings }}).

## [TOPONYM_TO_GEOPOINT](TOPONYM_TO_GEOPOINT.md)

**Синтаксис:**`TOPONYM_TO_GEOPOINT( name )`

Преобразует топоним (название города, региона или страны) `name` в формат `Геоточка`.
См. полный [список топонимов]({{ geopoints-list-link }}).

## [TOPONYM_TO_GEOPOLYGON](TOPONYM_TO_GEOPOLYGON.md)

**Синтаксис:**`TOPONYM_TO_GEOPOLYGON( name )`

Преобразует топоним (название города, региона или страны) `name` в формат `Геополигон`.
См. полный [список топонимов]({{ geopolygons-list-link }}).

