---
editable: false
---

# SUM_IF

_Функция `SUM_IF` также доступна как [оконная](SUM_IF_WINDOW.md)._

#### Синтаксис {#syntax}


```
SUM_IF( expression, condition )
```

#### Описание {#description}
Возвращает сумму всех значений выражения, которые удовлетворяют условию `condition`. Работает только с числовыми типами данных.

**Типы аргументов:**
- `expression` — `Дробное число | Целое число`
- `condition` — `Логический`


**Возвращаемый тип**: Совпадает с типом аргументов (`expression`)

#### Примеры {#examples}

```
SUM_IF([Profit], [Profit] > 15)
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
