---
editable: false
---

{% if audience == "external" %}# TOPONYM_TO_GEOPOLYGON



#### Синтаксис {#syntax}


```
TOPONYM_TO_GEOPOLYGON( name )
```

#### Описание {#description}
Преобразует топоним (название города, региона или страны) `name` в формат `Геополигон`.
См. полный [список топонимов]({{ geopolygons-list-link }}).

**Типы аргументов:**
- `name` — `Строка`


**Возвращаемый тип**: `Геополигон`

#### Пример {#examples}

```
TOPONYM_TO_GEOPOLYGON("Алтайский край") = [[[53.290641,77.907506],[53.367469,77.889413], ... ]]
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`.{% endif %}
