---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/STARTSWITH_ARRAY.md
---

# STARTSWITH (массивы)

_Функция `STARTSWITH` также доступна в следующих категориях: [Строковые функции](STARTSWITH.md)._

#### Синтаксис {#syntax}


```
STARTSWITH( array_1, array_2 )
```

#### Описание {#description}
Возвращает `TRUE`, если значения из массива `array_2` находятся в начале массива `array_1`.

**Типы аргументов:**
- `array_1` — `Массив дробных чисел | Массив целых числел | Массив строк`
- `array_2` — `Массив дробных чисел | Массив целых числел | Массив строк`


**Возвращаемый тип**: `Логический`

#### Примеры {#examples}

```
STARTSWITH(ARRAY(1, 2, 3), ARRAY(1, 2)) = TRUE
```

```
STARTSWITH(ARRAY(1, 2, 3), ARRAY(2, 3)) = FALSE
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `PostgreSQL 9.3`.
