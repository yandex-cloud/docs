---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/MIN_WINDOW.md
---


# MIN (оконная)

_Функция `MIN` также доступна в следующих категориях: [Агрегатные функции](MIN.md)._

#### Синтаксис {#syntax}


```
MIN( value [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )
```

#### Описание {#description}
Возвращает минимальное значение.

Если `value`:
- число — возвращает наименьшее число;
- дата — возвращает самую раннюю дату;
- строка — возвращает первое значение в алфавитном порядке.


**Типы аргументов:**
- `value` — `Логический | Дата | Дата и время | Дробное число | Целое число | Строка | UUID`


**Возвращаемый тип**: Совпадает с типом аргументов (`value`)

#### Примеры {#examples}

```
MIN([Profit] TOTAL)
```

```
MIN([Profit] WITHIN [Date])
```

```
MIN([Profit] AMONG [Date])
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
