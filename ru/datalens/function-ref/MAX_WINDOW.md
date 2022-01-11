---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/MAX_WINDOW.md
---


# MAX (оконная)

_Функция `MAX` также доступна как [агрегатная](MAX.md)._

#### Синтаксис {#syntax}


```
MAX( value [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )
```

#### Описание {#description}
Возвращает максимальное значение.

Если `value`:
- число — возвращает наибольшее число;
- дата — возвращает самую позднюю дату;
- строка — возвращает последнее значение в алфавитном порядке.


**Типы аргументов:**
- `value` — `Логический | Дата | Дата и время | Дробное число | Целое число | Строка | UUID`


**Возвращаемый тип**: Совпадает с типом аргументов (`value`)

#### Примеры {#examples}

```
MAX([Profit] TOTAL)
```

```
MAX([Profit] WITHIN [Date])
```

```
MAX([Profit] AMONG [Date])
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
