---
editable: false
---

# COUNT

_Агрегатные функции_

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

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.

### Как оконная функция {#as-window-function}

Функция `COUNT` также доступна в качестве оконной.
#### Синтаксис {#window-syntax}


```
COUNT(  [ value ] [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )
```

#### Примеры {#window-examples}

```
COUNT([Profit] TOTAL)
```

```
COUNT(TOTAL)
```

```
COUNT([Profit] WITHIN [Date])
```

```
COUNT(AMONG [Date])
```
