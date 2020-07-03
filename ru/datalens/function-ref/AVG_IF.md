---
editable: false
---

# AVG_IF

_Агрегатные функции_

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

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.

### Как оконная функция {#as-window-function}

Функция `AVG_IF` также доступна в качестве оконной.
#### Синтаксис {#window-syntax}


```
AVG_IF( expression, condition [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )
```

#### Примеры {#window-examples}

```
AVG_IF([Profit], [Category] = 'Office Supplies' TOTAL)
```

```
AVG_IF([Profit], [Category] = 'Office Supplies' WITHIN [Date])
```

```
AVG_IF([Profit], [Category] = 'Office Supplies' AMONG [Date])
```
