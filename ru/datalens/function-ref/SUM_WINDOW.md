---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# SUM (оконная)

_Функция `SUM` также доступна как [агрегатная](SUM.md)._

#### Синтаксис {#syntax}


```
SUM( value [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )
```

#### Описание {#description}
Возвращает сумму всех значений выражения. Работает только с числовыми типами данных.

**Типы аргументов:**
- `value` — `Дробное число | Целое число`


**Возвращаемый тип**: Совпадает с типом аргументов (`value`)

#### Примеры {#examples}

```
SUM([Profit] TOTAL)
```

```
SUM([Profit] WITHIN [Date])
```

```
SUM([Profit] AMONG [Date])
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
