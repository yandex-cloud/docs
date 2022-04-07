---
editable: false
---

# COUNT_ITEM



#### Синтаксис {#syntax}


```
COUNT_ITEM( array, value )
```

#### Описание {#description}
Возвращает количество элементов массива `array`, равных `value`. Тип `value` должен соответствовать типу элементов `array`.

**Типы аргументов:**
- `array` — `Массив дробных чисел | Массив целых числел | Массив строк`
- `value` — `Дробное число | Целое число | Строка`


**Возвращаемый тип**: `Целое число`

#### Примеры {#examples}

```
COUNT_ITEM(ARRAY(1, 2, 2, 3), 2) = 2
```

```
COUNT_ITEM(ARRAY(1, 2, 2, 3), 4) = 0
```

```
COUNT_ITEM(ARRAY(1, NULL, 2, NULL), NULL) = 2
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `PostgreSQL 9.3`.
