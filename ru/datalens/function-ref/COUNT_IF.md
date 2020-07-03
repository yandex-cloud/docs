---
editable: false
---

# COUNT_IF

_Агрегатные функции_

#### Синтаксис {#syntax}


```
COUNT_IF( condition )
```

#### Описание {#description}
Возвращает количество элементов в группе, которые удовлетворяют условию `condition`.

**Типы аргументов:**
- `condition` — `Логический`


**Возвращаемый тип**: `Целое число`

#### Примеры {#examples}

```
COUNT_IF([Profit] > 5)
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.

### Как оконная функция {#as-window-function}

Функция `COUNT_IF` также доступна в качестве оконной.
#### Синтаксис {#window-syntax}


```
COUNT_IF( expression, condition [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )
```

#### Примеры {#window-examples}

```
COUNT_IF([Profit], [Category] = 'Office Supplies' TOTAL)
```

```
COUNT_IF([Profit], [Category] = 'Office Supplies' WITHIN [Date])
```

```
COUNT_IF([Profit], [Category] = 'Office Supplies' AMONG [Date])
```
