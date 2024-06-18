---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/LEN_ARRAY.md
---

# LEN (массивы)

_Функция `LEN` также доступна в следующих категориях: [Строковые функции](LEN.md)._

#### Синтаксис {#syntax}


```
LEN( value )
```

#### Описание {#description}
Возвращает количество элементов в массиве `value`.

**Типы аргументов:**
- `value` — `Массив дробных чисел | Массив целых чисел | Массив строк`


**Возвращаемый тип**: `Целое число`

#### Примеры {#examples}

```
LEN(ARRAY(1, 2, 3)) = 3
```

```
LEN(ARRAY('a', 'b', NULL, 'c')) = 4
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `PostgreSQL 9.3`.
