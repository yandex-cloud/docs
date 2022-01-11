---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/COUNT.md
---


# COUNT

_Функция `COUNT` также доступна как [оконная](COUNT_WINDOW.md)._

#### Синтаксис {#syntax}


```
COUNT(  [ value ] )
```

#### Описание {#description}
Возвращает количество элементов в группе.

**Типы аргументов:**
- `value` — `Любой`


**Возвращаемый тип**: `Целое число`

#### Примеры {#examples}

```
COUNT()
```

```
COUNT([OrderID])
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
