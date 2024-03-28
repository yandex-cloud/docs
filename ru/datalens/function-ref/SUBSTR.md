---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/SUBSTR.md
---

# SUBSTR



#### Синтаксис {#syntax}


```
SUBSTR( string, from_index [ , length ] )
```

#### Описание {#description}
Возвращает подстроку `string`, начиная с индекса `from_index`. Нумерация начинается с единицы.

Если указан дополнительный аргумент `length`, то будет возвращена подстрока указанной длины.

**Типы аргументов:**
- `string` — `Строка`
- `from_index` — `Целое число`
- `length` — `Целое число`


**Возвращаемый тип**: `Строка`

#### Примеры {#examples}

```
SUBSTR("Computer", 3) = "mputer"
```

```
SUBSTR("Computer", 3, 2) = "mp"
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
