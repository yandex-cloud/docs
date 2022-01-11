---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/ZN.md
---


# ZN



#### Синтаксис {#syntax}


```
ZN( expression )
```

#### Описание {#description}
Возвращает значение выражения `expression`, если оно не `NULL`. В противном случае возвращает 0.

**Типы аргументов:**
- `expression` — `Дробное число | Целое число`


**Возвращаемый тип**: Совпадает с типом аргументов (`expression`)

#### Примеры {#examples}

```
ZN(1) = 1
```

```
ZN(NULL) = 0
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
