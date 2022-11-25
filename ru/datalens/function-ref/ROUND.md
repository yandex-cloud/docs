---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/ROUND.md
---

# ROUND



#### Синтаксис {#syntax}


```
ROUND( number [ , precision ] )
```

#### Описание {#description}
Округляет число `number` до указанного числа знаков `precision` после запятой.
Если число `precision` не указано, то `number` округляется до ближайшего целого.

**Типы аргументов:**
- `number` — `Дробное число | Целое число`
- `precision` — `Целое число`


**Возвращаемый тип**: Зависит от типов аргументов

#### Примеры {#examples}

```
ROUND(3.14159) = 3
```

```
ROUND(3.14159, 3) = 3.142
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
