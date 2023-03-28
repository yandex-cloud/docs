---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/CONTAINS_SUBSEQUENCE.md
---

# CONTAINS_SUBSEQUENCE



#### Синтаксис {#syntax}


```
CONTAINS_SUBSEQUENCE( array_1, array_2 )
```

#### Описание {#description}
Возвращает `TRUE`, если `array_2` является непрерывной подпоследовательностью `array_1`. Другими словами, возвращает `TRUE` исключительно если `array1 = prefix + array2 + suffix`.

**Типы аргументов:**
- `array_1` — `Массив дробных чисел | Массив целых числел | Массив строк`
- `array_2` — `Массив дробных чисел | Массив целых числел | Массив строк`


**Возвращаемый тип**: `Логический`

#### Пример {#examples}



| **[array1]**   | **[array2]**   | **CONTAINS_SUBSEQUENCE([array1], [array2])**   |
|:---------------|:---------------|:-----------------------------------------------|
| `'[1,2,3]'`    | `'[1,2]'`      | `True`                                         |
| `'[1,2,3]'`    | `'[2,1]'`      | `False`                                        |
| `'[1,2,3]'`    | `'[1,3]'`      | `False`                                        |




#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`.
