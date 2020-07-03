---
editable: false
---

# SUM_IF

_Агрегатные функции_

#### Синтаксис {#syntax}


```
SUM_IF( expression, condition )
```

#### Описание {#description}
Возвращает сумму всех значений выражения, которые удовлетворяют условию `condition`. Работает только с числовыми типами данных.

**Типы аргументов:**
- `expression` — `Число`
- `condition` — `Логический`


**Возвращаемый тип**: Совпадает с типом аргументов (`expression`)

#### Примеры {#examples}

```
SUM_IF([Profit], [Profit] > 15)
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.

### Как оконная функция {#as-window-function}

Функция `SUM_IF` также доступна в качестве оконной.
#### Синтаксис {#window-syntax}


```
SUM_IF( expression, condition [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )
```

#### Примеры {#window-examples}

```
SUM_IF([Profit], [Category] = 'Office Supplies' TOTAL)
```

```
SUM_IF([Profit], [Category] = 'Office Supplies' WITHIN [Date])
```

```
SUM_IF([Profit], [Category] = 'Office Supplies' AMONG [Date])
```
