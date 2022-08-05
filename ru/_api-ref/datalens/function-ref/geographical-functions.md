---
title: Географические функции
editable: false
---

# Географические функции


## [GEOCODE](GEOCODE.md)

**Синтаксис:**`GEOCODE( address )`

{% if audience == "internal" %} Устаревшая функция. С 1 июня поля с этой функцией перестанут обновляться. Вместо значений будет возвращаться NULL. Подробности https://clubs.at.yandex-team.ru/datalens/132.{% endif %}
{% if audience != "internal" %} Преобразует адрес `address` в координаты. {% endif %}
{% if audience != "internal" %} Результаты выполнения функции кешируются, поэтому при повторном запросе {{ datalens-short-name }} не выполнит геокодирование. Время хранения кеша — 30 дней. {% endif %}
{% if audience != "internal" %} После 30 дней {{ datalens-short-name }} автоматически вызовет функцию `GEOCODE` для преобразования адреса. {% endif %}
{% if audience != "internal" %} Вычисляемое поле с этой функцией создается на уровне датасета. {% endif %}
{% if audience != "internal" %} Чтобы подключить функцию, перейдите на страницу [Настройки сервиса]({{ link-datalens-settings }}). {% endif %}



## [GEOINFO](GEOINFO.md)

**Синтаксис:**`GEOINFO( address, scale )`

{% if audience == "internal" %} Устаревшая функция. С 1 июня поля с этой функцией перестанут обновляться. Вместо значений будет возвращаться NULL. Подробности https://clubs.at.yandex-team.ru/datalens/132. {% endif %}
{% if audience != "internal" %} Преобразует `address` в название географического объекта (топоним), который соответствует указанному масштабу `scale`. {% endif %}
{% if audience != "internal" %} Допустимые значения параметра `scale`: {% endif %}
{% if audience != "internal" %} - `"country"`; {% endif %}
{% if audience != "internal" %} - `"country_code"`; {% endif %}
{% if audience != "internal" %} - `"region"`; {% endif %}
{% if audience != "internal" %} - `"locality"`. {% endif %}
{% if audience != "internal" %} Вычисляемое поле с этой функцией создается на уровне датасета. {% endif %}
{% if audience != "internal" %} Чтобы подключить функцию, перейдите на страницу [Настройки сервиса]({{ link-datalens-settings }}). {% endif %}



## [TOPONYM_TO_GEOPOINT](TOPONYM_TO_GEOPOINT.md)

**Синтаксис:**`TOPONYM_TO_GEOPOINT( name )`

{% if audience == "internal" %} Устаревшая функция. С 1 июня поля с этой функцией перестанут обновляться. Вместо значений будет возвращаться NULL. Подробности https://clubs.at.yandex-team.ru/datalens/132. {% endif %}
{% if audience != "internal" %} Преобразует топоним (название города, региона или страны) `name` в формат `Геоточка`. {% endif %}
{% if audience != "internal" %} См. полный [список топонимов]({{ geopoints-list-link }}). {% endif %}



## [TOPONYM_TO_GEOPOLYGON](TOPONYM_TO_GEOPOLYGON.md)

**Синтаксис:**`TOPONYM_TO_GEOPOLYGON( name )`

{% if audience == "internal" %} Устаревшая функция. С 1 июня поля с этой функцией перестанут обновляться. Вместо значений будет возвращаться NULL. Подробности https://clubs.at.yandex-team.ru/datalens/132. {% endif %}
{% if audience != "internal" %} Преобразует топоним (название города, региона или страны) `name` в формат `Геополигон`. {% endif %}
{% if audience != "internal" %} См. полный [список топонимов]({{ geopolygons-list-link }}). {% endif %}


