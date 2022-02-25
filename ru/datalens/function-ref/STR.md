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
- `expression` — `Массив дробных чисел | Массив целых числел | Массив строк | Логический | Дата | Дата и время | Дробное число | Геоточка | Геополигон | Целое число | Строка | UUID`


**Возвращаемый тип**: `Строка`

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


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
