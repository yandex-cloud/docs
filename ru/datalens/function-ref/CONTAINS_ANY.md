---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/CONTAINS_ANY.md
---

# CONTAINS_ANY



#### Синтаксис {#syntax}


```
CONTAINS_ANY( array_1, array_2 )
```

#### Описание {#description}
Возвращает `TRUE`, если `array_1` содержит хотя бы один элемент из `array_2`.

**Типы аргументов:**
- `array_1` — `Массив дробных чисел | Массив целых чисел | Массив строк`
- `array_2` — `Массив дробных чисел | Массив целых чисел | Массив строк`


**Возвращаемый тип**: `Логический`

#### Пример {#examples}



| **[array1]**   | **[array2]**   | **CONTAINS_ANY([array1], [array2])**   |
|:---------------|:---------------|:---------------------------------------|
| `'[1,2,3]'`    | `'[1,5]'`      | `True`                                 |
| `'[1,2,3]'`    | `'[4,5]'`      | `False`                                |




#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `PostgreSQL 9.3`.
