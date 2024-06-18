---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/ARR_STR.md
---

# ARR_STR



#### Синтаксис {#syntax}


```
ARR_STR( array [ , delimiter [ , null_str ] ] )
```

#### Описание {#description}
Из элементов массива `array` формирует строку, используя `delimiter` в качестве разделителя (запятая по умолчанию) и `null_str` в качестве строки, подставляемой вместо `NULL` (по умолчанию такие элементы пропускаются и в результат не попадают).

См. также [STR](STR.md)

**Типы аргументов:**
- `array` — `Массив дробных чисел | Массив целых чисел | Массив строк`
- `delimiter` — `Строка`
- `null_str` — `Строка`


**Возвращаемый тип**: `Строка`

{% note info %}

Значения аргументов (`delimiter`, `null_str`) должны быть константами.

{% endnote %}


#### Примеры {#examples}

```
ARR_STR(ARRAY(1, 2, NULL, 4)) = 1,2,4
```

```
ARR_STR(ARRAY(1, 2, NULL, 4), ';') = 1;2;4
```

```
ARR_STR(ARRAY(1, 2, NULL, 4), ';', '*') = 1;2;*;4
```

```
ARR_STR(ARRAY('a', 'b', '', NULL), ';', '*') = a;b;;*
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `PostgreSQL 9.3`.
