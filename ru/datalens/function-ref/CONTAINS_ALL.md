---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/CONTAINS_ALL.md
---

# CONTAINS_ALL



#### Синтаксис {#syntax}


```
CONTAINS_ALL( array_1, array_2 )
```

#### Описание {#description}
Возвращает `TRUE`, если `array_1` содержит все элементы `array_2`.

**Типы аргументов:**
- `array_1` — `Массив дробных чисел | Массив целых числел | Массив строк`
- `array_2` — `Массив дробных чисел | Массив целых числел | Массив строк`


**Возвращаемый тип**: `Логический`

#### Пример {#examples}



| **[array1]**   | **[array2]**   | **CONTAINS_ALL([array1], [array2])**   |
|:---------------|:---------------|:---------------------------------------|
| `'[1,2,3]'`    | `'[1,2]'`      | `True`                                 |
| `'[1,2,3]'`    | `'[1,4]'`      | `False`                                |




#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `PostgreSQL 9.3`.
