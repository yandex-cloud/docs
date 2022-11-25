---
editable: false
---

# SUBSTR



#### Синтаксис {#syntax}


```
SUBSTR( string, from_index [ , length ] )
```

#### Описание {#description}
Возвращает подстроку `string`, начиная с индекса `from_index`.

Если указан дополнительный аргумент `length`, то будет возвращена подстрока указанной длины.

**Типы аргументов:**
- `string` — `Строка`
- `from_index` — `Целое число`
- `length` — `Целое число`


**Возвращаемый тип**: `Строка`

#### Пример {#examples}

```
SUBSTR("Computer", 3) = "mputer"
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
