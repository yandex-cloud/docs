---
editable: false
---

# AVG

_Агрегатные функции_

#### Синтаксис {#syntax}


```
AVG( value )
```

#### Описание {#description}
Возвращает среднее для всех значений. Работает с числовыми типами данных и с типами `Дата | Дата и время`.

**Типы аргументов:**
- `value` — `Дата | Дата и время | Число`


**Возвращаемый тип**: Зависит от типов аргументов

#### Примеры {#examples}

```
AVG([Profit])
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.

### Как оконная функция {#as-window-function}

Функция `AVG` также доступна в качестве оконной.
#### Синтаксис {#window-syntax}


```
AVG( value [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )
```

#### Примеры {#window-examples}

```
AVG([Profit] TOTAL)
```

```
AVG([Profit] WITHIN [Date])
```

```
AVG([Profit] AMONG [Date])
```
