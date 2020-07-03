---
editable: false
---

# SUM

_Агрегатные функции_

#### Синтаксис {#syntax}


```
SUM( value )
```

#### Описание {#description}
Возвращает сумму всех значений выражения. Работает только с числовыми типами данных.

**Типы аргументов:**
- `value` — `Число`


**Возвращаемый тип**: Совпадает с типом аргументов (`value`)

#### Примеры {#examples}

```
SUM([Profit])
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.

### Как оконная функция {#as-window-function}

Функция `SUM` также доступна в качестве оконной.
#### Синтаксис {#window-syntax}


```
SUM( value [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )
```

#### Примеры {#window-examples}

```
SUM([Profit] TOTAL)
```

```
SUM([Profit] WITHIN [Date])
```

```
SUM([Profit] AMONG [Date])
```
