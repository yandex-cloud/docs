---
editable: false
---

# TOPONYM_TO_GEOPOLYGON



#### Синтаксис {#syntax}


```
TOPONYM_TO_GEOPOLYGON( name )
```

#### Описание {#description}
{% if audience == "internal" %} Устаревшая функция. С 1 июня поля с этой функцией перестанут обновляться. Вместо значений будет возвращаться NULL. Подробности https://clubs.at.yandex-team.ru/datalens/132. {% endif %}
{% if audience != "internal" %} Преобразует топоним (название города, региона или страны) `name` в формат `Геополигон`. {% endif %}
{% if audience != "internal" %} См. полный [список топонимов]({{ geopolygons-list-link }}). {% endif %}

**Типы аргументов:**
- `name` — `Строка`


**Возвращаемый тип**: `Геополигон`

#### Пример {#examples}

```
TOPONYM_TO_GEOPOLYGON("Алтайский край") = [[[53.290641,77.907506],[53.367469,77.889413], ... ]]
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`.
