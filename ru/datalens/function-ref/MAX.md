---
editable: false
---

# MAX

_Агрегатные функции_

#### Синтаксис {#syntax}


```
MAX( value )
```

#### Описание {#description}
Возвращает максимальное значение.

Если `value`:
- число — возвращает наибольшее число;
- дата — возвращает самую позднюю дату;
- строка — возвращает последнее значение в алфавитном порядке.


**Типы аргументов:**
- `value` — `Логический | Дата | Дата и время | Число | Строка | UUID`


**Возвращаемый тип**: Совпадает с типом аргументов (`value`)

#### Примеры {#examples}

```
MAX([Profit])
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.

### Как оконная функция {#as-window-function}

Функция `MAX` также доступна в качестве оконной.
#### Синтаксис {#window-syntax}


```
MAX( value [ TOTAL | WITHIN [ dim1, ... ] | AMONG [ dim1, ... ] ] )
```

#### Примеры {#window-examples}

```
MAX([Profit] TOTAL)
```

```
MAX([Profit] WITHIN [Date])
```

```
MAX([Profit] AMONG [Date])
```
