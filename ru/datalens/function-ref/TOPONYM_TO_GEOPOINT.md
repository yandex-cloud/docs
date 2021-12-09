---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/TOPONYM_TO_GEOPOINT.md
---


# TOPONYM_TO_GEOPOINT



#### Синтаксис {#syntax}


```
TOPONYM_TO_GEOPOINT( name )
```

#### Описание {#description}
Преобразует топоним (название города, региона или страны) `name` в формат `Геоточка`.
См. полный [список топонимов]({{ geopoints-list-link }}).

**Типы аргументов:**
- `name` — `Строка`


**Возвращаемый тип**: `Геоточка`

#### Пример {#examples}

```
TOPONYM_TO_GEOPOINT("Комсомольск-на-Амуре") = [50.549923,137.007948]
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`.
