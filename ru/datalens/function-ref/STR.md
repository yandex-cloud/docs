---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/STR.md
---

# STR



#### Синтаксис {#syntax}


```
STR( expression )
```

#### Описание {#description}
Переводит выражение `expression` к типу строки.

**Типы аргументов:**
- `expression` — `Массив дробных чисел | Массив целых чисел | Массив строк | Логический | Дата | Дата и время | Дробное число | Геоточка | Геополигон | Целое число | Строка | UUID`


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

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
