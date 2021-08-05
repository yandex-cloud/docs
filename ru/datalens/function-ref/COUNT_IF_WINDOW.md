---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# COUNT_IF (оконная)

_Функция `COUNT_IF` также доступна как [агрегатная](COUNT_IF.md)._

#### Синтаксис {#syntax}


```
COUNT_IF( expression, condition [ TOTAL | WITHIN ... | AMONG ... ] [ BEFORE FILTER BY ... ] )
```

#### Описание {#description}
Возвращает количество элементов в заданном окне, которые удовлетворяют условию `expression`.

**Типы аргументов:**
- `expression` — `Дробное число | Целое число`
- `condition` — `Логический`


**Возвращаемый тип**: Совпадает с типом аргументов (`expression`)

#### Примеры {#examples}

```
COUNT_IF([Profit], [Category] = 'Office Supplies' TOTAL)
```

```
COUNT_IF([Profit], [Category] = 'Office Supplies' WITHIN [Date])
```

```
COUNT_IF([Profit], [Category] = 'Office Supplies' AMONG [Date])
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
