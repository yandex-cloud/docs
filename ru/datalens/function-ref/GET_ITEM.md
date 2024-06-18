---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/GET_ITEM.md
---

# GET_ITEM



#### Синтаксис {#syntax}


```
GET_ITEM( array, index )
```

#### Описание {#description}
Возвращает элемент с индексом `index` из массива `array`. Индекс должен быть целым числом. Индексы в массиве начинаются с единицы. Возвращает последний элемент из массива, если значение `index` равно `-1`.

**Типы аргументов:**
- `array` — `Массив дробных чисел | Массив целых чисел | Массив строк`
- `index` — `Целое число`


**Возвращаемый тип**: Зависит от типов аргументов

#### Пример {#examples}

```
GET_ITEM([array_field], 2)
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `PostgreSQL 9.3`.
