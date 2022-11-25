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
- `array` — `Массив дробных чисел | Массив целых числел | Массив строк`
- `value` — `Дробное число | Целое число | Строка`


**Возвращаемый тип**: `Логический`

#### Примеры {#examples}

```
CONTAINS(ARRAY(1, 2, 3), 2) = TRUE
```

```
CONTAINS(ARRAY(1, 2, 3), 4) = FALSE
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `PostgreSQL 9.3`.
