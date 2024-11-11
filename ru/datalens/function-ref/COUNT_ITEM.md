---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/COUNT_ITEM.md
---

# COUNT_ITEM



#### Синтаксис {#syntax}


```
COUNT_ITEM( array, value )
```

#### Описание {#description}
Возвращает количество элементов массива `array`, равных `value`. Тип `value` должен соответствовать типу элементов `array`.

**Типы аргументов:**
- `array` — `Массив дробных чисел | Массив целых чисел | Массив строк`
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

`ClickHouse 21.8`, `Файлы`, `Google Sheets`, `PostgreSQL 9.3`, `Яндекс Документы`.
