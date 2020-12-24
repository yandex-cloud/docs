---
editable: false
---

# ZN



#### Синтаксис {#syntax}


```
ZN( expression )
```

#### Описание {#description}
Возвращает значение выражения `expression`, если оно не `NULL`. В противном случае возвращает 0.

**Типы аргументов:**
- `expression` — `Число`


**Возвращаемый тип**: Совпадает с типом аргументов (`expression`)

#### Примеры {#examples}

```
ZN(1) = 1
```

```
ZN(NULL) = 0
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
