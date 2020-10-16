---
editable: false
---

# MIN

_Агрегатные функции_

#### Синтаксис {#syntax}


```
MIN( value )
```

#### Описание {#description}
Возвращает минимальное значение.

Если `value`:
- число — возвращает наименьшее число;
- дата — возвращает самую раннюю дату;
- строка — возвращает первое значение в алфавитном порядке.


**Типы аргументов:**
- `value` — `Логический | Дата | Дата и время | Число | Строка | UUID`


**Возвращаемый тип**: Совпадает с типом аргументов (`value`)

#### Примеры {#examples}

```
MIN([Profit])
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.

### Как оконная функция {#as-window-function}

Функция `MIN` также доступна в качестве оконной.
#### Синтаксис {#window-syntax}


```
MIN( value [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )
```

#### Примеры {#window-examples}

```
MIN([Profit] TOTAL)
```

```
MIN([Profit] WITHIN [Date])
```

```
MIN([Profit] AMONG [Date])
```
