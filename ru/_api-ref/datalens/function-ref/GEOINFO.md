---
editable: false
---

{% if audience == "external" %}# GEOINFO



#### Синтаксис {#syntax}


```
GEOINFO( address, scale )
```

#### Описание {#description}
Преобразует `address` в название географического объекта (топоним), который соответствует указанному масштабу `scale`.

Допустимые значения параметра`scale`:
- `"country"`;
- `"country_code"`;
- `"region"`;
- `"locality"`.

Вычисляемое поле с этой функцией создается на уровне датасета.
Чтобы подключить функцию, перейдите на страницу [Настройки сервиса]({{ link-datalens-settings }}).

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

`Материализованный датасет`.{% endif %}