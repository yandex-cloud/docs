---
editable: false
---

# GEOINFO



#### Синтаксис {#syntax}


```
GEOINFO( address, scale )
```

#### Описание {#description}
{% if audience == "internal" %} Устаревшая функция. С 1 июня поля с этой функцией перестанут обновляться. Вместо значений будет возвращаться NULL. Подробности https://clubs.at.yandex-team.ru/datalens/132. {% endif %}
{% if audience != "internal" %} Преобразует `address` в название географического объекта (топоним), который соответствует указанному масштабу `scale`. {% endif %}
{% if audience != "internal" %} Допустимые значения параметра `scale`: {% endif %}
{% if audience != "internal" %} - `"country"`; {% endif %}
{% if audience != "internal" %} - `"country_code"`; {% endif %}
{% if audience != "internal" %} - `"region"`; {% endif %}
{% if audience != "internal" %} - `"locality"`. {% endif %}
{% if audience != "internal" %} Вычисляемое поле с этой функцией создается на уровне датасета. {% endif %}
{% if audience != "internal" %} Чтобы подключить функцию, перейдите на страницу [Настройки сервиса]({{ link-datalens-settings }}). {% endif %}

**Типы аргументов:**
- `address` — `Строка`
- `scale` — `Строка`


**Возвращаемый тип**: `Строка`

{% note info %}

Значения аргументов (`scale`) должны быть константами.

{% endnote %}


#### Пример {#examples}



| **[value]**                | **GEOINFO([value], 'country')**   |
|:---------------------------|:----------------------------------|
| `'Paris, France'`          | `'Франция'`                       |
| `'New York'`               | `'Соединённые Штаты Америки'`     |
| `'посёлок Свободный Серп'` | `'Россия'`                        |




#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`.
