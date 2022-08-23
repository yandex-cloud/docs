---
editable: false
---

# STR



#### Синтаксис {#syntax}


```
STR( expression )
```

#### Описание {#description}
Переводит выражение `expression` к типу строки.

**Типы аргументов:**
- `expression` — `Массив дробных чисел | Массив целых числел | Массив строк | Логический | Дата | Дата и время | Дата и время (устаревший) | Дробное число | Геоточка | Геополигон | Целое число | Строка | UUID`


**Возвращаемый тип**: `Строка`

{% note info %}

Если передан массив (только для источников `ClickHouse`, `PostgreSQL`), то преобразование осуществляется функцией источника и результат для разных источников может отличаться. Для получения одинакового результата используйте [ARR_STR](ARR_STR.md).

{% endnote %}


#### Примеры {#examples}

```
STR(77) = "77"
```

```
STR(1 != 1) = "False"
```

```
STR(#2019-01-01#) = "2019-01-01"
```

```
STR(ARRAY(1, 2, 3, NULL)) = {1,2,3,NULL}  PostgreSQL
```

```
STR(ARRAY(1, 2, 3, NULL)) = [1,2,3,NULL]  ClickHouse
```

```
STR(ARRAY('a', 'b', '', NULL)) = {a,b,,NULL}  PostgreSQL
```

```
STR(ARRAY('a', 'b', '', NULL)) = ['a','b','',NULL]  ClickHouse
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
