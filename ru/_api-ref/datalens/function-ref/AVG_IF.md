---
editable: false
---

# AVG_IF

_Функция `AVG_IF` также доступна как [оконная](AVG_IF_WINDOW.md)._

#### Синтаксис {#syntax}


```
AVG_IF( expression, condition )
```

#### Описание {#description}
Возвращает среднее для всех значений, которые удовлетворяют условию `condition`. Если значения отсутствуют, то возвращается `NULL`. Работает только с числовыми типами данных.

**Типы аргументов:**
- `expression` — `Число`
- `condition` — `Логический`


**Возвращаемый тип**: `Дробное число`

#### Примеры {#examples}

```
AVG([Profit], [Profit] > 5)
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
