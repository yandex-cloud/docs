---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/SLICE.md
---

# SLICE



#### Синтаксис {#syntax}


```
SLICE( array, offset, length )
```

#### Описание {#description}
Возвращает часть массива `array` длины `length`, начиная с индекса `offset`. Индексы в массиве начинаются с единицы.

**Типы аргументов:**
- `array` — `Массив дробных чисел | Массив целых чисел | Массив строк`
- `offset` — `Целое число`
- `length` — `Целое число`


**Возвращаемый тип**: Совпадает с типом аргументов (`array`)

{% note info %}

Значения аргументов (`offset`, `length`) должны быть константами.

{% endnote %}


#### Примеры {#examples}

```
SLICE(ARRAY(1, 2, 3, 4, 5), 3, 2) = [3, 4]
```

```
SLICE(ARRAY(1, 2, 3, 4, 5), 3, 1) = [3]
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `PostgreSQL 9.3`.
