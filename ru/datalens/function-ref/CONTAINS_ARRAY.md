---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/CONTAINS_ARRAY.md
---

# CONTAINS (массивы)

_Функция `CONTAINS` также доступна в следующих категориях: [Строковые функции](CONTAINS.md)._

#### Синтаксис {#syntax}


```
CONTAINS( array, value )
```

#### Описание {#description}
Возвращает `TRUE`, если `array` содержит `value`.

**Типы аргументов:**
- `array` — `Массив дробных чисел | Массив целых чисел | Массив строк`
- `value` — `Дробное число | Целое число | Строка`


**Возвращаемый тип**: `Логический`

#### Пример {#examples}



| **[array]**   | **[value]**   | **CONTAINS([array], [value])**   |
|:--------------|:--------------|:---------------------------------|
| `'[1,2,3]'`   | `2`           | `True`                           |
| `'[1,2,3]'`   | `4`           | `False`                          |




#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `PostgreSQL 9.3`.
